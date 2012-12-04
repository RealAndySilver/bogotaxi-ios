//
//  LLamadasObject.h
//  BogoTaxi
//
//  Created by Andres Abril on 30/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLamadasObject : NSObject
+(NSDictionary *)traerDiccionarioConNumerosDeTaxis;
+(NSDictionary*)traerDiccionarioConNombre:(NSString*)nombre;
@end
