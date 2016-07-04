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

@interface SignInViewController : CXViewController<UITextFieldDelegate,CCKFNavDrawerDelegate>{
    
    IBOutlet UITextField *emailTxtField;
    IBOutlet UITextField *paswordTxtField;
    IBOutlet UIImageView *emailEditImgView;
    IBOutlet UIImageView *passwrdEditImgView;
    NSString *emailRegEx;
    NSPredicate *emailTest;
    
    
    IBOutlet UIScrollView *backGroundScroll;
    
}
-(IBAction)signInBtnClicked:(id)sender;
-(IBAction)fbLoginBtnClicked:(id)sender;
-(IBAction)forgotPasswrdBtnClicked:(id)sender;
-(IBAction)keyboardReturn:(id)sender;

@end
