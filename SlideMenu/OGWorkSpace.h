//
//  OGWorkSpace.h
//  OnGO
//
//  Created by Hanuman Kachwa on 19/12/15.
//  Copyright © 2015 Aryan Ghassemi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LeftViewController.h"

#define kPageSize 18

#define ODISHA_NEWS_FAV_KEY @"ODISHA_NEWS_FAV_KEY"

@interface OGWorkSpace : NSObject

@property (nonatomic, strong) NSString *mallId;


@property (nonatomic, strong) NSMutableDictionary *savedPreferences;

@property (nonatomic, strong) NSArray* widgets; // widget type Vs list
@property (nonatomic, strong) OGMallInfo* mallInfo;
@property (nonatomic, strong) OGOrgs* orgInfo;
@property (nonatomic, strong) LeftViewController* leftViewController;

+ (OGWorkSpace*)sharedWorkspace;

- (NSArray*)getAllWidgetsForWidgetType:(NSString*)widgetType;

@end
