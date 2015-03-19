//
//  AppDelegate.m
//  SGTouchPointer
//
//  Created by ParkSanggeon on 19/03/15.
//  Copyright (c) 2015 SG. All rights reserved.
//

#import "AppDelegate.h"
#import "SGTouchPointerWindow.h"

#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[SGTouchPointerWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [ViewController new];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
