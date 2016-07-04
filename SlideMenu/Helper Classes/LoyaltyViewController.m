//
//  SignInViewController.m
//  OnGO
//
//  Created by Mentor Insight India pvt Ltd on 27/02/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "LoyaltyViewController.h"
#import "DataServices.h"

@interface LoyaltyViewController ()

@end

@implementation LoyaltyViewController
@synthesize tabItemName = mTabItemName;
@synthesize tabBGColor = mTabBGColor;

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
    return @"Loyality";
}


-(IBAction)qrCodeTapped:(id)sender
{
    
}

-(IBAction)summaryTapped:(id)sender
{
    
}

-(IBAction)offersTapped:(id)sender
{
    
}


-(IBAction)campaignsTapped:(id)sender
{
    
}


@end
