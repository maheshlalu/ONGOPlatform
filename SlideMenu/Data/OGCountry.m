//
//  OGCountry.m
//
//  Created by Hanuman Kachwa on 27/12/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "OGCountry.h"


NSString *const kOGCountryName = @"name";
NSString *const kOGCountryId = @"id";
NSString *const kOGCountryCode = @"code";


@interface OGCountry ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OGCountry

@synthesize name = _name;
@synthesize countryIdentifier = _countryIdentifier;
@synthesize code = _code;


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
            self.name = [self objectOrNilForKey:kOGCountryName fromDictionary:dict];
            self.countryIdentifier = [[self objectOrNilForKey:kOGCountryId fromDictionary:dict] doubleValue];
            self.code = [self objectOrNilForKey:kOGCountryCode fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.name forKey:kOGCountryName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.countryIdentifier] forKey:kOGCountryId];
    [mutableDict setValue:self.code forKey:kOGCountryCode];

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

    self.name = [aDecoder decodeObjectForKey:kOGCountryName];
    self.countryIdentifier = [aDecoder decodeDoubleForKey:kOGCountryId];
    self.code = [aDecoder decodeObjectForKey:kOGCountryCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_name forKey:kOGCountryName];
    [aCoder encodeDouble:_countryIdentifier forKey:kOGCountryId];
    [aCoder encodeObject:_code forKey:kOGCountryCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    OGCountry *copy = [[OGCountry alloc] init];
    
    if (copy) {

        copy.name = [self.name copyWithZone:zone];
        copy.countryIdentifier = self.countryIdentifier;
        copy.code = [self.code copyWithZone:zone];
    }
    
    return copy;
}


@end
