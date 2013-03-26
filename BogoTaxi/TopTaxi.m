//
//  TopTaxi.m
//  BogoTaxiLite
//
//  Created by Nicolle Jimenez Vasquez on 20/02/13.
//  Copyright (c) 2013 iAmStudio. All rights reserved.
//

#import "TopTaxi.h"

@implementation TopTaxi
@synthesize placa,positivos,negativos;

-(id)leerTopTaxiConDiccionario:(NSDictionary*)diccionario{
    placa=[diccionario objectForKey:@"Placa"];
    negativos=[diccionario objectForKey:@"Negativos"];
    positivos=[diccionario objectForKey:@"Positivos"];
    return self;
}


@end
