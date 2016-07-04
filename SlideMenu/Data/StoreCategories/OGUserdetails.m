//
//  OGUserdetails.m
//
//  Created by Hanuman Kachwa on 19/12/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "OGUserdetails.h"


NSString *const kOGUserdetailsEmail = @"email";
NSString *const kOGUserdetailsId = @"id";
NSString *const kOGUserdetailsSubdomain = @"subdomain";
NSString *const kOGUserdetailsWebsite = @"website";
NSString *const kOGUserdetailsFullname = @"fullname";


@interface OGUserdetails ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OGUserdetails

@synthesize email = _email;
@synthesize userdetailsIdentifier = _userdetailsIdentifier;
@synthesize subdomain = _subdomain;
@synthesize website = _website;
@synthesize fullname = _fullname;


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
            self.email = [self objectOrNilForKey:kOGUserdetailsEmail fromDictionary:dict];
            self.userdetailsIdentifier = [self objectOrNilForKey:kOGUserdetailsId fromDictionary:dict];
            self.subdomain = [self objectOrNilForKey:kOGUserdetailsSubdomain fromDictionary:dict];
            self.website = [self objectOrNilForKey:kOGUserdetailsWebsite fromDictionary:dict];
            self.fullname = [self objectOrNilForKey:kOGUserdetailsFullname fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.email forKey:kOGUserdetailsEmail];
    [mutableDict setValue:self.userdetailsIdentifier forKey:kOGUserdetailsId];
    [mutableDict setValue:self.subdomain forKey:kOGUserdetailsSubdomain];
    [mutableDict setValue:self.website forKey:kOGUserdetailsWebsite];
    [mutableDict setValue:self.fullname forKey:kOGUserdetailsFullname];

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

    self.email = [aDecoder decodeObjectForKey:kOGUserdetailsEmail];
    self.userdetailsIdentifier = [aDecoder decodeObjectForKey:kOGUserdetailsId];
    self.subdomain = [aDecoder decodeObjectForKey:kOGUserdetailsSubdomain];
    self.website = [aDecoder decodeObjectForKey:kOGUserdetailsWebsite];
    self.fullname = [aDecoder decodeObjectForKey:kOGUserdetailsFullname];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_email forKey:kOGUserdetailsEmail];
    [aCoder encodeObject:_userdetailsIdentifier forKey:kOGUserdetailsId];
    [aCoder encodeObject:_subdomain forKey:kOGUserdetailsSubdomain];
    [aCoder encodeObject:_website forKey:kOGUserdetailsWebsite];
    [aCoder encodeObject:_fullname forKey:kOGUserdetailsFullname];
}

- (id)copyWithZone:(NSZone *)zone
{
    OGUserdetails *copy = [[OGUserdetails alloc] init];
    
    if (copy) {

        copy.email = [self.email copyWithZone:zone];
        copy.userdetailsIdentifier = [self.userdetailsIdentifier copyWithZone:zone];
        copy.subdomain = [self.subdomain copyWithZone:zone];
        copy.website = [self.website copyWithZone:zone];
        copy.fullname = [self.fullname copyWithZone:zone];
    }
    
    return copy;
}


@end
