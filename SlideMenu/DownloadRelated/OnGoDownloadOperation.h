
#import "OnGoCommonConstants.h"
#import "OnGoDownloadData.h"



@protocol OnGoDownloadOperationDelegate;


@interface OnGoDownloadOperation : NSOperation 
{
    NSURLConnection* urlConnection;
    NSMutableData* data;
	
}

@property(strong, nonatomic) OnGoDownloadData *downloadData;
@property(assign, nonatomic) id<OnGoDownloadOperationDelegate> delegate;



@end


//protocol declaration
@protocol OnGoDownloadOperationDelegate <NSObject>

-(void)downloadOperationDidFinish:(OnGoDownloadOperation*)downloadOperation;

@end