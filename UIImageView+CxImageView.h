//
//  UIImageView+CxImageView.h
//  OnGO
//
//  Created by Apple on 27/06/15.
//  Copyright (c) 2015 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (CxImageView)

+ (UIImageView*)createCxImageView:(CGRect)frame imageName:(NSString*)imageName;
@end
