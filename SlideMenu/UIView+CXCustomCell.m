//
//  UIView+CXCustomCell.m
//  OnGO
//
//  Created by Apple on 02/07/15.
//  Copyright (c) 2015 Aryan Ghassemi. All rights reserved.
//

#import "UIView+CXCustomCell.h"
#import "UILabel+CXLabel.h"
@implementation UIView (CXCustomCell)

+ (UIView*)designCustomCellView:(CGRect)frame title:(NSString*)title webPageString:(NSString*)inHtmlString indexPath:(NSIndexPath*)inIndexPath;
{
    
    UIView *customCellView = [[UIView alloc]initWithFrame:frame];
    customCellView.layer.cornerRadius = 4.0f;
    customCellView.layer.borderColor = [UIColor clearColor].CGColor;
    customCellView.layer.borderWidth = 2.0f;
    
    
    [customCellView setBackgroundColor:[UIColor whiteColor]];
    //TitleLabel
    UILabel *titleLbl = [UILabel createCXCustomeHeaderLabel:CGRectMake(10, -5,customCellView.frame.size.width-100, 40) AndText:title];
    [customCellView addSubview:titleLbl];
    
    UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(titleLbl.frame.size.width+titleLbl.frame.origin.x+10,5,70, 30)];
    [moreBtn setTitle:@"More" forState:UIControlStateNormal];
    moreBtn.titleLabel.font = [UIFont fontWithName:@"AlegreyaSans-Regular" size:16];
    moreBtn.layer.cornerRadius = 8.0f;
    moreBtn.layer.borderWidth = 0.0f;
    moreBtn.tag = inIndexPath.row;
    [moreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [moreBtn setBackgroundColor:[UIColor colorWithRed:0/255.0f green:102/255.0f blue:51/255.0f alpha:1.0f]];
    [customCellView addSubview:moreBtn];
    [moreBtn addTarget:self action:@selector(viewMoreClicked:event:) forControlEvents:UIControlEventTouchUpInside];
    
    //Web View
   UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(titleLbl.frame.origin.x,40, customCellView.frame.size.width-titleLbl.frame.origin.x, customCellView.frame.size.height-50)];
    ;
    [webView loadHTMLString:[NSString stringWithFormat:@"<font face='AlegreyaSans-Regular'>%@", inHtmlString] baseURL:nil];
    
    [customCellView addSubview:webView];
    
    return customCellView;
}

@end
