//
//  SignInViewController.h
//  OnGO
//
//  Created by Mentor Insight India pvt Ltd on 27/02/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCKFNavDrawer.h"
#import "MHTabBarController.h"
#import "CXViewController.h"
#import "ADPageControl.h"

@interface ProfileTabViewController : CXViewController<CCKFNavDrawerDelegate,MHTabBarControllerDelegate>{
    
    ADPageControl *_pageControl;

    
}

@end
