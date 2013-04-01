//
//  Taximetro.h
//  BogoTaxi
//
//  Created by Andres Abril on 27/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Taximetro : NSObject

@property (nonatomic)int unidadesDeArranque;
@property (nonatomic)int metrosParaCambio;
@property (nonatomic)int carreraMinima;
@property (nonatomic)float costoArranque;
@property (nonatomic)float costoUnidadFloat;
@property (nonatomic)float carreraMinimaFloat;
@property (nonatomic)BOOL aeropuertoAnula;
@property (nonatomic)BOOL medicionEnPrecio;
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
@end
