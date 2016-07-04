
#import <UIKit/UIKit.h>
#import "CXViewController.h"
#import "MHTabBarController.h"


@interface ServiceInfoViewController : CXViewController<MHTabBarItemController>

@property(nonatomic) IBOutlet UILabel *nameLabel;
@property(nonatomic) IBOutlet UILabel *descLabel;

@end
