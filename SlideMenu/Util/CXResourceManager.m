
#import "CXResourceManager.h"



static CXResourceManager *sharedResourceManager = nil;

@implementation CXResourceManager

+ (CXResourceManager *)sharedInstance
{
    if (sharedResourceManager == nil) 
	{
        sharedResourceManager = [[super allocWithZone:NULL] init];
    }
	
    return sharedResourceManager;
}

#pragma mark -
#pragma mark  Singleton Overrides
#pragma mark -


- (id)init {

	self = [super init];
	
	if (self) {
		
        mImageMap = [NSMutableDictionary new];
	}
	
	return self;
}


- (id)copyWithZone:(NSZone *)zone {
    return self;
}


-(UIImage*)imageForPath:(NSString*)imagePathName
{
    //NSLog(@"image path %@",imagePathName);
    
    UIImage* image = [mImageMap objectForKey:imagePathName];
    if(!image)
    {
        image = [UIImage imageNamed:imagePathName];
        if(!image)
        {
            image = [[UIImage alloc] initWithContentsOfFile:imagePathName];
        }

        if(image)
        {
            [mImageMap setObject:image forKey:imagePathName];
        }
        else
        {
            NSLog(@"Couldnt find the image for :%@", imagePathName);
        }
    }
    return image;
}

-(void)setImage:(UIImage*)image forPath:(NSString*)imagePath
{
    if(image)
    {
        [mImageMap setObject:image forKey:imagePath];
    }
}


@end
