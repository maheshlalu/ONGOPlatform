//
//  OGPlushDetails.h
//
//  Created by Hanuman Kachwa on 19/12/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface OGPlushDetails : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *plushKey;
@property (nonatomic, strong) NSString *plushSecret;
@property (nonatomic, strong) NSString *plushPwd;
@property (nonatomic, strong) NSString *authorization;
@property (nonatomic, strong) NSString *plushMasterSecret;
@property (nonatomic, strong) NSString *plushEmail;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
