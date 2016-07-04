//
//  OGInsights.h
//
//  Created by Hanuman Kachwa on 19/12/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface OGInsights : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *servicesComment;
@property (nonatomic, strong) NSString *productsShare;
@property (nonatomic, strong) NSString *gmail;
@property (nonatomic, strong) NSString *servicesView;
@property (nonatomic, strong) NSString *productsView;
@property (nonatomic, strong) NSString *offersView;
@property (nonatomic, strong) NSString *hangouts;
@property (nonatomic, strong) NSString *messaging;
@property (nonatomic, strong) NSString *registerProperty;
@property (nonatomic, strong) NSString *pinterest;
@property (nonatomic, strong) NSString *servicesShare;
@property (nonatomic, strong) NSString *offersComment;
@property (nonatomic, strong) NSString *offersShare;
@property (nonatomic, strong) NSString *offersFavorite;
@property (nonatomic, strong) NSString *productsComment;
@property (nonatomic, strong) NSString *productsBuy;
@property (nonatomic, strong) NSString *instagram;
@property (nonatomic, strong) NSString *whatsApp;
@property (nonatomic, strong) NSString *campaignsShare;
@property (nonatomic, strong) NSString *campaignsFavorite;
@property (nonatomic, strong) NSString *productsFavorite;
@property (nonatomic, strong) NSString *campaignsComment;
@property (nonatomic, strong) NSString *points;
@property (nonatomic, strong) NSString *facebook;
@property (nonatomic, strong) NSString *login;
@property (nonatomic, strong) NSString *servicesFavorite;
@property (nonatomic, strong) NSString *skype;
@property (nonatomic, strong) NSString *linkedin;
@property (nonatomic, strong) NSString *productsCart;
@property (nonatomic, strong) NSString *twitter;
@property (nonatomic, strong) NSString *google;
@property (nonatomic, strong) NSString *campaignsView;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
