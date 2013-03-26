//
//  TopTaxi.h
//  BogoTaxiLite
//
//  Created by Nicolle Jimenez Vasquez on 20/02/13.
//  Copyright (c) 2013 iAmStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopTaxi : NSObject

@property(nonatomic,retain)NSString *placa;
@property(nonatomic,retain)NSString *positivos;
@property(nonatomic,retain)NSString *negativos;

-(id)leerTopTaxiConDiccionario:(NSDictionary*)diccionario;

@end
