//
//  OGOdishaNewsJobs.m
//  OnGO
//
//  Created by Hanuman Kachwa on 23/01/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

#import "OGOdishaNewsJobs.h"

NSString *const kOGJobsP3rdCategory = @"P3rdCategory";
NSString *const kOGJobsDate = @"Date";
NSString *const kOGJobsPostedBy = @"Posted By";
NSString *const kOGJobsSubCategoryType = @"SubCategoryType";
NSString *const kOGJobsImageURL = @"Image_URL";
NSString *const kOGJobsImageName = @"Image_Name";
NSString *const kOGJobsImageCreditURL = @"Image Credit URL";
NSString *const kOGJobsImageCreditName = @"Image Credit Name";
NSString *const kOGJobsCategoryType = @"CategoryType";

@implementation OGOdishaNewsJobs

@synthesize p3rdCategory = _p3rdCategory;
@synthesize date = _date;
@synthesize postedBy = _postedBy;
@synthesize subCategoryType = _subCategoryType;
@synthesize imageURL = _imageURL;
@synthesize imageName = _imageName;
@synthesize imageCreditURL = _imageCreditURL;
@synthesize imageCreditName = _imageCreditName;
@synthesize categoryType = _categoryType;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super initWithDictionary:dict];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.p3rdCategory = [self objectOrNilForKey:kOGJobsP3rdCategory fromDictionary:dict];
        self.date = [self objectOrNilForKey:kOGJobsDate fromDictionary:dict];
        self.postedBy = [self objectOrNilForKey:kOGJobsPostedBy fromDictionary:dict];
        self.subCategoryType = [self objectOrNilForKey:kOGJobsSubCategoryType fromDictionary:dict];
        self.imageURL = [self objectOrNilForKey:kOGJobsImageURL fromDictionary:dict];
        self.imageName = [self objectOrNilForKey:kOGJobsImageName fromDictionary:dict];
        self.imageCreditURL = [self objectOrNilForKey:kOGJobsImageCreditURL fromDictionary:dict];
        self.imageCreditName = [self objectOrNilForKey:kOGJobsImageCreditName fromDictionary:dict];
        self.categoryType = [self objectOrNilForKey:kOGJobsCategoryType fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:[super dictionaryRepresentation]];
    [mutableDict setValue:self.p3rdCategory forKey:kOGJobsP3rdCategory];
    [mutableDict setValue:self.date forKey:kOGJobsDate];
    [mutableDict setValue:self.postedBy forKey:kOGJobsPostedBy];
    [mutableDict setValue:self.subCategoryType forKey:kOGJobsSubCategoryType];
    [mutableDict setValue:self.imageURL forKey:kOGJobsImageURL];
    [mutableDict setValue:self.imageName forKey:kOGJobsImageName];
    [mutableDict setValue:self.imageCreditURL forKey:kOGJobsImageCreditURL];
    [mutableDict setValue:self.imageCreditName forKey:kOGJobsImageCreditName];
    [mutableDict setValue:self.categoryType forKey:kOGJobsCategoryType];
    
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
    self = [super initWithCoder:aDecoder];
    
    self.p3rdCategory = [aDecoder decodeObjectForKey:kOGJobsP3rdCategory];
    self.date = [aDecoder decodeObjectForKey:kOGJobsDate];
    self.postedBy = [aDecoder decodeObjectForKey:kOGJobsPostedBy];
    self.subCategoryType = [aDecoder decodeObjectForKey:kOGJobsSubCategoryType];
    self.imageURL = [aDecoder decodeObjectForKey:kOGJobsImageURL];
    self.imageName = [aDecoder decodeObjectForKey:kOGJobsImageName];
    self.imageCreditURL = [aDecoder decodeObjectForKey:kOGJobsImageCreditURL];
    self.imageCreditName = [aDecoder decodeObjectForKey:kOGJobsImageCreditName];
    self.categoryType = [aDecoder decodeObjectForKey:kOGJobsCategoryType];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_p3rdCategory forKey:kOGJobsP3rdCategory];
    [aCoder encodeObject:_date forKey:kOGJobsDate];
    [aCoder encodeObject:_postedBy forKey:kOGJobsPostedBy];
    [aCoder encodeObject:_subCategoryType forKey:kOGJobsSubCategoryType];
    [aCoder encodeObject:_imageURL forKey:kOGJobsImageURL];
    [aCoder encodeObject:_imageName forKey:kOGJobsImageName];
    [aCoder encodeObject:_imageCreditURL forKey:kOGJobsImageCreditURL];
    [aCoder encodeObject:_imageCreditName forKey:kOGJobsImageCreditName];
    [aCoder encodeObject:_categoryType forKey:kOGJobsCategoryType];
}

- (id)copyWithZone:(NSZone *)zone
{
    OGOdishaNewsJobs *copy = [[OGOdishaNewsJobs alloc] init];
    
    if (copy) {
        
        copy.p3rdCategory = [self.p3rdCategory copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.postedBy = [self.postedBy copyWithZone:zone];
        copy.subCategoryType = [self.subCategoryType copyWithZone:zone];
        copy.imageURL = [self.imageURL copyWithZone:zone];
        copy.imageName = [self.imageName copyWithZone:zone];
        copy.imageCreditURL = [self.imageCreditURL copyWithZone:zone];
        copy.imageCreditName = [self.imageCreditName copyWithZone:zone];
        copy.categoryType = [self.categoryType copyWithZone:zone];
    }
    
    return copy;
}

@end
