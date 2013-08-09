//
//  OpcionesContactoView.h
//  BogoTaxi
//
//  Created by Development on 6/12/12.
//  Copyright (c) 2012 iAmStudio S.A.S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSwitch.h"
#import "CustomLabel.h"
#import "CustomButton.h"

@interface OpcionesContactoView : UIView{
    CGRect myFrame;
    UIView *containerOpciones;
    CustomLabel *bannerOpcionesTaxi;
    UIView *contenidoOpcionesView;
    CustomButton *advertencia;
    CustomButton *acercaDeBogoTaxi;
    CustomButton *contactanos;
    CustomButton *cuentaleaUnAmigo;
    CustomButton *meEncanta;
}
@property(nonatomic,retain) CustomButton *advertencia;
@property(nonatomic,retain) CustomButton *acercaDeBogoTaxi;
@property(nonatomic,retain) CustomButton *contactanos;
@property(nonatomic,retain) CustomButton *cuentaleaUnAmigo;
@property(nonatomic,retain) CustomButton *meEncanta;

-(void)changeState;
-(void)construirConDeviceKind:(int)deviceKind;

@end
