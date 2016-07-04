//
//  LocationList.m
//  OnGO
//
//  Created by Mentor Insight India pvt Ltd on 15/04/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "LocationList.h"
#import "JSONKit.h"

@interface LocationList()
@property(strong,nonatomic) NSArray* resultsStoreList;
@property(strong,nonatomic) NSArray* sortedList;
@property(strong,nonatomic) CLLocationManager* locationManager;

@end

@implementation LocationList

-(void)viewDidLoad
{
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    
    self.resultsStoreList = self.storeList;
    [self.tblList reloadData];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation*   location = [self.locationManager location];
    for(OnGoStores* store in self.storeList)
    {
        double longitude = [[[store.json objectFromJSONString] objectForKey:@"Longitude"] doubleValue];
        double latitude = [[[store.json objectFromJSONString] objectForKey:@"Latitude"] doubleValue];
        CLLocation* storeLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
        CLLocationDistance distance = [location distanceFromLocation:storeLocation];
        store.storeDistance = [NSNumber numberWithDouble:distance];
    }
    self.storeList = [self.storeList sortedArrayUsingComparator:^(OnGoStores* store1, OnGoStores* store2)
                      {
                          return [store1.storeDistance compare:store2.storeDistance];
                      }];
    
    self.resultsStoreList = self.storeList;
    
    [self.tblList reloadData];

}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.resultsStoreList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"LocationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UILabel* label = (UILabel*)[cell viewWithTag:1];
    NSString *str = [[self.resultsStoreList objectAtIndex:indexPath.row]Name];
    label.text = str;
    
    UILabel* storeDistancelabel = (UILabel*)[cell viewWithTag:2];
    storeDistancelabel.text = [NSString stringWithFormat:@"%.1lf KM",[[[self.resultsStoreList objectAtIndex:indexPath.row] storeDistance] doubleValue]/1000];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OnGoStores* selectedStore = [self.resultsStoreList objectAtIndexedSubscript:indexPath.row];
    
    for(OnGoStores* store in self.resultsStoreList)
    {
        if([store.Name isEqualToString:selectedStore.Name])
        {
            [self.delegate locationList:self didSelectStore:selectedStore];
            break;
        }
    }
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;   // called when text changes (including clear)
{
    if(searchText.length == 0)
    {
        self.resultsStoreList = self.storeList;
    }
    else
    {
        NSMutableArray* newList = [NSMutableArray new];
        for(OnGoStores* store in self.storeList)
        {
            NSRange range = [store.Name rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(range.location != NSNotFound)
            {
                [newList addObject:store];
            }
        }
        self.resultsStoreList = newList;
    }

    [self.tblList reloadData];
}

-(void)backButtonTapped
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(NSString*)leftNavigationBarItemTitle
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"PRODUCT_NAME"];
}

//-(UIBarButtonItem*)leftNavigationBarItem
//{
//    SEL selector =  @selector(leftBarTapped);
//    
//    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 43)];
//    //customView.backgroundColor = [UIColor redColor];
//    
//    UIButton* menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 13, 24, 24)];
//    [menuButton setImage:[UIImage imageNamed:@"ic_actionbar_leftslide"] forState:UIControlStateNormal];
//    [menuButton addTarget:self
//                   action:selector forControlEvents:UIControlEventTouchDown];
//    [customView addSubview:menuButton];
//    
//    UIImageView* iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 4, 35, 35)];
//    iconImageView.image = [UIImage imageNamed:@"icon"];
//    [customView addSubview:iconImageView];
//    
//    
//   UILabel* titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(67, 15, 200, 20)];
//    titleLabel.text = @"Celkon Mobiles";
//    [customView addSubview:titleLabel];
//    
//    
//    return [[UIBarButtonItem alloc]initWithCustomView:customView];
//    
//}

@end
