

#import "ServiceFormViewController.h"
#import "DataServices.h"

@interface ServiceFormViewController()
@end

@interface CXDyamicForm : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,assign) BOOL addMore;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,assign) BOOL mandatory;
@property (nonatomic,strong) NSString *allowedValues;
@property (nonatomic,assign) BOOL multiselect;
@property (nonatomic,strong) NSString *groupName;
@property (nonatomic,strong) NSString *dependentFields;
@property (nonatomic,strong) NSString *propgateValueToSubFormFields;
@property (nonatomic,strong) NSArray *allowedValuesResults;


@end

@implementation CXDyamicForm



@end

@implementation ServiceFormViewController
@synthesize tabItemName = mTabItemName;
@synthesize tabBGColor = mTabBGColor;
@synthesize formTableView;
-(void)backButtonTapped
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(BOOL)shouldShowCart
{
    return NO;
}


-(NSString*)leftNavigationBarItemTitle
{
    return @"Services";
}


- (void)viewDidLoad
{
    [self.webView removeFromSuperview];
    [self getTheFormResultFromServer];
    return;
    [self.progressView startAnimating];

    [[DataServices serviceInstance] getAllServicesInfoForMallId:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"MALL_ID"] block:^(NSArray* list)
     {
         NSString *jobTypeId;
         for (NSDictionary *dict in list) {
             
             if([dict[@"type"] isEqualToString:self.serviceName])
             {
                 jobTypeId = dict[@"id"];
                 break;
             }
             
         }
         if(jobTypeId)
         {
             NSString *urlString = [NSString stringWithFormat:@"http://storeongo.com/Services/showPostAJob?userId=%@&weburl=ongo_%@&noHeader=true&storeId=0&hideAppTabs=false&useLoginUserEmail=false&jobType=%@&catagoryType=ServicesCategories&hideBar=true#.VIwe8aaPKPI", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"MALL_ID"],[[[NSBundle mainBundle] infoDictionary] objectForKey:@"MALL_ID"], jobTypeId];
             
             NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:120];
             [self.webView loadRequest:urlRequest];
         }
         else
         {
             NSLog(@"No type in API");
         }
         
     }];

    
    

}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.progressView stopAnimating];

}


#pragma marl Dynamic Form Creation 


- (void)getTheFormResultFromServer{
    
    [[DataServices serviceInstance] getFormInformationMallId:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"MALL_ID"] block:^(NSArray* list){
        
        NSLog(@"Result %@",list);
        
        
        [self.formTableView reloadData];
    }];
    
    //[self tableViewCration];
    
}


- (void)tableViewCration{
    
    self.formTableView = [[UITableView alloc]initWithFrame:self.webView.frame style:UITableViewStyleGrouped];
    [self.formTableView setDelegate:self];
    [self.formTableView setDataSource:self];
    [self.view addSubview:self.formTableView];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;  {
    
   return  19;
    
}// Default is 1 if not implemented


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{
    return 1;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = @"index";
    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
   // NSString *string =[list objectAtIndex:section];
    /* Section header is in 0th index... */
    [label setText:@"mahesh"];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}
/*
 
 (lldb) po [list valueForKey:@"Fields"]
 <__NSArrayI 0x7ffc03bd5330>(
 <JKArray 0x7ffc017fbe90>(
 {
 addMore = 0;
 allowedValues = "";
 dependentFields = "";
 groupName = "";
 mandatory = false;
 multiselect = false;
 name = Name;
 propgateValueToSubFormFields = "";
 type = "Small Text";
 },
 {
 addMore = 0;
 allowedValues = "q:ServicesCategories";
 allowedValuesResults =     {
 "Enquiry(22026)" = "SERVICES_1";
 "Mobile Phone Repair(22513)" = "061815-DECFDBIH";
 };
 dependentFields = "";
 groupName = "";
 mandatory = false;
 multiselect = true;
 name = 1stLevelCategory;
 propgateValueToSubFormFields = "";
 type = Selection;
 },
 {
 addMore = 0;
 allowedValues = "q:Stores";
 allowedValuesResults =     {
 "Sakshi Creations(22115)" = "1434519545414_688";
 };
 dependentFields = "";
 groupName = "";
 mandatory = false;
 multiselect = true;
 name = storeId;
 propgateValueToSubFormFields = "";
 type = Selection;
 }
 )
 ,
 <JKArray 0x7ffc017f1b00>(
 {
 addMore = 0;
 allowedValues = "";
 dependentFields = "";
 groupName = "";
 mandatory = true;
 multiselect = false;
 name = Name;
 propgateValueToSubFormFields = "";
 type = "Small Text";
 },
 {
 addMore = 0;
 allowedValues = "";
 dependentFields = "";
 groupName = "";
 mandatory = false;
 multiselect = false;
 name = Description;
 propgateValueToSubFormFields = "";
 type = "Small Text";
 },
 {
 addMore = 0;
 allowedValues = "";
 dependentFields = "";
 groupName = "";
 mandatory = false;
 multiselect = false;
 name = Image;
 propgateValueToSubFormFields = "";
 type = Attachment;
 },
 {
 addMore = 0;
 allowedValues = "true|false";
 dependentFields = "";
 groupName = "";
 mandatory = true;
 multiselect = false;
 name = IsSpecialService;
 propgateValueToSubFormFields = "";
 type = "Radio OR CheckBox";
 },
 {
 addMore = 0;
 allowedValues = "";
 dependentFields = "";
 groupName = "";
 mandatory = false;
 multiselect = false;
 name = GroupName;
 propgateValueToSubFormFields = "";
 type = "Small Text";
 },
 {
 addMore = 0;
 allowedValues = "q:Stores";
 allowedValuesResults =     {
 "Sakshi Creations(22115)" = "1434519545414_688";
 };
 dependentFields = "";
 groupName = "";
 mandatory = false;
 multiselect = false;
 name = storeId;
 propgateValueToSubFormFields = "";
 type = Selection;
 }
 )
 ,
 <JKArray 0x7ffc017e3010>(
 {
 addMore = 0;
 allowedValues = "";
 dependentFields = "";
 groupName = "";
 mandatory = false;
 multiselect = false;
 name = Name;
 propgateValueToSubFormFields = "";
 type = "Small Text";
 },
 {
 addMore = 0;
 allowedValues = "";
 dependentFields = "";
 groupName = "";
 mandatory = false;
 multiselect = false;
 name = Description;
 propgateValueToSubFormFields = "";
 type = "Small Text";
 },
 {
 addMore = 0;
 allowedValues = "";
 dependentFields = "";
 groupName = "";
 mandatory = false;
 multiselect = false;
 name = Image;
 propgateValueToSubFormFields = "";
 type = Attachment;
 }
 )
 ,
 <JKArray 0x7ffc01703650>(
 {
 addMore = 0;
 allowedValues = "";
 dependentFields = "";
 groupName = "";
 mandatory = false;
 multiselect = false;
 name = Name;
 propgateValueToSubFormFields = "";
 type = "Small Text";
 },
 {
 addMore = 0;
 allowedValues = "";
 dependentFields = "";
 groupName = "";
 mandatory = false;
 multiselect = false;
 name = Description;
 propgateValueToSubFormFields = "";
 type = "Small Text";
 },
 {
 addMore = 0;
 allowedValues = "";
 dependentFields = "";
 groupName = "";
 mandatory = false;
 multiselect = false;
 name = Image;
 propgateValueToSubFormFields = "";
 type = Attachment;
 }
 )
 ,
 <JKArray 0x7ffc017d8ca0>(
 {
 allowedValues = "";
 dependentFields = "";
 groupName = "";
 "lang_label" = "LBL_JOB_TYPE_9040_NAME";
 mandatory = false;
 mask = "";
 multiselect = false;
 name = Name;
 propgateValueToSubFormFields = "";
 type = "Small Text";
 },
 {
 allowedValues = "";
 dependentFields = "";
 groupName = "";
 "lang_label" = "LBL_JOB_TYPE_9040_CONTACT_NUMBER";
 mandatory = false;
 mask = "";
 multiselect = false;
 name = "Contact number";
 propgateValueToSubFormFields = "";
 type = "Small Text";
 },
 {
 allowedValues = "";
 dependentFields = "";
 groupName = "";
 "lang_label" = "LBL_JOB_TYPE_9040_IMAGE";
 mandatory = false;
 mask = "";
 multiselect = false;
 name = Image;
 propgateValueToSubFormFields = "";
 type = Attachment;
 },
 {
 allowedValues = "";
 dependentFields = "";
 groupName = "";
 "lang_label" = "LBL_JOB_TYPE_9040_MESSAGE";
 mandatory = false;
 mask = "";
 multiselect = false;
 name = Message;
 propgateValueToSubFormFields = "";
 type = "Large Text";
 },
 {
 allowedValues = "q:Stores";
 allowedValuesResults =     {
 "Sakshi Creations(22115)" = "1434519545414_688";
 };
 dependentFields = "";
 groupName = "";
 "lang_label" = "LBL_JOB_TYPE_9040_STOREID";
 mandatory = false;
 mask = "";
 multiselect = false;
 name = storeId;
 propgateValueToSubFormFields = "";
 type = Selection;
 },
 {
 allowedValues = "";
 dependentFields = "";
 groupName = "";
 "lang_label" = "LBL_JOB_TYPE_9040_ADDRESS";
 mandatory = false;
 mask = "";
 multiselect = false;
 name = Address;
 propgateValueToSubFormFields = "";
 type = "Large Text";
 }
 )
 ,
 <JKArray 0x7ffc017f8460>(
 {
 addMore = 0;
 allowedValues = "";
 dependentFields = "";
 groupName = "";
 mandatory = true;
 multiselect = false;
 name = Name;
 propgateValueToSubFormFields = "";
 type = "Small Text";
 },
 {
 addMore = 1;
 allowedValues = "q:Menu";
 allowedValuesResults =     {
 };
 dependentFields = "";
 groupName = "";
 mandatory = true;
 multiselect = false;
 name = OrderItems;
 propgateValueToSubFormFields = "";
 type = Selection;
 },
 {
 addMore = 0;
 allowedValues = "";
 dependentFields = "";
 groupName = "";
 mandatory = true;
 multiselect = false;
 name = "Contact_Number";
 propgateValueToSubFormFields = "";
 type = "Small Text";
 },
 {
 addMore = 0;
 allowedValues = "";
 dependentFields = "";
 groupName = "";
 mandatory = true;
 multiselect = false;
 name = Address;
 propgateValueToSubFormFields = "";
 type = "Large Text";
 },
 {
 addMore = 0;
 allowedValues = "q:Stores";
 allowedValuesResults =     {
 "Sakshi Creations(22115)" = "1434519545414_688";
 };
 dependentFields = "";
 groupName = "";
 mandatory = false;
 multiselect = false;
 name = storeId;
 propgateValueToSubFormFields = "";
 type = Selection;
 },
 {
 addMore = 0;
 allowedValues = "";
 dependentFields = "";
 groupName = "";
 mandatory = true;
 multiselect = false;
 name = Quantity;
 propgateValueToSubFormFields = "";
 type = "Small Text";
 }
 )
 ,
 <JKArray 0x7ffc017fafa0>(
 {
 addMore = 0;
 allowedValues = "";
 dependentFields = "";
 groupName = "";
 mandatory = false;
 multiselect = false;
 name = Name;
 propgateValueToSubFormFields = "";
 type = "Small Text";
 },
 {
 addMore = 0;
 allowedValues = "";
 dependentFields = "";
 groupName = "";
 mandatory = false;
 multiselect = false;
 name = Address;
 propgateValueToSubFormFields = "";
 type = "Large Text";
 },
 {
 addMore = 1;
 allowedValues = "";
 dependentFields = "";
 groupName = OrderItems;
 mandatory = false;
 multiselect = false;
 name = OrderItemId;
 propgateValueToSubFormFields = "";
 type = "Small Text";
 },
 {
 addMore = 0;
 allowedValues = "";
 dependentFields = "";
 groupName = "";
 mandatory = false;
 multiselect = false;
 name = "Contact_Number";
 propgateValueToSubFormFields = "";
 type = "Small Text";
 },
 {
 addMore = 0;
 allowedValues = "";
 dependentFields = "";
 groupName = OrderItems;
 mandatory = false;
 multiselect = false;
 name = OrderItemQuantity;
 propgateValueToSubFormFields = "";
 type = "Small Text";
 },
 {
 addMore = 1;
 allowedValues = "";
 dependentFields = "";
 groupName = OrderItems;
 mandatory = false;
 multiselect = false;
 name = OrderItemName;
 propgateValueToSubFormFields = "";
 type = "Small Text";
 },
 {
 addMore = 0;
 allowedValues = "";
 dependentFields = "";
 groupName = OrderItems;
 mandatory = false;
 multiselect = false;
 name = OrderItemDiscount;
 propgateValueToSubFormFields = "";
 type = "Small Text";
 },
 {
 addMore = 0;
 allowedValues = "";
 dependentFields = "";
 groupName = OrderItems;
 mandatory = false;
 multiselect = false;
 name = OrderItemMRP;
 propgateValueToSubFormFields = "";
 type = "Small Text";
 },
 {
 addMore = 0;
 allowedValues = "";
 dependentFields = "";
 groupName = OrderItems;
 mandatory = false;
 multiselect = false;
 name = OrderItemSubTotal;
 propgateValueToSubFormFields = "";
 type = "Small Text";
 },
 {
 addMore = 0;
 allowedValues = "";
 dependentFields = "";
 groupName = "";
 mandatory = false;
 multiselect = false;
 name = Total;
 propgateValueToSubFormFields = "";
 type = "Small Text";
 }
 )
 ,
 <JKArray 0x7ffc017f5ef0>(
 {
 allowedValues = "";
 dependentFields = "";
 groupName = "User Info";
 "lang_label" = "LBL_JOB_TYPE_9190_NAME";
 mandatory = true;
 mask = "";
 multiselect = false;
 name = Name;
 propgateValueToSubFormFields = "";
 type = "Small Text";
 },
 {
 allowedValues = "";
 dependentFields = "";
 groupName = "User Info";
 "lang_label" = "LBL_JOB_TYPE_9190_PHONE_NUMBER";
 mandatory = false;
 mask = "";
 multiselect = false;
 name = "Phone Number";
 propgateValueToSubFormFields = "";
 type = "Small Text";
 },
 {
 allowedValues = "";
 dependentFields = "";
 groupName = "User Info";
 "lang_label" = "LBL_JOB_TYPE_9190_ADDRESS";
 mandatory = false;
 mask = "";
 multiselect = false;
 name = Address;
 propgateValueToSubFormFields = "";
 type = "Small Text";
 },
 {
 allowedValues = "";
 dependentFields = "";
 groupName = "Device Info";
 "lang_label" = "LBL_JOB_TYPE_9190_PROOF_OF_ID";
 mandatory = false;
 mask = "";
 multiselect = false;
 name = "Proof of ID";
 propgateValueToSubFormFields = "";
 type = "Small Text";
 },
 {
 allowedValues = "";
 dependentFields = "";
 groupName = "Device Info";
 "lang_label" = "LBL_JOB_TYPE_9190_WARRANTY";
 mandatory = false;
 mask = "";
 multiselect = false;
 name = Warranty;
 propgateValueToSubFormFields = "";
 type = "Small Text";
 },
 {
 allowedValues = "";
 dependentFields = "";
 groupName = "Device Info";
 "lang_label" = "LBL_JOB_TYPE_9190_MODEL";
 mandatory = false;
 mask = "";
 multiselect = false;
 name = Model;
 propgateValueToSubFormFields = "";
 type = "Small Text";
 },
 {
 allowedValues = "";
 dependentFields = "";
 groupName = "Device Info";
 "lang_label" = "LBL_JOB_TYPE_9190_IMEI_NUMBER";
 mandatory = false;
 mask = "";
 multiselect = false;
 name = "IMEI number";
 propgateValueToSubFormFields = "";
 type = "Small Text";
 },
 {
 allowedValues = "";
 dependentFields = "";
 groupName = "Device Info";
 "lang_label" = "LBL_JOB_TYPE_9190_DATE_PURCHASED";
 mandatory = false;
 mask = "";
 multiselect = false;
 name = "Date purchased";
 propgateValueToSubFormFields = "";
 type = "Small Text";
 },
 {
 allowedValues = "";
 dependentFields = "";
 groupName = "Device Info";
 "lang_label" = "LBL_JOB_TYPE_9190_IMAGE";
 mandatory = false;
 mask = "";
 multiselect = false;
 name = Image;
 propgateValueToSubFormFields = "";
 type = Attachment;
 },
 {
 allowedValues = "";
 dependentFields = "";
 groupName = "Device Info";
 "lang_label" = "LBL_JOB_TYPE_9190_MESSAGE";
 mandatory = false;
 mask = "";
 multiselect = false;
 name = Message;
 propgateValueToSubFormFields = "";
 type = "Large Text";
 }
 )
 
 )
 
 
 (lldb)
 */

/*
 
 [04/07/15 12:34:07 pm] PHANI KUMAR: http://storeongo.com:8081/Services/getMasters?type=allServicesJobTypes&mallId=688
 [04/07/15 12:34:15 pm] PHANI KUMAR: http://storeongo.com:8081/Services/getMasters?type=servicescategories&mallId=688
 
 */



@end


