//
//  OGWorkSpace.m
//  OnGO
//
//  Created by Hanuman Kachwa on 19/12/15.
//  Copyright © 2015 Aryan Ghassemi. All rights reserved.
//

#import "OGWorkSpace.h"


@implementation OGWorkSpace

+ (OGWorkSpace*)sharedWorkspace
{
    // 1
    static OGWorkSpace *_sharedWorkspace = nil;
    
    // 2
    static dispatch_once_t oncePredicate;
    
    // 3
    dispatch_once(&oncePredicate, ^{
        _sharedWorkspace = [[OGWorkSpace alloc] init];
    });
    return _sharedWorkspace;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _mallId = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"MALL_ID"];
        
        _savedPreferences = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSArray*)getAllWidgetsForWidgetType:(NSString*)widgetType
{
    NSArray *filtered = [self.widgets filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(widgetType == %@)", widgetType]];
    return filtered;
}

@end
