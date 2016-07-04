//
//  DealsListViewController.h
//  OnGO
//
//  Created by krish on 22/05/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXViewController.h"

@interface CXCustomTabListViewController : CXViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong)  UITableView* tableView;
@property(nonatomic,strong) NSString* customTabName;


@end
