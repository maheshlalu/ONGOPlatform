//
//  OGOrgs.m
//
//  Created by Hanuman Kachwa on 27/12/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "OGOrgs.h"
#import "OGAddress.h"


NSString *const kOGOrgsFacebookPageLink = @"FacebookPageLink";
NSString *const kOGOrgsMainCategory = @"mainCategory";
NSString *const kOGOrgsHrsOfOperation = @"hrsOfOperation";
NSString *const kOGOrgsId = @"id";
NSString *const kOGOrgsLogo = @"logo";
NSString *const kOGOrgsCategory = @"category";
NSString *const kOGOrgsPublicURL = @"publicURL";
NSString *const kOGOrgsAddress = @"address";
NSString *const kOGOrgsStoresCount = @"storesCount";
NSString *const kOGOrgsIcLauncherLdpi = @"ic_launcher_ldpi";
NSString *const kOGOrgsDescription = @"description";
NSString *const kOGOrgsOffersCount = @"offersCount";
NSString *const kOGOrgsLanguageName = @"languageName";
NSString *const kOGOrgsIcLauncherMdpi = @"ic_launcher_mdpi";
NSString *const kOGOrgsWebsite = @"website";
NSString *const kOGOrgsPrimaryColor = @"primaryColor";
NSString *const kOGOrgsEmail = @"email";
NSString *const kOGOrgsIcLauncherXxhdpi = @"ic_launcher_xxhdpi";
NSString *const kOGOrgsSplashscreen = @"splashscreen";
NSString *const kOGOrgsName = @"name";
NSString *const kOGOrgsLongitude = @"longitude";
NSString *const kOGOrgsCoverImage = @"Cover_Image";
NSString *const kOGOrgsGallery = @"gallery";
NSString *const kOGOrgsCurrencyType = @"currencyType";
NSString *const kOGOrgsDefaultStoreId = @"defaultStoreId";
NSString *const kOGOrgsIcLauncherXxxhdpi = @"ic_launcher_xxxhdpi";
NSString *const kOGOrgsIcLauncherXhdpi = @"ic_launcher_xhdpi";
NSString *const kOGOrgsMobile = @"mobile";
NSString *const kOGOrgsSecondaryColor = @"secondaryColor";
NSString *const kOGOrgsLanguageCode = @"languageCode";
NSString *const kOGOrgsTwitterinfo = @"Twitterinfo";
NSString *const kOGOrgsIcLauncherHdpi = @"ic_launcher_hdpi";
NSString *const kOGOrgsPromotionURL = @"promotionURL";
NSString *const kOGOrgsFacebookinfo = @"Facebookinfo";
NSString *const kOGOrgsBusinessType = @"businessType";
NSString *const kOGOrgsLatitude = @"latitude";


@interface OGOrgs ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OGOrgs

@synthesize facebookPageLink = _facebookPageLink;
@synthesize mainCategory = _mainCategory;
@synthesize hrsOfOperation = _hrsOfOperation;
@synthesize orgsIdentifier = _orgsIdentifier;
@synthesize logo = _logo;
@synthesize category = _category;
@synthesize publicURL = _publicURL;
@synthesize address = _address;
@synthesize storesCount = _storesCount;
@synthesize icLauncherLdpi = _icLauncherLdpi;
@synthesize orgsDescription = _orgsDescription;
@synthesize offersCount = _offersCount;
@synthesize languageName = _languageName;
@synthesize icLauncherMdpi = _icLauncherMdpi;
@synthesize website = _website;
@synthesize primaryColor = _primaryColor;
@synthesize email = _email;
@synthesize icLauncherXxhdpi = _icLauncherXxhdpi;
@synthesize splashscreen = _splashscreen;
@synthesize name = _name;
@synthesize longitude = _longitude;
@synthesize coverImage = _coverImage;
@synthesize gallery = _gallery;
@synthesize currencyType = _currencyType;
@synthesize defaultStoreId = _defaultStoreId;
@synthesize icLauncherXxxhdpi = _icLauncherXxxhdpi;
@synthesize icLauncherXhdpi = _icLauncherXhdpi;
@synthesize mobile = _mobile;
@synthesize secondaryColor = _secondaryColor;
@synthesize languageCode = _languageCode;
@synthesize twitterinfo = _twitterinfo;
@synthesize icLauncherHdpi = _icLauncherHdpi;
@synthesize promotionURL = _promotionURL;
@synthesize facebookinfo = _facebookinfo;
@synthesize businessType = _businessType;
@synthesize latitude = _latitude;


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
            self.facebookPageLink = [self objectOrNilForKey:kOGOrgsFacebookPageLink fromDictionary:dict];
            self.mainCategory = [self objectOrNilForKey:kOGOrgsMainCategory fromDictionary:dict];
            self.hrsOfOperation = [self objectOrNilForKey:kOGOrgsHrsOfOperation fromDictionary:dict];
            self.orgsIdentifier = [self objectOrNilForKey:kOGOrgsId fromDictionary:dict];
            self.logo = [self objectOrNilForKey:kOGOrgsLogo fromDictionary:dict];
            self.category = [self objectOrNilForKey:kOGOrgsCategory fromDictionary:dict];
            self.publicURL = [self objectOrNilForKey:kOGOrgsPublicURL fromDictionary:dict];
            self.address = [OGAddress modelObjectWithDictionary:[dict objectForKey:kOGOrgsAddress]];
            self.storesCount = [self objectOrNilForKey:kOGOrgsStoresCount fromDictionary:dict];
            self.icLauncherLdpi = [self objectOrNilForKey:kOGOrgsIcLauncherLdpi fromDictionary:dict];
            self.orgsDescription = [self objectOrNilForKey:kOGOrgsDescription fromDictionary:dict];
            self.offersCount = [self objectOrNilForKey:kOGOrgsOffersCount fromDictionary:dict];
            self.languageName = [self objectOrNilForKey:kOGOrgsLanguageName fromDictionary:dict];
            self.icLauncherMdpi = [self objectOrNilForKey:kOGOrgsIcLauncherMdpi fromDictionary:dict];
            self.website = [self objectOrNilForKey:kOGOrgsWebsite fromDictionary:dict];
            self.primaryColor = [self objectOrNilForKey:kOGOrgsPrimaryColor fromDictionary:dict];
            self.email = [self objectOrNilForKey:kOGOrgsEmail fromDictionary:dict];
            self.icLauncherXxhdpi = [self objectOrNilForKey:kOGOrgsIcLauncherXxhdpi fromDictionary:dict];
            self.splashscreen = [self objectOrNilForKey:kOGOrgsSplashscreen fromDictionary:dict];
            self.name = [self objectOrNilForKey:kOGOrgsName fromDictionary:dict];
            self.longitude = [self objectOrNilForKey:kOGOrgsLongitude fromDictionary:dict];
            self.coverImage = [self objectOrNilForKey:kOGOrgsCoverImage fromDictionary:dict];
            self.gallery = [self objectOrNilForKey:kOGOrgsGallery fromDictionary:dict];
            self.currencyType = [self objectOrNilForKey:kOGOrgsCurrencyType fromDictionary:dict];
            self.defaultStoreId = [[self objectOrNilForKey:kOGOrgsDefaultStoreId fromDictionary:dict] doubleValue];
            self.icLauncherXxxhdpi = [self objectOrNilForKey:kOGOrgsIcLauncherXxxhdpi fromDictionary:dict];
            self.icLauncherXhdpi = [self objectOrNilForKey:kOGOrgsIcLauncherXhdpi fromDictionary:dict];
            self.mobile = [self objectOrNilForKey:kOGOrgsMobile fromDictionary:dict];
            self.secondaryColor = [self objectOrNilForKey:kOGOrgsSecondaryColor fromDictionary:dict];
            self.languageCode = [self objectOrNilForKey:kOGOrgsLanguageCode fromDictionary:dict];
            self.twitterinfo = [self objectOrNilForKey:kOGOrgsTwitterinfo fromDictionary:dict];
            self.icLauncherHdpi = [self objectOrNilForKey:kOGOrgsIcLauncherHdpi fromDictionary:dict];
            self.promotionURL = [self objectOrNilForKey:kOGOrgsPromotionURL fromDictionary:dict];
            self.facebookinfo = [self objectOrNilForKey:kOGOrgsFacebookinfo fromDictionary:dict];
            self.businessType = [self objectOrNilForKey:kOGOrgsBusinessType fromDictionary:dict];
            self.latitude = [self objectOrNilForKey:kOGOrgsLatitude fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.facebookPageLink forKey:kOGOrgsFacebookPageLink];
    [mutableDict setValue:self.mainCategory forKey:kOGOrgsMainCategory];
    NSMutableArray *tempArrayForHrsOfOperation = [NSMutableArray array];
    for (NSObject *subArrayObject in self.hrsOfOperation) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForHrsOfOperation addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForHrsOfOperation addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForHrsOfOperation] forKey:kOGOrgsHrsOfOperation];
    [mutableDict setValue:self.orgsIdentifier forKey:kOGOrgsId];
    [mutableDict setValue:self.logo forKey:kOGOrgsLogo];
    [mutableDict setValue:self.category forKey:kOGOrgsCategory];
    [mutableDict setValue:self.publicURL forKey:kOGOrgsPublicURL];
    [mutableDict setValue:[self.address dictionaryRepresentation] forKey:kOGOrgsAddress];
    [mutableDict setValue:self.storesCount forKey:kOGOrgsStoresCount];
    [mutableDict setValue:self.icLauncherLdpi forKey:kOGOrgsIcLauncherLdpi];
    [mutableDict setValue:self.orgsDescription forKey:kOGOrgsDescription];
    [mutableDict setValue:self.offersCount forKey:kOGOrgsOffersCount];
    [mutableDict setValue:self.languageName forKey:kOGOrgsLanguageName];
    [mutableDict setValue:self.icLauncherMdpi forKey:kOGOrgsIcLauncherMdpi];
    [mutableDict setValue:self.website forKey:kOGOrgsWebsite];
    [mutableDict setValue:self.primaryColor forKey:kOGOrgsPrimaryColor];
    [mutableDict setValue:self.email forKey:kOGOrgsEmail];
    [mutableDict setValue:self.icLauncherXxhdpi forKey:kOGOrgsIcLauncherXxhdpi];
    [mutableDict setValue:self.splashscreen forKey:kOGOrgsSplashscreen];
    [mutableDict setValue:self.name forKey:kOGOrgsName];
    [mutableDict setValue:self.longitude forKey:kOGOrgsLongitude];
    [mutableDict setValue:self.coverImage forKey:kOGOrgsCoverImage];
    NSMutableArray *tempArrayForGallery = [NSMutableArray array];
    for (NSObject *subArrayObject in self.gallery) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForGallery addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForGallery addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForGallery] forKey:kOGOrgsGallery];
    [mutableDict setValue:self.currencyType forKey:kOGOrgsCurrencyType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.defaultStoreId] forKey:kOGOrgsDefaultStoreId];
    [mutableDict setValue:self.icLauncherXxxhdpi forKey:kOGOrgsIcLauncherXxxhdpi];
    [mutableDict setValue:self.icLauncherXhdpi forKey:kOGOrgsIcLauncherXhdpi];
    [mutableDict setValue:self.mobile forKey:kOGOrgsMobile];
    [mutableDict setValue:self.secondaryColor forKey:kOGOrgsSecondaryColor];
    [mutableDict setValue:self.languageCode forKey:kOGOrgsLanguageCode];
    [mutableDict setValue:self.twitterinfo forKey:kOGOrgsTwitterinfo];
    [mutableDict setValue:self.icLauncherHdpi forKey:kOGOrgsIcLauncherHdpi];
    [mutableDict setValue:self.promotionURL forKey:kOGOrgsPromotionURL];
    [mutableDict setValue:self.facebookinfo forKey:kOGOrgsFacebookinfo];
    NSMutableArray *tempArrayForBusinessType = [NSMutableArray array];
    for (NSObject *subArrayObject in self.businessType) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForBusinessType addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForBusinessType addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForBusinessType] forKey:kOGOrgsBusinessType];
    [mutableDict setValue:self.latitude forKey:kOGOrgsLatitude];

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

    self.facebookPageLink = [aDecoder decodeObjectForKey:kOGOrgsFacebookPageLink];
    self.mainCategory = [aDecoder decodeObjectForKey:kOGOrgsMainCategory];
    self.hrsOfOperation = [aDecoder decodeObjectForKey:kOGOrgsHrsOfOperation];
    self.orgsIdentifier = [aDecoder decodeObjectForKey:kOGOrgsId];
    self.logo = [aDecoder decodeObjectForKey:kOGOrgsLogo];
    self.category = [aDecoder decodeObjectForKey:kOGOrgsCategory];
    self.publicURL = [aDecoder decodeObjectForKey:kOGOrgsPublicURL];
    self.address = [aDecoder decodeObjectForKey:kOGOrgsAddress];
    self.storesCount = [aDecoder decodeObjectForKey:kOGOrgsStoresCount];
    self.icLauncherLdpi = [aDecoder decodeObjectForKey:kOGOrgsIcLauncherLdpi];
    self.orgsDescription = [aDecoder decodeObjectForKey:kOGOrgsDescription];
    self.offersCount = [aDecoder decodeObjectForKey:kOGOrgsOffersCount];
    self.languageName = [aDecoder decodeObjectForKey:kOGOrgsLanguageName];
    self.icLauncherMdpi = [aDecoder decodeObjectForKey:kOGOrgsIcLauncherMdpi];
    self.website = [aDecoder decodeObjectForKey:kOGOrgsWebsite];
    self.primaryColor = [aDecoder decodeObjectForKey:kOGOrgsPrimaryColor];
    self.email = [aDecoder decodeObjectForKey:kOGOrgsEmail];
    self.icLauncherXxhdpi = [aDecoder decodeObjectForKey:kOGOrgsIcLauncherXxhdpi];
    self.splashscreen = [aDecoder decodeObjectForKey:kOGOrgsSplashscreen];
    self.name = [aDecoder decodeObjectForKey:kOGOrgsName];
    self.longitude = [aDecoder decodeObjectForKey:kOGOrgsLongitude];
    self.coverImage = [aDecoder decodeObjectForKey:kOGOrgsCoverImage];
    self.gallery = [aDecoder decodeObjectForKey:kOGOrgsGallery];
    self.currencyType = [aDecoder decodeObjectForKey:kOGOrgsCurrencyType];
    self.defaultStoreId = [aDecoder decodeDoubleForKey:kOGOrgsDefaultStoreId];
    self.icLauncherXxxhdpi = [aDecoder decodeObjectForKey:kOGOrgsIcLauncherXxxhdpi];
    self.icLauncherXhdpi = [aDecoder decodeObjectForKey:kOGOrgsIcLauncherXhdpi];
    self.mobile = [aDecoder decodeObjectForKey:kOGOrgsMobile];
    self.secondaryColor = [aDecoder decodeObjectForKey:kOGOrgsSecondaryColor];
    self.languageCode = [aDecoder decodeObjectForKey:kOGOrgsLanguageCode];
    self.twitterinfo = [aDecoder decodeObjectForKey:kOGOrgsTwitterinfo];
    self.icLauncherHdpi = [aDecoder decodeObjectForKey:kOGOrgsIcLauncherHdpi];
    self.promotionURL = [aDecoder decodeObjectForKey:kOGOrgsPromotionURL];
    self.facebookinfo = [aDecoder decodeObjectForKey:kOGOrgsFacebookinfo];
    self.businessType = [aDecoder decodeObjectForKey:kOGOrgsBusinessType];
    self.latitude = [aDecoder decodeObjectForKey:kOGOrgsLatitude];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_facebookPageLink forKey:kOGOrgsFacebookPageLink];
    [aCoder encodeObject:_mainCategory forKey:kOGOrgsMainCategory];
    [aCoder encodeObject:_hrsOfOperation forKey:kOGOrgsHrsOfOperation];
    [aCoder encodeObject:_orgsIdentifier forKey:kOGOrgsId];
    [aCoder encodeObject:_logo forKey:kOGOrgsLogo];
    [aCoder encodeObject:_category forKey:kOGOrgsCategory];
    [aCoder encodeObject:_publicURL forKey:kOGOrgsPublicURL];
    [aCoder encodeObject:_address forKey:kOGOrgsAddress];
    [aCoder encodeObject:_storesCount forKey:kOGOrgsStoresCount];
    [aCoder encodeObject:_icLauncherLdpi forKey:kOGOrgsIcLauncherLdpi];
    [aCoder encodeObject:_orgsDescription forKey:kOGOrgsDescription];
    [aCoder encodeObject:_offersCount forKey:kOGOrgsOffersCount];
    [aCoder encodeObject:_languageName forKey:kOGOrgsLanguageName];
    [aCoder encodeObject:_icLauncherMdpi forKey:kOGOrgsIcLauncherMdpi];
    [aCoder encodeObject:_website forKey:kOGOrgsWebsite];
    [aCoder encodeObject:_primaryColor forKey:kOGOrgsPrimaryColor];
    [aCoder encodeObject:_email forKey:kOGOrgsEmail];
    [aCoder encodeObject:_icLauncherXxhdpi forKey:kOGOrgsIcLauncherXxhdpi];
    [aCoder encodeObject:_splashscreen forKey:kOGOrgsSplashscreen];
    [aCoder encodeObject:_name forKey:kOGOrgsName];
    [aCoder encodeObject:_longitude forKey:kOGOrgsLongitude];
    [aCoder encodeObject:_coverImage forKey:kOGOrgsCoverImage];
    [aCoder encodeObject:_gallery forKey:kOGOrgsGallery];
    [aCoder encodeObject:_currencyType forKey:kOGOrgsCurrencyType];
    [aCoder encodeDouble:_defaultStoreId forKey:kOGOrgsDefaultStoreId];
    [aCoder encodeObject:_icLauncherXxxhdpi forKey:kOGOrgsIcLauncherXxxhdpi];
    [aCoder encodeObject:_icLauncherXhdpi forKey:kOGOrgsIcLauncherXhdpi];
    [aCoder encodeObject:_mobile forKey:kOGOrgsMobile];
    [aCoder encodeObject:_secondaryColor forKey:kOGOrgsSecondaryColor];
    [aCoder encodeObject:_languageCode forKey:kOGOrgsLanguageCode];
    [aCoder encodeObject:_twitterinfo forKey:kOGOrgsTwitterinfo];
    [aCoder encodeObject:_icLauncherHdpi forKey:kOGOrgsIcLauncherHdpi];
    [aCoder encodeObject:_promotionURL forKey:kOGOrgsPromotionURL];
    [aCoder encodeObject:_facebookinfo forKey:kOGOrgsFacebookinfo];
    [aCoder encodeObject:_businessType forKey:kOGOrgsBusinessType];
    [aCoder encodeObject:_latitude forKey:kOGOrgsLatitude];
}

- (id)copyWithZone:(NSZone *)zone
{
    OGOrgs *copy = [[OGOrgs alloc] init];
    
    if (copy) {

        copy.facebookPageLink = [self.facebookPageLink copyWithZone:zone];
        copy.mainCategory = [self.mainCategory copyWithZone:zone];
        copy.hrsOfOperation = [self.hrsOfOperation copyWithZone:zone];
        copy.orgsIdentifier = [self.orgsIdentifier copyWithZone:zone];
        copy.logo = [self.logo copyWithZone:zone];
        copy.category = [self.category copyWithZone:zone];
        copy.publicURL = [self.publicURL copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.storesCount = [self.storesCount copyWithZone:zone];
        copy.icLauncherLdpi = [self.icLauncherLdpi copyWithZone:zone];
        copy.orgsDescription = [self.orgsDescription copyWithZone:zone];
        copy.offersCount = [self.offersCount copyWithZone:zone];
        copy.languageName = [self.languageName copyWithZone:zone];
        copy.icLauncherMdpi = [self.icLauncherMdpi copyWithZone:zone];
        copy.website = [self.website copyWithZone:zone];
        copy.primaryColor = [self.primaryColor copyWithZone:zone];
        copy.email = [self.email copyWithZone:zone];
        copy.icLauncherXxhdpi = [self.icLauncherXxhdpi copyWithZone:zone];
        copy.splashscreen = [self.splashscreen copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.longitude = [self.longitude copyWithZone:zone];
        copy.coverImage = [self.coverImage copyWithZone:zone];
        copy.gallery = [self.gallery copyWithZone:zone];
        copy.currencyType = [self.currencyType copyWithZone:zone];
        copy.defaultStoreId = self.defaultStoreId;
        copy.icLauncherXxxhdpi = [self.icLauncherXxxhdpi copyWithZone:zone];
        copy.icLauncherXhdpi = [self.icLauncherXhdpi copyWithZone:zone];
        copy.mobile = [self.mobile copyWithZone:zone];
        copy.secondaryColor = [self.secondaryColor copyWithZone:zone];
        copy.languageCode = [self.languageCode copyWithZone:zone];
        copy.twitterinfo = [self.twitterinfo copyWithZone:zone];
        copy.icLauncherHdpi = [self.icLauncherHdpi copyWithZone:zone];
        copy.promotionURL = [self.promotionURL copyWithZone:zone];
        copy.facebookinfo = [self.facebookinfo copyWithZone:zone];
        copy.businessType = [self.businessType copyWithZone:zone];
        copy.latitude = [self.latitude copyWithZone:zone];
    }
    
    return copy;
}


@end
