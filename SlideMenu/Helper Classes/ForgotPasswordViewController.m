//
//  ForgotPasswordViewController.m
//  OnGO
//
//  Created by Mentor Insight India pvt Ltd on 03/03/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "CXLoadingViewController.h"
#import "DataServices.h"

@interface ForgotPasswordViewController ()
@property(nonatomic,strong) CXLoadingViewController *loadingViewController;

@end

@implementation ForgotPasswordViewController

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
	// Do any additional setup after loading the view.
    emailTxtField.delegate=self;
    confirmEmailTxtField.delegate=self;
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (emailTxtField.editing==YES)
    {
        emailTxtImg.image=[UIImage imageNamed:@"red_line"];
    }
    else
    {
        emailTxtImg.image=[UIImage imageNamed:@"grey_line-1"];
    }
    if(confirmEmailTxtField.editing==YES)
    {
        confirmEmailTxtImg.image=[UIImage imageNamed:@"red_line"];
    }
    else
    {
        confirmEmailTxtImg.image=[UIImage imageNamed:@"grey_line-1"];
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    emailTxtImg.image=[UIImage imageNamed:@"grey_line-1"];
    confirmEmailTxtImg.image=[UIImage imageNamed:@"grey_line-1"];
    
    //Email Validation..
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];

    //Valid email address
    
    if ([emailTest evaluateWithObject:textField.text] == YES)
    {
        //UIAlertView *emailAlert = [[UIAlertView alloc]initWithTitle:@"Email alert" message:@"Email is in proper formate" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        //[emailAlert show];
    }
    else
    {
        UIAlertView *emailAlert = [[UIAlertView alloc]initWithTitle:@"Messege" message:@"email not in proper format" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [emailAlert show];
    }
}


-(IBAction)sendBtnClicked:(id)sender
{
    
    if([emailTxtField.text isEqualToString:@""] || [confirmEmailTxtField.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"StoreOnGo" message:@"Please provide all mandatory fields" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
    else  if([confirmEmailTxtField.text isEqualToString:emailTxtField.text])
    {
//        UIAlertView *emailAlert = [[UIAlertView alloc]initWithTitle:@"Sucess" message:@"Sucessfully Sended. " delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        [emailAlert show];
        
        self.loadingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CXLoadingViewController"];
        [self.view addSubview:self.loadingViewController.view];
        
        [[DataServices serviceInstance] forgotPasswordForEmailId:emailTxtField.text rEmailId:confirmEmailTxtField.text mallId:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"MALL_ID"] finishblock:^(NSDictionary* response)
         {
             if([[response objectForKey:@"status"] intValue] == 1)
             {
                 NSString* msg = [response objectForKey:@"msg"];
                 if(!msg)
                 {
                     msg = [response objectForKey:@"result"];
                 }
                 
                 UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"StoreOnGo" message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                 [alert show];
                 [self.navigationController popToRootViewControllerAnimated:NO];
             }
             else if([[response objectForKey:@"status"] intValue] == -1)
             {
                 NSString* msg = [response objectForKey:@"msg"];
                 if(!msg)
                 {
                     msg = [response objectForKey:@"result"];
                 }
                 
                 UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"StoreOnGo" message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                 [alert show];
                 [self.loadingViewController.view removeFromSuperview];
                 self.loadingViewController = nil;
             }
         }];
    }
    else
    {
        UIAlertView *emailAlert = [[UIAlertView alloc]initWithTitle:@"Error!!!!" message:@"Emial and Confirm Email Value should be same" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [emailAlert show];
    }
}


-(IBAction)keyboardReturn:(id)sender
{
    
    [emailTxtField resignFirstResponder];
    [confirmEmailTxtField resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backButtonTapped
{
    emailTxtField.delegate = nil;
    confirmEmailTxtField.delegate = nil;
    [self.navigationController popViewControllerAnimated:YES];
}


-(NSString*)leftNavigationBarItemTitle
{
    return @"Forgot Password";
}

-(BOOL)shouldShowRightMenu
{
    return NO;
}


@end
