#import <Foundation/Foundation.h>
#import "OnGoDB.h"
#import "DataBaseManager.h"

@interface DataServices : NSObject

+(DataServices*) serviceInstance;

-(void)getAllStoreCategoriesForMallId:(NSString*)mallId block:(void(^)(NSArray* storeCatList))callBackBlock;
-(void)getAllStoresOfType:(NSString*)type mallId:(NSString *)mallId finishblock:(void(^)(NSArray* storeList))callBackBlock;

- (void)getAllProductsCategoriesForMallId:(NSString*)mallId finishBlock:(void(^)(NSArray* products))callBackBlock;

-(void)getAllProductsOfType:(NSString*)type mallId:(NSString *)mallId block:(void (^)(NSArray* allProductList))callBackBlock;

-(void)getAllCustomtabItemsForCustomTabName:(NSString*)customTabName mallId:(NSString *)mallId block:(void (^)(NSArray* list))callBackBlock;
-(void)getAllCustomHtmls:(NSString*)customHtmlName mallId:(NSString *)mallId block:(void (^)(NSDictionary* list))callBackBlock;

-(void)getAllOffersOfType:(NSString*)type mallId:(NSString *)mallId block:(void (^)(NSArray* offersList))callBackBlock;

-(void)getAllRatingForJobTypeId:(NSString*)jobTypeId finishBlock:(void(^)(NSArray* ratingList))callBackBlock;

-(void)postRating:(OnGoRating*)rating userId:(NSString*)userId;

-(void)getAllServiceCategories:(void(^)(NSArray* services))callBackBlock;

-(void)postRegister:(NSString*)emailId password:(NSString*)passwrd firstName:(NSString*)firstName lastName:(NSString*)lastName mallId:(NSString*)mallId isFB:(BOOL)isFB finishblock:(void(^)(NSDictionary* response))callBackBlock;

-(void)login:(NSString*)emailId password:(NSString*)passwrd  mallId:(NSString*)mallId finishblock:(void(^)(NSDictionary* response))callBackBlock;
-(void)forgotPasswordForEmailId:(NSString*)emailId rEmailId:(NSString*)rEmaildId  mallId:(NSString*)mallId finishblock:(void(^)(NSDictionary* response))callBackBlock;
-(void)placeOrder:(NSString*)emailId mallId:(NSString*)mallId orderInfo:(NSString*)jsonInfo finishblock:(void(^)(NSDictionary* response))callBackBlock;
- (void)getAllOrdersForMallId:(NSString*)mallId userId:(NSString*)mallId   block:(void(^)(NSDictionary* response))callBackBlock;

-(void)getAllServiceHistoryItemsForServiceCategoryName:(NSString*)serviceCategoryName mallId:(NSString *)mallId userId:(NSString *)userId block:(void (^)(NSArray* list))callBackBlock;

-(void)getAllServicesInfoForMallId:(NSString *)mallId block:(void (^)(NSArray* list))callBackBlock;

-(void)getFormInformationMallId:(NSString *)mallId block:(void (^)(NSArray* list))callBackBlock;

-(void)getCalenderInformationMallId:(NSString *)mallId block:(void (^)(NSArray* list))callBackBlock;



-(void)getLoyaltyInfoForMallId:(NSString *)mallId emailId:(NSString *)emailId   block:(void (^)(NSDictionary* dict))callBackBlock;


-(void)registerForPushNotification:(NSString *)deviceId block:(void (^)(NSDictionary* dict))callBackBlock;
-(void)updateProfile:(NSDictionary *)dict mallId:(NSString*)mallId  finishblock:(void(^)(NSDictionary* response))callBackBlock;
-(void)changePassword:(NSDictionary *)dict mallId:(NSString*)mallId  finishblock:(void(^)(NSDictionary* response))callBackBlock;
-(void)getCountries:(NSString *)deviceId block:(void (^)(NSArray* list))callBackBlock;

-(void)getKeys:(NSString *)mallId finishblock:(void(^)(NSArray* storeList))callBackBlock;


- (void)getFeatureProduct:(NSString*)mallId block:(void (^)(NSArray* list))callBackBlock;

- (void)getNotificatin:(NSString*)mallId block:(void(^)(NSArray *list))callBackBlock;


@end
