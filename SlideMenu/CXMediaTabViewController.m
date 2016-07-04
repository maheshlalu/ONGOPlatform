//
//  ProductTabViewController.m
//  OnGO
//
//  Created by krish on 21/05/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "CXMediaTabViewController.h"
#import "CXAlbumImageCollectionViewController.h"
#import "CXAlbumVideoCollectionViewController.h"
#import "CXAlbumAudioCollectionViewController.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface CXMediaTabViewController ()
@property (strong, nonatomic)  IBOutlet GADBannerView *bannerView;

@end

@implementation CXMediaTabViewController

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
    
//    self.bannerView.adUnitID = @"ca-app-pub-2961740639249418/1063635481";
//    self.bannerView.rootViewController = self;
//    
//    
//    GADRequest *request = [GADRequest request];
//    // Enable test ads on simulators.
//    request.testDevices = @[ GAD_SIMULATOR_ID ];
//    [self.bannerView loadRequest:request];
    
    
    CXAlbumImageCollectionViewController* cxAlbumImageCollectionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CXAlbumImageCollectionViewController"];
    cxAlbumImageCollectionViewController.tabItemName = @"Images";
    cxAlbumImageCollectionViewController.tabBGColor = [UIColor colorWithRed:238.0f/255 green:238.0f/255 blue:238.0f/255 alpha:1.0f];
    cxAlbumImageCollectionViewController.navController = self.navigationController;
    
    
    
    CXAlbumAudioCollectionViewController* cxAlbumAudioCollectionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CXAlbumAudioCollectionViewController"];
    cxAlbumAudioCollectionViewController.tabItemName = @"Audios";
    cxAlbumAudioCollectionViewController.tabBGColor = [UIColor colorWithRed:238.0f/255 green:238.0f/255 blue:238.0f/255 alpha:1.0f];
    cxAlbumAudioCollectionViewController.navController = self.navigationController;

    
    
    CXAlbumVideoCollectionViewController* cxAlbumVideoCollectionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CXAlbumVideoCollectionViewController"];
    cxAlbumVideoCollectionViewController.tabItemName = @"Videos";
    cxAlbumVideoCollectionViewController.tabBGColor = [UIColor colorWithRed:238.0f/255 green:238.0f/255 blue:238.0f/255 alpha:1.0f];
    cxAlbumVideoCollectionViewController.navController = self.navigationController;

    
    NSArray *viewControllers = nil;
    viewControllers = @[cxAlbumImageCollectionViewController, cxAlbumAudioCollectionViewController, cxAlbumVideoCollectionViewController];

    cxAlbumImageCollectionViewController.imageList = self.album.imageList;
    cxAlbumAudioCollectionViewController.audioList = self.album.audioList;
    cxAlbumVideoCollectionViewController.videoList = self.album.videoList;
    
    //[self setUpPageController:viewControllers andTabTitles:@[@"Images",@"Audios",@"Videos"]];
    //return;
    self.tabBarController = [[MHTabBarController alloc] init];
    self.tabBarController.delegate = self;
    self.tabBarController.isTabBarItemWidthResize = YES;
    [self.view addSubview:self.tabBarController.view];
    self.tabBarController.view.frame = CGRectMake(self.tabBarController.view.frame.origin.x, 43, self.tabBarController.view.frame.size.width, self.tabBarController.view.frame.size.height-43);
    
    
    self.tabBarController.viewControllers = viewControllers;
    
//    [self.view bringSubviewToFront:self.bannerView];
//
//    self.bannerView.adUnitID = @"ca-app-pub-2961740639249418/1063635481";
//    self.bannerView.rootViewController = self;
//    
//    
//    GADRequest *request = [GADRequest request];
//    // Enable test ads on simulators.
//    request.testDevices = @[ GAD_SIMULATOR_ID ];
//    [self.bannerView loadRequest:request];


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


- (BOOL)mh_tabBarController:(MHTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController atIndex:(NSUInteger)index
{
    
	return YES;
}

- (void)mh_tabBarController:(MHTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController atIndex:(NSUInteger)index
{
    
    
}

-(void)backButtonTapped
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(NSString*)leftNavigationBarItemTitle
{
    return self.album.albumName;
}
    

@end
