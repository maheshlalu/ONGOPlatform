//
//  ProductTabViewController.m
//  OnGO
//
//  Created by krish on 21/05/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "ProductTabViewController.h"
#import "ProductInfoViewController.h"
#import "RatingListViewController.h"

@interface ProductTabViewController ()
@property(strong,nonatomic) ProductInfoViewController* productInfoViewController;
@end

@implementation ProductTabViewController

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
    
    self.productInfoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductInfoViewController"];
    self.productInfoViewController.tabItemName = @"DESCRIPTION";
    self.productInfoViewController.tabBGColor = [UIColor colorWithRed:238.0f/255 green:238.0f/255 blue:238.0f/255 alpha:1.0f];
    self.productInfoViewController.navController = self.navigationController;
    
    RatingListViewController* ratingListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RatingListViewController"];
    ratingListViewController.tabItemName = @"REVIEWS";
    ratingListViewController.tabBGColor = [UIColor colorWithRed:238.0f/255 green:238.0f/255 blue:238.0f/255 alpha:1.0f];
    ratingListViewController.navController = self.navigationController;
    
    
    NSArray *viewControllers = nil;
    viewControllers = @[self.productInfoViewController, ratingListViewController];
    self.tabBarController = [[MHTabBarController alloc] init];
    self.tabBarController.delegate = self;
    [self.view addSubview:self.tabBarController.view];
    self.tabBarController.view.frame = CGRectMake(self.tabBarController.view.frame.origin.x, 43, self.tabBarController.view.frame.size.width, self.tabBarController.view.frame.size.height-43);
    
    //self.tabBarController.view.frame = self.tabBarContainerView.bounds;

    self.tabBarController.viewControllers = viewControllers;
    self.productInfoViewController.productInfo = self.productInfo;
    //ratingListViewController.ratingList = self.productInfo.ratingList;
    ratingListViewController.jobTypeId = self.productInfo.id;
    ratingListViewController.productInfo = self.productInfo;
    // Do any additional setup after loading the view.
}

-(void)setProductInfo:(OnGoProducts *)productInfo
{
    _productInfo = productInfo;
    self.productInfoViewController.productInfo = productInfo;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.productInfoViewController refresh];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)mh_tabBarController:(MHTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController atIndex:(NSUInteger)index
{
    
	return YES;
}

- (void)mh_tabBarController:(MHTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController atIndex:(NSUInteger)index
{
    
    
}


-(NSString*)leftNavigationBarItemTitle
{
    return self.productInfo.Name;
}
    

@end
