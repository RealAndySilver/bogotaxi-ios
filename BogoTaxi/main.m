//
//  main.m
//  BogoTaxi
//
//  Created by Andres Abril on 22/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
        Method getDistanceFrom = class_getInstanceMethod([CLLocation class], @selector(getDistanceFrom:));
        class_addMethod([CLLocation class], @selector(distanceFromLocation:), method_getImplementation(getDistanceFrom), method_getTypeEncoding(getDistanceFrom));
        //int retVal = UIApplicationMain(argc, argv, nil, nil);
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
