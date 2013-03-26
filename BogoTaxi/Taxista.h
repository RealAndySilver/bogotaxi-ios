//
//  Taxista.h
//  BogoTaxiLite
//
//  Created by Development on 7/03/13.
//  Copyright (c) 2013 iAmStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Taxista : NSObject

@property(nonatomic,retain)NSString *nombre;
@property(nonatomic,retain)NSString *twitter;
@property(nonatomic,retain)NSString *asociacion;
@property(nonatomic,retain)NSString *horaInicio;
@property(nonatomic,retain)NSString *horaFin;

-(id)leerTaxistaConDiccionario:(NSDictionary*)diccionario;

@end
