//
//  ProductTabViewController.h
//  OnGO
//
//  Created by krish on 21/05/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHTabBarController.h"
#import "CXAlbum.h"
#import "ADPageControl.h"

@interface CXMediaTabViewController : UIViewController<MHTabBarControllerDelegate,ADPageControlDelegate>{
    ADPageControl *_pageControl;

}

@property(strong)MHTabBarController *tabBarController;

@property(strong, nonatomic) CXAlbum* album;

@end
