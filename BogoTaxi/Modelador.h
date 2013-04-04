//
//  Modelador.h
//  BogoTaxi
//
//  Created by Andrés Abril on 26/09/11.
//  Copyright (c) 2011 iAm Studio SAS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Taximetro.h"
@class Taximetro;
@interface Modelador : NSObject{ 
    NSDictionary *datos;
    NSDictionary *datosConf;
    NSDictionary *datosEstadistica; 
    NSDictionary *datosCompras; 

    NSDictionary *tableDataSource; 
    Taximetro *taximetro;

}
-(BOOL)onShake;
-(void)onShakeSwitch;
-(void)mensajeConInput:(NSString *)panicMessage;
-(NSString *)obtenerMensajeDePanico;
-(BOOL)guardarConf;
-(BOOL)guardarEst;
-(BOOL)guardarCompras;
-(void)ciudadConNombre:(NSString *)ciudad;
-(void)redSocialConNombre:(NSString *)servicio;
-(NSString*)obtenerNombreDeCiudad;
-(NSString*)obtenerNombreDeRedSocial;
-(void)alertSwitch;
-(BOOL)getAlertSwitchValue;
-(void)firstTimeSwitch;
-(void)firstTimeSecondSwitch;
-(int)getTutorialReady;
-(void)setTutorialReady;
-(int)firstTimeSecond;
-(BOOL)getBackgroundResponse;
-(void)setBackgroundResponse:(int)background;
-(NSString*)getNumeroSMS;
-(void)setNumeroSMS:(double)numero;
-(NSString*)getMail;
-(void)setMail:(NSString*)mail;
-(void)setCiudad:(NSString*)ciudad;
-(NSString*)getCiudad;
-(BOOL)getComprasConID:(int)ID;
-(void)setComprasConID:(int)ID;

#pragma mark llamada de emergencia
-(NSString*)getNumeroEmergencia;
-(void)setNumeroEmergencia:(double)numero;
-(NSString*)getNumero123;
-(void)setNumero123:(double)numero;

#pragma mark estadistica show
-(float)getKm;
-(void)setKm:(float)km;
-(int)getViajes;
-(void)setViajes:(int)viajes;
-(float)getCantidadTaxis;
-(void)setCantidadTaxis:(float)cantidadTaxis;
-(float)getMinutosTaxi;
-(void)setMinutosTaxi:(float)minTaxi;
-(void)resetEstadistica;


#pragma mark ClassMethods
+(float)medidorDeMetrosRecorridos:(NSMutableArray*)puntos;
+(int)conversorMetrosAUnidades:(float)totalMetros paraLaCiudad:(NSString*)ciudad;
//+(int)conversorSegundosAUnidades:(int)tiempoquieto :(int)cantidadADividir;
+(int)unidadesADinero:(int)unidades paraLaCiudad:(NSString*)ciudad;
+(int)unidadesAPesos:(int)unidades;

//+(int)conversorMetrosAUnidades:(float)totalMetros paraElTaximetro:(Taximetro*)objeto;
+(int)unidadesADinero:(int)unidades paraElTaximetro:(Taximetro*)objeto;
+(float)unidadesADineroFloat:(int)unidades paraElTaximetro:(Taximetro *)objeto;

#pragma mark compras in app
-(int)getPackPurchaseWithID:(int)ID;
-(void)setPackPurchaseWithID:(int)ID;


@property (readonly) BOOL onShake;
@property (readonly) BOOL guardarConf;
@property (readonly) BOOL firstTime;



@end
