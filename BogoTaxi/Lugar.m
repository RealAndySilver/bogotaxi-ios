//
//  Lugar.m
//  BogoTaxi
//
//  Created by Andres Abril on 6/01/12.
//  Copyright (c) 2012 iAm Studio SAS. All rights reserved.
//

#import "Lugar.h"

@implementation Lugar
@synthesize nombre = _nombre;
@synthesize direccion = _direccion;
@synthesize coordinate = _coordinate;
@synthesize pinColor = _pinColor;

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [super init])) {
        _nombre = [name copy];
        _direccion = [address copy];
        _coordinate = coordinate;
    }
    return self;
}

- (NSString *)title {
    return _nombre;
}

- (NSString *)subtitle {
    return _direccion;
}

- (void)dealloc
{
    [_nombre release];
    _nombre = nil;
    [_direccion release];
    _direccion = nil;    
    [super dealloc];
}

@end