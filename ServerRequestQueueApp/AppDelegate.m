//
//  AppDelegate.m
//  ServerRequestQueueApp
//
//  Created by Scott Hasbrouck on 1/13/15.
//  Copyright (c) 2015 Scott Hasbrouck. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // add a test request, these should be saved for the subsquent launches of the app
    //sample server request
    ServerRequest *singleSampleRequest = [[ServerRequest alloc] init];
    singleSampleRequest.tag = @"sample";
    
    singleSampleRequest.postData = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"Sarah", @"fname",
                                    @"Jane", @"lname",
                                    @"59857355", @"fb_id",
                                    nil];
    
    
    //enqueue the first sample request
    [[NSMutableArray sharedQueue] enqueue:singleSampleRequest];
    
    //note about how I tested this
    NSLog(@"Everytime the app is opened, a new request is added to the queue.\nThus, the request count will increment by 1 on every launch");
    NSLog(@"----------------------");
    NSLog(@"Request count: %lu", [[NSMutableArray sharedQueue] queueSize]);
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    //  save the queue here
    NSLog([NSMutableArray saveQueueState] ? @"Saved state" : @"Failed to save state");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    //  save the queue here
    NSLog([NSMutableArray saveQueueState] ? @"Saved state" : @"Failed to save state");
}

@end
