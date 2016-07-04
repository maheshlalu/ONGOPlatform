//
//  DealsListViewController.h
//  OnGO
//
//  Created by krish on 22/05/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXViewController.h"

@interface DealsListViewController : CXViewController

@property(nonatomic, strong) NSMutableArray* dealsList;
@property(nonatomic, strong) NSString* offerType;
@property(nonatomic, retain) IBOutlet UICollectionView* collectionView;


- (IBAction)myClickEvent:(id)sender event:(id)event;
@end
