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
#import "OpcionesViewController.h"
#import "ConsultarPlacaViewController.h"
#import "MenuView.h"
#import "CalcularView.h"
#import "AlertView.h"
#import "AlertMessageView.h"
#import <CoreLocation/CoreLocation.h>
#import "RegionAnnotationView.h"
#import "RegionAnnotation.h"
#import "RegexKitLite.h"
#import "Modelador.h"
#import "iRate.h"
#import "FileSaver.h"

@interface MainViewController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate,CLLocationManagerDelegate,MKMapViewDelegate,UIGestureRecognizerDelegate>{
    UIScrollView *mainScrollView;
    MenuView *menu;
    CalcularView *calcular;
    AlertView *alert;
    AlertMessageView *alertMessage;
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
    
    MKMapView *mapViewGPS;
    UIImageView *routeView2;
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
    UIButton *buttonAlert;
    
    CustomLabel *valorLabel;
    CustomLabel *valorInputLabel;
    CustomLabel *tiempoLabel;
    CustomLabel *tiempoInputLabel;
    
    //Modelador *mod;
    //FileSaver *saver;
    int unidadesAjuste;
    int unidadesAjusteTotal;
    int totalQuieto;
    int tiempoQuieto;
    BOOL estaMoviendose;
    int unidadesGlobales;
    BOOL banderaSecs;
    NSMutableArray *coordenadasParaDibujar;
    
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
    UITapGestureRecognizer *recognizerAnotattion;
    RegionAnnotation *myRegionAnnotation;
    int banderaTouch;
    CLLocationManager *locationManager;
    CLLocationCoordinate2D currentLocation;
    CLLocationCoordinate2D locationOne;
    CLLocationCoordinate2D locationTwo;
    CLLocationCoordinate2D locationPast;
    RegionAnnotation *annotationA;
    RegionAnnotation *annotationB;
    int seleccionarAB;
    CLLocation* ptoA;
    CLLocation* ptoB;
    BOOL banderaU;
    double distanciaMetros;
    NSArray* routes;
    UIImageView *routeView;
    UIColor* lineColor;
    Taximetro *taximetro;
    
    //Pagina Tres
    UIView *paginaTres;
    BannerView *bannerPaginaTres;
    UIView *containerPlacaPaginaTres;
    UITextField *placa;
    CGRect viewFrame;
    CGFloat viewWidth;
    CGFloat viewHeight;
    UILabel *footer;
    
    BOOL tecladoUp;
    
    //Timer
    NSTimer *vTimer;
    int lastMovementTime;
    int seconds;
    
    //Location
    CLLocationManager *locManager;
    CLLocationCoordinate2D zoomLocation;
    CLLocationCoordinate2D zoomLocation2;
    CLLocationCoordinate2D zoomLocationPast;
    BOOL banderaLocation;
    NSMutableArray *arregloDePuntos;


}
@property (nonatomic, retain) UIAcceleration *lastAcceleration;
@property BOOL shakeDetected;

@end
