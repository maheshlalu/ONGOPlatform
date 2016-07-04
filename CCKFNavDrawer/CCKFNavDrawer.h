//
//  CCKFNavDrawer.h
//  CCKFNavDrawer
//
//  Created by calvin on 23/1/14.
//  Copyright (c) 2014年 com.calvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnGoDB.h"

typedef  enum{
	CCKFNavDrawer_MenuLeft,
	CCKFNavDrawer_MenuRight,
}CCKFNavDrawer_Menu;


@protocol CCKFNavDrawerDelegate <NSObject>
@required
-(NSString*)leftNavigationBarItemTitle;

@end

@interface CCKFNavDrawer : UINavigationController<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *pan_gr;
@property (weak, nonatomic) id<CCKFNavDrawerDelegate> CCKFNavDrawerDelegate;
@property (nonatomic, strong) UIBarButtonItem *leftBarButtonItem;
@property (nonatomic, strong) OnGoStores* selectedStore;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *languageBtn;
@property (nonatomic,strong) UIButton *notificationBtn;

@property (nonatomic,strong) UILabel *cartCountLbl;

- (void)drawerToggle;

- (void)updateTheCartInformation;

@end
