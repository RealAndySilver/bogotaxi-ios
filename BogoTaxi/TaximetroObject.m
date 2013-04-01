//
//  TaximetroObject.m
//  BogoTaxi
//
//  Created by Andres Abril on 30/12/11.
//  Copyright (c) 2011 iAm Studio SAS. All rights reserved.
//

#import "TaximetroObject.h"

@implementation TaximetroObject
@synthesize ciudad,unidadesDeArranque,metrosParaCambio,carreraMinima,costoUnidad,unidadesCarreraMinima,segundosDeEspera,costoUnidadFloat, carreraMinimaFloat,costoArranque;
@synthesize valorTerminal,valorTerminalFloat,valorNocDomFes,valorNocDomFesFloat,valorAeropuerto,valorAeropuertoFloat,valorpuertaApuerta,valorpuertaApuertaFloat;
@synthesize aeropuertoAnula,medicionEnPrecio,decimales,numeroDeEmergenciasLocal;

-(id)init{
    if ((self=[super init])) {
    ciudad=@"";
    unidadesDeArranque=0;
    metrosParaCambio=0;
    costoUnidad=0;
    carreraMinima=0;
    unidadesCarreraMinima=0;
    }
    return self;
}

-(void)inicializarConValores:(NSString*)laCiudad 
       unidadesCarreraMinima:(int)undCarrMin 
            unidadesArranque:(int)unidades 
                metrosCambio:(int)metros 
               costoDeUnidad:(int)costo 
                  carreraMin:(int)minima
            segundosDeEspera:(int)segEspera
             aeropuertoAnula:(BOOL)aeroAnula
            medicionEnPrecio:(BOOL)esPrecio{
    
    ciudad=laCiudad;
    unidadesCarreraMinima=undCarrMin;
    unidadesDeArranque=unidades;
    metrosParaCambio=metros;
    costoUnidad=costo;
    carreraMinima=minima;
    segundosDeEspera=segEspera;
    aeropuertoAnula=aeroAnula;
    medicionEnPrecio=esPrecio;
    costoArranque=0;
}

-(void)inicializarConValoresFloat:(NSString*)laCiudad 
       unidadesCarreraMinima:(int)undCarrMin 
            unidadesArranque:(int)unidades 
                metrosCambio:(int)metros 
               costoDeUnidad:(float)costo 
                  carreraMin:(float)minima
            segundosDeEspera:(int)segEspera
             aeropuertoAnula:(BOOL)aeroAnula
            medicionEnPrecio:(BOOL)esPrecio{
    
    ciudad=laCiudad;
    unidadesCarreraMinima=undCarrMin;
    unidadesDeArranque=unidades;
    metrosParaCambio=metros;
    costoUnidadFloat=costo;
    carreraMinimaFloat=minima;
    segundosDeEspera=segEspera;
    aeropuertoAnula=aeroAnula;
    medicionEnPrecio=esPrecio;
    costoArranque=0;
}
-(void)valoresAdicionalesNocturno:(int)nocturno 
                          llamada:(int)llamada 
                       aeropuerto:(int)aeropuerto 
                         terminal:(int)terminal{
    valorNocDomFes=nocturno;
    valorpuertaApuerta=llamada;
    valorAeropuerto=aeropuerto;
    valorTerminal=terminal;
}

-(void)valoresAdicionalesNocturnoFloat:(float)nocturno 
                          llamada:(float)llamada 
                       aeropuerto:(float)aeropuerto 
                         terminal:(float)terminal{
    valorNocDomFesFloat=nocturno;
    valorpuertaApuertaFloat=llamada;
    valorAeropuertoFloat=aeropuerto;
    valorTerminalFloat=terminal;
}
-(void)resetToCero{
    ciudad=0;
    unidadesCarreraMinima=0;
    unidadesDeArranque=0;
    metrosParaCambio=0;
    costoUnidadFloat=0;
    carreraMinimaFloat=0;
    segundosDeEspera=0;
    aeropuertoAnula=0;
    medicionEnPrecio=0;
    valorNocDomFes=0;
    valorpuertaApuerta=0;
    valorAeropuerto=0;
    valorTerminal=0;
    valorNocDomFesFloat=0;
    valorpuertaApuertaFloat=0;
    valorAeropuertoFloat=0;
    valorTerminalFloat=0;
    
    medicionEnPrecio=NO;
    aeropuertoAnula=NO;
    decimales=NO;    
}
-(void)crearTaximetroConCiudad:(NSString *)laCiudad{
    Modelador *obj=[[Modelador alloc]init];

    if ([laCiudad isEqualToString:@" "]||laCiudad ==nil||[laCiudad isEqualToString:@""]||laCiudad ==NULL) {
        [obj setCiudad:laCiudad];
        [obj release];
    }
    if ([laCiudad isEqualToString:@"Bogota"]||[laCiudad isEqualToString:@"Bogota "]) {
        
        [self inicializarConValores:@"Bogota" 
                   unidadesCarreraMinima:50 
                        unidadesArranque:25 
                            metrosCambio:100 
                           costoDeUnidad:70
                              carreraMin:3500
                        segundosDeEspera:30
                         aeropuertoAnula:NO
                        medicionEnPrecio:NO];
        [self setDecimales:NO];
        [self valoresAdicionalesNocturno:1700
                                      llamada:600 
                                   aeropuerto:3500
                                     terminal:500];
        numeroDeEmergenciasLocal=123;
    }
    if ([laCiudad isEqualToString:@"Medellin"]||[laCiudad isEqualToString:@"Medellin "]) {
        
        [self inicializarConValores:@"Medellin" 
                   unidadesCarreraMinima:56 
                        unidadesArranque:33 
                            metrosCambio:78 
                           costoDeUnidad:79 
                              carreraMin:4400
                        segundosDeEspera:60
                         aeropuertoAnula:YES
                        medicionEnPrecio:YES];
        [self setDecimales:NO];
        [self setCostoArranque:2600];
        [self valoresAdicionalesNocturno:0 
                                 llamada:0 
                              aeropuerto:57000 
                                terminal:0];
        numeroDeEmergenciasLocal=123;
    }
    if ([laCiudad isEqualToString:@"Cali"]||[laCiudad isEqualToString:@"Cali "]) {
        ciudad = @"Cali";
        
        [self inicializarConValores:@"Cali" 
                   unidadesCarreraMinima:45 
                        unidadesArranque:18 
                            metrosCambio:70 
                           costoDeUnidad:60 
                              carreraMin:2700
                        segundosDeEspera:5
                         aeropuertoAnula:NO
                        medicionEnPrecio:YES];
        [self setDecimales:NO];
        [self setCostoArranque:1100];
        [self valoresAdicionalesNocturno:0 
                                      llamada:1000 
                                   aeropuerto:54000 
                                     terminal:200];
        numeroDeEmergenciasLocal=123;
    }
    if ([laCiudad isEqualToString:@"Buenos Aires"]||[laCiudad isEqualToString:@"Buenos Aires "]) {
        
        [self inicializarConValoresFloat:@"Buenos Aires" 
                        unidadesCarreraMinima:10 
                             unidadesArranque:10 
                                 metrosCambio:200 
                                costoDeUnidad:0.58
                                   carreraMin:5.80
                             segundosDeEspera:5
                              aeropuertoAnula:NO
                             medicionEnPrecio:YES];
        [self setDecimales:YES];
        [self setCostoUnidad:self.costoUnidadFloat];
        
        [self valoresAdicionalesNocturnoFloat:0.0001
                                           llamada:0.2 
                                        aeropuerto:0.9 
                                          terminal:0.5];
    }
}
@end
