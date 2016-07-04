//
//  TestViewController.m
//  OnGO
//
//  Created by krish on 06/06/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "CXPageViewController.h"

@implementation CXPageViewController

-(void)backButtonTapped
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(NSString*)leftNavigationBarItemTitle
{
    return self.leftNavigationItemName;
}
    
    

@end


