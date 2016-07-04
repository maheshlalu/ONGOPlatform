
//
//  LeftViewController.m
//  OnGO
//
//  Created by CreativeXpert pvt Ltd. on 4/24/13.
//  Copyright (c) 2013 CreativeXpert. All rights reserved.
//

#import "LeftViewController.h"
#import "SlideNavigationContorllerAnimatorSlide.h"
#import "ProductSubcategoryViewController.h"
#import "OnGoDB.h"
#import "DataServices.h"
#import "OnGoCommonConstants.h"
#import "OnGoDownloadManager.h"
#import "CCKFNavDrawer.h"
#import "ProductsListViewController.h"
#import "DealsListViewController.h"
#import "CXWebViewController.h"
#import "JSONKit.h"
#import "CXAlbumGalleryViewController.h"
#import "CXCustomTabListViewController.h"
#import "ServiceTabViewController.h"
#import "GroupServiceListViewController.h"

@interface LeftViewController ()
@property(nonatomic,strong) NSMutableArray* widgets;
@property(nonatomic, strong) NSMutableArray* allowedNativeWidgets;
@property (weak, nonatomic) IBOutlet UILabel *homeMenuTitle;

@end


@implementation CXWidgetItem

@end

@implementation LeftViewController
@synthesize tblCollapesAndExpand;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [OGWorkSpace sharedWorkspace].leftViewController = self;
    
    self.allowedNativeWidgets = [NSMutableArray arrayWithObjects:@"Products", @"Services", @"Notifications", @"Gallery", @"Venue",nil];
    self.widgets = [[NSMutableArray alloc] init];
    
    CXWidgetItem* widgetItem = [CXWidgetItem new];
    widgetItem.Name = self.allowedNativeWidgets[0];
    widgetItem.Display_Name = self.allowedNativeWidgets[0];
    widgetItem.Visibility = @"No";
    widgetItem.Widget_Type = @"native";
   // [self.widgets addObject:widgetItem];
    
    self.homeMenuTitle.text = @"Latest";
    
    widgetItem = [CXWidgetItem new];
    widgetItem.Name = self.allowedNativeWidgets[1];
    widgetItem.Display_Name = self.allowedNativeWidgets[1];
    widgetItem.Visibility = @"No";
    widgetItem.Widget_Type = @"native";
    [self.widgets addObject:widgetItem];

    widgetItem = [CXWidgetItem new];
    widgetItem.Name = self.allowedNativeWidgets[2];
    widgetItem.Display_Name = self.allowedNativeWidgets[2];
    widgetItem.Visibility = @"No";
    //widgetItem.Widget_Type = @"native";
    //widgetItem.childItems = [[NSMutableArray alloc]initWithObjects:@"General Offers",@"Special Offers",@"Special Deals", nil];
   // [self.widgets addObject:widgetItem];

    widgetItem = [CXWidgetItem new];
    widgetItem.Name = self.allowedNativeWidgets[3];
    widgetItem.Display_Name = self.allowedNativeWidgets[3];
    widgetItem.Visibility = @"No";
    widgetItem.Widget_Type = @"native";

    [self.widgets addObject:widgetItem];

    widgetItem = [CXWidgetItem new];
    widgetItem.Name = self.allowedNativeWidgets[4];
    widgetItem.Display_Name = self.allowedNativeWidgets[4];
    widgetItem.Visibility = @"No";
    widgetItem.Widget_Type = @"native";
    
//    [self.widgets addObject:widgetItem];
    
//    widgetItem = [CXWidgetItem new];
//    widgetItem.Name = self.allowedNativeWidgets[5];
//    widgetItem.Display_Name = self.allowedNativeWidgets[5];
//    widgetItem.Visibility = @"No";
//    widgetItem.Widget_Type = @"native";
//    
//    [self.widgets addObject:widgetItem];
    
    widgetItem = [CXWidgetItem new];
    widgetItem.Name = @"Programs";
    widgetItem.Display_Name = @"Programs";
    widgetItem.Visibility = @"No";
    widgetItem.Widget_Type = @"native";
    
    
//    [self.widgets addObject:widgetItem];
    
    widgetItem = [CXWidgetItem new];
    widgetItem.Name = @"Speakers";
    widgetItem.Display_Name = @"Speakers";
    widgetItem.Visibility = @"No";
    widgetItem.Widget_Type = @"native";
    
//    [self.widgets addObject:widgetItem];
    
    
    self.tblCollapesAndExpand.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    
    [[DataServices serviceInstance] getAllProductsCategoriesForMallId:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"MALL_ID"] finishBlock:^(NSArray* products)
     {
         for(CXWidgetItem* widget in self.widgets)
         {
             if(1)
             {
                 NSMutableArray* childItems = [NSMutableArray new];
                 for(OnGoProductCategories* category in products)
                 {
                    // [childItems addObject:category.Name];
                     CXWidgetItem*  widgetItem = [CXWidgetItem new];
                     widgetItem.Name = category.Name;
                     widgetItem.Display_Name = category.Name;
                     widgetItem.Visibility = @"No";
                     widgetItem.Widget_Type = @"url";
                     

                     [self.widgets addObject:widgetItem];

                 }
                 widget.childItems = childItems;
                 break;
             }
         }
         
     }];
    
    [[DataServices serviceInstance] getAllServiceCategories:^(NSArray* services)
     {
         for(CXWidgetItem* widget in self.widgets)
         {
             if([widget.Name isEqualToString:@"Services"])
             {
                 NSMutableArray* childItems = [NSMutableArray new];
                 NSMutableDictionary *serviceInfoDict = nil;
                 for(OnGoServiceCategories* category in services)
                 {
                     if([category.IsSpecialService boolValue] && ([category.GroupName length] <= 0)) // of type special service only
                     {
                         BOOL exists = NO;
                         for(NSMutableDictionary *dict in childItems)
                         {
                             if([dict objectForKey:@"IsSpecialServiceOnly"])
                             {
                                 exists = YES;
                                 NSMutableArray *list = dict[@"grouplist"];
                                 if(!list)
                                 {
                                     list = [NSMutableArray new];
                                 }
                                 [list addObject:category];
                                 dict[@"grouplist"] = list;
                             }
                         }
                         
                         if(!exists)
                         {
                             NSMutableDictionary *dict = [NSMutableDictionary new];
                             dict[@"GroupName"] = @"General services";
                             dict[@"IsSpecialServiceOnly"] = @"true";
                             NSMutableArray *list = [NSMutableArray new];
                             [list addObject:category];
                             dict[@"grouplist"] = list;
                             [childItems addObject:dict];
                         }
                         
                     }
                     else if([category.IsSpecialService boolValue] && ([category.GroupName length] > 0))// of type special service and with group name
                     {
                         BOOL exists = NO;
                         for(NSMutableDictionary *dict in childItems)
                         {
                             if([dict objectForKey:@"SpecialServiceOnlyAndGroup"] && [[dict objectForKey:@"GroupName"] isEqualToString:category.GroupName])
                             {
                                 exists = YES;
                                 NSMutableArray *list = dict[@"grouplist"];
                                 if(!list)
                                 {
                                     list = [NSMutableArray new];
                                 }
                                 [list addObject:category];
                                 dict[@"grouplist"] = list;
                             }
                         }
                         
                         if(!exists)
                         {
                             NSMutableDictionary *dict = [NSMutableDictionary new];
                             dict[@"SpecialServiceOnlyAndGroup"] = @"true";
                             dict[@"GroupName"] = category.GroupName;
                             NSMutableArray *list = [NSMutableArray new];
                             [list addObject:category];
                             dict[@"grouplist"] = list;
                             [childItems addObject:dict];
                         }

                     }
                     else if(![category.IsSpecialService boolValue] && ([category.GroupName length] > 0))// only with group name
                     {
                         BOOL exists = NO;
                         for(NSMutableDictionary *dict in childItems)
                         {
                             if(![dict objectForKey:@"SpecialServiceOnlyAndGroup"] && ![dict objectForKey:@"IsSpecialServiceOnly"] && [[dict objectForKey:@"GroupName"] isEqualToString:category.GroupName])
                             {
                                 exists = YES;
                                 NSMutableArray *list = dict[@"grouplist"];
                                 if(!list)
                                 {
                                     list = [NSMutableArray new];
                                 }
                                 [list addObject:category];
                                 dict[@"grouplist"] = list;
                             }
                         }
                         
                         if(!exists)
                         {
                             NSMutableDictionary *dict = [NSMutableDictionary new];
                             dict[@"GroupName"] = category.GroupName;
                             NSMutableArray *list = [NSMutableArray new];
                             [list addObject:category];
                             dict[@"grouplist"] = list;
                             [childItems addObject:dict];
                         }

                     }
                     else
                     {
                         NSMutableDictionary *dict = [NSMutableDictionary new];
                         dict[@"GroupName"] = category.Name;
                         dict[@"category"] = category;
                         [childItems addObject:dict];
                     }
                 }
                 widget.childItems = childItems;
                 break;
             }
         }
         
     }];

     for(OGWidgets* widget in [OGWorkSpace sharedWorkspace].widgets)
     {
         BOOL exists = NO;
         for(CXWidgetItem* widget in self.widgets)
         {
             if([widget.Name isEqualToString:widget.Name])
             {
                 if(![widget.Visibility boolValue])// if visibility is false
                 {
                     [self.widgets removeObject:widget];
                 }
                 else
                 {
                     widget.Visibility = @"Yes";
                     widget.Display_Name = widget.Display_Name;
                 }
                 exists = YES;
                 break;
             }
         }
         if(!exists)
         {
             if([widget.visibility boolValue])
             {
                 if([widget.widgetType isEqualToString:@"Custom Tab"])
                 {
                     CXWidgetItem* widgetItem = [CXWidgetItem new];
                     widgetItem.Name = widget.name;
                     widgetItem.Display_Name = widget.displayName;
                     widgetItem.Visibility = widget.visibility;
                     widgetItem.Widget_Type = widget.widgetType;
                     [self.widgets addObject:widgetItem];
                 }
             }
             
         }

     }
     
    //Sorting the data
     NSSortDescriptor *sortDescriptor;
     sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Display_Name"
                                                  ascending:YES];
     NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
     self.widgets = [NSMutableArray arrayWithArray:[self.widgets sortedArrayUsingDescriptors:sortDescriptors]];
     [self.tblCollapesAndExpand reloadData];
    
    
   if(!expandedSections)
    {
        expandedSections = [[NSMutableIndexSet alloc] init];
     }
    
}

#pragma mark - UITableView Delegate & Datasrouce -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return 37;
    }
    else
    {
        return 50;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.widgets.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfChildsInSection:(NSInteger)section
{
    return [self.widgets[section] childItems].count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([expandedSections containsIndex:section])
    {
        return [self.widgets[section] childItems].count+1;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
    UILabel* label = nil;
    if(indexPath.row == 0)
    {
        static NSString *CellIdentifier = @"SectionCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        label = (UILabel*)[cell viewWithTag:1];
        
        UIView* topSeparatorLineView = (UIView*)[cell viewWithTag:2];

        if(indexPath.section == 0)
        {
            topSeparatorLineView.hidden = NO;
        }
        else
        {
            topSeparatorLineView.hidden = YES;
        }
    }
    else
    {
        static NSString *CellIdentifier = @"RowCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        label = (UILabel*)[cell viewWithTag:1];
    }
    
    if(indexPath.row == 0)
    {
        label.text = [self.widgets[indexPath.section] Display_Name];
        [label setFont:[UIFont selectingCellLableFont]];

    }
    else
    {
        CXWidgetItem* item = self.widgets[indexPath.section];
        
        if([item.childItems[indexPath.row-1] isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *dict = item.childItems[indexPath.row-1];
            label.text = dict[@"GroupName"];
        }
        else
        {
            label.text = item.childItems[indexPath.row-1];
            [label setFont:[UIFont selectingCellSubCategoryLabelFont]];

        }
    }
    
    return cell;
}

//Printing description of URLString:
//Services/getMasters?type=Share Worthy&unlimited=false&mallId=3169


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CXWidgetItem* item = self.widgets[indexPath.section];

    if (_delegate && [_delegate respondsToSelector:(@selector(leftMenuViewDidSelectMenuItem:))]) {
        [_delegate leftMenuViewDidSelectMenuItem:item];
    }

    if(indexPath.row == 0)
    {
        //remove previous selected section's rows
        NSInteger previousSection = [expandedSections firstIndex];
        if(previousSection != NSNotFound)
        {
            NSInteger rowCount = [self tableView:tableView numberOfChildsInSection:previousSection];
            NSMutableArray* indexArray = [NSMutableArray array];
            for(int index = 1; index <= rowCount; ++index)
            {
                NSIndexPath* indPath = [NSIndexPath indexPathForRow:index inSection:previousSection];
                [indexArray addObject:indPath];
            }
            [expandedSections removeAllIndexes];

            [tableView deleteRowsAtIndexPaths:indexArray
                             withRowAnimation:UITableViewRowAnimationBottom];
        }
        if(previousSection != indexPath.section)
        {
            NSInteger rowCount = [self tableView:tableView numberOfChildsInSection:indexPath.section];
            NSMutableArray* indexArray = [NSMutableArray array];
            for(int index = 1; index <= rowCount; ++index)
            {
                NSIndexPath* indPath = [NSIndexPath indexPathForRow:index inSection:indexPath.section];
                [indexArray addObject:indPath];
            }

            [expandedSections addIndex:indexPath.section];
            [tableView insertRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationTop];
        }
        
        
        if(item.childItems.count == 0)
        {
            //Speakers //Programs
            [self.navController drawerToggle];

            if([item.Name isEqualToString:@"Gallery"])
            {
                CXAlbumGalleryViewController* cxAlbumGalleryViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CXAlbumGalleryViewController"];
                cxAlbumGalleryViewController.attachmentList = _selectedStore.attachments;
                [self.navController pushViewController:cxAlbumGalleryViewController animated:YES];

            }
            else if([item.Widget_Type isEqualToString:@"Custom Tab"])
            {
                CXCustomTabListViewController* cxCustomTabListViewController = [[CXCustomTabListViewController alloc]initWithNibName:nil bundle:[NSBundle mainBundle]];
                //[storyBoard instantiateViewControllerWithIdentifier:@"CXCustomTabListViewController"];
                cxCustomTabListViewController.customTabName = item.Name;
                cxCustomTabListViewController.navController = self.navController;
                [self.navController pushViewController:cxCustomTabListViewController animated:YES];
            }else if ([item.Name isEqualToString:@"Speakers"]){
                ProductsListViewController* productListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductsListViewController"];
                productListViewController.productName = item.Name;
                [self.navController pushViewController:productListViewController animated:YES];
            }else if ([item.Name isEqualToString:@"Register Now"]){
                //Go to Register page
                CXSocialWebViewController* webViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CXSocialWebViewController"];
                webViewController.navController = (CCKFNavDrawer*)self.navigationController;
                webViewController.leftBarTitle = @"Register Now";
                webViewController.urlString = @"http://gonat.in/delegateregister.php";

                [self.navController pushViewController:webViewController animated:YES];

                
            }else if ([item.Name isEqualToString:@"Venue"]){
                MapViewController* mapVc = (MapViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
               // mapVc.storeName = self.storeData.Name;
                [self.navController pushViewController:mapVc animated:YES];
                
               /* double longitude = [[[self.storeData.json objectFromJSONString] objectForKey:@"Longitude"] doubleValue];
                double latitude = [[[self.storeData.json objectFromJSONString] objectForKey:@"Latitude"] doubleValue];
                
                CLLocationCoordinate2D regionCenter;
                regionCenter.longitude = longitude;
                regionCenter.latitude = latitude;
                mapVc.regionCenter = regionCenter;*/
                
                
                //Load the Venu map
            }else if ([item.Name isEqualToString:@"Programs"]){
                
                CXCalenderVc*calenderVc  = [[CXCalenderVc alloc]initWithNibName:nil bundle:[NSBundle mainBundle]];
              calenderVc.view.backgroundColor = [UIColor colorWithRed:204.0f/255 green:204.0f/255 blue:204.0f/255 alpha:1.0f];
                calenderVc.navController = (CCKFNavDrawer*)self.navigationController;
                [self.navController pushViewController:calenderVc animated:YES];

            }

        }
    }
    else
    {
        [self.navController drawerToggle];
        
        NSString* selectedChildItem = nil;
        if([item.childItems[indexPath.row-1] isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *dict = item.childItems[indexPath.row-1];
            selectedChildItem = dict[@"GroupName"];
        }
        else
        {
            selectedChildItem = item.childItems[indexPath.row-1];
        }

        if([[self.widgets[indexPath.section] Name] isEqualToString:@"Offers"])
        {
            DealsListViewController* dealsListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DealsListViewController"];
            dealsListViewController.offerType = selectedChildItem;
            [self.navController pushViewController:dealsListViewController animated:YES];
        }
        else if([[self.widgets[indexPath.section] Name] isEqualToString:@"Products"])
        {
            ProductsListViewController* productListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductsListViewController"];
            productListViewController.productName = selectedChildItem;
            [self.navController pushViewController:productListViewController animated:YES];
        }
        else if([[self.widgets[indexPath.section] Name] isEqualToString:@"Services"])
        {
            ServiceTabViewController* serviceTabViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ServiceTabViewController"];
            
            NSDictionary *dict = item.childItems[indexPath.row-1];
            if(dict[@"category"])
            {
                serviceTabViewController.leftNavigationBarItemTitle = selectedChildItem;
                serviceTabViewController.serviceName = selectedChildItem;
                serviceTabViewController.serviceDesc = [dict[@"category"] Description];
                [self.navController pushViewController:serviceTabViewController animated:YES];
            }
            else
            {
                GroupServiceListViewController *groupServiceListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"GroupServiceListViewController"];
                groupServiceListViewController.groupedServiceInfoDict = dict;
                groupServiceListViewController.productName = selectedChildItem;
                [self.navController pushViewController:groupServiceListViewController animated:YES];
            }
            
        }


    }
    
}


-(void)viewWillAppear:(BOOL)animated
{
    
}

-(IBAction)homeMenuTapped:(id)sender
{
    [self.navController drawerToggle];
    
    CXWidgetItem* item = self.widgets.firstObject;
    
    if (_delegate && [_delegate respondsToSelector:(@selector(leftMenuViewDidSelectMenuItem:))]) {
        [_delegate leftMenuViewDidSelectMenuItem:item];
    }

}



@end