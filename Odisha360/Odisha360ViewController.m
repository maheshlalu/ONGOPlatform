//
//  Odisha360ViewController.m
//  OnGO
//
//  Created by Hanuman Kachwa on 27/12/15.
//  Copyright © 2015 Aryan Ghassemi. All rights reserved.
//

#import "Odisha360ViewController.h"
#import "UIViewController+JCAdditionsPage.h"
#import "OGOdishaNews.h"
#import "MBProgressHUD.h"
#import "ODNewsTableViewCell.h"
#import "OGOdishaNewsJobs.h"
#import "UIImageView+AFNetworking.h"
#import "Odisha360NewsDetailViewController.h"
#import "ProfileTabViewController.h"
#import "OGStores.h"
#import "Odisha360LanguageViewController.h"
#import "SignInViewController.h"
@interface Odisha360ViewController () {
    BOOL isOdishaLanguage;
    
    NSArray *searchResults;
    
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableData;

@property (nonatomic, strong) CXWidgetItem *menuItem;

@property (strong, nonatomic) UISearchDisplayController *searchDisplayController;


@end

@implementation Odisha360ViewController
static NSString * const reuseIdentifier = @"ODNewsCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self performSegueWithIdentifier:@"showLanguageSelectionVC" sender:self];
    
    // Do any additional setup after loading the view.
    searchResults = [[NSArray alloc] init];
    
    isOdishaLanguage = false;
    
    _menuItem = [[CXWidgetItem alloc] init];
    _menuItem.Name  = @"Latest";
    
    [OGMallInfo getMallInfoWithBlock:^(OGMallInfo *mallInfo, NSError *error) {
        NSLog(@"test");
        [OGStoreCategories getWidgetsWithBlock:^(NSArray *widgets, NSError *error) {
            
        }];
    }];
    
    [OGStores getStoreInfoWithBlock:^(NSArray *storeList, NSError *error) {
        [(CCKFNavDrawer*)self.navigationController setSelectedStore:storeList.lastObject];
    }];

    [OGWorkSpace sharedWorkspace].leftViewController.delegate = self;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.tableView.tableFooterView = [UIView new];

    [self enabledPullToRefreshAndLoadMore:self.tableView];

    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.loadMoreView.bottomButton setTitle:@"load more" forState:UIControlStateNormal];
    [self.loadMoreView.bottomButton setTitle:@"loading" forState:UIControlStateSelected];
    [self.loadMoreView.bottomButton setTitle:@"no more data" forState:UIControlStateDisabled];
    
    self.tableData = [[NSMutableArray alloc] initWithCapacity:10];
    

    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUserLoggedIn:) name:@"CXUserRegisterDidNotification" object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUserLoggedIn:) name:@"CXUserLoginDidNotification" object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUserLoggedIn:) name:@"CXUserProfileShowNotification" object:nil];
    
    self.leftNavigationBarItemTitle = @"Latest";
    
    [self removeRightViewController];
    
    
#if DEBUG
    [OGWorkSpace sharedWorkspace].mallId = @"3";
    isOdishaLanguage = false;
    
    [self loadDatas];
    
#endif


}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self removeRightViewController];
}

- (void)leftMenuViewDidSelectMenuItem:(CXWidgetItem*)menuItem {
    if ([menuItem.Widget_Type isEqualToString:@"url"]) {
        CCKFNavDrawer *navController = (CCKFNavDrawer*)self.navigationController;
        navController.titleLabel.text = menuItem.Display_Name;
        self.leftNavigationBarItemTitle = menuItem.Display_Name;
        self.currentPage = 1;
        self.menuItem = menuItem;
        [self loadDatas];
    }
}
//didToggleNotificationsSelection

- (void)didToggleLanguageSelection:(id)sender {
    
    
    CCKFNavDrawer *navController = (CCKFNavDrawer*)self.navigationController;
    UIButton *lanBtn = sender;
    
   // lanBtn.selected =! lanBtn.selected;
    
    if ([lanBtn.titleLabel.text isEqualToString:@"ଓଡ଼ିଶା"]) {//ଓଡ଼ିଶା
        [self didTapOdishaLanguage:nil];
        [navController.languageBtn setTitle:@"English" forState:UIControlStateNormal];
    }else if ([lanBtn.titleLabel.text isEqualToString:@"English"]){
        [self didTapEnglishLanguage:nil];
        [navController.languageBtn setTitle:@"ଓଡ଼ିଶା" forState:UIControlStateNormal];
    }
//    if (lanBtn.selected) {
//        [self didTapOdishaLanguage:nil];
    //    } [_languageBtn setTitle:@"English" forState:UIControlStateNormal];
   // [_languageBtn setTitle:@"ଓଡ଼ିଶା" forState:UIControlStateSelected];
//    else {
//        [self didTapEnglishLanguage:nil];
//    }
}
//    [_languageBtn setTitle:@"English" forState:UIControlStateNormal];
//[_languageBtn setTitle:@"ଓଡ଼ିଶା" forState:UIControlStateSelected];

//didToggleNotificationsSelection

- (void)didToggleNotificationsSelection:(id)sender {
    CXKeysViewController *keyView = [self.storyboard instantiateViewControllerWithIdentifier:@"CXKeysViewController"];
    keyView.tabItemName = @"Notifications";
    keyView.tabBGColor = [UIColor colorWithRed:243.0f/255 green:243.0f/255 blue:243.0f/255 alpha:1.0f];
    keyView.navController = (CCKFNavDrawer*)self.navigationController;
    [self.navigationController pushViewController:keyView animated:YES];
}

//- (void)tapAction:(id)sender {
//    CXKeysViewController *keyView = [self.storyboard instantiateViewControllerWithIdentifier:@"CXKeysViewController"];
//    
//   keyView.tabItemName = @"Notifications";
//    keyView.tabBGColor = [UIColor colorWithRed:243.0f/255 green:243.0f/255 blue:243.0f/255 alpha:1.0f];
//    keyView.navController = (CCKFNavDrawer*)self.navigationController;
//    [self.navigationController pushViewController:keyView animated:YES];
//
//    
//    NSLog(@"Tap Action enabled");
//  /*  SignInViewController* signInViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
//    [self.navigationController pushViewController:signInViewController animated:YES];*/
//}

- (BOOL)shouldShowLanguageSelection {
    return true;
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
    [MBProgressHUD showHUDAddedTo:self.view animated:true];

    if (!self.loadMoreView.isRefreshing) {
        self.currentPage = 1;
    }

    [OGOdishaNews getNewsWithType:_menuItem.Name currentPageNumber:self.currentPage block:^(NSArray *mallsArray, NSError *error) {
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

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    searchResults = [self.tableData filteredArrayUsingPredicate:resultPredicate];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"ODNewsDetailVC"]) {
        Odisha360NewsDetailViewController *newDVC = [segue destinationViewController];
        newDVC.isOdishaLanguage = isOdishaLanguage;
        
        NSIndexPath *indexPath = nil;
        OGOdishaNewsJobs *newsItem = nil;

        if (self.searchDisplayController.active) {
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            newsItem = [searchResults objectAtIndex:indexPath.row];
        } else {
            indexPath = [self.tableView indexPathForSelectedRow];
            newsItem = [self.tableData objectAtIndex:indexPath.row];
        }

        newDVC.newsItem = newsItem;
        newDVC.menuItem = self.menuItem;
    }else if ([segue.identifier isEqualToString:@"showLanguageSelectionVC"]) {
        Odisha360LanguageViewController *languageVC = [segue destinationViewController];
        languageVC.delegate = self;
    }
    
    
    
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.rightMenuTableView == tableView) {
        return [super tableView:tableView numberOfRowsInSection:section];
    }

    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
        
    } else {
        return [self.tableData count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.rightMenuTableView == tableView) {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
    ODNewsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    OGOdishaNewsJobs *jobsInfo = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        jobsInfo = [searchResults objectAtIndex:indexPath.row];
    } else {
        jobsInfo = [self.tableData objectAtIndex:indexPath.row];
    }

    if (isOdishaLanguage) {
        cell.newsTitle.font = [UIFont fontWithName:@"AkrutiOriSarala06" size:cell.newsTitle.font.pointSize];
        cell.newsSourceLabel.font = [UIFont fontWithName:@"AkrutiOriSarala06" size:cell.newsSourceLabel.font.pointSize];
        cell.newsDateLabel.font = [UIFont fontWithName:@"AkrutiOriSarala06" size:cell.newsDateLabel.font.pointSize];

    }else{
        
        cell.newsTitle.font = [UIFont fontWithName:@"HelveticaNeue" size:cell.newsTitle.font.pointSize];
        cell.newsSourceLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:cell.newsSourceLabel.font.pointSize];
        cell.newsDateLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:cell.newsDateLabel.font.pointSize];
    }
    
    cell.newsItem = jobsInfo;
    
    NSString *newsId = [NSString stringWithFormat:@"%f", jobsInfo.jobsIdentifier];
    
    if ([[[OGWorkSpace sharedWorkspace] savedPreferences] objectForKey:newsId]) {
        cell.newsFavBtn.selected = true;
    }else {
        cell.newsFavBtn.selected = false;
    }

    [cell.newsCommentBtn setTitle:jobsInfo.totalReviews forState:UIControlStateNormal];
    cell.newsTitle.text = jobsInfo.name;
    cell.newsSourceLabel.text = jobsInfo.postedBy;
    cell.newsDateLabel.text = jobsInfo.date;
    [cell.newsImageView setImageWithURL:[NSURL URLWithString:jobsInfo.imageURL] placeholderImage:[UIImage imageNamed:@"placeholder"]];
//    [cell.newsCommentBtn setTitle:[NSString stringWithFormat:@"%lu", (unsigned long)jobsInfo.jobComments.count] forState:UIControlStateNormal];
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    cell.contentView.backgroundColor = [UIColor clearColor];
//    UIView *whiteRoundedCornerView = [[UIView alloc] initWithFrame:CGRectMake(10,10, cell.contentView.frame.size.width - 20, 250)];
//    whiteRoundedCornerView.backgroundColor = [UIColor whiteColor];
//    whiteRoundedCornerView.layer.masksToBounds = NO;
//    whiteRoundedCornerView.layer.cornerRadius = 3.0;
//    whiteRoundedCornerView.layer.shadowOffset = CGSizeMake(-1, 1);
//    whiteRoundedCornerView.layer.shadowOpacity = 0.5;
//    [cell.contentView addSubview:whiteRoundedCornerView];
//    [cell.contentView sendSubviewToBack:whiteRoundedCornerView];
//}
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.rightMenuTableView == tableView) {
        return [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    }

    [self performSegueWithIdentifier:@"ODNewsDetailVC" sender:[tableView cellForRowAtIndexPath:indexPath]];
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView
{
    tableView.rowHeight = 230.0f; // or some other height
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


- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

-(IBAction)leftMenuTapped:(id)sender
{
    [(CCKFNavDrawer *)self.navigationController drawerToggle];
}


-(BOOL)shouldShowLeftMenu
{
    return YES;
}

-(void)showProfile:(id)obj
{
    ProfileTabViewController* profileViewC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileTabViewController"];
    [self.navigationController pushViewController:profileViewC animated:NO];}


-(void)handleUserLoggedIn:(NSNotification*)notification
{
    [self performSelector:@selector(showProfile:) withObject:nil afterDelay:0.001f];
}

- (IBAction)didTapEnglishLanguage:(id)sender {
    CCKFNavDrawer *navController = (CCKFNavDrawer*)self.navigationController;
   // navController.languageBtn.selected = false;
    [navController.languageBtn setTitle:@"ଓଡ଼ିଶା" forState:UIControlStateNormal];
    navController.titleLabel.font  = [UIFont fontWithName:@"Roboto-Regular" size:14.0f];

    [self dismissViewControllerAnimated:false completion:nil];
    [OGWorkSpace sharedWorkspace].mallId = @"3";
    isOdishaLanguage = false;
    [[NSUserDefaults standardUserDefaults] setValue:@"English" forKey:@"Language"];
    [self loadDatas];

}

- (IBAction)didTapOdishaLanguage:(id)sender {
    CCKFNavDrawer *navController = (CCKFNavDrawer*)self.navigationController;
   // navController.languageBtn.selected = true;
    navController.titleLabel.font  = [UIFont fontWithName:@"AkrutiOriSarala06" size:navController.titleLabel.font.pointSize];

    [navController.languageBtn setTitle:@"English" forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:false completion:nil];
    [OGWorkSpace sharedWorkspace].mallId = @"5";
    [[NSUserDefaults standardUserDefaults] setValue:@"odisha" forKey:@"Language"];
    isOdishaLanguage = true;
    
    [self loadDatas];
}
@end
