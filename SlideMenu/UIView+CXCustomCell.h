//
//  UIView+CXCustomCell.h
//  OnGO
//
//  Created by Apple on 02/07/15.
//  Copyright (c) 2015 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CXCustomCell)

+ (UIView*)designCustomCellView:(CGRect)frame title:(NSString*)title webPageString:(NSString*)inHtmlString indexPath:(NSIndexPath*)inIndexPath;
@end

