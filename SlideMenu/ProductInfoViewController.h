//
//  ProductInfoViewController.h
//  OnGO
//
//  Created by krish on 20/05/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnGoDB.h"
#import "MHTabBarController.h"
#import "CCKFNavDrawer.h"
#import "CXViewController.h"

@interface ProductInfoViewController : CXViewController<MHTabBarItemController>

@property(strong) IBOutlet UILabel* productName;
@property(strong) IBOutlet UILabel* productPrice;
@property(strong) IBOutlet UITableView* tableView;
@property(nonatomic, strong) CCKFNavDrawer* navController;
@property(strong, nonatomic) OnGoProducts* productInfo;

- (IBAction)addOrRemoveCart:(id)sender event:(id)event;
-(IBAction)addReview:(id)sender;
- (IBAction)myClickEvent:(id)sender event:(id)event;

-(void)refresh;

@end
