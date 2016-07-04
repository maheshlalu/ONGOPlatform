//
//  TestViewController.m
//  OnGO
//
//  Created by krish on 06/06/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "CXSocialWebViewController.h"

@interface CXSocialWebViewController ()

@end

@implementation CXSocialWebViewController

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
    
    //self.urlString = @"http://www.apple.com";
    if(self.contentString)
    {
        [self loadContent:self.contentString];
    }
    else
    {
        [self loadUrlString];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loadContent:(NSString*)string
{
    [self.webView loadHTMLString:string baseURL:nil];
}


-(void)loadUrlString
{
    NSURLRequest* urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:120];
    
    [self.webView loadRequest:urlRequest];
}


-(void)setUrlString:(NSString *)urlString
{
    _urlString = urlString;
    
    [self loadUrlString];
}


-(NSString*)leftNavigationBarItemTitle
{
    return self.leftBarTitle;
}

-(void)backButtonTapped
{
    [(CCKFNavDrawer*)self.navigationController drawerToggle];
    [self.navigationController popViewControllerAnimated:YES];
}





@end
