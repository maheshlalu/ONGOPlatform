//
//  SignInViewController.h
//  OnGO
//
//  Created by Mentor Insight India pvt Ltd on 27/02/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCKFNavDrawer.h"
#import "MHTabBarController.h"
#import "CXViewController.h"

@interface OrdersListViewController : CXViewController<UITextFieldDelegate,CCKFNavDrawerDelegate,MHTabBarItemController>{
    
    
    
}
@property(strong,nonatomic) IBOutlet UICollectionView* collectionView;
@property(nonatomic, strong) CCKFNavDrawer* navController;

@end
