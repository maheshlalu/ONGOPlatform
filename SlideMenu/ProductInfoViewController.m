//
//  ProductInfoViewController.m
//  OnGO
//
//  Created by krish on 20/05/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "ProductInfoViewController.h"
#import "JSONKit.h"
#import "OnGoDownloadManager.h"
#import "CXResourceManager.h"
#import "OnGoDownloadData.h"
#import "DataServices.h"
#import "WriteReviewViewController.h"

@interface ProductInfoViewController ()
@property(strong,nonatomic) NSMutableArray* excludedKeys;
@property(strong,nonatomic) NSMutableArray* shownProperties;
@property(assign) NSInteger selectedSection;

@end

@implementation ProductInfoViewController
@synthesize tabItemName = mTabItemName;
@synthesize tabBGColor = mTabBGColor;

-(void)setProductInfo:(OnGoProducts*)prduct
{
    _productInfo = prduct;
    _productName.text = _productInfo.Name;
    NSDictionary* dict = [_productInfo.json objectFromJSONString];
    _productPrice.text = [dict objectForKey:@"MRP"];
    
    if([self.productInfo.type isEqualToString:@"Deals"])
    {
        [self.shownProperties addObject:@"Discount Value"];
        [self.shownProperties addObject:@"Discount Type"];
    }
    else
    {
        NSArray* allkeys = [dict allKeys];
        
        NSMutableSet* set = [NSMutableSet setWithArray:allkeys];
        
        NSArray* excludedKeys = @[@"ItemCode", @"id", @"Name", @"createdById", @"jobTypeId", @"createdByFullName", @"publicURL", @"ExpiredOn", @"Quantity", @"In_Stock", @"hrsOfOperation", @"createdOn",
                                  @"Image_Name", @"Image_URL", @"Latitude", @"Longitude", @"Attachments", @"Additional_Details", @"jobComments", @"Current_Job_Status,Category_Mall", @"MRP", @"Insights",
                                  @"Current_Job_StatusId", @"Next_Seq_Nos", @"CreatedSubJobs", @"Next_Job_Statuses", @"offersCount", @"productsCount", @"businessType", @"storeId", @"CategoryType", @"SubCategoryType", @"P3rdCategory", @"Category_Mall", @"PackageName",@"Current_Job_Status", @"jobTypeName",@"Units", @"guestUserId", @"guestUserEmail", @"Image"];
        
        NSSet* set1 = [NSSet setWithArray:excludedKeys];
        
        [set minusSet:set1];
        
        self.shownProperties = [set allObjects];
    }
    
    NSMutableArray* excludedKeys = [NSMutableArray array];
    for(int index = 0; index < self.shownProperties.count; ++index)
    {
        NSString* value = [dict objectForKey:[self.shownProperties objectAtIndex:index]];
        if(!value || ![value isKindOfClass:[NSString class]])
        {
            [excludedKeys addObject:[self.shownProperties objectAtIndex:index]];
        }
        if([value isKindOfClass:[NSString class]])
        {
            value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if(value.length <= 0)
            {
                [excludedKeys addObject:[self.shownProperties objectAtIndex:index]];
            }
        }

    }
    
    NSSet* set1 = [NSSet setWithArray:excludedKeys];
    NSMutableSet* set = [NSMutableSet setWithArray:self.shownProperties];
    [set minusSet:set1];
    
    self.shownProperties = [set allObjects];

    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    
    [self.tableView reloadData];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)refresh
{
    [self.tableView reloadData];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.shownProperties = [NSMutableArray new];
    
    
    
    self.selectedSection = 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.shownProperties.count ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell* cell = nil;
    
    if(indexPath.section == 0)
    {
        static NSString *imageCellIdentifier = @"ImageCell";
        cell = [tableView dequeueReusableCellWithIdentifier:imageCellIdentifier];
        NSDictionary* dict = [_productInfo.json objectFromJSONString];

        NSString* imageUrl = [dict objectForKey:@"Image_URL"];
        UIActivityIndicatorView* activityView = (UIActivityIndicatorView*)[cell viewWithTag:2];
        UIImageView* productImageView = (UIImageView*)[cell viewWithTag:1];

        if(imageUrl)
        {
            UIImage *image = [[CXResourceManager sharedInstance] imageForPath:imageUrl];

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
                                                                                          [productImageView setImage:image];
                                                                                          
                                                                                          [[CXResourceManager sharedInstance] setImage:image forPath:imageUrl];
                                                                                      }
                                                                                  }
                                                                                  
                                                                              }];
            }
            else
            {
                activityView.hidden = YES;
                [productImageView setImage:image];
            }
        }
        else
        {
            activityView.hidden = YES;
            [productImageView setImage:[UIImage imageNamed:@"shadow_home"]];
        }
    }
    else if(indexPath.section == 1)
    {
        static NSString *headercellIdentifier = @"Headercell";
        cell = [tableView dequeueReusableCellWithIdentifier:headercellIdentifier];
        
        UILabel* label = (UILabel*)[cell viewWithTag:1];
        label.text = self.productInfo.Name;
        
        if([self.productInfo.type isEqualToString:@"Deals"])
        {
            UIButton* addtoCartButton = (UIButton*)[cell viewWithTag:6];//hide Add to cart button
            addtoCartButton.hidden = YES;
            
            UILabel* label = (UILabel*)[cell viewWithTag:1001];
            label.hidden = YES;
            label = (UILabel*)[cell viewWithTag:1002];
            label.hidden = YES;
            label = (UILabel*)[cell viewWithTag:1003];
            label.hidden = YES;
        }
        else
        {
            UILabel* priceLabel = (UILabel*)[cell viewWithTag:1002];
            UILabel* currencySmbl = (UILabel*)[cell viewWithTag:1001];


            NSDictionary* dict = [_productInfo.json objectFromJSONString];
            NSString* mrpValue = [dict objectForKey:@"MRP"];
            UIButton* addtoCartButton = (UIButton*)[cell viewWithTag:6];
            
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

            if(([_productInfo.addToCart length] > 0) && [_productInfo.addToCart isEqualToString:@"1"])
            {
                [addtoCartButton setTitle:@"Added" forState:UIControlStateNormal];
                //addtoCartButton.enabled = NO;
            }
            else
            {
                [addtoCartButton setTitle:@"Add to cart" forState:UIControlStateNormal];
                //addtoCartButton.enabled = YES;
            }
        }
        
        UIButton* favButton = (UIButton*)[cell viewWithTag:4];
        
        if(([_productInfo.favourite length] > 0) && [_productInfo.favourite isEqualToString:@"1"])
        {
            [favButton setImage:[UIImage imageNamed:@"favorite"] forState:UIControlStateNormal];
            
        }
        else
        {
            [favButton setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
        }

    }
    else
    {
        
      /*  NSString *cellIdentfier = @"Store_Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentfier];
        //if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentfier];
        cell.backgroundColor = [UIColor clearColor];
        // }
        return cell;*/
        
        static NSString *cellIdentifier = @"ProductInfoCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        
        NSDictionary* dict = [_productInfo.json objectFromJSONString];
        
        UIWebView *webView = (UIWebView*)[cell viewWithTag:101];

        [webView loadHTMLString:[NSString stringWithFormat:@"<font face='AlegreyaSans-Regular'>%@", dict[@"Description"]] baseURL:nil];
        
      /*  UILabel* keyLabel = (UILabel*)[cell viewWithTag:1];
        keyLabel.text = [[self.shownProperties objectAtIndex:indexPath.section-2] uppercaseString];
        
        UILabel* valueLabel = (UILabel*)[cell viewWithTag:2];

        if(self.selectedSection == indexPath.section)
        {
            NSString* value = [dict objectForKey:[self.shownProperties objectAtIndex:indexPath.section-2]];
            
            if([value isKindOfClass:[NSString class]])
            {
                valueLabel.text = value;
            }
        }
        else
        {
            valueLabel.text = @"";
        }
        
     */
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return 227;
    }
    else if(indexPath.section == 1)
    {
        return 50;
    }
    else if(indexPath.section == self.selectedSection)
    {
        return 85;
    }
    else
    {
        return 300;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2)
    {
        self.selectedSection = indexPath.section;
        [tableView reloadData];
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2)
        return YES;
    else
        return NO;

}

- (IBAction)addOrRemoveCart:(id)sender event:(id)event 
{
    NSSet *touches = [event allTouches];
    
    UITouch *touch = [touches anyObject];
    
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
    
    
    if([self.productInfo.addToCart isEqualToString:@"1"])
    {
        [[OnGoDB dbInstance] addToCart:NO forProduct:self.productInfo];
        [self.navController updateTheCartInformation];

    }
    else
    {
        [[OnGoDB dbInstance] addToCart:YES forProduct:self.productInfo];
        [self.navController updateTheCartInformation];

    }
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];

}

-(IBAction)addReview:(id)sender
{
    WriteReviewViewController* writeReviewViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WriteReviewViewController"];
    writeReviewViewController.productName = self.productInfo.Name;
    writeReviewViewController.jobTypeId = self.productInfo.id;

    [self.navController pushViewController:writeReviewViewController animated:YES];

}


- (IBAction)myClickEvent:(id)sender event:(id)event {
    
    NSSet *touches = [event allTouches];
    
    UITouch *touch = [touches anyObject];
    
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
    
    
    if([self.productInfo.favourite isEqualToString:@"1"])
    {
        [[OnGoDB dbInstance] makeFavorite:NO forProduct:self.productInfo];
        
    }
    else
    {
        [[OnGoDB dbInstance] makeFavorite:YES forProduct:self.productInfo];
    }
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
}

@end
