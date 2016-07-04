//
//  OGOdishaNews.h
//
//  Created by Hanuman Kachwa on 23/01/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OGUserdetails;

@interface OGOdishaNews : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) BOOL showInsights;
@property (nonatomic, strong) NSArray *jobs;
@property (nonatomic, assign) double averageRating;
@property (nonatomic, assign) double totalNumRecords;
@property (nonatomic, assign) double count;
@property (nonatomic, strong) NSString *guestUserId;
@property (nonatomic, assign) BOOL showJTJobs;
@property (nonatomic, strong) OGUserdetails *userdetails;
@property (nonatomic, assign) BOOL showFields;
@property (nonatomic, assign) BOOL showStatuses;
@property (nonatomic, assign) double status;
@property (nonatomic, strong) NSString *guestUserEmail;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

+ (NSURLSessionDataTask *)getMallInfoWithBlock:(void (^)(OGMallInfo *mallInfo, NSError *error))block;
    
+ (NSURLSessionDataTask *)getNewsWithType:(NSString*)newsType currentPageNumber:(NSUInteger)pageNumber block:(void (^)(NSArray *allMallsInfo, NSError *error))block;

@end
