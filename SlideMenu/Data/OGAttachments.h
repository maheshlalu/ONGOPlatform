//
//  OGAttachments.h
//
//  Created by Hanuman Kachwa on 12/01/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface OGAttachments : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *mmType;
@property (nonatomic, strong) NSString *isBannerImage;
@property (nonatomic, strong) NSString *albumName;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *attachmentsIdentifier;
@property (nonatomic, strong) NSString *uRL;
@property (nonatomic, strong) NSString *isCoverImage;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
