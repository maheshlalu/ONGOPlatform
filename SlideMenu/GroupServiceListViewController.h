//
//  GroupServiceListViewController.h
//  OnGO
//
//  Created by krish on 18/05/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCKFNavDrawer.h"
#import "CXViewController.h"

@interface GroupServiceListViewController : CXViewController<CCKFNavDrawerDelegate>

@property(nonatomic,retain) NSMutableDictionary* groupedServiceInfoDict;
@property(nonatomic, retain) NSString* productName;
@property(nonatomic, retain) IBOutlet UICollectionView* collectionView;


@end
