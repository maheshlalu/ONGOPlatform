//
//  LeftViewController.h
//  OnGO
//
//  Created by CreativeXpert pvt Ltd. on 4/24/13.
//  Copyright (c) 2013 CreativeXpert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "OnGoDB.h"
#import "CCKFNavDrawer.h"
#import "CXCalenderVc.h"
#import "CXSocialWebViewController.h"
#import "MapViewController.h"
#import "OGJobs.h"

@class CXWidgetItem;

@protocol LeftViewControllerDelegate <NSObject>

- (void)leftMenuViewDidSelectMenuItem:(CXWidgetItem*)menuItem;

@end

@interface CXWidgetItem:NSObject
@property(nonatomic, strong) NSString* Name;
@property(nonatomic, strong) NSString* Display_Name;
@property(nonatomic, strong) NSString* Visibility;
@property(nonatomic, strong) NSString* Widget_Type;
@property(nonatomic, strong) NSArray* childItems;
@end

@interface LeftViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableIndexSet *expandedSections;
    IBOutlet UIImageView *imv;
}

@property (strong, nonatomic) IBOutlet UITableView *tblCollapesAndExpand;

@property (assign, nonatomic) id<LeftViewControllerDelegate> delegate;

@property(nonatomic, strong) CCKFNavDrawer* navController;
@property (nonatomic, strong) OGJobs* selectedStore;


-(IBAction)homeMenuTapped:(id)sender;

@end
