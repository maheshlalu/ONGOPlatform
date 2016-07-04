//
//  StoreOnGoViewController.m
//  OnGO
//
//  Created by Hanuman Kachwa on 27/12/15.
//  Copyright © 2015 Aryan Ghassemi. All rights reserved.
//

#import "StoreOnGoViewController.h"
#import "UIViewController+JCAdditionsPage.h"


@interface StoreOnGoViewController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableData;

@end

@implementation StoreOnGoViewController
static NSString * const reuseIdentifier = @"MallInfoCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.tableView.rowHeight = 50.0f;
    self.tableView.tableFooterView = [UIView new];

    [self enabledPullToRefreshAndLoadMore:self.tableView];

    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.loadMoreView.bottomButton setTitle:@"load more" forState:UIControlStateNormal];
    [self.loadMoreView.bottomButton setTitle:@"loading" forState:UIControlStateSelected];
    [self.loadMoreView.bottomButton setTitle:@"no more data" forState:UIControlStateDisabled];
    
    self.tableData = [[NSMutableArray alloc] initWithCapacity:10];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    [self loadDatas];

}

- (void)loadDatas
{
    // http://storeongo.com:8081/MobileAPIs/searchResults?name=tabla&address=Hyderabad,
    // Telangana, India
    //    return getHostUrl(mContext) + "/MobileAPIs/searchResults?name="
    //				+ category + "&address=" + locality;
    //
    //
    //    + "/Services/getMasters?type=allMalls&keyWord=" + keyWord;
    //} else {
    //				return getHostUrl(mContext)
    //    + "/Services/getMasters?type=allMalls&mainCategory=" + keyWord;
    //}
    //} else {
    //    return getHostUrl(mContext)
    //    + "/Services/getMasters?type=allMalls&pageNumber=" + pageNo
    //    + "&pageSize=" + pageSize;

    if (!self.loadMoreView.isRefreshing) {
        self.currentPage = 1;
    }

    [OGMallInfo getAllMallsInfoWithCurrentPageNumber:self.currentPage block:^(NSArray *mallsArray, NSError *error) {
        [self endRefresh];
        
        if(self.currentPage == 1) {
            [self.tableData removeAllObjects];
        }

        [self.tableData addObjectsFromArray:mallsArray];
        self.hasNextPage = mallsArray.count == kPageSize ? YES : NO;

        [self.tableView reloadData];
        
        self.currentPage++;
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    OGOrgs *orgInfo = self.tableData[indexPath.row];
    cell.textLabel.text = orgInfo.name;
//    cell.textLabel.attributedText = [[NSAttributedString alloc] initWithData:[self.datas[indexPath.row][@"title"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    return cell;
}


#pragma mark -

- (void)endRefresh
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.pullToRefreshView.isRefreshing) {
            [self.pullToRefreshView endRefresh];
        }
        
        if (self.loadMoreView.isRefreshing) {
            [self.loadMoreView endRefresh];
        }
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:true];
    });
}
@end
