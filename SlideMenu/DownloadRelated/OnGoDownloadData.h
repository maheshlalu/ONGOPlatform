#import "OnGoCommonConstants.h"


@interface OnGoDownloadData : NSObject

@property(strong, nonatomic) id data;
@property(strong, nonatomic) NSString* urlString;
@property(assign, nonatomic) ONGO_DATA_TYPE dataType;
@property(assign, nonatomic) ONGO_DOWNLOAD_STATUS downloadStatus;
@property(strong, nonatomic)OnGoDownloadBlock downloadFinishBlock;


@end

