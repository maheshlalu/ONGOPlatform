//
//  TestViewController.h
//  OnGO
//
//  Created by krish on 06/06/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXViewController.h"
#import "CartViewController.h"

@interface OrderConfirmationViewController : CXViewController

@property(strong,nonatomic) IBOutlet UIView* containerView;
@property(strong,nonatomic) IBOutlet UIButton* okButton;


@property(strong,nonatomic)IBOutlet UITextField *nameTField;
@property(strong,nonatomic)IBOutlet UITextField *emailTxtField;
@property(strong,nonatomic)IBOutlet UITextField *address1TxtField;
@property(strong,nonatomic)IBOutlet UITextField *address2TxtField;
@property(strong,nonatomic)IBOutlet UITextField *phoneNumberTxtField;

@property(strong,nonatomic)IBOutlet UIImageView *nameEditImgView;
@property(strong,nonatomic)IBOutlet UIImageView *emailEditImgView;
@property(strong,nonatomic)IBOutlet UIImageView *address1EditImgView;
@property(strong,nonatomic)IBOutlet UIImageView *address2EditImgView;
@property(strong,nonatomic)IBOutlet UIImageView *phoneNumberEditImgView;
@property (strong,nonatomic) NSString *emailRegEx;
@property (strong,nonatomic) NSPredicate *emailTest;

@property(strong,nonatomic) CartViewController* cartViewController;

-(IBAction)okTapped:(id)sender;

-(IBAction)keyboardReturn:(id)sender;

@end
