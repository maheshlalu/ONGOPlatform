//
//  OGNextJobStatuses.m
//
//  Created by Hanuman Kachwa on 19/12/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "OGNextJobStatuses.h"


NSString *const kOGNextJobStatusesStatusId = @"Status_Id";
NSString *const kOGNextJobStatusesSeqNo = @"SeqNo";
NSString *const kOGNextJobStatusesSubJobtypeForms = @"Sub_Jobtype_Forms";
NSString *const kOGNextJobStatusesStatusName = @"Status_Name";


@interface OGNextJobStatuses ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OGNextJobStatuses

@synthesize statusId = _statusId;
@synthesize seqNo = _seqNo;
@synthesize subJobtypeForms = _subJobtypeForms;
@synthesize statusName = _statusName;


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
            self.statusId = [self objectOrNilForKey:kOGNextJobStatusesStatusId fromDictionary:dict];
            self.seqNo = [self objectOrNilForKey:kOGNextJobStatusesSeqNo fromDictionary:dict];
            self.subJobtypeForms = [self objectOrNilForKey:kOGNextJobStatusesSubJobtypeForms fromDictionary:dict];
            self.statusName = [self objectOrNilForKey:kOGNextJobStatusesStatusName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.statusId forKey:kOGNextJobStatusesStatusId];
    [mutableDict setValue:self.seqNo forKey:kOGNextJobStatusesSeqNo];
    NSMutableArray *tempArrayForSubJobtypeForms = [NSMutableArray array];
    for (NSObject *subArrayObject in self.subJobtypeForms) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSubJobtypeForms addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSubJobtypeForms addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSubJobtypeForms] forKey:kOGNextJobStatusesSubJobtypeForms];
    [mutableDict setValue:self.statusName forKey:kOGNextJobStatusesStatusName];

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

    self.statusId = [aDecoder decodeObjectForKey:kOGNextJobStatusesStatusId];
    self.seqNo = [aDecoder decodeObjectForKey:kOGNextJobStatusesSeqNo];
    self.subJobtypeForms = [aDecoder decodeObjectForKey:kOGNextJobStatusesSubJobtypeForms];
    self.statusName = [aDecoder decodeObjectForKey:kOGNextJobStatusesStatusName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_statusId forKey:kOGNextJobStatusesStatusId];
    [aCoder encodeObject:_seqNo forKey:kOGNextJobStatusesSeqNo];
    [aCoder encodeObject:_subJobtypeForms forKey:kOGNextJobStatusesSubJobtypeForms];
    [aCoder encodeObject:_statusName forKey:kOGNextJobStatusesStatusName];
}

- (id)copyWithZone:(NSZone *)zone
{
    OGNextJobStatuses *copy = [[OGNextJobStatuses alloc] init];
    
    if (copy) {

        copy.statusId = [self.statusId copyWithZone:zone];
        copy.seqNo = [self.seqNo copyWithZone:zone];
        copy.subJobtypeForms = [self.subJobtypeForms copyWithZone:zone];
        copy.statusName = [self.statusName copyWithZone:zone];
    }
    
    return copy;
}


@end
