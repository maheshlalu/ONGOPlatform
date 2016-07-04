//
//  OGMallInfo.h
//
//  Created by Hanuman Kachwa on 19/12/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OGPlushDetails;

@interface OGMallInfo : OGBaseModel <NSCoding, NSCopying>

@property (nonatomic, assign) double status;
@property (nonatomic, strong) NSString *guestUserEmail;
@property (nonatomic, assign) BOOL showInsights;
@property (nonatomic, assign) BOOL showJTJobs;
@property (nonatomic, strong) OGPlushDetails *plushDetails;
@property (nonatomic, assign) double mallCount;
@property (nonatomic, strong) NSArray *orgs;
@property (nonatomic, assign) double averageRating;
@property (nonatomic, strong) NSString *guestUserId;
@property (nonatomic, assign) BOOL showStatuses;
@property (nonatomic, assign) BOOL showFields;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

+ (NSURLSessionDataTask *)getMallInfoWithBlock:(void (^)(OGMallInfo *mallInfo, NSError *error))block;
+ (NSURLSessionDataTask *)getAllMallsInfoWithCurrentPageNumber:(NSUInteger)pageNumber block:(void (^)(NSArray *allMallsInfo, NSError *error))block;

@end
