//
//  TestViewController.h
//  OnGO
//
//  Created by krish on 06/06/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHTabBarController.h"
#import "CCKFNavDrawer.h"
#import "WYPopoverController.h"

@interface CXViewController : UIViewController <WYPopoverControllerDelegate, UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong) NSString* leftNavigationBarItemTitle;
@property(nonatomic, strong) CCKFNavDrawer* navController;

@property (nonatomic, strong) WYPopoverController *cxPopoverController;

@property(strong,nonatomic) UITableView *rightMenuTableView;

-(BOOL)shouldShowRightMenu;
-(BOOL)shouldShowLeftMenu;
-(BOOL)shouldShowCart;
-(BOOL)shouldShowLanguageSelection;

-(void)backButtonTapped;

-(void)removeRightViewController;
-(void)profileTapped;

@end
