//
//  Reportes.h
//  BogoTaxiLite
//
//  Created by Development on 6/02/13.
//  Copyright (c) 2013 iAmStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerCommunicator.h"

@interface Reportes : NSObject

@property(nonatomic,retain)NSString *comentarios;
@property(nonatomic,retain)NSString *fecha;
@property(nonatomic,retain)NSString *tipo;
@property(nonatomic,retain)NSString *placa;

-(id)leerReporteConDiccionario:(NSDictionary*)diccionario;

@end
