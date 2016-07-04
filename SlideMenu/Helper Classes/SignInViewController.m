//
//  SignInViewController.m
//  OnGO
//
//  Created by Mentor Insight India pvt Ltd on 27/02/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "SignInViewController.h"
#import "DataServices.h"
#import "CXLoadingViewController.h"
#import "lyt.h"

@interface SignInViewController ()
@property(nonatomic,strong) CXLoadingViewController *loadingViewController;

@property (nonatomic,strong) UITextField *emalTxtField;

@property (nonatomic,strong) UITextField *passWordTxtField;
@property (nonatomic,strong) UILabel *signInTxtLbl;

@property (nonatomic,strong) UIButton *signInBtn;
@property (nonatomic,strong) UIButton *signUpBtn;


@end

@implementation SignInViewController

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


-(void)dealloc
{
    NSLog(@"in dealloc");
    
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
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
      emailEditImgView.image=[UIImage imageNamed:@"grey_line-1"];
      passwrdEditImgView.image=[UIImage imageNamed:@"grey_line-1"];
    
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
    if([emailTxtField.text isEqual:@""] || [paswordTxtField.text isEqual:@""])
    {
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"StoreOnGo" message:@"Please provide all mandatory fields" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
    }
    else
    {
        self.loadingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CXLoadingViewController"];
        [self.view addSubview:self.loadingViewController.view];

        [[DataServices serviceInstance] login:emailTxtField.text password:paswordTxtField.text  mallId:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"MALL_ID"] finishblock:^(NSDictionary* response)
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
        
}
-(IBAction)fbLoginBtnClicked:(id)sender
{
    
}


-(IBAction)forgotPasswrdBtnClicked:(id)sender
{
    NSLog(@"hiiiiii forgot pass clicked!!!!!");
}

-(IBAction)keyboardReturn:(id)sender
{
    [emailTxtField resignFirstResponder];
    [paswordTxtField resignFirstResponder];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)backButtonTapped
{
    emailTxtField.delegate = nil;
    paswordTxtField.delegate = nil;
    [self.navigationController popViewControllerAnimated:YES];
}


-(NSString*)leftNavigationBarItemTitle
{
    return @"Sign in or Sign up";
}

-(BOOL)shouldShowRightMenu
{
    return NO;
}


@end
