//
//  UIFont+OnGoFont.m
//  OnGO
//
//  Created by Apple on 24/06/15.
//  Copyright (c) 2015 Aryan Ghassemi. All rights reserved.
//

#import "UIFont+OnGoFont.h"

@implementation UIFont (OnGoFont)

+ (UIFont*)selectingCellLableFont;
{
    return  [UIFont fontWithName:@"AlegreyaSans-Regular" size:15];
}

+ (UIFont*)selectingCellSubCategoryLabelFont;
{
    return  [UIFont fontWithName:@"AlegreyaSans-Regular" size:14];
}

+ (UIFont*)tabBarButtonTitle;
{
    return [UIFont fontWithName:@"Verdana-Bold" size:11];
}
+ (UIFont*)descriptionFont;{
    
    return  [UIFont fontWithName:@"AlegreyaSans-Regular" size:15];
}
+ (UIFont*)headerFont;{
    return  [UIFont fontWithName:@"AlegreyaSansSC-Bold" size:13];

}
+ (UIFont*)customeCellFont;{
    return  [UIFont fontWithName:@"AlegreyaSansSC-Bold" size:11];
    
}

+ (UIFont*)userNameFont;{
    return  [UIFont fontWithName:@"AlegreyaSans-Regular" size:14];

}
+ (UIFont*)commentPostDateFont;{
    return  [UIFont fontWithName:@"AlegreyaSans-Regular" size:12];

}
+ (UIFont*)userCommentFont;{
    return  [UIFont fontWithName:@"AlegreyaSans-Regular" size:12];

}

+ (UIFont*)headerBarFont;{
    return  [UIFont fontWithName:@"AlegreyaSansSC-Bold" size:17];
    
}
@end
