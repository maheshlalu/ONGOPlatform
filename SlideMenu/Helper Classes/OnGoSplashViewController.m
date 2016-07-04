//
//  FortunaViewController.m
//  FortunaBoox
//
//  Created by Santhosh Kumar Sahukari on 15/12/13.
//  Copyright (c) 2013 Fortuna. All rights reserved.
//

#import "OnGoSplashViewController.h"
#define NUMBER_OF_SPLASH_IMAGES 1

@interface OnGoSplashViewController ()

@end

@implementation OnGoSplashViewController
@synthesize splashScreenImageView;


-(void)pointerAction:(id)sender
{
    NSLog(@"in pointerAction");
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setupSplashScreenAnimation];
    
    
//    CGRect rect = CGRectMake(0.0, 0.0, 100, 100);
//    
//    UIButton* pointerButton = [[UIButton alloc] initWithFrame:rect];
//    
//    [pointerButton setImage:[UIImage imageNamed:@"pointer"] forState:UIControlStateNormal];
//    
//    [pointerButton addTarget:self action:@selector(pointerAction:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.view addSubview:pointerButton];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*** Animate Splash Screen***/

-(void)setupSplashScreenAnimation
{
    [self.splashScreenImageView setUserInteractionEnabled:NO];
    [self.splashScreenImageView setImage:[UIImage imageNamed:@"splash"]];
//    NSMutableArray *splashScreenImages = [[NSMutableArray alloc] init];
//    
//    for(int index = 1; index < NUMBER_OF_SPLASH_IMAGES; index ++)
//    {
//        NSString *imageName = [NSString stringWithFormat:@"layer_%d",index];
//        [splashScreenImages addObject:[UIImage imageNamed:imageName]];
//    }
//    
//    [self.splashScreenImageView setAnimationImages:splashScreenImages];
//    [self.splashScreenImageView setAnimationDuration:10.0f];
//    [self.splashScreenImageView startAnimating];

}


@end
