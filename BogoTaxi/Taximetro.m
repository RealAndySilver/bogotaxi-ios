//
//  Taximetro.m
//  BogoTaxi
//
//  Created by Andres Abril on 27/11/12.
//  Copyright (c) 2013 iAmStudio. All rights reserved.
//

#import "Taximetro.h"

#define METROSBOGOTA 100
#define UNIDADBOGOTA 67
#define METROSMEDELLIN 78
#define UNIDADMEDELLIN 79

@implementation Taximetro
@synthesize costoUnidad,unidadesCarreraMinima,costoAero,costoNoc,costoPuerta,costoTerm,segundosDeEspera,unidadesDeArranque,metrosParaCambio, medicionEnPrecio,costoArranque,costoUnidadFloat,carreraMinimaFloat, numeroDeEmergenciasLocal, version, aeropuertoAnula;


-(float)unidadesADinero:(int)unidades{
    if (medicionEnPrecio==0) {
        if (unidades<unidadesCarreraMinima) {
            float res1=self.costoUnidad*unidadesCarreraMinima;
            float res =100*floor((res1/100)+0.5);
            return res;
        }
        float res1=self.costoUnidad*unidades;
        float res =100*floor((res1/100)+0.5);
        return res;
    }
    else{
        if (unidades<unidadesDeArranque) {
            return costoArranque;
        }
        else{
            float res1=costoUnidad*unidades;
            float res =100*floor((res1/100)+0.5);
            int res3=res;
            return res3;
        }
    }
}

-(id)initWithCiudad:(NSString*)ciudad{
    if (self=[super init]) {
        [self iniciarConCiudad:ciudad];
    }
    return self;
}

-(void)iniciarConCiudad:(NSString*)ciudad{
    FileSaver *file=[[FileSaver alloc]init];
    if ([ciudad isEqualToString:[file getLastCity]]) {
        NSString *nameDictionary=[[NSString alloc]initWithString:[NSString stringWithFormat:@"taximetro%@",ciudad]];
        [self resetearTaximetroConDiccionario:[file getDictionary:nameDictionary]];
    }
}
-(void)resetearTaximetroConDiccionario:(NSDictionary*)taximetro{
    version=[taximetro objectForKey:@"version"];
    unidadesCarreraMinima=[[taximetro objectForKey:@"unidadesCarreraMinima"]intValue];
    unidadesDeArranque=[[taximetro objectForKey:@"unidadesDeArranque"]intValue];
    costoAero=[[taximetro objectForKey:@"costoAero"]floatValue];
    costoNoc=[[taximetro objectForKey:@"costoNoc"]floatValue];
    costoTerm=[[taximetro objectForKey:@"costoTerm"]floatValue];
    costoPuerta=[[taximetro objectForKey:@"costoPuerta"]floatValue];
    segundosDeEspera=[[taximetro objectForKey:@"segundosDeEspera"]floatValue];
    metrosParaCambio=[[taximetro objectForKey:@"metrosParaCambio"]floatValue];
    costoUnidad=[[taximetro objectForKey:@"costoUnidad"]floatValue];
    carreraMinimaFloat=[[taximetro objectForKey:@"carreraMinima"]floatValue];
    costoArranque=[[taximetro objectForKey:@"costoArranque"]floatValue];
    medicionEnPrecio=[[taximetro objectForKey:@"medicionEnPrecio"]boolValue];
    aeropuertoAnula=[[taximetro objectForKey:@"aeropuertoAnula"]boolValue];
    numeroDeEmergenciasLocal=[[taximetro objectForKey:@"numeroDeEmergenciasLocal"]floatValue];
    NSLog(@"Taximetro Dic: %@",taximetro);
}
-(void)resetToCero{
    //ciudad=0;
    unidadesCarreraMinima=0;
    unidadesDeArranque=0;
    metrosParaCambio=0;
    costoUnidadFloat=0;
    carreraMinimaFloat=0;
    costoArranque=0;
    segundosDeEspera=0;
    medicionEnPrecio=0;
    costoAero=0;
    costoNoc=0;
    costoTerm=0;
    costoPuerta=0;
    medicionEnPrecio=NO;
    aeropuertoAnula=NO;
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
    if (totalMetros>10) {
        int unidades = totalMetros/objeto.metrosParaCambio;
        return unidades+objeto.unidadesDeArranque;
    }
    else{
        int unidades = objeto.unidadesDeArranque;
        return unidades;
    }
    
}

@end
