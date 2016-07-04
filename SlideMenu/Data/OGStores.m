//
//  OGStores.m
//
//  Created by Hanuman Kachwa on 12/01/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "OGStores.h"
#import "OGJobs.h"
#import "OGUserdetails.h"
#import "OGDataServices.h"
#import "NSDictionary+OG.h"

NSString* const OGGetStoreInfoURL = @"Services/getMasters?type=Stores&mallId=%@";

NSString *const kOGStoresShowInsights = @"showInsights";
NSString *const kOGStoresJobs = @"jobs";
NSString *const kOGStoresAverageRating = @"averageRating";
NSString *const kOGStoresTotalNumRecords = @"totalNumRecords";
NSString *const kOGStoresCount = @"count";
NSString *const kOGStoresGuestUserId = @"guestUserId";
NSString *const kOGStoresShowJTJobs = @"showJTJobs";
NSString *const kOGStoresUserdetails = @"userdetails";
NSString *const kOGStoresShowFields = @"showFields";
NSString *const kOGStoresShowStatuses = @"showStatuses";
NSString *const kOGStoresStatus = @"status";
NSString *const kOGStoresGuestUserEmail = @"guestUserEmail";


@interface OGStores ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OGStores

@synthesize showInsights = _showInsights;
@synthesize jobs = _jobs;
@synthesize averageRating = _averageRating;
@synthesize totalNumRecords = _totalNumRecords;
@synthesize count = _count;
@synthesize guestUserId = _guestUserId;
@synthesize showJTJobs = _showJTJobs;
@synthesize userdetails = _userdetails;
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
            self.showInsights = [[self objectOrNilForKey:kOGStoresShowInsights fromDictionary:dict] boolValue];
    NSObject *receivedOGJobs = [dict objectForKey:kOGStoresJobs];
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
            self.averageRating = [[self objectOrNilForKey:kOGStoresAverageRating fromDictionary:dict] doubleValue];
            self.totalNumRecords = [[self objectOrNilForKey:kOGStoresTotalNumRecords fromDictionary:dict] doubleValue];
            self.count = [[self objectOrNilForKey:kOGStoresCount fromDictionary:dict] doubleValue];
            self.guestUserId = [self objectOrNilForKey:kOGStoresGuestUserId fromDictionary:dict];
            self.showJTJobs = [[self objectOrNilForKey:kOGStoresShowJTJobs fromDictionary:dict] boolValue];
            self.userdetails = [OGUserdetails modelObjectWithDictionary:[dict objectForKey:kOGStoresUserdetails]];
            self.showFields = [[self objectOrNilForKey:kOGStoresShowFields fromDictionary:dict] boolValue];
            self.showStatuses = [[self objectOrNilForKey:kOGStoresShowStatuses fromDictionary:dict] boolValue];
            self.status = [[self objectOrNilForKey:kOGStoresStatus fromDictionary:dict] doubleValue];
            self.guestUserEmail = [self objectOrNilForKey:kOGStoresGuestUserEmail fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithBool:self.showInsights] forKey:kOGStoresShowInsights];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForJobs] forKey:kOGStoresJobs];
    [mutableDict setValue:[NSNumber numberWithDouble:self.averageRating] forKey:kOGStoresAverageRating];
    [mutableDict setValue:[NSNumber numberWithDouble:self.totalNumRecords] forKey:kOGStoresTotalNumRecords];
    [mutableDict setValue:[NSNumber numberWithDouble:self.count] forKey:kOGStoresCount];
    [mutableDict setValue:self.guestUserId forKey:kOGStoresGuestUserId];
    [mutableDict setValue:[NSNumber numberWithBool:self.showJTJobs] forKey:kOGStoresShowJTJobs];
    [mutableDict setValue:[self.userdetails dictionaryRepresentation] forKey:kOGStoresUserdetails];
    [mutableDict setValue:[NSNumber numberWithBool:self.showFields] forKey:kOGStoresShowFields];
    [mutableDict setValue:[NSNumber numberWithBool:self.showStatuses] forKey:kOGStoresShowStatuses];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kOGStoresStatus];
    [mutableDict setValue:self.guestUserEmail forKey:kOGStoresGuestUserEmail];

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

    self.showInsights = [aDecoder decodeBoolForKey:kOGStoresShowInsights];
    self.jobs = [aDecoder decodeObjectForKey:kOGStoresJobs];
    self.averageRating = [aDecoder decodeDoubleForKey:kOGStoresAverageRating];
    self.totalNumRecords = [aDecoder decodeDoubleForKey:kOGStoresTotalNumRecords];
    self.count = [aDecoder decodeDoubleForKey:kOGStoresCount];
    self.guestUserId = [aDecoder decodeObjectForKey:kOGStoresGuestUserId];
    self.showJTJobs = [aDecoder decodeBoolForKey:kOGStoresShowJTJobs];
    self.userdetails = [aDecoder decodeObjectForKey:kOGStoresUserdetails];
    self.showFields = [aDecoder decodeBoolForKey:kOGStoresShowFields];
    self.showStatuses = [aDecoder decodeBoolForKey:kOGStoresShowStatuses];
    self.status = [aDecoder decodeDoubleForKey:kOGStoresStatus];
    self.guestUserEmail = [aDecoder decodeObjectForKey:kOGStoresGuestUserEmail];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeBool:_showInsights forKey:kOGStoresShowInsights];
    [aCoder encodeObject:_jobs forKey:kOGStoresJobs];
    [aCoder encodeDouble:_averageRating forKey:kOGStoresAverageRating];
    [aCoder encodeDouble:_totalNumRecords forKey:kOGStoresTotalNumRecords];
    [aCoder encodeDouble:_count forKey:kOGStoresCount];
    [aCoder encodeObject:_guestUserId forKey:kOGStoresGuestUserId];
    [aCoder encodeBool:_showJTJobs forKey:kOGStoresShowJTJobs];
    [aCoder encodeObject:_userdetails forKey:kOGStoresUserdetails];
    [aCoder encodeBool:_showFields forKey:kOGStoresShowFields];
    [aCoder encodeBool:_showStatuses forKey:kOGStoresShowStatuses];
    [aCoder encodeDouble:_status forKey:kOGStoresStatus];
    [aCoder encodeObject:_guestUserEmail forKey:kOGStoresGuestUserEmail];
}

- (id)copyWithZone:(NSZone *)zone
{
    OGStores *copy = [[OGStores alloc] init];
    
    if (copy) {

        copy.showInsights = self.showInsights;
        copy.jobs = [self.jobs copyWithZone:zone];
        copy.averageRating = self.averageRating;
        copy.totalNumRecords = self.totalNumRecords;
        copy.count = self.count;
        copy.guestUserId = [self.guestUserId copyWithZone:zone];
        copy.showJTJobs = self.showJTJobs;
        copy.userdetails = [self.userdetails copyWithZone:zone];
        copy.showFields = self.showFields;
        copy.showStatuses = self.showStatuses;
        copy.status = self.status;
        copy.guestUserEmail = [self.guestUserEmail copyWithZone:zone];
    }
    
    return copy;
}

#pragma mark -

+ (NSURLSessionDataTask *)getStoreInfoWithBlock:(void (^)(NSArray *storeList, NSError *error))block {
    return [[OGDataServices sharedClient] GET:[NSString stringWithFormat:OGGetStoreInfoURL, [OGWorkSpace sharedWorkspace].mallId] parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        OGStores *malInfo = [OGStores modelObjectWithDictionary:JSON];
        if (block) {
            block(malInfo.jobs, nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
}


@end
