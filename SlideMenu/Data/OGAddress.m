//
//  OGAddress.m
//
//  Created by Hanuman Kachwa on 27/12/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "OGAddress.h"
#import "OGCountry.h"


NSString *const kOGAddressId = @"id";
NSString *const kOGAddressState = @"state";
NSString *const kOGAddressCountry = @"country";
NSString *const kOGAddressCity = @"city";
NSString *const kOGAddressLocation = @"location";


@interface OGAddress ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OGAddress

@synthesize addressIdentifier = _addressIdentifier;
@synthesize state = _state;
@synthesize country = _country;
@synthesize city = _city;
@synthesize location = _location;


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
            self.addressIdentifier = [[self objectOrNilForKey:kOGAddressId fromDictionary:dict] doubleValue];
            self.state = [self objectOrNilForKey:kOGAddressState fromDictionary:dict];
            self.country = [OGCountry modelObjectWithDictionary:[dict objectForKey:kOGAddressCountry]];
            self.city = [self objectOrNilForKey:kOGAddressCity fromDictionary:dict];
            self.location = [self objectOrNilForKey:kOGAddressLocation fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.addressIdentifier] forKey:kOGAddressId];
    [mutableDict setValue:self.state forKey:kOGAddressState];
    [mutableDict setValue:[self.country dictionaryRepresentation] forKey:kOGAddressCountry];
    [mutableDict setValue:self.city forKey:kOGAddressCity];
    [mutableDict setValue:self.location forKey:kOGAddressLocation];

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

    self.addressIdentifier = [aDecoder decodeDoubleForKey:kOGAddressId];
    self.state = [aDecoder decodeObjectForKey:kOGAddressState];
    self.country = [aDecoder decodeObjectForKey:kOGAddressCountry];
    self.city = [aDecoder decodeObjectForKey:kOGAddressCity];
    self.location = [aDecoder decodeObjectForKey:kOGAddressLocation];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_addressIdentifier forKey:kOGAddressId];
    [aCoder encodeObject:_state forKey:kOGAddressState];
    [aCoder encodeObject:_country forKey:kOGAddressCountry];
    [aCoder encodeObject:_city forKey:kOGAddressCity];
    [aCoder encodeObject:_location forKey:kOGAddressLocation];
}

- (id)copyWithZone:(NSZone *)zone
{
    OGAddress *copy = [[OGAddress alloc] init];
    
    if (copy) {

        copy.addressIdentifier = self.addressIdentifier;
        copy.state = [self.state copyWithZone:zone];
        copy.country = [self.country copyWithZone:zone];
        copy.city = [self.city copyWithZone:zone];
        copy.location = [self.location copyWithZone:zone];
    }
    
    return copy;
}


@end
