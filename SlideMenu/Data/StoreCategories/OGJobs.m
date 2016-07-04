//
//  OGJobs.m
//
//  Created by Hanuman Kachwa on 12/01/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "OGJobs.h"
#import "OGInsights.h"
#import "OGNextJobStatuses.h"
#import "OGAdditionalDetails.h"
#import "OGAttachments.h"

NSString *const kOGJobsNextJobStatuses = @"Next_Job_Statuses";
NSString *const kOGJobsJobTypeName = @"jobTypeName";
NSString *const kOGJobsOverallRating = @"overallRating";
NSString *const kOGJobsJobComments = @"jobComments";
NSString *const kOGJobsCurrentJobStatusId = @"Current_Job_StatusId";
NSString *const kOGJobsCreatedOn = @"createdOn";
NSString *const kOGJobsStreet = @"Street";
NSString *const kOGJobsCountry = @"Country";
NSString *const kOGJobsHrsOfOperation = @"hrsOfOperation";
NSString *const kOGJobsGuestUserId = @"guestUserId";
NSString *const kOGJobsNextSeqNos = @"Next_Seq_Nos";
NSString *const kOGJobsImage = @"Image";
NSString *const kOGJobsPublicURL = @"publicURL";
NSString *const kOGJobsCreatedById = @"createdById";
NSString *const kOGJobsName = @"Name";
NSString *const kOGJobsJobTypeId = @"jobTypeId";
NSString *const kOGJobsAttachments = @"Attachments";
NSString *const kOGJobsGuestUserEmail = @"guestUserEmail";
NSString *const kOGJobsCurrentJobStatus = @"Current_Job_Status";
NSString *const kOGJobsTotalReviews = @"totalReviews";
NSString *const kOGJobsCategoryMall = @"Category_Mall";
NSString *const kOGJobsPackageName = @"PackageName";
NSString *const kOGJobsId = @"id";
NSString *const kOGJobsAddress = @"Address";
NSString *const kOGJobsCity = @"City";
NSString *const kOGJobsLatitude = @"Latitude";
NSString *const kOGJobsLongitude = @"Longitude";
NSString *const kOGJobsProductsCount = @"productsCount";
NSString *const kOGJobsOffersCount = @"offersCount";
NSString *const kOGJobsTwitter = @"Twitter";
NSString *const kOGJobsContactNumber = @"Contact Number";
NSString *const kOGJobsPostalCode = @"PostalCode";
NSString *const kOGJobsAdditionalDetails = @"Additional_Details";
NSString *const kOGJobsCreatedSubJobs = @"CreatedSubJobs";
NSString *const kOGJobsDescription = @"Description";
NSString *const kOGJobsInsights = @"Insights";
NSString *const kOGJobsBorough = @"Borough";
NSString *const kOGJobsDistrict = @"District";
NSString *const kOGJobsFaceBook = @"FaceBook";
NSString *const kOGJobsItemCode = @"ItemCode";
NSString *const kOGJobsZoom = @"Zoom";
NSString *const kOGJobsState = @"State";
NSString *const kOGJobsType = @"Type";
NSString *const kOGJobsCreatedByFullName = @"createdByFullName";
NSString *const kOGJobsBusinessType = @"businessType";


@interface OGJobs ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OGJobs

@synthesize nextJobStatuses = _nextJobStatuses;
@synthesize jobTypeName = _jobTypeName;
@synthesize overallRating = _overallRating;
@synthesize jobComments = _jobComments;
@synthesize currentJobStatusId = _currentJobStatusId;
@synthesize createdOn = _createdOn;
@synthesize street = _street;
@synthesize country = _country;
@synthesize hrsOfOperation = _hrsOfOperation;
@synthesize guestUserId = _guestUserId;
@synthesize nextSeqNos = _nextSeqNos;
@synthesize image = _image;
@synthesize publicURL = _publicURL;
@synthesize createdById = _createdById;
@synthesize name = _name;
@synthesize jobTypeId = _jobTypeId;
@synthesize attachments = _attachments;
@synthesize guestUserEmail = _guestUserEmail;
@synthesize currentJobStatus = _currentJobStatus;
@synthesize totalReviews = _totalReviews;
@synthesize categoryMall = _categoryMall;
@synthesize packageName = _packageName;
@synthesize jobsIdentifier = _jobsIdentifier;
@synthesize address = _address;
@synthesize city = _city;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize productsCount = _productsCount;
@synthesize offersCount = _offersCount;
@synthesize twitter = _twitter;
@synthesize contactNumber = _contactNumber;
@synthesize postalCode = _postalCode;
@synthesize additionalDetails = _additionalDetails;
@synthesize createdSubJobs = _createdSubJobs;
@synthesize jobsDescription = _jobsDescription;
@synthesize insights = _insights;
@synthesize borough = _borough;
@synthesize district = _district;
@synthesize faceBook = _faceBook;
@synthesize itemCode = _itemCode;
@synthesize zoom = _zoom;
@synthesize state = _state;
@synthesize type = _type;
@synthesize createdByFullName = _createdByFullName;
@synthesize businessType = _businessType;


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
            self.createdOn = [self objectOrNilForKey:kOGJobsCreatedOn fromDictionary:dict];
            self.street = [self objectOrNilForKey:kOGJobsStreet fromDictionary:dict];
            self.country = [self objectOrNilForKey:kOGJobsCountry fromDictionary:dict];
            self.hrsOfOperation = [self objectOrNilForKey:kOGJobsHrsOfOperation fromDictionary:dict];
        NSObject *receivedOGNextJobStatuses = [dict objectForKey:kOGJobsNextJobStatuses];
        NSMutableArray *parsedOGNextJobStatuses = [NSMutableArray array];
        if ([receivedOGNextJobStatuses isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedOGNextJobStatuses) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedOGNextJobStatuses addObject:[OGNextJobStatuses modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedOGNextJobStatuses isKindOfClass:[NSDictionary class]]) {
            [parsedOGNextJobStatuses addObject:[OGNextJobStatuses modelObjectWithDictionary:(NSDictionary *)receivedOGNextJobStatuses]];
        }
        
        self.nextJobStatuses = [NSArray arrayWithArray:parsedOGNextJobStatuses];
        self.jobTypeName = [self objectOrNilForKey:kOGJobsJobTypeName fromDictionary:dict];
        self.overallRating = [self objectOrNilForKey:kOGJobsOverallRating fromDictionary:dict];
        self.jobComments = [self objectOrNilForKey:kOGJobsJobComments fromDictionary:dict];
        self.currentJobStatusId = [[self objectOrNilForKey:kOGJobsCurrentJobStatusId fromDictionary:dict] doubleValue];
        self.createdOn = [self objectOrNilForKey:kOGJobsCreatedOn fromDictionary:dict];
        self.hrsOfOperation = [self objectOrNilForKey:kOGJobsHrsOfOperation fromDictionary:dict];
        self.guestUserId = [self objectOrNilForKey:kOGJobsGuestUserId fromDictionary:dict];
        self.nextSeqNos = [self objectOrNilForKey:kOGJobsNextSeqNos fromDictionary:dict];
        self.image = [self objectOrNilForKey:kOGJobsImage fromDictionary:dict];
        self.publicURL = [self objectOrNilForKey:kOGJobsPublicURL fromDictionary:dict];
        self.createdById = [[self objectOrNilForKey:kOGJobsCreatedById fromDictionary:dict] doubleValue];
        self.name = [self objectOrNilForKey:kOGJobsName fromDictionary:dict];
        self.jobTypeId = [[self objectOrNilForKey:kOGJobsJobTypeId fromDictionary:dict] doubleValue];
        self.attachments = [self objectOrNilForKey:kOGJobsAttachments fromDictionary:dict];
        self.guestUserEmail = [self objectOrNilForKey:kOGJobsGuestUserEmail fromDictionary:dict];
        self.currentJobStatus = [self objectOrNilForKey:kOGJobsCurrentJobStatus fromDictionary:dict];
        self.totalReviews = [self objectOrNilForKey:kOGJobsTotalReviews fromDictionary:dict];
        self.categoryMall = [self objectOrNilForKey:kOGJobsCategoryMall fromDictionary:dict];
        self.packageName = [self objectOrNilForKey:kOGJobsPackageName fromDictionary:dict];
            self.jobsIdentifier = [[self objectOrNilForKey:kOGJobsId fromDictionary:dict] doubleValue];
            self.address = [self objectOrNilForKey:kOGJobsAddress fromDictionary:dict];
            self.city = [self objectOrNilForKey:kOGJobsCity fromDictionary:dict];
            self.latitude = [self objectOrNilForKey:kOGJobsLatitude fromDictionary:dict];
            self.longitude = [self objectOrNilForKey:kOGJobsLongitude fromDictionary:dict];
            self.productsCount = [self objectOrNilForKey:kOGJobsProductsCount fromDictionary:dict];
            self.offersCount = [self objectOrNilForKey:kOGJobsOffersCount fromDictionary:dict];
            self.twitter = [self objectOrNilForKey:kOGJobsTwitter fromDictionary:dict];
            self.contactNumber = [self objectOrNilForKey:kOGJobsContactNumber fromDictionary:dict];
            self.postalCode = [self objectOrNilForKey:kOGJobsPostalCode fromDictionary:dict];
        self.additionalDetails = [OGAdditionalDetails modelObjectWithDictionary:[dict objectForKey:kOGJobsAdditionalDetails]];
        self.createdSubJobs = [self objectOrNilForKey:kOGJobsCreatedSubJobs fromDictionary:dict];
        self.jobsDescription = [self objectOrNilForKey:kOGJobsDescription fromDictionary:dict];

    NSObject *receivedOGInsights = [dict objectForKey:kOGJobsInsights];
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
            self.borough = [self objectOrNilForKey:kOGJobsBorough fromDictionary:dict];
            self.district = [self objectOrNilForKey:kOGJobsDistrict fromDictionary:dict];
            self.faceBook = [self objectOrNilForKey:kOGJobsFaceBook fromDictionary:dict];
            self.itemCode = [self objectOrNilForKey:kOGJobsItemCode fromDictionary:dict];
            self.zoom = [self objectOrNilForKey:kOGJobsZoom fromDictionary:dict];
            self.state = [self objectOrNilForKey:kOGJobsState fromDictionary:dict];
            self.type = [self objectOrNilForKey:kOGJobsType fromDictionary:dict];
            self.createdByFullName = [self objectOrNilForKey:kOGJobsCreatedByFullName fromDictionary:dict];
            self.businessType = [self objectOrNilForKey:kOGJobsBusinessType fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForNextJobStatuses = [NSMutableArray array];
    for (NSObject *subArrayObject in self.nextJobStatuses) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForNextJobStatuses addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForNextJobStatuses addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForNextJobStatuses] forKey:kOGJobsNextJobStatuses];
    [mutableDict setValue:self.overallRating forKey:kOGJobsOverallRating];
    NSMutableArray *tempArrayForJobComments = [NSMutableArray array];
    for (NSObject *subArrayObject in self.jobComments) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForJobComments addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForJobComments addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForJobComments] forKey:kOGJobsJobComments];
    [mutableDict setValue:self.createdOn forKey:kOGJobsCreatedOn];
    [mutableDict setValue:self.street forKey:kOGJobsStreet];
    [mutableDict setValue:self.country forKey:kOGJobsCountry];
    NSMutableArray *tempArrayForHrsOfOperation = [NSMutableArray array];
    for (NSObject *subArrayObject in self.hrsOfOperation) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForHrsOfOperation addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForHrsOfOperation addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForHrsOfOperation] forKey:kOGJobsHrsOfOperation];
    [mutableDict setValue:self.guestUserId forKey:kOGJobsGuestUserId];
    [mutableDict setValue:self.nextSeqNos forKey:kOGJobsNextSeqNos];
    [mutableDict setValue:self.image forKey:kOGJobsImage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createdById] forKey:kOGJobsCreatedById];
    [mutableDict setValue:self.name forKey:kOGJobsName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.jobTypeId] forKey:kOGJobsJobTypeId];
    NSMutableArray *tempArrayForAttachments = [NSMutableArray array];
    for (NSObject *subArrayObject in self.attachments) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForAttachments addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForAttachments addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForAttachments] forKey:kOGJobsAttachments];
    [mutableDict setValue:self.guestUserEmail forKey:kOGJobsGuestUserEmail];
    [mutableDict setValue:self.currentJobStatus forKey:kOGJobsCurrentJobStatus];
    [mutableDict setValue:self.totalReviews forKey:kOGJobsTotalReviews];
    [mutableDict setValue:self.categoryMall forKey:kOGJobsCategoryMall];
    [mutableDict setValue:self.packageName forKey:kOGJobsPackageName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.jobsIdentifier] forKey:kOGJobsId];
    [mutableDict setValue:self.address forKey:kOGJobsAddress];
    [mutableDict setValue:[NSNumber numberWithDouble:self.currentJobStatusId] forKey:kOGJobsCurrentJobStatusId];
    [mutableDict setValue:self.city forKey:kOGJobsCity];
    [mutableDict setValue:self.latitude forKey:kOGJobsLatitude];
    [mutableDict setValue:self.longitude forKey:kOGJobsLongitude];
    [mutableDict setValue:self.productsCount forKey:kOGJobsProductsCount];
    [mutableDict setValue:self.offersCount forKey:kOGJobsOffersCount];
    [mutableDict setValue:self.twitter forKey:kOGJobsTwitter];
    [mutableDict setValue:self.contactNumber forKey:kOGJobsContactNumber];
    [mutableDict setValue:self.postalCode forKey:kOGJobsPostalCode];
    [mutableDict setValue:[self.additionalDetails dictionaryRepresentation] forKey:kOGJobsAdditionalDetails];
    NSMutableArray *tempArrayForCreatedSubJobs = [NSMutableArray array];
    for (NSObject *subArrayObject in self.createdSubJobs) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCreatedSubJobs addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCreatedSubJobs addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCreatedSubJobs] forKey:kOGJobsCreatedSubJobs];
    [mutableDict setValue:self.jobsDescription forKey:kOGJobsDescription];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForInsights] forKey:kOGJobsInsights];
    [mutableDict setValue:self.borough forKey:kOGJobsBorough];
    [mutableDict setValue:self.district forKey:kOGJobsDistrict];
    [mutableDict setValue:self.faceBook forKey:kOGJobsFaceBook];
    [mutableDict setValue:self.itemCode forKey:kOGJobsItemCode];
    [mutableDict setValue:self.zoom forKey:kOGJobsZoom];
    [mutableDict setValue:self.state forKey:kOGJobsState];
    [mutableDict setValue:self.type forKey:kOGJobsType];
    [mutableDict setValue:self.createdByFullName forKey:kOGJobsCreatedByFullName];
    NSMutableArray *tempArrayForBusinessType = [NSMutableArray array];
    for (NSObject *subArrayObject in self.businessType) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForBusinessType addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForBusinessType addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForBusinessType] forKey:kOGJobsBusinessType];

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

    self.nextJobStatuses = [aDecoder decodeObjectForKey:kOGJobsNextJobStatuses];
    self.overallRating = [aDecoder decodeObjectForKey:kOGJobsOverallRating];
    self.jobComments = [aDecoder decodeObjectForKey:kOGJobsJobComments];
    self.createdOn = [aDecoder decodeObjectForKey:kOGJobsCreatedOn];
    self.street = [aDecoder decodeObjectForKey:kOGJobsStreet];
    self.country = [aDecoder decodeObjectForKey:kOGJobsCountry];
    self.hrsOfOperation = [aDecoder decodeObjectForKey:kOGJobsHrsOfOperation];
    self.guestUserId = [aDecoder decodeObjectForKey:kOGJobsGuestUserId];
    self.nextSeqNos = [aDecoder decodeObjectForKey:kOGJobsNextSeqNos];
    self.createdById = [aDecoder decodeDoubleForKey:kOGJobsCreatedById];
    self.name = [aDecoder decodeObjectForKey:kOGJobsName];
    self.jobTypeId = [aDecoder decodeDoubleForKey:kOGJobsJobTypeId];
    self.attachments = [aDecoder decodeObjectForKey:kOGJobsAttachments];
    self.guestUserEmail = [aDecoder decodeObjectForKey:kOGJobsGuestUserEmail];
    self.currentJobStatus = [aDecoder decodeObjectForKey:kOGJobsCurrentJobStatus];
    self.totalReviews = [aDecoder decodeObjectForKey:kOGJobsTotalReviews];
    self.categoryMall = [aDecoder decodeObjectForKey:kOGJobsCategoryMall];
    self.packageName = [aDecoder decodeObjectForKey:kOGJobsPackageName];
    self.jobsIdentifier = [aDecoder decodeDoubleForKey:kOGJobsId];
    self.address = [aDecoder decodeObjectForKey:kOGJobsAddress];
    self.currentJobStatusId = [aDecoder decodeDoubleForKey:kOGJobsCurrentJobStatusId];
    self.publicURL = [aDecoder decodeObjectForKey:kOGJobsPublicURL];
    self.city = [aDecoder decodeObjectForKey:kOGJobsCity];
    self.jobTypeName = [aDecoder decodeObjectForKey:kOGJobsJobTypeName];
    self.image = [aDecoder decodeObjectForKey:kOGJobsImage];
    self.latitude = [aDecoder decodeObjectForKey:kOGJobsLatitude];
    self.longitude = [aDecoder decodeObjectForKey:kOGJobsLongitude];
    self.productsCount = [aDecoder decodeObjectForKey:kOGJobsProductsCount];
    self.offersCount = [aDecoder decodeObjectForKey:kOGJobsOffersCount];
    self.twitter = [aDecoder decodeObjectForKey:kOGJobsTwitter];
    self.contactNumber = [aDecoder decodeObjectForKey:kOGJobsContactNumber];
    self.postalCode = [aDecoder decodeObjectForKey:kOGJobsPostalCode];
    self.additionalDetails = [aDecoder decodeObjectForKey:kOGJobsAdditionalDetails];
    self.createdSubJobs = [aDecoder decodeObjectForKey:kOGJobsCreatedSubJobs];
    self.jobsDescription = [aDecoder decodeObjectForKey:kOGJobsDescription];
    self.insights = [aDecoder decodeObjectForKey:kOGJobsInsights];
    self.borough = [aDecoder decodeObjectForKey:kOGJobsBorough];
    self.district = [aDecoder decodeObjectForKey:kOGJobsDistrict];
    self.faceBook = [aDecoder decodeObjectForKey:kOGJobsFaceBook];
    self.itemCode = [aDecoder decodeObjectForKey:kOGJobsItemCode];
    self.zoom = [aDecoder decodeObjectForKey:kOGJobsZoom];
    self.state = [aDecoder decodeObjectForKey:kOGJobsState];
    self.type = [aDecoder decodeObjectForKey:kOGJobsType];
    self.createdByFullName = [aDecoder decodeObjectForKey:kOGJobsCreatedByFullName];
    self.businessType = [aDecoder decodeObjectForKey:kOGJobsBusinessType];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_nextJobStatuses forKey:kOGJobsNextJobStatuses];
    [aCoder encodeObject:_jobTypeName forKey:kOGJobsJobTypeName];
    [aCoder encodeObject:_overallRating forKey:kOGJobsOverallRating];
    [aCoder encodeObject:_jobComments forKey:kOGJobsJobComments];
    [aCoder encodeObject:_createdOn forKey:kOGJobsCreatedOn];
    [aCoder encodeObject:_street forKey:kOGJobsStreet];
    [aCoder encodeObject:_country forKey:kOGJobsCountry];
    [aCoder encodeObject:_hrsOfOperation forKey:kOGJobsHrsOfOperation];
    [aCoder encodeObject:_guestUserId forKey:kOGJobsGuestUserId];
    [aCoder encodeObject:_nextSeqNos forKey:kOGJobsNextSeqNos];
    [aCoder encodeObject:_publicURL forKey:kOGJobsPublicURL];
    [aCoder encodeDouble:_createdById forKey:kOGJobsCreatedById];
    [aCoder encodeObject:_name forKey:kOGJobsName];
    [aCoder encodeDouble:_jobTypeId forKey:kOGJobsJobTypeId];
    [aCoder encodeObject:_attachments forKey:kOGJobsAttachments];
    [aCoder encodeObject:_guestUserEmail forKey:kOGJobsGuestUserEmail];
    [aCoder encodeObject:_currentJobStatus forKey:kOGJobsCurrentJobStatus];
    [aCoder encodeObject:_totalReviews forKey:kOGJobsTotalReviews];
    [aCoder encodeObject:_categoryMall forKey:kOGJobsCategoryMall];
    [aCoder encodeObject:_packageName forKey:kOGJobsPackageName];
    [aCoder encodeDouble:_jobsIdentifier forKey:kOGJobsId];
    [aCoder encodeObject:_address forKey:kOGJobsAddress];
    [aCoder encodeDouble:_currentJobStatusId forKey:kOGJobsCurrentJobStatusId];
    [aCoder encodeObject:_publicURL forKey:kOGJobsPublicURL];
    [aCoder encodeObject:_city forKey:kOGJobsCity];
    [aCoder encodeObject:_jobTypeName forKey:kOGJobsJobTypeName];
    [aCoder encodeObject:_image forKey:kOGJobsImage];
    [aCoder encodeObject:_latitude forKey:kOGJobsLatitude];
    [aCoder encodeObject:_longitude forKey:kOGJobsLongitude];
    [aCoder encodeObject:_productsCount forKey:kOGJobsProductsCount];
    [aCoder encodeObject:_offersCount forKey:kOGJobsOffersCount];
    [aCoder encodeObject:_twitter forKey:kOGJobsTwitter];
    [aCoder encodeObject:_contactNumber forKey:kOGJobsContactNumber];
    [aCoder encodeObject:_postalCode forKey:kOGJobsPostalCode];
    [aCoder encodeObject:_additionalDetails forKey:kOGJobsAdditionalDetails];
    [aCoder encodeObject:_createdSubJobs forKey:kOGJobsCreatedSubJobs];
    [aCoder encodeObject:_jobsDescription forKey:kOGJobsDescription];
    [aCoder encodeObject:_insights forKey:kOGJobsInsights];
    [aCoder encodeObject:_borough forKey:kOGJobsBorough];
    [aCoder encodeObject:_district forKey:kOGJobsDistrict];
    [aCoder encodeObject:_faceBook forKey:kOGJobsFaceBook];
    [aCoder encodeObject:_itemCode forKey:kOGJobsItemCode];
    [aCoder encodeObject:_jobsDescription forKey:kOGJobsDescription];
    [aCoder encodeObject:_additionalDetails forKey:kOGJobsAdditionalDetails];
    [aCoder encodeObject:_overallRating forKey:kOGJobsOverallRating];
    [aCoder encodeObject:_createdSubJobs forKey:kOGJobsCreatedSubJobs];
    [aCoder encodeObject:_categoryMall forKey:kOGJobsCategoryMall];
    [aCoder encodeObject:_zoom forKey:kOGJobsZoom];
    [aCoder encodeObject:_state forKey:kOGJobsState];
    [aCoder encodeObject:_type forKey:kOGJobsType];
    [aCoder encodeObject:_createdByFullName forKey:kOGJobsCreatedByFullName];
    [aCoder encodeObject:_businessType forKey:kOGJobsBusinessType];
}

- (id)copyWithZone:(NSZone *)zone
{
    OGJobs *copy = [[OGJobs alloc] init];
    
    if (copy) {

        copy.nextJobStatuses = [self.nextJobStatuses copyWithZone:zone];
        copy.jobTypeName = [self.jobTypeName copyWithZone:zone];
        copy.overallRating = [self.overallRating copyWithZone:zone];
        copy.jobComments = [self.jobComments copyWithZone:zone];
        copy.currentJobStatusId = self.currentJobStatusId;
        copy.createdOn = [self.createdOn copyWithZone:zone];
        copy.street = [self.street copyWithZone:zone];
        copy.country = [self.country copyWithZone:zone];
        copy.hrsOfOperation = [self.hrsOfOperation copyWithZone:zone];
        copy.guestUserId = [self.guestUserId copyWithZone:zone];
        copy.nextSeqNos = [self.nextSeqNos copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
        copy.publicURL = [self.publicURL copyWithZone:zone];
        copy.createdById = self.createdById;
        copy.name = [self.name copyWithZone:zone];
        copy.jobTypeId = self.jobTypeId;
        copy.attachments = [self.attachments copyWithZone:zone];
        copy.guestUserEmail = [self.guestUserEmail copyWithZone:zone];
        copy.currentJobStatus = [self.currentJobStatus copyWithZone:zone];
        copy.totalReviews = [self.totalReviews copyWithZone:zone];
        copy.categoryMall = [self.categoryMall copyWithZone:zone];
        copy.packageName = [self.packageName copyWithZone:zone];
        copy.jobsIdentifier = self.jobsIdentifier;
        copy.name = [self.name copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.currentJobStatusId = self.currentJobStatusId;
        copy.publicURL = [self.publicURL copyWithZone:zone];
        copy.city = [self.city copyWithZone:zone];
        copy.jobTypeName = [self.jobTypeName copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
        copy.latitude = [self.latitude copyWithZone:zone];
        copy.longitude = [self.longitude copyWithZone:zone];
        copy.productsCount = [self.productsCount copyWithZone:zone];
        copy.offersCount = [self.offersCount copyWithZone:zone];
        copy.twitter = [self.twitter copyWithZone:zone];
        copy.contactNumber = [self.contactNumber copyWithZone:zone];
        copy.postalCode = [self.postalCode copyWithZone:zone];
        copy.additionalDetails = [self.additionalDetails copyWithZone:zone];
        copy.createdSubJobs = [self.createdSubJobs copyWithZone:zone];
        copy.jobsDescription = [self.jobsDescription copyWithZone:zone];
        copy.insights = [self.insights copyWithZone:zone];
        copy.borough = [self.borough copyWithZone:zone];
        copy.nextSeqNos = [self.nextSeqNos copyWithZone:zone];
        copy.guestUserEmail = [self.guestUserEmail copyWithZone:zone];
        copy.jobComments = [self.jobComments copyWithZone:zone];
        copy.packageName = [self.packageName copyWithZone:zone];
        copy.currentJobStatus = [self.currentJobStatus copyWithZone:zone];
        copy.nextJobStatuses = [self.nextJobStatuses copyWithZone:zone];
        copy.district = [self.district copyWithZone:zone];
        copy.faceBook = [self.faceBook copyWithZone:zone];
        copy.itemCode = [self.itemCode copyWithZone:zone];
        copy.jobsDescription = [self.jobsDescription copyWithZone:zone];
        copy.additionalDetails = [self.additionalDetails copyWithZone:zone];
        copy.overallRating = [self.overallRating copyWithZone:zone];
        copy.createdSubJobs = [self.createdSubJobs copyWithZone:zone];
        copy.categoryMall = [self.categoryMall copyWithZone:zone];
        copy.zoom = [self.zoom copyWithZone:zone];
        copy.attachments = [self.attachments copyWithZone:zone];
        copy.guestUserId = [self.guestUserId copyWithZone:zone];
        copy.state = [self.state copyWithZone:zone];
        copy.totalReviews = [self.totalReviews copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.createdByFullName = [self.createdByFullName copyWithZone:zone];
        copy.businessType = [self.businessType copyWithZone:zone];
        copy.createdById = self.createdById;
        copy.jobTypeId = self.jobTypeId;
    }
    
    return copy;
}


@end
