//
//  CCKFNavDrawer.m
//  CCKFNavDrawer
//
//  Created by calvin on 23/1/14.
//  Copyright (c) 2014年 com.calvin. All rights reserved.
//

#import "CCKFNavDrawer.h"
#import "DrawerView.h"
#import "LeftViewController.h"
#import "CXViewController.h"

#define SHAWDOW_ALPHA 0.5
#define MENU_DURATION 0.3
#define MENU_TRIGGER_VELOCITY 350
#define LEFT_NAV_BUTTON_WIDTH 44
#define LEFT_NAV_BUTTON_HEIGHT 44

#define ICON_WIDTH 35
#define ICON_HEIGHT 35

@interface CCKFNavDrawer ()

@property (nonatomic) BOOL isOpen;
@property (nonatomic) float meunHeight;
@property (nonatomic) float menuWidth;
@property (nonatomic) CGRect outFrame;
@property (nonatomic) CGRect inFrame;
@property (strong, nonatomic) UIView *shawdowView;
@property (strong, nonatomic) UIView *drawerView;
@property (strong, nonatomic) LeftViewController* leftViewController;
@end

@implementation CCKFNavDrawer

@synthesize titleLabel;
//@synthesize notificationBtn;

#pragma mark - VC lifecycle

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
	// Do any additional setup after loading the view.
    self.delegate = self;
   // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateTheCartInformation) name:@"loadCartInformation" object:nil];

    [self setUpDrawer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setSelectedStore:(OnGoStores *)selectedStore
{
    _selectedStore = selectedStore;
    if(!self.leftViewController.selectedStore)
    {
        self.leftViewController.selectedStore = selectedStore;
    }
}

#pragma mark - push & pop

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    
    // disable gesture in next vc
    [self.pan_gr setEnabled:NO];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    UIViewController *vc = [super popViewControllerAnimated:animated];
    
    // enable gesture in root vc
    if ([self.viewControllers count]==1){
        [self.pan_gr setEnabled:YES];
    }
    return vc;
}

#pragma mark - drawer

- (void)setUpDrawer
{
    self.isOpen = NO;
    self.leftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
    self.leftViewController.view.frame = CGRectMake(self.leftViewController.view.frame.origin.x, self.leftViewController.view.frame.origin.y, 270, self.leftViewController.view.frame.size.height);
    
    self.leftViewController.navController = self;
    // load drawer view
    self.drawerView = self.leftViewController.view;
    
    self.meunHeight = self.drawerView.frame.size.height;
    self.menuWidth = self.drawerView.frame.size.width;
    self.outFrame = CGRectMake(-self.menuWidth,0,self.menuWidth,self.meunHeight);
    self.inFrame = CGRectMake (0,0,self.menuWidth,self.meunHeight);
    
    // drawer shawdow and assign its gesture
    self.shawdowView = [[UIView alloc] initWithFrame:self.view.frame];
    self.shawdowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    self.shawdowView.hidden = YES;
    UITapGestureRecognizer *tapIt = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(tapOnShawdow:)];
    [self.shawdowView addGestureRecognizer:tapIt];
    self.shawdowView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.shawdowView];
    
    // add drawer view
    [self.drawerView setFrame:self.outFrame];
    [self.view addSubview:self.drawerView];
    
    // drawer list
//    [self.drawerView.drawerTableView setContentInset:UIEdgeInsetsMake(64, 0, 0, 0)]; // statuesBarHeight+navBarHeight
//    self.drawerView.drawerTableView.dataSource = self;
//    self.drawerView.drawerTableView.delegate = self;
    
    // gesture on self.view
    self.pan_gr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveDrawer:)];
    self.pan_gr.maximumNumberOfTouches = 1;
    self.pan_gr.minimumNumberOfTouches = 1;
    //self.pan_gr.delegate = self;
    [self.view addGestureRecognizer:self.pan_gr];
    
    [self.view bringSubviewToFront:self.navigationBar];
    
//    for (id x in self.view.subviews){
//        NSLog(@"%@",NSStringFromClass([x class]));
//    }
}

- (void)drawerToggle
{
    if (!self.isOpen) {
        [self openNavigationDrawer];
    }else{
        [self closeNavigationDrawer];
    }
}

#pragma open and close action

- (void)openNavigationDrawer{
//    NSLog(@"open x=%f",self.menuView.center.x);
    float duration = MENU_DURATION/self.menuWidth*abs(self.drawerView.center.x)+MENU_DURATION/2; // y=mx+c
    
    // shawdow
    self.shawdowView.hidden = NO;
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.shawdowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:SHAWDOW_ALPHA];
                     }
                     completion:nil];
    
    // drawer
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.drawerView.frame = self.inFrame;
                     }
                     completion:nil];
    
    self.isOpen= YES;
}

- (void)closeNavigationDrawer{
//    NSLog(@"close x=%f",self.menuView.center.x);
    float duration = MENU_DURATION/self.menuWidth*abs(self.drawerView.center.x)+MENU_DURATION/2; // y=mx+c
    
    // shawdow
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.shawdowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0f];
                     }
                     completion:^(BOOL finished){
                         self.shawdowView.hidden = YES;
                     }];
    
    // drawer
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.drawerView.frame = self.outFrame;
                     }
                     completion:nil];
    self.isOpen= NO;
}

#pragma gestures

- (void)tapOnShawdow:(UITapGestureRecognizer *)recognizer {
    [self closeNavigationDrawer];
}

-(void)moveDrawer:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self.view];
    CGPoint velocity = [(UIPanGestureRecognizer*)recognizer velocityInView:self.view];
//    NSLog(@"velocity x=%f",velocity.x);
    
    if([(UIPanGestureRecognizer*)recognizer state] == UIGestureRecognizerStateBegan) {
//        NSLog(@"start");
        if ( velocity.x > MENU_TRIGGER_VELOCITY && !self.isOpen) {
            [self openNavigationDrawer];
        }else if (velocity.x < -MENU_TRIGGER_VELOCITY && self.isOpen) {
            [self closeNavigationDrawer];
        }
    }
    
    if([(UIPanGestureRecognizer*)recognizer state] == UIGestureRecognizerStateChanged) {
//        NSLog(@"changing");
        float movingx = self.drawerView.center.x + translation.x;
        if ( movingx > -self.menuWidth/2 && movingx < self.menuWidth/2){
            
            self.drawerView.center = CGPointMake(movingx, self.drawerView.center.y);
            [recognizer setTranslation:CGPointMake(0,0) inView:self.view];
            
            float changingAlpha = SHAWDOW_ALPHA/self.menuWidth*movingx+SHAWDOW_ALPHA/2; // y=mx+c
            self.shawdowView.hidden = NO;
            self.shawdowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:changingAlpha];
        }
    }
    
    if([(UIPanGestureRecognizer*)recognizer state] == UIGestureRecognizerStateEnded) {
//        NSLog(@"end");
        if (self.drawerView.center.x>0){
            [self openNavigationDrawer];
        }else if (self.drawerView.center.x<0){
            [self closeNavigationDrawer];
        }
    }

}



-(UIBarButtonItem*)leftBarButtonItemForViewController:(CXViewController*)viewController
{
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];//200
    
    SEL selector;
    UIButton* menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, LEFT_NAV_BUTTON_WIDTH, LEFT_NAV_BUTTON_HEIGHT)];

    NSString* leftBarButtonImage = nil;

    if([viewController respondsToSelector:@selector(shouldShowLeftMenu)]) // which are derived from CXViewController
    {
        selector = ([viewController shouldShowLeftMenu]) ? @selector(leftMenuTapped) : @selector(backButtonTapped);
        leftBarButtonImage = ([viewController shouldShowLeftMenu]) ? @"menu-button" : @"ic_actionbar_leftslide";
        //menuButton.frame = CGRectMake(-15, 0, LEFT_NAV_BUTTON_WIDTH, LEFT_NAV_BUTTON_HEIGHT);
        menuButton.frame = CGRectMake(-15, 5, LEFT_NAV_BUTTON_WIDTH, LEFT_NAV_BUTTON_HEIGHT-10);
        //menuButton.backgroundColor = [UIColor redColor];
    }
    else
    {
        selector = @selector(backButtonTapped);
        leftBarButtonImage = @"ic_actionbar_leftslide";
        menuButton.frame = CGRectMake(-15, 0, LEFT_NAV_BUTTON_WIDTH, LEFT_NAV_BUTTON_HEIGHT);
    }
    
    
    [menuButton setImage:[UIImage imageNamed:leftBarButtonImage] forState:UIControlStateNormal];
    [menuButton addTarget:viewController
                   action:selector forControlEvents:UIControlEventTouchDown];
    [menuButton setTag:100];
    [customView addSubview:menuButton];
    
    
//    UIImageView* iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(LEFT_NAV_BUTTON_WIDTH, 4, ICON_WIDTH, ICON_HEIGHT)];
//    iconImageView.image = [UIImage imageNamed:@"icon"];
//    [iconImageView setTag:101];
//    [customView addSubview:iconImageView];
    
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(LEFT_NAV_BUTTON_WIDTH-10, 5, 200, 34)];
    self.titleLabel.text = viewController.leftNavigationBarItemTitle;
    [self.titleLabel setFont:[UIFont headerBarFont]];
    [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self.titleLabel setTag:102];
    self.titleLabel.textColor = [UIColor whiteColor];
    [customView addSubview:self.titleLabel];
    
//    CGRect rect = [[UIScreen mainScreen] bounds];
//    UIButton* rightButton = [[UIButton alloc] initWithFrame:CGRectMake(rect.size.width-LEFT_NAV_BUTTON_WIDTH-10, 8, LEFT_NAV_BUTTON_WIDTH, LEFT_NAV_BUTTON_HEIGHT)];
//    [rightButton setImage:[UIImage imageNamed:@"ic_action_overflow"] forState:UIControlStateNormal];
//    [rightButton addTarget:self
//                    action:@selector(rightMenuTapped:) forControlEvents:UIControlEventTouchDown];
//    [rightButton setTag:103];
//    [customView addSubview:rightButton];
    //    //        self.newsTitle.font = [UIFont fontWithName:@"AkrutiOriSarala06" size:self.newsTitle.font.pointSize];
    //
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"Language"] isEqualToString:@"odisha"]) {//odisha
        self.titleLabel.font = [UIFont fontWithName:@"AkrutiOriSarala06" size:self.titleLabel.font.pointSize];

    }else{
        self.titleLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:14.0f];

    }

    return [[UIBarButtonItem alloc]initWithCustomView:customView];

}


-(UIBarButtonItem*)rightBarButtonItemForViewController:(CXViewController*)viewController
{
    if([viewController respondsToSelector:@selector(shouldShowRightMenu)] && [viewController shouldShowRightMenu]) // which are derived from CXViewController
    {
        UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 43)];//75
        
        CGRect rect = [customView bounds];
        UIButton* rightButton = [[UIButton alloc] initWithFrame:CGRectMake(rect.size.width-LEFT_NAV_BUTTON_WIDTH, 0, LEFT_NAV_BUTTON_WIDTH, LEFT_NAV_BUTTON_HEIGHT)];
        [rightButton setImage:[UIImage imageNamed:@"ic_action_overflow"] forState:UIControlStateNormal];
        [rightButton addTarget:viewController
                        action:@selector(rightMenuTapped) forControlEvents:UIControlEventTouchDown];
        [rightButton setTag:100];
        [customView addSubview:rightButton];
        
        if([viewController respondsToSelector:@selector(shouldShowCart)] && [viewController shouldShowCart])
        {
            UIButton* cartButton = [[UIButton alloc] initWithFrame:CGRectMake(rect.size.width-LEFT_NAV_BUTTON_WIDTH-30, 0, LEFT_NAV_BUTTON_WIDTH, LEFT_NAV_BUTTON_HEIGHT)];
            [cartButton setImage:[UIImage imageNamed:@"Cart"] forState:UIControlStateNormal];
            [cartButton addTarget:viewController
                           action:@selector(cartTapped) forControlEvents:UIControlEventTouchDown];
            [cartButton setTag:101];
            //[customView addSubview:cartButton];
            
            self.cartCountLbl = [[UILabel alloc]initWithFrame:CGRectMake(20,15, 20, 20)];
           // [cartButton addSubview:self.cartCountLbl];
            [self.cartCountLbl setBackgroundColor:[UIColor colorWithRed:63/255.0f green:149/255.0f blue:0/255.0f alpha:1.0f]];
            self.cartCountLbl.textColor = [UIColor whiteColor];
            self.cartCountLbl.textAlignment = NSTextAlignmentCenter;
            self.cartCountLbl.font = [UIFont fontWithName:@"AlegreyaSans-Regular" size:18];
            self.cartCountLbl.layer.cornerRadius = 10.0f;
            self.cartCountLbl.layer.masksToBounds = YES;
            [self.cartCountLbl.layer setBorderColor:[[UIColor darkGrayColor] CGColor]];
            //self.cartCountLbl.hidden = YES;


          /*  [[OnGoDB dbInstance]getAllCartItems:@"" mallId:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"MALL_ID"] block:^(NSArray *allCartItems) {
                if (allCartItems.count==0) {
                    self.cartCountLbl.hidden = YES;
                    
                }else{
                    self.cartCountLbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)allCartItems.count];
                    self.cartCountLbl.hidden = NO;
                    
                }
            }];*/

        }
        
        
        if([viewController respondsToSelector:@selector(shouldShowLanguageSelection)] && [viewController shouldShowLanguageSelection])
        {
            
            _languageBtn = [[UIButton alloc] initWithFrame:CGRectMake(rect.size.width-60-30, 0, 60, LEFT_NAV_BUTTON_HEIGHT)];
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"Language"] isEqualToString:@"odisha"]) {//odisha
                [_languageBtn setTitle:@"English" forState:UIControlStateNormal];
                [_languageBtn setTitle:@"ଓଡ଼ିଶା" forState:UIControlStateSelected];

            }else if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Language"] isEqualToString:@"English"]){
                [_languageBtn setTitle:@"ଓଡ଼ିଶା" forState:UIControlStateNormal];
                [_languageBtn setTitle:@"English" forState:UIControlStateSelected];

            }else{
                [_languageBtn setTitle:@"ଓଡ଼ିଶା" forState:UIControlStateNormal];
                [_languageBtn setTitle:@"English" forState:UIControlStateSelected];
            }
            [_languageBtn addTarget:viewController
                             action:@selector(didToggleLanguageSelection:) forControlEvents:UIControlEventTouchDown];
            [_languageBtn setTag:101];
            [customView addSubview:_languageBtn];
            
            
            _notificationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _notificationBtn.frame = CGRectMake(_languageBtn.frame.origin.x-50, 0, 60, LEFT_NAV_BUTTON_HEIGHT);//50
            //[[UIButton alloc] initWithFrame:CGRectMake(_languageBtn.frame.origin.x-50, 0, 60, LEFT_NAV_BUTTON_HEIGHT)];
           [_notificationBtn setImage:[UIImage imageNamed:@"ic_social_notifications"] forState:UIControlStateNormal];
          //  [_notificationBtn setTitle:@"Notification" forState:UIControlStateNormal];
            [_notificationBtn addTarget:viewController
                             action:@selector(didToggleNotificationsSelection:) forControlEvents:UIControlEventTouchUpInside];
            [_notificationBtn setTag:102];
            _notificationBtn.userInteractionEnabled = YES;
            
            
//            UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:viewController action:@selector(tapAction:)];
//            tapG.numberOfTapsRequired = 1;
//            [_notificationBtn addGestureRecognizer:tapG];
            [customView addSubview:_notificationBtn];
            
            //[customView bringSubviewToFront:self.notificationBtn];

        }
        //customView.backgroundColor = [UIColor yellowColor];
        return [[UIBarButtonItem alloc]initWithCustomView:customView];

    }

    return nil;
}

//- (void)tapAction:(id)sender {
//    NSLog(@"Tap Action enabled");
//}
- (void)updateTheCartInformation;
{
    
    [[OnGoDB dbInstance]getAllCartItems:@"" mallId:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"MALL_ID"] block:^(NSArray *allCartItems) {
        self.cartCountLbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)allCartItems.count];
        self.cartCountLbl.hidden = NO;

    }];
}


- (void)navigationController:(UINavigationController *)navigationController
	  willShowViewController:(UIViewController *)viewController
					animated:(BOOL)animated
{
    CXViewController* vc = (CXViewController*)viewController;
    viewController.navigationItem.titleView = nil;
    viewController.navigationItem.leftBarButtonItem = [self leftBarButtonItemForViewController:vc];
    viewController.navigationItem.rightBarButtonItem = [self rightBarButtonItemForViewController:vc];
	
}

@end
