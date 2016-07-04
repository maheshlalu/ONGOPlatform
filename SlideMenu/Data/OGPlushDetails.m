//
//  OGPlushDetails.m
//
//  Created by Hanuman Kachwa on 19/12/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "OGPlushDetails.h"


NSString *const kOGPlushDetailsPlushKey = @"plush_key";
NSString *const kOGPlushDetailsPlushSecret = @"plush_secret";
NSString *const kOGPlushDetailsPlushPwd = @"plush_pwd";
NSString *const kOGPlushDetailsAuthorization = @"Authorization";
NSString *const kOGPlushDetailsPlushMasterSecret = @"plush_master_secret";
NSString *const kOGPlushDetailsPlushEmail = @"plush_email";


@interface OGPlushDetails ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OGPlushDetails

@synthesize plushKey = _plushKey;
@synthesize plushSecret = _plushSecret;
@synthesize plushPwd = _plushPwd;
@synthesize authorization = _authorization;
@synthesize plushMasterSecret = _plushMasterSecret;
@synthesize plushEmail = _plushEmail;


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
            self.plushKey = [self objectOrNilForKey:kOGPlushDetailsPlushKey fromDictionary:dict];
            self.plushSecret = [self objectOrNilForKey:kOGPlushDetailsPlushSecret fromDictionary:dict];
            self.plushPwd = [self objectOrNilForKey:kOGPlushDetailsPlushPwd fromDictionary:dict];
            self.authorization = [self objectOrNilForKey:kOGPlushDetailsAuthorization fromDictionary:dict];
            self.plushMasterSecret = [self objectOrNilForKey:kOGPlushDetailsPlushMasterSecret fromDictionary:dict];
            self.plushEmail = [self objectOrNilForKey:kOGPlushDetailsPlushEmail fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.plushKey forKey:kOGPlushDetailsPlushKey];
    [mutableDict setValue:self.plushSecret forKey:kOGPlushDetailsPlushSecret];
    [mutableDict setValue:self.plushPwd forKey:kOGPlushDetailsPlushPwd];
    [mutableDict setValue:self.authorization forKey:kOGPlushDetailsAuthorization];
    [mutableDict setValue:self.plushMasterSecret forKey:kOGPlushDetailsPlushMasterSecret];
    [mutableDict setValue:self.plushEmail forKey:kOGPlushDetailsPlushEmail];

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

    self.plushKey = [aDecoder decodeObjectForKey:kOGPlushDetailsPlushKey];
    self.plushSecret = [aDecoder decodeObjectForKey:kOGPlushDetailsPlushSecret];
    self.plushPwd = [aDecoder decodeObjectForKey:kOGPlushDetailsPlushPwd];
    self.authorization = [aDecoder decodeObjectForKey:kOGPlushDetailsAuthorization];
    self.plushMasterSecret = [aDecoder decodeObjectForKey:kOGPlushDetailsPlushMasterSecret];
    self.plushEmail = [aDecoder decodeObjectForKey:kOGPlushDetailsPlushEmail];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_plushKey forKey:kOGPlushDetailsPlushKey];
    [aCoder encodeObject:_plushSecret forKey:kOGPlushDetailsPlushSecret];
    [aCoder encodeObject:_plushPwd forKey:kOGPlushDetailsPlushPwd];
    [aCoder encodeObject:_authorization forKey:kOGPlushDetailsAuthorization];
    [aCoder encodeObject:_plushMasterSecret forKey:kOGPlushDetailsPlushMasterSecret];
    [aCoder encodeObject:_plushEmail forKey:kOGPlushDetailsPlushEmail];
}

- (id)copyWithZone:(NSZone *)zone
{
    OGPlushDetails *copy = [[OGPlushDetails alloc] init];
    
    if (copy) {

        copy.plushKey = [self.plushKey copyWithZone:zone];
        copy.plushSecret = [self.plushSecret copyWithZone:zone];
        copy.plushPwd = [self.plushPwd copyWithZone:zone];
        copy.authorization = [self.authorization copyWithZone:zone];
        copy.plushMasterSecret = [self.plushMasterSecret copyWithZone:zone];
        copy.plushEmail = [self.plushEmail copyWithZone:zone];
    }
    
    return copy;
}


@end
