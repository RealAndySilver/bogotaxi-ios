//
//  Taximetro.m
//  BogoTaxi
//
//  Created by Andres Abril on 27/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "Taximetro.h"

@implementation Taximetro
@synthesize costoUnidad,unidadesCarreraMinima,costoAero,costoNoc,costoPuerta,costoTerm;

-(float)unidadesADinero:(int)unidades{
    if (unidades<unidadesCarreraMinima) {
        float res1=self.costoUnidad*unidadesCarreraMinima;
        float res =100*floor((res1/100)+0.5);
        return res;
    }
    float res1=self.costoUnidad*unidades;
    float res =100*floor((res1/100)+0.5);
    return res;
}
-(id)initWithCiudad:(NSString*)ciudad{
    if (self=[super init]) {
        [self iniciarConCiudad:ciudad];
    }
    return self;
}
-(void)iniciarConCiudad:(NSString*)ciudad{
    if ([ciudad isEqualToString:@"bogota"]) {
        costoUnidad=68;
        unidadesCarreraMinima=50;
        costoAero=3400;
        costoNoc=1600;
        costoTerm=500;
        costoPuerta=600;
    }
}
+(float)medidorDeMetrosRecorridos:(NSMutableArray*)puntos{
    float suma=0;
    float value=0;
    for (int i = 0; i < [puntos count]; i++) {
        value = [[puntos objectAtIndex: i] floatValue];
		suma = suma + value;
	}
    return suma;
}
@end
