//
//  LLamadasObject.m
//  BogoTaxi
//
//  Created by Andres Abril on 30/11/12.
//  Copyright (c) 2013 iAmStudio. All rights reserved.
//

#import "LLamadasObject.h"

@implementation LLamadasObject
+(NSMutableDictionary*)diccionarioConRutaDefinida{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TelefonosTaxis" ofType:@"plist"];
    NSMutableDictionary*resultado=[[NSMutableDictionary alloc]initWithContentsOfFile:path];
    return resultado;
}
+(NSDictionary *)traerDiccionarioConNumerosDeTaxis{
    NSDictionary *diccionario=[self diccionarioConRutaDefinida];
    return diccionario;
}
+(NSDictionary*)traerDiccionarioConNombre:(NSString*)nombre{
    NSDictionary *diccionario=[self diccionarioConRutaDefinida];
    NSDictionary *temp=[diccionario objectForKey:nombre];
    NSLog(@"Diccionario con nombre %@ %@",nombre,temp);
    return temp;
}
@end
