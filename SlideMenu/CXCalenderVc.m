//
//  CXCalenderVc.m
//  OnGO
//
//  Created by Apple on 11/07/15.
//  Copyright (c) 2015 Aryan Ghassemi. All rights reserved.
//

#import "CXCalenderVc.h"

@interface CalenderEvents : NSObject

@end

@implementation CalenderEvents



@end

@implementation CXCalenderVc
@synthesize calenderListTableView;
- (void)viewDidLoad{
    [super viewDidLoad];
    self.eventsArray = [NSMutableArray new];
    [self createEditView];
    [self designCalenderWithOutEventsList];
    [self designCalenderList];
    [self getTheCalenderList];

}

- (void)getTheCalenderList{
    
    [[DataServices serviceInstance] getCalenderInformationMallId:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"MALL_ID"] block:^(NSArray* list){
  //  NSLog(@"Result %@",list);
        [self getThePresendDateEvents];
        
    }];
}

- (void)getThePresendDateEvents{
    
    NSDate *date = [NSDate date];
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [gregorian components:(NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit) fromDate:date];
    NSString *month  = nil;
    switch (dateComponents.month) {
        case 1:
            month = @"Jan";
            break;
        case 2:
            month = @"Feb";

            break;
        case 3:
            month = @"Mar";

            break;
        case 4:
            month = @"Apr";

            break;
        case 5:
            month = @"May";

            break;
        case 6:
            month = @"Jun";
 
            break;
        case 7:
            month = @"Jul";

            break;
        case 8:
            month = @"Aug";
 
            break;
        case 9:
            month = @"Sep";

            break;
        case 10:
            month = @"Oct";

            break;
        case 11:
            month = @"Nov";

            break;
        case 12:
            month = @"Dec";
 
            break;
            
        default:
            break;
    }
    
    NSString *event = [NSString stringWithFormat:@"select * from TABLE_CALENDER_EVENTS where month = '%@' AND year = '%ld'",month,(long)dateComponents.year];
    DataBaseManager *manager =  [DataBaseManager dataBaseManager];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    BOOL success = [manager execute:event resultsArray:array];
    if (success) {
        
    }
    if (array.count == 0 ) {
        changeDateButton.hidden = NO;
        self.editView.hidden = YES;
        [self.calenderListTableView removeFromSuperview];
        self.calenderListTableView = nil;
        self.noEventsLbl.text = [NSString stringWithFormat:@"No events for %@ ,%ld",[month lowercaseString],(long)dateComponents.year];
        self.noEventsLbl.hidden = NO;
    }else{
        changeDateButton.hidden = YES;
        self.editView.hidden = NO;
        self.selectedDate.text = [NSString stringWithFormat:@"%@,%ld",month,(long)dateComponents.year];
        self.noEventsLbl.hidden = YES;
    }
    
    self.eventsArray = array;
}


- (void)viewWillAppear:(BOOL)animated{

    //    NSString* sql = [NSString stringWithFormat:@"select * from TABLE_PRODUCTS where addToCart = '1'"];

    
}


- (void)saveTheCalendeEvnts{
    
    EKEventStore *store = [EKEventStore new];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (!granted) { return; }
        EKEvent *event = [EKEvent eventWithEventStore:store];
        event.title = @"Event Title";
        event.startDate = [NSDate date]; //today
        event.endDate = [event.startDate dateByAddingTimeInterval:60*60];  //set 1 hour meeting
        event.calendar = [store defaultCalendarForNewEvents];
        NSError *err = nil;
        [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
    }];
}


- (void)designCalenderList{

    if (self.calenderListTableView == nil) {
        calenderListTableView = [[UITableView alloc]initWithFrame:CGRectMake(15, self.editView.frame.origin.y+self.editView.frame.size.height+20,self.view.frame.size.width-30,self.view.frame.size.height-70)];
        [self.view addSubview:calenderListTableView];
        [calenderListTableView setBackgroundColor:[UIColor clearColor]];
        [calenderListTableView setDelegate:self];
        [calenderListTableView setDataSource:self];
    }
   
}


- (void)createEditView{
    
    self.editView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,45)];
    [self.view addSubview:self.editView];
    [self.editView setBackgroundColor:[UIColor clearColor]];
    
    self.selectedDate = [[UILabel alloc]initWithFrame:CGRectMake(0,10, 200, 40)];
    [self.editView addSubview:self.selectedDate];
    self.selectedDate.font = [UIFont fontWithName:@"AlegreyaSansSC-Bold" size:16];
    self.selectedDate.text = self.selectedDeteStr;
    self.selectedDate.textAlignment = NSTextAlignmentCenter;
    
    UIButton *editBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.selectedDate.frame.size.width,10, 70, 35)];
    [editBtn setTitle:@"Edit" forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(changeDateAction:) forControlEvents:UIControlEventTouchUpInside];
    [editBtn setBackgroundColor:[UIColor colorWithRed:0/255.0f green:102/255.0f blue:51/255.0f alpha:1.0f]];
    editBtn.titleLabel.font = [UIFont fontWithName:@"AlegreyaSans-Regular" size:16];
    editBtn.layer.cornerRadius = 8.0f;
    editBtn.layer.borderWidth = 0.0f;
    [self.editView addSubview:editBtn];
    
}

- (void)designCalenderWithOutEventsList{
    
    CGSize winSize = [UIScreen mainScreen].bounds.size;
    
    
    
     changeDateButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-50,100, 50)];
    [changeDateButton setTitle:@"Change date" forState:UIControlStateNormal];
    [changeDateButton addTarget:self action:@selector(changeDateAction:) forControlEvents:UIControlEventTouchUpInside];
    [changeDateButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:102/255.0f blue:51/255.0f alpha:1.0f]];
    changeDateButton.titleLabel.font = [UIFont fontWithName:@"AlegreyaSans-Regular" size:16];
    changeDateButton.layer.cornerRadius = 8.0f;
    changeDateButton.layer.borderWidth = 0.0f;
    [self.view addSubview:changeDateButton];
    

    _dateTextField = [[UITextField alloc] initWithFrame: CGRectMake(winSize.width * 0.5 - 75.0,
                                                                    winSize.height * 0.5 - 20.0,
                                                                    150.0,
                                                                    40.0)];
    [_dateTextField setText:@"Change date"];
    
    _monthYearPicker = [[LTHMonthYearPickerView alloc] initWithDate: [NSDate date]
                                                        shortMonths: NO
                                                     numberedMonths: NO
                                                         andToolbar: YES];
    _monthYearPicker.delegate = self;
    _dateTextField.delegate = self;
    _dateTextField.textAlignment = NSTextAlignmentCenter;
    _dateTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _dateTextField.layer.borderWidth = 1.0;
    _dateTextField.textColor = [UIColor purpleColor];
    _dateTextField.tintColor = [UIColor purpleColor];
    _dateTextField.inputView = _monthYearPicker;
    _dateTextField.hidden = YES;
    [self.view addSubview: _dateTextField];
    
    self.noEventsLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 130, self.view.frame.size.width, 50)];
    self.noEventsLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.noEventsLbl];
    self.noEventsLbl.font = [UIFont fontWithName:@"AlegreyaSansSC-Bold" size:18];

    
    
}

- (void)changeDateAction:(UIButton*)sender{
    
    [_dateTextField becomeFirstResponder];
    
}



- (void)designCalenderEditView{
    
    
}


#pragma mark - LTHMonthYearPickerView Delegate
- (void)pickerDidPressCancelWithInitialValues:(NSDictionary *)initialValues {
    _dateTextField.text = [NSString stringWithFormat:
                           @"%@ / %@",
                           initialValues[@"month"],
                           initialValues[@"year"]];
    [_dateTextField resignFirstResponder];
}


- (void)pickerDidPressDoneWithMonth:(NSString *)month andYear:(NSString *)year {
    _dateTextField.text = [NSString stringWithFormat: @"%@ / %@", month, year];
    [self getTheCalenderEvents:[month substringToIndex:3] year:year];
    
    [_dateTextField resignFirstResponder];
}


- (void)pickerDidPressCancel {
    [_dateTextField resignFirstResponder];
}


- (void)pickerDidSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //NSLog(@"row: %i in component: %i", row, component);
}


- (void)pickerDidSelectMonth:(NSString *)month {
    //NSLog(@"month: %@ ", month);
}


- (void)pickerDidSelectYear:(NSString *)year {
    //NSLog(@"year: %@ ", year);
}


- (void)pickerDidSelectMonth:(NSString *)month andYear:(NSString *)year {
    _dateTextField.text = [NSString stringWithFormat: @"%@ / %@", month, year];
}

#pragma mark

- (void)getTheCalenderEvents:(NSString*)month year:(NSString*)year{
    
    NSString *event = [NSString stringWithFormat:@"select * from TABLE_CALENDER_EVENTS where month = '%@' AND year = '%@'",[month capitalizedString],year ];
    DataBaseManager *manager =  [DataBaseManager dataBaseManager];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    BOOL success = [manager execute:event resultsArray:array];
    if (success) {
        
    }
    if (array.count == 0 ) {
        changeDateButton.hidden = NO;
        self.editView.hidden = YES;
        [self.calenderListTableView removeFromSuperview];
        self.calenderListTableView = nil;
        self.noEventsLbl.text = [NSString stringWithFormat:@"No events for %@ ,%@",month,year];
        self.noEventsLbl.hidden = NO;
    }else{
        changeDateButton.hidden = YES;
        self.editView.hidden = NO;
        self.selectedDate.text = [NSString stringWithFormat:@"%@,%@",month,year];
        self.noEventsLbl.hidden = YES;
        [self designCalenderList];
    }
    self.selectedDate.text = [NSString stringWithFormat:@"%@,%@",month,year];
    self.eventsArray = array;
    [self.calenderListTableView reloadData];
}

#pragma mark table delegate and datasource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
   return  self.eventsArray.count;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *key = [NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section, (long)indexPath.row];

    UITableViewCell *cell = [_cellCache objectForKey:key];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:key];
        [_cellCache setObject:cell forKey:key];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10)];/// change size as you need.
        separatorLineView.backgroundColor = [UIColor clearColor];// you can also put image here
        [cell.contentView addSubview:separatorLineView];
    }
    [cell.contentView addSubview:[self designEventsView:indexPath]];

    return cell;
}


- (UIView*)designEventsView:(NSIndexPath*)indexPath{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 10, self.calenderListTableView.frame.size.width, [self tableView:calenderListTableView heightForRowAtIndexPath:indexPath]-10)];
    view.layer.cornerRadius = 8.0f;
    view.layer.borderColor = [UIColor clearColor].CGColor;
    view.layer.borderWidth = 2.0f;
    [view setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *imageView = [UIImageView createCxImageView:CGRectMake(10,10, 35, 35) imageName:@"calender"];
    [view addSubview:imageView];
    
    //TitleLabel
    UILabel *titleLbl = [UILabel createCXHeaderLabel:CGRectMake(imageView.frame.size.width+20, -5,view.frame.size.width-100, 40) AndText:[[[self.eventsArray objectAtIndex:indexPath.row] valueForKey:@"NAME"] base64DecodedString]];
    [view addSubview:titleLbl];//-10
    titleLbl.numberOfLines = 0;
    
    //[events.Name base64EncodedString]
    //DescriptionLabel
    UILabel *descriptionLbl = [UILabel createCXDescriptionLabel:CGRectMake(titleLbl.frame.origin.x,10, view.frame.size.width-titleLbl.frame.origin.x, view.frame.size.height) AndText:[self dateString:[[self.eventsArray objectAtIndex:indexPath.row] valueForKey:@"startDate"]]];
    [view addSubview:descriptionLbl];
    return view;
}

- (NSString*)dateString:(NSString*)str{
    
    
    
    return [str substringToIndex:10];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return;
    NSDictionary *dic = [self.eventsArray objectAtIndex:indexPath.row];
    
    EKEventStore *store = [EKEventStore new];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (!granted) { return; }
        EKEvent *event = [EKEvent eventWithEventStore:store];
        event.title = [[dic valueForKey:@"NAME"] base64DecodedString];
        event.startDate =[dic valueForKey:@"startDate"];// [NSDate date]; //today
        event.endDate = [[dic valueForKey:@"endDate"] dateByAddingTimeInterval:60*60];//[event.startDate dateByAddingTimeInterval:60*60];  //set 1 hour meeting
        event.calendar = [store defaultCalendarForNewEvents];
        NSError *err = nil;
        [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
       // self.savedEventId = event.eventIdentifier;  //save the event id if you want to access this later
    }];
    
}

-(void)backButtonTapped
{
    [(CCKFNavDrawer*)self.navigationController drawerToggle];
    [self.navigationController popViewControllerAnimated:YES];
}


-(NSString*)leftNavigationBarItemTitle
{
    return @"Programs";
}

/*
 EKEventStore *store = [EKEventStore new];
 [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
 if (!granted) { return; }
 EKEvent *event = [EKEvent eventWithEventStore:store];
 event.title = @"Event Title";
 event.startDate = [NSDate date]; //today
 event.endDate = [event.startDate dateByAddingTimeInterval:60*60];  //set 1 hour meeting
 event.calendar = [store defaultCalendarForNewEvents];
 NSError *err = nil;
 [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
 self.savedEventId = event.eventIdentifier;  //save the event id if you want to access this later
 }];
 
 
 */

@end