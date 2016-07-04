//
//  MapViewController.m
//  OnGO
//
//  Created by Mentor Insight India pvt Ltd on 01/05/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "MapViewController.h"


#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface MapViewController () <MKMapViewDelegate>

@property (nonatomic, assign) CLLocationCoordinate2D coordinates;

@property (nonatomic, strong) UIButton *directionBtn;
@property (nonatomic, strong) UITextView *addressView;

@end

@implementation MapViewController

@synthesize onMapView;
@synthesize coordinates;
@synthesize locationManager;

@synthesize directionBtn;
@synthesize addressView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self designMapView];
    [self customizeInnerItemsInMap];
}

- (void)designMapView{
    
    self.onMapView=[[MKMapView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-50)];
    self.onMapView.delegate = self;
    self.onMapView.backgroundColor = [UIColor redColor];
    self.onMapView.mapType = MKMapTypeStandard;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
#ifdef __IPHONE_8_0
    if(IS_OS_8_OR_LATER) {
        // Use one or the other, not both. Depending on what you put in info.plist
        [self.locationManager requestWhenInUseAuthorization];
        //[self.locationManager requestAlwaysAuthorization];
    }
#endif
    self.onMapView.showsUserLocation = YES;
    [self.view addSubview:self.onMapView];
    [self.locationManager startUpdatingLocation];
    
    self.coordinates = [self getLocation];
    [self updateCurrentLocation];
}

- (void)updateCurrentLocation{
    MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = self.coordinates.latitude;
    region.center.longitude = self.coordinates.longitude;
    region.span.latitudeDelta = 0.0187f;
    region.span.longitudeDelta = 0.0137f;
    
    [self.onMapView setRegion:region animated:YES];
}

- (void)customizeInnerItemsInMap {
    
    CGFloat btnHeight = 40.0f;
    
    CGFloat addrHeight = 120.0f;
    
    CGFloat firstSpace = 10.0f;
    
    CGFloat secondSpace = 20.0f;
    
    self.directionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.directionBtn.frame = CGRectMake(20, self.onMapView.frame.size.height-btnHeight-addrHeight-firstSpace-secondSpace, self.onMapView.frame.size.width-40, btnHeight);
    
    
    NSLog(@"Btn frame is %@",NSStringFromCGRect(self.directionBtn.frame));
    self.directionBtn.backgroundColor = [UIColor orangeColor];
    [self.directionBtn setTitle:@"DIRECTION" forState:UIControlStateNormal];
    [self.directionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.directionBtn.titleLabel setFont:[UIFont fontWithName:@"Verdana" size:13]];
    self.directionBtn.layer.cornerRadius = 5.0f;
    self.directionBtn.layer.masksToBounds = YES;
    
    [self.directionBtn addTarget:self action:@selector(directionAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.onMapView addSubview:self.directionBtn];
    
    self.addressView = [[UITextView alloc] initWithFrame:CGRectMake(20, btnHeight+self.directionBtn.frame.origin.y+firstSpace, self.onMapView.frame.size.width-40, addrHeight)];
    
    NSLog(@"address frame is %@",NSStringFromCGRect(self.addressView.frame));
    self.addressView.editable = NO;
    self.addressView.textAlignment = NSTextAlignmentCenter;
    
    self.addressView.text = [NSString stringWithFormat:@"%@\n(For more Info click here)", [[[OGWorkSpace sharedWorkspace] orgInfo] valueForKey:@"name"]];
    
    
    [self.addressView setFont:[UIFont fontWithName:@"Verdana" size:13]];
    [self.addressView setTextColor:[UIColor blackColor]];
    [self.onMapView addSubview:self.addressView];
    [self boldAddressWithHeader];
    
    self.addressView.dataDetectorTypes = UIDataDetectorTypeLink;
    self.addressView.layer.cornerRadius = 5.0f;
    self.addressView.layer.masksToBounds = YES;
    self.addressView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.addressView.layer.borderWidth = 1.0f;
}
- (void)boldAddressWithHeader {
    NSString *strTextView = [NSString stringWithFormat:@"%@\n(For more Info click here)", [[[OGWorkSpace sharedWorkspace] orgInfo] valueForKey:@"name"]];
    
    NSRange rangeBold = [strTextView rangeOfString:[[[OGWorkSpace sharedWorkspace] orgInfo] valueForKey:@"name"]];
    NSRange rangelineText = [strTextView rangeOfString:@"click here"];
    
    UIFont *fontText = [UIFont boldSystemFontOfSize:14];
    NSDictionary *dictBoldText = [NSDictionary dictionaryWithObjectsAndKeys:fontText, NSFontAttributeName, nil];
    
    NSMutableAttributedString *mutAttrTextViewString = [[NSMutableAttributedString alloc] initWithString:strTextView];
    [mutAttrTextViewString setAttributes:dictBoldText range:rangeBold];
    

    [mutAttrTextViewString addAttribute: NSLinkAttributeName value: [[[OGWorkSpace sharedWorkspace] orgInfo] valueForKey:@"promotionURL"] range:rangelineText];
    [mutAttrTextViewString addAttribute:NSUnderlineColorAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle]
                      range:rangelineText];
    [self.addressView setAttributedText:mutAttrTextViewString];
}

- (void)directionAction:(UIButton *)dirBtn {
    
    NSString* addr = [NSString stringWithFormat:@"http://maps.google.com/maps?daddr=%1.6f,%1.6f&saddr=%1.6f,%1.6f", self.coordinates.latitude, self.coordinates.longitude, [[[[OGWorkSpace sharedWorkspace] orgInfo] valueForKey:@"latitude"] floatValue], [[[[OGWorkSpace sharedWorkspace] orgInfo] valueForKey:@"longitude"] floatValue]];

    NSURL* url = [[NSURL alloc] initWithString:[addr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:url];

}


-(CLLocationCoordinate2D) getLocation{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    [self.locationManager startUpdatingLocation];
    [self.locationManager requestWhenInUseAuthorization];
    if(IS_OS_8_OR_LATER) {
        [self.locationManager requestAlwaysAuthorization];
    }
    CLLocation *location = [self.locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    return coordinate;
}



-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = self.locationManager.location.coordinate.latitude;
    region.center.longitude = self.locationManager.location.coordinate.longitude;
    
    self.coordinates = self.locationManager.location.coordinate;
    
    region.span.latitudeDelta = 0.0187f;
    region.span.longitudeDelta = 0.0137f;
    [self updateCurrentLocation];
}

-(IBAction)locationBtnClicked:(id)sender
{

    }
-(IBAction)navBtnClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)backButtonTapped
{
    [self.navigationController popViewControllerAnimated:YES];
}


    
-(NSString*)leftNavigationBarItemTitle
{
    return self.storeName;
}
    

@end
