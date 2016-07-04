//
//  Odisha360NewsDetailViewController.h
//  OnGO
//
//  Created by Hanuman Kachwa on 23/01/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OGOdishaNewsJobs;

@interface Odisha360NewsDetailViewController : UIViewController

@property (nonatomic, strong) OGOdishaNewsJobs *newsItem;
@property (nonatomic, strong) CXWidgetItem *menuItem;

@property (assign) BOOL isOdishaLanguage;

@end
