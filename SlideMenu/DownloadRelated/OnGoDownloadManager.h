

#import "OnGoCommonConstants.h"
#import "OnGoDownloadOperation.h"

@interface OnGoDownloadManager : NSObject<OnGoDownloadOperationDelegate> {
	
	NSOperationQueue *mQueueOfDownloads;
    NSMutableDictionary* mDownloadsInProgress;
}
-(void)cancelAllOperations;
+ (OnGoDownloadManager *)sharedDownloadManager;
-(void)downloadDataWithURLString:(NSString*)urlString dataType:(ONGO_DATA_TYPE)dataType finishBlock:(OnGoDownloadBlock) fortunaDownloadBlock;


@end



