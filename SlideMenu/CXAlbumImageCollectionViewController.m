//
//  ProductsListViewController.m
//  OnGO
//
//  Created by krish on 18/05/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "CXAlbumImageCollectionViewController.h"
#import "DataServices.h"
#import "JSONKit.h"
#import "OnGoDownloadManager.h"
#import "CXResourceManager.h"
#import "OnGoDownloadData.h"
#import "CXAlbum.h"
#import "CXPageViewController.h"
#import "CXPageImageViewController.h"

#define ITEMS_PER_SECTION 2

#define ITEM_DEFAULT_WIDTH 150
#define ITEM_DEFAULT_HEIGHT 180



@interface CXAlbumImageCollectionViewController ()

@property(strong,nonatomic) NSMutableDictionary* sizesDict;
@property(nonatomic,strong) NSMutableArray* viewControllers;
@property(nonatomic, strong) UILabel* staticTextField;

@end

@implementation CXAlbumImageCollectionViewController
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.staticTextField = [[UILabel alloc] initWithFrame:CGRectMake(100, 150, 300, 40)];
    self.staticTextField.text = @"No images available";
    //[self.collectionView addSubview:self.staticTextField];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)populateImageList
{
    self.sizesDict = [NSMutableDictionary new];
    for(int index = 0; index < self.imageList.count; ++index)
    {
        CGSize size;
        size.height = ITEM_DEFAULT_HEIGHT;
        size.width = self.view.bounds.size.width;
        NSValue* value = [NSValue valueWithCGSize:size];

        [self.sizesDict setObject:value forKey:[NSString stringWithFormat:@"%d", index]];
    }
    if(self.imageList.count == 0)
    {
        self.staticTextField.hidden = NO;
    }
    else
    {
        self.staticTextField.hidden = YES;
    }
    [self.collectionView reloadData];
}

-(void)setImageList:(NSMutableArray *)imageList
{
    _imageList = imageList;
    [self populateImageList];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageList.count;
    
//    if((section+1) == [self numberOfSectionsInCollectionView:collectionView])
//    {
//        if(self.productsList.count%ITEMS_PER_SECTION)
//            return 1;
//        else
//            return ITEMS_PER_SECTION;
//
//    }
//    return ITEMS_PER_SECTION;

}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AlbumImageCell";

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.layer.borderWidth = 1.0f;
    
    cell.layer.borderColor = [UIColor colorWithRed:225/255.0f green:225/255.0f blue:225/255.0f alpha:1.0f].CGColor;
    
    
    int productIndex = indexPath.item;
    if(productIndex < self.imageList.count)
    {
        NSString* imageUrl = self.imageList[productIndex];
        
        
        if(imageUrl)
        {
            UIActivityIndicatorView* activityView = (UIActivityIndicatorView*)[cell viewWithTag:5];
            activityView.hidden = NO;

            UIImage *image = [[CXResourceManager sharedInstance] imageForPath:imageUrl];
            UIImageView* imageView = (UIImageView*)[cell viewWithTag:4];

            if(!image)
            {
                [activityView startAnimating];
                [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:imageUrl
                                                                              dataType:DATA_TYPE_BINARY finishBlock:^(OnGoDownloadData *downloadData){
                                                                                  if (downloadData.downloadStatus == DOWNLOAD_STATUS_SUCCESS)
                                                                                  {
                                                                                      UIImage *image = [UIImage imageWithData:downloadData.data];
                                                                                      if(image)
                                                                                      {
                                                                                          [activityView stopAnimating];
                                                                                          activityView.hidden = YES;
                                                                                          
                                                                                          
                                                                                          imageView.contentMode = UIViewContentModeScaleAspectFit;
                                                                                          [imageView setImage:image];
                                                                                          
                                                                                          [[CXResourceManager sharedInstance] setImage:image forPath:imageUrl];
                                                                                          
                                                                                          CGSize size = [image size];
                                                                                          
                                                                                          CGFloat deltaWidth = size.width - imageView.frame.size.width;
                                                                                          
                                                                                          CGFloat deltaHeight = size.height - imageView.frame.size.height;
                                                                                          
                                                                                          NSValue* value = [self.sizesDict objectForKey:[NSString stringWithFormat:@"%d", indexPath.item]];
                                                                                          
                                                                                          CGSize defaultSize =  [value CGSizeValue];
                                                                                          
                                                                                          CGSize newSize;
                                                                                          newSize.height = defaultSize.height + deltaHeight;
                                                                                          newSize.width = defaultSize.width ;
                                                                                          
                                                                                          
                                                                                          
                                                                                          [self.sizesDict setObject:[NSValue valueWithCGSize:newSize] forKey:[NSString stringWithFormat:@"%d", indexPath.item]];
                                                                                          
                                                                                          [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
                                                                                          
                                                                                          
                                                                                      }
                                                                                  }
                                                                                  
                                                                              }];
            }
            else
            {
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                [imageView setImage:image];
                activityView.hidden = YES;
                
            }
        }
    }

    return cell;
}


//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    if(self.productsList.count%ITEMS_PER_SECTION)
//    {
//        return ((self.productsList.count/ITEMS_PER_SECTION)+1);
//    }
//    else
//    {
//        return (self.productsList.count/ITEMS_PER_SECTION);
//    }
//}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary* dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:UIPageViewControllerSpineLocationMid] forKey:UIPageViewControllerOptionSpineLocationKey];
    
    CXPageViewController* pageViewController = [[CXPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:dict];
    pageViewController.leftNavigationItemName = @"IMAGES";

    self.viewControllers = [NSMutableArray new];
    
    for(int index = 0; index < self.imageList.count; ++index)
    {
        CXPageImageViewController* viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CXPageImageViewController"];
        [self.viewControllers addObject:viewController];
        viewController.pageIndex = index;
        viewController.urlString = self.imageList[index];
    }
    
    
    [pageViewController setViewControllers:@[self.viewControllers[indexPath.item]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished)
     {
         
     }];
    
    
    pageViewController.doubleSided = NO;
    pageViewController.dataSource = self;
    
    [self.navController pushViewController:pageViewController animated:YES];

}

- (UIViewController *)pageViewController:(UIPageViewController *)pvc viewControllerBeforeViewController:(UIViewController *)vc
{
    CXPageImageViewController* pVC = (CXPageImageViewController*)vc;
    if(pVC.pageIndex == 0)
        return nil;
    return self.viewControllers[pVC.pageIndex-1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pvc viewControllerAfterViewController:(UIViewController *)vc
{
    CXPageImageViewController* pVC = (CXPageImageViewController*)vc;
    if(pVC.pageIndex < self.viewControllers.count-1)
        return  self.viewControllers[pVC.pageIndex+1];
    return nil;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.bounds.size.width, ITEM_DEFAULT_HEIGHT);
    
    
//    NSValue* value = [self.sizesDict objectForKey:[NSString stringWithFormat:@"%d", indexPath.item]];
//    NSLog(@"%@", NSStringFromCGSize(value.CGSizeValue));
//    return [value CGSizeValue];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}//150, 214

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}


-(void)backButtonTapped
{
    [(CCKFNavDrawer*)self.navigationController drawerToggle];
    [self.navigationController popViewControllerAnimated:YES];
}

    
-(NSString*)leftNavigationBarItemTitle
{
    return @"Gallery";
}
    

@end
