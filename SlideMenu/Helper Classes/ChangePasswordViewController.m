//
//  SignInViewController.m
//  OnGO
//
//  Created by Mentor Insight India pvt Ltd on 27/02/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "DataServices.h"
#import "CXLoadingViewController.h"

@interface ChangePasswordViewController ()
@property(nonatomic) IBOutlet UITextField *currentPaswdTField;
@property(nonatomic) IBOutlet UITextField *nwPaswdTField;
@property(nonatomic) IBOutlet UITextField *confirmPaswdTField;
@property(nonatomic) IBOutlet UIImageView *currentPaswdEditImgView;
@property(nonatomic) IBOutlet UIImageView *nwPaswdEditImgView;
@property(nonatomic) IBOutlet UIImageView *confirmPaswdEditImgView;
@property(nonatomic) IBOutlet UIButton *saveButton;
@property(nonatomic) NSMutableArray* tFieldsList;
@property(nonatomic) NSMutableArray* imageViewsList;
@property(nonatomic,strong) CXLoadingViewController *loadingViewController;

@end

@implementation ChangePasswordViewController

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
    _saveButton.layer.cornerRadius = 4.0f;
    
    _tFieldsList = [NSMutableArray new];
    [_tFieldsList addObject:_currentPaswdTField];
    [_tFieldsList addObject:_nwPaswdTField];
    [_tFieldsList addObject:_confirmPaswdTField];
    
    _imageViewsList = [NSMutableArray new];
    [_imageViewsList addObject:_currentPaswdEditImgView];
    [_imageViewsList addObject:_nwPaswdEditImgView];
    [_imageViewsList addObject:_confirmPaswdEditImgView];


}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{

    NSInteger index = [_tFieldsList indexOfObject:textField];
    UIImageView *imageView = _imageViewsList[index];
    imageView.image=[UIImage imageNamed:@"red_line"];

}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSInteger index = [_tFieldsList indexOfObject:textField];
    UIImageView *imageView = _imageViewsList[index];
    imageView.image=[UIImage imageNamed:@"grey_line-1"];

}



-(IBAction)changePassword:(id)sender
{
    self.loadingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CXLoadingViewController"];
    [self.view addSubview:self.loadingViewController.view];

    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    dict[@"emailId"] = [[NSUserDefaults standardUserDefaults] objectForKey:@"loggedinUserDetails"][@"emailId"];
    dict[@"currentPassword"] = _currentPaswdTField.text;
    dict[@"newPassword"] = _nwPaswdTField.text;
    dict[@"confirmPassword"] = _confirmPaswdTField.text;
    
    [[DataServices serviceInstance] changePassword:dict mallId:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"MALL_ID"]  finishblock:^(NSDictionary *response)
    {
        [self.loadingViewController.view removeFromSuperview];
        self.loadingViewController = nil;
        NSDictionary *dict = response[@"myHashMap"];

        if([dict[@"status"] integerValue] == 1)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Failed" message:dict[@"msg"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }];
}


-(IBAction)keyboardReturn:(id)sender
{
    UITextField *tField = (UITextField *)sender;
    [tField resignFirstResponder];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)leftBarTapped
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)shouldCustomizeLeftNavigationItem
{
    return YES;
}

-(NSString*)leftNavigationBarItemTitle
{
    return @"Change password";
}

@end
