//
//  CXCalenderVc.h
//  OnGO
//
//  Created by Apple on 11/07/15.
//  Copyright (c) 2015 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import "CCKFNavDrawer.h"
#import "DataServices.h"
#import "LTHMonthYearPickerView.h"
#import "UIImageView+CxImageView.h"
#import "UILabel+CXLabel.h"
#import "Base64.h"
#import "CXViewController.h"
@interface CXCalenderVc : CXViewController <LTHMonthYearPickerViewDelegate,UIActionSheetDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>{
    UIButton *changeDateButton;
    NSString *currentDate;
    NSCache *_cellCache;

}
@property(nonatomic, strong) CCKFNavDrawer* navController;
@property(nonatomic, strong)  NSMutableArray* keysList;
@property (nonatomic,strong) UITableView *calenderListTableView;
@property (nonatomic, strong) LTHMonthYearPickerView *monthYearPicker;
@property (nonatomic, strong) UITextField *dateTextField;
@property (nonatomic,strong) UIView *editView;
@property (nonatomic,strong) NSMutableArray *eventsArray;
@property (nonatomic,strong) UILabel *selectedDate;
@property (nonatomic,strong) NSString *selectedDeteStr;
@property (nonatomic,strong) UILabel *noEventsLbl;


@end
