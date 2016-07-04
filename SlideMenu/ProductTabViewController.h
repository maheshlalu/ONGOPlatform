//
//  ProductTabViewController.h
//  OnGO
//
//  Created by krish on 21/05/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHTabBarController.h"
#import "OnGoDB.h"
#import "CXViewController.h"

@interface ProductTabViewController : CXViewController<MHTabBarControllerDelegate>

@property(strong)MHTabBarController *tabBarController;

@property(strong, nonatomic) OnGoProducts* productInfo;

@end
