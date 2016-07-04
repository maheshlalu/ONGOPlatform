
#import "CXAlbum.h"

@implementation CXAlbum : NSObject 

-(id)init
{
    self = [super init];
    
    self.imageList = [NSMutableArray new];
    self.audioList = [NSMutableArray new];
    self.videoList = [NSMutableArray new];

    return self;
}


@end