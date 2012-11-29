//
//  MenuView.h
//  BogoTaxi
//
//  Created by Andres Abril on 29/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"
@interface MenuView : UIView{
    CustomButton *taximetroGps;
    CustomButton *calcular;
    CustomButton *placa;
    CustomButton *taximetroManual;
    CustomButton *llamadas;
    CustomButton *opciones;
    CGRect myFrame;

}
@property(nonatomic,retain)CustomButton *taximetroGps;
@property(nonatomic,retain)CustomButton *calcular;
@property(nonatomic,retain)CustomButton *placa;
@property(nonatomic,retain)CustomButton *taximetroManual;
@property(nonatomic,retain)CustomButton *llamadas;
@property(nonatomic,retain)CustomButton *opciones;
-(void)changeState;
-(void)construirMenuConDeviceKind:(int)deviceKind;
@end
