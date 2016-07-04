//
//  OGBaseModel.h
//  OnGO
//
//  Created by Hanuman Kachwa on 19/12/15.
//  Copyright © 2015 Aryan Ghassemi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OGBaseModel : NSObject

@property (nonatomic, assign) double averageRating;
@property (nonatomic, assign) double status;
@property (nonatomic, strong) NSString *guestUserId;
@property (nonatomic, strong) NSString *guestUserEmail;
@property (nonatomic, assign) double mallCount;
@property (nonatomic, assign) BOOL showJTJobs;
@property (nonatomic, assign) BOOL showStatuses;
@property (nonatomic, assign) BOOL showFields;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
