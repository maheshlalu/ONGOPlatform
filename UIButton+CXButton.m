//
//  UIButton+CXButton.m
//  OnGO
//
//  Created by Apple on 27/06/15.
//  Copyright (c) 2015 Aryan Ghassemi. All rights reserved.
//

#import "UIButton+CXButton.h"

@implementation UIButton (CXButton)

+ (UIButton *)createSocialButtonWithFrame:(CGRect)frame withImage:(UIImage *)image withTag:(int)inTag {
    UIButton *cxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cxBtn setImage:image forState:UIControlStateNormal];
    cxBtn.frame = frame;
    return cxBtn;
}

@end
