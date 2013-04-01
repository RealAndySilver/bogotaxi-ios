//
//  TaximetroObject.h
//  BogoTaxi
//
//  Created by Andres Abril on 30/12/11.
//  Copyright (c) 2011 iAm Studio SAS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Modelador.h"
//@class TaximetroObject;
@interface TaximetroObject : NSObject{
    NSString * ciudad;
    int unidadesDeArranque;
    int unidadesCarreraMinima;
    int metrosParaCambio;
    int costoUnidad;
    int carreraMinima;
    int segundosDeEspera;
    
    float costoArranque;
    
    float costoUnidadFloat;
    float carreraMinimaFloat;
    
    int valorAeropuerto;
    float valorAeropuertoFloat;
    int valorpuertaApuerta;
    float valorpuertaApuertaFloat;
    int valorTerminal;
    float valorTerminalFloat;
    int valorNocDomFes;
    float valorNocDomFesFloat;
    
    double numeroDeEmergenciasLocal;
    
    BOOL aeropuertoAnula;
    BOOL medicionEnPrecio;
    BOOL decimales;
}
@property (nonatomic, retain)NSString*ciudad;
@property (nonatomic)int unidadesDeArranque;
@property (nonatomic)int metrosParaCambio;
@property (nonatomic)int costoUnidad;
@property (nonatomic)int carreraMinima;
@property (nonatomic)int unidadesCarreraMinima;
@property (nonatomic)int segundosDeEspera;

@property (nonatomic)float costoArranque;


@property (nonatomic)float costoUnidadFloat;
@property (nonatomic)float carreraMinimaFloat;

@property (nonatomic)int valorAeropuerto;
@property (nonatomic)float valorAeropuertoFloat;
@property (nonatomic)int valorpuertaApuerta;
@property (nonatomic)float valorpuertaApuertaFloat;
@property (nonatomic)int valorTerminal;
@property (nonatomic)float valorTerminalFloat;
@property (nonatomic)int valorNocDomFes;
@property (nonatomic)float valorNocDomFesFloat;

@property (nonatomic)BOOL aeropuertoAnula;
@property (nonatomic)BOOL medicionEnPrecio;
@property (nonatomic)BOOL decimales;

@property (nonatomic)double numeroDeEmergenciasLocal;





-(void)inicializarConValores:(NSString*)laCiudad 
       unidadesCarreraMinima:(int)undCarrMin 
            unidadesArranque:(int)unidades 
                metrosCambio:(int)metros 
               costoDeUnidad:(int)costo 
                  carreraMin:(int)minima 
            segundosDeEspera:(int)segEspera 
             aeropuertoAnula:(BOOL)aeroAnula 
            medicionEnPrecio:(BOOL)esPrecio;

-(void)inicializarConValoresFloat:(NSString*)laCiudad 
            unidadesCarreraMinima:(int)undCarrMin 
                 unidadesArranque:(int)unidades 
                     metrosCambio:(int)metros 
                    costoDeUnidad:(float)costo 
                       carreraMin:(float)minima 
                 segundosDeEspera:(int)segEspera 
                  aeropuertoAnula:(BOOL)aeroAnula 
                 medicionEnPrecio:(BOOL)esPrecio;

-(void)valoresAdicionalesNocturno:(int)nocturno 
                          llamada:(int)llamada 
                       aeropuerto:(int)aeropuerto 
                         terminal:(int)terminal;

-(void)valoresAdicionalesNocturnoFloat:(float)nocturno 
                               llamada:(float)llamada 
                            aeropuerto:(float)aeropuerto 
                              terminal:(float)terminal;
-(void)resetToCero;
-(void)crearTaximetroConCiudad:(NSString*)laCiudad;

@end
