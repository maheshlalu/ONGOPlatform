#import "OnGoDownloadManager.h"



@implementation OnGoDownloadManager

static OnGoDownloadManager *sharedDownloadManager = nil;
+ (OnGoDownloadManager *)sharedDownloadManager
{
	if (sharedDownloadManager == nil) 
	{
        sharedDownloadManager = [[super allocWithZone:NULL] init];
    }
	
    return sharedDownloadManager;
}
- (id) init
{

	self = [super init];
	if (self != nil) {
		mQueueOfDownloads = [[NSOperationQueue alloc] init];
        mDownloadsInProgress = [NSMutableDictionary new];
		[mQueueOfDownloads setMaxConcurrentOperationCount:NSOperationQueueDefaultMaxConcurrentOperationCount];
	}
	return self;
}

-(void)downloadDataWithURLString:(NSString*)urlString dataType:(ONGO_DATA_TYPE)dataType finishBlock:(OnGoDownloadBlock) OnGoDownloadBlock
{
    if(![mDownloadsInProgress objectForKey:urlString])
    {
        OnGoDownloadData* downloadData = [OnGoDownloadData new];
        downloadData.urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        downloadData.dataType = dataType;
        downloadData.downloadFinishBlock = OnGoDownloadBlock;
        [mDownloadsInProgress setObject:downloadData.urlString forKey:downloadData.urlString];
        
        OnGoDownloadOperation *downloadOperation = [OnGoDownloadOperation new];
        downloadOperation.downloadData = downloadData;
        downloadOperation.delegate = self;
        [mQueueOfDownloads addOperation:downloadOperation];
    }
}

-(void)cancelAllOperations
{
	[mQueueOfDownloads cancelAllOperations];
}

-(void)downloadOperationDidFinish:(OnGoDownloadOperation*)downloadOperation
{
    downloadOperation.downloadData.downloadFinishBlock(downloadOperation.downloadData);
    [mDownloadsInProgress removeObjectForKey:downloadOperation.downloadData.urlString];

//    if(downloadOperation.downloadData.downloadStatus == DOWNLOAD_STATUS_SUCCESS)
//    {
//        downloadOperation.downloadData.downloadFinishBlock(downloadOperation.downloadData);
//    }
//    else
//    {
//        NSLog(@"Connectivity Problem for url:%@", downloadOperation.downloadData.urlString);
//    }
}

@end
