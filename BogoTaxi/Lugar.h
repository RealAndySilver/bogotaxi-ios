//
//  Lugar.h
//  BogoTaxi
//
//  Created by Andres Abril on 6/01/12.
//  Copyright (c) 2012 iAm Studio SAS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Lugar : NSObject<MKAnnotation> {
    NSString *_nombre;
    NSString *_direccion;
    CLLocationCoordinate2D _coordinate;
    MKPinAnnotationColor _pinColor;
}

@property (copy) NSString *nombre;
@property (copy) NSString *direccion;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic) MKPinAnnotationColor pinColor;


- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;

@end