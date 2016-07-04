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

@interface CXKeysViewController : UIViewController<UIPageViewControllerDataSource,MHTabBarItemController,UITableViewDataSource,UITableViewDelegate>{
    NSCache *_cellCache;

}

@property(nonatomic, strong) IBOutlet UITableView* keysTableView;
@property(nonatomic, strong) CCKFNavDrawer* navController;
@property(nonatomic, strong)  NSMutableArray* keysList;

@end


