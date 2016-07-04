//
//  ProductsListViewController.m
//  OnGO
//
//  Created by krish on 18/05/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "CXAlbumGalleryViewController.h"
#import "DataServices.h"
#import "JSONKit.h"
#import "OnGoDownloadManager.h"
#import "CXResourceManager.h"
#import "OnGoDownloadData.h"
#import "CXMediaTabViewController.h"
#import "CXAlbum.h"

#define ITEMS_PER_SECTION 2

#define ITEM_DEFAULT_WIDTH 150
#define ITEM_DEFAULT_HEIGHT 214



@interface CXAlbumGalleryViewController ()
@property(strong,nonatomic) NSMutableDictionary* albumsDict;
@property(strong,nonatomic) NSMutableDictionary* sizesDict;
@end

@implementation CXAlbumGalleryViewController

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
    [self populateAlbums];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)populateAlbums
{
    self.albumsDict = [NSMutableDictionary new];

    for(NSDictionary* dict in self.attachmentList)
    {
        NSString* albumName = [dict objectForKey:@"albumName"];
        CXAlbum* album = nil;
        if(albumName && [self.albumsDict objectForKey:albumName])
        {
            album = [self.albumsDict objectForKey:albumName];
        }
        else
        {
            if(!albumName)
            {
                albumName = @" ";
                album = [self.albumsDict objectForKey:albumName];
            }
            if(!album)
            {
                album = [CXAlbum new];
                album.albumName = albumName;
                [self.albumsDict setObject:album forKey:albumName];
            }
        }
        
        NSString* url = [dict objectForKey:@"URL"];
        
        if([[dict objectForKey:@"isCoverImage"] boolValue])
        {
            album.coverImage = url;
        }
        
        
        if(url)
        {
            //safe check whether its a image url or not
            
            NSArray* components = [url componentsSeparatedByString:@".png"];
            if(components.count > 1)
            {
                [album.imageList addObject:url];
            }
            else
            {
                components = [url componentsSeparatedByString:@".jpeg"];
                if(components.count > 1)
                {
                    [album.imageList addObject:url];
                }
                else
                {
                    components = [url componentsSeparatedByString:@".jpg"];
                    if(components.count > 1)
                    {
                        [album.imageList addObject:url];
                    }
                }
            }
            
            //safe check whether its a audio url or not
            components = [url componentsSeparatedByString:@".mp3"];
            if(components.count > 1)
            {
                [album.audioList addObject:url];
            }
            
            //checking for video
            if([[dict objectForKey:@"mmType"] intValue] == 3)
            {
                [album.videoList addObject:url];
            }
        }
    }
    
    self.sizesDict = [NSMutableDictionary new];
    for(int index = 0; index < self.albumsDict.count; ++index)
    {
        CGSize size;
        size.height = ITEM_DEFAULT_HEIGHT;
        size.width = ITEM_DEFAULT_WIDTH;
        NSValue* value = [NSValue valueWithCGSize:size];

        [self.sizesDict setObject:value forKey:[NSString stringWithFormat:@"%d", index]];
    }
    [self.collectionView reloadData];
}

-(void)setAttachmentList:(NSMutableArray *)attachmentList
{
    _attachmentList = attachmentList;
    [self populateAlbums];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.albumsDict.count;
    
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
    static NSString *CellIdentifier = @"AlbumCell";

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.layer.borderWidth = 1.0f;
    
    cell.layer.borderColor = [UIColor colorWithRed:225/255.0f green:225/255.0f blue:225/255.0f alpha:1.0f].CGColor;
    
    UILabel* nameLabel = (UILabel*)[cell viewWithTag:1];
    
    int productIndex = indexPath.item;
    if(productIndex < self.albumsDict.count)
    {
        CXAlbum* album = [self.albumsDict objectForKey:[self.albumsDict allKeys][productIndex]];
        nameLabel.text = album.albumName;
        
        NSString* imageUrl = album.coverImage;
        
        if(!imageUrl)
        {
            if(album.imageList.count > 0)
            {
                imageUrl = album.imageList[0];
            }
        }
        
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
    int productIndex = indexPath.item;
    CXAlbum* album = [self.albumsDict objectForKey:[self.albumsDict allKeys][productIndex]];

    CXMediaTabViewController* cxMediaTabViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CXMediaTabViewController"];
    cxMediaTabViewController.album  = album;
    [self.navigationController pushViewController:cxMediaTabViewController animated:YES];
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(ITEM_DEFAULT_WIDTH, ITEM_DEFAULT_HEIGHT);
    
//    NSValue* value = [self.sizesDict objectForKey:[NSString stringWithFormat:@"%d", indexPath.item]];
//    
//    return [value CGSizeValue];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}

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
