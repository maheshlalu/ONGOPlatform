//
//  DealsListViewController.m
//  OnGO
//
//  Created by krish on 22/05/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "DealsListViewController.h"
#import "DataServices.h"
#import "JSONKit.h"
#import "OnGoDownloadManager.h"
#import "CXResourceManager.h"
#import "OnGoDownloadData.h"
#import "CCKFNavDrawer.h"
#import "ProductTabViewController.h"

@interface DealsListViewController ()

@end

@implementation DealsListViewController

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
    

    [[DataServices serviceInstance]getAllOffersOfType:self.offerType mallId:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"MALL_ID"] block:^(NSArray* offersList){
        
        self.dealsList = offersList;
        [self.collectionView reloadData];
    }];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return 1;
//}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"OfferCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
//    cell.layer.borderWidth = 1.0f;
//    cell.layer.borderColor = [UIColor blackColor].CGColor;
    
    OnGoOffers* offers = self.dealsList[indexPath.item];
    UILabel* nameLabel = (UILabel*)[cell viewWithTag:2];
    nameLabel.text = offers.Name;

    //UILabel* descLabel = (UILabel*)[cell viewWithTag:3];
    //descLabel.text = offers.Description;

    NSDictionary* dict = [offers.json objectFromJSONString];
    
    UILabel* validityLabel = (UILabel*)[cell viewWithTag:4];
    validityLabel.text = [dict objectForKey:@"ExpiredOn"];

    
    NSArray* jobComments = [dict objectForKey:@"jobComments"];
    double ratingSum = 0;
    for(NSDictionary* dict in jobComments)
    {
        ratingSum += [[dict objectForKey:@"rating"] doubleValue];
    }
    
    double rating = 0;
    if(jobComments && jobComments.count > 0)
    {
        rating = ratingSum/jobComments.count;
    }
    
    UILabel* ratingLabel = (UILabel*)[cell viewWithTag:5];
    ratingLabel.text = [NSString stringWithFormat:@"%.1lf", rating];
    
    OnGoProducts* product = self.dealsList[indexPath.item];
    UIButton* favButton = (UIButton*)[cell viewWithTag:6];

    if(([product.favourite length] > 0) && [product.favourite isEqualToString:@"1"])
    {
        [favButton setImage:[UIImage imageNamed:@"favorite"] forState:UIControlStateNormal];
        
    }
    else
    {
        [favButton setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
    }

    
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
            [imageView setImage:image];
            activityView.hidden = YES;
        }

    }
    else
    {
        UIActivityIndicatorView* activityView = (UIActivityIndicatorView*)[cell viewWithTag:7];
        activityView.hidden = YES;
        UIImageView* imageView = (UIImageView*)[cell viewWithTag:1];
        [imageView setImage:[UIImage imageNamed:@"shadow_home"]];
    }
    
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dealsList.count;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    int productIndex = indexPath.item;
    OnGoProducts* product = self.dealsList[productIndex];
    
    ProductTabViewController* productTabViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductTabViewController"];
    productTabViewController.productInfo  = product;
    [self.navigationController pushViewController:productTabViewController animated:YES];
}

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return self.dealsList.count;
//}
    
-(NSString*)leftNavigationBarItemTitle
{
    return self.offerType;
}

-(void)backButtonTapped
{
    [(CCKFNavDrawer*)self.navigationController drawerToggle];
    [self.navigationController popViewControllerAnimated:YES];
}



- (IBAction)myClickEvent:(id)sender event:(id)event {
    
    NSSet *touches = [event allTouches];
    
    UITouch *touch = [touches anyObject];
    
    CGPoint currentTouchPosition = [touch locationInView:self.collectionView];
    
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint: currentTouchPosition];
    
    
    OnGoProducts* product = self.dealsList[indexPath.item];
    
    
    if([product.favourite isEqualToString:@"1"])
    {
        [[OnGoDB dbInstance] makeFavorite:NO forProduct:product];
        
    }
    else
    {
        [[OnGoDB dbInstance] makeFavorite:YES forProduct:product];
    }
    [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
    
}

@end
