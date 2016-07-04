//
//  GroupServiceListViewController.m
//  OnGO
//
//  Created by krish on 18/05/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "GroupServiceListViewController.h"
#import "DataServices.h"
#import "JSONKit.h"
#import "OnGoDownloadManager.h"
#import "CXResourceManager.h"
#import "OnGoDownloadData.h"
#import "ServiceTabViewController.h"

#define ITEMS_PER_SECTION 2

#define ITEM_DEFAULT_WIDTH 150
#define ITEM_DEFAULT_HEIGHT 214



@interface GroupServiceListViewController ()
@end

@implementation GroupServiceListViewController

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



-(void)reloadProductList
{

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
    return [self.groupedServiceInfoDict[@"grouplist"] count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GroupCell";

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.layer.borderWidth = 1.0f;
    
    cell.layer.borderColor = [UIColor colorWithRed:225/255.0f green:225/255.0f blue:225/255.0f alpha:1.0f].CGColor;
    
    OnGoServiceCategories *serviceCategory = [self.groupedServiceInfoDict[@"grouplist"] objectAtIndex:indexPath.item];
    
    UILabel* nameLabel = (UILabel*)[cell viewWithTag:2];
    nameLabel.text = serviceCategory.Name;
    

    return cell;
}



- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(![self.groupedServiceInfoDict objectForKey:@"SpecialServiceOnlyAndGroup"] && ![self.groupedServiceInfoDict objectForKey:@"IsSpecialServiceOnly"])
    {
        OnGoServiceCategories *serviceCategory = [self.groupedServiceInfoDict[@"grouplist"] objectAtIndex:indexPath.item];
        ServiceTabViewController* serviceTabViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ServiceTabViewController"];
        serviceTabViewController.leftNavigationBarItemTitle = self.groupedServiceInfoDict[@"GroupName"];
        serviceTabViewController.serviceName = serviceCategory.Name;
        serviceTabViewController.serviceDesc = [serviceCategory Description];
        [self.navigationController pushViewController:serviceTabViewController animated:YES];
    }
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
    
@end
