

#import "CartViewController.h"
#import "CCKFNavDrawer.h"
#import "OnGoDB.h"
#import "JSONKit.h"
#import "CXResourceManager.h"
#import "OnGoDownloadManager.h"
#import "OrderConfirmationViewController.h"
#import "CXLoginManager.h"
#import "DataServices.h"
#import "CXLoadingViewController.h"

@interface CartViewController()
@property(nonatomic,strong) NSArray* cartItems;
@property(nonatomic,assign) BOOL shippingAddressEntered;
@property(nonatomic,strong) CXLoadingViewController *loadingViewController;
@end

static NSMutableDictionary* cartList = nil;

@implementation CartViewController

-(void)backButtonTapped
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(BOOL)shouldShowCart
{
    return NO;
}


-(NSString*)leftNavigationBarItemTitle
{
    return @"Your cart";
}


-(void)reloadCartData
{
    [[OnGoDB dbInstance] getAllCartItems:@"" mallId:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"MALL_ID"] block:^(NSArray* cartItems){
        self.cartItems = cartItems;
        
        if(self.cartItems.count == 0)
        {
            self.noCartItemsView.hidden = NO;
            self.collectionView.hidden = YES;
        }
        else
        {
            for(int index = 0; index < self.cartItems.count; ++index)
            {
                OnGoProducts* product = self.cartItems[index];
                
                if(![cartList objectForKey:product.id])
                {
                    [cartList setObject:[NSNumber numberWithInt:1] forKey:product.id];
                }
            }
            self.noCartItemsView.hidden = YES;
            self.collectionView.hidden = NO;
            [self.collectionView reloadData];
        }
        [self updateTotalOrder];

    }];

}

- (void)viewDidLoad
{
    
    if(!cartList)
    {
        cartList = [NSMutableDictionary new];
    }
    
    [self.totalLabel.layer setBorderWidth:1.0f];
    
    self.totalLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [self reloadCartData];
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CartIdentifier";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    int productIndex = indexPath.item;

    OnGoProducts* product = self.cartItems[productIndex];
    NSDictionary* dict = [product.json objectFromJSONString];

    NSString* imageUrl = [dict objectForKey:@"Image_URL"];
    if(imageUrl)
    {
        UIActivityIndicatorView* activityView = (UIActivityIndicatorView*)[cell viewWithTag:7];
        activityView.hidden = NO;
        
        UIImage *image = [[CXResourceManager sharedInstance] imageForPath:imageUrl];
        UIImageView* imageView = (UIImageView*)[cell viewWithTag:1];
        
        if(!image)
        {
            [activityView startAnimating];
            [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:imageUrl
                                                                          dataType:DATA_TYPE_BINARY finishBlock:^(OnGoDownloadData *downloadData){
                                                                              if (downloadData.downloadStatus == DOWNLOAD_STATUS_SUCCESS)
                                                                              {
                                                                                  UIImage *image = [UIImage imageWithData:downloadData.data];
                                                                                  if(image)
                                                                                  {
                                                                                      [activityView stopAnimating];
                                                                                      activityView.hidden = YES;
                                                                                      
                                                                                      
                                                                                      imageView.contentMode = UIViewContentModeScaleAspectFit;
                                                                                      [imageView setImage:image];
                                                                                      
                                                                                      [[CXResourceManager sharedInstance] setImage:image forPath:imageUrl];
                                                                                      
                                                                                  }
                                                                              }
                                                                              
                                                                          }];
        }
        else
        {
            [activityView stopAnimating];
            [imageView setImage:image];
            activityView.hidden = YES;
        }
    }

    UILabel* descLabel = (UILabel*)[cell viewWithTag:2];
    descLabel.text = product.Name;
    
    UILabel* priceLabel = (UILabel*)[cell viewWithTag:3];
    priceLabel.text = [dict objectForKey:@"MRP"];
    
    UILabel* quantityLabel = (UILabel*)[cell viewWithTag:4];
    quantityLabel.text = [[cartList objectForKey:product.id] stringValue];

    UILabel* totalLabel = (UILabel*)[cell viewWithTag:5];
    totalLabel.text = @"";


    UIButton* deleteButton = (UIButton*)[cell viewWithTag:6];
    [deleteButton.layer setBorderWidth:1.0f];
    deleteButton.layer.borderColor = [UIColor lightGrayColor].CGColor;

    
    
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.cartItems.count;
    
}

-(void)updateTotalCheckoutAmount
{
    
}

-(IBAction)addItem:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    
    UITouch *touch = [touches anyObject];
    
    CGPoint currentTouchPosition = [touch locationInView:self.collectionView];
    
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint: currentTouchPosition];
    int productIndex = indexPath.item;
    
    OnGoProducts* product = self.cartItems[productIndex];
    NSDictionary* dict = [product.json objectFromJSONString];

    int quantity = [[dict objectForKey:@"Quantity"] intValue];
    if(quantity > [[cartList objectForKey:product.id] intValue])
    {
        [cartList setObject:[NSNumber numberWithInt:[[cartList objectForKey:product.id] intValue]+1] forKey:product.id];
    }

    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    
    [self updateTotalOrder];

}

-(IBAction)deleteItem:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    
    UITouch *touch = [touches anyObject];
    
    CGPoint currentTouchPosition = [touch locationInView:self.collectionView];
    
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint: currentTouchPosition];
    int productIndex = indexPath.item;

    OnGoProducts* product = self.cartItems[productIndex];

    [cartList removeObjectForKey:product.id];
    
    [[OnGoDB dbInstance] addToCart:NO forProduct:product];

    
    [self reloadCartData];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CartDidUpdateNotification" object:nil];
    
    [self updateTotalOrder];


}


-(IBAction)keepShoppingTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)updateTotalOrder
{
    double total = 0;
    
    for(int index = 0; index < self.cartItems.count;++index)
    {
        OnGoProducts* product = self.cartItems[index];
        NSDictionary* dict = [product.json objectFromJSONString];
        
        double orderItemValue = [[cartList objectForKey:product.id] intValue]* [[dict objectForKey:@"MRP"] floatValue];
        
        total += orderItemValue;
    }
    
    self.totalLabel.text = [NSString stringWithFormat:@"= ₹ %.2lf",total];
}

-(void)processOrder
{
    NSMutableDictionary* order = [NSMutableDictionary new];
    
    NSMutableString* orderItemId = [NSMutableString string];
    //NSMutableString* itemCode = [NSMutableString string];
    NSMutableString* orderItemQuantity = [NSMutableString string];
    NSMutableString* orderItemName = [NSMutableString string];
    NSMutableString* orderSubTotal = [NSMutableString string];
    NSMutableString* orderItemMRP = [NSMutableString string];
    
    double total = 0;
    [order setObject:orderItemId forKey:@"OrderItemId"];
    //[order setObject:itemCode forKey:@"ItemCode"];
    [order setObject:orderItemQuantity forKey:@"OrderItemQuantity"];
    [order setObject:orderItemName forKey:@"OrderItemName"];
    [order setObject:orderSubTotal forKey:@"OrderItemSubTotal"];
    [order setObject:orderItemMRP forKey:@"OrderItemMRP"];

    
    NSDictionary* addressDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"shippingAddress"];
    
    NSString* name = [addressDict objectForKey:@"name"];
    if(!name)
    {
        name = @"No Name";
    }
    NSString* emailId = [addressDict objectForKey:@"email"];
    if(!emailId)
    {
        emailId = @"No email";
    }

    NSString* address1 = [addressDict objectForKey:@"address1"];
    if(!address1)
    {
        address1 = @"No address1";
    }

    NSString* address2 = [addressDict objectForKey:@"address2"];
    if(!address2)
    {
        address2 = @"No address2";
    }

    NSString* address = [NSString stringWithFormat:@"%@ %@",address1, address2];
    NSString* phoneNumber = [addressDict objectForKey:@"phoneNumber"];
    if(!phoneNumber)
    {
        phoneNumber = @"No Phone number";
    }

    [order setObject:name forKey:@"Name"]; //should be replaced
    [order setObject:address forKey:@"Address"];//should be replaced
    [order setObject:phoneNumber forKey:@"Contact_Number"];//should be replaced

    
    for(int index = 0; index < self.cartItems.count;++index)
    {
        OnGoProducts* product = self.cartItems[index];
        NSDictionary* dict = [product.json objectFromJSONString];
        
        if(index != 0)
        {
            [orderItemId appendString:@"|"];
            //[itemCode appendString:@";"];
            [orderItemQuantity appendString:@"|"];
            [orderItemName appendString:@"|"];
            [orderSubTotal appendString:@"|"];
            [orderItemMRP appendString:@"|"];
        }
        NSString* orderInfo = [NSString stringWithFormat:@"%@%@", product.id,[[cartList objectForKey:product.id] stringValue]];
        
        [orderItemId appendString:product.id];
        [orderItemId appendString:@"`"];
        [orderItemId appendString:orderInfo];
        
       // [itemCode appendString:product.ItemCode];
        
        [orderItemQuantity appendString:[NSString stringWithFormat:@"%@`%@", [[cartList objectForKey:product.id] stringValue],orderInfo]];
        [orderItemName appendString:[NSString stringWithFormat:@"%@`%@", product.Name,orderInfo]];
        double orderItemValue = [[cartList objectForKey:product.id] intValue]* [[dict objectForKey:@"MRP"] floatValue];
        [orderSubTotal appendString:[NSString stringWithFormat:@"%.2f`%@", orderItemValue,orderInfo]];
        [orderItemMRP appendString:[NSString stringWithFormat:@"%.2f`%@", [[dict objectForKey:@"MRP"] floatValue],orderInfo]];
        
        total += orderItemValue;
    }
    
    [order setObject:[NSString stringWithFormat:@"%lf",total] forKey:@"Total"];
    
    NSArray* ordersArray = [NSArray arrayWithObject:order];
    NSDictionary* dict = [NSDictionary dictionaryWithObject:ordersArray forKey:@"list"];
    
    NSString* jsonString = [dict JSONString];
    
    self.loadingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CXLoadingViewController"];
    [self.view addSubview:self.loadingViewController.view];

    
    [[DataServices serviceInstance] placeOrder:emailId mallId:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"MALL_ID"] orderInfo:jsonString   finishblock:^(NSDictionary* response){
        
        [self.loadingViewController.view removeFromSuperview];
        self.loadingViewController = nil;

        UIAlertView *orderAlert = [[UIAlertView alloc]initWithTitle:@"Order confirmed" message:@"Your order is placed" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [orderAlert show];

        
        for(int index = 0; index < self.cartItems.count; ++index)
        {
            OnGoProducts* product = self.cartItems[index];
            
            [cartList removeObjectForKey:product.id];
            
            [[OnGoDB dbInstance] addToCart:NO forProduct:product];

        }
        
        
        [self reloadCartData];
    }];
    
}


-(IBAction)checkout:(id)sender
{
    OrderConfirmationViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderConfirmationViewController"];
    vc.cartViewController = self;
    [self presentViewController:vc animated:NO completion:nil];
    self.shippingAddressEntered = YES;

//    if(!self.shippingAddressEntered)
//    {
//        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:[[NSBundle mainBundle].infoDictionary objectForKey:@"UIMainStoryboardFile"]
//                                                             bundle:[NSBundle mainBundle]];
//        
//        OrderConfirmationViewController* vc = [storyBoard instantiateViewControllerWithIdentifier:@"OrderConfirmationViewController"];
//        vc.cartViewController = self;
//        [self presentViewController:vc animated:NO completion:nil];
//        self.shippingAddressEntered = YES;
//    }
//    else
//    {
//        [self processOrder];
//        //[self.navigationController popViewControllerAnimated:YES];
//    }
    

}


@end


