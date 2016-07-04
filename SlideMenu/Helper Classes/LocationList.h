//
//  LocationList.h
//  OnGO
//
//  Created by Mentor Insight India pvt Ltd on 15/04/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataServices.h"
#import <CoreLocation/CoreLocation.h>

@protocol LocationListDelegate;

@interface LocationList : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,CLLocationManagerDelegate>
{
}

@property (nonatomic,strong) NSArray *storeList;
@property (nonatomic,strong) IBOutlet UITableView *tblList;
@property (nonatomic,strong) IBOutlet UISearchBar* searchBar;

@property (assign) id<LocationListDelegate> delegate;

-(void)resetSearchBar;
-(void)resignSearchbar;

@end



@protocol LocationListDelegate <NSObject>
-(void)locationList:(LocationList*)locationList didSelectStore:(OnGoStores*) stores;
@end

