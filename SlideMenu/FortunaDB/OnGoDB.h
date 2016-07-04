#import <Foundation/Foundation.h>
@interface OnGoBase : NSObject
@property(strong, nonatomic) NSString* ItemCode;
@property(strong, nonatomic) NSString* id;
@property(strong, nonatomic) NSString* Description;
@property(strong, nonatomic) NSString* createdByFullName;
@property(strong, nonatomic) NSNumber* createdById;
@property(strong, nonatomic) NSString* publicURL;
@end



@interface OnGoUserDetails : OnGoBase
@property(strong, nonatomic) NSString* api;
@property(strong, nonatomic) NSNumber* id;
@property(strong, nonatomic) NSString* fullname;
@property(strong, nonatomic) NSString* email;
@property(strong, nonatomic) NSNumber* website;
+(OnGoUserDetails*)onGoUserDetailsForApi:(NSString*)api  FromJsonDict:(NSDictionary*)dict;
@end



@interface OnGoProductCategories : OnGoBase
@property(strong, nonatomic) NSString* Name;
@property(strong, nonatomic) NSString* StoreId;
@property(strong, nonatomic) NSString* Icon_Name;
@property(strong, nonatomic) NSString* Icon_URL;
+(OnGoProductCategories*)onGoProductsFromJsonDict:(NSDictionary*)dict;
@end



@interface OnGoStoreCategories : OnGoBase
@property(strong, nonatomic) NSString* Name;
+(OnGoStoreCategories*)onGoStoreCategoriesFromJsonDict:(NSDictionary*)dict;
@end



@interface OnGoPSubCategories : OnGoBase
@property(strong, nonatomic) NSString* Name;
@property(strong, nonatomic) NSString* MasterCategory;
@property(strong, nonatomic) NSString* Icon_Name;
@property(strong, nonatomic) NSString* Icon_URL;
+(OnGoPSubCategories*)onGoPSubCategoriesFromJsonDict:(NSDictionary*)dict;
@end



@interface OnGoP3rdCategory : OnGoBase
@property(strong, nonatomic) NSString* Name;
@property(strong, nonatomic) NSString* MasterCategory;
@property(strong, nonatomic) NSString* SubCategory;
@property(strong, nonatomic) NSString* Icon_Name;
@property(strong, nonatomic) NSString* Icon_URL;
+(OnGoP3rdCategory*)onGoP3rdCategoryFromJsonDict:(NSDictionary*)dict;
@end


// Stores
@interface OnGoStores : OnGoBase
@property(strong, nonatomic) NSString* Name;
@property(strong, nonatomic) NSString* json;
@property(strong, nonatomic) NSString* type;
@property(strong, nonatomic) NSNumber* storeDistance;
@property(strong, nonatomic) NSMutableArray* ratingList;
+(OnGoStores*)onGoStoresOfType:(NSString*)type FromJsonDict:(NSDictionary*)dict;
@end



@interface OnGoServiceCategories : OnGoBase
@property(strong, nonatomic) NSString* Name;
@property(strong, nonatomic) NSString* isSubType;
@property(strong, nonatomic) NSString* GroupName;
@property(strong, nonatomic) NSString* IsSpecialService;
+(OnGoServiceCategories*)onGoServiceCategoriesFromJsonDict:(NSDictionary*)dict;
@end



@interface OnGoServices : OnGoBase
@property(strong, nonatomic) NSNumber* id;
@property(strong, nonatomic) NSString* serviceType;
@property(strong, nonatomic) NSString* mallName;
@property(strong, nonatomic) NSNumber* mallId;
@property(strong, nonatomic) NSString* favourite;
@property(strong, nonatomic) NSString* addToCart;
+(OnGoServices*)onGoServicesTypesFromJsonDict:(NSDictionary*)dict;
@end



@interface OnGoProducts : OnGoBase
@property(strong, nonatomic) NSString* Name;
@property(strong, nonatomic) NSString* json;
@property(strong, nonatomic) NSString* type;
@property(strong, nonatomic) NSString* storeId;
@property(strong, nonatomic) NSString* ItemCode;
@property(strong, nonatomic) NSString* offerType;
@property(strong, nonatomic) NSString* favourite;
@property(strong, nonatomic) NSString* addToCart;
@property(strong, nonatomic) NSMutableArray* ratingList;

+(OnGoProducts*)onGoProductsOfType:(NSString*)type mallId:(NSString*)mallId FromJsonDict:(NSDictionary*)dict;
@end


@interface OnGoServiceField : OnGoBase
@property(strong, nonatomic) NSNumber* field_id;
@property(strong, nonatomic) NSString* type;
@property(strong, nonatomic) NSString* Name;
@property(strong, nonatomic) NSString* mandatory;
@property(strong, nonatomic) NSString* allowedValues;
@property(strong, nonatomic) NSString* multiselect;
@property(strong, nonatomic) NSString* groupName;
@property(strong, nonatomic) NSString* dependentFields;
@property(strong, nonatomic) NSString* propgateValueToSubFormFields;
@property(strong, nonatomic) NSString* addMore;
@property(strong, nonatomic) NSNumber* id;
@property(strong, nonatomic) NSString* allowedValuesResults;
@property(strong, nonatomic) NSString* serviceType;
@property(strong, nonatomic) NSString* mask;
@property(strong, nonatomic) NSString* incrementalSearch;
+(OnGoServiceField*)onGoServiceFieldFromJsonDict:(NSDictionary*)dict;
@end



@interface OnGoAllMalls : OnGoBase
@property(strong, nonatomic) NSString* mallId;
@property(strong, nonatomic) NSString* Name;
@property(strong, nonatomic) NSString* email;
@property(strong, nonatomic) NSString* offersCount;
@property(strong, nonatomic) NSString* productCount;
@property(strong, nonatomic) NSString* storesCount;
@property(strong, nonatomic) NSString* location;
@property(strong, nonatomic) NSString* street;
@property(strong, nonatomic) NSString* state;
@property(strong, nonatomic) NSString* coun_Id;
@property(strong, nonatomic) NSString* coun_Code;
@property(strong, nonatomic) NSString* coun_Name;
@property(strong, nonatomic) NSString* city;
@property(strong, nonatomic) NSString* zipCode;
@property(strong, nonatomic) NSString* mobile;
@property(strong, nonatomic) NSString* website;
@property(strong, nonatomic) NSString* logo;
@property(strong, nonatomic) NSString* facebook_Info;
@property(strong, nonatomic) NSString* twitter_Info;
@property(strong, nonatomic) NSString* LinkedIn_info;
@property(strong, nonatomic) NSArray* hrsOfOperation;
@property(strong, nonatomic) NSString* gallery;
+(OnGoAllMalls*)onGoAllMallsFromJsonDict:(NSDictionary*)dict;
@end


@interface OnGoOffers : OnGoBase
@property(strong, nonatomic) NSString* favourite;
@property(strong, nonatomic) NSString* addToCart;
@property(strong, nonatomic) NSString* json;
@property(strong, nonatomic) NSString* storeId;
@property(strong, nonatomic) NSString* offerType;
@property(strong, nonatomic) NSString* Name;
+(OnGoOffers*)onGoOffersFromJsonDict:(NSDictionary*)dict offerType:(NSString*)offerType;
@end


@interface OnGoCart : OnGoBase
@property(strong, nonatomic) NSString* Name;
@property(strong, nonatomic) NSString* Next_Seq_Nos;
@property(strong, nonatomic) NSString* OrderItems;
@property(strong, nonatomic) NSString* json;
@property(strong, nonatomic) NSString* Contact_Number;
@property(strong, nonatomic) NSString* Current_Job_Status;
@property(strong, nonatomic) NSString* Current_Job_StatusId;
@property(strong, nonatomic) NSString* NextJobStatus;
+(OnGoCart*)onGoCartFromJsonDict:(NSDictionary*)dict;
@end



@interface OnGoAttachment : OnGoBase
@property(strong, nonatomic) NSNumber* id;
@property(strong, nonatomic) NSString* Image_Name;
@property(strong, nonatomic) NSString* URL;
@property(strong, nonatomic) NSString* store_Id;
@property(strong, nonatomic) NSString* Name;
@property(strong, nonatomic) NSString* attach_Type;
@property(strong, nonatomic) NSString* prodCate_Type;

+(OnGoAttachment*)onGoAttachment:(NSDictionary*)dict;
@end



@interface OnGoLocalCart : OnGoBase
@property(strong, nonatomic) NSNumber* id;
@property(strong, nonatomic) NSString* cart_Num;
@property(strong, nonatomic) NSString* ItemCode;
@property(strong, nonatomic) NSString* Name;
@property(strong, nonatomic) NSString* Image_Name;
@property(strong, nonatomic) NSString* Image_URL;
@property(strong, nonatomic) NSString* MRP;
@property(strong, nonatomic) NSString* storeId;
@property(strong, nonatomic) NSString* QUANTITY;
@property(strong, nonatomic) NSString* UNITS;
@property(strong, nonatomic) NSString* P_CATEGERIES;
@property(strong, nonatomic) NSString* S_SUB_CATEGORIES;
@property(strong, nonatomic) NSString* DiscountType;
@property(strong, nonatomic) NSString* DiscountValue;
@property(strong, nonatomic) NSString* P3_CATEGORIES;
@property(strong, nonatomic) NSString* CateType;
@property(strong, nonatomic) NSString* favourite;
@property(strong, nonatomic) NSString* addToCart;
+(OnGoLocalCart*)onGoLocalCartFromJsonDict:(NSDictionary*)dict;
@end



@interface OnGoLoyaltyCard : OnGoBase
@property(strong, nonatomic) NSString* StoreOnGo_Reedemption_Points;
@property(strong, nonatomic) NSString* QR_Code_Path;
@property(strong, nonatomic) NSString* StoreOnGo_Total_Points;
@property(strong, nonatomic) NSString* Store_Total_Points;
@property(strong, nonatomic) NSString* Customer_Email;
@property(strong, nonatomic) NSString* Account_Number;
@property(strong, nonatomic) NSString* Store_Reedemption_Points;
@property(strong, nonatomic) NSString* QR_Code;
@property(strong, nonatomic) NSString* Store_Current_Points;
@property(strong, nonatomic) NSString* StoreOnGo_Current_Points;
+(OnGoLoyaltyCard*)onGoLoyaltyCardFromJsonDict:(NSDictionary*)dict;
@end


@interface OnGoPostedServices : OnGoBase
@property(strong, nonatomic) NSNumber* field_id;
@property(strong, nonatomic) NSString* type;
@property(strong, nonatomic) NSString* Name;
@property(strong, nonatomic) NSString* json;
+(OnGoPostedServices*)onGoPostedServicesFromJsonDict:(NSDictionary*)dict;
@end


@interface OnGoRating : OnGoBase
@property(strong, nonatomic) NSString* Id;
@property(strong, nonatomic) NSString* RatingType;
@property(strong, nonatomic) NSString* UserRatingValue;
@property(strong, nonatomic) NSString* time;
@property(strong, nonatomic) NSString* userName;
@property(strong, nonatomic) NSString* cateType;
@property(strong, nonatomic) NSString* jobTypeId;

+(OnGoRating*)onGoRatingForCateType:(NSString*)cateType ratingType:(NSString*)ratingType  FromJsonDict:(NSDictionary*)dict;
@end


@interface OnGoSpecialOffers : OnGoBase
@property(strong, nonatomic) NSString* Products;
@property(strong, nonatomic) NSString* Name;
@property(strong, nonatomic) NSString* SubTitle;
@property(strong, nonatomic) NSString* DiscountType;
@property(strong, nonatomic) NSString* DiscountValue;
@property(strong, nonatomic) NSString* ExpiredOn;
@property(strong, nonatomic) NSString* storeId;
@property(strong, nonatomic) NSString* Image_Name;
@property(strong, nonatomic) NSString* Image_URL;
@property(strong, nonatomic) NSString* addToCart;
@property(strong, nonatomic) NSString* favourite;
+(OnGoSpecialOffers*)onGoSpecialOffersFromJsonDict:(NSDictionary*)dict;
@end

#pragma mark Calender events
@interface ongoCalenderEvent : OnGoBase
@property(strong, nonatomic) NSString* ID;
@property(strong, nonatomic) NSString* Name;
@property(strong, nonatomic) NSString* json;
@property(strong, nonatomic) NSString* startDate;
@property(strong, nonatomic) NSString* endDate;
@property(strong, nonatomic) NSString* description_data;
@property(strong, nonatomic) NSString* itemCode;
@property(strong, nonatomic) NSString* createdBy;
@property (strong,nonatomic) NSString *month;
@property (strong,nonatomic) NSString *year;
+(NSString*)convertTheGmtTimeToNormalTime:(NSString*)inDate;
+ (ongoCalenderEvent*)parseTheCalenderEvents:(NSDictionary*)dict;

@end

#pragma mark Feature Products

@interface FeatureProducts : OnGoBase
@property(strong, nonatomic) NSString* ID;
@property(strong, nonatomic) NSString* Name;
@property(strong, nonatomic) NSString* json;
@property(strong, nonatomic) NSString* description_data;
@property(strong, nonatomic) NSString* itemCode;
@property(strong, nonatomic) NSString* createdBy;
@property (strong,nonatomic) NSString*jobID;
@property (strong,nonatomic) NSString *Campaign_Jobs;

+ (FeatureProducts*)parseTheCalenderEvents:(NSDictionary*)dict;

@end

@interface FeatureProductsJobs : OnGoBase

@property(strong, nonatomic) NSString* ID;
@property (strong,nonatomic) NSString *Item_Code;
@property(strong, nonatomic) NSString* createdBy;
@property (strong,nonatomic) NSString* jobTypeName;
@property (strong,nonatomic) NSString*jobID;
@property(strong, nonatomic) NSString* Name;
@property(strong, nonatomic) NSString* json;
@property(strong, nonatomic) NSString* description_data;
@property (strong,nonatomic) NSString * Image_URL;
+ (FeatureProductsJobs*)parseTheFeatureProductsJobs:(NSDictionary*)dict;
@end


/*
   NSString *keysTable = @"CREATE TABLE TABLE_KEYS (ID INTEGER PRIMARY KEY,NAME VARCHAR,JSON VARCHAR,DESCRIPTION VARCHAR,ITEM_CODE VARCHAR,jobId VARCHAR,CREATED_BY_ID VARCHAR)";
 */

@interface onGoKeys : NSObject
@property(strong, nonatomic) NSString* ID;
@property(strong, nonatomic) NSString* Name;
@property(strong, nonatomic) NSString* json;
@property(strong, nonatomic) NSString* description_data;
@property(strong, nonatomic) NSString* itemCode;
@property(strong, nonatomic) NSString* createdBy;
@property (strong,nonatomic) NSString*jobID;
+ (onGoKeys*)parseTheKeys:(NSDictionary*)dict;

@end



@interface OnGoDB : NSObject
#pragma mark - Base
+ (OnGoDB*) dbInstance;

- (id) initWithFile: (NSString*) filePathName;
- (void) close;

-(void)saveOnGoUserDetails:(OnGoUserDetails *)oNgUserDetails;

-(void)saveOnGoProductCategories:(OnGoProductCategories *)oNgProductCategories;

-(void)saveOnGoStoreCategories:(OnGoStoreCategories *)oNgStoreCategories;

-(void)saveOnGoServiceCategories:(OnGoServiceCategories *)oNgServiceCategories;

-(void)saveOnGoRating:(OnGoRating*)oNgRating;

-(void)saveOnGoAllProducts:(OnGoProducts*)oNgAllProducts;

-(void)saveOnGoOffer:(OnGoOffers*)offer;

- (void)saveCalenderEvents:(id)events;
-(void)getAllCalenderEvents:(void(^)(NSArray* services))callBackBlock;
-(void)getEvents:(NSString*)query event:(void(^)(NSArray* services))callBackBlock;


- (void)getAllProductsCategoies:(void(^)(NSArray* productCategories))callBackBlock;

- (void)getAllStoreCategoriesForMallId:(NSString*)mallId finishBlock:(void(^)(NSArray* storeCatList))callBackBlock;

// Stores
-(void) saveOnGoStores:(OnGoStores *)oNgStores;

- (void)getAllStoresOfType:(NSString*)type mallId:(NSString*)mallId block:(void(^)(NSArray* storeList))callBackBlock;


-(void)getUserDetailsForAPI:(NSString*)apiName finishBlock: (void(^)(OnGoUserDetails* user))callBackBlock;

-(void)getAllRatingForCateType:(NSString*)cateType ratingType:(NSString*)ratingType finishBlock:(void(^)(NSArray* ratingList))callBackBlock;


-(void)getAllRatingForJobTypeId:(NSString*)jobTypeId finishBlock:(void(^)(NSArray* ratingList))callBackBlock;

-(void)getAllServiceCategories:(void(^)(NSArray* services))callBackBlock;

-(void)getAllProductsOfType:(NSString*)type mallId:(NSString*)mallId block:(void(^)(NSArray* allProductLists))callBackBlock;


-(void)getAllOffersOfType:(NSString*)type mallId:(NSString *)mallId block:(void (^)(NSArray* offersList))callBackBlock;

-(void)makeFavorite:(BOOL)yesOrNo forProduct:(OnGoProducts*)product;
-(void)addToCart:(BOOL)yesOrNo forProduct:(OnGoProducts*)product;
-(void)getAllCartItems:(NSString*)type mallId:(NSString*)mallId block:(void(^)(NSArray* allCartItems))callBackBlock;
-(void)getAllFavoritesForMallId:(NSString *)mallId block:(void (^)(NSArray* favList))callBackBlock;

- (void)saveOnGoKeys:(onGoKeys*)keys;

- (void)saveFeatureProduct:(FeatureProducts*)product;
- (void)saveFeatureProductJobs:(FeatureProductsJobs*)product parentID:(NSString*)str;
//-(void)getallServicewithType:(NSString*)serviceType mallId:(NSString*)mallId block:(void(^)(NSArray* storeList))callBackBlock;
#pragma mark - Utilities
-(NSString *)uniqueID;

@end


