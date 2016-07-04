//
//  OGWidgets.m
//
//  Created by Hanuman Kachwa on 19/12/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "OGWidgets.h"


NSString *const kOGWidgetsVisibility = @"Visibility";
NSString *const kOGWidgetsWidgetType = @"Widget_Type";
NSString *const kOGWidgetsHighlighted = @"Highlighted";
NSString *const kOGWidgetsEnabledReviews = @"enabledReviews";
NSString *const kOGWidgetsDisplayName = @"Display_Name";
NSString *const kOGWidgetsName = @"Name";
NSString *const kOGWidgetsSubCategories = @"subCategories";
NSString *const kOGWidgetsEnabledUserAddition = @"enabledUserAddition";


@interface OGWidgets ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OGWidgets

@synthesize visibility = _visibility;
@synthesize widgetType = _widgetType;
@synthesize highlighted = _highlighted;
@synthesize enabledReviews = _enabledReviews;
@synthesize displayName = _displayName;
@synthesize name = _name;
@synthesize subCategories = _subCategories;
@synthesize enabledUserAddition = _enabledUserAddition;


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
            self.visibility = [self objectOrNilForKey:kOGWidgetsVisibility fromDictionary:dict];
            self.widgetType = [self objectOrNilForKey:kOGWidgetsWidgetType fromDictionary:dict];
            self.highlighted = [self objectOrNilForKey:kOGWidgetsHighlighted fromDictionary:dict];
            self.enabledReviews = [self objectOrNilForKey:kOGWidgetsEnabledReviews fromDictionary:dict];
            self.displayName = [self objectOrNilForKey:kOGWidgetsDisplayName fromDictionary:dict];
            self.name = [self objectOrNilForKey:kOGWidgetsName fromDictionary:dict];
            self.subCategories = [self objectOrNilForKey:kOGWidgetsSubCategories fromDictionary:dict];
            self.enabledUserAddition = [self objectOrNilForKey:kOGWidgetsEnabledUserAddition fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.visibility forKey:kOGWidgetsVisibility];
    [mutableDict setValue:self.widgetType forKey:kOGWidgetsWidgetType];
    [mutableDict setValue:self.highlighted forKey:kOGWidgetsHighlighted];
    [mutableDict setValue:self.enabledReviews forKey:kOGWidgetsEnabledReviews];
    [mutableDict setValue:self.displayName forKey:kOGWidgetsDisplayName];
    [mutableDict setValue:self.name forKey:kOGWidgetsName];
    NSMutableArray *tempArrayForSubCategories = [NSMutableArray array];
    for (NSObject *subArrayObject in self.subCategories) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSubCategories addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSubCategories addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSubCategories] forKey:kOGWidgetsSubCategories];
    [mutableDict setValue:self.enabledUserAddition forKey:kOGWidgetsEnabledUserAddition];

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

    self.visibility = [aDecoder decodeObjectForKey:kOGWidgetsVisibility];
    self.widgetType = [aDecoder decodeObjectForKey:kOGWidgetsWidgetType];
    self.highlighted = [aDecoder decodeObjectForKey:kOGWidgetsHighlighted];
    self.enabledReviews = [aDecoder decodeObjectForKey:kOGWidgetsEnabledReviews];
    self.displayName = [aDecoder decodeObjectForKey:kOGWidgetsDisplayName];
    self.name = [aDecoder decodeObjectForKey:kOGWidgetsName];
    self.subCategories = [aDecoder decodeObjectForKey:kOGWidgetsSubCategories];
    self.enabledUserAddition = [aDecoder decodeObjectForKey:kOGWidgetsEnabledUserAddition];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_visibility forKey:kOGWidgetsVisibility];
    [aCoder encodeObject:_widgetType forKey:kOGWidgetsWidgetType];
    [aCoder encodeObject:_highlighted forKey:kOGWidgetsHighlighted];
    [aCoder encodeObject:_enabledReviews forKey:kOGWidgetsEnabledReviews];
    [aCoder encodeObject:_displayName forKey:kOGWidgetsDisplayName];
    [aCoder encodeObject:_name forKey:kOGWidgetsName];
    [aCoder encodeObject:_subCategories forKey:kOGWidgetsSubCategories];
    [aCoder encodeObject:_enabledUserAddition forKey:kOGWidgetsEnabledUserAddition];
}

- (id)copyWithZone:(NSZone *)zone
{
    OGWidgets *copy = [[OGWidgets alloc] init];
    
    if (copy) {

        copy.visibility = [self.visibility copyWithZone:zone];
        copy.widgetType = [self.widgetType copyWithZone:zone];
        copy.highlighted = [self.highlighted copyWithZone:zone];
        copy.enabledReviews = [self.enabledReviews copyWithZone:zone];
        copy.displayName = [self.displayName copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.subCategories = [self.subCategories copyWithZone:zone];
        copy.enabledUserAddition = [self.enabledUserAddition copyWithZone:zone];
    }
    
    return copy;
}


@end
