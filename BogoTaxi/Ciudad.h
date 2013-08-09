//
//  Ciudad.h
//  MedeTaxi
//
//  Created by Development on 31/07/13.
//  Copyright (c) 2013 iAmStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ciudad : NSObject{
    
}
@property(nonatomic,retain)NSString *nombre;
@property(nonatomic,retain)NSString *acr;

-(id)leerCiudadConDiccionario:(NSDictionary*)diccionario;

@end
