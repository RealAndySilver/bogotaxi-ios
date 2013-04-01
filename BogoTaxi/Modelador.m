//
//  Modelador.m
//  BogoTaxi
//
//  Created by Andrés Abril on 26/09/11.
//  Copyright (c) 2011 iAm Studio SAS. All rights reserved.
//

#import "Modelador.h"
#define DATAFILENAMET @"opciones.plist"
#define DATAFILENAMEE @"estadisticas.plist"
#define TAXIMETROSCOMPRADOS @"compras.plist"


#define DATAFILENAMECOUNTERS @"contadores.plist"
#define METROSBOGOTA 100
#define UNIDADBOGOTA 67
#define METROSMEDELLIN 78
#define UNIDADMEDELLIN 77




@implementation Modelador
@synthesize onShake, firstTime;

-(id) init{
	if ((self = [super init])) {
        NSArray *pathsC = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *PathC = [pathsC objectAtIndex:0];
		
		//NSString *Path = [[NSBundle mainBundle] bundlePath];
		NSString *DataPathC = [PathC stringByAppendingPathComponent:DATAFILENAMET];
		NSDictionary *tempDictC = [[NSDictionary alloc] initWithContentsOfFile:DataPathC];
        
        //Estadísticas path
        NSArray *pathsB = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *PathB = [pathsB objectAtIndex:0];
		NSString *DataPathB = [PathB stringByAppendingPathComponent:DATAFILENAMEE];
		NSDictionary *tempDictB = [[NSDictionary alloc] initWithContentsOfFile:DataPathB];
        
        //Compras path
        NSArray *pathsD = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *PathD = [pathsD objectAtIndex:0];
		NSString *DataPathD = [PathD stringByAppendingPathComponent:TAXIMETROSCOMPRADOS];
		NSDictionary *tempDictD = [[NSDictionary alloc] initWithContentsOfFile:DataPathD];
		
        if (!tempDictC) {
			tempDictC = [[NSDictionary alloc] init];
		}
        if (!tempDictB) {
            tempDictB = [[NSDictionary alloc] init];
        }
        if (!tempDictD) {
            tempDictD = [[NSDictionary alloc] init];
        }
        datosConf = tempDictC;
        datosEstadistica = tempDictB;
        datosCompras = tempDictD;
	}
# warning habia un log
    //NSLog(@"DatosEst %@",datosEstadistica);
    
	return self;
}
-(BOOL)onShake{
	return [[datosConf objectForKey:@"onShake"] boolValue];
}
-(void) onShakeSwitch {
	int shake = [[datosConf objectForKey:@"onShake"] intValue];
	if (shake != 0) {
		shake = 0;
	}
	else {
		shake = 1;
	}
	NSMutableDictionary *newData = [datosConf mutableCopy];
	[newData setObject:[NSNumber numberWithInt:shake] forKey:@"onShake"];
	datosConf = newData;
	[self guardarConf];  
}
-(BOOL)getAlertSwitchValue{
    return [[datosConf objectForKey:@"AlertSwitch2"] boolValue];
}
-(void) alertSwitch {
	int alertSwitch = [[datosConf objectForKey:@"AlertSwitch2"] intValue];
	if (alertSwitch != 0) {
		alertSwitch = 0;
	}
	else {
		alertSwitch = 1;
	}
	NSMutableDictionary *newData = [datosConf mutableCopy];
	[newData setObject:[NSNumber numberWithInt:alertSwitch] forKey:@"AlertSwitch2"];
	datosConf = newData;
	[self guardarConf];  
}
-(BOOL)getBackgroundResponse{
    return [[datosConf objectForKey:@"backgroundShake"] boolValue];
}
-(void)setBackgroundResponse:(int)background{
    int bg = background;
	NSMutableDictionary *newData = [datosConf mutableCopy];
	[newData setObject:[NSNumber numberWithInt:bg] forKey:@"backgroundShake"];
	datosConf = newData;
	[self guardarConf];  
}
-(NSString*)getNumeroSMS{
    return [[datosConf objectForKey:@"NumeroSMS"] stringValue];
}
-(void)setNumeroSMS:(double)numero{
    double number = numero;
	NSMutableDictionary *newData = [datosConf mutableCopy];
	[newData setObject:[NSNumber numberWithDouble:number] forKey:@"NumeroSMS"];
	datosConf = newData;
	[self guardarConf];
}
-(NSString*)getMail{
    return [datosConf objectForKey:@"Correo"];
}
-(void)setMail:(NSString*)mail{
    NSString* correo = mail;
	NSMutableDictionary *newData = [datosConf mutableCopy];
	[newData setObject:[NSString stringWithFormat:@"%@ ",correo] forKey:@"Correo"];
	datosConf = newData;
	[self guardarConf];
}
-(BOOL) firstTime {
	return [[datosConf objectForKey:@"firstTime"] boolValue];
}
-(void) firstTimeSwitch {
	int first = 1;
	NSMutableDictionary *newData = [datosConf mutableCopy];
	[newData setObject:[NSNumber numberWithInt:first] forKey:@"firstTime"];
	datosConf = newData;
	[self guardarConf];  
}
-(int)getTutorialReady {
	return [[datosConf objectForKey:@"Tutorial"] intValue];
}
-(void)setTutorialReady{
	int first = 1;
	NSMutableDictionary *newData = [datosConf mutableCopy];
	[newData setObject:[NSNumber numberWithInt:first] forKey:@"Tutorial"];
	datosConf = newData;
	[self guardarConf];  
}

-(void)mensajeConInput:(NSString *)panicMessage{
    NSString * message = panicMessage;
	NSMutableDictionary *newData = [datosConf mutableCopy];
	[newData setObject:[NSString stringWithFormat:@"%@ ",message] forKey:@"MensajeDePanico"];
	datosConf = newData;
	[self guardarConf];
}
-(void)redSocialConNombre:(NSString *)servicio{
    NSString * redSocial = servicio;
	NSMutableDictionary *newData = [datosConf mutableCopy];
	[newData setObject:[NSString stringWithFormat:@"%@ ",redSocial] forKey:@"RedSocial"];
	datosConf = newData;
	[self guardarConf];
}
-(void)ciudadConNombre:(NSString *)ciudad{
    NSString * laCiudad = ciudad;
	NSMutableDictionary *newData = [datosConf mutableCopy];
	[newData setObject:[NSString stringWithFormat:@"%@ ",laCiudad] forKey:@"Ciudad"];
	datosConf = newData;
	[self guardarConf];
}
-(NSString *)obtenerNombreDeCiudad{
    NSString *ciudad=[datosConf objectForKey:@"Ciudad"];
    return ciudad;
}
-(NSString *)obtenerNombreDeRedSocial{
    NSString *mensaje=[datosConf objectForKey:@"RedSocial"];
    return mensaje;
}
-(NSString *)obtenerMensajeDePanico{
    NSString *mensaje=[datosConf objectForKey:@"MensajeDePanico"];
    return mensaje;
}
-(void)setCiudad:(NSString *)ciudad{
    NSString* laCiudad = ciudad;
	NSMutableDictionary *newData = [datosConf mutableCopy];
	[newData setObject:[NSString stringWithFormat:@"%@ ",laCiudad] forKey:@"Ciudad"];
	datosConf = newData;
	[self guardarConf];
}
-(NSString *)getCiudad{
    return [datosConf objectForKey:@"Ciudad"];
}

-(BOOL)getComprasConID:(int)ID{
    switch (ID) {
        case 1:
            NSLog(@"Dato geteado medellin%i",[[datosConf objectForKey:@"TaximetroMedellin"] boolValue]);
            return [[datosConf objectForKey:@"TaximetroMedellin"] boolValue];
            break;
            
        case 2:
            NSLog(@"Dato geteado cali%i",[[datosConf objectForKey:@"TaximetroCali"] boolValue]);
            return [[datosConf objectForKey:@"TaximetroCali"] boolValue];
            break;
        default:
            return NO;
            break;
    }
}
-(void)setComprasConID:(int)ID{
	NSMutableDictionary *newData = [datosConf mutableCopy];
    int first=1;
    switch (ID) {
        case 1:
            NSLog(@"ID en el modelador %i",ID);
            [newData setObject:[NSNumber numberWithInt:first] forKey:@"TaximetroMedellin"];
            datosConf = newData;
            [self guardarConf];
            NSLog(@"Datos en archivo %@",datosConf);
            return;
            break;
            
        case 2:
            NSLog(@"ID en el modelador %i",ID);
            [newData setObject:[NSNumber numberWithInt:first] forKey:@"TaximetroCali"];
            datosConf = newData;
            [self guardarConf];
            NSLog(@"Datos en archivo %@",datosConf);
            break;
    }
    
}

-(NSString*)getNumeroEmergencia{
    return [[datosConf objectForKey:@"NumeroEmergencia"] stringValue];
}
-(void)setNumeroEmergencia:(double)numero{
	NSMutableDictionary *newData = [datosConf mutableCopy];
	[newData setObject:[NSNumber numberWithDouble:numero] forKey:@"NumeroEmergencia"];
	datosConf = newData;
	[self guardarConf];
}

-(NSString*)getNumero123{
    return [[datosConf objectForKey:@"Numero123"] stringValue];
}
-(void)setNumero123:(double)numero{
	NSMutableDictionary *newData = [datosConf mutableCopy];
	[newData setObject:[NSNumber numberWithDouble:numero] forKey:@"Numero123"];
	datosConf = newData;
	[self guardarConf];
}

-(BOOL)guardarConf {
	NSData *xmlData;  
	NSString *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *Path = [paths objectAtIndex:0];
	//NSString *Path = [[NSBundle mainBundle] bundlePath];
    //NSLog(@"guardar %@",datosConf);
	NSString *DataPath = [Path stringByAppendingPathComponent:DATAFILENAMET];
	xmlData = [NSPropertyListSerialization dataFromPropertyList:datosConf format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];  
	if (xmlData) {  
		[xmlData writeToFile:DataPath atomically:YES];  
		return YES;
	} else {  
		NSLog(@"Error writing plist to file '%s', error = '%s'", [DataPath UTF8String], [error UTF8String]);
		return NO;
	}
}
-(BOOL)guardarEst {
	NSData *xmlData;  
	NSString *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *Path = [paths objectAtIndex:0];
	//NSString *Path = [[NSBundle mainBundle] bundlePath];
    //NSLog(@"guardar %@",datosConf);
	NSString *DataPath = [Path stringByAppendingPathComponent:DATAFILENAMEE];
	xmlData = [NSPropertyListSerialization dataFromPropertyList:datosEstadistica format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];  
	if (xmlData) {  
		[xmlData writeToFile:DataPath atomically:YES];  
		return YES;
	} else {  
		NSLog(@"Error writing plist to file '%s', error = '%s'", [DataPath UTF8String], [error UTF8String]);
		return NO;
	}
}
-(BOOL)guardarCompras{
	NSData *xmlData;  
	NSString *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *Path = [paths objectAtIndex:0];
	//NSString *Path = [[NSBundle mainBundle] bundlePath];
    //NSLog(@"guardar %@",datosConf);
	NSString *DataPath = [Path stringByAppendingPathComponent:TAXIMETROSCOMPRADOS];
	xmlData = [NSPropertyListSerialization dataFromPropertyList:datosEstadistica format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];  
	if (xmlData) {  
		[xmlData writeToFile:DataPath atomically:YES];  
		return YES;
	} else {  
		NSLog(@"Error writing plist to file '%s', error = '%s'", [DataPath UTF8String], [error UTF8String]);  
		return NO;
	}
}

+(float)medidorDeMetrosRecorridos:(NSMutableArray*)puntos{
    float suma=0;
    float value=0;
    for (int i = 0; i < [puntos count]; i++) {
        value = [[puntos objectAtIndex: i] floatValue];
		suma = suma + value;
	}
    return suma;    
}
+(int)conversorSegundosAUnidades:(int)tiempoquieto :(int)cantidadADividir{
    //Pilas, a veces sale división por 0
    int unidadesTiempoEspera = tiempoquieto/cantidadADividir;
    return unidadesTiempoEspera;
}
+(int)conversorMetrosAUnidades:(float)totalMetros paraLaCiudad:(NSString*)ciudad{
    if ([ciudad isEqual:@"Bogota"]||[ciudad isEqual:@"Bogota "]||[ciudad isEqual:@""]) {
        if (totalMetros>10) {
            int unidades = totalMetros/METROSBOGOTA;
            return unidades+25;
        }
        else{
            int unidades = 25 ;
            return unidades;
        }
    }
    else if ([ciudad isEqual:@"Medellin"]) {
        if (totalMetros>10) {
            int unidades = totalMetros/METROSMEDELLIN;
            return unidades+31;
        }
        else{
            int unidades = 31 ;
            return unidades;
        }
    }
    else
        return 0;
}
+(int)unidadesADinero:(int)unidades paraLaCiudad:(NSString*)ciudad{
    int unidadesRecibidas=unidades;
    NSString* nombreCiudad=ciudad;
    if ([nombreCiudad isEqual:@"Bogota"]||[nombreCiudad isEqual:@"Bogota "]||[nombreCiudad isEqual:@""]) {
        if (unidadesRecibidas<52) {
            return 3300;
        }
        else{
            float res1=UNIDADBOGOTA*unidadesRecibidas;
            float res =100*floor((res1/100)+0.5);
            int res3=res;
            return res3;
        }
    }
    else if ([nombreCiudad isEqual:@"Medellin"]) {
        if (unidadesRecibidas<32) {
            return 2400;
        }
        else{
            float res1=UNIDADMEDELLIN*unidadesRecibidas;
            float res =100*floor((res1/100)+0.5);
            int res3=res;
            NSLog(@"Unidades Medellin %i", unidadesRecibidas);
            return res3;
        }
    }
    else
        return 0;
    
}
+(int)unidadesAPesos:(int)unidades{
    if (unidades<300) {
        NSString *varUnidades=[NSString stringWithFormat:@"%i", unidades];
        NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"UnidadesBogota" ofType:@"plist"];
        NSArray *data=[[NSArray alloc]init];
        data=[NSArray arrayWithContentsOfFile:dataPath];
        NSDictionary *tempData = [data objectAtIndex:0];
        int res =[[tempData objectForKey:varUnidades]intValue];
        return res;
    }
    else{
        int res = 20000;
        return res;
    }
}



+(int)conversorMetrosAUnidades:(float)totalMetros paraElTaximetro:(TaximetroObject*)objeto{
    int unidades = totalMetros/objeto.metrosParaCambio;
    return unidades+objeto.unidadesDeArranque;
}
+(int)unidadesADinero:(int)unidades paraElTaximetro:(TaximetroObject *)objeto{
    /*if (unidades<objeto.unidadesCarreraMinima) {
     return objeto.carreraMinima;
     }
     else{*/
    float res1=objeto.costoUnidad*unidades;
    float res =100*floor((res1/100)+0.5);
    int res3=res;
    return res3;
    //}
}
+(float)unidadesADineroFloat:(int)unidades paraElTaximetro:(TaximetroObject *)objeto{
    
    if (unidades<objeto.unidadesCarreraMinima) {
        return objeto.carreraMinimaFloat;
    }
    else{
        float res1=objeto.costoUnidadFloat*unidades;
        return res1;
    }
    
}



-(int)firstTimeSecond{
	return [[datosConf objectForKey:@"firstTimeSecond"] intValue];
}
-(void) firstTimeSecondSwitch {
	int first = 1;
	NSMutableDictionary *newData = [datosConf mutableCopy];
	[newData setObject:[NSNumber numberWithInt:first] forKey:@"firstTimeSecond"];
	datosConf = newData;
	[self guardarConf];  
}

#pragma mark estadisticas
-(float)getKm{
    return [[datosEstadistica objectForKey:@"KilometrosRecorridos"] floatValue];
}
-(void)setKm:(float)km{
    float kilometros = km;
	NSMutableDictionary *newData = [datosEstadistica mutableCopy];
	[newData setObject:[NSString stringWithFormat:@"%f",kilometros] forKey:@"KilometrosRecorridos"];
	datosEstadistica = newData;
	[self guardarEst];
}
-(int)getViajes{
    return [[datosEstadistica objectForKey:@"NumeroDeViajes"] intValue];
}
-(void)setViajes:(int)viajes{
    int numeroViajes = viajes;
	NSMutableDictionary *newData = [datosEstadistica mutableCopy];
	[newData setObject:[NSString stringWithFormat:@"%i",numeroViajes] forKey:@"NumeroDeViajes"];
	datosEstadistica = newData;
	[self guardarEst];
}
-(float)getCantidadTaxis{
    return [[datosEstadistica objectForKey:@"CantidadPagadaEnTaxis"] floatValue];
}
-(void)setCantidadTaxis:(float)cantidadTaxis{
    float dineroEnTaxis = cantidadTaxis;
	NSMutableDictionary *newData = [datosEstadistica mutableCopy];
	[newData setObject:[NSString stringWithFormat:@"%f",dineroEnTaxis] forKey:@"CantidadPagadaEnTaxis"];
	datosEstadistica = newData;
	[self guardarEst];
}
-(float)getMinutosTaxi{
    return [[datosEstadistica objectForKey:@"MinutosEnElTaxi"] floatValue];
}
-(void)setMinutosTaxi:(float)minTaxi{
    float minutosEnTaxi = minTaxi;
	NSMutableDictionary *newData = [datosEstadistica mutableCopy];
	[newData setObject:[NSString stringWithFormat:@"%f",minutosEnTaxi] forKey:@"MinutosEnElTaxi"];
	datosEstadistica = newData;
	[self guardarEst];
}



#pragma mark purchases
-(int)getPackPurchaseWithID:(int)ID{
    switch (ID) {
        case 1:
            NSLog(@"Get ID en el modelador %i",ID);
            return [[datosConf objectForKey:@"TaximetroMedellinPurchased"] intValue];
            break;
        case 0:
            NSLog(@"Get ID en el modelador %i",ID);
            return [[datosConf objectForKey:@"TaximetroCaliPurchased"] intValue];
            break;
        default:
            return 0;
            break;
    }
}
-(void)setPackPurchaseWithID:(int)ID{
    NSMutableDictionary *newData = [datosConf mutableCopy];
    int first=1;
    switch (ID) {
        case 1:
            NSLog(@"ID en el modelador %i",ID);
            [newData setObject:[NSNumber numberWithInt:first] forKey:@"TaximetroMedellinPurchased"];
            datosConf = newData;
            [self guardarConf];
            NSLog(@"Datos en archivo %@",datosConf);
            break;
            
        case 0:
            NSLog(@"ID en el modelador %i",ID);
            [newData setObject:[NSNumber numberWithInt:first] forKey:@"TaximetroCaliPurchased"];
            datosConf = newData;
            [self guardarConf];
            NSLog(@"Datos en archivo %@",datosConf);
            break;
    }
}
@end
