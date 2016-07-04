//
//  ODNewsTableViewCell.m
//  OnGO
//
//  Created by Hanuman Kachwa on 23/01/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

#import "ODNewsTableViewCell.h"
#import "WriteReviewViewController.h"
#import <ShareKit/ShareKit.h>

@interface ODNewsTableViewCell ()

- (IBAction)didTapNewsDownloadBtn:(id)sender;
- (IBAction)didTapNewsCommentBtn:(id)sender;
- (IBAction)didTapNewsFavBtn:(id)sender;
- (IBAction)didTapNewsShareBtn:(id)sender;

@end

@implementation ODNewsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didTapNewsDownloadBtn:(id)sender {
    
}

- (IBAction)didTapNewsCommentBtn:(id)sender {
    WriteReviewViewController* writeReviewViewController = [[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"WriteReviewViewController"];
    writeReviewViewController.productName = _newsItem.name;
    writeReviewViewController.jobTypeId = [NSString stringWithFormat:@"%f", _newsItem.jobsIdentifier];
    
    UITableView *tv = (UITableView *) self.superview.superview;
    UIViewController *vc = (UIViewController *) tv.dataSource;
    [vc.navigationController pushViewController:writeReviewViewController animated:YES];

}

- (void)setNewsItem:(OGOdishaNewsJobs *)newsItem {
    _newsItem = newsItem;
    
    
}

- (IBAction)didTapNewsFavBtn:(UIButton*)sender {
    sender.selected =! sender.selected;
    
    NSString *newsId = [NSString stringWithFormat:@"%f", _newsItem.jobsIdentifier];
    if (sender.selected) {
        [[[OGWorkSpace sharedWorkspace] savedPreferences] setValue:newsId forKey:newsId];
    }
    else {
        [[[OGWorkSpace sharedWorkspace] savedPreferences] removeObjectForKey:newsId];
    }
}

- (IBAction)didTapNewsShareBtn:(id)sender {
    // Create the item to share (in this example, a url)
    NSURL *url = [NSURL URLWithString:_newsItem.imageURL];
    
    UITableView *tv = (UITableView *) self.superview.superview;
    UIViewController *vc = (UIViewController *) tv.dataSource;

    SHKItem *item = [SHKItem URL:url title:_newsItem.jobsDescription contentType:SHKURLContentTypeWebpage];
    
    // ShareKit detects top view controller (the one intended to present ShareKit UI) automatically,
    // but sometimes it may not find one. To be safe, set it explicitly
    [SHK setRootViewController:vc];
    
    // Display the action sheet
    if (NSClassFromString(@"UIAlertController")) {
        
        //iOS 8+
        SHKAlertController *alertController = [SHKAlertController actionSheetForItem:item];
        [alertController setModalPresentationStyle:UIModalPresentationPopover];
        UIPopoverPresentationController *popPresenter = [alertController popoverPresentationController];
//        popPresenter.barButtonItem = self.toolbarItems[1];
        [vc presentViewController:alertController animated:YES completion:nil];
        
    } else {
        
        //deprecated
        SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
        [actionSheet showInView:vc.view];
    }
    
    //https://storeongo.com:9085/Services/createORGetJobInstance?email=vinodhapudari@gmail.com&orgId=3(mallId)&activityName=Register(SKYPE,WHATSAPP)&loyalty=true&ItemCodes=1403328294834_3;white13&trackOnlyOnce=false
    
//    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:@[_newsItem.jobsDescription] applicationActivities:nil];
//    [self presentViewController:controller animated:YES completion:nil];


   // self.activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[self.textField.text] applicationActivities:nil];

    
}
@end
