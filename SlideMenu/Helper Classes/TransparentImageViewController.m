
#import "TransparentImageViewController.h"
#import "CXResourceManager.h"
#import "OnGoDownloadManager.h"

@interface TransparentImageViewController ()
@property(strong,nonatomic) IBOutlet UIImageView* imageView;

@end

@implementation TransparentImageViewController

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
    
    UIImage *image = [[CXResourceManager sharedInstance] imageForPath:_imageUrl];
    if(!image)
    {
        [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:_imageUrl dataType:DATA_TYPE_BINARY finishBlock:^(OnGoDownloadData *downloadData){
            
            if (downloadData.downloadStatus == DOWNLOAD_STATUS_SUCCESS)
            {
                UIImage *image = [UIImage imageWithData:downloadData.data];
                if(image)
                {
                    _imageView.image = image;
                }
            }
        }];
    }
    else
    {
        _imageView.image = image;
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)leftBarTapped
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)shouldCustomizeLeftNavigationItem
{
    return YES;
}

-(NSString*)leftNavigationBarItemTitle
{
    return @"Loyality";
}



@end
