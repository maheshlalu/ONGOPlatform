//
//  OGDataServices.h
//  OnGO
//
//  Created by Hanuman Kachwa on 19/12/15.
//  Copyright © 2015 Aryan Ghassemi. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>


@interface OGDataServices : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
