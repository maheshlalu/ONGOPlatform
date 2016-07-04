//
//  TestViewController.m
//  OnGO
//
//  Created by krish on 06/06/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "CXWebViewController.h"
#import "UIFont+OnGoFont.h"
#define HEADER_HEIGHT 50
#define TABLE_TOP_MARGIN 5

#define BTN_LEFT_MARGIN 5
#define BTN_TOP 10
#define BTN_WIDTH 30
#define BTN_HEIGHT 30

@interface CXWebViewController ()

@end

@implementation CXWebViewController

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
    [self customizeHeader];
   // self.title = self.headerString;
   // self.headerLabel.text = self.headerString;
   // self.leftBarTitle =
    
    
    
   // self.navController.navigationBarHidden = YES;
    //self.navController.titleLabel.text = @"";
   // self.leftNavigationBarItemTitle = self.headerString;
    
    
    
    
    NSLog(@"Web header string is %@",self.headerString);
    [self createWebView];
    
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


- (void)customizeHeader {
    UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, HEADER_HEIGHT)];
    headerView.userInteractionEnabled = YES;
    headerView.textAlignment = NSTextAlignmentCenter;
    headerView.font = [UIFont fontWithName:@"AlegreyaSans-Regular" size:12];
    headerView.text = self.headerString;
    headerView.textColor = [UIColor blackColor];
    headerView.backgroundColor = [UIColor colorWithRed:247.0f/255 green:247.0f/255 blue:247.0f/255 alpha:1.0f];

    [self.view addSubview:headerView];
    
    UIButton *cancelBtn = [self createButtonWithTitle:@"" withFrame:CGRectMake(BTN_LEFT_MARGIN, BTN_TOP, BTN_WIDTH, BTN_HEIGHT) withTag:1];
    [cancelBtn addTarget:self action:@selector(backButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:cancelBtn];
    
}

- (void)backButtonTapped{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}



- (UIButton *)createButtonWithTitle:(NSString *)title withFrame:(CGRect)frame withTag:(int)tag {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.tag = tag;
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"ic_actionbar_leftslide"] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:18]];
    return button;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    [self.navController setNavigationBarHidden:YES animated:YES];
//    self.navigationController.title = self.headerString;
}

- (void)createWebView{
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, HEADER_HEIGHT, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-HEADER_HEIGHT)];
    [self.view addSubview:self.webView];
    self.webView.scrollView.bounces = NO;

    
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
    return self.headerString;
}


@end
