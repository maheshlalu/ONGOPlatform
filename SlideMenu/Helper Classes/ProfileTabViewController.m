//
//  SignInViewController.m
//  OnGO
//
//  Created by Mentor Insight India pvt Ltd on 27/02/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "ProfileTabViewController.h"
#import "DataServices.h"
#import "FavoritesListViewController.h"
#import "LoyaltyViewController.h"
#import "OrdersListViewController.h"
#import "ProfileViewController.h"

@interface ProfileTabViewController ()<ADPageControlDelegate>{
    
}
@property(strong,nonatomic) MHTabBarController* tabBarController;
@end

@implementation ProfileTabViewController

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
    
    ProfileViewController *profileViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    profileViewController.tabItemName = @"MY PROFILE";
    profileViewController.tabBGColor = [UIColor colorWithRed:238.0f/255 green:238.0f/255 blue:238.0f/255 alpha:1.0f];
    profileViewController.navController = self.navigationController;
    
    
    FavoritesListViewController* favoritesListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FavoritesListViewController"];
    favoritesListViewController.tabItemName = @"FAVOURITES";
    favoritesListViewController.tabBGColor = [UIColor colorWithRed:238.0f/255 green:238.0f/255 blue:238.0f/255 alpha:1.0f];
    favoritesListViewController.navController = self.navigationController;
    
    LoyaltyViewController* loyaltyViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoyaltyViewController"];
    loyaltyViewController.tabItemName = @"LOYALTY";
    loyaltyViewController.tabBGColor = [UIColor colorWithRed:238.0f/255 green:238.0f/255 blue:238.0f/255 alpha:1.0f];
    loyaltyViewController.navController = self.navigationController;
    
    OrdersListViewController* ordersListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"OrdersListViewController"];
    ordersListViewController.tabItemName = @"ORDERS";
    ordersListViewController.tabBGColor = [UIColor colorWithRed:238.0f/255 green:238.0f/255 blue:238.0f/255 alpha:1.0f];
    ordersListViewController.navController = self.navigationController;
    
    
    
    NSArray *viewControllers = nil;
    viewControllers = @[profileViewController, loyaltyViewController, favoritesListViewController];
    // viewControllers = @[profileViewController, ordersListViewController, loyaltyViewController, favoritesListViewController];
    [self setUpPageController:viewControllers andTabTitles:@[@"MY PROFILE",@"LOYALTY",@"FAVOURITES"]];
    
    return;
    //I replace the MHTabbar to another controller(mahesh)
    self.tabBarController = [[MHTabBarController alloc] init];
    self.tabBarController.delegate = self;
    self.tabBarController.isTabBarItemWidthResize = YES;
    //[self addChildViewController:self.tabBarController];
    self.tabBarController.view.frame = CGRectMake(self.tabBarController.view.frame.origin.x, 43, self.tabBarController.view.frame.size.width, self.tabBarController.view.frame.size.height-43);
    [self.view addSubview:self.tabBarController.view];
    
    self.tabBarController.viewControllers = viewControllers;
    
}


- (void)setUpPageController:(NSArray*)controller andTabTitles:(NSArray*)titles{
    
    
    //page 0
    ADPageModel *pageModel0 = [[ADPageModel alloc] init];
    pageModel0.strPageTitle = titles[0];
    pageModel0.iPageNumber = 0;
    pageModel0.viewController = controller[0];//You can provide view controller in prior OR use flag "bShouldLazyLoad" to load only when required
    pageModel0.bShouldLazyLoad = YES;
    
    //page 1
    ADPageModel *pageModel1 = [[ADPageModel alloc] init];
    pageModel1.strPageTitle = titles[1];
    pageModel1.iPageNumber = 1;
    pageModel1.viewController = controller[1];
    pageModel1.bShouldLazyLoad = YES;
    
    //page 2
    ADPageModel *pageModel2 = [[ADPageModel alloc] init];
    pageModel2.strPageTitle = titles[2];
    pageModel2.iPageNumber = 2;
    pageModel2.bShouldLazyLoad = YES;
    pageModel2.viewController = controller[2];
    
    
    /**** 2. Initialize page control ****/
    
    _pageControl = [[ADPageControl alloc] init];
    _pageControl.delegateADPageControl = self;
    _pageControl.arrPageModel = [[NSMutableArray alloc] initWithObjects:pageModel0,pageModel1,pageModel2, nil];
    
    
    
    /**** 3. Customize parameters (Optinal, as all have default value set) ****/
    
    _pageControl.iFirstVisiblePageNumber = 0;
    _pageControl.iTitleViewHeight = 50;
    _pageControl.iPageIndicatorHeight = 4;
    //_pageControl.fontTitleTabText =  [UIFont fontWithName:@"Helvetica" size:16];
    
    _pageControl.bEnablePagesEndBounceEffect = NO;
    _pageControl.bEnableTitlesEndBounceEffect = NO;
    
    _pageControl.bShowMoreTabAvailableIndicator = NO;
    
    /**** 3. Add as subview ****/
    
    _pageControl.view.frame = CGRectMake(0, 43, self.view.bounds.size.width, self.view.bounds.size.height - 43);
    [self.view addSubview:_pageControl.view];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSString*)leftNavigationBarItemTitle
{
    return @"Profile";
}


- (BOOL)mh_tabBarController:(MHTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController atIndex:(NSUInteger)index
{
    
	return YES;
}

- (void)mh_tabBarController:(MHTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController atIndex:(NSUInteger)index
{
    
    
}

@end
