//
//  UIImageView+CxImageView.m
//  OnGO
//
//  Created by Apple on 27/06/15.
//  Copyright (c) 2015 Aryan Ghassemi. All rights reserved.
//

#import "UIImageView+CxImageView.h"

@implementation UIImageView (CxImageView)
+ (UIImageView*)createCxImageView:(CGRect)frame imageName:(NSString*)imageName {
    UIImageView*imageView = [[UIImageView alloc]initWithFrame:frame];
    [imageView setImage:[UIImage imageNamed:imageName]];
    return imageView;
}

@end
