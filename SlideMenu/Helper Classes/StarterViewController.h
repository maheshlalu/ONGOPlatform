//
//  StarterViewController.h
//  SlideMenu
//
//  Created by Mentor Insight India pvt Ltd on 24/02/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StarterViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    IBOutlet UITableView *starterMenuTbl;
    NSArray *menuSubcategoryArray;
    NSMutableArray* filtered;
}

@end
