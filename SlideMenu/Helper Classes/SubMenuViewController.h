//
//  SubMenuViewController.h
//  SlideMenu
//
//  Created by Mentor Insight India pvt Ltd on 21/02/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
@interface SubMenuViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,SlideNavigationControllerDelegate>{
NSArray *menuSubcategoryArray;
    NSMutableArray* filtered;
}
@property (strong, nonatomic) IBOutlet UICollectionView *collectuinView;

@end
