//
//  SignInViewController.m
//  OnGO
//
//  Created by Mentor Insight India pvt Ltd on 27/02/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "FavoritesListViewController.h"
#import "DataServices.h"
#import "JSONKit.h"
#import "CXResourceManager.h"
#import "OnGoDownloadManager.h"
#import "OnGoDB.h"

@interface FavoritesListViewController ()
@property(strong,nonatomic) NSMutableArray* favList;
@end

@implementation FavoritesListViewController
@synthesize tabItemName = mTabItemName;
@synthesize tabBGColor = mTabBGColor;

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
}


-(void)viewDidAppear:(BOOL)animated
{
    [[OnGoDB dbInstance] getAllFavoritesForMallId:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"MALL_ID"] block:^(NSArray* favList)
    {
        self.favList = (NSMutableArray*)favList;
        [self.collectionView reloadData];
    }];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)leftBarTapped
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)shouldCustomizeLeftNavigationItem
{
    return YES;
}

-(NSString*)leftNavigationBarItemTitle
{
    return @"FAVOURITES";
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.favList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FavIdentifier";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.layer.borderWidth = 1.0f;
    
    cell.layer.borderColor = [UIColor colorWithRed:225/255.0f green:225/255.0f blue:225/255.0f alpha:1.0f].CGColor;
    
    UILabel* nameLabel = (UILabel*)[cell viewWithTag:2];
    
    int productIndex = indexPath.item;
    if(productIndex < self.favList.count)
    {
        OnGoProducts* product = self.favList[productIndex];
        nameLabel.text = product.Name;
        NSDictionary* dict = [product.json objectFromJSONString];
        
        UILabel* descLabel = (UILabel*)[cell viewWithTag:3];
        descLabel.text = product.Description;
        
        NSString* imageUrl = [dict objectForKey:@"Image_URL"];
        if(imageUrl)
        {
            
            UIImage *image = [[CXResourceManager sharedInstance] imageForPath:imageUrl];
            UIImageView* imageView = (UIImageView*)[cell viewWithTag:1];
            
            if(!image)
            {
                [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:imageUrl
                                                                              dataType:DATA_TYPE_BINARY finishBlock:^(OnGoDownloadData *downloadData){
                                                                                  if (downloadData.downloadStatus == DOWNLOAD_STATUS_SUCCESS)
                                                                                  {
                                                                                      UIImage *image = [UIImage imageWithData:downloadData.data];
                                                                                      if(image)
                                                                                      {
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
            }
        }
    }
    
    return cell;
}





- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}


@end
