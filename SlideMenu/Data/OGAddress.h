//
//  OGAddress.h
//
//  Created by Hanuman Kachwa on 27/12/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OGCountry;

@interface OGAddress : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double addressIdentifier;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) OGCountry *country;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *location;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
