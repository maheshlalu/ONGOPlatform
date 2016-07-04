//
//  OGStoreCategories.m
//
//  Created by Hanuman Kachwa on 19/12/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "OGStoreCategories.h"
#import "OGJobs.h"
#import "OGInsights.h"
#import "OGUserdetails.h"
#import "OGWidgets.h"
#import "OGDataServices.h"

NSString* const OGGetStoreCategoriesURL = @"Services/getMasters?type=StoreCategories&mallId=%@";

NSString *const kOGStoreCategoriesShowInsights = @"showInsights";
NSString *const kOGStoreCategoriesJobs = @"jobs";
NSString *const kOGStoreCategoriesAverageRating = @"averageRating";
NSString *const kOGStoreCategoriesGuestUserId = @"guestUserId";
NSString *const kOGStoreCategoriesCount = @"count";
NSString *const kOGStoreCategoriesShowJTJobs = @"showJTJobs";
NSString *const kOGStoreCategoriesInsights = @"insights";
NSString *const kOGStoreCategoriesUserId = @"userId";
NSString *const kOGStoreCategoriesUserdetails = @"userdetails";
NSString *const kOGStoreCategoriesWidgets = @"widgets";
NSString *const kOGStoreCategoriesShowFields = @"showFields";
NSString *const kOGStoreCategoriesShowStatuses = @"showStatuses";
NSString *const kOGStoreCategoriesStatus = @"status";
NSString *const kOGStoreCategoriesGuestUserEmail = @"guestUserEmail";


@interface OGStoreCategories ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OGStoreCategories

@synthesize showInsights = _showInsights;
@synthesize jobs = _jobs;
@synthesize averageRating = _averageRating;
@synthesize guestUserId = _guestUserId;
@synthesize storeCatCount = _storeCatCount;
@synthesize showJTJobs = _showJTJobs;
@synthesize insights = _insights;
@synthesize userId = _userId;
@synthesize userdetails = _userdetails;
@synthesize widgets = _widgets;
@synthesize showFields = _showFields;
@synthesize showStatuses = _showStatuses;
@synthesize status = _status;
@synthesize guestUserEmail = _guestUserEmail;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.showInsights = [[self objectOrNilForKey:kOGStoreCategoriesShowInsights fromDictionary:dict] boolValue];
    NSObject *receivedOGJobs = [dict objectForKey:kOGStoreCategoriesJobs];
    NSMutableArray *parsedOGJobs = [NSMutableArray array];
    if ([receivedOGJobs isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedOGJobs) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedOGJobs addObject:[OGJobs modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedOGJobs isKindOfClass:[NSDictionary class]]) {
       [parsedOGJobs addObject:[OGJobs modelObjectWithDictionary:(NSDictionary *)receivedOGJobs]];
    }

    self.jobs = [NSArray arrayWithArray:parsedOGJobs];
            self.averageRating = [[self objectOrNilForKey:kOGStoreCategoriesAverageRating fromDictionary:dict] doubleValue];
            self.guestUserId = [self objectOrNilForKey:kOGStoreCategoriesGuestUserId fromDictionary:dict];
            self.storeCatCount = [[self objectOrNilForKey:kOGStoreCategoriesCount fromDictionary:dict] doubleValue];
            self.showJTJobs = [[self objectOrNilForKey:kOGStoreCategoriesShowJTJobs fromDictionary:dict] boolValue];
    NSObject *receivedOGInsights = [dict objectForKey:kOGStoreCategoriesInsights];
    NSMutableArray *parsedOGInsights = [NSMutableArray array];
    if ([receivedOGInsights isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedOGInsights) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedOGInsights addObject:[OGInsights modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedOGInsights isKindOfClass:[NSDictionary class]]) {
       [parsedOGInsights addObject:[OGInsights modelObjectWithDictionary:(NSDictionary *)receivedOGInsights]];
    }

    self.insights = [NSArray arrayWithArray:parsedOGInsights];
            self.userId = [[self objectOrNilForKey:kOGStoreCategoriesUserId fromDictionary:dict] doubleValue];
            self.userdetails = [OGUserdetails modelObjectWithDictionary:[dict objectForKey:kOGStoreCategoriesUserdetails]];
    NSObject *receivedOGWidgets = [dict objectForKey:kOGStoreCategoriesWidgets];
    NSMutableArray *parsedOGWidgets = [NSMutableArray array];
    if ([receivedOGWidgets isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedOGWidgets) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedOGWidgets addObject:[OGWidgets modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedOGWidgets isKindOfClass:[NSDictionary class]]) {
       [parsedOGWidgets addObject:[OGWidgets modelObjectWithDictionary:(NSDictionary *)receivedOGWidgets]];
    }

    self.widgets = [NSArray arrayWithArray:parsedOGWidgets];
            self.showFields = [[self objectOrNilForKey:kOGStoreCategoriesShowFields fromDictionary:dict] boolValue];
            self.showStatuses = [[self objectOrNilForKey:kOGStoreCategoriesShowStatuses fromDictionary:dict] boolValue];
            self.status = [[self objectOrNilForKey:kOGStoreCategoriesStatus fromDictionary:dict] doubleValue];
            self.guestUserEmail = [self objectOrNilForKey:kOGStoreCategoriesGuestUserEmail fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithBool:self.showInsights] forKey:kOGStoreCategoriesShowInsights];
    NSMutableArray *tempArrayForJobs = [NSMutableArray array];
    for (NSObject *subArrayObject in self.jobs) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForJobs addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForJobs addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForJobs] forKey:kOGStoreCategoriesJobs];
    [mutableDict setValue:[NSNumber numberWithDouble:self.averageRating] forKey:kOGStoreCategoriesAverageRating];
    [mutableDict setValue:self.guestUserId forKey:kOGStoreCategoriesGuestUserId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.storeCatCount] forKey:kOGStoreCategoriesCount];
    [mutableDict setValue:[NSNumber numberWithBool:self.showJTJobs] forKey:kOGStoreCategoriesShowJTJobs];
    NSMutableArray *tempArrayForInsights = [NSMutableArray array];
    for (NSObject *subArrayObject in self.insights) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForInsights addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForInsights addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForInsights] forKey:kOGStoreCategoriesInsights];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userId] forKey:kOGStoreCategoriesUserId];
    [mutableDict setValue:[self.userdetails dictionaryRepresentation] forKey:kOGStoreCategoriesUserdetails];
    NSMutableArray *tempArrayForWidgets = [NSMutableArray array];
    for (NSObject *subArrayObject in self.widgets) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForWidgets addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForWidgets addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForWidgets] forKey:kOGStoreCategoriesWidgets];
    [mutableDict setValue:[NSNumber numberWithBool:self.showFields] forKey:kOGStoreCategoriesShowFields];
    [mutableDict setValue:[NSNumber numberWithBool:self.showStatuses] forKey:kOGStoreCategoriesShowStatuses];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kOGStoreCategoriesStatus];
    [mutableDict setValue:self.guestUserEmail forKey:kOGStoreCategoriesGuestUserEmail];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.showInsights = [aDecoder decodeBoolForKey:kOGStoreCategoriesShowInsights];
    self.jobs = [aDecoder decodeObjectForKey:kOGStoreCategoriesJobs];
    self.averageRating = [aDecoder decodeDoubleForKey:kOGStoreCategoriesAverageRating];
    self.guestUserId = [aDecoder decodeObjectForKey:kOGStoreCategoriesGuestUserId];
    self.storeCatCount = [aDecoder decodeDoubleForKey:kOGStoreCategoriesCount];
    self.showJTJobs = [aDecoder decodeBoolForKey:kOGStoreCategoriesShowJTJobs];
    self.insights = [aDecoder decodeObjectForKey:kOGStoreCategoriesInsights];
    self.userId = [aDecoder decodeDoubleForKey:kOGStoreCategoriesUserId];
    self.userdetails = [aDecoder decodeObjectForKey:kOGStoreCategoriesUserdetails];
    self.widgets = [aDecoder decodeObjectForKey:kOGStoreCategoriesWidgets];
    self.showFields = [aDecoder decodeBoolForKey:kOGStoreCategoriesShowFields];
    self.showStatuses = [aDecoder decodeBoolForKey:kOGStoreCategoriesShowStatuses];
    self.status = [aDecoder decodeDoubleForKey:kOGStoreCategoriesStatus];
    self.guestUserEmail = [aDecoder decodeObjectForKey:kOGStoreCategoriesGuestUserEmail];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeBool:_showInsights forKey:kOGStoreCategoriesShowInsights];
    [aCoder encodeObject:_jobs forKey:kOGStoreCategoriesJobs];
    [aCoder encodeDouble:_averageRating forKey:kOGStoreCategoriesAverageRating];
    [aCoder encodeObject:_guestUserId forKey:kOGStoreCategoriesGuestUserId];
    [aCoder encodeDouble:_storeCatCount forKey:kOGStoreCategoriesCount];
    [aCoder encodeBool:_showJTJobs forKey:kOGStoreCategoriesShowJTJobs];
    [aCoder encodeObject:_insights forKey:kOGStoreCategoriesInsights];
    [aCoder encodeDouble:_userId forKey:kOGStoreCategoriesUserId];
    [aCoder encodeObject:_userdetails forKey:kOGStoreCategoriesUserdetails];
    [aCoder encodeObject:_widgets forKey:kOGStoreCategoriesWidgets];
    [aCoder encodeBool:_showFields forKey:kOGStoreCategoriesShowFields];
    [aCoder encodeBool:_showStatuses forKey:kOGStoreCategoriesShowStatuses];
    [aCoder encodeDouble:_status forKey:kOGStoreCategoriesStatus];
    [aCoder encodeObject:_guestUserEmail forKey:kOGStoreCategoriesGuestUserEmail];
}

- (id)copyWithZone:(NSZone *)zone
{
    OGStoreCategories *copy = [[OGStoreCategories alloc] init];
    
    if (copy) {

        copy.showInsights = self.showInsights;
        copy.jobs = [self.jobs copyWithZone:zone];
        copy.averageRating = self.averageRating;
        copy.guestUserId = [self.guestUserId copyWithZone:zone];
        copy.storeCatCount = self.storeCatCount;
        copy.showJTJobs = self.showJTJobs;
        copy.insights = [self.insights copyWithZone:zone];
        copy.userId = self.userId;
        copy.userdetails = [self.userdetails copyWithZone:zone];
        copy.widgets = [self.widgets copyWithZone:zone];
        copy.showFields = self.showFields;
        copy.showStatuses = self.showStatuses;
        copy.status = self.status;
        copy.guestUserEmail = [self.guestUserEmail copyWithZone:zone];
    }
    
    return copy;
}

#pragma mark -

+ (NSURLSessionDataTask *)getWidgetsWithBlock:(void (^)(NSArray *widgets, NSError *error))block {
    return [[OGDataServices sharedClient] GET:[NSString stringWithFormat:OGGetStoreCategoriesURL, [OGWorkSpace sharedWorkspace].mallId] parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        OGStoreCategories *storeCat = [OGStoreCategories modelObjectWithDictionary:JSON];
        if (block) {
            [OGWorkSpace sharedWorkspace].widgets = storeCat.widgets;
            block(storeCat.widgets, nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
    
}

@end
