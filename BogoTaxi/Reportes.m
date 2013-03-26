//
//  Reportes.m
//  BogoTaxiLite
//
//  Created by Development on 6/02/13.
//  Copyright (c) 2013 iAmStudio. All rights reserved.
//

#import "Reportes.h"


@implementation Reportes

@synthesize comentarios,fecha,tipo,placa;

-(id)leerReporteConDiccionario:(NSDictionary*)diccionario{
    comentarios=[diccionario objectForKey:@"Comentarios"];
    fecha=[diccionario objectForKey:@"Fecha"];
    tipo=[diccionario objectForKey:@"Tipo"];
    placa=[diccionario objectForKey:@"Placa"];
    return self;
}

@end
