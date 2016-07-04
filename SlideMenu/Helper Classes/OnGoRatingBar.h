//
//  OnGoRatingBar.h
//  OnGO
//
//  Created by CreativeXpert pvt Ltd on 11/04/14.

#import <UIKit/UIKit.h>

@class OnGoRatingBar;

@protocol OnGoRatingBarDelegate <NSObject>

- (void) ratingBar:(OnGoRatingBar *) ratingBar
   didChangeRating:(float) rating;

@end

@interface OnGoRatingBar : UIView
{
UIImage *_onImage;
UIImage *_offImage;
    NSMutableArray* imageArray;

float _rating;
    
NSMutableArray *_imageButtons;

}

@property (assign, nonatomic) id<OnGoRatingBarDelegate> delegate;

- (void)updateRating;
@end
