
#import <UIKit/UIKit.h>
#import "CXViewController.h"
#import "MHTabBarController.h"


@interface ServiceHistoryViewController : CXViewController<MHTabBarItemController>

@property(nonatomic) NSString *serviceName;
@property(nonatomic) IBOutlet UILabel *loginMessageLabel;
@property(nonatomic) IBOutlet UITableView *tableView;

@end
