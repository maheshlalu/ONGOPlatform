//
//  UILabel+CXLabel.h
//  OnGO
//
//  Created by Apple on 27/06/15.
//  Copyright (c) 2015 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (CXLabel)

+ (UILabel*)createCXDescriptionLabel:(CGRect)frame AndText:(NSString*)inText;
+ (UILabel*)createCXHeaderLabel:(CGRect)frame AndText:(NSString*)inText;
+ (UILabel*)createCXCustomeHeaderLabel:(CGRect)frame AndText:(NSString*)inText;

@end
