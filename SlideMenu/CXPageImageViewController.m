//
//  TestViewController.m
//  OnGO
//
//  Created by krish on 06/06/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "CXPageImageViewController.h"
#import "CXResourceManager.h"
#import "OnGoDownloadManager.h"
#import "OnGoDownloadData.h"

@interface CXPageImageViewController ()

@end

@implementation CXPageImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadImage
{
    UIImage *image = [[CXResourceManager sharedInstance] imageForPath:self.urlString];
    
    if(!image)
    {
        [activityView startAnimating];
        [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:self.urlString
                                                                      dataType:DATA_TYPE_BINARY finishBlock:^(OnGoDownloadData *downloadData){
                                                                          if (downloadData.downloadStatus == DOWNLOAD_STATUS_SUCCESS)
                                                                          {
                                                                              UIImage *image = [UIImage imageWithData:downloadData.data];
                                                                              if(image)
                                                                              {
                                                                                  [activityView stopAnimating];
                                                                                  activityView.hidden = YES;
                                                                                  
                                                                                  
                                                                                  imageView.contentMode = UIViewContentModeScaleAspectFit;
                                                                                  [imageView setImage:image];
                                                                                  
                                                                                  [[CXResourceManager sharedInstance] setImage:image forPath:self.urlString];
                                                                                  
                                                                              }
                                                                          }
                                                                          else
                                                                          {
                                                                              activityView.hidden = YES;
                                                                              [imageView setImage:[UIImage imageNamed:@"shadow_home"]];
                                                                              
                                                                          }
                                                                          
                                                                      }];
        
    }
    else
    {
        [imageView setImage:image];
        activityView.hidden = YES;
    }
}

-(void)setUrlString:(NSString *)urlString
{
    _urlString = urlString;
    [self loadImage];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
