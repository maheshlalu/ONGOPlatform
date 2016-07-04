//
//  ODNewsTableViewCell.h
//  OnGO
//
//  Created by Hanuman Kachwa on 23/01/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OGOdishaNewsJobs.h"

@interface ODNewsTableViewCell : UITableViewCell

@property (strong, nonatomic) OGOdishaNewsJobs *newsItem;

@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UILabel *newsSourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *newsDateLabel;
@property (weak, nonatomic) IBOutlet UIButton *newsCommentBtn;
@property (weak, nonatomic) IBOutlet UIButton *newsFavBtn;

@end
