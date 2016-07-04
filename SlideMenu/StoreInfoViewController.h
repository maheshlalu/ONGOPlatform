//
//  StoreInfoViewController.h
//  OnGO
//
//  Created by krish on 18/05/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHTabBarController.h"
#import "DataServices.h"
#import "LocationList.h"
#import "CCKFNavDrawer.h"
#import <MessageUI/MessageUI.h>
#import "HomeViewController.h"
#import "KIImagePager.h"
#import "UILabel+CXLabel.h"
#import "AFTableViewCell.h"
#import "ProductTabViewController.h"
@interface StoreInfoViewController : UIViewController<MHTabBarItemController,LocationListDelegate,MFMessageComposeViewControllerDelegate,UIPageViewControllerDataSource,UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView* tableView;


@property(nonatomic, strong) NSArray* storeList;
@property(nonatomic, strong) NSArray* storeCategorieList;

@property(nonatomic, strong) OnGoStores* storeData;
@property(nonatomic, strong) CCKFNavDrawer* navController;
@property(nonatomic, assign) HomeViewController* homeViewController;
@property(strong,nonatomic)ProductTabViewController* productTabViewController;

@property (nonatomic,strong) NSMutableArray *coverImageList;

@property (strong, nonatomic) IBOutlet KIImagePager *_imagePager;

-(IBAction)locationBtnClicked:(id)sender;
-(IBAction)callUsBtnClicked:(id)sender;
-(IBAction)smsBtnClicked:(id)sender;
-(IBAction)fbBtnClicked:(id)sender;
-(IBAction)twitterBtnClicked:(id)sender;
-(IBAction)locBtnClicked:(id)sender;
- (IBAction)viewMoreClicked:(id)sender event:(id)event;
- (IBAction)viewMoreClickedInGroup:(id)sender event:(id)event;

- (void)passTheAlubumImages:(NSArray*)images;
@end
