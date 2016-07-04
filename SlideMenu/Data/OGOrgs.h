//
//  OGOrgs.h
//
//  Created by Hanuman Kachwa on 21/01/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OGAddress;

@interface OGOrgs : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *facebookPageLink;
@property (nonatomic, strong) NSString *mainCategory;
@property (nonatomic, strong) NSArray *hrsOfOperation;
@property (nonatomic, strong) NSString *orgsIdentifier;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *publicURL;
@property (nonatomic, strong) OGAddress *address;
@property (nonatomic, strong) NSString *storesCount;
@property (nonatomic, strong) NSString *icLauncherLdpi;
@property (nonatomic, strong) NSString *orgsDescription;
@property (nonatomic, strong) NSString *offersCount;
@property (nonatomic, strong) NSString *languageName;
@property (nonatomic, strong) NSString *icLauncherMdpi;
@property (nonatomic, strong) NSString *website;
@property (nonatomic, strong) NSString *primaryColor;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *icLauncherXxhdpi;
@property (nonatomic, strong) NSString *splashscreen;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *coverImage;
@property (nonatomic, strong) NSArray *gallery;
@property (nonatomic, strong) NSString *currencyType;
@property (nonatomic, assign) double defaultStoreId;
@property (nonatomic, strong) NSString *icLauncherXxxhdpi;
@property (nonatomic, strong) NSString *icLauncherXhdpi;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *secondaryColor;
@property (nonatomic, strong) NSString *languageCode;
@property (nonatomic, strong) NSString *twitterinfo;
@property (nonatomic, strong) NSString *icLauncherHdpi;
@property (nonatomic, strong) NSString *promotionURL;
@property (nonatomic, strong) NSString *facebookinfo;
@property (nonatomic, strong) NSArray *businessType;
@property (nonatomic, strong) NSString *latitude;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
