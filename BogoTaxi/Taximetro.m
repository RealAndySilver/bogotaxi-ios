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
@end
