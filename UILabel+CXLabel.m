//
//  UILabel+CXLabel.m
//  OnGO
//
//  Created by Apple on 27/06/15.
//  Copyright (c) 2015 Aryan Ghassemi. All rights reserved.
//

#import "UILabel+CXLabel.h"
#import "UIFont+OnGoFont.h"
@implementation UILabel (CXLabel)

+ (UILabel*)createCXDescriptionLabel:(CGRect)frame AndText:(NSString*)inText;{
    
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    [label setFont:[UIFont descriptionFont]];
    [label setNumberOfLines:0];
    [label setTextColor:[UIColor blackColor]];
    [label setText:inText];
    return label;
}
+ (UILabel*)createCXHeaderLabel:(CGRect)frame AndText:(NSString*)inText;{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    [label setFont:[UIFont headerFont]];
    [label setText:inText];
    return label;
}

+ (UILabel*)createCXCustomeHeaderLabel:(CGRect)frame AndText:(NSString*)inText;{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    [label setFont:[UIFont customeCellFont]];
    [label setText:inText];
    return label;
}
@end
