//
//  StoreInfoViewController.m
//  OnGO
//
//  Created by krish on 18/05/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "StoreInfoViewController.h"
#import "JSONKit.h"
#import "LocationList.h"
#import "CXResourceManager.h"
#import "OnGoDownloadManager.h"
#import "CXWebViewController.h"
#import "MapViewController.h"
#import "CXPageImageViewController.h"
#import "CXWebViewController.h"
#import "CXPageViewController.h"
#import "CXSocialWebViewController.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "UIImageView+CxImageView.h"
#import "UIButton+CXButton.h"
#import "DejalActivityView.h"
#import "OnGoCollectionViewCell.h"
#import "OGStores.h"

#define CALL_TAG 20
#define MSG_TAG 21
#define FB_TAG 22
#define TWITTER_TAG 23

@interface StoreInfoViewController ()<KIImagePagerDelegate, KIImagePagerDataSource>{

}
@property(nonatomic,strong) UIPageViewController* pageViewController;
@property(nonatomic,strong) NSMutableArray* galleryImageVCList;
@property(strong, nonatomic)NSTimer* timer;
@property(nonatomic) NSInteger pageCurrentIndex;
@property(nonatomic) OnGoStores *selectedStore;
@property(nonatomic) NSMutableArray *imageUrlsList;;
@property(nonatomic) NSDictionary *customHtmlsDict;;
@property(nonatomic) NSMutableArray *customHtmlWebViewControllers;
@property(nonatomic) NSMutableDictionary* groupsDict;
//@property (strong, nonatomic) IBOutlet GADBannerView *bannerView;
@property (nonatomic,strong) NSMutableArray *featureProducts;
@property (nonatomic,strong) NSMutableArray *featureProductJobs;

@property (nonatomic,strong) NSMutableArray *featureProductsJobs1;
@property (nonatomic,strong) NSMutableArray *featureProductsJobs2;


@end

@implementation StoreInfoViewController
@synthesize tabItemName = mTabItemName;
@synthesize tabBGColor = mTabBGColor;
@synthesize coverImageList;
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
    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Loading..."];
    
    self.featureProductJobs = [[NSMutableArray alloc]init];
    self.featureProducts = [[NSMutableArray alloc]init];
    self.featureProductsJobs2 = [[NSMutableArray alloc]init];
    self.featureProductsJobs1 = [[NSMutableArray alloc]init];

    
    self.groupsDict = [NSMutableDictionary new];
    
   /* self.bannerView.adUnitID = @"ca-app-pub-2961740639249418/1063635481";
    self.bannerView.rootViewController = self;
    
    GADRequest *request = [GADRequest request];
    // Enable test ads on simulators.
    request.testDevices = @[ GAD_SIMULATOR_ID ];
    [self.bannerView loadRequest:request];*/

    
//    [self.callusButton.layer setBorderWidth:1.0f];
//    [self.smsButton.layer setBorderWidth:1.0f];
//
//    self.callusButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.smsButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    
//    self.mainImgView.contentMode = UIViewContentModeScaleToFill;
    
    [[DataServices serviceInstance] getAllStoreCategoriesForMallId:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"MALL_ID"] block:^(NSArray* storeCatList)
     {
         self.storeCategorieList = storeCatList;
     }];

    
//    self.infoView.layer.cornerRadius = 4.0f;
//    self.addressView.layer.cornerRadius = 4.0f;
//    self.contactView.layer.cornerRadius = 4.0f;
//    
//    
//    [self.activityView startAnimating];
    
    [[DataServices serviceInstance] getAllStoresOfType:@"Stores" mallId:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"MALL_ID"] finishblock:^(NSArray* allStores){
        if(allStores.count > 0)
        {
            for(OnGoStores* store in allStores)
            {
                if([OGWorkSpace sharedWorkspace].orgInfo.defaultStoreId == [store.id intValue])
                {
                    //[self updateImageGalleryForStore:store];
                    self.homeViewController.selectedStore = store;
                    self.selectedStore = store;
                    
                    [self updateSelectedStoreImageList];
                    [self.tableView reloadData];

                    break;
                }
            }
            
            
            if(allStores.count <= 1)
            {
                //self.locationBtn.hidden = YES;
            }
        }
        self.storeList = allStores;
    }];
    
    
    [[DataServices serviceInstance] getAllCustomHtmls:@"Custom" mallId:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"MALL_ID"] block:^(NSDictionary* customHtmls) {
        self.customHtmlsDict = customHtmls;
        [self.tableView reloadData];
    }];

    
    NSArray* widgets = [[OGWorkSpace sharedWorkspace] getAllWidgetsForWidgetType:@"native"];
    
    for (OGWidgets *widget in widgets) {
        if([widget.name isEqualToString:@"Google Ads"] )
        {
            //self.bannerView.hidden = ![dict[@"Visibility"] boolValue];
            break;
        }
    }

    self.tableView.backgroundColor = [UIColor colorWithRed:237.0f/255.0f green:237.0f/255.0f blue:237.0f/255.0f alpha:1.0f];
    [self getTheFeatureProducts];
    //[self populdateStore];
}


- (void)getTheFeatureProducts{
    
    [[DataServices serviceInstance] getFeatureProduct:@"" block:^(NSArray *list) {
        
       // NSLog(@"feature products %@",list);
        self.featureProducts = (NSMutableArray*)list;
        [self getFeatureProductJobs];
    }];
    [DejalBezelActivityView removeView];

    
}

- (void)getFeatureProductJobs{
    
    DataBaseManager *manager =  [DataBaseManager dataBaseManager];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    BOOL success = [manager execute:@"SELECT *FROM FEATURE_PRODUCTS_JOBS" resultsArray:array];
    if (success) {
    }
    self.featureProductJobs = (NSMutableArray*)array;
   // NSLog(@"feature prduct jobs %@",array);
    
    [DejalBezelActivityView removeView];
    [self.tableView reloadData];


}




- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(IBAction)locationBtnClicked:(id)sender
{
    LocationList* locationList = [self.storyboard instantiateViewControllerWithIdentifier:@"LocationList"];
    locationList.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    locationList.modalPresentationStyle = UIModalPresentationCurrentContext;
    locationList.storeList = self.storeList;
    locationList.delegate = self;
    

    [self.navController pushViewController:locationList animated:YES];
    
}

#pragma mark LocationListDelegate methods
-(void)locationList:(LocationList*)locationList didSelectStore:(OnGoStores*)store
{
    [self.navController    popViewControllerAnimated:YES];
    [self populateStoreDataWithStore:store];
    self.homeViewController.selectedStore = store;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)populdateStore
{
//    self.infoViewLabel1.text = self.storeData.Name;
//    self.infoViewLabel2.text = [[self.storeData.json objectFromJSONString] objectForKey:@"Description"];
//    
//    self.addressViewLabel1.text = @"Address";
//    self.addressViewLabel2.text = [[self.storeData.json objectFromJSONString] objectForKey:@"Address"];
    
}

-(void)setStoreData:(OnGoStores *)storeData
{
    _storeData = storeData;
    [self populdateStore];
}

-(void)populateStoreDataWithStore:(OnGoStores*)store
{
    self.storeData = store;
}

-(void)updateSelectedStoreImageList
{
    NSMutableArray* imageUrlsList = [NSMutableArray new];
    self.coverImageList = [NSMutableArray new];
    
    NSString* imageUrl = [[self.selectedStore.json objectFromJSONString] objectForKey:@"Image_URL"];
    
    if(imageUrl)
    {
        [imageUrlsList addObject:imageUrl];
    }
    
    NSArray* attachments = [[self.selectedStore.json objectFromJSONString] objectForKey:@"Attachments"];
    for(NSDictionary* dict in attachments)
    {
        //NSInteger mediaType = [[dict objectForKey:@"mmType"] intValue];
        //if(mediaType == 0)
        {
            imageUrl = [dict objectForKey:@"URL"];
            if(imageUrl)
            {
                //safe check whether its a image url or not
                NSArray* components = [imageUrl componentsSeparatedByString:@".png"];
                if(components.count > 1)
                {
                    [imageUrlsList addObject:imageUrl];
                }
                else
                {
                    components = [imageUrl componentsSeparatedByString:@".jpeg"];
                    if(components.count > 1)
                    {
                        [imageUrlsList addObject:imageUrl];
                    }
                    else
                    {
                        components = [imageUrl componentsSeparatedByString:@".jpg"];
                        if(components.count > 1)
                        {
                            [imageUrlsList addObject:imageUrl];
                        }
                    }
                }
            }
        }
        if ([[dict valueForKey:@"isCoverImage"] boolValue]) {
            [self.coverImageList addObject:[dict objectForKey:@"URL"]];
        }
    }
    self.imageUrlsList = imageUrlsList;
}


-(void)updateImageGalleryForStore:(OnGoStores*)store
{
    //self.activityView.hidden = YES;
    [self.pageViewController.view removeFromSuperview];
    NSDictionary* dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:UIPageViewControllerSpineLocationMid] forKey:UIPageViewControllerOptionSpineLocationKey];

    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:dict];

    self.galleryImageVCList = [NSMutableArray new];
    
    NSMutableArray* imageUrlsList = [NSMutableArray new];
    
    NSString* imageUrl = [[store.json objectFromJSONString] objectForKey:@"Image_URL"];
    
    if(imageUrl)
    {
        [imageUrlsList addObject:imageUrl];
    }
    
    NSArray* attachments = [[store.json objectFromJSONString] objectForKey:@"Attachments"];
    for(NSDictionary* dict in attachments)
    {
        //NSInteger mediaType = [[dict objectForKey:@"mmType"] intValue];
        //if(mediaType == 0)
        {
            imageUrl = [dict objectForKey:@"URL"];
            if(imageUrl)
            {
                //safe check whether its a image url or not
                NSArray* components = [imageUrl componentsSeparatedByString:@".png"];
                if(components.count > 1)
                {
                    [imageUrlsList addObject:imageUrl];
                }
                else
                {
                    components = [imageUrl componentsSeparatedByString:@".jpeg"];
                    if(components.count > 1)
                    {
                        [imageUrlsList addObject:imageUrl];
                    }
                    else
                    {
                        components = [imageUrl componentsSeparatedByString:@".jpg"];
                        if(components.count > 1)
                        {
                            [imageUrlsList addObject:imageUrl];
                        }
                    }
                }
            }
        }
    }
    
    
    
    for(int index = 0; index < imageUrlsList.count; ++index)
    {
        CXPageImageViewController* viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CXPageImageViewController"];
        [self.galleryImageVCList addObject:viewController];
        viewController.pageIndex = index;
        viewController.urlString = imageUrlsList[index];
    }
    
    if(self.galleryImageVCList.count == 0)
    {
        CXPageImageViewController* viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CXPageImageViewController"];
        [self.galleryImageVCList addObject:viewController];
        viewController.pageIndex = 0;
        viewController.urlString = @"placeholderimage";
    }
    
    [self.pageViewController setViewControllers:@[self.galleryImageVCList[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished)
     {
         
     }];
    
    self.pageViewController.doubleSided = NO;
    self.pageViewController.dataSource = self;
    
    [self.timer invalidate];
    self.timer = [NSTimer timerWithTimeInterval:2.0
                                         target:self
                                       selector:@selector(timeFireAction:)
                                       userInfo:nil
                                        repeats:YES];
    NSRunLoop *runner = [NSRunLoop currentRunLoop];
    [runner addTimer:self.timer forMode: NSDefaultRunLoopMode];
}

-(void)timeFireAction:(id)sender
{
    self.pageCurrentIndex++;
    if(self.pageCurrentIndex >= self.galleryImageVCList.count)
    {
        self.pageCurrentIndex = 0;
    }
    [self.pageViewController setViewControllers:@[self.galleryImageVCList[self.pageCurrentIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished)
     {
         
     }];
}
//- (UIViewController *)pageViewController:(UIPageViewController *)pvc viewControllerBeforeViewController:(UIViewController *)vc
//{
//    CXPageImageViewController* pVC = (CXPageImageViewController*)vc;
//    if(pVC.pageIndex == 0)
//        return nil;
//    return self.galleryImageVCList[pVC.pageIndex-1];
//}
//
//- (UIViewController *)pageViewController:(UIPageViewController *)pvc viewControllerAfterViewController:(UIViewController *)vc
//{
//    CXPageImageViewController* pVC = (CXPageImageViewController*)vc;
//    if(pVC.pageIndex < self.galleryImageVCList.count-1)
//        return  self.galleryImageVCList[pVC.pageIndex+1];
//    return nil;
//}

-(IBAction)callUsBtnClicked:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", [OGWorkSpace sharedWorkspace].orgInfo.mobile]]];
}

-(IBAction)smsBtnClicked:(id)sender
{
    MFMessageComposeViewController* messageComposeViewController = [MFMessageComposeViewController new];
    if(messageComposeViewController)// will work on real device only, but not simulator
    {
        messageComposeViewController.messageComposeDelegate = self;
        messageComposeViewController.recipients = [NSArray arrayWithObject:[OGWorkSpace sharedWorkspace].orgInfo.mobile];
        messageComposeViewController.subject = @"enquiry";
        
        [self.homeViewController presentViewController:messageComposeViewController animated:YES completion:^()
         {
             self.navController.navigationBarHidden = YES;
         }];

    }
}

-(IBAction)fbBtnClicked:(id)sender
{
    CXSocialWebViewController* webViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CXSocialWebViewController"];
    webViewController.urlString = [OGWorkSpace sharedWorkspace].orgInfo.facebookPageLink;
    [self.navController pushViewController:webViewController animated:YES];
}

-(IBAction)twitterBtnClicked:(id)sender
{
    CXSocialWebViewController* webViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CXSocialWebViewController"];
    webViewController.urlString = [NSString stringWithFormat:@"https://mobile.twitter.com/%@", [OGWorkSpace sharedWorkspace].orgInfo.twitterinfo];
    [self.navController pushViewController:webViewController animated:YES];
}


- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    self.navController.navigationBarHidden = NO;

    [self.homeViewController dismissViewControllerAnimated:YES completion:^()
     {
     }];
}


-(IBAction)locBtnClicked:(id)sender{
    MapViewController* mapVc = (MapViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    mapVc.storeName = self.storeData.Name;
    [self.navController pushViewController:mapVc animated:YES];
    

    double longitude = [[[self.storeData.json objectFromJSONString] objectForKey:@"Longitude"] doubleValue];
    double latitude = [[[self.storeData.json objectFromJSONString] objectForKey:@"Latitude"] doubleValue];
    
    CLLocationCoordinate2D regionCenter;
    regionCenter.longitude = longitude;
    regionCenter.latitude = latitude;
    mapVc.regionCenter = regionCenter;

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 6)
        return self.customHtmlsDict.count;
    return 1;
}


-(UITableViewCell*)imageCellForTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
    
    static NSString *imageCellIdentifier = @"ImageCell";
    cell = [tableView dequeueReusableCellWithIdentifier:imageCellIdentifier];
    
 /*   UILabel* storeLabel = (UILabel*)[cell viewWithTag:5];
    UILabel* storeNameLabel = (UILabel*)[cell viewWithTag:6];
    UIButton* storesButton = (UIButton*)[cell viewWithTag:4];
    
    
    if(self.storeList.count <= 1)
    {
        storeLabel.hidden = YES;
        storeNameLabel.hidden = YES;
        storesButton.hidden = YES;
    }
    else
    {
        storeLabel.text = @"Store";
        storeNameLabel.text = self.selectedStore.Name;
    }
    
    
    NSString* imageUrl = nil;
    if(self.imageUrlsList.count > 0)
    {
        imageUrl = self.imageUrlsList[0];
    }
    
    UIActivityIndicatorView* activityView = (UIActivityIndicatorView*)[cell viewWithTag:2];
    [activityView removeFromSuperview];
    UIImageView* productImageView = (UIImageView*)[cell viewWithTag:1];*/
    //if (!_imagePager) {
    self._imagePager = [[KIImagePager alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 202)];
    self._imagePager.pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    self._imagePager.pageControl.pageIndicatorTintColor = [UIColor blackColor];
    self._imagePager.slideshowTimeInterval = 3.2f;
    self._imagePager.slideshowShouldCallScrollToDelegate = YES;
    self._imagePager.imageCounterDisabled = true;
    [self._imagePager setClipsToBounds:YES];
    self._imagePager.delegate = self;
    self._imagePager.dataSource = self;
    [cell.contentView addSubview:self._imagePager];
    //}
    //[productImageView removeFromSuperview];
    
   /* if(imageUrl)
    {
        UIImage *image = [[CXResourceManager sharedInstance] imageForPath:imageUrl];
        
        if(!image)
        {
            
            [activityView startAnimating];
            
            [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:imageUrl
                                                                          dataType:DATA_TYPE_BINARY finishBlock:^(OnGoDownloadData *downloadData){
                                                                              if (downloadData.downloadStatus == DOWNLOAD_STATUS_SUCCESS)
                                                                              {
                                                                                  UIImage *image = [UIImage imageWithData:downloadData.data];
                                                                                  if(image)
                                                                                  {
                                                                                      [activityView stopAnimating];
                                                                                      activityView.hidden = YES;
                                                                                      [productImageView setImage:image];
                                                                                      
                                                                                      [[CXResourceManager sharedInstance] setImage:image forPath:imageUrl];
                                                                                  }
                                                                              }
                                                                              
                                                                          }];
        }
        else
        {
            activityView.hidden = YES;
            [productImageView setImage:image];
        }
    }
    else
    {
        activityView.hidden = NO;
        [activityView startAnimating];
        //[productImageView setImage:[UIImage imageNamed:@"shadow_home"]];
    }*/
    return cell;
}

#pragma mark Image Animation



/*-(UITableViewCell*)storeCellForTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
    
    static NSString *storeCellIdentifier = @"StoreCell";
    cell = [tableView dequeueReusableCellWithIdentifier:storeCellIdentifier];
    
    UILabel* storeLabel = (UILabel*)[cell viewWithTag:2];
    storeLabel.text = self.selectedStore.Name;
    
    UILabel* descriptionLabel = (UILabel*)[cell viewWithTag:3];
    descriptionLabel.text = [[self.selectedStore.json objectFromJSONString] objectForKey:@"Description"];

    return cell;
}*/

#pragma mark Design Store Section
-(UITableViewCell*)storeCellForTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentfier = @"Store_Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentfier];
    //if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentfier];
    cell.backgroundColor = [UIColor clearColor];
   // }
    [cell.contentView addSubview:[self designStoreCell:CGRectMake(10, 0, tableView.frame.size.width-20, [self tableView:tableView heightForRowAtIndexPath:indexPath])]];
    
    return cell;
}


- (UIView*)designStoreCell:(CGRect)frame{
    
    UIView *customCellView = [[UIView alloc]initWithFrame:frame];
    customCellView.layer.cornerRadius = 4.0f;
    customCellView.backgroundColor = [UIColor whiteColor];
    customCellView.layer.borderColor = [UIColor clearColor].CGColor;
    customCellView.layer.borderWidth = 2.0f;
    
   // [customCellView setBackgroundColor:[UIColor whiteColor]];
    //ImageView
    UIImageView *imageView = [UIImageView createCxImageView:CGRectMake(0, 5, 35, 35) imageName:@"storename"];
    [customCellView addSubview:imageView];

    //TitleLabel
    UILabel *titleLbl = [UILabel createCXHeaderLabel:CGRectMake(imageView.frame.size.width+10, -5,customCellView.frame.size.width-100, 40) AndText:self.selectedStore.Name];
    [customCellView addSubview:titleLbl];//-10
    
    //DescriptionLabel
    UILabel *descriptionLbl = [UILabel createCXDescriptionLabel:CGRectMake(titleLbl.frame.origin.x,10, customCellView.frame.size.width-titleLbl.frame.origin.x, customCellView.frame.size.height) AndText:[[self.selectedStore.json objectFromJSONString] objectForKey:@"Description"]];
    [customCellView addSubview:descriptionLbl];
    //    [[NSNotificationCenter defaultCenter]postNotificationName:@"PLAY_VIDEO" object:self.videoPath];

    
    return customCellView;
}

#pragma mark Design Address

-(UITableViewCell*)addressCellForTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentfier = @"Store_Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentfier];
    //if (cell == nil) {
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentfier];
    cell.backgroundColor = [UIColor clearColor];
    // }
    [cell.contentView addSubview:[self designAddressCell:CGRectMake(10, 0, tableView.frame.size.width-20, [self tableView:tableView heightForRowAtIndexPath:indexPath])]];
    
    return cell;
    
    /*UITableViewCell* cell = nil;
    
    static NSString *storeCellIdentifier = @"AddressCell";
    cell = [tableView dequeueReusableCellWithIdentifier:storeCellIdentifier];

    UILabel* addressStaticLabel = (UILabel*)[cell viewWithTag:2];
    addressStaticLabel.text = @"Address";;
    
    UILabel* addressLabel = (UILabel*)[cell viewWithTag:3];
    addressLabel.text = [[self.selectedStore.json objectFromJSONString] objectForKey:@"Address"];
    
    return cell;*/
}

- (UIView*)designAddressCell:(CGRect)frame{
    
    UIView *customCellView = [[UIView alloc]initWithFrame:frame];
    customCellView.layer.cornerRadius = 4.0f;
    customCellView.layer.borderColor = [UIColor clearColor].CGColor;
    customCellView.layer.borderWidth = 2.0f;
    
    
    [customCellView setBackgroundColor:[UIColor whiteColor]];
    //ImageView
    UIImageView *imageView = [UIImageView createCxImageView:CGRectMake(0, 10, 35, 35) imageName:@"address"];
    [customCellView addSubview:imageView];
    
    //TitleLabel
    UILabel *titleLbl = [UILabel createCXHeaderLabel:CGRectMake(imageView.frame.size.width+10, -5,customCellView.frame.size.width-100, 40) AndText:@"Address"];
    [customCellView addSubview:titleLbl];
    
    //DescriptionLabel
    NSString *addressText = [NSString stringWithFormat:@"%@", [[self.selectedStore.json objectFromJSONString] objectForKey:@"Address"]];
    UILabel *descriptionLbl = [UILabel createCXDescriptionLabel:CGRectMake(titleLbl.frame.origin.x,10, customCellView.frame.size.width-titleLbl.frame.origin.x, customCellView.frame.size.height) AndText:addressText];
    [customCellView addSubview:descriptionLbl];
    
    return customCellView;
}





#pragma mark ----------

-(UITableViewCell*)contactCellForTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *storeCellIdentifier = @"ContactCell_custom";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:storeCellIdentifier];
    //if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:storeCellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
    //}
    cell.backgroundColor = [UIColor clearColor];
    
    [cell.contentView addSubview:[self designContactViewWithFrame:CGRectMake(10, 0, tableView.frame.size.width-20, [self tableView:tableView heightForRowAtIndexPath:indexPath])]];
    
    return cell;
}


- (UIView *)designContactViewWithFrame:(CGRect)frame {
    
    UIView *contactView = [[UIView alloc] initWithFrame:frame];
    contactView.layer.cornerRadius = 4.0f;
    contactView.layer.masksToBounds = YES;
    [contactView setBackgroundColor:[UIColor whiteColor]];
    
    CGFloat width = frame.size.height - 10;
    CGFloat socBtnSize = frame.size.height - 10;
    CGFloat yPosition = 5;
    
    OGOrgs *org = [OGWorkSpace sharedWorkspace].orgInfo;
    
    int numberOfContent = 0;
    if (org.mobile && org.mobile.length > 0) {
        numberOfContent += 2;
    }
    if(org.facebookPageLink && org.facebookPageLink.length > 0) {
        numberOfContent ++;
    }
    if(org.twitterinfo && org.twitterinfo.length > 0) {
        numberOfContent ++;
    }

    CGFloat startX = (contactView.frame.size.width - ((numberOfContent * width) + (numberOfContent * 10)))/2 ;

    if (org.mobile && org.mobile.length > 0) {
        UIButton *calBtn = [UIButton createSocialButtonWithFrame:CGRectMake(startX, yPosition, socBtnSize, socBtnSize) withImage:[UIImage imageNamed:@"call_us"] withTag:CALL_TAG];
        [calBtn addTarget:self action:@selector(callAction:) forControlEvents:UIControlEventTouchUpInside];
        [contactView addSubview:calBtn];
        startX = startX + width + 10;
        
        UIButton *msgBtn = [UIButton createSocialButtonWithFrame:CGRectMake(startX, yPosition, socBtnSize, socBtnSize) withImage:[UIImage imageNamed:@"send_sms"] withTag:MSG_TAG];
        [msgBtn addTarget:self action:@selector(messageAction:) forControlEvents:UIControlEventTouchUpInside];
        [contactView addSubview:msgBtn];
        startX = startX + width + 10;
    }
    
    if(org.facebookPageLink && org.facebookPageLink.length > 0) {
        UIButton *fbBtn = [UIButton createSocialButtonWithFrame:CGRectMake(startX, yPosition, socBtnSize, socBtnSize) withImage:[UIImage imageNamed:@"facebook"] withTag:FB_TAG];
        [fbBtn addTarget:self action:@selector(fbAction:) forControlEvents:UIControlEventTouchUpInside];
        [contactView addSubview:fbBtn];
        startX = startX + width + 10;
    }

    if(org.twitterinfo && org.twitterinfo.length > 0) {
        UIButton *twtBtn = [UIButton createSocialButtonWithFrame:CGRectMake(startX, yPosition, socBtnSize, socBtnSize) withImage:[UIImage imageNamed:@"twitter"] withTag:TWITTER_TAG];
        [twtBtn addTarget:self action:@selector(twitterAction:) forControlEvents:UIControlEventTouchUpInside];
        [contactView addSubview:twtBtn];
    }
    
    return contactView;
}

- (void)callAction:(UIButton *)calBtn {
    [self callUsBtnClicked:calBtn];
}

- (void)messageAction:(UIButton *)msgBtn {
    [self smsBtnClicked:msgBtn];
}

- (void)fbAction:(UIButton *)fbBtn {
    [self fbBtnClicked:fbBtn];
}

- (void)twitterAction:(UIButton *)twtBtn {
    [self twitterBtnClicked:twtBtn];
}


-(UITableViewCell*)customHtmlGroupCellForTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
    
    static NSString *storeCellIdentifier = @"CustomHtmlGroupCell";
    cell = [tableView dequeueReusableCellWithIdentifier:storeCellIdentifier];
    
    NSString* customHtmlKeyName = [self.customHtmlsDict allKeys][indexPath.row];
    //NSArray* htmlGroupList = self.customHtmlsDict[customHtmlKeyName];
    
    UILabel* customHtmlNameabel = (UILabel*)[cell viewWithTag:1];
    customHtmlNameabel.text = customHtmlKeyName;

    UICollectionView* collectionView = (UICollectionView*)[cell viewWithTag:2];
    
    //have to relook, ugly way of coding,
    if(!self.groupsDict[customHtmlKeyName])
    {
        self.groupsDict[customHtmlKeyName] = collectionView;
    }
    
    return cell;

}

#pragma mark Load Html Pages

-(UITableViewCell*)customHtmlCellForTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *storeCellIdentifier = @"htmlCell_cutom";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:storeCellIdentifier];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:storeCellIdentifier];
    cell.backgroundColor = [UIColor clearColor];
    
    [cell.contentView addSubview:[self designWebView:CGRectMake(10, 0, tableView.frame.size.width-20, [self tableView:tableView heightForRowAtIndexPath:indexPath]-10)AndIndexPath:indexPath]];
    
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10)];/// change size as you need.
    separatorLineView.backgroundColor = [UIColor clearColor];// you can also put image here
    [cell.contentView addSubview:separatorLineView];
    
    return cell;
    
   /* UITableViewCell* cell = nil;
    
    static NSString *storeCellIdentifier = @"CustomHtmlCell";
    cell = [tableView dequeueReusableCellWithIdentifier:storeCellIdentifier];
    
    NSString* customHtmlKeyName = [self.customHtmlsDict allKeys][indexPath.row];
    NSArray* htmlGroupList = self.customHtmlsDict[customHtmlKeyName];
    
    UILabel* customHtmlNameabel = (UILabel*)[cell viewWithTag:1];
    customHtmlNameabel.text = customHtmlKeyName;
    
    UIWebView* webView = (UIWebView*)[cell viewWithTag:2];
    if(htmlGroupList.count == 1)
    {
        NSDictionary* dict = htmlGroupList[0];
        [webView loadHTMLString:dict[@"Description"] baseURL:nil];
    }
    else
    {
        cell = [self customHtmlGroupCellForTableView:tableView cellForRowAtIndexPath:indexPath];
    }*/
    return cell;
}

#pragma mark Design Html webview


- (UIView*)designWebView:(CGRect)frame AndIndexPath:(NSIndexPath*)indexPath{
    
    NSString* customHtmlKeyName = [self.customHtmlsDict allKeys][indexPath.row];
    NSArray* htmlGroupList = self.customHtmlsDict[customHtmlKeyName];
    
    
    UIView *customCellView = [[UIView alloc]initWithFrame:frame];
    customCellView.layer.cornerRadius = 4.0f;
    customCellView.layer.borderColor = [UIColor clearColor].CGColor;
    customCellView.layer.borderWidth = 2.0f;
    
    
    [customCellView setBackgroundColor:[UIColor whiteColor]];
    //ImageView
    UIImageView *imageView = [UIImageView createCxImageView:CGRectMake(0,0,0,0) imageName:nil];
    [customCellView addSubview:imageView];
    
    //TitleLabel
    UILabel *titleLbl = [UILabel createCXHeaderLabel:CGRectMake(imageView.frame.size.width+10, -5,customCellView.frame.size.width-100, 40) AndText:customHtmlKeyName];
    [customCellView addSubview:titleLbl];
    
    UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(titleLbl.frame.size.width+titleLbl.frame.origin.x+10,5,70, 30)];
    [moreBtn setTitle:@"More" forState:UIControlStateNormal];
    moreBtn.titleLabel.font = [UIFont fontWithName:@"AlegreyaSans-Regular" size:16];
    moreBtn.layer.cornerRadius = 8.0f;
    moreBtn.layer.borderWidth = 0.0f;
    moreBtn.tag = indexPath.row;
    [moreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [moreBtn setBackgroundColor:[UIColor colorWithRed:0/255.0f green:102/255.0f blue:51/255.0f alpha:1.0f]];
    [customCellView addSubview:moreBtn];
    [moreBtn addTarget:self action:@selector(viewMoreClicked:event:) forControlEvents:UIControlEventTouchUpInside];
    //Web View
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(titleLbl.frame.origin.x,40, customCellView.frame.size.width-titleLbl.frame.origin.x, customCellView.frame.size.height-50)];
    ;

    if(htmlGroupList.count == 1)
    {
        NSDictionary* dict = htmlGroupList[0];
        [webView loadHTMLString:[NSString stringWithFormat:@"<font face='AlegreyaSans-Regular'>%@", dict[@"Description"]] baseURL:nil];
    }
    [customCellView addSubview:webView];

    
    return customCellView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = nil;
    
    if(indexPath.section == 0)
    {
        cell = [self imageCellForTableView:tableView cellForRowAtIndexPath:indexPath];//completed
    }
    else if(indexPath.section == 1)
    {
        cell = [self storeCellForTableView:tableView cellForRowAtIndexPath:indexPath];
    }
    else if(indexPath.section == 2)
    {
        cell = [self addressCellForTableView:tableView cellForRowAtIndexPath:indexPath];
    }
    else if(indexPath.section == 3)
    {
        cell = [self contactCellForTableView:tableView cellForRowAtIndexPath:indexPath];
    }
    else if (indexPath.section == 4){
        static NSString *CellIdentifier = @"CellIdentifier";
        
        AFTableViewCell *cell = (AFTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell)
        {
            cell = [[AFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier collectionView:1003];
            [cell.collectionView setDelegate:self];
            [cell.collectionView setDataSource:self];
        }
        return cell;
        
    }else if (indexPath.section == 5){
        static NSString *CellIdentifier = @"CellIdentifier";
        
        AFTableViewCell *cell = (AFTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell)
        {
            cell = [[AFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier collectionView:1004];
            [cell.collectionView setDelegate:self];
            [cell.collectionView setDataSource:self];
        }
        return cell;
    }
    else if(indexPath.section == 6)
    {
        cell = [self customHtmlCellForTableView:tableView cellForRowAtIndexPath:indexPath];
    }

    //section 3 == what's going on
    //section 4 == Speakers
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    switch (indexPath.section) {
        case 0:
            height = 202;
            break;
        case 1:
            height = 120;
            break;
        case 2:
            height = 90;
            break;
        case 3:
            height = 50;
            break;
        case 4:
            height = 160;
            break;
        case 5:
            height =160;// 172;
            break;
 
        default:
            height = 160;

            break;
    }
    return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
   // return 1;
    return 10;
}


- (IBAction)viewMoreClickedInGroup:(id)sender event:(id)event {
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    NSString* customHtmlKeyName = [self.customHtmlsDict allKeys][indexPath.row];

    UICollectionView *collectionView = self.groupsDict[customHtmlKeyName];
    UICollectionViewCell *tappedCell = (UICollectionViewCell*)[[touch.view superview] superview];

    NSIndexPath *tappedIndexPath = [collectionView indexPathForCell:tappedCell];
    
    
    NSDictionary* pageDict = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:UIPageViewControllerSpineLocationMid] forKey:UIPageViewControllerOptionSpineLocationKey];
    
    
    CXPageViewController* pageViewController = [[CXPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:pageDict];
    pageViewController.leftNavigationItemName = @"Custom Html";
    
    self.customHtmlWebViewControllers = [NSMutableArray new];
    
    NSMutableArray* list = self.customHtmlsDict[customHtmlKeyName];
    NSInteger selectedPageIndex = tappedIndexPath.item;

    for(int index = 0; index < list.count; ++index)
    {
        CXWebViewController* viewController = [[CXWebViewController alloc]initWithNibName:nil bundle:[NSBundle mainBundle]];;//[storyBoard instantiateViewControllerWithIdentifier:@"CXWebViewController"]
        [self.customHtmlWebViewControllers addObject:viewController];
        viewController.pageIndex = index;
        viewController.contentString = list[index][@"Description"];
        viewController.headerLabel.text = list[index][@"Name"];
        viewController.leftNavigationBarItemTitle = list[index][@"Name"];

    }
    
    
    [pageViewController setViewControllers:@[self.customHtmlWebViewControllers[selectedPageIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished)
     {
         
     }];
    
    
    pageViewController.doubleSided = NO;
    pageViewController.dataSource = self;
    
    //[self.navController pushViewController:pageViewController animated:YES];
   

}


- (IBAction)viewMoreClicked:(UIButton*)sender event:(id)event {
    
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    NSString* customHtmlKeyName = [self.customHtmlsDict allKeys][sender.tag];
    NSArray* htmlGroupList = self.customHtmlsDict[customHtmlKeyName];

    
    NSDictionary* pageDict = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:UIPageViewControllerSpineLocationMid] forKey:UIPageViewControllerOptionSpineLocationKey];
    
    
    CXPageViewController* pageViewController = [[CXPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:pageDict];
    pageViewController.leftNavigationItemName = customHtmlKeyName;

    self.customHtmlWebViewControllers = [NSMutableArray new];
    
    NSMutableArray* list = [NSMutableArray new];
    NSInteger selectedPageIndex;
    
    if(htmlGroupList.count == 1)
    {
        for (int index = 0; index < [self.customHtmlsDict allKeys].count; ++index)
        {
            NSString* keyName = [self.customHtmlsDict allKeys][index];
            
            NSArray* groupList = self.customHtmlsDict[keyName];
            if(groupList.count == 1)
            {
                [list addObject:groupList[0]];
                if([keyName isEqualToString:customHtmlKeyName])
                {
                    selectedPageIndex = list.count-1;
                }
            }
        }
    }
    else
    {
        list = htmlGroupList;
        selectedPageIndex = 0;
    }

    
    
    for(int index = 0; index < list.count; ++index)
    {
        CXWebViewController* viewController = [[CXWebViewController alloc]initWithNibName:nil bundle:[NSBundle mainBundle]];//[storyBoard instantiateViewControllerWithIdentifier:@"CXWebViewController"];
        viewController.pageIndex = index;
        viewController.contentString = list[index][@"Description"];
        viewController.headerString = list[index][@"Name"];
        viewController.leftNavigationBarItemTitle = list[index][@"Name"];
        [self.customHtmlWebViewControllers addObject:viewController];
    }
    
    
    [pageViewController setViewControllers:@[self.customHtmlWebViewControllers[selectedPageIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished)
     {
         
     }];
    
    
    pageViewController.doubleSided = NO;
    pageViewController.dataSource = self;
    
    [self presentViewController:pageViewController animated:YES completion:^{
        
    }];
   // [self.navController pushViewController:pageViewController animated:YES];

}

- (UIViewController *)pageViewController:(UIPageViewController *)pvc viewControllerBeforeViewController:(UIViewController *)vc
{
    
   
    CXWebViewController* pVC = (CXWebViewController*)vc;
    
    UINavigationController *navController = pVC.navController;
    navController.title = pVC.headerString;
    pVC.leftNavigationBarItemTitle = pVC.headerString;

    
    pvc.title = pVC.headerString;
     NSLog(@"title before header %@", pVC.headerString);
    if(pVC.pageIndex == 0)
        return nil;
    
    return self.customHtmlWebViewControllers[pVC.pageIndex-1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pvc viewControllerAfterViewController:(UIViewController *)vc
{
    CXWebViewController* pVC = (CXWebViewController*)vc;
    [pVC.navController setNavigationBarHidden:YES animated:YES];
    
    pvc.title = pVC.headerString;
    
    NSLog(@"title header %@", pVC.headerString);
    
    int pIndex = (int) pVC.pageIndex;
    pVC.leftNavigationBarItemTitle = pVC.headerString;
    
    pVC.navController.titleLabel.text = @"NNNEE";

    if(pVC.pageIndex < self.customHtmlWebViewControllers.count-1)
    {
         //pVC.headerString = list[pIndex][@"Name"];
        
        return  self.customHtmlWebViewControllers[pVC.pageIndex+1];
        
    }
    return nil;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (!self.featureProductJobs.count) {
        return 0;
    }
    if(collectionView.tag == 1003){
        NSDictionary *dic = self.featureProducts[0];
        self.featureProductsJobs1 = (NSMutableArray*)[self getTheFeatureProductsJobList:[dic valueForKey:@"ID"]];
      return   self.featureProductsJobs1.count;
        
    }else if (collectionView.tag == 1004){
        
        if (self.featureProducts.count > 1) {
            NSDictionary *dic = self.featureProducts[1];
            
            self.featureProductsJobs2 = (NSMutableArray*)[self getTheFeatureProductsJobList:[dic valueForKey:@"ID"]];
            return   self.featureProductsJobs2.count;
        }
        return 0;
    }
    
    NSArray* groupKeyName = [self.groupsDict allKeysForObject:collectionView];
    NSArray* groupList = self.customHtmlsDict[groupKeyName[0]];
    return groupList.count;
}


- (NSArray*)getTheFeatureProductsJobList:(NSString*)str{
    DataBaseManager *manager =  [DataBaseManager dataBaseManager];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT *FROM FEATURE_PRODUCTS_JOBS WHERE PARENT_ID == '%@'",str];
    
    BOOL success = [manager execute:sqlQuery resultsArray:array];
    if (success) {
    }
    self.featureProductJobs = (NSMutableArray*)array;
   // NSLog(@"feature prduct jobs %@",array);
    //SELECT * FROM FEATURE_PRODUCTS_JOBS WHERE PARENT_ID == '54832'
    return array;
}



// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = nil;
    if (collectionView.tag ==1003) {
        dic = self.featureProductsJobs1[indexPath.row];
    }else if (collectionView.tag == 1004){
        dic = self.featureProductsJobs2[indexPath.row];
    }
    //UICollectionViewCell *cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
    
    OnGoCollectionViewCell *cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
    
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 160, 160)];
//    [cell1.contentView addSubview:view];
//    
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 130, 130)];
//    UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.size.height, 150 ,50)];
//    
//    //if (cell1 == nil) {
//       // UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.size.height, 150 ,50)];
//        titleLbl.textAlignment = NSTextAlignmentCenter;
//        titleLbl.text =  [dic valueForKey:@"NAME"];//NAME
//        [view addSubview:titleLbl];
//  //  }
    
    
    
    cell1.cLabel.text = [dic valueForKey:@"NAME"];;
    
    
 //   [view addSubview:imageView];
    UIImage *image = [[CXResourceManager sharedInstance] imageForPath:[dic valueForKey:@"Image_URL"]];
    if (!image) {
        [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:[dic valueForKey:@"Image_URL"]
                                                                      dataType:DATA_TYPE_BINARY finishBlock:^(OnGoDownloadData *downloadData){
                                                                          if (downloadData.downloadStatus == DOWNLOAD_STATUS_SUCCESS)
                                                                          {
                                                                              UIImage *image = [UIImage imageWithData:downloadData.data];
                                                                              if(image)
                                                                              {
                                                                                  //[imageView setImage:image];
                                                                                  cell1.cImageView.image = image;
                                                                                  
                                                                                  [[CXResourceManager sharedInstance] setImage:image forPath:[dic valueForKey:@"Image_URL"]];
                                                                              }
                                                                          }
                                                                          
                                                                      }];
        
    }else{
        //imageView.image  = image;
        cell1.cImageView.image = image;
    }
    cell1.cImageView.userInteractionEnabled = YES;
    
    UIButton *cellBtn = [[UIButton alloc]initWithFrame:cell1.cImageView.frame];
    cellBtn.tag = indexPath.row;
    [cellBtn addTarget:self action:@selector(SelectItem:) forControlEvents:UIControlEventTouchUpInside];
    [cell1 addSubview:cellBtn];
    
    
    return cell1;
    
    static NSString *CellIdentifier = @"CollectionCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.layer.borderWidth = 1.0f;
    cell.layer.cornerRadius = 4.0f;
    cell.layer.borderColor = [UIColor colorWithRed:225/255.0f green:225/255.0f blue:225/255.0f alpha:1.0f].CGColor;
    
    NSArray* groupKeyName = [self.groupsDict allKeysForObject:collectionView];
    NSArray* groupList = self.customHtmlsDict[groupKeyName[0]];
    NSDictionary* dict = groupList[indexPath.item];

    UIWebView* webView = (UIWebView*)[cell viewWithTag:1];
    [webView loadHTMLString:dict[@"Description"] baseURL:nil];

    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(AFTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[cell setCollectionViewDataSourceDelegate:self indexPath:indexPath];
    //NSInteger index = cell.collectionView.tag;
    
   // CGFloat horizontalOffset = [self.contentOffsetDictionary[[@(index) stringValue]] floatValue];
    //[cell.collectionView setContentOffset:CGPointMake(horizontalOffset, 0)];
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    //return CGSizeMake(160.f, 160.f);
    return CGSizeMake(140.f, 140.f);
    
}

#pragma mark AlbumImages

- (void)passTheAlubumImages:(NSArray*)images;
{
    
    
}




#pragma mark - KIImagePager DataSource
- (NSArray *) arrayWithImages:(KIImagePager*)pager
{
    return self.coverImageList;
}

- (UIViewContentMode) contentModeForImage:(NSUInteger)image inPager:(KIImagePager *)pager
{
    return UIViewContentModeScaleAspectFill;
}

/*- (NSString *) captionForImageAtIndex:(NSUInteger)index inPager:(KIImagePager *)pager
{
    return @[
             @"First screenshot",
             @"Another screenshot",
             @"Last one! ;-)"
             ][index];
}*/

#pragma mark - KIImagePager Delegate
- (void) imagePager:(KIImagePager *)imagePager didScrollToIndex:(NSUInteger)index
{
   // NSLog(@"%s %lu", __PRETTY_FUNCTION__, (unsigned long)index);
}

- (void) imagePager:(KIImagePager *)imagePager didSelectImageAtIndex:(NSUInteger)index
{
   // NSLog(@"%s %lu", __PRETTY_FUNCTION__, (unsigned long)index);
}


//- (NSString *)leftNavigationBarItemTitle {
//    return
//}


#pragma mark Collection View Implementation

#pragma mark - UICollectionViewDataSource Methods
/*
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *collectionViewArray = self.colorArray[[(AFIndexedCollectionView *)collectionView indexPath].row];
    return collectionViewArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
    
    NSArray *collectionViewArray = self.colorArray[[(AFIndexedCollectionView *)collectionView indexPath].row];
    cell.backgroundColor = collectionViewArray[indexPath.item];
    
    return cell;
}



#pragma mark - UIScrollViewDelegate Methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:[UICollectionView class]]) return;
    
    CGFloat horizontalOffset = scrollView.contentOffset.x;
    
    UICollectionView *collectionView = (UICollectionView *)scrollView;
    NSInteger index = collectionView.tag;
    self.contentOffsetDictionary[[@(index) stringValue]] = @(horizontalOffset);
}
*/

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    int productIndex = indexPath.item;
    OnGoProducts* product = self.featureProductsJobs1[productIndex];
    
    self.productTabViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductTabViewController"];
    self.productTabViewController.productInfo  = product;
    //self.selectedProductIndex = productIndex;
    [self.navigationController pushViewController:self.productTabViewController animated:YES];
}


- (void)SelectItem:(UIButton*)sender{
    
    int productIndex = sender.tag;
    OnGoProducts* product = self.featureProductsJobs1[productIndex];
    
    self.productTabViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductTabViewController"];
    self.productTabViewController.productInfo  = product;
    //self.selectedProductIndex = productIndex;
//    [self presentViewController:self.productTabViewController animated:YES completion:^{
//        
//    }];
    //[self.navigationController pushViewController:self.productTabViewController animated:YES];
    
}

@end
