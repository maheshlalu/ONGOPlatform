//
//  HomeViewController.m
//  OnGO
//
//  Created by CreativeXpert pvt Ltd. on 4/24/13.
//  Copyright (c) 2014 CreativeXpert. All rights reserved.
//

#import "HomeViewController.h"
#import "LocationList.h"
#import "DataServices.h"
#import "OnGoCommonConstants.h"
#import "OnGoDownloadManager.h"
#import "StoreInfoViewController.h"
#import "RatingListViewController.h"
#import "CXResourceManager.h"
#import "OnGoDownloadData.h"
#import "CXKeysViewController.h"
#import "JSONKit.h"
#import "ProfileTabViewController.h"
#import "CXCalenderVc.h"
#import "MBProgressHUD.h"
#import "OGMallInfo.h"
#import "LeftViewController.h"

#define SYSTEM_VERSION_LESS_THAN(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface HomeViewController()
@property (strong, nonatomic) LocationList* locationList;
@property(strong,nonatomic)StoreInfoViewController* storeInfoViewController;
@property(strong,nonatomic)RatingListViewController* ratingListViewController;
@property(strong,nonatomic)CXKeysViewController* cxKeysViewController;
@property (strong,nonatomic)CXCalenderVc *calenderVc;

@end


@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [OGMallInfo getMallInfoWithBlock:^(OGMallInfo *mallInfo, NSError *error) {
        NSLog(@"test");
        [OGStoreCategories getWidgetsWithBlock:^(NSArray *widgets, NSError *error) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUserLoggedIn:) name:@"CXUserRegisterDidNotification" object:nil];
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUserLoggedIn:) name:@"CXUserLoginDidNotification" object:nil];
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUserLoggedIn:) name:@"CXUserProfileShowNotification" object:nil];
            
            
            
            self.leftNavigationBarItemTitle = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"PRODUCT_NAME"];
            
            [self setUpPageController];
            
            [self removeRightViewController];
            
            //[[OGWorkSpace sharedWorkspace].leftViewController viewDidLoad];
            
        }];
    }];
}

- (void)setUpPageController {
    self.storeInfoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"StoreInfoViewController"];
    self.storeInfoViewController.tabItemName = @"INFO";
    self.storeInfoViewController.tabBGColor = [UIColor colorWithRed:243.0f/255 green:243.0f/255 blue:243.0f/255 alpha:1.0f];
    self.storeInfoViewController.navController = (CCKFNavDrawer*)self.navigationController;
    self.storeInfoViewController.homeViewController = self;
    
    
    
    self.ratingListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RatingListViewController"];
    self.ratingListViewController.tabItemName = @"My Experience";//@"REVIEWS";
    self.ratingListViewController.tabBGColor = [UIColor colorWithRed:243.0f/255 green:243.0f/255 blue:243.0f/255 alpha:1.0f];
    self.ratingListViewController.navController = (CCKFNavDrawer*)self.navigationController;
    
    NSMutableArray *viewControllers = [[NSMutableArray alloc]initWithObjects:self.storeInfoViewController, self.ratingListViewController, nil];
    NSMutableArray *tabNames = [[NSMutableArray alloc]initWithObjects:@"INFO", @"REVIEWS", nil];
    
    NSArray* widgets = [[OGWorkSpace sharedWorkspace] getAllWidgetsForWidgetType:@"native"];
    
    BOOL exists = NO;
    for (OGWidgets *widget in widgets) {
        
        if([widget.name isEqualToString:@"Keys"] && [widget.visibility boolValue])
        {
            self.cxKeysViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CXKeysViewController"];
            self.cxKeysViewController.tabItemName = widget.displayName;
            self.cxKeysViewController.tabBGColor = [UIColor colorWithRed:243.0f/255 green:243.0f/255 blue:243.0f/255 alpha:1.0f];
            self.cxKeysViewController.navController = (CCKFNavDrawer*)self.navigationController;
            // viewControllers = @[self.storeInfoViewController, self.ratingListViewController, self.cxKeysViewController];
            [viewControllers addObject:self.cxKeysViewController];
            //tabNames = @[ @"INFO",@"My Experience",dict[@"Display_Name"]];
            [tabNames addObject:widget.displayName];
            exists = YES;
            //break;
        }else if ([widget.name isEqualToString:@"Calendar" ] &&[widget.visibility boolValue]){
            self.calenderVc  = [[CXCalenderVc alloc]initWithNibName:nil bundle:[NSBundle mainBundle]];
            self.calenderVc.view.backgroundColor = [UIColor colorWithRed:204.0f/255 green:204.0f/255 blue:204.0f/255 alpha:1.0f];
            self.calenderVc.navController = (CCKFNavDrawer*)self.navigationController;
            [viewControllers addObject:self.calenderVc];
            [tabNames addObject:widget.displayName];
        }
    }
    
    /*
     
     if([dict[@"Name"] isEqualToString:@"Keys"] && [dict[@"Visibility"] boolValue])
     {
     self.cxKeysViewController = [storyBoard instantiateViewControllerWithIdentifier:@"CXKeysViewController"];
     self.cxKeysViewController.tabItemName = dict[@"Display_Name"];
     self.cxKeysViewController.tabBGColor = [UIColor colorWithRed:243.0f/255 green:243.0f/255 blue:243.0f/255 alpha:1.0f];
     self.cxKeysViewController.navController = (CCKFNavDrawer*)self.navigationController;
     // viewControllers = @[self.storeInfoViewController, self.ratingListViewController, self.cxKeysViewController];
     [viewControllers addObject:self.cxKeysViewController];
     //tabNames = @[ @"INFO",@"My Experience",dict[@"Display_Name"]];
     [tabNames addObject:dict[@"Display_Name"]];
     exists = YES;
     //break;
     }else if ([dict[@"Name"] isEqualToString:@"Calendar" ] &&[dict[@"Visibility"]boolValue]){
     self.calenderVc  = [[CXCalenderVc alloc]initWithNibName:nil bundle:[NSBundle mainBundle]];
     self.calenderVc.view.backgroundColor = [UIColor colorWithRed:204.0f/255 green:204.0f/255 blue:204.0f/255 alpha:1.0f];
     self.calenderVc.navController = (CCKFNavDrawer*)self.navigationController;
     [viewControllers addObject:self.calenderVc];
     [tabNames addObject:dict[@"Display_Name"]];
     }
     */
    
    [self setUpPageController:viewControllers andTabTitles:tabNames];
    
    /* if(!exists)
     {
     viewControllers = @[self.storeInfoViewController, self.ratingListViewController];
     tabNames = @[ @"INFO",@"My Experience"];
     [self setUpPageController:viewControllers andTabTitles:tabNames];
     }*/
}

- (void)setUpPageController:(NSArray*)controller andTabTitles:(NSArray*)titles{
    NSMutableArray *controllers = [NSMutableArray new];
    
    for (int i = 0; i<controller.count; i++) {
        ADPageModel *pageVc = [[ADPageModel alloc]init];
        pageVc.strPageTitle = titles[i];
        pageVc.iPageNumber = i;
        pageVc.viewController = controller[i];
        pageVc.bShouldLazyLoad = YES;
        [controllers addObject:pageVc];
    }
    
    //page 0/
    /**** 2. Initialize page control ****/
    
    _pageControl = [[ADPageControl alloc] init];
    _pageControl.delegateADPageControl = self;
    _pageControl.arrPageModel = controllers;    
    
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

- (void)viewWillAppear:(BOOL)animated
{
    [self removeRightViewController];
}

-(void)setSelectedStore:(OnGoStores *)selectedStore
{
    _selectedStore = selectedStore;
    //self.ratingListViewController.ratingList = self.selectedStore.ratingList;
    self.ratingListViewController.jobTypeId = self.selectedStore.id;
    
    NSArray* widgets = [[OGWorkSpace sharedWorkspace] getAllWidgetsForWidgetType:@"native"];
    
    NSMutableArray* keyList = [NSMutableArray new];
    NSDictionary* storeDict = [self.selectedStore.json objectFromJSONString];

    for(OGWidgets *widget in widgets)
    {
        
        NSString* keyName = widget.name;
        if(keyName)
        {
            
            NSString* keyValue = [storeDict objectForKey:keyName];
            
            if(keyValue)
            {
                NSDictionary* keyDict = [NSDictionary dictionaryWithObjectsAndKeys:keyName, @"keyName", keyValue, @"comment",nil];
                [keyList addObject:keyDict];
            }
            
        }
    }
    if(!self.cxKeysViewController.keysList)
    {
        self.cxKeysViewController.keysList = keyList;
    }
    
    [(CCKFNavDrawer*)self.navigationController setSelectedStore:selectedStore];
}


- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
	return YES;
}


- (BOOL)mh_tabBarController:(MHTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController atIndex:(NSUInteger)index
{
    
	return YES;
}

- (void)mh_tabBarController:(MHTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController atIndex:(NSUInteger)index
{
    
    
}

-(IBAction)leftMenuTapped:(id)sender
{
    [(CCKFNavDrawer *)self.navigationController drawerToggle];
}


-(BOOL)shouldShowLeftMenu
{
    return YES;
}

-(void)showProfile:(id)obj
{
    ProfileTabViewController* profileViewC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileTabViewController"];
    [self.navigationController pushViewController:profileViewC animated:NO];}


-(void)handleUserLoggedIn:(NSNotification*)notification
{
    [self performSelector:@selector(showProfile:) withObject:nil afterDelay:0.001f];
}

@end
