//
//  UIButton+CXButton.h
//  OnGO
//
//  Created by Apple on 27/06/15.
//  Copyright (c) 2015 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CXButton)

+ (UIButton *)createSocialButtonWithFrame:(CGRect)frame withImage:(UIImage *)image withTag:(int)inTag;

@end
