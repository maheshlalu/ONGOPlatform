//
//  OGInsights.m
//
//  Created by Hanuman Kachwa on 19/12/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "OGInsights.h"


NSString *const kOGInsightsServicesComment = @"Services Comment";
NSString *const kOGInsightsProductsShare = @"Products Share";
NSString *const kOGInsightsGmail = @"Gmail";
NSString *const kOGInsightsServicesView = @"Services View";
NSString *const kOGInsightsProductsView = @"Products View";
NSString *const kOGInsightsOffersView = @"Offers View";
NSString *const kOGInsightsHangouts = @"Hangouts";
NSString *const kOGInsightsMessaging = @"Messaging";
NSString *const kOGInsightsRegister = @"Register";
NSString *const kOGInsightsPinterest = @"Pinterest";
NSString *const kOGInsightsServicesShare = @"Services Share";
NSString *const kOGInsightsOffersComment = @"Offers Comment";
NSString *const kOGInsightsOffersShare = @"Offers Share";
NSString *const kOGInsightsOffersFavorite = @"Offers Favorite";
NSString *const kOGInsightsProductsComment = @"Products Comment";
NSString *const kOGInsightsProductsBuy = @"Products Buy";
NSString *const kOGInsightsInstagram = @"Instagram";
NSString *const kOGInsightsWhatsApp = @"WhatsApp";
NSString *const kOGInsightsCampaignsShare = @"Campaigns Share";
NSString *const kOGInsightsCampaignsFavorite = @"Campaigns Favorite";
NSString *const kOGInsightsProductsFavorite = @"Products Favorite";
NSString *const kOGInsightsCampaignsComment = @"Campaigns Comment";
NSString *const kOGInsightsPoints = @"points";
NSString *const kOGInsightsFacebook = @"Facebook";
NSString *const kOGInsightsLogin = @"Login";
NSString *const kOGInsightsServicesFavorite = @"Services Favorite";
NSString *const kOGInsightsSkype = @"Skype";
NSString *const kOGInsightsLinkedin = @"Linkedin";
NSString *const kOGInsightsProductsCart = @"Products Cart";
NSString *const kOGInsightsTwitter = @"Twitter";
NSString *const kOGInsightsGoogle = @"Google+";
NSString *const kOGInsightsCampaignsView = @"Campaigns View";


@interface OGInsights ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OGInsights

@synthesize servicesComment = _servicesComment;
@synthesize productsShare = _productsShare;
@synthesize gmail = _gmail;
@synthesize servicesView = _servicesView;
@synthesize productsView = _productsView;
@synthesize offersView = _offersView;
@synthesize hangouts = _hangouts;
@synthesize messaging = _messaging;
@synthesize registerProperty = _registerProperty;
@synthesize pinterest = _pinterest;
@synthesize servicesShare = _servicesShare;
@synthesize offersComment = _offersComment;
@synthesize offersShare = _offersShare;
@synthesize offersFavorite = _offersFavorite;
@synthesize productsComment = _productsComment;
@synthesize productsBuy = _productsBuy;
@synthesize instagram = _instagram;
@synthesize whatsApp = _whatsApp;
@synthesize campaignsShare = _campaignsShare;
@synthesize campaignsFavorite = _campaignsFavorite;
@synthesize productsFavorite = _productsFavorite;
@synthesize campaignsComment = _campaignsComment;
@synthesize points = _points;
@synthesize facebook = _facebook;
@synthesize login = _login;
@synthesize servicesFavorite = _servicesFavorite;
@synthesize skype = _skype;
@synthesize linkedin = _linkedin;
@synthesize productsCart = _productsCart;
@synthesize twitter = _twitter;
@synthesize google = _google;
@synthesize campaignsView = _campaignsView;


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
            self.servicesComment = [self objectOrNilForKey:kOGInsightsServicesComment fromDictionary:dict];
            self.productsShare = [self objectOrNilForKey:kOGInsightsProductsShare fromDictionary:dict];
            self.gmail = [self objectOrNilForKey:kOGInsightsGmail fromDictionary:dict];
            self.servicesView = [self objectOrNilForKey:kOGInsightsServicesView fromDictionary:dict];
            self.productsView = [self objectOrNilForKey:kOGInsightsProductsView fromDictionary:dict];
            self.offersView = [self objectOrNilForKey:kOGInsightsOffersView fromDictionary:dict];
            self.hangouts = [self objectOrNilForKey:kOGInsightsHangouts fromDictionary:dict];
            self.messaging = [self objectOrNilForKey:kOGInsightsMessaging fromDictionary:dict];
            self.registerProperty = [self objectOrNilForKey:kOGInsightsRegister fromDictionary:dict];
            self.pinterest = [self objectOrNilForKey:kOGInsightsPinterest fromDictionary:dict];
            self.servicesShare = [self objectOrNilForKey:kOGInsightsServicesShare fromDictionary:dict];
            self.offersComment = [self objectOrNilForKey:kOGInsightsOffersComment fromDictionary:dict];
            self.offersShare = [self objectOrNilForKey:kOGInsightsOffersShare fromDictionary:dict];
            self.offersFavorite = [self objectOrNilForKey:kOGInsightsOffersFavorite fromDictionary:dict];
            self.productsComment = [self objectOrNilForKey:kOGInsightsProductsComment fromDictionary:dict];
            self.productsBuy = [self objectOrNilForKey:kOGInsightsProductsBuy fromDictionary:dict];
            self.instagram = [self objectOrNilForKey:kOGInsightsInstagram fromDictionary:dict];
            self.whatsApp = [self objectOrNilForKey:kOGInsightsWhatsApp fromDictionary:dict];
            self.campaignsShare = [self objectOrNilForKey:kOGInsightsCampaignsShare fromDictionary:dict];
            self.campaignsFavorite = [self objectOrNilForKey:kOGInsightsCampaignsFavorite fromDictionary:dict];
            self.productsFavorite = [self objectOrNilForKey:kOGInsightsProductsFavorite fromDictionary:dict];
            self.campaignsComment = [self objectOrNilForKey:kOGInsightsCampaignsComment fromDictionary:dict];
            self.points = [self objectOrNilForKey:kOGInsightsPoints fromDictionary:dict];
            self.facebook = [self objectOrNilForKey:kOGInsightsFacebook fromDictionary:dict];
            self.login = [self objectOrNilForKey:kOGInsightsLogin fromDictionary:dict];
            self.servicesFavorite = [self objectOrNilForKey:kOGInsightsServicesFavorite fromDictionary:dict];
            self.skype = [self objectOrNilForKey:kOGInsightsSkype fromDictionary:dict];
            self.linkedin = [self objectOrNilForKey:kOGInsightsLinkedin fromDictionary:dict];
            self.productsCart = [self objectOrNilForKey:kOGInsightsProductsCart fromDictionary:dict];
            self.twitter = [self objectOrNilForKey:kOGInsightsTwitter fromDictionary:dict];
            self.google = [self objectOrNilForKey:kOGInsightsGoogle fromDictionary:dict];
            self.campaignsView = [self objectOrNilForKey:kOGInsightsCampaignsView fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.servicesComment forKey:kOGInsightsServicesComment];
    [mutableDict setValue:self.productsShare forKey:kOGInsightsProductsShare];
    [mutableDict setValue:self.gmail forKey:kOGInsightsGmail];
    [mutableDict setValue:self.servicesView forKey:kOGInsightsServicesView];
    [mutableDict setValue:self.productsView forKey:kOGInsightsProductsView];
    [mutableDict setValue:self.offersView forKey:kOGInsightsOffersView];
    [mutableDict setValue:self.hangouts forKey:kOGInsightsHangouts];
    [mutableDict setValue:self.messaging forKey:kOGInsightsMessaging];
    [mutableDict setValue:self.registerProperty forKey:kOGInsightsRegister];
    [mutableDict setValue:self.pinterest forKey:kOGInsightsPinterest];
    [mutableDict setValue:self.servicesShare forKey:kOGInsightsServicesShare];
    [mutableDict setValue:self.offersComment forKey:kOGInsightsOffersComment];
    [mutableDict setValue:self.offersShare forKey:kOGInsightsOffersShare];
    [mutableDict setValue:self.offersFavorite forKey:kOGInsightsOffersFavorite];
    [mutableDict setValue:self.productsComment forKey:kOGInsightsProductsComment];
    [mutableDict setValue:self.productsBuy forKey:kOGInsightsProductsBuy];
    [mutableDict setValue:self.instagram forKey:kOGInsightsInstagram];
    [mutableDict setValue:self.whatsApp forKey:kOGInsightsWhatsApp];
    [mutableDict setValue:self.campaignsShare forKey:kOGInsightsCampaignsShare];
    [mutableDict setValue:self.campaignsFavorite forKey:kOGInsightsCampaignsFavorite];
    [mutableDict setValue:self.productsFavorite forKey:kOGInsightsProductsFavorite];
    [mutableDict setValue:self.campaignsComment forKey:kOGInsightsCampaignsComment];
    [mutableDict setValue:self.points forKey:kOGInsightsPoints];
    [mutableDict setValue:self.facebook forKey:kOGInsightsFacebook];
    [mutableDict setValue:self.login forKey:kOGInsightsLogin];
    [mutableDict setValue:self.servicesFavorite forKey:kOGInsightsServicesFavorite];
    [mutableDict setValue:self.skype forKey:kOGInsightsSkype];
    [mutableDict setValue:self.linkedin forKey:kOGInsightsLinkedin];
    [mutableDict setValue:self.productsCart forKey:kOGInsightsProductsCart];
    [mutableDict setValue:self.twitter forKey:kOGInsightsTwitter];
    [mutableDict setValue:self.google forKey:kOGInsightsGoogle];
    [mutableDict setValue:self.campaignsView forKey:kOGInsightsCampaignsView];

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

    self.servicesComment = [aDecoder decodeObjectForKey:kOGInsightsServicesComment];
    self.productsShare = [aDecoder decodeObjectForKey:kOGInsightsProductsShare];
    self.gmail = [aDecoder decodeObjectForKey:kOGInsightsGmail];
    self.servicesView = [aDecoder decodeObjectForKey:kOGInsightsServicesView];
    self.productsView = [aDecoder decodeObjectForKey:kOGInsightsProductsView];
    self.offersView = [aDecoder decodeObjectForKey:kOGInsightsOffersView];
    self.hangouts = [aDecoder decodeObjectForKey:kOGInsightsHangouts];
    self.messaging = [aDecoder decodeObjectForKey:kOGInsightsMessaging];
    self.registerProperty = [aDecoder decodeObjectForKey:kOGInsightsRegister];
    self.pinterest = [aDecoder decodeObjectForKey:kOGInsightsPinterest];
    self.servicesShare = [aDecoder decodeObjectForKey:kOGInsightsServicesShare];
    self.offersComment = [aDecoder decodeObjectForKey:kOGInsightsOffersComment];
    self.offersShare = [aDecoder decodeObjectForKey:kOGInsightsOffersShare];
    self.offersFavorite = [aDecoder decodeObjectForKey:kOGInsightsOffersFavorite];
    self.productsComment = [aDecoder decodeObjectForKey:kOGInsightsProductsComment];
    self.productsBuy = [aDecoder decodeObjectForKey:kOGInsightsProductsBuy];
    self.instagram = [aDecoder decodeObjectForKey:kOGInsightsInstagram];
    self.whatsApp = [aDecoder decodeObjectForKey:kOGInsightsWhatsApp];
    self.campaignsShare = [aDecoder decodeObjectForKey:kOGInsightsCampaignsShare];
    self.campaignsFavorite = [aDecoder decodeObjectForKey:kOGInsightsCampaignsFavorite];
    self.productsFavorite = [aDecoder decodeObjectForKey:kOGInsightsProductsFavorite];
    self.campaignsComment = [aDecoder decodeObjectForKey:kOGInsightsCampaignsComment];
    self.points = [aDecoder decodeObjectForKey:kOGInsightsPoints];
    self.facebook = [aDecoder decodeObjectForKey:kOGInsightsFacebook];
    self.login = [aDecoder decodeObjectForKey:kOGInsightsLogin];
    self.servicesFavorite = [aDecoder decodeObjectForKey:kOGInsightsServicesFavorite];
    self.skype = [aDecoder decodeObjectForKey:kOGInsightsSkype];
    self.linkedin = [aDecoder decodeObjectForKey:kOGInsightsLinkedin];
    self.productsCart = [aDecoder decodeObjectForKey:kOGInsightsProductsCart];
    self.twitter = [aDecoder decodeObjectForKey:kOGInsightsTwitter];
    self.google = [aDecoder decodeObjectForKey:kOGInsightsGoogle];
    self.campaignsView = [aDecoder decodeObjectForKey:kOGInsightsCampaignsView];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_servicesComment forKey:kOGInsightsServicesComment];
    [aCoder encodeObject:_productsShare forKey:kOGInsightsProductsShare];
    [aCoder encodeObject:_gmail forKey:kOGInsightsGmail];
    [aCoder encodeObject:_servicesView forKey:kOGInsightsServicesView];
    [aCoder encodeObject:_productsView forKey:kOGInsightsProductsView];
    [aCoder encodeObject:_offersView forKey:kOGInsightsOffersView];
    [aCoder encodeObject:_hangouts forKey:kOGInsightsHangouts];
    [aCoder encodeObject:_messaging forKey:kOGInsightsMessaging];
    [aCoder encodeObject:_registerProperty forKey:kOGInsightsRegister];
    [aCoder encodeObject:_pinterest forKey:kOGInsightsPinterest];
    [aCoder encodeObject:_servicesShare forKey:kOGInsightsServicesShare];
    [aCoder encodeObject:_offersComment forKey:kOGInsightsOffersComment];
    [aCoder encodeObject:_offersShare forKey:kOGInsightsOffersShare];
    [aCoder encodeObject:_offersFavorite forKey:kOGInsightsOffersFavorite];
    [aCoder encodeObject:_productsComment forKey:kOGInsightsProductsComment];
    [aCoder encodeObject:_productsBuy forKey:kOGInsightsProductsBuy];
    [aCoder encodeObject:_instagram forKey:kOGInsightsInstagram];
    [aCoder encodeObject:_whatsApp forKey:kOGInsightsWhatsApp];
    [aCoder encodeObject:_campaignsShare forKey:kOGInsightsCampaignsShare];
    [aCoder encodeObject:_campaignsFavorite forKey:kOGInsightsCampaignsFavorite];
    [aCoder encodeObject:_productsFavorite forKey:kOGInsightsProductsFavorite];
    [aCoder encodeObject:_campaignsComment forKey:kOGInsightsCampaignsComment];
    [aCoder encodeObject:_points forKey:kOGInsightsPoints];
    [aCoder encodeObject:_facebook forKey:kOGInsightsFacebook];
    [aCoder encodeObject:_login forKey:kOGInsightsLogin];
    [aCoder encodeObject:_servicesFavorite forKey:kOGInsightsServicesFavorite];
    [aCoder encodeObject:_skype forKey:kOGInsightsSkype];
    [aCoder encodeObject:_linkedin forKey:kOGInsightsLinkedin];
    [aCoder encodeObject:_productsCart forKey:kOGInsightsProductsCart];
    [aCoder encodeObject:_twitter forKey:kOGInsightsTwitter];
    [aCoder encodeObject:_google forKey:kOGInsightsGoogle];
    [aCoder encodeObject:_campaignsView forKey:kOGInsightsCampaignsView];
}

- (id)copyWithZone:(NSZone *)zone
{
    OGInsights *copy = [[OGInsights alloc] init];
    
    if (copy) {

        copy.servicesComment = [self.servicesComment copyWithZone:zone];
        copy.productsShare = [self.productsShare copyWithZone:zone];
        copy.gmail = [self.gmail copyWithZone:zone];
        copy.servicesView = [self.servicesView copyWithZone:zone];
        copy.productsView = [self.productsView copyWithZone:zone];
        copy.offersView = [self.offersView copyWithZone:zone];
        copy.hangouts = [self.hangouts copyWithZone:zone];
        copy.messaging = [self.messaging copyWithZone:zone];
        copy.registerProperty = [self.registerProperty copyWithZone:zone];
        copy.pinterest = [self.pinterest copyWithZone:zone];
        copy.servicesShare = [self.servicesShare copyWithZone:zone];
        copy.offersComment = [self.offersComment copyWithZone:zone];
        copy.offersShare = [self.offersShare copyWithZone:zone];
        copy.offersFavorite = [self.offersFavorite copyWithZone:zone];
        copy.productsComment = [self.productsComment copyWithZone:zone];
        copy.productsBuy = [self.productsBuy copyWithZone:zone];
        copy.instagram = [self.instagram copyWithZone:zone];
        copy.whatsApp = [self.whatsApp copyWithZone:zone];
        copy.campaignsShare = [self.campaignsShare copyWithZone:zone];
        copy.campaignsFavorite = [self.campaignsFavorite copyWithZone:zone];
        copy.productsFavorite = [self.productsFavorite copyWithZone:zone];
        copy.campaignsComment = [self.campaignsComment copyWithZone:zone];
        copy.points = [self.points copyWithZone:zone];
        copy.facebook = [self.facebook copyWithZone:zone];
        copy.login = [self.login copyWithZone:zone];
        copy.servicesFavorite = [self.servicesFavorite copyWithZone:zone];
        copy.skype = [self.skype copyWithZone:zone];
        copy.linkedin = [self.linkedin copyWithZone:zone];
        copy.productsCart = [self.productsCart copyWithZone:zone];
        copy.twitter = [self.twitter copyWithZone:zone];
        copy.google = [self.google copyWithZone:zone];
        copy.campaignsView = [self.campaignsView copyWithZone:zone];
    }
    
    return copy;
}


@end
