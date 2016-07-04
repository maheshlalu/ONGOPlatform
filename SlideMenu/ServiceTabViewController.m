

#import "ServiceTabViewController.h"
#import "CCKFNavDrawer.h"
#import "OnGoDB.h"
#import "JSONKit.h"
#import "CXResourceManager.h"
#import "OnGoDownloadManager.h"
#import "DataServices.h"
#import "ServiceInfoViewController.h"
#import "ServiceFormViewController.h"
#import "ServiceHistoryViewController.h"
#import "MHTabBarController.h"

@interface ServiceTabViewController()
@property(nonatomic,strong) ServiceInfoViewController* infoVController;
@property(nonatomic,strong) ServiceFormViewController* formVController;
@property(nonatomic,strong) ServiceHistoryViewController* historyVController;
@property(nonatomic,strong) MHTabBarController* tabBarController;

@end

static NSMutableDictionary* cartList = nil;

@implementation ServiceTabViewController

-(void)backButtonTapped
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(BOOL)shouldShowCart
{
    return NO;
}




- (void)viewDidLoad
{
    self.infoVController = [self.storyboard instantiateViewControllerWithIdentifier:@"ServiceInfoViewController"];
    self.infoVController.tabItemName = @"INFO";
    self.infoVController.tabBGColor = [UIColor colorWithRed:238.0f/255 green:238.0f/255 blue:238.0f/255 alpha:1.0f];
    self.infoVController.navController = self.navigationController;
    
    self.formVController = [self.storyboard instantiateViewControllerWithIdentifier:@"ServiceFormViewController"];
    self.formVController.tabItemName = @"FORM";
    self.formVController.tabBGColor = [UIColor colorWithRed:238.0f/255 green:238.0f/255 blue:238.0f/255 alpha:1.0f];
    self.formVController.navController = self.navigationController;
    self.formVController.serviceName = self.serviceName;
    
    self.historyVController = [self.storyboard instantiateViewControllerWithIdentifier:@"ServiceHistoryViewController"];
    self.historyVController.serviceName = self.serviceName;
    self.historyVController.tabItemName = @"HISTORY";
    self.historyVController.tabBGColor = [UIColor colorWithRed:238.0f/255 green:238.0f/255 blue:238.0f/255 alpha:1.0f];
    self.historyVController.navController = self.navigationController;
    
    NSArray *viewControllers = nil;
    viewControllers = @[self.infoVController, self.formVController, self.historyVController];
    self.tabBarController = [[MHTabBarController alloc] init];
    self.tabBarController.isTabBarItemWidthResize = YES;
    self.tabBarController.delegate = self;
    [self.view addSubview:self.tabBarController.view];
    self.tabBarController.view.frame = CGRectMake(self.tabBarController.view.frame.origin.x, 43, self.tabBarController.view.frame.size.width, self.tabBarController.view.frame.size.height-43);
    
    self.tabBarController.viewControllers = viewControllers;
    
    self.infoVController.nameLabel.text = self.serviceName;
    self.infoVController.descLabel.text = self.serviceDesc;


}



@end


