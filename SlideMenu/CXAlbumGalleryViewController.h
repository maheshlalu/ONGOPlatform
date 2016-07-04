//
//  ProductsListViewController.h
//  OnGO
//
//  Created by krish on 18/05/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCKFNavDrawer.h"

@interface CXAlbumGalleryViewController : UICollectionViewController<CCKFNavDrawerDelegate>

@property(nonatomic,retain) NSMutableArray* attachmentList;


@end
