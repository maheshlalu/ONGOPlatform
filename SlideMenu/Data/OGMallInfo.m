//
//  OGMallInfo.m
//
//  Created by Hanuman Kachwa on 19/12/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "OGMallInfo.h"
#import "OGPlushDetails.h"
#import "OGOrgs.h"
#import "OGDataServices.h"
#import "NSDictionary+OG.h"

NSString* const OGGetAllMallsInfoURL = @"Services/getMasters?type=allMalls";

NSString *const kOGMallInfoStatus = @"status";
NSString *const kOGMallInfoGuestUserEmail = @"guestUserEmail";
NSString *const kOGMallInfoShowInsights = @"showInsights";
NSString *const kOGMallInfoShowJTJobs = @"showJTJobs";
NSString *const kOGMallInfoPlushDetails = @"plushDetails";
NSString *const kOGMallInfoCount = @"count";
NSString *const kOGMallInfoOrgs = @"orgs";
NSString *const kOGMallInfoAverageRating = @"averageRating";
NSString *const kOGMallInfoGuestUserId = @"guestUserId";
NSString *const kOGMallInfoShowStatuses = @"showStatuses";
NSString *const kOGMallInfoShowFields = @"showFields";


@interface OGMallInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OGMallInfo

@synthesize status = _status;
@synthesize guestUserEmail = _guestUserEmail;
@synthesize showInsights = _showInsights;
@synthesize showJTJobs = _showJTJobs;
@synthesize plushDetails = _plushDetails;
@synthesize mallCount = _mallCount;
@synthesize orgs = _orgs;
@synthesize averageRating = _averageRating;
@synthesize guestUserId = _guestUserId;
@synthesize showStatuses = _showStatuses;
@synthesize showFields = _showFields;


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
            self.status = [[self objectOrNilForKey:kOGMallInfoStatus fromDictionary:dict] doubleValue];
            self.guestUserEmail = [self objectOrNilForKey:kOGMallInfoGuestUserEmail fromDictionary:dict];
            self.showInsights = [[self objectOrNilForKey:kOGMallInfoShowInsights fromDictionary:dict] boolValue];
            self.showJTJobs = [[self objectOrNilForKey:kOGMallInfoShowJTJobs fromDictionary:dict] boolValue];
            self.plushDetails = [OGPlushDetails modelObjectWithDictionary:[dict objectForKey:kOGMallInfoPlushDetails]];
            self.mallCount = [[self objectOrNilForKey:kOGMallInfoCount fromDictionary:dict] doubleValue];
    NSObject *receivedOGOrgs = [dict objectForKey:kOGMallInfoOrgs];
    NSMutableArray *parsedOGOrgs = [NSMutableArray array];
    if ([receivedOGOrgs isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedOGOrgs) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedOGOrgs addObject:[OGOrgs modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedOGOrgs isKindOfClass:[NSDictionary class]]) {
       [parsedOGOrgs addObject:[OGOrgs modelObjectWithDictionary:(NSDictionary *)receivedOGOrgs]];
    }

    self.orgs = [NSArray arrayWithArray:parsedOGOrgs];
            self.averageRating = [[self objectOrNilForKey:kOGMallInfoAverageRating fromDictionary:dict] doubleValue];
            self.guestUserId = [self objectOrNilForKey:kOGMallInfoGuestUserId fromDictionary:dict];
            self.showStatuses = [[self objectOrNilForKey:kOGMallInfoShowStatuses fromDictionary:dict] boolValue];
            self.showFields = [[self objectOrNilForKey:kOGMallInfoShowFields fromDictionary:dict] boolValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kOGMallInfoStatus];
    [mutableDict setValue:self.guestUserEmail forKey:kOGMallInfoGuestUserEmail];
    [mutableDict setValue:[NSNumber numberWithBool:self.showInsights] forKey:kOGMallInfoShowInsights];
    [mutableDict setValue:[NSNumber numberWithBool:self.showJTJobs] forKey:kOGMallInfoShowJTJobs];
    [mutableDict setValue:[self.plushDetails dictionaryRepresentation] forKey:kOGMallInfoPlushDetails];
    [mutableDict setValue:[NSNumber numberWithDouble:self.mallCount] forKey:kOGMallInfoCount];
    NSMutableArray *tempArrayForOrgs = [NSMutableArray array];
    for (NSObject *subArrayObject in self.orgs) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForOrgs addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForOrgs addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForOrgs] forKey:kOGMallInfoOrgs];
    [mutableDict setValue:[NSNumber numberWithDouble:self.averageRating] forKey:kOGMallInfoAverageRating];
    [mutableDict setValue:self.guestUserId forKey:kOGMallInfoGuestUserId];
    [mutableDict setValue:[NSNumber numberWithBool:self.showStatuses] forKey:kOGMallInfoShowStatuses];
    [mutableDict setValue:[NSNumber numberWithBool:self.showFields] forKey:kOGMallInfoShowFields];

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

    self.status = [aDecoder decodeDoubleForKey:kOGMallInfoStatus];
    self.guestUserEmail = [aDecoder decodeObjectForKey:kOGMallInfoGuestUserEmail];
    self.showInsights = [aDecoder decodeBoolForKey:kOGMallInfoShowInsights];
    self.showJTJobs = [aDecoder decodeBoolForKey:kOGMallInfoShowJTJobs];
    self.plushDetails = [aDecoder decodeObjectForKey:kOGMallInfoPlushDetails];
    self.mallCount = [aDecoder decodeDoubleForKey:kOGMallInfoCount];
    self.orgs = [aDecoder decodeObjectForKey:kOGMallInfoOrgs];
    self.averageRating = [aDecoder decodeDoubleForKey:kOGMallInfoAverageRating];
    self.guestUserId = [aDecoder decodeObjectForKey:kOGMallInfoGuestUserId];
    self.showStatuses = [aDecoder decodeBoolForKey:kOGMallInfoShowStatuses];
    self.showFields = [aDecoder decodeBoolForKey:kOGMallInfoShowFields];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_status forKey:kOGMallInfoStatus];
    [aCoder encodeObject:_guestUserEmail forKey:kOGMallInfoGuestUserEmail];
    [aCoder encodeBool:_showInsights forKey:kOGMallInfoShowInsights];
    [aCoder encodeBool:_showJTJobs forKey:kOGMallInfoShowJTJobs];
    [aCoder encodeObject:_plushDetails forKey:kOGMallInfoPlushDetails];
    [aCoder encodeDouble:_mallCount forKey:kOGMallInfoCount];
    [aCoder encodeObject:_orgs forKey:kOGMallInfoOrgs];
    [aCoder encodeDouble:_averageRating forKey:kOGMallInfoAverageRating];
    [aCoder encodeObject:_guestUserId forKey:kOGMallInfoGuestUserId];
    [aCoder encodeBool:_showStatuses forKey:kOGMallInfoShowStatuses];
    [aCoder encodeBool:_showFields forKey:kOGMallInfoShowFields];
}

- (id)copyWithZone:(NSZone *)zone
{
    OGMallInfo *copy = [[OGMallInfo alloc] init];
    
    if (copy) {

        copy.status = self.status;
        copy.guestUserEmail = [self.guestUserEmail copyWithZone:zone];
        copy.showInsights = self.showInsights;
        copy.showJTJobs = self.showJTJobs;
        copy.plushDetails = [self.plushDetails copyWithZone:zone];
        copy.mallCount = self.mallCount;
        copy.orgs = [self.orgs copyWithZone:zone];
        copy.averageRating = self.averageRating;
        copy.guestUserId = [self.guestUserId copyWithZone:zone];
        copy.showStatuses = self.showStatuses;
        copy.showFields = self.showFields;
    }
    
    return copy;
}

#pragma mark -

+ (NSURLSessionDataTask *)getMallInfoWithBlock:(void (^)(OGMallInfo *mallInfo, NSError *error))block {
    return [[OGDataServices sharedClient] GET:[NSString stringWithFormat:OGGetMallInfoURL, [OGWorkSpace sharedWorkspace].mallId] parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        OGMallInfo *malInfo = [OGMallInfo modelObjectWithDictionary:JSON];
        if (block) {
            [OGWorkSpace sharedWorkspace].orgInfo = malInfo.orgs.firstObject;
            block(malInfo, nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
    
}

+ (NSURLSessionDataTask *)getAllMallsInfoWithCurrentPageNumber:(NSUInteger)pageNumber block:(void (^)(NSArray *allMallsInfo, NSError *error))block {
    //    return getHostUrl(mContext)
    //    + "/Services/getMasters?type=allMalls&pageNumber=" + pageNo
    //    + "&pageSize=" + pageSize;

    NSDictionary *params = @{@"pageNumber": @(pageNumber),
                             @"pageSize": @(kPageSize)};

    return [[OGDataServices sharedClient] POST:OGGetAllMallsInfoURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        OGMallInfo *malInfo = [OGMallInfo modelObjectWithDictionary:responseObject];
        if (block) {
            [OGWorkSpace sharedWorkspace].orgInfo = malInfo.orgs.firstObject;
            block(malInfo.orgs, nil);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (block) {
            block([NSArray array], error);
        }

    }];
    
}

@end
