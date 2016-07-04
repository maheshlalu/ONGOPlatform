//
//  TestViewController.m
//  OnGO
//
//  Created by krish on 06/06/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "CXKeysViewController.h"
#import "CXKeyPageViewController.h"
#import "CXPageViewController.h"
#import "DataServices.h"
#import "Base64.h"
@interface CXKeysViewController ()
@property(nonatomic,strong) NSMutableArray* viewControllers;
@end




@implementation CXKeysViewController
@synthesize tabItemName = mTabItemName;
@synthesize tabBGColor = mTabBGColor;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSString*)leftNavigationBarItemTitle
{
    return @"Notifications";
}


- (void)createTableView{
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.keysTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,size.width,size.height)];
    [self.view addSubview:self.keysTableView];
    [self.keysTableView setBackgroundColor:[UIColor clearColor]];
    [self.keysTableView setDelegate:self];
    [self.keysTableView setDataSource:self];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createTableView];
    self.view.backgroundColor = [UIColor colorWithRed:243.0f/255 green:243.0f/255 blue:243.0f/255 alpha:1.0f];
    self.title = @"Notifications";
    ///http://storeongo.com:8081/Services/getMasters?type=Keys&mallId=42&unlimited=true
    
//    self.keysList = [NSMutableArray new];
//    
//    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:@"SAI",@"keyName", @"Sai Baba of Shirdi (unknown – 15 October 1918), also known as Shirdi Sai Baba, was a spiritual master who was and is regarded by his devotees as a saint, fakir, avatar (an incarnation of God), or sadguru, according to their individual proclivities and beliefs. He was revered by both his Muslim and Hindu devotees, and during, as well as after, his life on earth it remained uncertain if he was a Muslim or Hindu himself. This however was of no consequence to Sai Baba himself.[1] Sai Baba stressed the importance of surrender to the guidance of the true Sadguru or Murshad, who, having gone the path to divine consciousness himself, will lead the disciple through the jungle of spiritual training.[2]\r\n\r\nSai Baba remains a very popular saint,[3] especially in India, and is worshiped by people around the world. He had no love for perishable things and his sole concern was self-realization. He taught a moral code of love, forgiveness, helping others, charity, contentment, inner peace, and devotion to God and guru. He gave no distinction based on religion or caste. Sai Baba's teaching combined elements of Hinduism and Islam: he gave the Hindu name Dwarakamayi to the mosque he lived in,[4] practised Muslim rituals, taught using words and figures that drew from both traditions, and was buried in Shirdi. One of his well known epigrams, \"Sabka Malik Ek\" (\"One God governs all\"), is associated with Islam and Sufism. He also said, \"Trust in me and your prayer shall be answered\". He always uttered \"Allah Malik\" (\"God is King\").[2]", @"comment",nil];
//    [self.keysList addObject:dict];
//    
//    dict = [NSDictionary dictionaryWithObjectsAndKeys:@"About",@"keyName", @"Celkon is one of leading manufacturing companies in India. We have pioneered mobile phone solutions and wireless technologies in India.\r\n\r\nCelkon caters to the increasing smart needs of mobile users across the world.\r\n\r\nOur forte lies in providing innovative mobile technology to every customer. At Celkon, we believe every user needs an experience more personalized than ever. We are dedicated towards manufacturing customized user friendly phones. Our value added feature ensure the personality of the phone matches the taste of the user.\r\n\r\nThe wide range of products available at Celkon ensures that there is a phone for every pocket. Every Celkon product undergoes stringent quality tests at every stage of production.\r\n\r\nOur main focus is to excel and provide the user with best designs paired with unmatched technology.", @"comment",nil];
//    [self.keysList addObject:dict];

//     [[DataServices serviceInstance] getKeys:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"MALL_ID"] finishblock:^(NSArray* allStores){
//         
//         [self getTheKeys];
//         
//     }];
    
    [[DataServices serviceInstance] getNotificatin:@"3" block:^(NSArray *list) {
        
        NSLog(@"%@",list);
        self.keysList = [NSMutableArray arrayWithArray:list];
        [self.keysTableView reloadData];
    }];
    
    //[self populateKeys];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self getTheKeys];

}

- (void)getTheKeys{
    DataBaseManager *manager =  [DataBaseManager dataBaseManager];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    BOOL success = [manager execute:@"SELECT *FROM TABLE_KEYS" resultsArray:array];
    if (success) {
    }
    
    self.keysList = array;
    [self.keysTableView reloadData];
    
}

-(void)populateKeys
{
    [self.keysTableView reloadData];
}

-(void)setKeysList:(NSMutableArray *)keysList
{
    _keysList = keysList;
    [self populateKeys];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.keysList.count;
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
    
   /* static NSString *CellIdentifier = @"KeysIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UILabel* keyNameLabel = (UILabel*)[cell viewWithTag:2];
    NSDictionary* dict = self.keysList[indexPath.section];
   // keyNameLabel.text = [[dict objectForKey:@"NAME"] base64DecodedString];
    
    keyNameLabel.text = [dict valueForKeyPath:@"Name"];;
    
    UILabel* commentLabel = (UILabel*)[cell viewWithTag:3];
    commentLabel.text = [dict valueForKeyPath:@"Description"];// [[dict objectForKey:@"DESCRIPTION"]base64DecodedString];

    return cell;*/
    
    
    NSString *key = [NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section, (long)indexPath.row];
    
    UITableViewCell *cell = [_cellCache objectForKey:key];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:key];
        [_cellCache setObject:cell forKey:key];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10)];/// change size as you need.
        separatorLineView.backgroundColor = [UIColor clearColor];// you can also put image here
       // [cell.contentView addSubview:separatorLineView];
    }
    [cell.contentView addSubview:[self designEventsView:indexPath]];
    
    return cell;
    /*
     NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:@"Google"];
     [str addAttribute: NSLinkAttributeName value: @"http://www.google.com" range: NSMakeRange(0, str.length)];
     yourTextView.attributedText = str;
     */
}

- (UIView*)designEventsView:(NSIndexPath*)indexPath{

    CGSize size = [UIScreen mainScreen].bounds.size;
    NSDictionary* dict = self.keysList[indexPath.section];

    UIView *customCellView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, size.width,[self tableView:self.keysTableView heightForRowAtIndexPath:indexPath])];
    customCellView.layer.cornerRadius = 4.0f;
    customCellView.backgroundColor = [UIColor whiteColor];
    customCellView.layer.borderColor = [UIColor clearColor].CGColor;
    customCellView.layer.borderWidth = 2.0f;
    
    UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, customCellView.frame.size.width-50,50)];
    titleLbl.text = [dict valueForKeyPath:@"Name"];
    titleLbl.font = [UIFont fontWithName:@"Roboto-Bold" size:14.0f];
    
    UITextView *commentLbl = [[UITextView alloc]initWithFrame:CGRectMake(10, titleLbl.frame.size.height-10 ,customCellView.frame.size.width-10 ,customCellView.frame.size.height-50)];
     commentLbl.text = [dict valueForKeyPath:@"Description"];
    commentLbl.backgroundColor = [UIColor whiteColor];
    //commentLbl.isEditable = NO;
    [commentLbl setEditable:NO];
    commentLbl.dataDetectorTypes = UIDataDetectorTypeLink;
    commentLbl.font = [UIFont fontWithName:@"Roboto-Regular" size:13.0f];
    
    [customCellView addSubview:titleLbl];
    [customCellView addSubview:commentLbl];

    return customCellView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
    
    // If you are not using ARC:
    // return [[UIView new] autorelease];
}
/*
 
 self.newsTitle.font = [UIFont fontWithName:@"Roboto-Regular" size:14.0f];
 self.newsPublishedDate.font = [UIFont fontWithName:@"Roboto-Regular" size:14.0f];
 self.newsDescription.font = [UIFont fontWithName:@"Roboto-Regular" size:13.0f];
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:UIPageViewControllerSpineLocationMid] forKey:UIPageViewControllerOptionSpineLocationKey];
    
    CXPageViewController* pageViewController = [[CXPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:dict];
    pageViewController.leftNavigationItemName = @"KEYS";
    
    self.viewControllers = [NSMutableArray new];
    
    for(int index = 0; index < self.keysList.count; ++index)
    {
        CXKeyPageViewController* viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CXKeyPageViewController"];
        [self.viewControllers addObject:viewController];
        viewController.pageIndex = index;
        viewController.keyData = self.keysList[index];
    }
    
    
    [pageViewController setViewControllers:@[self.viewControllers[indexPath.section]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished)
     {
    
     }];

    
    pageViewController.doubleSided = NO;
    pageViewController.dataSource = self;
    
    [self.navController pushViewController:pageViewController animated:YES];

}

- (UIViewController *)pageViewController:(UIPageViewController *)pvc viewControllerBeforeViewController:(UIViewController *)vc
{
    CXKeyPageViewController* pVC = (CXKeyPageViewController*)vc;
    if(pVC.pageIndex == 0)
        return nil;
    return self.viewControllers[pVC.pageIndex-1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pvc viewControllerAfterViewController:(UIViewController *)vc
{
    CXKeyPageViewController* pVC = (CXKeyPageViewController*)vc;
    if(pVC.pageIndex < self.viewControllers.count-1)
      return  self.viewControllers[pVC.pageIndex+1];
    return nil;
}

-(void)backButtonTapped
{
   // [(CCKFNavDrawer*)self.navigationController drawerToggle];
    [self.navigationController popViewControllerAnimated:YES];
}


@end


