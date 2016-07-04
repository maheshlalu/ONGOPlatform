//
//  AppDelegate.h
//  OnGO
//
//  Created by CreativeXpert pvt Ltd. on 4/24/13.
//  Copyright (c) 2013 CreativeXpert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RightViewController.h"
#import "LeftViewController.h"
@interface OnGoAppDelegate : UIResponder <UIApplicationDelegate>{
   
}

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong) CCKFNavDrawer* navController;




@end
