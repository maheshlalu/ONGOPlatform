//
//  TestViewController.h
//  OnGO
//
//  Created by krish on 06/06/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "CXViewController.h"

@interface CXKeyPageViewController : CXViewController
@property(assign) NSInteger pageIndex;
@property(strong,nonatomic) NSDictionary* keyData;

@property(strong,nonatomic) IBOutlet UILabel* keyLabel;
@property(strong,nonatomic) IBOutlet UITextView* commentTextView;


@end
