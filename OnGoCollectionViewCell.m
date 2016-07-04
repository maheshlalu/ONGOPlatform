//
//  OnGoCollectionViewCell.m
//  OnGO
//
//  Created by Apple on 21/09/15.
//  Copyright (c) 2015 Aryan Ghassemi. All rights reserved.
//

#import "OnGoCollectionViewCell.h"

@implementation OnGoCollectionViewCell

@synthesize cImageView;
@synthesize cLabel;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupImageView];
    }
    return self;
}

- (UIView *)lineViewWithFrame:(CGRect)lFrame {
    UIView *lineVw = [[UIView alloc] initWithFrame:lFrame];
    lineVw.backgroundColor = [UIColor grayColor];
    return lineVw;
}

- (void)setupImageView {
    self.cImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 3, self.frame.size.width-20, self.frame.size.height -20-15)];
    self.cImageView.autoresizingMask = UIViewAutoresizingNone;
    [self addSubview:self.cImageView];
    
    UIView *lView = [self lineViewWithFrame:CGRectMake(0, self.cImageView.frame.size.height+self.cImageView.frame.origin.y, self.frame.size.width, 1)];
    [self addSubview:lView];
    
    
    self.cLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,lView.frame.size.height+lView.frame.origin.y, self.frame.size.width, 25)];
    self.cLabel.font = [UIFont fontWithName:@"Verdana" size:13];
    //self.cLabel.backgroundColor = [UIColor blueColor];
    self.cLabel.textAlignment = NSTextAlignmentCenter;
    
//    CALayer* layer = [self.cLabel layer];
//    [self customizeLineBorderWithFrame:CGRectMake(0, layer.frame.origin.y, layer.frame.size.width, 1)];
//    [self customizeLineBorderWithFrame:CGRectMake(0, layer.frame.size.height+1, layer.frame.size.width, 1)];
    
    
    [self addSubview:self.cLabel];
    
    
    self.layer.cornerRadius = 4.0f;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1.0f;
    
}

- (void)customizeLineBorderWithFrame:(CGRect)lineFrame {
    CALayer* layer = [self.cLabel layer];
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.borderColor = [UIColor darkGrayColor].CGColor;
    bottomBorder.borderWidth = 1;
    bottomBorder.frame = lineFrame;
    [bottomBorder setBorderColor:[UIColor blackColor].CGColor];
    [layer addSublayer:bottomBorder];
}






@end
