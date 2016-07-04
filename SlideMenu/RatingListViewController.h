//
//  RatingListViewController.h
//  OnGO
//
//  Created by krish on 18/05/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHTabBarController.h"
#import "CCKFNavDrawer.h"
#import "OnGoDB.h"

@interface RatingListViewController : UIViewController<MHTabBarItemController>
@property (nonatomic, strong) IBOutlet UITableView* ratingInfoTableView;
@property(nonatomic, strong) CCKFNavDrawer* navController;
@property(strong, nonatomic) OnGoProducts* productInfo;
@property(strong,nonatomic) NSMutableArray* ratingList;
@property(nonatomic,strong) NSString* jobTypeId;

@property(nonatomic,strong) IBOutlet UILabel* betheFirstStaticLabel;
@property(nonatomic,strong) IBOutlet UILabel* overallRatingLabel;

-(IBAction)writeReviewButtonTapped:(id)sender;

@end
