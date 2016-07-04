//
//  OGStoreCategories.h
//
//  Created by Hanuman Kachwa on 19/12/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OGUserdetails;
@class OGWidgets;

@interface OGStoreCategories : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) BOOL showInsights;
@property (nonatomic, strong) NSArray *jobs;
@property (nonatomic, assign) double averageRating;
@property (nonatomic, strong) NSString *guestUserId;
@property (nonatomic, assign) double storeCatCount;
@property (nonatomic, assign) BOOL showJTJobs;
@property (nonatomic, strong) NSArray *insights;
@property (nonatomic, assign) double userId;
@property (nonatomic, strong) OGUserdetails *userdetails;
@property (nonatomic, strong) NSArray *widgets;
@property (nonatomic, assign) BOOL showFields;
@property (nonatomic, assign) BOOL showStatuses;
@property (nonatomic, assign) double status;
@property (nonatomic, strong) NSString *guestUserEmail;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

+ (NSURLSessionDataTask *)getWidgetsWithBlock:(void (^)(NSArray *widgets, NSError *error))block;

@end
