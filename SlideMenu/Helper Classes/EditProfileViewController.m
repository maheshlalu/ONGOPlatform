//
//  SignInViewController.m
//  OnGO
//
//  Created by Mentor Insight India pvt Ltd on 27/02/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "EditProfileViewController.h"
#import "DataServices.h"
#import "CXResourceManager.h"
#import "OnGoDownloadManager.h"
#import "OnGoAppDelegate.h"
#import "CCKFNavDrawer.h"
#import "ChangePasswordViewController.h"
#import "JSONKit.h"
#import "CXLoadingViewController.h"

@interface EditProfileViewController ()
@property(nonatomic) IBOutlet UIImageView *profileImageView;

@property(nonatomic) IBOutlet UITextField *firstNameTField;
@property(nonatomic) IBOutlet UITextField *lastNameTField;
@property(nonatomic) IBOutlet UITextField *emailTxtField;
@property(nonatomic) IBOutlet UITextField *mobileTxtField;
@property(nonatomic) IBOutlet UITextField *addressTxtField;
@property(nonatomic) IBOutlet UITextField *cityTxtField;
@property(nonatomic) IBOutlet UITextField *stateTxtField;
@property(nonatomic) IBOutlet UITextField *countryTxtField;

@property(nonatomic) IBOutlet UIImageView *firstNameEditImgView;
@property(nonatomic) IBOutlet UIImageView *lastNameEditImgView;
@property(nonatomic) IBOutlet UIImageView *emailEditImgView;
@property(nonatomic) IBOutlet UIImageView *mobileEditImgView;
@property(nonatomic) IBOutlet UIImageView *addressEditImgView;
@property(nonatomic) IBOutlet UIImageView *cityEditImgView;
@property(nonatomic) IBOutlet UIImageView *stateEditImgView;
@property(nonatomic) IBOutlet UIImageView *countryEditImgView;

@property(nonatomic) IBOutlet UIButton *changePictureButton;
@property(nonatomic) IBOutlet UIButton *changePasswordButton;
@property(nonatomic) IBOutlet UIButton *saveChangesButton;

@property(nonatomic) NSMutableArray* tFieldsList;
@property(nonatomic) NSMutableArray* imageViewsList;
@property(nonatomic,strong) CXLoadingViewController *loadingViewController;

@end

@implementation EditProfileViewController
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
    
    _tFieldsList = [NSMutableArray new];
    [_tFieldsList addObject:_firstNameTField];
    [_tFieldsList addObject:_lastNameTField];
    [_tFieldsList addObject:_emailTxtField];
    [_tFieldsList addObject:_mobileTxtField];
    [_tFieldsList addObject:_addressTxtField];
    [_tFieldsList addObject:_cityTxtField];
    [_tFieldsList addObject:_stateTxtField];
    [_tFieldsList addObject:_countryTxtField];

    _imageViewsList = [NSMutableArray new];
    [_imageViewsList addObject:_firstNameEditImgView];
    [_imageViewsList addObject:_lastNameEditImgView];
    [_imageViewsList addObject:_emailEditImgView];
    [_imageViewsList addObject:_mobileEditImgView];
    [_imageViewsList addObject:_addressEditImgView];
    [_imageViewsList addObject:_cityEditImgView];
    [_imageViewsList addObject:_stateEditImgView];
    [_imageViewsList addObject:_countryEditImgView];

    
    _profileImageView.layer.cornerRadius = _profileImageView.frame.size.width/2.0f;
    _profileImageView.clipsToBounds = YES;
    
    _changePasswordButton.layer.cornerRadius = 4.0f;
    _changePictureButton.layer.cornerRadius = 4.0f;
    _saveChangesButton.layer.cornerRadius = 4.0f;
    
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"loggedinUserDetails"];
    
    UIImage *image = [[CXResourceManager sharedInstance] imageForPath:dict[@"userImagePath"]];
    if(image)
    {
        _profileImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_profileImageView setImage:image];
    }
    else
    {
        [_profileImageView setImage:[UIImage imageNamed:@"Default_Profile"]];
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
                                                                                      
                                                                                  }
                                                                              }
                                                                              
                                                                          }];
        }
    }

    _firstNameTField.text = dict[@"firstName"];
    _lastNameTField.text = dict[@"lastName"];
    _addressTxtField.text = dict[@"address"];
    _mobileTxtField.text = dict[@"mobile"];
    _emailTxtField.text = dict[@"emailId"];
    _cityTxtField.text = dict[@"city"];
    _stateTxtField.text = dict[@"state"];
    _countryTxtField.text = dict[@"country"];

}

-(void)dealloc
{
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSInteger index = [_tFieldsList indexOfObject:textField];
    UIImageView *imageView = _imageViewsList[index];
    imageView.image=[UIImage imageNamed:@"red_line"];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSInteger index = [_tFieldsList indexOfObject:textField];
    UIImageView *imageView = _imageViewsList[index];
    imageView.image=[UIImage imageNamed:@"grey_line-1"];
}




-(IBAction)keyboardReturn:(id)sender
{
    UITextField *tField = (UITextField *)sender;
    [tField resignFirstResponder];

}


-(IBAction)changePictureTapped:(id)sender
{
    UIImagePickerController *imagePicker = [UIImagePickerController new];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void)uploadPictureData:(NSData *)data
{
    if (data) {
        NSString *fileName = [NSString stringWithFormat:@"serverFileName_%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"loggedinUserDetails"][@"UserId"]];

        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSString *imagePostUrl = @"http://exapplor.com:8081/Services/uploadFileFromAndroidToServer";
        NSDictionary *parameters = @{@"refFileName": fileName};
        
        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:imagePostUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileData:data name:@"srcFile" fileName:@"uploadedFile.jpg" mimeType:@"image/jpeg"];
        }];
        
        AFHTTPRequestOperation *op = [manager HTTPRequestOperationWithRequest:request success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response: %@", responseObject);
            __weak typeof(self) welf = self;
            
            [welf.loadingViewController.view removeFromSuperview];
            welf.loadingViewController = nil;
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
            NSLog(@"response: %@",dict);
            
            if([dict[@"status"] intValue] == 0)
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Failed" message:@"Unable to upload profile picture" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                [alert show];
            }
            else
            {
                NSString *remoteImagePath = dict[@"filePath"];
                if(remoteImagePath)
                {
                    UIImage *image = [UIImage imageWithData:data];
                    [[CXResourceManager sharedInstance] setImage:image forPath:remoteImagePath];
                    _profileImageView.image = image;
                    
                    NSMutableDictionary *mutDict = [[[NSUserDefaults standardUserDefaults] objectForKey:@"loggedinUserDetails"] mutableCopy];
                    mutDict[@"userImagePath"] = remoteImagePath;
                    [[NSUserDefaults standardUserDefaults] setObject:mutDict forKey:@"loggedinUserDetails"];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"ProfilePictureDidChangeNotification" object:nil];
                    
                    [[DataServices serviceInstance]  updateProfile:mutDict mallId:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"MALL_ID"]  finishblock:^(NSDictionary *response)
                     {
                     }];
                    
                }
            }

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            __weak typeof(self) welf = self;
            
            [welf.loadingViewController.view removeFromSuperview];
            welf.loadingViewController = nil;
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Failed" message:@"Unable to upload profile picture" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];

        }];
        op.responseSerializer = [AFHTTPResponseSerializer serializer];
        [[NSOperationQueue mainQueue] addOperation:op];
    }
}

-(void)uploadPicture_without_ASILibrary
{
    UIImage *image = [UIImage imageNamed:@"Default_Profile"];
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    
    
    NSString* urlString = [NSString stringWithFormat:@"http://exapplor.com:8081/Services/uploadFileFromAndroidToServer"];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    
    
    
    NSString *charset = (NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    NSMutableData *body = [NSMutableData data];
    
    // We don't bother to check if post data contains the boundary, since it's pretty unlikely that it does.
    CFUUIDRef uuid = CFUUIDCreate(nil);
    NSString *uuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuid)) ;
    CFRelease(uuid);
    NSString *stringBoundary = [NSString stringWithFormat:@"0xKhTmLbOuNdArY-%@",uuidString];
    
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; charset=%@; boundary=%@", charset, stringBoundary] forHTTPHeaderField:@"Content-Type"];
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n",stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    // Adds post data
    NSString *endItemBoundary = [NSString stringWithFormat:@"\r\n--%@\r\n",stringBoundary];
    
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"refFileName"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"serverFileName_555" dataUsingEncoding:NSUTF8StringEncoding ]];
    [body appendData:[endItemBoundary dataUsingEncoding:NSUTF8StringEncoding ]];
    
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", @"srcFile", @"srcFile.jpg"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n", @"application/octet-stream"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:data];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",stringBoundary]dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [request setHTTPBody:body];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* connectionError)
     {
         NSLog(@"response:%@",[NSString stringWithFormat:@"%s",(char*)[data bytes]]);
     }];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    self.loadingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CXLoadingViewController"];
    [self.view addSubview:self.loadingViewController.view];


    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        __weak typeof(self) welf = self;
         [welf uploadPictureData:data];

    });
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)changePasswordTapped:(id)sender
{
    OnGoAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    CCKFNavDrawer *navController = appDelegate.navController;
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:[[NSBundle mainBundle].infoDictionary objectForKey:@"UIMainStoryboardFile"]
                                                         bundle:[NSBundle mainBundle]];
    
    ChangePasswordViewController *changePasswordViewController = [storyBoard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
    
    [navController pushViewController:changePasswordViewController animated:YES];
    
}

-(IBAction)saveChangesTapped:(id)sender
{
    self.loadingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CXLoadingViewController"];
    [self.view addSubview:self.loadingViewController.view];

    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    dict[@"emailId"] = _emailTxtField.text;
    dict[@"firstName"] = _firstNameTField.text;
    dict[@"lastName"] = _lastNameTField.text;
    dict[@"address"] = _addressTxtField.text;
    dict[@"mobile"] = _mobileTxtField.text;
    dict[@"city"] = _cityTxtField.text;
    dict[@"state"] = _stateTxtField.text;
    dict[@"country"] = _countryTxtField.text;
    dict[@"userImagePath"] = [[NSUserDefaults standardUserDefaults] objectForKey:@"loggedinUserDetails"][@"userImagePath"];
    dict[@"userBannerPath"] = [[NSUserDefaults standardUserDefaults] objectForKey:@"loggedinUserDetails"][@"userBannerPath"];

    [[DataServices serviceInstance]  updateProfile:dict mallId:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"MALL_ID"]  finishblock:^(NSDictionary *response)
     {
         [self.loadingViewController.view removeFromSuperview];
         self.loadingViewController = nil;
     }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)leftBarTapped
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)shouldCustomizeLeftNavigationItem
{
    return YES;
}

-(NSString*)leftNavigationBarItemTitle
{
    return @"Edit Profile";
}

@end
