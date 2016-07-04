//
//  ProductsListViewController.m
//  OnGO
//
//  Created by krish on 18/05/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "ProductsListViewController.h"
#import "DataServices.h"
#import "JSONKit.h"
#import "OnGoDownloadManager.h"
#import "CXResourceManager.h"
#import "OnGoDownloadData.h"
#import "ProductTabViewController.h"

#define ITEMS_PER_SECTION 2

#define ITEM_DEFAULT_WIDTH 150
#define ITEM_DEFAULT_HEIGHT 214



@interface ProductsListViewController ()
@property(strong,nonatomic) NSMutableDictionary* sizesDict;
@property(strong,nonatomic)ProductTabViewController* productTabViewController;
@property(assign,nonatomic) NSInteger selectedProductIndex;
@end

@implementation ProductsListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCartUpdated:) name:@"CartDidUpdateNotification" object:nil];
    self.selectedProductIndex = -1;
    [self reloadProductList];
}




-(void)reloadProductList
{
    [[DataServices serviceInstance] getAllProductsOfType:self.productName mallId:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"MALL_ID"] block:^(NSArray* allProductList){
        
        self.productsList = allProductList;
        self.sizesDict = [NSMutableDictionary new];
        for(int index = 0; index < allProductList.count; ++index)
        {
            CGSize size;
            size.height = ITEM_DEFAULT_HEIGHT;
            size.width = ITEM_DEFAULT_WIDTH;
            NSValue* value = [NSValue valueWithCGSize:size];
            
            [self.sizesDict setObject:value forKey:[NSString stringWithFormat:@"%d", index]];
        }
        [self.collectionView reloadData];
        
        if(self.selectedProductIndex != -1)
        {
            OnGoProducts* product = self.productsList[self.selectedProductIndex];
            self.productTabViewController.productInfo  = product;
        }

    }];

}


-(void)handleCartUpdated:(NSNotification*)notification
{
    [self reloadProductList];
}


-(void)viewWillAppear:(BOOL)animated
{
    [self reloadProductList];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.productsList.count;
    
//    if((section+1) == [self numberOfSectionsInCollectionView:collectionView])
//    {
//        if(self.productsList.count%ITEMS_PER_SECTION)
//            return 1;
//        else
//            return ITEMS_PER_SECTION;
//
//    }
//    return ITEMS_PER_SECTION;

}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
   static NSString *CellIdentifier = @"ProductCell";

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.layer.borderWidth = 1.0f;
    cell.layer.borderColor = [UIColor colorWithRed:225/255.0f green:225/255.0f blue:225/255.0f alpha:1.0f].CGColor;
    
    UILabel* nameLabel = (UILabel*)[cell viewWithTag:1];
    
    int productIndex = indexPath.item;
    if(productIndex < self.productsList.count)
    {
        OnGoProducts* product = self.productsList[productIndex];
        nameLabel.text = product.Name;
        NSDictionary* dict = [product.json objectFromJSONString];
        
        UILabel* priceLabel = (UILabel*)[cell viewWithTag:3];
        UILabel* currencySmbl = (UILabel*)[cell viewWithTag:10];

        NSString* mrpValue = [dict objectForKey:@"MRP"];
        UIButton* addtoCartButton = (UIButton*)[cell viewWithTag:100];

        if(mrpValue && [mrpValue length] > 0)
        {
            priceLabel.hidden = NO;
            addtoCartButton.hidden = NO;
            currencySmbl.hidden = NO;
            priceLabel.text = mrpValue;
        }
        else
        {
            priceLabel.hidden = YES;
            //addtoCartButton.hidden = YES;
            currencySmbl.hidden = YES;
        }
        
        if(([product.addToCart length] > 0) && [product.addToCart isEqualToString:@"1"])
        {
            [addtoCartButton setTitle:@"Added" forState:UIControlStateNormal];
           // addtoCartButton.enabled = NO;
        }
        else
        {
            [addtoCartButton setTitle:@"Add to cart" forState:UIControlStateNormal];
            //addtoCartButton.enabled = YES;
        }

        NSString* imageUrl = [dict objectForKey:@"Image_URL"];
        if(imageUrl)
        {
            UIActivityIndicatorView* activityView = (UIActivityIndicatorView*)[cell viewWithTag:5];
            activityView.hidden = NO;

            UIImage *image = [[CXResourceManager sharedInstance] imageForPath:imageUrl];
            UIImageView* imageView = (UIImageView*)[cell viewWithTag:4];

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
                                                                                          
                                                                                          CGSize size = [image size];
                                                                                          
                                                                                          CGFloat deltaWidth = size.width - imageView.frame.size.width;
                                                                                          
                                                                                          CGFloat deltaHeight = size.height - imageView.frame.size.height;
                                                                                          
                                                                                          NSValue* value = [self.sizesDict objectForKey:[NSString stringWithFormat:@"%d", indexPath.item]];
                                                                                          
                                                                                          CGSize defaultSize =  [value CGSizeValue];
                                                                                          
                                                                                          CGSize newSize;
                                                                                          newSize.height = defaultSize.height + deltaHeight;
                                                                                          newSize.width = defaultSize.width ;



                                                                                          [self.sizesDict setObject:[NSValue valueWithCGSize:newSize] forKey:[NSString stringWithFormat:@"%d", indexPath.item]];
                                                                                          
                                                                                          [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];


                                                                                      }
                                                                                  }
                                                                                  
                                                                              }];
            }
            else
            {
                [imageView setImage:image];
                activityView.hidden = YES;
            }
        }
    }

    return cell;
}





//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    if(self.productsList.count%ITEMS_PER_SECTION)
//    {
//        return ((self.productsList.count/ITEMS_PER_SECTION)+1);
//    }
//    else
//    {
//        return (self.productsList.count/ITEMS_PER_SECTION);
//    }
//}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    int productIndex = indexPath.item;
    OnGoProducts* product = self.productsList[productIndex];

    self.productTabViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductTabViewController"];
    self.productTabViewController.productInfo  = product;
    self.selectedProductIndex = productIndex;
    [self.navigationController pushViewController:self.productTabViewController animated:YES];
}


- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [self collectionView:collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    [cell setNeedsDisplay];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    //UICollectionViewCell* cell = [self collectionView:collectionView cellForItemAtIndexPath:indexPath];
    //cell.contentView.backgroundColor = nil;
}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ITEM_DEFAULT_WIDTH, ITEM_DEFAULT_HEIGHT);
    
    NSValue* value = [self.sizesDict objectForKey:[NSString stringWithFormat:@"%d", indexPath.item]];
    
    return [value CGSizeValue];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}


-(void)backButtonTapped
{
    [(CCKFNavDrawer*)self.navigationController drawerToggle];
    [self.navigationController popViewControllerAnimated:YES];
}


-(NSString*)leftNavigationBarItemTitle
{
    return self.productName;
}
    
//-(UIImage*)leftNavigationBarItemImage
//{
//    return [UIImage imageNamed:@"ic_actionbar_leftslide"];
//}
//    
//-(SEL)leftNavigationBarItemAction
//{
//    SEL selector =  @selector(leftBarTapped);
//    return selector;
//}
    
//-(UIBarButtonItem*)leftNavigationBarItem
//{
//    SEL selector =  @selector(leftBarTapped);
//
//    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 43)];
//    //customView.backgroundColor = [UIColor redColor];
//    
//    UIButton* menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 13, 24, 24)];
//    [menuButton setImage:[UIImage imageNamed:@"ic_actionbar_leftslide"] forState:UIControlStateNormal];
//    [menuButton addTarget:self
//                   action:selector forControlEvents:UIControlEventTouchDown];
//    [customView addSubview:menuButton];
//    
//    UIImageView* iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 4, 35, 35)];
//    iconImageView.image = [UIImage imageNamed:@"icon"];
//    [customView addSubview:iconImageView];
//    
//    
//    UILabel* titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(67, 15, 200, 20)];
//    titleLabel.text = self.productName;
//    [customView addSubview:titleLabel];
//    
//    
//    return [[UIBarButtonItem alloc]initWithCustomView:customView];
//
//}


- (IBAction)addOrRemoveCart:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    
    UITouch *touch = [touches anyObject];
    
    CGPoint currentTouchPosition = [touch locationInView:self.collectionView];
    
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:currentTouchPosition];
    
    OnGoProducts* product = self.productsList[indexPath.item];

    if([product.addToCart isEqualToString:@"1"])
    {
        [[OnGoDB dbInstance] addToCart:NO forProduct:product];
        [self.navController updateTheCartInformation];

    }
    else
    {
        [[OnGoDB dbInstance] addToCart:YES forProduct:product];
        [self.navController updateTheCartInformation];

    }
    [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
