
#import "FileSaver.h"
#define DATAFILENAME @"savefile.plist"
#define TAXIMETROTFILE @"ciudadestaximetros.plist"

@implementation FileSaver
-(id) init{
	if ((self = [super init])) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *Path = [paths objectAtIndex:0];
		//NSString *Path = [[NSBundle mainBundle] bundlePath];
		NSString *DataPath = [Path stringByAppendingPathComponent:DATAFILENAME];
		NSDictionary *tempDict = [[NSDictionary alloc] initWithContentsOfFile:DataPath];
		
        if (!tempDict) {
			tempDict = [[NSDictionary alloc] init];
		}
        datos = tempDict;
        
        NSArray *paths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *Path2 = [paths2 objectAtIndex:0];
		//NSString *Path = [[NSBundle mainBundle] bundlePath];
		NSString *DataPath2 = [Path2 stringByAppendingPathComponent:TAXIMETROTFILE];
		NSDictionary *tempDict2 = [[NSDictionary alloc] initWithContentsOfFile:DataPath2];
		
        if (!tempDict2) {
			tempDict2 = [[NSDictionary alloc] init];
		}
        datosTaximetro = tempDict2;
	}
	return self;
}
-(BOOL)guardar{
	NSData *xmlData;
	NSString *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *Path = [paths objectAtIndex:0];
	//NSString *Path = [[NSBundle mainBundle] bundlePath];
    //NSLog(@"guardar %@",datosConf);
	NSString *DataPath = [Path stringByAppendingPathComponent:DATAFILENAME];
	xmlData = [NSPropertyListSerialization dataFromPropertyList:datos format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
	if (xmlData) {
		[xmlData writeToFile:DataPath atomically:YES];
		return YES;
	} else {
		NSLog(@"Error writing plist to file '%s', error = '%s'", [DataPath UTF8String], [error UTF8String]);
		return NO;
	}
}
-(BOOL)guardarTaximetro{
	NSData *xmlData;
	NSString *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *Path = [paths objectAtIndex:0];
	//NSString *Path = [[NSBundle mainBundle] bundlePath];
    //NSLog(@"guardar %@",datosConf);
	NSString *DataPath = [Path stringByAppendingPathComponent:TAXIMETROTFILE];
	xmlData = [NSPropertyListSerialization dataFromPropertyList:datosTaximetro format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
	if (xmlData) {
		[xmlData writeToFile:DataPath atomically:YES];
		return YES;
	} else {
		NSLog(@"Error writing plist to file '%s', error = '%s'", [DataPath UTF8String], [error UTF8String]);
		return NO;
	}
}

-(NSDictionary*)getDictionary:(NSString*)taximetroCiudad{
    return [datosTaximetro objectForKey:taximetroCiudad];
}
-(void)setDictionary:(NSDictionary*)dictionary withKey:(NSString*)taximetroCiudad{
	NSMutableDictionary *newData = [datosTaximetro mutableCopy];
	[newData setObject:dictionary forKey:taximetroCiudad];
	datosTaximetro = newData;
	[self guardarTaximetro];
}
-(NSString*)getUserFirstTime:(NSString*)name{
    return [datos objectForKey:name];
}
-(void)setUserFirstTime:(NSString*)name{
    NSMutableDictionary *newData = [datos mutableCopy];
    [newData setObject:name forKey:name];
	datos = newData;
	[self guardar];
}
-(NSString*)getLastCity{
    NSString *ciudad=[datos objectForKey:@"Ciudad"];
    return ciudad;
}
-(void)setLastCity:(NSString*)name{
    NSMutableDictionary *newData = [datos mutableCopy];
    [newData setObject:name forKey:@"Ciudad"];
	datos = newData;
	[self guardar];
}

-(NSString*)getLastNameCity{
    NSString *ciudad=[datos objectForKey:@"FullNameCiudad"];
    return ciudad;
}
-(void)setLastNameCity:(NSString*)name{
    NSMutableDictionary *newData = [datos mutableCopy];
    [newData setObject:name forKey:@"FullNameCiudad"];
	datos = newData;
	[self guardar];
}

@end
