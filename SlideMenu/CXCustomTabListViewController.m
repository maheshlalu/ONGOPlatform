//
//  DealsListViewController.m
//  OnGO
//
//  Created by krish on 22/05/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "CXCustomTabListViewController.h"
#import "CCKFNavDrawer.h"
#import "DataServices.h"
#import "CXPageViewController.h"
#import "CXWebViewController.h"
#import "UIView+CXCustomCell.h"
#import "UILabel+CXLabel.h"
@interface CXCustomTabListViewController ()
@property(nonatomic) NSMutableArray* customTabsList;
@property(nonatomic) NSMutableArray* viewControllers;
@end

@implementation CXCustomTabListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self designTableView];

    [[DataServices serviceInstance]getAllCustomtabItemsForCustomTabName:self.customTabName mallId:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"MALL_ID"] block:^(NSArray* customTabsList){
        
        self.customTabsList = customTabsList;
        [self.tableView reloadData];
    }];

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)designTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{
    return self.customTabsList.count;

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;              // Default is 1 if not implemented
{
    return 1;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{
    NSDictionary* dict = self.customTabsList[indexPath.row];
    
    static NSString *storeCellIdentifier = @"custom_cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:storeCellIdentifier];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:storeCellIdentifier];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.contentView addSubview:[self designCustomCellView:CGRectMake(10, 0, tableView.frame.size.width-20, [self tableView:tableView heightForRowAtIndexPath:indexPath]-10) title:[dict objectForKey:@"Name"] webPageString:[dict objectForKey:@"Description"] indexPath:indexPath]];
    return cell;
}


- (UIView*)designCustomCellView:(CGRect)frame title:(NSString*)title webPageString:(NSString*)inHtmlString indexPath:(NSIndexPath*)inIndexPath;
{
    
    UIView *customCellView = [[UIView alloc]initWithFrame:frame];
    customCellView.layer.cornerRadius = 4.0f;
    customCellView.layer.borderColor = [UIColor clearColor].CGColor;
    customCellView.layer.borderWidth = 2.0f;
    
    
    [customCellView setBackgroundColor:[UIColor whiteColor]];
    //TitleLabel
    UILabel *titleLbl = [UILabel createCXCustomeHeaderLabel:CGRectMake(10, -5,customCellView.frame.size.width-100, 40) AndText:title];
    [customCellView addSubview:titleLbl];
    
    UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(titleLbl.frame.size.width+titleLbl.frame.origin.x+10,5,70, 30)];
    [moreBtn setTitle:@"More" forState:UIControlStateNormal];
    moreBtn.titleLabel.font = [UIFont fontWithName:@"AlegreyaSans-Regular" size:16];
    moreBtn.layer.cornerRadius = 8.0f;
    moreBtn.layer.borderWidth = 0.0f;
    moreBtn.tag = inIndexPath.row;
    [moreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [moreBtn setBackgroundColor:[UIColor colorWithRed:0/255.0f green:102/255.0f blue:51/255.0f alpha:1.0f]];
    [customCellView addSubview:moreBtn];
    [moreBtn addTarget:self action:@selector(viewMoreClicked:event:) forControlEvents:UIControlEventTouchUpInside];
    
    //Web View
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(titleLbl.frame.origin.x,40, customCellView.frame.size.width-titleLbl.frame.origin.x, customCellView.frame.size.height-50)];
    ;
    [webView loadHTMLString:[NSString stringWithFormat:@"<font face='AlegreyaSans-Regular'>%@", inHtmlString] baseURL:nil];
    
    [customCellView addSubview:webView];
    
    return customCellView;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}



- (IBAction)viewMoreClicked:(UIButton*)sender event:(id)event {
    
    [self myClickEvent:sender event:event];
    
}
    
-(NSString*)leftNavigationBarItemTitle
{
    return self.customTabName;
}

-(void)backButtonTapped
{
    [(CCKFNavDrawer*)self.navigationController drawerToggle];
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)myClickEvent:(UIButton*)sender event:(id)event
{

    NSSet *touches = [event allTouches];
    
    UITouch *touch = [touches anyObject];
    
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
    
    NSDictionary* pageDict = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:UIPageViewControllerSpineLocationMid] forKey:UIPageViewControllerOptionSpineLocationKey];
    
    
    CXPageViewController* pageViewController = [[CXPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:pageDict];
    pageViewController.leftNavigationItemName = self.customTabName;
    
    self.viewControllers = [NSMutableArray new];
    
    for(int index = 0; index < self.customTabsList.count; ++index)
    {
        CXWebViewController* viewController =[[CXWebViewController alloc]initWithNibName:nil bundle:[NSBundle mainBundle]];;// [storyBoard instantiateViewControllerWithIdentifier:@"CXWebViewController"];
        [self.viewControllers addObject:viewController];
        viewController.pageIndex = index;
        viewController.contentString = [self.customTabsList[index] objectForKey:@"Description"];
        viewController.headerString = [self.customTabsList[index] objectForKey:@"Name"];
        viewController.leftNavigationBarItemTitle = [self.customTabsList[index] objectForKey:@"Name"];
    }
    
    
    [pageViewController setViewControllers:@[self.viewControllers[sender.tag]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished)
     {
         
     }];
    
    
    pageViewController.doubleSided = NO;
    pageViewController.dataSource = self;
    [self presentViewController:pageViewController animated:YES completion:^{
        
    }];
    //[self.navController pushViewController:pageViewController animated:YES];
}

#pragma mark PageController

- (UIViewController *)pageViewController:(UIPageViewController *)pvc viewControllerBeforeViewController:(UIViewController *)vc
{
    CXWebViewController* pVC = (CXWebViewController*)vc;
    if(pVC.pageIndex == 0)
        return nil;
    
//    UIBarButtonItem* barButtonItem = [self.viewControllers[pVC.pageIndex-1] navigationItem].leftBarButtonItem;
//    
//    UILabel* customViewLabel = (UILabel*)[barButtonItem.customView viewWithTag:102];
//    customViewLabel.text = [self.viewControllers[pVC.pageIndex-1] leftNavigationBarItemTitle];
    
    
    return self.viewControllers[pVC.pageIndex-1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pvc viewControllerAfterViewController:(UIViewController *)vc
{
    CXWebViewController* pVC = (CXWebViewController*)vc;
    if(pVC.pageIndex < self.viewControllers.count-1)
    {
//        UIBarButtonItem* barButtonItem = [self.viewControllers[pVC.pageIndex+1] navigationItem].leftBarButtonItem;
//        
//        UILabel* customViewLabel = (UILabel*)[barButtonItem.customView viewWithTag:102];
//        customViewLabel.text = [self.viewControllers[pVC.pageIndex+1] leftNavigationBarItemTitle];

        return  self.viewControllers[pVC.pageIndex+1];

    }
    return nil;
}

/*
 
 - (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
 {
 
 
 
 
 UICollectionViewCell *cell = [collectionView
 dequeueReusableCellWithReuseIdentifier:@"newCell"
 forIndexPath:indexPath];
 
 // static NSString *CellIdentifier = @"CustomTabCell";
 
 //  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
 NSDictionary* dict = self.customTabsList[indexPath.item];
 
 [cell addSubview:[UIView designCustomCellView:cell.frame title:[dict objectForKey:@"Name"] webPageString:[dict objectForKey:@"Description"] indexPath:indexPath]];
 
 
 cell.layer.borderWidth = 4.0f;
 cell.layer.borderColor = [UIColor colorWithRed:243.0f/255.0f green:243.0f/255.0f blue:243.0f/255.0f alpha:1.0f].CGColor;
 cell.layer.cornerRadius = 4.0f;

UILabel* nameLabel = (UILabel*)[cell viewWithTag:1];
nameLabel.text = [dict objectForKey:@"Name"];
[nameLabel removeFromSuperview];

UIWebView* webView = (UIWebView*)[cell viewWithTag:3];
[webView removeFromSuperview];
 dispatch_async(dispatch_get_main_queue(), ^{
 [webView loadHTMLString:[dict objectForKey:@"Description"] baseURL:nil];
 
 });
 

return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.customTabsList.count;
    

 */
@end
