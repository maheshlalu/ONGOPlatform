//
//  MapViewController.h
//  OnGO
//
//  Created by Mentor Insight India pvt Ltd on 01/05/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MKMapView.h>

@interface MapViewController : UIViewController <CLLocationManagerDelegate>

@property(nonatomic, strong) IBOutlet MKMapView* onMapView;
@property(nonatomic, strong) NSString* storeName;

@property (nonatomic,strong) CLLocationManager *locationManager;
@property(assign, nonatomic) CLLocationCoordinate2D regionCenter;


-(IBAction)locationBtnClicked:(id)sender;
-(IBAction)navBtnClicked:(id)sender;

@end
