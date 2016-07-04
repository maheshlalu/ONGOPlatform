//
//  TestViewController.h
//  OnGO
//
//  Created by krish on 06/06/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXViewController.h"

@interface CXSocialWebViewController : CXViewController
@property(strong, nonatomic) IBOutlet UIWebView* webView;
@property(strong, nonatomic) NSString* urlString;
@property(strong, nonatomic) NSString* contentString;
@property(assign,nonatomic) NSInteger pageIndex;
@property(strong,nonatomic) NSString* leftBarTitle;

@end
