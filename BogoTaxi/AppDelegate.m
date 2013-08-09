//
//  AppDelegate.m
//  BogoTaxi
//
//  Created by Andres Abril on 22/11/12.
//  Copyright (c) 2013 iAmStudio. All rights reserved.
//

#import "AppDelegate.h"
#import "Flurry.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    [Flurry startSession:@"384XW6P5B2GSZ7MQYC96"];
    FileSaver *file=[[FileSaver alloc]init];
    NSString *ciudad=[file getLastCity];
    NSString *ciudadName=[file getLastNameCity];
    if ([ciudad isEqualToString:@""]||[ciudad isEqualToString:@" "]||ciudad ==nil) {
        [file setLastCity:@"med"];
    }
    if ([ciudadName isEqualToString:@""]||[ciudadName isEqualToString:@" "]||ciudadName ==nil) {
        [file setLastNameCity:@"Medellín"];
    }
    if (![file getDictionary:@"taximetromed"]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"taximetroMedellin" ofType:@"plist"];
        NSMutableDictionary *resultado=[[NSMutableDictionary alloc]initWithContentsOfFile:path];
        [file setDictionary:resultado withKey:@"taximetromed"];
    }
    if (![file getDictionary:@"taximetrocal"]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"taximetroCali" ofType:@"plist"];
        NSMutableDictionary *resultado=[[NSMutableDictionary alloc]initWithContentsOfFile:path];
        [file setDictionary:resultado withKey:@"taximetrocal"];
    }
    if (![file getDictionary:@"taximetrobog"]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"taximetroBogota" ofType:@"plist"];
        NSMutableDictionary *resultado=[[NSMutableDictionary alloc]initWithContentsOfFile:path];
        [file setDictionary:resultado withKey:@"taximetrobog"];
    }
    if (![file getDictionary:@"ciudades"]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Ciudades" ofType:@"plist"];
        NSMutableDictionary *resultado=[[NSMutableDictionary alloc]initWithContentsOfFile:path];
        [file setDictionary:resultado withKey:@"ciudades"];
    }
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    Modelador *mod=[[Modelador alloc]init];
    [mod setBackgroundResponse:0];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    Modelador *mod=[[Modelador alloc]init];
    [mod setBackgroundResponse:1];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
