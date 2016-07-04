//
//  Odisha360NewsDetailViewController.m
//  OnGO
//
//  Created by Hanuman Kachwa on 23/01/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

#import "Odisha360NewsDetailViewController.h"
#import "OGOdishaNewsJobs.h"
#import "UIImageView+AFNetworking.h"
#import <ShareKit/ShareKit.h>

@interface Odisha360NewsDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UILabel *newsPublishedDate;
@property (weak, nonatomic) IBOutlet UITextView *newsDescription;

- (IBAction)didTapFollowBtn:(id)sender;
- (IBAction)didTapShareBtn:(id)sender;

@end

@implementation Odisha360NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_isOdishaLanguage) {
        self.newsTitle.font = [UIFont fontWithName:@"AkrutiOriSarala06" size:self.newsTitle.font.pointSize];
        self.newsPublishedDate.font = [UIFont fontWithName:@"AkrutiOriSarala06" size:self.newsPublishedDate.font.pointSize];
        self.newsDescription.font = [UIFont fontWithName:@"AkrutiOriSarala06" size:self.newsDescription.font.pointSize];
        
        _newsItem.jobsDescription = [_newsItem.jobsDescription stringByAppendingString:[NSString stringWithFormat:@"<style>body{font-family: '%@'; font-size:%fpx;}</style>",
                                                                                        self.newsDescription.font.fontName,
                                                                                        self.newsDescription.font.pointSize]];

    }else{
       
        self.newsTitle.font = [UIFont fontWithName:@"Roboto-Regular" size:14.0f];
        self.newsPublishedDate.font = [UIFont fontWithName:@"Roboto-Regular" size:14.0f];
        self.newsDescription.font = [UIFont fontWithName:@"Roboto-Regular" size:13.0f];
        
        _newsItem.jobsDescription = [_newsItem.jobsDescription stringByAppendingString:[NSString stringWithFormat:@"<style>body{font-family: '%@'; font-size:%fpx;}</style>",
                                                                                        self.newsDescription.font.fontName,
                                                                                        self.newsDescription.font.pointSize]];
        

        
    }
    
    self.newsTitle.text = _newsItem.name;
    self.newsPublishedDate.text = _newsItem.date;

    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[_newsItem.jobsDescription dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.newsDescription.attributedText = attributedString;
    [self.newsImageView setImageWithURL:[NSURL URLWithString:_newsItem.imageURL] placeholderImage:[UIImage imageNamed:@"placeholder"]];
}

- (IBAction)didTapFollowBtn:(id)sender {
    NSString *newsId = [NSString stringWithFormat:@"%f", _newsItem.jobsIdentifier];
    [[[OGWorkSpace sharedWorkspace] savedPreferences] setValue:newsId forKey:newsId];

}

- (IBAction)didTapShareBtn:(id)sender {
    NSURL *url = [NSURL URLWithString:_newsItem.imageURL];

    SHKItem *item = [SHKItem URL:url title:_newsItem.jobsDescription contentType:SHKURLContentTypeWebpage];
    
    // ShareKit detects top view controller (the one intended to present ShareKit UI) automatically,
    // but sometimes it may not find one. To be safe, set it explicitly
    [SHK setRootViewController:self];
    
    // Display the action sheet
    if (NSClassFromString(@"UIAlertController")) {
        
        //iOS 8+
        SHKAlertController *alertController = [SHKAlertController actionSheetForItem:item];
        [alertController setModalPresentationStyle:UIModalPresentationPopover];
        UIPopoverPresentationController *popPresenter = [alertController popoverPresentationController];
        //        popPresenter.barButtonItem = self.toolbarItems[1];
        [self presentViewController:alertController animated:YES completion:nil];
        
    } else {
        
        //deprecated
        SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
        [actionSheet showInView:self.view];
    }
}


- (BOOL)mh_tabBarController:(MHTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController atIndex:(NSUInteger)index
{
    
    return YES;
}

- (void)mh_tabBarController:(MHTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController atIndex:(NSUInteger)index
{
    
    
}

-(void)backButtonTapped
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSString*)leftNavigationBarItemTitle
{
    return self.menuItem.Name;
}



@end
