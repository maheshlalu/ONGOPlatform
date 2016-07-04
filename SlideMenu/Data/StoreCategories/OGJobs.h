//
//  OGJobs.h
//
//  Created by Hanuman Kachwa on 12/01/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OGAdditionalDetails;

@interface OGJobs : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *nextJobStatuses;
@property (nonatomic, strong) NSString *jobTypeName;
@property (nonatomic, strong) NSString *overallRating;
@property (nonatomic, strong) NSArray *jobComments;
@property (nonatomic, assign) double currentJobStatusId;
@property (nonatomic, strong) NSString *createdOn;
@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSArray *hrsOfOperation;
@property (nonatomic, strong) NSString *guestUserId;
@property (nonatomic, strong) NSString *nextSeqNos;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *publicURL;
@property (nonatomic, assign) double createdById;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) double jobTypeId;
@property (nonatomic, strong) NSArray *attachments;
@property (nonatomic, strong) NSString *guestUserEmail;
@property (nonatomic, strong) NSString *currentJobStatus;
@property (nonatomic, strong) NSString *totalReviews;
@property (nonatomic, strong) NSString *categoryMall;
@property (nonatomic, strong) NSString *packageName;
@property (nonatomic, assign) double jobsIdentifier;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *productsCount;
@property (nonatomic, strong) NSString *offersCount;
@property (nonatomic, strong) NSString *twitter;
@property (nonatomic, strong) NSString *contactNumber;
@property (nonatomic, strong) NSString *postalCode;
@property (nonatomic, strong) OGAdditionalDetails *additionalDetails;
@property (nonatomic, strong) NSArray *createdSubJobs;
@property (nonatomic, strong) NSString *jobsDescription;
@property (nonatomic, strong) NSArray *insights;
@property (nonatomic, strong) NSString *borough;
@property (nonatomic, strong) NSString *district;
@property (nonatomic, strong) NSString *faceBook;
@property (nonatomic, strong) NSString *itemCode;
@property (nonatomic, strong) NSString *zoom;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *createdByFullName;
@property (nonatomic, strong) NSArray *businessType;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
