

#import "ServiceHistoryViewController.h"
#import "DataServices.h"
#import "CXLoginManager.h"

@interface ServiceHistoryViewController()
@property(nonatomic,strong) NSMutableArray* itemList;
@end


@implementation ServiceHistoryViewController
@synthesize tabItemName = mTabItemName;
@synthesize tabBGColor = mTabBGColor;

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

-(void)viewWillAppear:(BOOL)animated
{
    if([[CXLoginManager sharedManager] isLoggedIn])
    {
        self.loginMessageLabel.hidden = YES;
        
        [[DataServices serviceInstance] getAllServiceHistoryItemsForServiceCategoryName:self.serviceName mallId:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"MALL_ID"] userId:[[CXLoginManager sharedManager] loggedInUserId] block:^(NSArray *list)
         {
             self.itemList = list;
             [self.tableView reloadData];
         }];
    }
    else
    {
        self.tableView.hidden = YES;
    }
}

- (void)viewDidLoad
{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.itemList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return @"";
    return @"  ";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"HistoryCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    UILabel* historyNameLabel = (UILabel*)[cell viewWithTag:1];
    
    NSDictionary *dict = self.itemList[indexPath.section];
    historyNameLabel.text = dict[@"Name"];
    
    
    UILabel* dateLabel = (UILabel*)[cell viewWithTag:2];
    dateLabel.text = dict[@"createdOn"];

    UIButton* statusButton = (UIButton*)[cell viewWithTag:3];
    [statusButton.layer setCornerRadius:4.0f];
    NSArray *statusList = dict[@"Next_Job_Statuses"];
    NSString *status = @"Submitted";
    if(statusList.count > 0)
    {
        status = statusList[0][@"Status_Name"];
    }
    
    [statusButton setTitle:status forState:UIControlStateNormal];
    
    return cell;
}


@end


