//
//  Taximetro.h
//  BogoTaxi
//
//  Created by Andres Abril on 27/11/12.
//  Copyright (c) 2013 iAmStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerCommunicator.h"
#import "FileSaver.h"
@interface Taximetro : NSObject

@property(nonatomic)NSString *version;
@property (nonatomic)int unidadesDeArranque;
@property (nonatomic)int metrosParaCambio;
@property (nonatomic)int carreraMinima;
@property (nonatomic)float costoArranque;
@property (nonatomic)float costoUnidadFloat;
@property (nonatomic)float carreraMinimaFloat;
@property (nonatomic)BOOL medicionEnPrecio;
@property (nonatomic)BOOL aeropuertoAnula;
@property (nonatomic)double numeroDeEmergenciasLocal;

@property(nonatomic)float costoUnidad;
@property(nonatomic)float unidadesCarreraMinima;

@property (nonatomic)int segundosDeEspera;

@property(nonatomic)float costoNoc;
@property(nonatomic)float costoAero;
@property(nonatomic)float costoPuerta;
@property(nonatomic)float costoTerm;


-(float)unidadesADinero:(int)unidades;
-(id)initWithCiudad:(NSString*)ciudad;
+(float)medidorDeMetrosRecorridos:(NSMutableArray*)puntos;
-(void)resetToCero;
+(int)conversorSegundosAUnidades:(int)tiempoquieto :(int)cantidadADividir;
+(int)conversorMetrosAUnidades:(float)totalMetros paraElTaximetro:(Taximetro*)objeto;
@end
