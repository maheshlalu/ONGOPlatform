
#import <UIKit/UIKit.h>
#import "CCKFNavDrawer.h"
#import "MHTabBarController.h"
#import "CXViewController.h"

@interface LoyaltyViewController : CXViewController<UITextFieldDelegate,CCKFNavDrawerDelegate,MHTabBarItemController>{
    
    
    
}
@property(strong,nonatomic) IBOutlet UIImageView* coverImageView;
@property(nonatomic, strong) CCKFNavDrawer* navController;

@end
