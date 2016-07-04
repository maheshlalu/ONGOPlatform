//
//  OGAttachments.m
//
//  Created by Hanuman Kachwa on 12/01/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "OGAttachments.h"


NSString *const kOGAttachmentsMmType = @"mmType";
NSString *const kOGAttachmentsIsBannerImage = @"isBannerImage";
NSString *const kOGAttachmentsAlbumName = @"albumName";
NSString *const kOGAttachmentsImageName = @"Image_Name";
NSString *const kOGAttachmentsId = @"Id";
NSString *const kOGAttachmentsURL = @"URL";
NSString *const kOGAttachmentsIsCoverImage = @"isCoverImage";


@interface OGAttachments ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OGAttachments

@synthesize mmType = _mmType;
@synthesize isBannerImage = _isBannerImage;
@synthesize albumName = _albumName;
@synthesize imageName = _imageName;
@synthesize attachmentsIdentifier = _attachmentsIdentifier;
@synthesize uRL = _uRL;
@synthesize isCoverImage = _isCoverImage;


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
            self.mmType = [self objectOrNilForKey:kOGAttachmentsMmType fromDictionary:dict];
            self.isBannerImage = [self objectOrNilForKey:kOGAttachmentsIsBannerImage fromDictionary:dict];
            self.albumName = [self objectOrNilForKey:kOGAttachmentsAlbumName fromDictionary:dict];
            self.imageName = [self objectOrNilForKey:kOGAttachmentsImageName fromDictionary:dict];
            self.attachmentsIdentifier = [self objectOrNilForKey:kOGAttachmentsId fromDictionary:dict];
            self.uRL = [self objectOrNilForKey:kOGAttachmentsURL fromDictionary:dict];
            self.isCoverImage = [self objectOrNilForKey:kOGAttachmentsIsCoverImage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.mmType forKey:kOGAttachmentsMmType];
    [mutableDict setValue:self.isBannerImage forKey:kOGAttachmentsIsBannerImage];
    [mutableDict setValue:self.albumName forKey:kOGAttachmentsAlbumName];
    [mutableDict setValue:self.imageName forKey:kOGAttachmentsImageName];
    [mutableDict setValue:self.attachmentsIdentifier forKey:kOGAttachmentsId];
    [mutableDict setValue:self.uRL forKey:kOGAttachmentsURL];
    [mutableDict setValue:self.isCoverImage forKey:kOGAttachmentsIsCoverImage];

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

    self.mmType = [aDecoder decodeObjectForKey:kOGAttachmentsMmType];
    self.isBannerImage = [aDecoder decodeObjectForKey:kOGAttachmentsIsBannerImage];
    self.albumName = [aDecoder decodeObjectForKey:kOGAttachmentsAlbumName];
    self.imageName = [aDecoder decodeObjectForKey:kOGAttachmentsImageName];
    self.attachmentsIdentifier = [aDecoder decodeObjectForKey:kOGAttachmentsId];
    self.uRL = [aDecoder decodeObjectForKey:kOGAttachmentsURL];
    self.isCoverImage = [aDecoder decodeObjectForKey:kOGAttachmentsIsCoverImage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_mmType forKey:kOGAttachmentsMmType];
    [aCoder encodeObject:_isBannerImage forKey:kOGAttachmentsIsBannerImage];
    [aCoder encodeObject:_albumName forKey:kOGAttachmentsAlbumName];
    [aCoder encodeObject:_imageName forKey:kOGAttachmentsImageName];
    [aCoder encodeObject:_attachmentsIdentifier forKey:kOGAttachmentsId];
    [aCoder encodeObject:_uRL forKey:kOGAttachmentsURL];
    [aCoder encodeObject:_isCoverImage forKey:kOGAttachmentsIsCoverImage];
}

- (id)copyWithZone:(NSZone *)zone
{
    OGAttachments *copy = [[OGAttachments alloc] init];
    
    if (copy) {

        copy.mmType = [self.mmType copyWithZone:zone];
        copy.isBannerImage = [self.isBannerImage copyWithZone:zone];
        copy.albumName = [self.albumName copyWithZone:zone];
        copy.imageName = [self.imageName copyWithZone:zone];
        copy.attachmentsIdentifier = [self.attachmentsIdentifier copyWithZone:zone];
        copy.uRL = [self.uRL copyWithZone:zone];
        copy.isCoverImage = [self.isCoverImage copyWithZone:zone];
    }
    
    return copy;
}


@end
