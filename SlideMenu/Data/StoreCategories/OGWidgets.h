//
//  OGWidgets.h
//
//  Created by Hanuman Kachwa on 19/12/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface OGWidgets : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *visibility;
@property (nonatomic, strong) NSString *widgetType;
@property (nonatomic, strong) NSString *highlighted;
@property (nonatomic, strong) NSString *enabledReviews;
@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *subCategories;
@property (nonatomic, strong) NSString *enabledUserAddition;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
