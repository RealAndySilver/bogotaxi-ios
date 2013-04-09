//
//  OpcionesViewController.h
//  BogoTaxi
//
//  Created by Development on 4/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BannerView.h"
#import "OpcionesTaximetroView.h"
#import "OpcionesCompartirView.h"
#import "OpcionesContactoView.h"
#import "CustomButton.h"
#import "EstadisticasViewController.h"
#import "PanicoViewController.h"
#import "AdvertenciaViewController.h"
#import "AcercaDeViewController.h"
#import "LlamadaDeEmergenciaViewController.h"

@interface OpcionesViewController : UIViewController{
    int deviceKind;
    CustomLabel *configTituloLabel;
    UIView *containerView;
    CustomButton *opcionesTaxi;
    CustomButton *compartirGPS;
    CustomButton *contacto;
    OpcionesTaximetroView *opcionesTaxiView;
    OpcionesCompartirView *opcionesCompartir;
    OpcionesContactoView *opcionesContactoeInformacion;
    //EstadisticasViewController *estadisticas;
    //PanicoViewController *panico;
    //LlamadaDeEmergenciaViewController *llamadaEmergencia;
}

@end
