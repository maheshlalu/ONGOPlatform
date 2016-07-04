//
//  TestViewController.m
//  OnGO
//
//  Created by krish on 06/06/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "CXKeyPageViewController.h"

@interface CXKeyPageViewController ()

@end

@implementation CXKeyPageViewController

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
    
    self.keyLabel.text = [self.keyData objectForKey:@"keyName"]?[self.keyData objectForKey:@"keyName"]:[self.keyData valueForKey:@"Name"];
    self.commentTextView.text = [self.keyData objectForKey:@"comment"]?[self.keyData objectForKey:@"comment"]:[self.keyData valueForKey:@"Description"];
    
    [self.commentTextView setEditable:NO];
    self.commentTextView.dataDetectorTypes = UIDataDetectorTypeLink;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSString*)leftNavigationBarItemTitle
{
    return @"Keys";
}



@end
