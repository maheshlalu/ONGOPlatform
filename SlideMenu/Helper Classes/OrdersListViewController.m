//
//  SignInViewController.m
//  OnGO
//
//  Created by Mentor Insight India pvt Ltd on 27/02/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "OrdersListViewController.h"
#import "DataServices.h"

@interface OrdersListViewController ()
@property(nonatomic,strong) NSMutableArray* ordersList;
@end

@implementation OrdersListViewController
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
    [self reloadOrders];
}

-(void)reloadOrders
{
    NSString* userId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"loggedinUserDetails"] objectForKey:@"UserId"];
    if(!userId)
    {
        userId = @"11";
    }
    
    [[DataServices serviceInstance] getAllOrdersForMallId:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"MALL_ID"] userId:userId  block:^(NSDictionary* response)
     {
         self.ordersList = [response objectForKey:@"jobs"];
         [self.collectionView reloadData];
     }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self reloadOrders];
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
    return @"My Orders";
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.ordersList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"OrdersIdentifier";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.layer.borderWidth = 1.0f;
    
    cell.layer.borderColor = [UIColor colorWithRed:225/255.0f green:225/255.0f blue:225/255.0f alpha:1.0f].CGColor;
    
    
    int productIndex = indexPath.item;
    if(productIndex < self.ordersList.count)
    {
        NSDictionary* dict = self.ordersList[productIndex];
        
        UILabel* orderIdLabel = (UILabel*)[cell viewWithTag:1];
        orderIdLabel.text = [[dict objectForKey:@"id"] stringValue];
        
        UILabel* createdOnLabel = (UILabel*)[cell viewWithTag:2];
        createdOnLabel.text = [dict objectForKey:@"createdOn"];

        UILabel* totalLabel = (UILabel*)[cell viewWithTag:3];
        totalLabel.text = [dict objectForKey:@"Total"];
        
        UILabel* statusLabel = (UILabel*)[cell viewWithTag:4];
        statusLabel.text = [dict objectForKey:@"Current_Job_Status"];

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
