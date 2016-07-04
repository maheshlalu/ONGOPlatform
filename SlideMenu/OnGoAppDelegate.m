//
//  AppDelegate.m
//  OnGO
//
//  Created by CreativeXpert pvt Ltd. on 4/24/13.
//  Copyright (c) 2013 CreativeXpert. All rights reserved.
//

#import "OnGoAppDelegate.h"
#import "DataServices.h"
#import "CCKFNavDrawer.h"
#import <sys/utsname.h>
#import "CXKeyPageViewController.h"
#import "MBProgressHUD.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "StoreOnGoViewController.h"
#import "OGOdishaSHKConfigurator.h"

@interface OnGoAppDelegate()
@end
@implementation OnGoAppDelegate

NSString* machineName()
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    return [NSString stringWithCString:systemInfo.machine
                              encoding:NSUTF8StringEncoding];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];

    [[DataServices serviceInstance] registerForPushNotification:token block:nil];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Failed to register for remote notifications: %@", [error description]);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"notification dict:%@",userInfo);
    
    NSDictionary *infoDict = userInfo[@"aps"];
    NSString *title = infoDict[@"alert"];
    NSString *description = infoDict[@"KEYS"];
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:[[NSBundle mainBundle].infoDictionary objectForKey:@"UIMainStoryboardFile"]
                                                         bundle:[NSBundle mainBundle]];

    CXKeyPageViewController* viewController = [storyBoard instantiateViewControllerWithIdentifier:@"CXKeyPageViewController"];
    viewController.pageIndex = 0;
    viewController.keyData = @{@"keyName":title, @"comment":description};

    [self.navController pushViewController:viewController animated:YES];
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [self application:application didReceiveRemoteNotification:userInfo];
    
}

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSDictionary *remoteNotificationDict = launchOptions[@"UIApplicationLaunchOptionsRemoteNotificationKey"];
    if(remoteNotificationDict)
    {
        [self application:[UIApplication sharedApplication] didReceiveRemoteNotification:remoteNotificationDict];
    }
    return YES;
}

//public static Map<String, String> uploadFileFromAndroidToServerHelper(File srcFile,String refFileName){
//    
//    Map<String, String> fileInfo=new HashMap<String, String>();
//    
//    refFileName = StringUtils.isNotBlank(refFileName) ? refFileName : UUID.randomUUID()+"";
//    
//    if(srcFile != null && StringUtils.isNotBlank(refFileName)){
//        
//        String fileStorageLocation = Play.configuration
//        .getProperty("file.storage.location");
//        
//        String path = "/android/uploads";
//        
//        new File(fileStorageLocation + path).mkdirs();
//        
//        if(srcFile.exists()){
//            
//            String fileName = srcFile.getName();
//            int mid = fileName.lastIndexOf(".");
//            String ext = fileName.substring(mid, fileName.length());
//            
//            path +="/"+refFileName+""+ext;
//            
//            File destFile=new File(fileStorageLocation+path);
//            
//            try {
//                FileUtils.copyFile(srcFile, destFile);
//                if(destFile.exists()){
//                    fileInfo.put("status", 1+"");
//                    String filepath = play.Play.configuration.getProperty("content.base.url")+ "/coin/files" + path;
//                    fileInfo.put("filePath", filepath);
//                }
//                else{
//                    fileInfo.put("status", "0");
//                }
//            } catch (IOException e) {
//                e.printStackTrace();
//            }
//        }
//        else{
//            fileInfo.put("status", "0");
//            fileInfo.put("response", "File not found");
//        }
//    }
//    else{
//        fileInfo.put("status", "0");
//        fileInfo.put("response", "File is empty/File and File name is required"); 
//    }
//    return fileInfo;
//}




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];

    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];

    // register for remote notifications
    if ([[[[NSBundle mainBundle] infoDictionary] objectForKey:@"IS_PUSH_NOTIFICATION_ENABLED"] boolValue]) {
        if ([application respondsToSelector:@selector(registerUserNotificationSettings:)])
        {
            UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound);
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
            [application registerUserNotificationSettings:settings];
            [application registerForRemoteNotifications];
        }
        else
        {
            [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
        }
    }

    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:[[NSBundle mainBundle].infoDictionary objectForKey:@"UIMainStoryboardFile"] bundle:[NSBundle mainBundle]];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

#if STOREONGO
    self.navController = [mainStoryboard instantiateViewControllerWithIdentifier: @"StoreOnGoNav"];

#elif ODNEWS360
    DefaultSHKConfigurator *configurator = [[OGOdishaSHKConfigurator alloc] init];
    [SHKConfiguration sharedInstanceWithConfigurator:configurator];
    self.navController = [mainStoryboard instantiateViewControllerWithIdentifier: @"ODNEWS360Nav"];
#else
    self.navController = [mainStoryboard instantiateViewControllerWithIdentifier: @"CCKFNavDrawer"];

#endif
    
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];

    
//    MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:self.window animated:true];
//    progress.labelText = @"Fetching data..";

    //[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loggedinUserDetails"];
   
//    [[DataServices serviceInstance] getAllProductsOfType:@"SMART PHONE" mallId:@"199" block:^(NSArray* allProductList){
//        
//        //NSLog(@"allProductList:%@",allProductList);
//    }];
//
//
//    [[DataServices serviceInstance]getAllOffersOfType:@"General Offers" mallId:@"134" block:^(NSArray* offersList){
//        
//        NSLog(@"offersList:%@",offersList);
//    }];


//         UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
//															 bundle: nil];
	
//        LeftViewController *leftMenu = (LeftViewController*)[mainStoryboard
//														   instantiateViewControllerWithIdentifier: @"LeftViewController"];
//	    [SlideNavigationController sharedInstance].leftMenu = leftMenu;
    

    
	// Creating a custom bar button for right menu
//    UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 12, 22)];
//    [button setImage:[UIImage imageNamed:@"menu-button.png"] forState:UIControlStateNormal];
//    [button addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//    [SlideNavigationController sharedInstance].leftBarButtonItem = leftBarButtonItem;
    
    // Override point for customization after application launch.
    return YES;
}
    
    // Override point for customization after application launch.
                        
- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loggedinUserDetails"];
    
    
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
