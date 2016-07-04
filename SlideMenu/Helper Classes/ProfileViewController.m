//
//  SignInViewController.m
//  OnGO
//
//  Created by Mentor Insight India pvt Ltd on 27/02/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "ProfileViewController.h"
#import "DataServices.h"
#import "OnGoDownloadManager.h"
#import "CXResourceManager.h"
#import "EditProfileViewController.h"

@interface ProfileViewController ()
@property (nonatomic) IBOutlet UIImageView *profileImageView;
@property (nonatomic) IBOutlet UILabel *emailLabel;
@property (nonatomic) IBOutlet UILabel *fullNameLabel;
@property (nonatomic) IBOutlet UILabel *mobileLabel;
@property (nonatomic) IBOutlet UILabel *addressLabel;
@property (nonatomic) IBOutlet UILabel *cityLabel;
@property (nonatomic) IBOutlet UILabel *stateLabel;
@property (nonatomic) IBOutlet UILabel *countryLabel;
@property (nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;


@end

@implementation ProfileViewController
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(profilePictureChanged:) name:@"ProfilePictureDidChangeNotification" object:nil];
    
    _profileImageView.layer.cornerRadius = _profileImageView.frame.size.width/2.0f;
    _profileImageView.clipsToBounds = YES;
    
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"loggedinUserDetails"];
    
    UIImage *image = [[CXResourceManager sharedInstance] imageForPath:dict[@"userImagePath"]];
    if ([dict valueForKey:@"userImagePath"] != nil) {
    if(image)
    {
        _profileImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_profileImageView setImage:image];
        _activityIndicatorView.hidden = YES;
    }
    else
    {
        

        [_profileImageView setImage:[UIImage imageNamed:@"Default_Profile"]];
        [_activityIndicatorView stopAnimating];
        if(dict[@"userImagePath"])
        {
            [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:dict[@"userImagePath"]
                                                                          dataType:DATA_TYPE_BINARY finishBlock:^(OnGoDownloadData *downloadData){
                                                                              if (downloadData.downloadStatus == DOWNLOAD_STATUS_SUCCESS)
                                                                              {
                                                                                  UIImage *image = [UIImage imageWithData:downloadData.data];
                                                                                  if(image)
                                                                                  {
                                                                                      _profileImageView.contentMode = UIViewContentModeScaleAspectFit;
                                                                                      [_profileImageView setImage:image];
                                                                                      
                                                                                      [[CXResourceManager sharedInstance] setImage:image forPath:dict[@"userImagePath"]];
                                                                                      [_activityIndicatorView stopAnimating];
                                                                                  }
                                                                              }
                                                                              
                                                                          }];
        }

    }
}

    NSString *email = dict[@"emailId"];
    NSString *defaulValue = @":--";
    if(email && email.length > 0)
    {
        self.emailLabel.text =  [NSString stringWithFormat:@":%@", email];
    }
    else
    {
        self.emailLabel.text = defaulValue ;
    }
    
    NSString *fullName = dict[@"fullName"];
    if(fullName && fullName.length > 0)
    {
        self.fullNameLabel.text =  [NSString stringWithFormat:@":%@", fullName];
    }
    else
    {
        self.fullNameLabel.text = defaulValue ;
    }
    
    NSString *mobile = dict[@"mobile"];
    if(mobile && mobile.length > 0)
    {
        self.mobileLabel.text =  [NSString stringWithFormat:@":%@", mobile];
    }
    else
    {
        self.mobileLabel.text = defaulValue ;
    }
    
    NSString *address = dict[@"address"];
    if(address && address.length > 0)
    {
        self.addressLabel.text =  [NSString stringWithFormat:@":%@", address];
    }
    else
    {
        self.addressLabel.text = defaulValue ;
    }
    
    NSString *city = dict[@"city"];
    if(city && city.length > 0)
    {
        self.cityLabel.text =  [NSString stringWithFormat:@":%@", city];
    }
    else
    {
        self.cityLabel.text = defaulValue ;
    }

    NSString *state = dict[@"state"];
    if(state && state.length > 0)
    {
        self.stateLabel.text =  [NSString stringWithFormat:@":%@", state];
    }
    else
    {
        self.stateLabel.text = defaulValue ;
    }
    
    NSString *country = dict[@"country"];
    if(country && country.length > 0)
    {
        self.countryLabel.text =  [NSString stringWithFormat:@":%@", country];
    }
    else
    {
        self.countryLabel.text = defaulValue ;
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSString*)leftNavigationBarItemTitle
{
    return @"Profile";
}

-(void)profilePictureChanged:(id)sender
{
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"loggedinUserDetails"];
    
    UIImage *image = [[CXResourceManager sharedInstance] imageForPath:dict[@"userImagePath"]];
    if(image)
    {
        _profileImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_profileImageView setImage:image];
        _activityIndicatorView.hidden = YES;
    }
}

-(IBAction)editProfileTapped:(id)sender
{
    EditProfileViewController *editProfileViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EditProfileViewController"];
    [self.navController pushViewController:editProfileViewController animated:YES];

}

@end
