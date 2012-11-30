//
//  ViewController.h
//  BogoTaxi
//
//  Created by Andres Abril on 22/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSwitch.h"
#import "CustomLabel.h"
#import <MapKit/MapKit.h>
#import "BannerView.h"
#import "CustomButton.h"
#import "TaximetroManualViewController.h"
#import "LlamadasViewController.h"
#import "MenuView.h"

@interface MainViewController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate>{
    UIScrollView *mainScrollView;
    MenuView *menu;
    //Hud taximetro
    UIView *containerSuperior;
    UIView *barraSuperior;
    UIView *containerSuperiorInferior;
    UIButton *botonBarraSuperior;
    UIView *containerInfoTaximetro;
    UIView *containerTiempo;
    UIView *containerUnidades;
    CustomLabel *labelEncender;
    CustomSwitch *switchEncender;
    CustomLabel *labelRecorrido;
    CustomLabel *labelMetros;
    CustomLabel *labelUnidades;
    BOOL animationFinished;
    
    int deviceKind;//1=iphone4, 2=iphone5, 3=ipad.
    
    UIColor *backgroundColor;
    
    MKMapView *mapView;
    //Menú
    UIView *containerMenu;
    UIButton *menuButton;
    
    //Página Uno
    UIView *paginaUnoContainer;
    
    CustomLabel *configTituloLabel;
    UIView *containerConfig;
    CustomLabel *nocDomFesLabel;
    CustomSwitch *nocDomFesSwitch;
    CustomLabel *aeropuertoLabel;
    CustomSwitch *aeropuertoSwitch;
    CustomLabel *puertaApuertaLabel;
    CustomSwitch *puertaApuertaSwitch;
    CustomLabel *terminalLabel;
    CustomSwitch *terminalSwitch;
    
    CustomLabel *valorLabel;
    CustomLabel *valorInputLabel;
    CustomLabel *tiempoLabel;
    CustomLabel *tiempoInputLabel;
    
    //Pagina Dos
    UIView *paginaDos;
    CustomLabel *bannerPaginaDos;
    UIView *containerBotonesPaginaDos;
    UIView *ledSalida;
    UIView *ledDestino;
    UIButton *botonSalida;
    UIButton *botonDestino;
    MKMapView *mapaPaginaDos;
    CustomButton *botonCalcular;
    
    //Pagina Tres
    UIView *paginaTres;
    BannerView *bannerPaginaTres;
    UIView *containerPlacaPaginaTres;
    UITextField *placa;
    CustomLabel *footer;
    CustomButton *botonEnviarRedes;
    CustomButton *botonEnviarDenuncie;
    CGRect viewFrame;
    CGFloat viewWidth;
    CGFloat viewHeight;
    
    BOOL tecladoUp;
    
    //Timer
    NSTimer *vTimer;
    int lastMovementTime;
    int seconds;

}
@end
