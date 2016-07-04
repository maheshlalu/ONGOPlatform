                                                                                                                               
#import "OnGoDB.h"
#import "ABSQLiteDB.h"
#import "NSString+Additions.h"
#import "JSONKit.h"
#import "DataBaseManager.h"
#import "Base64.h"
#define DB_FILE_NAME @"OnGoSmartDB"
#define DB_FILE_NAME_WITH_EXT @"OnGoSmartDB.sqlite"

@implementation OnGoBase



@end


@implementation OnGoUserDetails

+(OnGoUserDetails*)onGoUserDetailsForApi:(NSString*)api  FromJsonDict:(NSDictionary*)dict;
{
    OnGoUserDetails* oNgUserDetails = [OnGoUserDetails new];
    oNgUserDetails.api = api;
    oNgUserDetails.id = [dict objectForKey:@"id"];
    oNgUserDetails.fullname = [dict objectForKey:@"fullname"];
    oNgUserDetails.email = [dict objectForKey:@"email"];
    oNgUserDetails.website = [dict objectForKey:@"website"];
    return  oNgUserDetails;
}


@end


@implementation OnGoProductCategories

+(OnGoProductCategories*)onGoProductsFromJsonDict:(NSDictionary*)dict;
{
    OnGoProductCategories* oNgProductCategories = [OnGoProductCategories new];
    oNgProductCategories.ItemCode = [dict objectForKey:@"ItemCode"];
    oNgProductCategories.id = [dict objectForKey:@"id"];
    oNgProductCategories.Description = [dict objectForKey:@"Description"];
    oNgProductCategories.createdByFullName = [dict objectForKey:@"createdByFullName"];
    oNgProductCategories.createdById = [dict objectForKey:@"createdById"];
    oNgProductCategories.publicURL = [dict objectForKey:@"publicURL"];
    oNgProductCategories.Name=[dict objectForKey:@"Name"];
    oNgProductCategories.StoreId=[dict objectForKey:@"StoreId"];
    oNgProductCategories.Icon_Name = [dict objectForKey:@"Icon_Name"];
    oNgProductCategories.Icon_URL = [dict objectForKey:@"Icon_URL"];
    
    return oNgProductCategories;
}

@end


@implementation OnGoStoreCategories

+(OnGoStoreCategories*)onGoStoreCategoriesFromJsonDict:(NSDictionary*)dict
{
    OnGoStoreCategories* oNgStoreCategories = [OnGoStoreCategories new];
    oNgStoreCategories.ItemCode = [dict objectForKey:@"ItemCode"];
    oNgStoreCategories.Name = [dict objectForKey:@"Name"];
    oNgStoreCategories.createdByFullName = [dict objectForKey:@"createdByFullName"];
    oNgStoreCategories.createdById = [dict objectForKey:@"createdById"];
    oNgStoreCategories.publicURL = [dict objectForKey:@"publicURL"];
    oNgStoreCategories.id = [dict objectForKey:@"id"];
    return oNgStoreCategories;
}


@end

@implementation OnGoPSubCategories
+(OnGoPSubCategories*)onGoPSubCategoriesFromJsonDict:(NSDictionary*)dict;
{
    OnGoPSubCategories* oNgPSubcategories = [OnGoPSubCategories new];
    
    oNgPSubcategories.ItemCode = [dict objectForKey:@"ItemCode"];
    oNgPSubcategories.Name = [dict objectForKey:@"Name"];
    oNgPSubcategories.createdByFullName = [dict objectForKey:@"createdByFullName"];
    oNgPSubcategories.createdById = [dict objectForKey:@"createdById"];
    oNgPSubcategories.publicURL = [dict objectForKey:@"publicURL"];
    oNgPSubcategories.id = [dict objectForKey:@"id"];
    oNgPSubcategories.Icon_Name = [dict objectForKey:@"Icon_Name"];
    oNgPSubcategories.Icon_URL = [dict objectForKey:@"Icon_URL"];
    oNgPSubcategories.MasterCategory = [dict objectForKey:@"MasterCategory"];
    
    return oNgPSubcategories;
}
@end


@implementation OnGoP3rdCategory

+(OnGoP3rdCategory*)onGoP3rdCategoryFromJsonDict:(NSDictionary*)dict
{
    OnGoP3rdCategory* oNgP3rdCategories = [OnGoP3rdCategory new];
    oNgP3rdCategories.ItemCode = [dict objectForKey:@"ItemCode"];
    oNgP3rdCategories.createdByFullName = [dict objectForKey:@"createdByFullName"];
    oNgP3rdCategories.createdById = [dict objectForKey:@"createdById"];
    oNgP3rdCategories.publicURL = [dict objectForKey:@"publicURL"];
    oNgP3rdCategories.id = [dict objectForKey:@"id"];
    oNgP3rdCategories.Name = [dict valueForKey:@"Name"];
    oNgP3rdCategories.MasterCategory = [dict valueForKey:@"MasterCategory"];
    oNgP3rdCategories.SubCategory = [dict valueForKey:@"SubCategory"];
    oNgP3rdCategories.Icon_Name = [dict valueForKey:@"Icon_Name"];
    oNgP3rdCategories.Icon_URL = [dict valueForKey:@"Icon_URL"];
    
    return oNgP3rdCategories;
}


@end

@implementation OnGoStores
+(OnGoStores*)onGoStoresOfType:(NSString*)type FromJsonDict:(NSDictionary*)dict
{
    OnGoStores* oNgStores = [OnGoStores new];
    oNgStores.id = [dict objectForKey:@"id"];
    oNgStores.Name = [dict objectForKey:@"Name"];
    oNgStores.json = [dict JSONString];
    oNgStores.type = type;
    oNgStores.createdById = [dict objectForKey:@"createdById"];
    
    return oNgStores;
}

@end


@implementation OnGoServiceCategories
+(OnGoServiceCategories*)onGoServiceCategoriesFromJsonDict:(NSDictionary*)dict
{
    OnGoServiceCategories* oNgServiceCategories = [OnGoServiceCategories new];
    oNgServiceCategories.id = [dict objectForKey:@"id"];
    oNgServiceCategories.ItemCode = [dict objectForKey:@"ItemCode"];
    oNgServiceCategories.createdByFullName = [dict objectForKey:@"createdByFullName"];
    oNgServiceCategories.createdById = [dict objectForKey:@"createdById"];
    oNgServiceCategories.publicURL = [dict objectForKey:@"publicURL"];
    oNgServiceCategories.Name = [dict objectForKey:@"Name"];
    oNgServiceCategories.Description = [dict objectForKey:@"Description"];
    oNgServiceCategories.isSubType = [dict objectForKey:@"isSubType"];
    oNgServiceCategories.IsSpecialService = [dict objectForKey:@"IsSpecialService"];
    oNgServiceCategories.GroupName = [dict objectForKey:@"GroupName"];
    return oNgServiceCategories;
}
@end

@implementation OnGoServices

+(OnGoServices*)onGoServicesTypesFromJsonDict:(NSDictionary*)dict
{
    OnGoServices* oNgServices = [OnGoServices new];
    oNgServices.id = [dict objectForKey:@"id"];
    oNgServices.serviceType = [dict objectForKey:@"Name"];
    oNgServices.mallName = [dict objectForKey:@"Name"];
    oNgServices.mallId = [dict objectForKey:@"mallId"];
    oNgServices.favourite= [dict objectForKey:@"favourite"];
    oNgServices.addToCart = [dict objectForKey:@"addToCart"];
    return oNgServices;    
}
@end

@implementation OnGoAttachment

+(OnGoAttachment*)onGoAttachment:(NSDictionary *)dict
{
    OnGoAttachment* oNgAttachment = [OnGoAttachment new];
    oNgAttachment.id = [dict valueForKey:@"id"];
    oNgAttachment.Image_Name = [dict valueForKey:@"Image_Name"];
    oNgAttachment.URL = [dict valueForKey:@"URL"];
    oNgAttachment.store_Id = [dict valueForKey:@"store_Id"];
    oNgAttachment.Name = [dict valueForKey:@"Name"];
    oNgAttachment.attach_Type = [dict valueForKey:@"attach_Type"];
    oNgAttachment.prodCate_Type = [dict valueForKey:@"prodCate_Type"];
    
    return oNgAttachment;
}

@end


@implementation OnGoRating

+(OnGoRating*)onGoRatingForCateType:(NSString*)cateType ratingType:(NSString*)ratingType  FromJsonDict:(NSDictionary*)dict
{
    OnGoRating* oNgRating = [OnGoRating new];
    oNgRating.Id = [dict valueForKey:@"postedBy_Id"];
    oNgRating.RatingType = ratingType;
    oNgRating.Description = [dict valueForKey:@"comment"];
    oNgRating.UserRatingValue = [dict valueForKey:@"rating"];
    oNgRating.time = [dict valueForKey:@"time"];
    oNgRating.userName = [dict valueForKey:@"postedBy_Name"];
    oNgRating.cateType = cateType;
    oNgRating.jobTypeId = [dict valueForKey:@"Job_Id"];
    return oNgRating;
}

@end

@implementation OnGoProducts

+(OnGoProducts*)onGoProductsOfType:(NSString*)type mallId:(NSString*)mallId FromJsonDict:(NSDictionary*)dict{
    
    OnGoProducts* oNgAllProducts = [OnGoProducts new];
    oNgAllProducts.id = [dict valueForKey:@"id"];
    oNgAllProducts.Name = [dict valueForKey:@"Name"];
    oNgAllProducts.json = [dict JSONString];
    oNgAllProducts.type = type;
    oNgAllProducts.storeId = [dict valueForKey:@"storeId"];
    oNgAllProducts.ItemCode = [dict valueForKey:@"ItemCode"];
    oNgAllProducts.Description = [dict valueForKey:@"Description"];
    oNgAllProducts.createdByFullName = [dict valueForKey:@"createdByFullName"];
    oNgAllProducts.createdById = [dict valueForKey:@"createdById"];
    oNgAllProducts.publicURL = [dict valueForKey:@"publicURL"];

    return oNgAllProducts;
}



@end

@implementation OnGoOffers
+(OnGoOffers*)onGoOffersFromJsonDict:(NSDictionary*)dict offerType:(NSString*)offerType
{
    OnGoOffers* offer = [OnGoOffers new];
    offer.id = [dict valueForKey:@"id"];
    offer.Name = [dict valueForKey:@"Name"];
    offer.json = [dict JSONString];
    offer.offerType = offerType;
    offer.storeId = [dict valueForKey:@"storeId"];
    offer.ItemCode = [dict valueForKey:@"ItemCode"];
    offer.Description = [dict valueForKey:@"Description"];
    offer.createdByFullName = [dict valueForKey:@"createdByFullName"];
    offer.createdById = [dict valueForKey:@"createdById"];
    offer.publicURL = [dict valueForKey:@"publicURL"];

    return offer;
}

@end


@implementation ongoCalenderEvent

+ (ongoCalenderEvent*)parseTheCalenderEvents:(NSDictionary*)dict{

    ongoCalenderEvent *events = [[ongoCalenderEvent alloc]init];
    events.ID = [dict valueForKey:@"id"];
    events.Name = [dict valueForKey:@"Name"];
    //events.json = [dict JSONString];
    events.startDate = [dict valueForKey:@"startDate"];//[self convertTheGmtTimeToNormalTime:[dict valueForKey:@"startDate"]];
    events.endDate = [dict valueForKey:@"endDate"];//[self convertTheGmtTimeToNormalTime:[dict valueForKey:@"endDate"]];//[dict valueForKey:@"endDate"];
    events.description_data = [dict valueForKey:@"Description"];//[dict valueForKey:@"Description"];
    events.itemCode = [dict valueForKey:@"ItemCode"];
    events.createdBy = [dict valueForKey:@"createdById"];
    NSArray *dateArr = [self parseDate:[dict valueForKey:@"startDate"]];
    events.month = dateArr[1];
    events.year = dateArr[3];
    
    return events;
}

+ (NSArray*)parseDate:(NSString*)date{
    return  [date componentsSeparatedByString:@" "];
    
}


+(NSString*)convertTheGmtTimeToNormalTime:(NSString*)inDate{
    NSString *gmtDateString = inDate;
     NSArray *dateItems = [inDate componentsSeparatedByString:@" "];
    NSString *month = [dateItems objectAtIndex:1];
    
    NSDateFormatter *dateFormmat = [[NSDateFormatter alloc] init];
    [dateFormmat setDateFormat:@"MMM"];
    NSDate *dateMonth = [dateFormmat dateFromString:month];
    NSDateFormatter *df = [NSDateFormatter new];
   // [df setDateFormat:@"MM.dd.yy hh:mm a"];
    [df setDateFormat:@"EEE MMM dd y hh:mm:ss GMT+0000"];
    df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDate *date = [df dateFromString:gmtDateString];//Mon Apr 27 2015 09:00:00 GMT+0000
    //Create a date string in the local timezone
    df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:[NSTimeZone localTimeZone].secondsFromGMT];
    NSString *localDateString = [df stringFromDate:date];
    return localDateString;
}

@end

@implementation FeatureProducts

+ (FeatureProducts*)parseTheCalenderEvents:(NSDictionary*)dict;
{
    FeatureProducts *product = [[FeatureProducts alloc]init];
    product.ID = [dict valueForKey:@"id"];
    product.Name = [dict valueForKey:@"Name"];
    product.json = [dict JSONString];
    product.description_data = [dict valueForKey:@"Description"];
    product.createdBy = [dict valueForKey:@"createdById"];
    product.jobID = [dict valueForKey:@"jobTypeId"];
    product.Campaign_Jobs = [dict valueForKey:@"Campaign_Jobs"];
    return product;
}


@end

@implementation FeatureProductsJobs
+ (FeatureProductsJobs*)parseTheFeatureProductsJobs:(NSDictionary*)dict{
    
    FeatureProductsJobs *jobs = [[FeatureProductsJobs alloc]init];
    jobs.ID = [dict valueForKey:@"id"];
    jobs.Item_Code = [dict valueForKey:@"ItemCode"];
    jobs.createdById = [dict valueForKey:@"createdById"];
    jobs.Name = [dict valueForKey:@"Name"];
    jobs.jobTypeName = [dict valueForKey:@"jobTypeName"];
    jobs.jobID = [dict valueForKey:@"jobTypeId"];
    jobs.json = [dict JSONString];
    jobs.Image_URL = [dict valueForKey:@"Image_URL"];
    jobs.description_data = [dict valueForKey:@"Description"];
    return jobs;
}

@end

@implementation onGoKeys

+ (onGoKeys*)parseTheKeys:(NSDictionary*)dict{
    onGoKeys *keys = [[onGoKeys alloc]init];
    keys.ID = [dict valueForKey:@"id"];
    keys.Name = [dict valueForKey:@"Name"];
    keys.json = [dict JSONString];
    keys.description_data = [dict valueForKey:@"Description"];
    keys.itemCode = [dict valueForKey:@"ItemCode"];
    keys.createdBy = [dict valueForKey:@"createdById"];
    keys.jobID = @"";
  return keys;
}

@end

static OnGoDB* _dbInstance;

@interface OnGoDB()

@end

@implementation OnGoDB {
	id <ABDatabase> db;
}


#pragma mark - Base

- (id) init {
	return [self initWithFile: NULL];
}

- (id) initWithFile: (NSString*) filePathName {
	if (!(self = [super init])) return nil;
	
	_dbInstance = self;
	
	BOOL myPathIsDir;
	BOOL fileExists = [[NSFileManager defaultManager]
                       fileExistsAtPath: filePathName
                       isDirectory: &myPathIsDir];
	
	// backupDbPath allows for a pre-made database to be in the app. Good for testing
	NSString *backupDbPath = [[NSBundle mainBundle]
                              pathForResource:DB_FILE_NAME
                              ofType:@"db"];
	BOOL copiedBackupDb = NO;
	if (backupDbPath != nil) {
		copiedBackupDb = [[NSFileManager defaultManager]
                          copyItemAtPath:backupDbPath
                          toPath:filePathName
                          error:nil];
	}
	
	// open SQLite db file
	db = [[ABSQLiteDB alloc] init];
	
	if(![db connect:filePathName]) {
		return nil;
	}
	
	if(!fileExists) {
		if(!backupDbPath || !copiedBackupDb)
        {
            [self makeDB];
        }
	}
	
	//[self checkSchema]; // always check schema because updates are done here
	
	return self;
}

+ (OnGoDB*) dbInstance {
	if (!_dbInstance) {
		NSString *dbFilePath;
		NSArray *searchPaths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentFolderPath = searchPaths[0];
		dbFilePath = [documentFolderPath stringByAppendingPathComponent: DB_FILE_NAME_WITH_EXT];
		
		OnGoDB* oNGoDB = [[OnGoDB alloc] initWithFile:dbFilePath];
		if (!oNGoDB) {
			UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"File Error" message:@"Unable to open database." delegate:nil cancelButtonTitle:@"Darn" otherButtonTitles:nil];
			[alert show];
		}
	}
	
	return _dbInstance;
}


- (void) close {
	[db close];
}




#pragma mark All Stores With Type and there MallId.

- (void)getAllStoresOfType:(NSString*)type mallId:(NSString*)mallId block:(void(^)(NSArray* storeList))callBackBlock
{
    //fetch the record from TABLE_STORE_CATEGORIES
    NSMutableArray* storeList = [NSMutableArray new];
    NSString* sql = [NSString stringWithFormat:@"select * from TABLE_STORES where type = '%@'",type];
   // [db sqlExecute:sql];
    
    id <ABRecordset> results;
	results = [db sqlSelect: sql];
    while (![results eof])
    {
        OnGoStores* store = [[OnGoStores alloc] init];
        NSArray* allFields = [results allFields];
        for(ABSQLiteField* field in allFields)
        {
            [store setValue:[field stringValue] forKey:field.name];
        }
        [self getAllRatingForJobTypeId:store.id finishBlock:^(NSArray* ratingList)
         {
             store.ratingList = ratingList;
             [storeList addObject:store];
             [results moveNext];
         }];
	}
    callBackBlock(storeList);
    
}


#pragma mark Store API Start
-(void) saveOnGoStores:(OnGoStores *)oNgStores
{
    NSString* sql = [NSString stringWithFormat:@"select * from TABLE_STORES where id = '%@'",oNgStores.id];
	id<ABRecordset> results = [db sqlSelect:sql];
	if ([results eof]) {
		// add the report
		sql = [NSString stringWithFormat:@"insert into TABLE_STORES(id,Name,json,createdById,type) values('%@','%@','%@','%@','%@');", oNgStores.id,[oNgStores.Name sqlString], [oNgStores.json sqlString], oNgStores.createdById,oNgStores.type];
		[db sqlExecute:sql];
	}
}

- (void)getAllStoreCategoriesForMallId:(NSString*)mallId finishBlock:(void(^)(NSArray* storeCatList))callBackBlock
{
    NSMutableArray* store = [[NSMutableArray alloc] init];
    NSString* sql = [NSString stringWithFormat:@"select * from TABLE_STORE_CATEGORIES where id ='%@'",mallId];
    id <ABRecordset> results;
	results = [db sqlSelect: sql];
    while (![results eof])
    {
        while (![results eof])
        {
            OnGoStoreCategories* oNgStore = [[OnGoStoreCategories alloc] init];
            
            
            NSArray* allFields = [results allFields];
            for(ABSQLiteField* field in allFields)
            {
                [oNgStore setValue:[field stringValue] forKey:field.name];
            }
            [store addObject:oNgStore];
            [results moveNext];
        }
       
    }
     callBackBlock(store);
}

-(void)getUserDetailsForAPI:(NSString*)apiName finishBlock: (void(^)(OnGoUserDetails* user))callBackBlock
{
    NSString* sql = [NSString stringWithFormat:@"select * from TABLE_USER_DETAILS where api='%@'",apiName];
    id <ABRecordset> results;
    results = [db sqlSelect: sql];

    OnGoUserDetails* oNgUser = [[OnGoUserDetails alloc] init];
    while (![results eof])
        {
            NSArray* allFields = [results allFields];
            for(ABSQLiteField* field in allFields)
            {
                [oNgUser setValue:[field stringValue] forKey:field.name];
            }
            [results moveNext];
        }
        callBackBlock(oNgUser);
}

-(void)getAllRatingForCateType:(NSString*)cateType ratingType:(NSString*)ratingType finishBlock:(void(^)(NSArray* ratingList))callBackBlock
{
    NSMutableArray* rating = [[NSMutableArray alloc] init];
    NSString* sql = [NSString stringWithFormat:@"select * from TABLE_RATINGS where cateType ='%@'",cateType];
    id <ABRecordset> results;
    results = [db sqlSelect: sql];
    while (![results eof])
    {
      while (![results eof])
        {
            OnGoRating* oNgRating = [[OnGoRating alloc]init];
            NSArray* allFields = [results allFields];
            for(ABSQLiteField* field in allFields)
             {
                [oNgRating setValue:[field stringValue] forKey:field.name];
             }
             [rating addObject:oNgRating];
             [results moveNext];
        }
    }
    callBackBlock(rating);
}

-(void)getAllRatingForJobTypeId:(NSString*)jobTypeId finishBlock:(void(^)(NSArray* ratingList))callBackBlock
{
    NSMutableArray* rating = [[NSMutableArray alloc] init];
    NSString* sql = [NSString stringWithFormat:@"select * from TABLE_RATINGS where jobTypeId ='%@'",jobTypeId];
    id <ABRecordset> results;
    results = [db sqlSelect: sql];
    while (![results eof])
    {
        while (![results eof])
        {
            OnGoRating* oNgRating = [[OnGoRating alloc]init];
            NSArray* allFields = [results allFields];
            for(ABSQLiteField* field in allFields)
            {
                [oNgRating setValue:[field stringValue] forKey:field.name];
            }
            [rating addObject:oNgRating];
            [results moveNext];
        }
    }
    callBackBlock(rating);
}


#pragma mark ProductCaterories API Start

-(void)saveOnGoProductCategories:(OnGoProductCategories *)oNgProductCategories
{
    NSString* sql = [NSString stringWithFormat:@"select Name from TABLE_PRODUCT_CATEGORIES where ItemCode = '%@'",[oNgProductCategories.ItemCode sqlString]];
	id<ABRecordset> results = [db sqlSelect:sql];
	if ([results eof]) {
		// add the report
		sql = [NSString stringWithFormat:@"insert into TABLE_PRODUCT_CATEGORIES(id,ItemCode,createdByFullName,createdById,publicURL,Name,Description,StoreId,Icon_Name,Icon_URL) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@');",oNgProductCategories.id,[oNgProductCategories.ItemCode sqlString], [oNgProductCategories.createdByFullName sqlString], [oNgProductCategories.createdById sqlString], [oNgProductCategories.publicURL sqlString],[oNgProductCategories.Name sqlString], [oNgProductCategories.Description sqlString], [oNgProductCategories.StoreId sqlString], [oNgProductCategories.Icon_Name sqlString], [oNgProductCategories.Icon_URL sqlString]];
		[db sqlExecute:sql];
	}
}

-(void)saveOnGoServiceCategories:(OnGoServiceCategories *)oNgServiceCategories{
    
    NSString* sql = [NSString stringWithFormat:@"select Name from TABLE_SERVICE_CATEGORIES where Name = '%@'",[oNgServiceCategories.Name sqlString]];
	id<ABRecordset> results = [db sqlSelect:sql];
	if ([results eof]) {
        
        sql = [NSString stringWithFormat:@"insert into TABLE_SERVICE_CATEGORIES(id,ItemCode,createdByFullName,createdById,publicURL,Name,Description,isSubType,IsSpecialService,GroupName) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@');",oNgServiceCategories.id,[oNgServiceCategories.ItemCode sqlString],[oNgServiceCategories.createdByFullName sqlString],[oNgServiceCategories.createdById sqlString],[oNgServiceCategories.publicURL sqlString],[oNgServiceCategories.Name sqlString],[oNgServiceCategories.Description sqlString],[oNgServiceCategories.isSubType sqlString],[oNgServiceCategories.IsSpecialService sqlString], [oNgServiceCategories.GroupName sqlString]] ;
        [db sqlExecute:sql];
    }
}

-(void)saveOnGoStoreCategories:(OnGoStoreCategories *)oNgStoreCategories
{
    NSString* sql = [NSString stringWithFormat:@"select ItemCode from TABLE_STORE_CATEGORIES where id = '%@'",oNgStoreCategories.id];
    id<ABRecordset> results = [db sqlSelect:sql];
	if ([results eof]) {
        // add the report
		sql = [NSString stringWithFormat:@"insert into TABLE_STORE_CATEGORIES(id,createdByFullName,createdById,Name,publicURL,ItemCode)values('%@','%@','%@','%@','%@','%@');",oNgStoreCategories.id,oNgStoreCategories.createdByFullName,oNgStoreCategories.createdById,oNgStoreCategories.Name,oNgStoreCategories.publicURL,oNgStoreCategories.ItemCode];
        [db sqlExecute:sql];
        
    }
    
}

-(void)saveOnGoUserDetails:(OnGoUserDetails *)oNgUserDetails;
{
    NSString* sql; //= [NSString stringWithFormat:@"select * from TABLE_USER_DETAILS where id = '%@'",[oNgUserDetails.id sqlString]];
//	id<ABRecordset> results = [db sqlSelect:sql];
//	if ([results eof]) {
		// add the report
		sql = [NSString stringWithFormat:@"insert into TABLE_USER_DETAILS(api,id,fullname,email,website) values('%@','%@','%@','%@','%@');",[oNgUserDetails.api sqlString], oNgUserDetails.id,  [oNgUserDetails.fullname sqlString], [oNgUserDetails.email sqlString], [oNgUserDetails.website sqlString]];
		[db sqlExecute:sql];
	//}
}

-(void)saveOnGoRating:(OnGoRating*)oNgRating
{
    NSString* sql;
    
        sql = [NSString stringWithFormat:@"insert into TABLE_RATINGS(id,RatingType,Description,UserRatingValue,time,userName,cateType, jobTypeId) values('%@','%@','%@','%@','%@','%@','%@', '%@');",[oNgRating.Id sqlString],oNgRating.RatingType,[oNgRating.Description sqlString],oNgRating.UserRatingValue,oNgRating.time,oNgRating.userName,oNgRating.cateType, oNgRating.jobTypeId];
        [db sqlExecute:sql];
}


-(void)saveOnGoAllProducts:(OnGoProducts*)oNgAllProducts
{
    NSString* sql;// = [NSString stringWithFormat:@"select * from TABLE_PRODUCTS where id = '%@'",oNgAllProducts.id];
//    id<ABRecordset> results = [db sqlSelect:sql];
//	if ([results eof]) {
    
        sql = [NSString stringWithFormat:@"insert into TABLE_PRODUCTS (id,Name,json,type,storeId,ItemCode,offerType) values('%@','%@','%@','%@','%@','%@','%@');",oNgAllProducts.id,[oNgAllProducts.Name sqlString],[oNgAllProducts.json sqlString],oNgAllProducts.type,[oNgAllProducts.storeId sqlString],[oNgAllProducts.ItemCode sqlString], oNgAllProducts.offerType];
        [db sqlExecute:sql];
    //}
}


-(void)saveOnGoOffer:(OnGoOffers*)oNgAllProducts
{
    NSString* sql;// = [NSString stringWithFormat:@"select * from TABLE_PRODUCTS where id = '%@'",oNgAllProducts.id];
    //    id<ABRecordset> results = [db sqlSelect:sql];
    //	if ([results eof]) {
    
    sql = [NSString stringWithFormat:@"insert into TABLE_PRODUCTS (id,Name,json,type,storeId,ItemCode,offerType) values('%@','%@','%@','%@','%@','%@', '%@');",oNgAllProducts.id,[oNgAllProducts.Name sqlString],[oNgAllProducts.json sqlString],@"Deals",[oNgAllProducts.storeId sqlString],[oNgAllProducts.ItemCode sqlString], oNgAllProducts.offerType];
    [db sqlExecute:sql];

//    sql = [NSString stringWithFormat:@"insert into TABLE_OFFERS (id,Name,json,offerType,storeId,ItemCode) values('%@','%@','%@','%@','%@','%@');",offer.id,offer.Name,[offer.json sqlString],offer.offerType,offer.storeId,offer.ItemCode];
//    [db sqlExecute:sql];

}


- (void)saveCalenderEvents:(ongoCalenderEvent*)events{
    
    NSString *sql = [NSString stringWithFormat:@"insert into TABLE_CALENDER_EVENTS(ID,NAME,JSON,startDate,endDate,DESCRIPTION,ITEM_CODE,jobId,CREATED_BY_ID,month,year) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",events.ID,[events.Name base64EncodedString],[events.json base64EncodedString],events.startDate,events.endDate,[events.description_data base64EncodedString],events.itemCode,@"",events.createdBy,events.month,events.year];
    NSLog(@"calender event query %@",sql);
    
    BOOL success = [[DataBaseManager dataBaseManager]execute:sql];
    if (success) {
        NSLog(@"inserted in to roster successfully");
    }
}

- (void)saveOnGoKeys:(onGoKeys*)keys;
{
    
    NSString *sql = [NSString stringWithFormat:@"insert into TABLE_KEYS(ID,NAME,JSON,DESCRIPTION,ITEM_CODE,CREATED_BY_ID,jobId) values('%@','%@','%@','%@','%@','%@','%@')",keys.ID,[keys.Name base64EncodedString],[keys.json base64EncodedString],[keys.description_data base64EncodedString],keys.itemCode,keys.createdBy,@""];
    NSLog(@"query %@",sql);
    
    BOOL success = [[DataBaseManager dataBaseManager]execute:sql];
    if (success) {
        NSLog(@"inserted in to roster successfully");
    }
}

- (void)saveFeatureProduct:(FeatureProducts*)product{
    
    NSString *sql = [NSString stringWithFormat:@"insert into FEATURE_PRODUCTS(ID,NAME,JSON,DESCRIPTION,ITEM_CODE,jobId,CREATED_BY_ID,Campaign_Jobs) values('%@','%@','%@','%@','%@','%@','%@','%@')",product.ID,[product.Name base64EncodedString],[product.json base64EncodedString],[product.description_data base64EncodedString],product.itemCode,[product jobID],product.createdBy,[product Campaign_Jobs]];
    NSLog(@"query %@",sql);
    
    BOOL success = [[DataBaseManager dataBaseManager]execute:sql];
    if (success) {
        NSLog(@"inserted in to roster successfully");
    }
    /*
     
     
     */
}

- (void)saveFeatureProductJobs:(FeatureProductsJobs*)product parentID:(NSString*)str{
    NSString *sql = [NSString stringWithFormat:@"insert into FEATURE_PRODUCTS_JOBS(ID,ITEM_CODE,CREATED_BY_ID,JOBTYPENAME,jobId,NAME,JSON,DESCRIPTION,PARENT_ID,Image_URL) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",product.ID,product.Item_Code,product.createdById,product.jobTypeName,product.jobID,product.Name,[product.json base64EncodedString],[product.description base64EncodedString],str,product.Image_URL];
    NSLog(@"query %@",sql);
    
    BOOL success = [[DataBaseManager dataBaseManager]execute:sql];
    if (success) {
        NSLog(@"inserted in to roster successfully");
    }

}


//-(void)getAllCalenderEvents:(void(^)(NSArray* services))callBackBlock
//{
//    NSMutableArray* services = [[NSMutableArray alloc] init];
//    NSString* sql = [NSString stringWithFormat:@"select * from TABLE_CALENDER_EVENTS"];
//    id <ABRecordset> results;
//    results = [db sqlSelect: sql];
//    
//    while (![results eof])
//    {
//        ongoCalenderEvent* oNgServices = [[ongoCalenderEvent alloc]init];
//        NSArray* allFields = [results allFields];
//        for(ABSQLiteField* field in allFields)
//        {
//            [oNgServices setValue:[field stringValue] forKey:field.name];
//        }
//        [services addObject:oNgServices];
//        [results moveNext];
//    }
//    callBackBlock(services);
//}

-(void)getEvents:(NSString*)query event:(void(^)(NSArray* services))callBackBlock;
{
    NSMutableArray* services = [[NSMutableArray alloc] init];
    id <ABRecordset> results;
    results = [db sqlSelect: query];
    
    while (![results eof])
    {
        ongoCalenderEvent* oNgServices = [[ongoCalenderEvent alloc]init];
        NSArray* allFields = [results allFields];
        for(ABSQLiteField* field in allFields)
        {
            [oNgServices setValue:[field stringValue] forKey:field.name];
        }
        [services addObject:oNgServices];
        [results moveNext];
    }
    callBackBlock(services);
    
}


#pragma mark ProductCategories API Start

- (void)getAllProductsCategoies:(void(^)(NSArray* products))callBackBlock
{
    NSMutableArray* products = [[NSMutableArray alloc] init];
                                                                                               
    NSString* sql = [NSString stringWithFormat:@"select * from TABLE_PRODUCT_CATEGORIES"];
    id <ABRecordset> results;
	results = [db sqlSelect: sql];
    
    while (![results eof])
    {
        OnGoProductCategories* oNgproducts = [[OnGoProductCategories alloc] init];
        NSArray* allFields = [results allFields];
        for(ABSQLiteField* field in allFields)
        {
            [oNgproducts setValue:[field stringValue] forKey:field.name];
        }
        [products addObject:oNgproducts];
		[results moveNext];
	}
    callBackBlock(products);
}


-(void)getAllServiceCategories:(void(^)(NSArray* services))callBackBlock
{
    NSMutableArray* services = [[NSMutableArray alloc] init];
    NSString* sql = [NSString stringWithFormat:@"select * from TABLE_SERVICE_CATEGORIES"];
    id <ABRecordset> results;
	results = [db sqlSelect: sql];
    
    while (![results eof])
    {
        OnGoServiceCategories* oNgServices = [[OnGoServiceCategories alloc]init];
        NSArray* allFields = [results allFields];
        for(ABSQLiteField* field in allFields)
        {
            [oNgServices setValue:[field stringValue] forKey:field.name];
        }
        [services addObject:oNgServices];
        [results moveNext];
	}
    callBackBlock(services);
}


-(void)getAllProductsOfType:(NSString*)type mallId:(NSString*)mallId block:(void(^)(NSArray* allProductList))callBackBlock
{
    NSMutableArray* allProductList = [[NSMutableArray alloc]init];
    NSString* sql = [NSString stringWithFormat:@"select * from TABLE_PRODUCTS where type = '%@'",type];
    id <ABRecordset> results;
	results = [db sqlSelect: sql];
    
    while (![results eof])
    {
        OnGoProducts* oNgProducts = [[OnGoProducts alloc]init];
        NSArray* allFields = [results allFields];
        for(ABSQLiteField* field in allFields)
        {
            [oNgProducts setValue:[field stringValue] forKey:field.name];
        }
        
        [self getAllRatingForJobTypeId:oNgProducts.id finishBlock:^(NSArray* ratingList)
         {
             oNgProducts.ratingList = ratingList;
             [allProductList addObject:oNgProducts];
             [results moveNext];
         }];
	}
   callBackBlock(allProductList);
    
}



-(void)getAllOffersOfType:(NSString*)type mallId:(NSString *)mallId block:(void (^)(NSArray* offersList))callBackBlock
{
    NSMutableArray* allProductList = [[NSMutableArray alloc]init];
    NSString* sql = [NSString stringWithFormat:@"select * from TABLE_PRODUCTS where type = 'Deals' AND offerType = '%@'",type];
    id <ABRecordset> results;
	results = [db sqlSelect: sql];
    
    while (![results eof])
    {
        OnGoProducts* oNgProducts = [[OnGoProducts alloc]init];
        NSArray* allFields = [results allFields];
        for(ABSQLiteField* field in allFields)
        {
            [oNgProducts setValue:[field stringValue] forKey:field.name];
        }
        [self getAllRatingForJobTypeId:oNgProducts.id finishBlock:^(NSArray* ratingList)
         {
             oNgProducts.ratingList = ratingList;
             [allProductList addObject:oNgProducts];
             [results moveNext];
         }];
	}
    callBackBlock(allProductList);

}

-(void)makeFavorite:(BOOL)yesOrNo forProduct:(OnGoProducts*)product
{
    NSString* valueToSet = @"";
    if(yesOrNo)
        valueToSet = @"1";
    
    
    NSString* sql = [NSString stringWithFormat:@"update TABLE_PRODUCTS set favourite = '%@' where id = '%@'",valueToSet, product.id];
    id <ABRecordset> results;
	results = [db sqlSelect: sql];
    
    product.favourite = valueToSet;
}


-(void)getAllCartItems:(NSString*)type mallId:(NSString*)mallId block:(void(^)(NSArray* allCartItems))callBackBlock
{
    NSMutableArray* allProductList = [[NSMutableArray alloc]init];
    NSString* sql = [NSString stringWithFormat:@"select * from TABLE_PRODUCTS where addToCart = '1'"];
    id <ABRecordset> results;
	results = [db sqlSelect: sql];
    
    while (![results eof])
    {
        OnGoProducts* oNgProducts = [[OnGoProducts alloc]init];
        NSArray* allFields = [results allFields];
        for(ABSQLiteField* field in allFields)
        {
            [oNgProducts setValue:[field stringValue] forKey:field.name];
        }
        [allProductList addObject:oNgProducts];
        [results moveNext];

	}
    callBackBlock(allProductList);
    
}


-(void)getAllFavoritesForMallId:(NSString *)mallId block:(void (^)(NSArray* favList))callBackBlock
{
    NSMutableArray* allProductList = [[NSMutableArray alloc]init];
    NSString* sql = [NSString stringWithFormat:@"select * from TABLE_PRODUCTS where favourite = '1'"];
    id <ABRecordset> results;
	results = [db sqlSelect: sql];
    
    while (![results eof])
    {
        OnGoProducts* oNgProducts = [[OnGoProducts alloc]init];
        NSArray* allFields = [results allFields];
        for(ABSQLiteField* field in allFields)
        {
            [oNgProducts setValue:[field stringValue] forKey:field.name];
        }
        [allProductList addObject:oNgProducts];
        [results moveNext];
        
	}
    callBackBlock(allProductList);
}

-(void)addToCart:(BOOL)yesOrNo forProduct:(OnGoProducts*)product
{
    NSString* valueToSet = @"";
    if(yesOrNo)
        valueToSet = @"1";
    
    
    NSString* sql = [NSString stringWithFormat:@"update TABLE_PRODUCTS set addToCart = '%@' where id = '%@'",valueToSet, product.id];
    id <ABRecordset> results;
	results = [db sqlSelect: sql];
    
    product.addToCart = valueToSet;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"loadCartInformation" object:nil];


}


#pragma mark - Utilities

- (void)makeDB
{
    
//    [db sqlExecute:@"CREATE TABLE TABLE_ALLMALLS [(id VARCHAR,Name VARCHAR PRIMARY KEY,email VARCHAR,Description VARCHAR,Offerscount VARCHAR,Productcount VARCHAR,storesCount VARCHAR,Location VARCHAR,Street VARCHAR,State VARCHAR,Coun_Id VARCHAR,Coun_Code VARCHAR,Coun_Name VARCHAR,City VARCHAR,Zipcode VARCHAR,mobile VARCHAR,website VARCHAR,logo VARCHAR,fbInfo VARCHAR,twitterInfo VARCHAR,LIinfo VARCHAR,hrsOfOperation VARCHAR,gallery VARCHAR)" ];
    
    [db sqlExecute:@"CREATE TABLE TABLE_ATTACHMENT (id INTEGER PRIMARY KEY AUTOINCREMENT,Image_Name VARCHAR,URL VARCHAR,store_Id VARCHAR,Name VARCHAR,attach_Type VARCHAR,prodCate_Type VARCHAR)"];
    
    [db sqlExecute:@"CREATE TABLE TABLE_CART (id VARCHAR,ItemCode VARCHAR PRIMARY KEY,createdByFullName VARCHAR,createdById VARCHAR,publicURL VARCHAR,Name VARCHAR,Next_Seq_Nos VARCHAR,OrderItems VARCHAR,json VARCHAR,Contact_Number VARCHAR,Current_Job_Status VARCHAR,Current_Job_StatusId VARCHAR,NextJobStatus VARCHAR)"];
    
    [db sqlExecute:@"CREATE TABLE TABLE_LOCAL_CART (id VARCHAR,CART_NUM INTEGER PRIMARY KEY AUTOINCREMENT,ItemCode VARCHAR UNIQUE,createdByFullName VARCHAR,createdById VARCHAR,publicURL VARCHAR,Name VARCHAR,Image_Name VARCHAR,Image_URL VARCHAR,MRP VARCHAR,Description VARCHAR,storeId VARCHAR,QUANTITY VARCHAR,UNITS VARCHAR,P_CATEGERIES VARCHAR,S_SUB_CATEGORIES VARCHAR,DiscountType VARCHAR,DiscountValue VARCHAR,P3_CATEGORIES VARCHAR,CateType VARCHAR,favourite VARCHAR,Cart_Quantity VARCHAR,addToCart VARCHAR)"];
    
    [db sqlExecute:@"CREATE TABLE TABLE_LOYALTYCARD (StoreOnGo_Reedemption_Points VARCHAR,QR_Code_Path VARCHAR PRIMARY KEY,StoreOnGo_Total_Points VARCHAR,Store_Total_Points VARCHAR,Customer_Email VARCHAR,Account_Number VARCHAR,Store_Reedemption_Points VARCHAR,QR_Code VARCHAR,Store_Current_Points VARCHAR,StoreOnGo_Current_Points VARCHAR)"];
    
    [db sqlExecute:@"CREATE TABLE TABLE_OFFERS (id VARCHAR UNIQUE,ItemCode VARCHAR PRIMARY KEY,createdById VARCHAR,favourite VARCHAR,addToCart VARCHAR,json VARCHAR,storeId VARCHAR,offerType VARCHAR,Name VARCHAR)"];
    
    
    [db sqlExecute:@"CREATE TABLE TABLE_POSTED_SERVICES (field_id INTEGER PRIMARY KEY AUTOINCREMENT,type VARCHAR,Name VARCHAR,id VARCHAR,json VARCHAR)"];
    
    [db sqlExecute:@"CREATE TABLE TABLE_PRODUCTS (id INTEGER PRIMARY KEY,Name VARCHAR,json VARCHAR,type VARCHAR,storeId VARCHAR,ItemCode VARCHAR,favourite VARCHAR,addToCart VARCHAR, offerType VARCHAR)"];
    
    [db sqlExecute:@"CREATE TABLE TABLE_PRODUCT_CATEGORIES (id VARCHAR,ItemCode VARCHAR PRIMARY KEY,createdByFullName VARCHAR,createdById VARCHAR,publicURL VARCHAR,Name VARCHAR,Description VARCHAR,storeId VARCHAR,Icon_Name VARCHAR,Icon_URL VARCHAR)"];
    
    [db sqlExecute:@"CREATE TABLE TABLE_P_3rd_CATEGORIES (id VARCHAR,ItemCode VARCHAR PRIMARY KEY,createdByFullName VARCHAR,createdById VARCHAR,publicURL VARCHAR,Name VARCHAR,MasterCategory VARCHAR,SubCategory VARCHAR,Icon_Name VARCHAR,Icon_URL VARCHAR)"];
    
    [db sqlExecute:@"CREATE TABLE TABLE_P_SUB_CATEGORIES (id VARCHAR,ItemCode VARCHAR PRIMARY KEY,createdByFullName VARCHAR,createdById VARCHAR,publicURL VARCHAR,Name VARCHAR,MasterCategory VARCHAR,Icon_Name VARCHAR,Icon_URL VARCHAR)"];
    
    [db sqlExecute:@"CREATE TABLE TABLE_RATINGS (id VARCHAR,RatingType VARCHAR,Description VARCHAR,UserRatingValue VARCHAR,time VARCHAR,userName VARCHAR,cateType VARCHAR, jobTypeId VARCHAR)"];
    
    [db sqlExecute:@"CREATE TABLE TABLE_SERVICES (id INTEGER PRIMARY KEY AUTOINCREMENT,serviceType VARCHAR,mallName VARCHAR,mallId VARCHAR,favourite VARCHAR,addToCart VARCHAR)"];
    
    
    [db sqlExecute:@"CREATE TABLE TABLE_SERVICE_CATEGORIES (id VARCHAR,ItemCode VARCHAR PRIMARY KEY,createdByFullName VARCHAR,createdById VARCHAR,publicURL VARCHAR,Name VARCHAR,Description VARCHAR,isSubType VARCHAR,IsSpecialService VARCHAR,GroupName VARCHAR)"];
    
    [db sqlExecute:@"CREATE TABLE TABLE_SERVICE_FIELD (field_id INTEGER PRIMARY KEY AUTOINCREMENT,type VARCHAR,Name VARCHAR,mandatory VARCHAR,allowedValues VARCHAR,multiselect VARCHAR,groupName VARCHAR,dependentFields VARCHAR,propgateValueToSubFormFields VARCHAR,addMore VARCHAR,id VARCHAR,allowedValuesResults VARCHAR,serviceType VARCHAR,mask VARCHAR,incrementalSearch VARCHAR)"];
    
    [db sqlExecute:@"CREATE TABLE TABLE_SPE_OFFERS (id VARCHAR,ItemCode VARCHAR PRIMARY KEY,createdByFullName VARCHAR,createdById VARCHAR,publicURL VARCHAR,Products VARCHAR,Name VARCHAR,Description VARCHAR,SubTitle VARCHAR,DiscountType VARCHAR,DiscountValue VARCHAR,ExpiredOn VARCHAR,storeId VARCHAR,Image_Name VARCHAR,Image_URL VARCHAR,addToCart VARCHAR,favourite VARCHAR)"];
    
    
    [db sqlExecute:@"CREATE TABLE TABLE_STORES (id VARCHAR PRIMARY KEY,Name VARCHAR,json VARCHAR,type VARCHAR,createdById VARCHAR)"];
    
    
    [db sqlExecute:@"CREATE TABLE TABLE_STORE_CATEGORIES (id INTEGER PRIMARY KEY AUTOINCREMENT,createdByFullName VARCHAR,createdById VARCHAR,Name VARCHAR,publicURL VARCHAR,ItemCode VARCHAR)"];
    
    
    [db sqlExecute:@"CREATE TABLE TABLE_USER_DETAILS (api VARCHAR,id VARCHAR,fullname VARCHAR,email VARCHAR,website VARCHAR)"];
    
    [db sqlExecute:@"CREATE TABLE TABLE_CALENDER_EVENTS (ID INTEGER PRIMARY KEY,NAME VARCHAR,JSON VARCHAR,startDate VARCHAR,endDate VARCHAR,DESCRIPTION VARCHAR,ITEM_CODE VARCHAR,jobId VARCHAR,CREATED_BY_ID VARCHAR,month VARCHAR,year VARCHAR )"];
    
    
    /*
     private String createTableEvents = "CREATE TABLE IF NOT EXISTS "
     + TableEvents + " (" + ID + " INTEGER PRIMARY KEY," + NAME
     + " VARCHAR," + JSON + " VARCHAR," + startDate + " VARCHAR,"
     + endDate + " VARCHAR," + DESCRIPTION + " VARCHAR," + ITEM_CODE
     + " VARCHAR," + jobId + " VARCHAR," + CREATED_BY_ID + " VARCHAR"
     + ")";
     */
    
}

- (NSString *)uniqueID {
	CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
	NSString *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuid);
	CFRelease(uuid);
	
	return uuidString;
}

- (NSString*)escapeText:(NSString*)text {
	NSString* newValue = [text stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
	return newValue;
}



@end




