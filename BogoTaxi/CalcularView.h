//
//  CalcularView.h
//  BogoTaxi
//
//  Created by Development on 5/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSwitch.h"
#import "CustomLabel.h"
#import "CustomButton.h"

@interface CalcularView : UIView{
    CGRect myFrame;
    UIView *contenedorCalcular;
    UIView *containerValores;
    UIView *containerRecorrido;
    CustomLabel *recorrido;
    CustomLabel *valueRecorrido;
    UIView *containerDinero;
    CustomLabel *totalAprox;
    CustomLabel *valueTotalAprox;
    UIView *containerConfig;
    CustomLabel *nocDomFesLabel;
    CustomSwitch *nocDomFesSwitch;
    CustomLabel *aeropuertoLabel;
    CustomSwitch *aeropuertoSwitch;
    CustomLabel *puertaApuertaLabel;
    CustomSwitch *puertaApuertaSwitch;
    CustomLabel *terminalLabel;
    CustomSwitch *terminalSwitch;
    CustomButton *botonVolverAlMapa;
}
-(void)changeState;
-(void)construirMenuConDeviceKind:(int)deviceKind;

@end
