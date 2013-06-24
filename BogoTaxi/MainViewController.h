//
//  ViewController.h
//  BogoTaxi
//
//  Created by Andres Abril on 22/11/12.
//  Copyright (c) 2013 iAmStudio. All rights reserved.
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
#import <MessageUI/MessageUI.h>
#import "MBProgressHud.h"
#import "AppDelegate.h"
#import <Social/Social.h>
#import "AdvertenciaViewController.h"
#import "FollowMeButton.h"

@interface MainViewController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate,CLLocationManagerDelegate,MKMapViewDelegate,UIGestureRecognizerDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate,UIAccelerometerDelegate,UIActionSheetDelegate>{
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
    UIImage *alertButtonImage;
    UIImage *callUserButtonImage;
    UIImage *emergencytButtonImage;

    //Menú
    UIView *containerMenu;
    UIButton *menuButton;
    
    //Página Uno
    UIView *paginaUnoContainer;
    
    BannerView *bannerViewPaginaUno;
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
    UIButton *buttonCallUser;
    UIButton *buttonEmergencyCall;
    
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
    __strong RegionAnnotation *annotationA;
    __strong RegionAnnotation *annotationB;
    int seleccion;
    int seleccionarAB;
    CLLocation* ptoA;
    CLLocation* ptoB;
    BOOL banderaU;
    BOOL banderaCalcular;
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
    
    //Pagina cuatro
    UIView *paginaCuatro;
    
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

    MBProgressHUD *hud;
    FileSaver *saverObj;
    
    //landScape
    UIView *landScapeView;
    UIView *landScapeViewContainer;
    UIView *containerInfoTaximetroLS;
    UIView *containerTiempoLS;
    UIView *containerUnidadesLS;
    CustomLabel *labelRecorridoLS;
    CustomLabel *labelMetrosLS;
    CustomLabel *labelUnidadesLS;
    CustomLabel *tiempoLabelLS;
    CustomLabel *tiempoInputLabelLS;
    CustomLabel *labelEncenderLS;
    CustomSwitch *switchEncenderLS;
    CustomLabel *valorLabelLS;
    CustomLabel *valorInputLabelLS;
    
    UILabel *labelMovimiento;
}
@property (nonatomic, retain) UIAcceleration *lastAcceleration;
@property (strong, nonatomic) CLGeocoder *geoCoder;
@property BOOL shakeDetected;

@end
