//
//  Annotation.h
//  CryptoChat
//
//  Created by Nicolle on 25/09/12.
//  Copyright (c) 2012 iAmStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>
#import <MapKit/MapKit.h>

@interface Annotation : NSObject<MKAnnotation> {
    
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
    
}

@property(nonatomic, assign) CLLocationCoordinate2D coordinate;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *subtitle;

@end
