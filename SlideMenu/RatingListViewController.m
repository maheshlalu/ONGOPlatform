//
//  RatingListViewController.m
//  OnGO
//
//  Created by krish on 18/05/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "RatingListViewController.h"
#import "WriteReviewViewController.h"
#import "DataServices.h"
#import "UIFont+OnGoFont.h"
#define DEFAULT_CELL_HEIGHT 67
#define DEFAULT_COMMENT_LABEL_HEIGHT 21

@interface RatingListViewController ()


@end

@implementation RatingListViewController
@synthesize tabItemName = mTabItemName;
@synthesize tabBGColor = mTabBGColor;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)updateOverallRating
{
    CGFloat total = 0;
    for(int index = 0; index < self.ratingList.count; ++index)
    {
        total += [[self.ratingList[index] UserRatingValue] floatValue];
    }
    if(self.ratingList.count > 0)
    {
        CGFloat t = (CGFloat)total/self.ratingList.count;
        self.overallRatingLabel.text = [NSString stringWithFormat:@"%.1f Overall rating", t];
    }
}

-(void)setRatingList:(NSMutableArray *)ratingList
{
    _ratingList = ratingList;
    if(self.ratingList.count > 0)
    {
        self.betheFirstStaticLabel.hidden = YES;
        self.ratingInfoTableView.hidden = NO;
    }
    else
    {
        self.betheFirstStaticLabel.hidden = NO;
        self.ratingInfoTableView.hidden = YES;
    }
    [self.ratingInfoTableView reloadData];
    [self updateOverallRating];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleReviewsDidChangeNotification:) name:@"ReviewsDidChangeNotification" object:[DataServices serviceInstance]];

    [self handleReviewsDidChangeNotification:nil];

    [self.ratingInfoTableView reloadData];
    [self updateOverallRating];

}

-(void)setJobTypeId:(NSString *)jobTypeId
{
    _jobTypeId = jobTypeId;
    [self handleReviewsDidChangeNotification:nil];
}

-(void)handleReviewsDidChangeNotification:(NSNotification*)notification
{
    [[OnGoDB dbInstance] getAllRatingForJobTypeId:self.jobTypeId  finishBlock:^(NSArray* ratingList)
     {
         self.ratingList = ratingList;
     }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)writeReviewButtonTapped:(id)sender
{
    WriteReviewViewController* writeReviewViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WriteReviewViewController"];
    writeReviewViewController.productName = self.productInfo.Name;
    writeReviewViewController.jobTypeId = self.jobTypeId;
    [self.navController pushViewController:writeReviewViewController animated:YES];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.ratingList.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"RatingCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    OnGoRating* ratingInfo = self.ratingList[indexPath.row];

    UILabel* userNameLabel = (UILabel*)[cell viewWithTag:1];
    userNameLabel.text = ratingInfo.userName;
    [userNameLabel setFont:[UIFont userNameFont]];
    
    UILabel* timeLabel = (UILabel*)[cell viewWithTag:4];
    timeLabel.text = ratingInfo.time;
    [timeLabel setFont:[UIFont commentPostDateFont]];


    UILabel* commentLabel = (UILabel*)[cell viewWithTag:2];
    commentLabel.text = ratingInfo.Description;
    [commentLabel setFont:[UIFont userCommentFont]];


    UILabel* ratingLabel = (UILabel*)[cell viewWithTag:3];
    ratingLabel.text = [NSString stringWithFormat:@"%.1f", [ratingInfo.UserRatingValue floatValue]];

    
    UIView* topSeparatorLineView = (UIView*)[cell viewWithTag:200];

    if(indexPath.row == 0)
    {
        topSeparatorLineView.hidden = NO;
    }
    else
    {
        topSeparatorLineView.hidden = YES;
    }
    
//    CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(1000, DEFAULT_COMMENT_LABEL_HEIGHT) lineBreakMode:NSLineBreakByTruncatingTail];
//    
//    if(size.height > DEFAULT_COMMENT_LABEL_HEIGHT)
//    {
//        commentLabel.frame = CGRectMake(commentLabel.frame.origin.x, commentLabel.frame.origin.y, commentLabel.frame.size.width, DEFAULT_CELL_HEIGHT + size.height - DEFAULT_COMMENT_LABEL_HEIGHT);
//    }
    
//    CGRect textRect = [str boundingRectWithSize:CGSizeMake(320, DEFAULT_COMMENT_LABEL_HEIGHT)
//                                        options:NSStringDrawingUsesLineFragmentOrigin
//                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f]}
//                                        context:nil];
//    
//    commentLabel.frame = textRect;


    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return DEFAULT_CELL_HEIGHT;
    
    
    NSString* str = self.ratingList[indexPath.row];
    
    
	UIFont *stringFont = [UIFont userCommentFont];
	NSDictionary *stringAttributes = [NSDictionary dictionaryWithObject:stringFont forKey:NSFontAttributeName];
	NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:str attributes:stringAttributes];
    
    
	CGSize size = [attrString size];
	return size.height;

//    
//    CGRect textRect = [str boundingRectWithSize:CGSizeMake(320, DEFAULT_COMMENT_LABEL_HEIGHT)
//                                         options:NSStringDrawingUsesLineFragmentOrigin
//                                      attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f]}
//                                         context:nil];
//    
//    return DEFAULT_CELL_HEIGHT + textRect.size.height - DEFAULT_COMMENT_LABEL_HEIGHT;
//
//    
//    CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(320, DEFAULT_COMMENT_LABEL_HEIGHT) lineBreakMode:NSLineBreakByTruncatingTail];
//    
//    if(size.height < DEFAULT_COMMENT_LABEL_HEIGHT)
//    {
//        return DEFAULT_CELL_HEIGHT;
//    }
//    
//    return DEFAULT_CELL_HEIGHT + size.height - DEFAULT_COMMENT_LABEL_HEIGHT;
}

@end
