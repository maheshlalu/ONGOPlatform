    //
//  DataServices.m
//  StressTest
//
//  Created by Aaron Bratcher on 06/28/2013.
//  Copyright (c) 2013 Aaron L. Bratcher. All rights reserved.
//

#import "DataServices.h"
#import "OnGoDB.h"
#import "OnGoDownloadManager.h"
#import "JSONKit.h"



NSString* const GetProductCategoriesURL = @"http://52.74.52.134:8081/Services/getMasters?type=ProductCategories&mallId=%@";

NSString* const GetStoreCategoriesURL = @"http://52.74.52.134:8081/Services/getMasters?type=StoreCategories&mallId=%@";

NSString* const GetaddMacIdURL = @"http://52.74.52.134:8081/MobileAPIs/postedJobs?type=MacIdInfo";

NSString* const GetChangeJobStatusURL = @"http://52.74.52.134:8081/Services/updateConsumerJobMetaData?";

NSString* const GetRegisterMacIdURL = @"http://52.74.52.134:8081/Services/registerMacId?";

NSString* const GetPSubCategoriesURL = @"http://52.74.52.134:8081/Services/getMasters?type=PSubCategories&mallId=%@";

NSString* const GetP3rdCategoryURL = @"http://52.74.52.134:8081/Services/getMasters?type=P3rdLevelCategories&mallId=%@";

NSString* const GetStoresURL = @"http://52.74.52.134:8081/Services/getMasters?type=%@&mallId=%@";

NSString* const GetCustomTabItemsURL = @"http://52.74.52.134:8081/Services/getMasters?type=%@&mallId=%@";

NSString* const GetCustomHtmlsURL = @"http://52.74.52.134:8081/MobileAPIs/getCustomJobs?category=%@&mallId=%@";

NSString* const GetServiceCategoriesURL = @"http://52.74.52.134:8081/Services/getMasters?type=ServicesCategories&mallId=%@";

NSString* const GetServiceJobTypesURL = @"http://52.74.52.134:8081/Services/getMasters?type=allServicesJobTypes&mallId=%@";

NSString* const GetProductJobTypesURL = @"http://52.74.52.134:8081/Services/getMasters?type=allJobTypes&mallId=%@";

NSString* const GetAllProductsURL = @"http://52.74.52.134:8081/Services/getMasters?type=%@&mallId=%@";

NSString* const GetmyServicesURL = @"http://52.74.52.134:8081/Services/getMyJobs?mallId=134&type=%@";

NSString* const GetSubServiceURL = @"http://52.74.52.134:8081/Services/getMyJobs?jobId=%d";

NSString* const GetMallInfoURL = @"http://52.74.52.134:8081/Services/getMasters?mallId=%@&type=singleMall";

NSString* const GetRegisteredURL = @"http://52.74.52.134:8081/MobileAPIs/regAndloyaltyAPI?";

NSString* const GetUpdateProfileURL = @"http://52.74.52.134:8081/MobileAPleIs/updateUserDetails?";

NSString* const GetLoginDataURL = @"http://52.74.52.134:8081/MobileAPIs/loginConsumerForOrg?";

NSString* const Getchange_PwdURL = @"http://52.74.52.134:8081/MobileAPIs/changePassword?";

NSString* const Postforgot_PwdURL = @"http://52.74.52.134:8081/MobileAPIs/forgotpwd?";

NSString* const GetOffersURL = @"http://52.74.52.134:8081/Services/getMasters?type=%@&mallId=%@";

NSString* const GetSpecial_OffersURL = @"http://52.74.52.134:8081/Services/getMasters?type=SpecificOffers&mallId=%@";

NSString* const GetUpdateURL = @"http://52.74.52.134:8081/MobileAPIs/updateUserDetails?";

NSString* const GetCountriesURL = @"http://52.74.52.134:8081/Services/countries";

NSString* const PostReviewsURL = @"http://52.74.52.134:8081/jobs/saveJobCommentJSON?jobId=%@&userId=%@&comment=%@&rating=%@";

NSString* const PostLoyalityURL = @"http://52.74.52.134:8081/MobileAPIs/createORGetJobInstance?";

NSString* const PostServicesURL = @"http://52.74.52.134:8081/MobileAPIs/postedJobs?";

NSString* const PostCartURL = @"http://52.74.52.134:8081/MobileAPIs/postedJobs?";

NSString* const GetCartURL = @"http://52.74.52.134:8081/services/getMyJobs?mallId=134&type=Cart;18|Draft";

NSString* const GetLoyaltyCardURL = @"http://52.74.52.134:8081/MobileAPIs/getLoyaltyPointsCard?email=%@&ownerId=%@";


NSString* const POSTORDER_URL = @"http://52.74.52.134:8081/MobileAPIs/postedJobs?type=PlaceOrder&";

NSString* const GetAllORDERS_URL = @"http://52.74.52.134:8081/Services/getMasters?";
NSString* const UpdateProfile_URL = @"http://52.74.52.134:8081/MobileAPIs/updateUserDetails?";

NSString *const CalenderEvents  = @"http://52.74.52.134:8081/Services/getMasters?type=CalenderEvents&mallId=%@";

NSString *const keys = @"http://52.74.52.134:8081/Services/getMasters?type=Keys&mallId=%@&unlimited=true";

NSString *const featureProduct = @"http://52.74.52.134:8081/Services/getMasters?type=Featured Products&mallId=%@";//http://52.74.52.134:8081/Services/getMasters?jobId=54830

NSString *const featureProductsJob = @"http://52.74.52.134:8081/Services/getMasters?jobId=%@";

static DataServices* _dataServices;


@implementation DataServices


-(id) init {
	if (!(self = [super init])) return nil;
	
	return self;
}

+(DataServices*) serviceInstance {
	if (!_dataServices) {
		_dataServices = [[DataServices alloc] init];
	}
	
	return _dataServices;
}

- (void)getAllProductsCategoriesForMallId:(NSString*)mallId finishBlock:(void(^)(NSArray* products))callBackBlock{
	[[OnGoDB dbInstance] getAllProductsCategoies:^(NSArray *products) {
		if (products.count == 0) {
            NSString* urlString = [NSString stringWithFormat:GetProductCategoriesURL,mallId];

            [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:urlString dataType:DATA_TYPE_JSON finishBlock:^(OnGoDownloadData *downloadData){
                NSMutableArray* productList = [NSMutableArray new];
                NSString* api = @"ProductCategories";
                
                NSArray* productJsonList = [downloadData.data objectForKey:@"jobs"];
                for(NSDictionary* jsonDict in productJsonList)
                {
                    OnGoProductCategories* productCat = [OnGoProductCategories onGoProductsFromJsonDict:jsonDict];
                    [productList addObject:productCat];
                    [[OnGoDB dbInstance] saveOnGoProductCategories:productCat];
                }
                //User Details for ProductCategories Api
                NSDictionary* userDetailJsonDict = [downloadData.data objectForKey:@"userdetails"];
                OnGoUserDetails* userDetails = [OnGoUserDetails onGoUserDetailsForApi:api FromJsonDict:userDetailJsonDict];
                [[OnGoDB dbInstance] saveOnGoUserDetails:userDetails];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    callBackBlock(productList);
                });
                
            }];
        }
        else
        {
            callBackBlock(products);
        }
	}];
}

-(void)getAllServiceCategories:(void(^)(NSArray* services))callBackBlock
{
    [[OnGoDB dbInstance] getAllServiceCategories:^(NSArray* services){
        if (services.count == 0) {
            
            NSString* urlString = [NSString stringWithFormat:GetServiceCategoriesURL,[[[NSBundle mainBundle] infoDictionary] objectForKey:@"MALL_ID"]];

            [[OnGoDownloadManager sharedDownloadManager]downloadDataWithURLString:urlString dataType:DATA_TYPE_JSON finishBlock:^(OnGoDownloadData *downloadData){
                NSMutableArray* serviceCatList = [NSMutableArray new];
                NSString* api = @"ServiceCategories";
                NSArray* serviceCatJsonList = [downloadData.data objectForKey:@"jobs"];
                for(NSDictionary* jsonDict in serviceCatJsonList)
                {
                    [serviceCatList addObject:[OnGoServiceCategories onGoServiceCategoriesFromJsonDict:jsonDict]];
                }
                for (OnGoServiceCategories* oNgServicesCat in serviceCatList)
                {
                    [[OnGoDB dbInstance]saveOnGoServiceCategories:oNgServicesCat];
                }
                
                
                //User Detail for ServiceCategories Api
                NSDictionary* userDetailJsonDict= [downloadData.data objectForKey:@"userdetails"];
                OnGoUserDetails* userDetails = [OnGoUserDetails onGoUserDetailsForApi:api FromJsonDict:userDetailJsonDict];
                [[OnGoDB dbInstance] saveOnGoUserDetails:userDetails];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    callBackBlock(serviceCatList);
                    
                });
            }];
        }
        else
        {
            callBackBlock(services);
        }
    }];
}

- (void)getAllStoreCategoriesForMallId:(NSString*)mallId block:(void(^)(NSArray* storeCatList))callBackBlock
{
    [[OnGoDB dbInstance] getAllStoreCategoriesForMallId:(NSString*)mallId finishBlock:^(NSArray* storeCatList) {
		if (storeCatList.count == 0) {
            
            NSString* urlString = [NSString stringWithFormat:GetStoreCategoriesURL,mallId];
           
            //for UserDetail Api Field.
            NSString* api= @"StoreCategories";
            [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:urlString dataType:DATA_TYPE_JSON finishBlock:^(OnGoDownloadData *downloadData){
                NSMutableArray* storeCatList = [NSMutableArray new];
               
                
                NSArray* storesJsonList = [downloadData.data objectForKey:@"jobs"];
                for(NSDictionary* jsonDict in storesJsonList)
                {
                    [storeCatList addObject:[OnGoStoreCategories onGoStoreCategoriesFromJsonDict:jsonDict]];
                }
               for(OnGoStoreCategories* oNgStores in storeCatList)
               {
                    [[OnGoDB dbInstance] saveOnGoStoreCategories:oNgStores];
                }
                 // UserDetail for StoreCategories APi.
                    NSDictionary* userDetailJsonDict= [downloadData.data objectForKey:@"userdetails"];
                    OnGoUserDetails* userDetails = [OnGoUserDetails onGoUserDetailsForApi:api FromJsonDict:userDetailJsonDict];
                    [[OnGoDB dbInstance] saveOnGoUserDetails:userDetails];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    callBackBlock(storeCatList);
                });
            }];
        }
        else
        {
            callBackBlock(storeCatList);
        }
	}];
}

-(void)getAllCustomtabItemsForCustomTabName:(NSString*)customTabName mallId:(NSString *)mallId block:(void (^)(NSArray* list))callBackBlock
{
    [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:[NSString stringWithFormat:GetCustomTabItemsURL,customTabName,mallId] dataType:DATA_TYPE_JSON finishBlock:^(OnGoDownloadData *downloadData){
       // NSMutableArray* storeList = [NSMutableArray new];
        
        NSArray* customTabList = [downloadData.data objectForKey:@"jobs"];
        
//        for(NSDictionary* jsonDict in storeJsonList)
//        {
//            OnGoStores* store = [OnGoStores onGoStoresOfType:type FromJsonDict:jsonDict];
//            [storeList addObject:store];
//            [[OnGoDB dbInstance]saveOnGoStores:store];
//            NSMutableArray* ratingJsonList = [jsonDict valueForKey:@"jobComments"];
//            NSMutableArray* ratingList = [NSMutableArray new];
//            
//            for (int i = 0; i < [ratingJsonList count]; i++)
//            {
//                NSString* typeId = (NSString*)[jsonDict valueForKey:@"id"];
//                NSMutableDictionary*  ratingDict = [[ratingJsonList objectAtIndex:i] mutableCopy];
//                [ratingDict setValue:typeId forKey:@"typeId"];
//                OnGoRating *rating = [OnGoRating onGoRatingForCateType:cateType ratingType:ratingType FromJsonDict:ratingDict];
//                [ratingList addObject:rating];
//                [[OnGoDB dbInstance] saveOnGoRating:rating];
//            }
//            store.ratingList = ratingList;
//        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            callBackBlock(customTabList);
        });
        
    }];
}

-(void)getAllCustomHtmls:(NSString*)customHtmlName mallId:(NSString *)mallId block:(void (^)(NSDictionary* list))callBackBlock
{
    [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:[NSString stringWithFormat:GetCustomHtmlsURL, customHtmlName,mallId] dataType:DATA_TYPE_JSON finishBlock:^(OnGoDownloadData *downloadData){
        // NSMutableArray* storeList = [NSMutableArray new];
        
        NSArray* customTabList = [downloadData.data objectForKey:@"widgetJobs"];
        
        //        for(NSDictionary* jsonDict in storeJsonList)
        //        {
        //            OnGoStores* store = [OnGoStores onGoStoresOfType:type FromJsonDict:jsonDict];
        //            [storeList addObject:store];
        //            [[OnGoDB dbInstance]saveOnGoStores:store];
        //            NSMutableArray* ratingJsonList = [jsonDict valueForKey:@"jobComments"];
        //            NSMutableArray* ratingList = [NSMutableArray new];
        //
        //            for (int i = 0; i < [ratingJsonList count]; i++)
        //            {
        //                NSString* typeId = (NSString*)[jsonDict valueForKey:@"id"];
        //                NSMutableDictionary*  ratingDict = [[ratingJsonList objectAtIndex:i] mutableCopy];
        //                [ratingDict setValue:typeId forKey:@"typeId"];
        //                OnGoRating *rating = [OnGoRating onGoRatingForCateType:cateType ratingType:ratingType FromJsonDict:ratingDict];
        //                [ratingList addObject:rating];
        //                [[OnGoDB dbInstance] saveOnGoRating:rating];
        //            }
        //            store.ratingList = ratingList;
        //        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            callBackBlock(customTabList);
        });
        
    }];
}


//http://52.74.52.134:8081/Services/getMasters?type=Keys&mallId=42&unlimited=true

-(void)getAllStoresOfType:(NSString*)type mallId:(NSString *)mallId finishblock:(void(^)(NSArray* storeList))callBackBlock
{
    
    [[OnGoDB dbInstance] getAllStoresOfType:type mallId:mallId block:^(NSArray *storeList){
         
        if (storeList.count == 0) {
            
            //Todo, have to remove this hard coding
            NSString* cateType = @"Stores";
            NSString* ratingType = @"STORES";
            [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:[NSString stringWithFormat:GetStoresURL,type,mallId] dataType:DATA_TYPE_JSON finishBlock:^(OnGoDownloadData *downloadData){
                NSMutableArray* storeList = [NSMutableArray new];
                
                NSArray* storeJsonList = [downloadData.data objectForKey:@"jobs"];
                
          for(NSDictionary* jsonDict in storeJsonList)
             {
                 OnGoStores* store = [OnGoStores onGoStoresOfType:type FromJsonDict:jsonDict];
                 [storeList addObject:store];
                 [[OnGoDB dbInstance]saveOnGoStores:store];
                NSMutableArray* ratingJsonList = [jsonDict valueForKey:@"jobComments"];
                 NSMutableArray* ratingList = [NSMutableArray new];

                 for (int i = 0; i < [ratingJsonList count]; i++)
                 {
                    NSString* typeId = (NSString*)[jsonDict valueForKey:@"id"];
                     NSMutableDictionary*  ratingDict = [[ratingJsonList objectAtIndex:i] mutableCopy];
                     [ratingDict setValue:typeId forKey:@"typeId"];
                     OnGoRating *rating = [OnGoRating onGoRatingForCateType:cateType ratingType:ratingType FromJsonDict:ratingDict];
                     [ratingList addObject:rating];
                     [[OnGoDB dbInstance] saveOnGoRating:rating];
                 }
                 store.ratingList = ratingList;
             }

                dispatch_async(dispatch_get_main_queue(), ^{
                    callBackBlock(storeList);
                });
                
            }];
        }
        else
        {
            callBackBlock(storeList);
        }
    }];
    
}


-(void)getAllProductsOfType:(NSString*)type mallId:(NSString *)mallId block:(void (^)(NSArray* allProductList))callBackBlock
{
    [[OnGoDB dbInstance]getAllProductsOfType:type mallId:mallId block:^(NSArray* allProductList){
        
        if (allProductList.count == 0) {
            
            NSString* urlString = [NSString stringWithFormat:GetAllProductsURL,type,mallId];
            [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:urlString dataType:DATA_TYPE_JSON finishBlock:^(OnGoDownloadData *downloadData){
                NSMutableArray* productList = [NSMutableArray new];
                
                NSString* cateType = @"Products";
                NSString* ratingType = @"Products";

                
                NSArray* productJsonList = [downloadData.data objectForKey:@"jobs"];
                for(NSDictionary* jsonDict in productJsonList)
                {
                    OnGoProducts* oNgProduct = [OnGoProducts onGoProductsOfType:type mallId:mallId FromJsonDict:jsonDict];
                    [productList addObject:oNgProduct];
                    [[OnGoDB dbInstance] saveOnGoAllProducts:oNgProduct];
                    
                    
                    NSMutableArray* ratingJsonList = [jsonDict valueForKey:@"jobComments"];
                    NSMutableArray* ratingList = [NSMutableArray new];
                    
                    for (int i = 0; i < [ratingJsonList count]; i++)
                    {
                        NSString* typeId = (NSString*)[jsonDict valueForKey:@"id"];
                        NSMutableDictionary*  ratingDict = [[ratingJsonList objectAtIndex:i] mutableCopy];
                        [ratingDict setValue:typeId forKey:@"typeId"];
                        OnGoRating *rating = [OnGoRating onGoRatingForCateType:cateType ratingType:ratingType FromJsonDict:ratingDict];
                        [ratingList addObject:rating];
                        [[OnGoDB dbInstance] saveOnGoRating:rating];
                    }
                    oNgProduct.ratingList = ratingList;
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    callBackBlock(productList);
                });
            }];
        }
        else
        {
            callBackBlock(allProductList);
        }
	}];
    
    
}


-(void)getAllOffersOfType:(NSString*)type mallId:(NSString *)mallId block:(void (^)(NSArray* offersList))callBackBlock
{
    [[OnGoDB dbInstance] getAllOffersOfType:type mallId:mallId block:^(NSArray* offersList){
        
        if(offersList.count == 0)
        {
            NSString* urlString = [NSString stringWithFormat:GetOffersURL,type,mallId];
            [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:urlString dataType:DATA_TYPE_JSON finishBlock:^(OnGoDownloadData *downloadData){
                NSMutableArray* offersList = [NSMutableArray new];
                
                NSString* cateType = @"Deals";
                NSString* ratingType = @"Deals";

                NSArray* productJsonList = [downloadData.data objectForKey:@"jobs"];
                for(NSDictionary* jsonDict in productJsonList)
                {
                    OnGoProducts* oNgProduct = [OnGoProducts onGoProductsOfType:@"Deals" mallId:mallId FromJsonDict:jsonDict];
                    oNgProduct.offerType = type;
                    [offersList addObject:oNgProduct];
                    [[OnGoDB dbInstance] saveOnGoAllProducts:oNgProduct];
                    
                    NSMutableArray* ratingJsonList = [jsonDict valueForKey:@"jobComments"];
                    NSMutableArray* ratingList = [NSMutableArray new];
                    
                    for (int i = 0; i < [ratingJsonList count]; i++)
                    {
                        NSString* typeId = (NSString*)[jsonDict valueForKey:@"id"];
                        NSMutableDictionary*  ratingDict = [[ratingJsonList objectAtIndex:i] mutableCopy];
                        [ratingDict setValue:typeId forKey:@"typeId"];
                        OnGoRating *rating = [OnGoRating onGoRatingForCateType:cateType ratingType:ratingType FromJsonDict:ratingDict];
                        [ratingList addObject:rating];
                        [[OnGoDB dbInstance] saveOnGoRating:rating];
                    }
                    oNgProduct.ratingList = ratingList;
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    callBackBlock(offersList);
                });
            }];

        }
        else
        {
            callBackBlock(offersList);

        }

    }];

}

-(void)getAllRatingForJobTypeId:(NSString*)jobTypeId finishBlock:(void(^)(NSArray* ratingList))callBackBlock
{
    [[OnGoDB dbInstance] getAllRatingForJobTypeId:jobTypeId  finishBlock:^(NSArray* ratingList)
    {
        callBackBlock(ratingList);
    }];
}

-(void)postRating:(OnGoRating*)rating userId:(NSString*)userId
{
    NSString* urlString = [NSString stringWithFormat:PostReviewsURL,rating.jobTypeId, userId, rating.Description, rating.UserRatingValue];
    [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:urlString dataType:DATA_TYPE_JSON finishBlock:^(OnGoDownloadData *downloadData){
        rating.userName = [downloadData.data objectForKey:@"fullname"];
        rating.time = [downloadData.data objectForKey:@"date"];
        [[OnGoDB dbInstance] saveOnGoRating:rating];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReviewsDidChangeNotification" object:self];
        
        //rating.id = [downloadData.data objectForKey:@"id"];
        
    }];

}

-(void)postRegister:(NSString*)emailId password:(NSString*)passwrd firstName:(NSString*)firstName lastName:(NSString*)lastName mallId:(NSString*)mallId isFB:(BOOL)isFB finishblock:(void(^)(NSDictionary* response))callBackBlock
{
    //http://exapplor.com:8081/MobileAPIs/regAndloyaltyAPI?orgId=3&userEmailId=cxsample@gmail.com&dt=DEVICES&firstName=Cxs&lastName=Ample&password=123
    
    NSString* isFBStrValue = isFB? @"true":@"false";
    
    NSString* urlString = [NSString stringWithFormat:@"%@&orgId=%@&userEmailId=%@&dt=DEVICES&firstName=%@&lastName=%@&password=%@&isLoginWithFB=%@",GetRegisteredURL,mallId,emailId,firstName,lastName,passwrd,isFBStrValue];
    [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:urlString dataType:DATA_TYPE_JSON finishBlock:^(OnGoDownloadData *downloadData){

        //if(downloadData.data)
        {
            
            if([[downloadData.data objectForKey:@"status"] intValue] == 1)
            {
                [[NSUserDefaults standardUserDefaults] setObject:downloadData.data forKey:@"loggedinUserDetails"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"CXUserRegisterDidNotification" object:self userInfo:downloadData.data];
            }
            callBackBlock(downloadData.data);
        }
    }];
    

}


-(void)login:(NSString*)emailId password:(NSString*)passwrd  mallId:(NSString*)mallId finishblock:(void(^)(NSDictionary* response))callBackBlock
{
    //http://exapplor.com:8081/MobileAPIs/loginConsumerForOrg?orgId=199&email=cxsample@gmail.com&dt=DEVICES&password=321
    NSString* urlString = [NSString stringWithFormat:@"%@&orgId=%@&email=%@&dt=DEVICES&password=%@",GetLoginDataURL,mallId,emailId,passwrd];
    [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:urlString dataType:DATA_TYPE_JSON finishBlock:^(OnGoDownloadData *downloadData){
        
        //if(downloadData.data)
        {
            if([[downloadData.data objectForKey:@"status"] intValue] == 1)
            {
                [[NSUserDefaults standardUserDefaults] setObject:downloadData.data forKey:@"loggedinUserDetails"];
                [[NSUserDefaults standardUserDefaults] setObject:[downloadData.data valueForKey:@"userImagePath"] forKey:@"USER_Image"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"CXUserLoginDidNotification" object:self userInfo:downloadData.data];
            }
            callBackBlock(downloadData.data);
        }
    }];
}


-(void)forgotPasswordForEmailId:(NSString*)emailId rEmailId:(NSString*)rEmaildId  mallId:(NSString*)mallId finishblock:(void(^)(NSDictionary* response))callBackBlock
{
    //http://exapplor.com:8081/MobileAPIs/forgotpwd?email=cxsample5@gmail.com&remai=cxsample5@gmail.com&orgId=3
   // http://exapplor.com:8081/MobileAPIs/forgotpwd?email=cxsample@gmail.com&remail=cxsample@gmail.com&orgId=3
    //http://exapplor.com:8081/MobileAPIs/forgotpwd?
    NSString* urlString = [NSString stringWithFormat:@"%@email=%@&remail=%@&orgId=%@",Postforgot_PwdURL,emailId,rEmaildId,mallId];

    [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:urlString dataType:DATA_TYPE_JSON finishBlock:^(OnGoDownloadData *downloadData){
        
        //if(downloadData.data)
        {
            callBackBlock(downloadData.data);
        }
    }];
}


-(void)updateProfile:(NSDictionary *)dict mallId:(NSString*)mallId  finishblock:(void(^)(NSDictionary* response))callBackBlock
{
    NSString* urlString = [NSString stringWithFormat:@"%@orgId=%@&email=%@&dt=DEVICES&firstName=%@&lastName=%@&address=%@&mobileNo=%@&city=%@&state=%@&country=%@&userImagePath=%@&userBannerPath=%@",UpdateProfile_URL,mallId,dict[@"emailId"], dict[@"firstName"],dict[@"lastName"],dict[@"address"],dict[@"mobile"],dict[@"city"],dict[@"state"],dict[@"country"], dict[@"userImagePath"], dict[@"userBannerPath"]];
    
    [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:urlString dataType:DATA_TYPE_JSON finishBlock:^(OnGoDownloadData *downloadData){
        
        //if(downloadData.data)
        {
            [[NSUserDefaults standardUserDefaults] setObject:downloadData.data forKey:@"loggedinUserDetails"];
            callBackBlock(downloadData.data);
        }
    }];

}

-(void)changePassword:(NSDictionary *)dict mallId:(NSString*)mallId  finishblock:(void(^)(NSDictionary* response))callBackBlock
{
    NSString* urlString = [NSString stringWithFormat:@"%@cPassword=%@&nPassword=%@&nrPassword=%@&email=%@&orgId=%@",Getchange_PwdURL,dict[@"currentPassword"], dict[@"newPassword"],dict[@"confirmPassword"],dict[@"emailId"],mallId];
    
    [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:urlString dataType:DATA_TYPE_JSON finishBlock:^(OnGoDownloadData *downloadData){
        
        //if(downloadData.data)
        {
            callBackBlock(downloadData.data);
        }
    }];
}


-(void)placeOrder:(NSString*)emailId mallId:(NSString*)mallId orderInfo:(NSString*)jsonInfo finishblock:(void(^)(NSDictionary* response))callBackBlock
{
    NSString* urlString = [NSString stringWithFormat:@"%@json=%@&dt=CAMPAIGNS&category=Services&userId=%@&consumerEmail=%@",POSTORDER_URL,jsonInfo,mallId,emailId];
    [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:urlString dataType:DATA_TYPE_JSON finishBlock:^(OnGoDownloadData *downloadData){
        
        NSLog(@"downloadData:%@",downloadData.data);
        callBackBlock(downloadData.data);
    }];

}


- (void)getAllOrdersForMallId:(NSString*)mallId userId:(NSString*)userId   block:(void(^)(NSDictionary* response))callBackBlock
{
    //http://exapplor.com:8081/Services/getMasters?consumerId=11&type=PlaceOrder&mallId=3

    NSString* urlString = [NSString stringWithFormat:@"%@consumerId=%@&type=PlaceOrder&mallId=%@",GetAllORDERS_URL,userId,mallId];

    [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:urlString dataType:DATA_TYPE_JSON finishBlock:^(OnGoDownloadData *downloadData){
        
        if(downloadData.data)
        {
            callBackBlock(downloadData.data);
        }
    }];

}


-(void)getAllServiceHistoryItemsForServiceCategoryName:(NSString*)serviceCategoryName mallId:(NSString *)mallId userId:(NSString *)userId block:(void (^)(NSArray* list))callBackBlock
{
    NSString* urlString = [NSString stringWithFormat:@"http://exapplor.com:8081/Services/getMyJobs?consumerId=%@&type=%@&mallId=%@", userId,serviceCategoryName,mallId];
    [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:urlString dataType:DATA_TYPE_JSON finishBlock:^(OnGoDownloadData *downloadData){
        
        if(downloadData.data)
        {
            callBackBlock(downloadData.data[@"jobs"]);
        }
    }];

}


-(void)getAllServicesInfoForMallId:(NSString *)mallId block:(void (^)(NSArray* list))callBackBlock
{
    NSString* urlString = [NSString stringWithFormat:@"http://52.74.52.134:8081/Services/getMasters?type=allServicesJobTypes&mallId=%@",mallId];
    [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:urlString dataType:DATA_TYPE_JSON finishBlock:^(OnGoDownloadData *downloadData){
        
        if(downloadData.data)
        {
            callBackBlock(downloadData.data[@"orgs"]);
        }
    }];

}


-(void)getFormInformationMallId:(NSString *)mallId block:(void (^)(NSArray* list))callBackBlock;{
    
   // NSString* urlString = [NSString stringWithFormat:@"http://52.74.52.134:8081/Services/getMasters?type=allServicesJobTypes&mallId=%@",mallId];
    [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:@"http://52.74.52.134:8081/Services/getMasters?type=allServicesJobTypes&mallId=688" dataType:DATA_TYPE_JSON finishBlock:^(OnGoDownloadData *downloadData){
        
        if(downloadData.data)
        {
            callBackBlock(downloadData.data[@"orgs"]);
        }
    }];
    
}

-(void)getCalenderInformationMallId:(NSString *)mallId block:(void (^)(NSArray* list))callBackBlock;
{
    
    DataBaseManager *manager =  [DataBaseManager dataBaseManager];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    BOOL success = [manager execute:@"SELECT *FROM TABLE_CALENDER_EVENTS" resultsArray:array];
    if (success) {
        
    }
        if (array.count == 0) {
            
            NSString* urlString = [NSString stringWithFormat:CalenderEvents,[[[NSBundle mainBundle] infoDictionary] objectForKey:@"MALL_ID"]];
            
            [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:urlString dataType:DATA_TYPE_JSON finishBlock:^(OnGoDownloadData *downloadData){
                
                if(downloadData.data)
                {
                    callBackBlock(downloadData.data[@"jobs"]);//[downloadData.data objectForKey:@"jobs"]
                    
                    
                    NSArray* productJsonList = [downloadData.data objectForKey:@"jobs"];
                    for(NSDictionary* jsonDict in productJsonList)
                    {
                        NSLog(@"calender events %@",jsonDict);
                        
                        ongoCalenderEvent* productCat = [ongoCalenderEvent parseTheCalenderEvents:jsonDict];
                        [[OnGoDB dbInstance] saveCalenderEvents:productCat];
                    }
                    
                }
            }];
        }else{
            callBackBlock(array);
        }
    
}

-(void)getLoyaltyInfoForMallId:(NSString *)mallId emailId:(NSString *)emailId   block:(void (^)(NSDictionary* dict))callBackBlock
{
    NSString* urlString = [NSString stringWithFormat:@"http://52.74.52.134:8081/MobileAPIs/getConJobInstances?email=%@&ownerId=%@",emailId,mallId];
    [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:urlString dataType:DATA_TYPE_JSON finishBlock:^(OnGoDownloadData *downloadData){
        
        if(downloadData.data)
        {
            
        }
    }];

}


-(void)registerForPushNotification:(NSString *)deviceId block:(void (^)(NSDictionary* dict))callBackBlock
{
    NSString* urlString = [NSString stringWithFormat:@"http://storeongo.com:9000/api/device_tokens/%@",deviceId];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60.0];
    [request setHTTPMethod:@"PUT"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[OGWorkSpace sharedWorkspace].mallInfo.plushDetails.authorization forHTTPHeaderField:@"Authorization"];

    NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:-1] forKey:@"status"];
    
    [request setHTTPBody:[dict JSONData]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:nil];
}

-(void)getCountries:(NSString *)deviceId block:(void (^)(NSArray* list))callBackBlock
{
    [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:GetCountriesURL dataType:DATA_TYPE_JSON finishBlock:^(OnGoDownloadData *downloadData){
        
        
    }];
    
}


#pragma mark Getting keys

-(void)getKeys:(NSString *)mallId finishblock:(void(^)(NSArray* storeList))callBackBlock
{
    DataBaseManager *manager =  [DataBaseManager dataBaseManager];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    BOOL success = [manager execute:@"SELECT *FROM TABLE_KEYS" resultsArray:array];
    if (success) {
    }
    if (array.count == 0) {
        NSString* urlString = [NSString stringWithFormat:keys,[[[NSBundle mainBundle] infoDictionary] objectForKey:@"MALL_ID"]];
        [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:urlString dataType:DATA_TYPE_JSON finishBlock:^(OnGoDownloadData *downloadData){
            if(downloadData.data)
            {
                callBackBlock(downloadData.data[@"jobs"]);//[downloadData.data objectForKey:@"jobs"]
                NSArray* productJsonList = [downloadData.data objectForKey:@"jobs"];
                for(NSDictionary* jsonDict in productJsonList)
                {
                    onGoKeys* productCat = [onGoKeys parseTheKeys:jsonDict];
                    [[OnGoDB dbInstance] saveOnGoKeys:productCat];
                }
            }
        }];
    }else{
        callBackBlock(array);
    }
}

#pragma mark Notification

- (void)getNotificatin:(NSString*)mallId block:(void(^)(NSArray *list))callBackBlock;{
    //NSString *const keys = @"http://52.74.52.134:8081/Services/getMasters?type=Keys&mallId=%@&unlimited=true";
//http://odishanews360.com:8081/Services/getMasters?type=keys&mallId=3
    
    NSString* urlString = [NSString stringWithFormat:@"http://odishanews360.com:8081/Services/getMasters?type=keys&mallId=%@",mallId];

    
    [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:urlString dataType:DATA_TYPE_JSON finishBlock:^(OnGoDownloadData *downloadData){
        if(downloadData.data)
        {
            callBackBlock(downloadData.data[@"jobs"]);//[downloadData.data objectForKey:@"jobs"]
            NSArray* productJsonList = [downloadData.data objectForKey:@"jobs"];
            for(NSDictionary* jsonDict in productJsonList)
            {
                //onGoKeys* productCat = [onGoKeys parseTheKeys:jsonDict];
                //[[OnGoDB dbInstance] saveOnGoKeys:productCat];
            }
        }
    }];
}



#pragma mark Get Feture product

- (void)getFeatureProduct:(NSString*)mallId block:(void (^)(NSArray* list))callBackBlock;
{
    
    DataBaseManager *manager =  [DataBaseManager dataBaseManager];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    BOOL success = [manager execute:@"SELECT *FROM FEATURE_PRODUCTS" resultsArray:array];
    if (success) {
    }
    
    if (array.count == 0) {

    NSString* urlString = [NSString stringWithFormat:featureProduct,[[[NSBundle mainBundle] infoDictionary] objectForKey:@"MALL_ID"]];
    
    [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:urlString dataType:DATA_TYPE_JSON finishBlock:^(OnGoDownloadData *downloadData){
        
        if(downloadData.data)
        {
            callBackBlock(downloadData.data[@"jobs"]);//[downloadData.data objectForKey:@"jobs"]
            
            
            NSArray* productJsonList = [downloadData.data objectForKey:@"jobs"];
            for(NSDictionary* jsonDict in productJsonList)
            {
                NSLog(@"featured products %@",jsonDict);
                
                FeatureProducts* productCat = [FeatureProducts parseTheCalenderEvents:jsonDict];
                [[OnGoDB dbInstance] saveFeatureProduct:productCat];
                NSArray *jobsID =   [[jsonDict valueForKey:@"Campaign_Jobs"] componentsSeparatedByString:@"_"];
                for (NSString*str in jobsID) {
                    [self getFEatureJobs:str featureProductID:[jsonDict valueForKey:@"id"]];
                }
                
            }
            
        }
    }];
    }else{
        callBackBlock(array);
    }

    
}

- (void)getFEatureJobs:(NSString*)str featureProductID:(NSString*)parentID{
    
    NSString* urlString = [NSString stringWithFormat:featureProductsJob,str];
    
    [[OnGoDownloadManager sharedDownloadManager] downloadDataWithURLString:urlString dataType:DATA_TYPE_JSON finishBlock:^(OnGoDownloadData *downloadData){
        
        if(downloadData.data)
        {
           // callBackBlock(downloadData.data[@"jobs"]);//[downloadData.data objectForKey:@"jobs"]
            
            NSArray* productJsonList = [downloadData.data objectForKey:@"jobs"];
            for(NSDictionary* jsonDict in productJsonList)
            {
                NSLog(@"featured products %@",jsonDict);
                
                FeatureProductsJobs* productCat = [FeatureProductsJobs parseTheFeatureProductsJobs:jsonDict];
                [[OnGoDB dbInstance] saveFeatureProductJobs:productCat parentID:parentID];
                
            }
            
        }
    }];

    
}



@end
