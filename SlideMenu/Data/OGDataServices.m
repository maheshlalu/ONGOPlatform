//
//  OGDataServices.m
//  OnGO
//
//  Created by Hanuman Kachwa on 19/12/15.
//  Copyright © 2015 Aryan Ghassemi. All rights reserved.
//

#import "OGDataServices.h"

static NSString * const OGDataServicesAPIBaseURLString = @"http://storeongo.com:8081/";

@implementation OGDataServices

+ (instancetype)sharedClient {
    static OGDataServices *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[OGDataServices alloc] initWithBaseURL:[NSURL URLWithString:OGDataServicesAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}

@end
