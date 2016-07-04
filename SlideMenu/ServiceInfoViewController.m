

#import "ServiceInfoViewController.h"
#import "CCKFNavDrawer.h"
#import "OnGoDB.h"
#import "JSONKit.h"
#import "CXResourceManager.h"
#import "OnGoDownloadManager.h"
#import "DataServices.h"

@interface ServiceInfoViewController()
@property(nonatomic,strong) NSMutableArray* itemList;
@end


@implementation ServiceInfoViewController
@synthesize tabItemName = mTabItemName;
@synthesize tabBGColor = mTabBGColor;

-(void)backButtonTapped
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(BOOL)shouldShowCart
{
    return NO;
}


-(NSString*)leftNavigationBarItemTitle
{
    return @"Services";
}


- (void)viewDidLoad
{
    
}



@end


