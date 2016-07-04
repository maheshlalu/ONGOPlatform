

#import <UIKit/UIKit.h>
#import "CCKFNavDrawer.h"
#import "MHTabBarController.h"
#import "CXViewController.h"

@interface FavoritesListViewController : CXViewController<UITextFieldDelegate,CCKFNavDrawerDelegate,MHTabBarItemController>{
    
    
    
}
@property(nonatomic,strong) IBOutlet UICollectionView* collectionView;
@property(nonatomic, strong) CCKFNavDrawer* navController;

@end
