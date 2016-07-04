//
//  OnGoRatingBar.m
//  OnGO
//
//  Created by CreativeXpert pvt Ltd on 11/04/14.

#import "OnGoRatingBar.h"

@interface OnGoRatingBar()

@property(strong) NSMutableDictionary* ratingButtonsState;
@end

//define number of circle to show (and maximum rating user can give)
#define kNumberOfCircle 10
@implementation OnGoRatingBar

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _rating = 0.0f;
        
        self.ratingButtonsState = [NSMutableDictionary new];
        _offImage = [UIImage imageNamed:@"Grey.png"];
        
        imageArray=[[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"pink.png"],
                    [UIImage imageNamed:@"brown.png"],
                     [UIImage imageNamed:@"dark blue.png"],
                     [UIImage imageNamed:@"green v light.png"],
                     [UIImage imageNamed:@"green.png"],
                     [UIImage imageNamed:@"greenish blue.png"],
                     [UIImage imageNamed:@"light brown.png"],
                     [UIImage imageNamed:@"light green.png"],
                     [UIImage imageNamed:@"blue.png"],
                     [UIImage imageNamed:@"red.png"],nil];
        
        CGFloat spaceBetweenCircle = (frame.size.width - _offImage.size.width*kNumberOfCircle)/(kNumberOfCircle+1);
        _imageButtons = [[NSMutableArray alloc] initWithCapacity:kNumberOfCircle];
        for(NSInteger i=0; i<kNumberOfCircle; i++)
        {
            
            UIButton* imageButton = [[UIButton alloc] initWithFrame:CGRectMake((_offImage.size.width + spaceBetweenCircle)*i + spaceBetweenCircle,
                                                                                  (frame.size.height - _offImage.size.height)/2,
                                                                                  _offImage.size.width,
                                                                               _offImage.size.height)];
            
            
            [imageButton setImage:_offImage forState:UIControlStateNormal];
            [imageButton addTarget:self action:@selector(ratingButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:imageButton];
            [_imageButtons addObject:imageButton];
            
            [self.ratingButtonsState setObject:[NSNumber numberWithBool:NO] forKey:[NSString stringWithFormat:@"%d", i]];

        }
    }
    return self;
}


-(void)ratingButtonTapped:(id)sender
{
    [self clean];
    UIButton* tappedButton = (UIButton*)sender;
    int tappedIndex = [_imageButtons indexOfObject:tappedButton];
    
    BOOL tappedButtonPrevioiusState = [[self.ratingButtonsState objectForKey:[NSString stringWithFormat:@"%d", tappedIndex]] boolValue];
    
    _rating = 0;
    if(!tappedButtonPrevioiusState)
    {
        for(NSInteger i=0; i<=tappedIndex; i++)
        {
            _rating += 0.5;
            UIButton *imageButton = (UIButton *)[_imageButtons objectAtIndex:i];
            [imageButton setImage:[imageArray objectAtIndex:i] forState:UIControlStateNormal];
        }
        
        for(int index = 0; index < _imageButtons.count; ++index)
        {
            [self.ratingButtonsState setObject:[NSNumber numberWithBool:NO] forKey:[NSString stringWithFormat:@"%d", index]];
        }
        
        [self.ratingButtonsState setObject:[NSNumber numberWithBool:YES] forKey:[NSString stringWithFormat:@"%d", tappedIndex]];

    }
    else
    {
        for(int index = 0; index < _imageButtons.count; ++index)
        {
            [self.ratingButtonsState setObject:[NSNumber numberWithBool:NO] forKey:[NSString stringWithFormat:@"%d", index]];
        }
    }
    
    
    if(self.delegate)
    {
        [self.delegate ratingBar:self
                 didChangeRating:_rating];
    }

}

#pragma mark - Updating UI

- (void)clean
{
    for(NSInteger i=0; i<_imageButtons.count; i++)
    {
        UIButton *imageButton = (UIButton *)[_imageButtons objectAtIndex:i];
        [imageButton setImage:_offImage forState:UIControlStateNormal];
    }
}


@end

