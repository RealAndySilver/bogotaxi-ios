//
//  Taxista.m
//  BogoTaxiLite
//
//  Created by Development on 7/03/13.
//  Copyright (c) 2013 iAmStudio. All rights reserved.
//

#import "Taxista.h"

@implementation Taxista
@synthesize nombre,twitter,asociacion,horaInicio,horaFin;

-(id)leerTaxistaConDiccionario:(NSDictionary*)diccionario{
    nombre=[diccionario objectForKey:@"Nombre"];
    twitter=[diccionario objectForKey:@"Twitter"];
    asociacion=[diccionario objectForKey:@"Asociacion"];
    horaInicio=[diccionario objectForKey:@"HoraInicio"];
    horaFin=[diccionario objectForKey:@"HoraFin"];
    return self;
}

@end
