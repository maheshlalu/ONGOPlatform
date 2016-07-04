 
#import "OnGoDownloadOperation.h"
#import "JSONKit.h"


@implementation OnGoDownloadOperation


- (void)main
{
	@try{
        data = [NSMutableData new];
        
        if(!_downloadData.urlString)
        {
            NSLog(@" no url string:");
        }
        else
        {
            NSLog(@"_downloadData.urlString:%@",_downloadData.urlString);
            NSMutableURLRequest* urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_downloadData.urlString]];
            urlRequest.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
            urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
            [urlConnection start];
            [[NSRunLoop currentRunLoop] run];
        }
	}
	@catch(NSException *e)
	{
		NSString *logString = [NSString stringWithFormat:@"OnGoDownloadOperation::Exception while downloading URL path is %@",_downloadData.urlString];
		NSLog(@"%@ exception:%@",logString,e);
	}
	
}

-(void)cancel
{
	[urlConnection cancel];
	[super cancel];
}

-(void)dealloc
{
    [urlConnection cancel];
}

#pragma mark NSURLConnection delegate methods
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if(_delegate)
    {
        NSLog(@"Network error:%@", [error localizedDescription]);
        _downloadData.downloadStatus = DOWNLOAD_STATUS_FAILED;
        [(id)_delegate performSelectorOnMainThread:@selector(downloadOperationDidFinish:) withObject:self waitUntilDone:NO];
    }
}



- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)tData
{
    [data appendData:tData];
}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    _downloadData.downloadStatus = DOWNLOAD_STATUS_SUCCESS;
    if(_downloadData.dataType == DATA_TYPE_JSON)
    {
        _downloadData.data = [data objectFromJSONData];
    }
    else
    {
        _downloadData.data = data;
    }

    if(_delegate)
    {
        //[_delegate downloadOperationDidFinish:self];
        [(id)_delegate performSelectorOnMainThread:@selector(downloadOperationDidFinish:) withObject:self waitUntilDone:NO];
    }
}

@end