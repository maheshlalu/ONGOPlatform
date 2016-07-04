//
//  WriteReviewViewController.m
//  OnGO
//
//  Created by CreativeXpert pvt Ltd on 11/04/14.

#import "WriteReviewViewController.h"
#import "HomeViewController.h"
#import "CXLoginManager.h"


@interface WriteReviewViewController ()

@end

@implementation WriteReviewViewController
@synthesize ratingLbl,submitReviewBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
	// Do any additional setup after loading the view.
    
    
    _ratingBar = [[OnGoRatingBar alloc] initWithFrame:_ratingBarPlaceholder.frame];
    [self.view addSubview:_ratingBar];
    _ratingBar.delegate = self;

    ratingTxtView.delegate=self;
    ratingTxtView.layer.borderWidth = 1.0f;
    ratingTxtView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    placeholderText = @"write at least 50 characters";
    isPlaceholder = YES;
    ratingTxtView.text = placeholderText;
     ratingTxtView.textColor = [UIColor lightGrayColor];
    [ratingTxtView setSelectedRange:NSMakeRange(0, 0)];
    
    //NSString *str = [NSString stringWithFormat:@"%f", myFloat];
    strRating = [NSNumber numberWithFloat:ratingValue].stringValue;
    ratingLbl.text = strRating;
    
}

// keyboard return for Text View...
- (BOOL)textView:(UITextView *)txtView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if( [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound )
    {
         //[self adjustFrames];
         return YES;
     }
    
    [ratingTxtView resignFirstResponder];
    return NO;
}

//-(void) adjustFrames
//{
//    CGRect textFrame = ratingTxtView.frame;
//    ratingTxtView.frame.size.height = ratingTxtView.contentSize.height;
//    reviewTxt.frame = textFrame;
//}
- (void) textViewDidChange:(UITextView *)textView
{
    if(ratingTxtView.text.length == 0)
    {
        ratingTxtView.textColor = [UIColor lightGrayColor];
        ratingTxtView.text = placeholderText;
        [ratingTxtView setSelectedRange:NSMakeRange(0, 0)];
        isPlaceholder = YES;
        }
    else if(isPlaceholder && ![textView.text isEqualToString:placeholderText])
    {
        ratingTxtView.text = [textView.text substringToIndex:1];
        ratingTxtView.textColor = [UIColor blackColor];
        isPlaceholder = NO;
     }
      
}


#pragma mark - OnGoRatingBarDelegate

- (void) ratingBar:(OnGoRatingBar *) ratingBar
   didChangeRating:(float) rating
{
    ratingValue = rating;
    ratingLbl.text = [NSString stringWithFormat:@"%.1f", ratingValue];
}

             

-(IBAction)submitReviewBtnClicked:(id)sender{
    
    NSString *trimmedValue = [ratingTxtView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(trimmedValue.length <= 0 || [ratingTxtView.text isEqualToString:placeholderText])
        return;
    
    OnGoRating* ongoRating = [OnGoRating new];
    ongoRating.Description = ratingTxtView.text;
    ongoRating.UserRatingValue = ratingLbl.text;
    ongoRating.jobTypeId = self.jobTypeId;
    
    __block NSString *userId = nil;
    if(![[CXLoginManager sharedManager] isLoggedIn])
    {
        userId = [OGWorkSpace sharedWorkspace].mallInfo.guestUserId;
    }
    else
    {
        userId = [[CXLoginManager sharedManager] loggedInUserId];
    }
    
    if(!userId)
    {
        userId = @"16";
    }
    
    [[DataServices serviceInstance] postRating:ongoRating userId:userId];
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSString*)leftNavigationBarItemTitle
{    
    return self.productName;
}
    
//-(UIBarButtonItem*)leftNavigationBarItem
//{
//    SEL selector =  @selector(leftBarTapped);
//    
//    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 43)];
//    //customView.backgroundColor = [UIColor redColor];
//    
//    UIButton* menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 13, 24, 24)];
//    [menuButton setImage:[UIImage imageNamed:@"ic_actionbar_leftslide"] forState:UIControlStateNormal];
//    [menuButton addTarget:self
//                   action:selector forControlEvents:UIControlEventTouchDown];
//    [customView addSubview:menuButton];
//    
//    UIImageView* iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 4, 35, 35)];
//    iconImageView.image = [UIImage imageNamed:@"icon"];
//    [customView addSubview:iconImageView];
//    
//    
//    UILabel* titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(67, 15, 200, 20)];
//    titleLabel.text = self.productName;
//    [customView addSubview:titleLabel];
//    
//    
//    return [[UIBarButtonItem alloc]initWithCustomView:customView];
//    
//}
@end
