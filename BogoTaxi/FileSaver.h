#import <Foundation/Foundation.h>

@interface FileSaver : NSObject{
    NSDictionary *datos;
    NSDictionary *datosTaximetro;
    
}
-(NSDictionary*)getDictionary:(NSString*)taximetroCiudad;
-(void)setDictionary:(NSDictionary*)dictionary withKey:(NSString*)taximetroCiudad;

-(void)setUserFirstTime:(NSString*)name;
-(NSString*)getUserFirstTime:(NSString*)name;

-(NSString*)getLastCity;
-(void)setLastCity:(NSString*)name;

-(NSString*)getLastNameCity;
-(void)setLastNameCity:(NSString*)name;

@end
