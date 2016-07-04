//
//  SignInViewController.m
//  OnGO
//
//  Created by Mentor Insight India pvt Ltd on 27/02/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "SignupViewController.h"
#import "DataServices.h"
#import "CXLoadingViewController.h"

@interface SignupViewController ()
@property(nonatomic,strong) CXLoadingViewController *loadingViewController;
@end

@implementation SignupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    emailTxtField.delegate=self;
    paswordTxtField.delegate=self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (emailTxtField.editing==YES)
    {
        emailEditImgView.image=[UIImage imageNamed:@"red_line"];
        
    }
    else
    {
        emailEditImgView.image=[UIImage imageNamed:@"grey_line-1"];
    }
    if(paswordTxtField.editing==YES)
    {
        passwrdEditImgView.image=[UIImage imageNamed:@"red_line"];
    }
    else
    {
       passwrdEditImgView.image=[UIImage imageNamed:@"grey_line-1"];
    }
    
    if(firstNameTField.editing==YES)
    {
        firstNameEditImgView.image=[UIImage imageNamed:@"red_line"];
    }
    else
    {
        firstNameEditImgView.image=[UIImage imageNamed:@"grey_line-1"];
    }
    
    if(lastNameTField.editing==YES)
    {
        lastNameEditImgView.image=[UIImage imageNamed:@"red_line"];
    }
    else
    {
        lastNameEditImgView.image=[UIImage imageNamed:@"grey_line-1"];
    }
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
      emailEditImgView.image=[UIImage imageNamed:@"grey_line-1"];
      passwrdEditImgView.image=[UIImage imageNamed:@"grey_line-1"];
    
    firstNameEditImgView.image=[UIImage imageNamed:@"grey_line-1"];
    lastNameEditImgView.image=[UIImage imageNamed:@"grey_line-1"];

    if(firstNameTField == textField || lastNameTField == textField)
    {
        return;
    }
    
    
      //Email Validation..
      emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
      emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
     //Valid email address
  if ([emailTest evaluateWithObject:emailTxtField.text] == YES)
    {
        //UIAlertView *emailAlert = [[UIAlertView alloc]initWithTitle:@"Email alert" message:@"Email is in proper formate" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        //[emailAlert show];
    }
    else
    {
        UIAlertView *emailAlert = [[UIAlertView alloc]initWithTitle:@"Messege" message:@"Email not in proper format" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [emailAlert show];
    }

    // Password Validation.
if (textField == paswordTxtField)
    {
       // int numberofCharacters = 0;
        BOOL lowerCaseLetter,upperCaseLetter= 0;
        if([paswordTxtField.text length] >= 8)
        {
            for (int i = 0; i < [paswordTxtField.text length]; i++)
            {
                unichar c = [paswordTxtField.text characterAtIndex:i];
                if(!lowerCaseLetter)
                {
                    lowerCaseLetter = [[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:c];
                }
                if(!upperCaseLetter)
                {
                    upperCaseLetter = [[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:c];
                }
                /*if(!digit)
                 {
                 digit = [[NSCharacterSet decimalDigitCharacterSet] characterIsMember:c];
                 }
                 if(!specialCharacter)
                 {
                 specialCharacter = [[NSCharacterSet symbolCharacterSet] characterIsMember:c];
                 }*/
            }
            
            if(lowerCaseLetter && upperCaseLetter)
            {
                //do what u want
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Please Ensure that you have at least one lower case letter, one upper case letter, one digit and one special character"
                                                               delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Please Enter at least 8 characters"
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        
    }
}


-(IBAction)signInBtnClicked:(id)sender
{
    firstNameTField.delegate = nil;
    lastNameTField.delegate = nil;
    emailTxtField.delegate = nil;
    paswordTxtField.delegate = nil;

    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)signUpBtnClicked:(id)sender
{
   // http://54.251.36.80:8081/MobileAPIs/regAndloyaltyAPI?orgId=3&userEmailId=cxsample@gmail.com&dt=DEVICES&firstName=Cxs&lastName=Ample&password=123

    self.loadingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CXLoadingViewController"];
    [self.view addSubview:self.loadingViewController.view];

    [[DataServices serviceInstance] postRegister:emailTxtField.text password:paswordTxtField.text firstName:firstNameTField.text lastName:lastNameTField.text mallId:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"MALL_ID"] isFB:NO finishblock:^(NSDictionary* response)
     {
         if([[response objectForKey:@"status"] intValue] == 1)
         {
             [self.navigationController popToRootViewControllerAnimated:NO];
         }
         else if([[response objectForKey:@"status"] intValue] == -1)
         {
             UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"StoreOnGo" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
             [alert show];
             [self.loadingViewController.view removeFromSuperview];
             self.loadingViewController = nil;
         }
     }];

    
}


-(IBAction)keyboardReturn:(id)sender
{
    [emailTxtField resignFirstResponder];
    [paswordTxtField resignFirstResponder];
    [firstNameTField resignFirstResponder];
    [lastNameTField resignFirstResponder];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)backButtonTapped
{
    firstNameTField.delegate = nil;
    lastNameTField.delegate = nil;
    emailTxtField.delegate = nil;
    paswordTxtField.delegate = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)shouldShowRightMenu
{
    return NO;
}


-(NSString*)leftNavigationBarItemTitle
{
    return @"Sign in or Sign up";
}

@end
