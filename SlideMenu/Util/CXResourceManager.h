
@interface CXResourceManager : NSObject {
	
	NSMutableDictionary *mImageMap;
}

+ (CXResourceManager *)sharedInstance;



-(UIImage*)imageForPath:(NSString*)imagePathName;//by default it will be of type .png
-(void)setImage:(UIImage*)image forPath:(NSString*)imagePath;

@end
