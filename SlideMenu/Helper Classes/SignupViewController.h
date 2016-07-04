//
//  SignInViewController.h
//  OnGO
//
//  Created by Mentor Insight India pvt Ltd on 27/02/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCKFNavDrawer.h"
#include "CXViewController.h"

@interface SignupViewController : CXViewController<UITextFieldDelegate,CCKFNavDrawerDelegate>{
    
    IBOutlet UITextField *firstNameTField;
    IBOutlet UITextField *lastNameTField;
    IBOutlet UITextField *emailTxtField;
    IBOutlet UITextField *paswordTxtField;
    IBOutlet UIImageView *firstNameEditImgView;
    IBOutlet UIImageView *lastNameEditImgView;
    IBOutlet UIImageView *emailEditImgView;
    IBOutlet UIImageView *passwrdEditImgView;
    NSString *emailRegEx;
    NSPredicate *emailTest;
    
}
-(IBAction)signUpBtnClicked:(id)sender;

-(IBAction)signInBtnClicked:(id)sender;

@end
