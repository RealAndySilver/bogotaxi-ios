//
//  Ciudad.m
//  MedeTaxi
//
//  Created by Development on 31/07/13.
//  Copyright (c) 2013 iAmStudio. All rights reserved.
//

#import "Ciudad.h"

@implementation Ciudad
@synthesize nombre,acr;

-(id)leerCiudadConDiccionario:(NSDictionary*)diccionario{
    nombre=[diccionario objectForKey:@"Nombre"];
    acr=[diccionario objectForKey:@"Acr"];
    return self;
}


@end
