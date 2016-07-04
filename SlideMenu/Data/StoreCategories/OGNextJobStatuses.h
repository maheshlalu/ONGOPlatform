//
//  OGNextJobStatuses.h
//
//  Created by Hanuman Kachwa on 19/12/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface OGNextJobStatuses : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *statusId;
@property (nonatomic, strong) NSString *seqNo;
@property (nonatomic, strong) NSArray *subJobtypeForms;
@property (nonatomic, strong) NSString *statusName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
