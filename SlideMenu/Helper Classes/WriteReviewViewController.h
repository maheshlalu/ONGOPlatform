//
//  WriteReviewViewController.h
//  OnGO
//
//  Created by CreativeXpert pvt Ltd on 11/04/14.



#import <UIKit/UIKit.h>
#import "OnGoRatingBar.h"
#import "CXViewController.h"

@interface WriteReviewViewController : CXViewController<UITextViewDelegate,UIGestureRecognizerDelegate,OnGoRatingBarDelegate>{
    
    IBOutlet UILabel *ratingLbl;

    IBOutlet UITextView *ratingTxtView;
    NSString *placeholderText;
    BOOL isPlaceholder;
    NSString * strRating;
    float ratingValue;
    OnGoRatingBar *_ratingBar;
    IBOutlet UIView *_ratingBarPlaceholder;
    
}
-(IBAction)submitReviewBtnClicked:(id)sender;


@property (nonatomic, strong) IBOutlet UILabel* ratingLbl;
@property (nonatomic, strong) IBOutlet UIButton* submitReviewBtn;
@property(nonatomic,strong) NSString* productName;
@property(nonatomic,strong) NSString* jobTypeId;

@end
