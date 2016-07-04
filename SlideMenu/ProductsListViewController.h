//
//  ProductsListViewController.h
//  OnGO
//
//  Created by krish on 18/05/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCKFNavDrawer.h"
#import "CXViewController.h"

@interface ProductsListViewController : CXViewController<CCKFNavDrawerDelegate>

@property(nonatomic,retain) NSMutableArray* productsList;
@property(nonatomic, retain) NSString* productName;
@property(nonatomic, retain) IBOutlet UICollectionView* collectionView;



- (IBAction)addOrRemoveCart:(id)sender event:(id)event;

@end
