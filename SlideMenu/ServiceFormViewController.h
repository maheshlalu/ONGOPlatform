
#import <UIKit/UIKit.h>
#import "CXViewController.h"
#import "MHTabBarController.h"


@interface ServiceFormViewController : CXViewController<MHTabBarItemController,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic) IBOutlet UIActivityIndicatorView *progressView;
@property(nonatomic) NSString *serviceName;

@property (nonatomic,strong) UITableView *formTableView;
@property (nonatomic,strong) NSMutableArray *formsList;
@end


