//
//  OGUserdetails.h
//
//  Created by Hanuman Kachwa on 19/12/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface OGUserdetails : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *userdetailsIdentifier;
@property (nonatomic, strong) NSString *subdomain;
@property (nonatomic, strong) NSString *website;
@property (nonatomic, strong) NSString *fullname;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
