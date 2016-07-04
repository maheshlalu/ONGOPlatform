//
//  HomeViewController.h
//  OnGO
//
//  Created by CreativeXpert pvt Ltd.  on 4/24/13.

#import "LocationList.h"
#import "OnGoDB.h"
#import "MHTabBarController.h"
#import "CCKFNavDrawer.h"
#import "CXViewController.h"
#import "ADPageControl.h"

@interface HomeViewController : CXViewController <LocationListDelegate,CCKFNavDrawerDelegate,MHTabBarControllerDelegate,ADPageControlDelegate>
{
    ADPageControl *_pageControl;

}

@property (nonatomic, strong) IBOutlet UIView* tabBarContainerView;
@property (nonatomic, strong) MHTabBarController *tabBarController;
@property (nonatomic, strong) OnGoStores* selectedStore;



-(IBAction)leftMenuTapped:(id)sender;




@end
