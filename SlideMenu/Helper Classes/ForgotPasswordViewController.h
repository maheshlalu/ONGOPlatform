//
//  ForgotPasswordViewController.h
//  OnGO
//
//  Created by Mentor Insight India pvt Ltd on 03/03/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXViewController.h"

@interface ForgotPasswordViewController : CXViewController<UITextFieldDelegate>
{
    IBOutlet UITextField *emailTxtField;
    IBOutlet UITextField *confirmEmailTxtField;
    IBOutlet UIButton *sendBtn;
    IBOutlet UIImageView *emailTxtImg;
    IBOutlet UIImageView *confirmEmailTxtImg;
 }

-(IBAction)sendBtnClicked:(id)sender;
-(IBAction)keyboardReturn:(id)sender;

@end
