//
//  OpcionesCompartirView.h
//  BogoTaxi
//
//  Created by Development on 6/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSwitch.h"
#import "CustomLabel.h"
#import "CustomButton.h"

@interface OpcionesCompartirView : UIView{
    CGRect myFrame;
    UIView *containerOpciones;
    CustomLabel *bannerOpcionesTaxi;
    UIView *contenidoOpcionesView;
    CustomButton *botonDePanico;
    CustomButton *LlamadaEmergencia;
    
}
@property(nonatomic,retain) CustomButton *botonDePanico;
@property(nonatomic,retain) CustomButton *LlamadaEmergencia;
-(void)changeState;
-(void)construirMenuConDeviceKind:(int)deviceKind;


@end
