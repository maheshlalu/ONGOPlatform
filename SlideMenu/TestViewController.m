//
//  TestViewController.m
//  OnGO
//
//  Created by krish on 06/06/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "TestViewController.h"
//#import "RatingListViewController.h"
#import "CCKFNavDrawer.h"

@interface TestViewController ()
//@property(strong,nonatomic)RatingListViewController* ratingListViewController;
@property(nonatomic,strong) CCKFNavDrawer* navController;

@end

@implementation TestViewController

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
    
    self.navController = [self.storyboard instantiateViewControllerWithIdentifier: @"CCKFNavDrawer"];
    //[self.view addSubview:self.navController.view];
    self.view.backgroundColor = [UIColor redColor];

//    self.testView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//
//    self.ratingListViewController = [storyBoard instantiateViewControllerWithIdentifier:@"RatingListViewController"];
//    self.ratingListViewController.tabItemName = @"REVIEWS";
//    self.ratingListViewController.tabBGColor = [UIColor colorWithRed:243.0f/255 green:243.0f/255 blue:243.0f/255 alpha:1.0f];
//    
//    [self.testView addSubview:self.ratingListViewController.view];
//    self.ratingListViewController.view.frame = CGRectMake(0, 0, self.testView.frame.size.width, self.testView.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
