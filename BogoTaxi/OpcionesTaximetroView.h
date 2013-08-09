//
//  OpcionesTaximetroView.h
//  BogoTaxi
//
//  Created by Development on 5/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSwitch.h"
#import "CustomLabel.h"
#import "CustomButton.h"
#import "BannerView.h"
#import "EstadisticasViewController.h"
#import "Modelador.h"

@interface OpcionesTaximetroView : UIView{
    CGRect myFrame;
    UIView *containerOpciones;
    CustomLabel *bannerOpcionesTaxi;
    UIView *contenidoOpcionesView;
    CustomLabel *resumenViajeLabel;
    CustomSwitch *switchResumen;
    
}
@property(nonatomic,retain) CustomButton *estadisticas;
@property(nonatomic,retain) CustomButton *ciudades;
-(void)changeState;
-(void)construirMenuConDeviceKind:(int)deviceKind;

@end
