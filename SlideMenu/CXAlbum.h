#import "OnGoCommonConstants.h"


@interface CXAlbum : NSObject

@property(strong, nonatomic) NSString* albumName;
@property(strong, nonatomic) NSMutableArray* audioList;
@property(strong, nonatomic) NSMutableArray* imageList;
@property(strong, nonatomic) NSMutableArray* videoList;
@property(strong, nonatomic) NSString* coverImage;


@end

