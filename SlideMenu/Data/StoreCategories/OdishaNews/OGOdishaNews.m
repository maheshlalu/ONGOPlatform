//
//  OGOdishaNews.m
//
//  Created by Hanuman Kachwa on 23/01/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "OGOdishaNews.h"
#import "OGOdishaNewsJobs.h"
#import "OGUserdetails.h"
#import "OGDataServices.h"

NSString* const OGGetLatestNewsURL = @"Services/getMasters?type=%@&unlimited=false&mallId=%@";

NSString *const kOGOdishaNewsShowInsights = @"showInsights";
NSString *const kOGOdishaNewsJobs = @"jobs";
NSString *const kOGOdishaNewsAverageRating = @"averageRating";
NSString *const kOGOdishaNewsTotalNumRecords = @"totalNumRecords";
NSString *const kOGOdishaNewsCount = @"count";
NSString *const kOGOdishaNewsGuestUserId = @"guestUserId";
NSString *const kOGOdishaNewsShowJTJobs = @"showJTJobs";
NSString *const kOGOdishaNewsUserdetails = @"userdetails";
NSString *const kOGOdishaNewsShowFields = @"showFields";
NSString *const kOGOdishaNewsShowStatuses = @"showStatuses";
NSString *const kOGOdishaNewsStatus = @"status";
NSString *const kOGOdishaNewsGuestUserEmail = @"guestUserEmail";


@interface OGOdishaNews ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OGOdishaNews

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
            self.showInsights = [[self objectOrNilForKey:kOGOdishaNewsShowInsights fromDictionary:dict] boolValue];
    NSObject *receivedOGJobs = [dict objectForKey:kOGOdishaNewsJobs];
    NSMutableArray *parsedOGJobs = [NSMutableArray array];
    if ([receivedOGJobs isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedOGJobs) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedOGJobs addObject:[OGOdishaNewsJobs modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedOGJobs isKindOfClass:[NSDictionary class]]) {
       [parsedOGJobs addObject:[OGOdishaNewsJobs modelObjectWithDictionary:(NSDictionary *)receivedOGJobs]];
    }

    self.jobs = [NSArray arrayWithArray:parsedOGJobs];
            self.averageRating = [[self objectOrNilForKey:kOGOdishaNewsAverageRating fromDictionary:dict] doubleValue];
            self.totalNumRecords = [[self objectOrNilForKey:kOGOdishaNewsTotalNumRecords fromDictionary:dict] doubleValue];
            self.count = [[self objectOrNilForKey:kOGOdishaNewsCount fromDictionary:dict] doubleValue];
            self.guestUserId = [self objectOrNilForKey:kOGOdishaNewsGuestUserId fromDictionary:dict];
            self.showJTJobs = [[self objectOrNilForKey:kOGOdishaNewsShowJTJobs fromDictionary:dict] boolValue];
            self.userdetails = [OGUserdetails modelObjectWithDictionary:[dict objectForKey:kOGOdishaNewsUserdetails]];
            self.showFields = [[self objectOrNilForKey:kOGOdishaNewsShowFields fromDictionary:dict] boolValue];
            self.showStatuses = [[self objectOrNilForKey:kOGOdishaNewsShowStatuses fromDictionary:dict] boolValue];
            self.status = [[self objectOrNilForKey:kOGOdishaNewsStatus fromDictionary:dict] doubleValue];
            self.guestUserEmail = [self objectOrNilForKey:kOGOdishaNewsGuestUserEmail fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithBool:self.showInsights] forKey:kOGOdishaNewsShowInsights];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForJobs] forKey:kOGOdishaNewsJobs];
    [mutableDict setValue:[NSNumber numberWithDouble:self.averageRating] forKey:kOGOdishaNewsAverageRating];
    [mutableDict setValue:[NSNumber numberWithDouble:self.totalNumRecords] forKey:kOGOdishaNewsTotalNumRecords];
    [mutableDict setValue:[NSNumber numberWithDouble:self.count] forKey:kOGOdishaNewsCount];
    [mutableDict setValue:self.guestUserId forKey:kOGOdishaNewsGuestUserId];
    [mutableDict setValue:[NSNumber numberWithBool:self.showJTJobs] forKey:kOGOdishaNewsShowJTJobs];
    [mutableDict setValue:[self.userdetails dictionaryRepresentation] forKey:kOGOdishaNewsUserdetails];
    [mutableDict setValue:[NSNumber numberWithBool:self.showFields] forKey:kOGOdishaNewsShowFields];
    [mutableDict setValue:[NSNumber numberWithBool:self.showStatuses] forKey:kOGOdishaNewsShowStatuses];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kOGOdishaNewsStatus];
    [mutableDict setValue:self.guestUserEmail forKey:kOGOdishaNewsGuestUserEmail];

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

    self.showInsights = [aDecoder decodeBoolForKey:kOGOdishaNewsShowInsights];
    self.jobs = [aDecoder decodeObjectForKey:kOGOdishaNewsJobs];
    self.averageRating = [aDecoder decodeDoubleForKey:kOGOdishaNewsAverageRating];
    self.totalNumRecords = [aDecoder decodeDoubleForKey:kOGOdishaNewsTotalNumRecords];
    self.count = [aDecoder decodeDoubleForKey:kOGOdishaNewsCount];
    self.guestUserId = [aDecoder decodeObjectForKey:kOGOdishaNewsGuestUserId];
    self.showJTJobs = [aDecoder decodeBoolForKey:kOGOdishaNewsShowJTJobs];
    self.userdetails = [aDecoder decodeObjectForKey:kOGOdishaNewsUserdetails];
    self.showFields = [aDecoder decodeBoolForKey:kOGOdishaNewsShowFields];
    self.showStatuses = [aDecoder decodeBoolForKey:kOGOdishaNewsShowStatuses];
    self.status = [aDecoder decodeDoubleForKey:kOGOdishaNewsStatus];
    self.guestUserEmail = [aDecoder decodeObjectForKey:kOGOdishaNewsGuestUserEmail];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeBool:_showInsights forKey:kOGOdishaNewsShowInsights];
    [aCoder encodeObject:_jobs forKey:kOGOdishaNewsJobs];
    [aCoder encodeDouble:_averageRating forKey:kOGOdishaNewsAverageRating];
    [aCoder encodeDouble:_totalNumRecords forKey:kOGOdishaNewsTotalNumRecords];
    [aCoder encodeDouble:_count forKey:kOGOdishaNewsCount];
    [aCoder encodeObject:_guestUserId forKey:kOGOdishaNewsGuestUserId];
    [aCoder encodeBool:_showJTJobs forKey:kOGOdishaNewsShowJTJobs];
    [aCoder encodeObject:_userdetails forKey:kOGOdishaNewsUserdetails];
    [aCoder encodeBool:_showFields forKey:kOGOdishaNewsShowFields];
    [aCoder encodeBool:_showStatuses forKey:kOGOdishaNewsShowStatuses];
    [aCoder encodeDouble:_status forKey:kOGOdishaNewsStatus];
    [aCoder encodeObject:_guestUserEmail forKey:kOGOdishaNewsGuestUserEmail];
}

- (id)copyWithZone:(NSZone *)zone
{
    OGOdishaNews *copy = [[OGOdishaNews alloc] init];
    
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

+ (NSURLSessionDataTask *)getNewsWithType:(NSString*)newsType currentPageNumber:(NSUInteger)pageNumber block:(void (^)(NSArray *allMallsInfo, NSError *error))block {
    //    return getHostUrl(mContext)
    //    + "/Services/getMasters?type=allMalls&pageNumber=" + pageNo
    //    + "&pageSize=" + pageSize;
    
    NSDictionary *params = @{@"pageNumber": @(pageNumber),
                             @"pageSize": @(kPageSize)};
    
    NSString *newsTypeEncoded = [newsType stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    return [[OGDataServices sharedClient] POST:[NSString stringWithFormat:OGGetLatestNewsURL, newsTypeEncoded, [OGWorkSpace sharedWorkspace].mallId] parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        OGOdishaNews *malInfo = [OGOdishaNews modelObjectWithDictionary:responseObject];
        if (block) {
            block(malInfo.jobs, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (block) {
            block([NSArray array], error);
        }
        
    }];
    
}

@end
