//
//  TestViewController.h
//  OnGO
//
//  Created by krish on 06/06/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXViewController.h"


@interface CartViewController : CXViewController

@property(nonatomic,strong) IBOutlet UICollectionView* collectionView;
@property(nonatomic,strong) IBOutlet UILabel* totalLabel;
@property(nonatomic,strong) IBOutlet UIView* noCartItemsView;

@property(nonatomic,strong) NSString* name;
@property(nonatomic,strong) NSString* address;
@property(nonatomic,strong) NSString* phoneNumber;
@property(nonatomic,strong) NSString* email;


-(IBAction)keepShoppingTapped:(id)sender;
-(IBAction)checkout:(id)sender;
-(IBAction)addItem:(id)sender event:(id)event;
-(IBAction)deleteItem:(id)sender event:(id)event;

-(void)processOrder;

@end
