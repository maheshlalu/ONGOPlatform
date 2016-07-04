//
//  SignInViewController.h
//  OnGO
//
//  Created by Mentor Insight India pvt Ltd on 27/02/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCKFNavDrawer.h"
#import "CXViewController.h"

@interface ChangePasswordViewController : CXViewController<UITextFieldDelegate,CCKFNavDrawerDelegate>{
    
}


-(IBAction)changePassword:(id)sender;

@end
