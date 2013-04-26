//
//  Taximetro.m
//  BogoTaxi
//
//  Created by Andres Abril on 27/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "Taximetro.h"

#define METROSBOGOTA 100
#define UNIDADBOGOTA 67
#define METROSMEDELLIN 78
#define UNIDADMEDELLIN 77

@implementation Taximetro
@synthesize costoUnidad,unidadesCarreraMinima,costoAero,costoNoc,costoPuerta,costoTerm,segundosDeEspera,unidadesDeArranque,metrosParaCambio, medicionEnPrecio,costoArranque,costoUnidadFloat,carreraMinimaFloat, numeroDeEmergenciasLocal;


-(id)leerTaxistaConDiccionario:(NSDictionary*)diccionario{
    costoUnidad=[[diccionario objectForKey:@"CostoUnidad"]floatValue];
    unidadesCarreraMinima=[[diccionario objectForKey:@"UnidadesCarreraMinima"]floatValue];
    unidadesDeArranque=[[diccionario objectForKey:@"UnidadesDeArranque"]floatValue];
    costoAero=[[diccionario objectForKey:@"CostoAero"]floatValue];
    costoNoc=[[diccionario objectForKey:@"CostoNoc"]floatValue];
    costoTerm=[[diccionario objectForKey:@"CostoTerm"]floatValue];
    costoPuerta=[[diccionario objectForKey:@"CostoPuerta"]floatValue];
    segundosDeEspera=[[diccionario objectForKey:@"SegundosDeEspera"]floatValue];
    metrosParaCambio=[[diccionario objectForKey:@"MetrosParaCambio"]floatValue];
    costoUnidad=[[diccionario objectForKey:@"CostoUnidad"]floatValue];
    carreraMinimaFloat=[[diccionario objectForKey:@"CarreraMinima"]floatValue];
    numeroDeEmergenciasLocal=[[diccionario objectForKey:@"NumeroDeEmergenciasLocal"]floatValue];
    return self;
}
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
        unidadesDeArranque=25;
        costoAero=3400;
        costoNoc=1600;
        costoTerm=500;
        costoPuerta=600;
        segundosDeEspera=30;
        metrosParaCambio=100;
        costoUnidad=70;
        carreraMinimaFloat=3500;

        medicionEnPrecio=NO;
        numeroDeEmergenciasLocal=123;
    }
}
-(void)resetToCero{
    //ciudad=0;
    unidadesCarreraMinima=0;
    unidadesDeArranque=0;
    metrosParaCambio=0;
    costoUnidadFloat=0;
    carreraMinimaFloat=0;
    segundosDeEspera=0;
    medicionEnPrecio=0;
    costoAero=0;
    costoNoc=0;
    costoTerm=0;
    costoPuerta=0;
    
    medicionEnPrecio=NO;
    //decimales=NO;
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
+(int)conversorSegundosAUnidades:(int)tiempoquieto :(int)cantidadADividir{
    //Pilas, a veces sale división por 0
    int unidadesTiempoEspera = tiempoquieto/cantidadADividir;
    return unidadesTiempoEspera;
}
+(int)conversorMetrosAUnidades:(float)totalMetros paraElTaximetro:(Taximetro*)objeto{
    int unidades = totalMetros/objeto.metrosParaCambio;
    return unidades+objeto.unidadesDeArranque;
}


@end
