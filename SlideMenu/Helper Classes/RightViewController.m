//
//  RightViewController.m
//  OnGO
//
//  Created by CreativeXpert pvt Ltd.  on 4/24/13.


#import "RightViewController.h"
#import "CXLoginManager.h"
#import "SignInViewController.h"
#import "ProfileViewController.h"

@implementation RightViewController




-(void)viewDidLoad
{
    self.logoutButton.layer.cornerRadius = 4;
    self.profileButton.layer.cornerRadius = 4;
    self.overLayView.layer.cornerRadius = 4;
    
}

-(void)viewDidAppear:(BOOL)animated
{
    if(![[CXLoginManager sharedManager] isLoggedIn])
    {
        self.logoutButton.hidden = YES;
    }
    else
    {
        self.logoutButton.hidden = NO;
    }

}


-(IBAction)profileTapped:(id)sender
{
    if([[CXLoginManager sharedManager] isLoggedIn])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CXUserProfileShowNotification" object:nil];
        [(CXViewController*)self.parentViewController removeRightViewController];
    }
    else
    {
        SignInViewController* signInViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
        [self.navigationController pushViewController:signInViewController animated:YES];
    }
    
}

-(IBAction)logoutTapped:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CXUserLoggedOutNotification" object:self];

    [(CXViewController*)self.parentViewController removeRightViewController];
}

-(void)dealloc
{
    
}

@end
