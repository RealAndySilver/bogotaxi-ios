//
//  ViewController.m
//  BogoTaxi
//
//  Created by Andres Abril on 22/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "MainViewController.h"

#pragma mark - constantes de fuente
#define kFontType @"LeagueGothic"

#pragma mark - constantes de color
#define kYellowColor [UIColor colorWithRed:0.984375 green:0.828125 blue:0.390625 alpha:1]
#define kLiteRedColor [UIColor colorWithHue:0 saturation:0.53 brightness:0.95 alpha:1]
#define kDarkRedColor [UIColor colorWithHue:0 saturation:0.67 brightness:0.94 alpha:1]
#define kNightColor [UIColor colorWithRed:0.2265625 green:0.28515625 blue:0.3515625 alpha:1]
#define kGreenColor [UIColor colorWithRed:0.16015625 green:0.97265625 blue:0.65625 alpha:1]
#define kTitleBlueColor [UIColor colorWithRed:0.1484375 green:0.4765625 blue:0.5390625 alpha:1]
#define kBeigeColor [UIColor colorWithRed:1 green:0.984375 blue:0.87890625 alpha:1]
#define kLiteBlueColor [UIColor colorWithRed:0.47265625 green:0.87109375 blue:0.984375 alpha:1]
#define kBlueColor [UIColor colorWithRed:0.50390625 green:0.796875 blue:0.8515625 alpha:1]
#define kDarkGrayColor [UIColor darkGrayColor]
#define kGrayColor [UIColor grayColor]
#define kWhiteColor [UIColor whiteColor]

#define METERS_PER_MILE 1609.344 


#ifdef NSTextAlignmentCenter
#define ALIGN_CENTER NSTextAlignmentCenter
#else
#define ALIGN_CENTER UITextAlignmentCenter
#endif

#pragma mark - interface
@interface MainViewController ()

@end

@implementation MainViewController

#pragma mark - lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    viewFrame=self.view.frame;
    viewWidth=self.view.frame.size.width;
    viewHeight=self.view.frame.size.height;
    tecladoUp=NO;
    if (self.view.frame.size.height<480) {
        deviceKind=1;
    }
    else if (self.view.frame.size.height>480 && self.view.frame.size.height<560){
        deviceKind=2;
    }
    else if (self.view.frame.size.height>600){
        deviceKind=3;
    }
    mainScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 126, self.view.frame.size.width, self.view.frame.size.height-126)];
    mainScrollView.backgroundColor=[UIColor clearColor];
    mainScrollView.contentSize=CGSizeMake(mainScrollView.frame.size.width*3, mainScrollView.frame.size.height);
    [mainScrollView setShowsHorizontalScrollIndicator:NO];
    [mainScrollView setPagingEnabled:YES];
    mainScrollView.delegate=self;
    [mainScrollView setScrollEnabled:NO];
    UITapGestureRecognizer *scrollTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [mainScrollView addGestureRecognizer:scrollTap];
    
    
    [self.view addSubview:mainScrollView];
    [self crearPaginaUno];
    [self crearPaginaDos];
    [self crearViewCalcular];
    [self crearPaginaTres];
    [self crearInterfazSuperior];
    backgroundColor=self.view.backgroundColor;
    [paginaUnoContainer bringSubviewToFront:containerConfig];
    [self crearMenu];
    [self crearViewAlert];
    [self crearViewAlertMessage];
    locManager=[[CLLocationManager alloc]init];
    locManager.delegate=self;
    mapView.showsUserLocation=YES;
    mapView.delegate=self;

}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark - interfaz superior
-(void)crearInterfazSuperior{
    mapView=[[MKMapView alloc]initWithFrame:CGRectMake(0, (self.view.frame.size.height-126)*-1, self.view.frame.size.width, self.view.frame.size.height-126)];
    mapView.tag=1000;
    [self.view addSubview:mapView];
    
    buttonAlert=[[UIButton alloc]initWithFrame:CGRectMake(10, mapView.frame.size.height-50, 40, 40)];
    buttonAlert.backgroundColor=kLiteRedColor;
    buttonAlert.layer.opacity=0;
    [mapView addSubview:buttonAlert];
    
    containerSuperior=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 126)];
    containerSuperior.backgroundColor=[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1];
    [self.view addSubview:containerSuperior];
    
    barraSuperior=[[UIView alloc]initWithFrame:CGRectMake(0, 0, containerSuperior.frame.size.width, 37)];
    barraSuperior.backgroundColor=[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1];
    [containerSuperior addSubview:barraSuperior];
    botonBarraSuperior=[UIButton buttonWithType:UIButtonTypeCustom];
    animationFinished=NO;
    [botonBarraSuperior addTarget:self action:@selector(startAnimationSequence) forControlEvents:UIControlEventTouchUpInside];
    [botonBarraSuperior setTitle:@"Mapa" forState:UIControlStateNormal];
    [botonBarraSuperior setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [botonBarraSuperior setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    botonBarraSuperior.titleLabel.font=[UIFont fontWithName:kFontType size:20];
    botonBarraSuperior.backgroundColor=kLiteRedColor;
    botonBarraSuperior.frame=CGRectMake(containerSuperior.frame.size.width-87, 6, 81, 25);
    [barraSuperior addSubview:botonBarraSuperior];
    
    valorLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, 70, 22)];
    valorLabel.center=CGPointMake(45, barraSuperior.frame.size.height/2);
    [valorLabel ponerTexto:@"Valor Total:" fuente:[UIFont fontWithName:kFontType size:22] color:[UIColor whiteColor]];
    [valorLabel setOverlayOff:YES];
    [barraSuperior addSubview:valorLabel];
    
    valorInputLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, 130, 35)];
    valorInputLabel.center=CGPointMake(155, barraSuperior.frame.size.height/2);
    [valorInputLabel ponerTexto:@"$99.900" fuente:[UIFont fontWithName:kFontType size:32] color:kDarkRedColor];
    [valorInputLabel setOverlayOff:YES];
    [barraSuperior addSubview:valorInputLabel];
    
    containerSuperiorInferior=[[UIView alloc]initWithFrame:CGRectMake(0, barraSuperior.frame.size.height, containerSuperior.frame.size.width, containerSuperior.frame.size.height-barraSuperior.frame.size.height)];
    containerSuperiorInferior.backgroundColor=[UIColor whiteColor];
    containerSuperiorInferior.layer.shadowColor = [[UIColor colorWithWhite:0.1 alpha:1] CGColor];
    containerSuperiorInferior.layer.shadowOffset = CGSizeMake(0.0f,1.0f);
    containerSuperiorInferior.layer.shadowRadius = 1;
    containerSuperiorInferior.layer.shadowOpacity = 0.3;
    [containerSuperior addSubview:containerSuperiorInferior];
    
    containerInfoTaximetro=[[UIView alloc]initWithFrame:CGRectMake(5, 5, 135, 78)];
    containerInfoTaximetro.backgroundColor=[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1];
    [containerSuperiorInferior addSubview:containerInfoTaximetro];
    
    
    containerTiempo=[[UIView alloc]initWithFrame:CGRectMake(137+4, 5, 70, 78)];
    containerTiempo.backgroundColor=[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1];
    [containerSuperiorInferior addSubview:containerTiempo];
    
    tiempoLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 7, containerTiempo.frame.size.width, 30)];
    [tiempoLabel ponerTexto:@"Tiempo" fuente:[UIFont fontWithName:kFontType size:22] color:kYellowColor];
    [tiempoLabel setCentrado:YES];
    [tiempoLabel setOverlayOff:YES];
    [containerTiempo addSubview:tiempoLabel];
    tiempoInputLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 40, containerTiempo.frame.size.width, 30)];
    [tiempoInputLabel ponerTexto:@"00:00" fuente:[UIFont fontWithName:kFontType size:22] color:[UIColor whiteColor]];
    [tiempoInputLabel setCentrado:YES];
    [tiempoInputLabel setOverlayOff:YES];
    [containerTiempo addSubview:tiempoInputLabel];

    
    UIView *infoTaximetroOverlay=[[UIView alloc]initWithFrame:CGRectMake(3, 3, containerInfoTaximetro.frame.size.width-5, containerInfoTaximetro.frame.size.height-5)];
    infoTaximetroOverlay.backgroundColor=[UIColor whiteColor];
    infoTaximetroOverlay.alpha=0.08;
    [containerInfoTaximetro addSubview:infoTaximetroOverlay];
    
    labelEncender=[[CustomLabel alloc]initWithFrame:CGRectMake(8, 10, 80, 23)];
    [labelEncender ponerTexto:@"Encender" fuente:[UIFont fontWithName:kFontType size:22] color:kYellowColor];
    [labelEncender setOverlayOff:YES];
    [containerInfoTaximetro addSubview:labelEncender];
    
    labelRecorrido=[[CustomLabel alloc]initWithFrame:CGRectMake(8, 46, 80, 20)];
    [labelRecorrido ponerTexto:@"Recorrido" fuente:[UIFont fontWithName:kFontType size:22] color:kYellowColor];
    [labelRecorrido setOverlayOff:YES];
    [containerInfoTaximetro addSubview:labelRecorrido];
    
    switchEncender=[[CustomSwitch alloc]initWithFrame:CGRectMake(70, 10, 0, 0)];
    [switchEncender addTarget:self action:@selector(encenderTaximetro:)];
    [containerInfoTaximetro addSubview:switchEncender];
    
    labelMetros=[[CustomLabel alloc]initWithFrame:CGRectMake(78, 46, 50, 20)];
    [labelMetros ponerTexto:@"0.0 m" fuente:[UIFont fontWithName:kFontType size:22] color:[UIColor whiteColor]];
    labelMetros.adjustsFontSizeToFitWidth = YES;
    [labelMetros setOverlayOff:YES];
    [containerInfoTaximetro addSubview:labelMetros];
    
    containerUnidades=[[UIView alloc]initWithFrame:CGRectMake(6+206, 5, 103, 78)];
    containerUnidades.backgroundColor=[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1];
    [containerSuperiorInferior addSubview:containerUnidades];
    UIView *containerUnidadesOverlay=[[UIView alloc]initWithFrame:CGRectMake(3, 3, containerUnidades.frame.size.width-5, containerUnidades.frame.size.height-5)];
    containerUnidadesOverlay.backgroundColor=[UIColor whiteColor];
    containerUnidadesOverlay.alpha=0.08;
    //[containerUnidades addSubview:containerUnidadesOverlay];
    UIView *containerBotonesUnidades=[[UIView alloc]initWithFrame:CGRectMake(0, containerUnidades.frame.size.height-30, containerUnidades.frame.size.width, 30)];
    containerBotonesUnidades.backgroundColor=[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1];
    [containerUnidades addSubview:containerBotonesUnidades];
    unidades=25;
    UIButton *botonMenos=[UIButton buttonWithType:UIButtonTypeCustom];
    botonMenos.frame=CGRectMake(0, 0, (containerBotonesUnidades.frame.size.width/2)-0.5, containerBotonesUnidades.frame.size.height);
    [botonMenos setTitle:@"-" forState:UIControlStateNormal];
    botonMenos.titleLabel.font=[UIFont  boldSystemFontOfSize:15];
    botonMenos.tag=3000;
    botonMenos.backgroundColor=kDarkGrayColor;
    [botonMenos addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [containerBotonesUnidades addSubview:botonMenos];
    
    UIButton *botonMas=[UIButton buttonWithType:UIButtonTypeCustom];
    botonMas.frame=CGRectMake((containerBotonesUnidades.frame.size.width/2)+0.5, 0, (containerBotonesUnidades.frame.size.width/2)-0.5, containerBotonesUnidades.frame.size.height);
    [botonMas setTitle:@"+" forState:UIControlStateNormal];
    botonMas.titleLabel.font=[UIFont  boldSystemFontOfSize:15];
    botonMas.tag=3001;
    botonMas.backgroundColor=kDarkGrayColor;
    [botonMas addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [containerBotonesUnidades addSubview:botonMas];
    
    labelUnidades=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, containerUnidades.frame.size.width-10, containerUnidades.frame.size.height-20)];
    labelUnidades.center=CGPointMake(containerUnidades.frame.size.width/2, (containerUnidades.frame.size.height/2)-13);
    //labelUnidades.textAlignment=UITextAlignmentCenter;
    labelUnidades.textAlignment=ALIGN_CENTER;

    [labelUnidades ponerTexto:@"25" fuente:[UIFont fontWithName:kFontType size:50] color:kDarkRedColor];
    [labelUnidades setOverlayOff:YES];
    [containerUnidades addSubview:labelUnidades];
}
-(void)buttonPressed:(UIButton*)button{
    if (button.tag==3000) {
        unidades-=1;
        labelUnidades.text=[NSString stringWithFormat:@"%i",unidades];
        
    }
    else if (button.tag==3001){
        unidades+=1;
        labelUnidades.text=[NSString stringWithFormat:@"%i",unidades];
    }
}
#pragma mark - boton menu
-(void)crearMenu{
    menu=[[MenuView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [menu construirMenuConDeviceKind:deviceKind];
    [self.view addSubview:menu];
    [menu.taximetroManual addTarget:self action:@selector(goTo:) forControlEvents:UIControlEventTouchUpInside];
    [menu.taximetroGps addTarget:self action:@selector(goTo:) forControlEvents:UIControlEventTouchUpInside];
    [menu.calcular addTarget:self action:@selector(goTo:) forControlEvents:UIControlEventTouchUpInside];
    [menu.placa addTarget:self action:@selector(goTo:) forControlEvents:UIControlEventTouchUpInside];
    [menu.llamadas addTarget:self action:@selector(goTo:) forControlEvents:UIControlEventTouchUpInside];
    [menu.opciones addTarget:self action:@selector(goTo:) forControlEvents:UIControlEventTouchUpInside];
    
    containerMenu=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 120, 100)];
    containerMenu.backgroundColor=kDarkRedColor;
    containerMenu.layer.shouldRasterize=YES;
    containerMenu.center=CGPointMake(0, self.view.frame.size.height);
    CGAffineTransform rotarCuadrado = CGAffineTransformMakeRotation(1.57079633/2.1);
    containerMenu.transform = rotarCuadrado;
    
    menuButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [menuButton addTarget:self action:@selector(callMenu) forControlEvents:UIControlEventTouchUpInside];
    [menuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [menuButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    menuButton.titleLabel.layer.shouldRasterize=YES;
    
    menuButton.frame=CGRectMake(0, self.view.frame.size.height-30, 50, 30);
    menuButton.titleLabel.font=[UIFont fontWithName:kFontType size:25];
    //menuButton.center=CGPointMake(containerMenu.frame.size.width/2-(menuButton.frame.size.width/2), menuButton.frame.size.height/2);
    [menuButton setTitle:@"Menú" forState:UIControlStateNormal];
    
    [self.view addSubview:containerMenu];
    [self.view addSubview:menuButton];
}
#pragma mark - pagina uno

-(void)crearPaginaUno{
    paginaUnoContainer=[[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScrollView.frame.size.width, mainScrollView.frame.size.height)];
    paginaUnoContainer.backgroundColor=kYellowColor;
    [mainScrollView addSubview:paginaUnoContainer];
    
    BannerView *bannerView=[[BannerView alloc]initWithFrame:CGRectMake(0, 0, mainScrollView.frame.size.width-10, 0)];
    [bannerView ponerTexto:@"CONFIGURACIÓN"];
    bannerView.configBannerLabel.textColor=[UIColor colorWithRed:0.75390625 green:0.02734375 blue:0.02734375 alpha:1];
    [bannerView.configBannerLabel setOverlayOff:NO];
    [bannerView setBannerColor:[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1]];
    bannerView.center=CGPointMake(self.view.frame.size.width/2, 50);
    [paginaUnoContainer addSubview:bannerView];
    
    /*BannerView *bannerView=[[BannerView alloc]initWithFrame:CGRectMake(0, 0, mainScrollView.frame.size.width-10, 0)];
    [bannerView ponerTexto:@"CONFIGURACIÓN"];
    bannerView.center=CGPointMake(mainScrollView.frame.size.width/2, 50);
    [paginaUnoContainer addSubview:bannerView];*/
    
    /*configTituloLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-20, 30)];
    
    configTituloLabel.center=CGPointMake(paginaUnoContainer.frame.size.width/2, 104);
    if (deviceKind==2) {
        configTituloLabel.center=CGPointMake(paginaUnoContainer.frame.size.width/2, 124);
    }
    [configTituloLabel ponerTexto:@"CONFIGURA TU TAXÍMETRO" fuente:[UIFont fontWithName:kFontType size:30] color:[UIColor colorWithRed:0.75390625 green:0.57421875 blue:0.06640625 alpha:1]];
    [configTituloLabel setCentrado:YES];
    //[configTituloLabel setOverlayOff:YES];
    [paginaUnoContainer addSubview:configTituloLabel];*/
    
    containerConfig=[[UIView alloc]initWithFrame:CGRectMake(5, bannerView.frame.size.height+15,paginaUnoContainer.frame.size.width-10, 165)];
    
    if (deviceKind==2) {
        containerConfig.frame=CGRectMake(5, bannerView.frame.size.height+configTituloLabel.frame.size.height+45, paginaUnoContainer.frame.size.width-10, 160);
    }
    
    containerConfig.backgroundColor=[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1];
    containerConfig.layer.cornerRadius=3;
    [paginaUnoContainer addSubview:containerConfig];
    
    int margenLabels=10;
    nocDomFesLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(margenLabels, 10, 130, 30)];
    [nocDomFesLabel ponerTexto:@"Noc-Dom-Fes" fuente:[UIFont fontWithName:kFontType size:30] color:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1]];
    [nocDomFesLabel setOverlayOff:YES];
    [containerConfig addSubview:nocDomFesLabel];
    
    nocDomFesSwitch=[[CustomSwitch alloc]initWithFrame:CGRectMake(containerConfig.frame.size.width-65, 8, 0, 0)];
    
    [nocDomFesSwitch addTarget:self action:@selector(animacionNoche:)];
    
    [containerConfig addSubview:nocDomFesSwitch];
    
    aeropuertoLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(margenLabels, 50, 130, 30)];
    [aeropuertoLabel ponerTexto:@"Aeropuerto" fuente:[UIFont fontWithName:kFontType size:30] color:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1]];
    [aeropuertoLabel setOverlayOff:YES];
    [containerConfig addSubview:aeropuertoLabel];
    
    aeropuertoSwitch=[[CustomSwitch alloc]initWithFrame:CGRectMake(containerConfig.frame.size.width-65, 48, 0, 0)];
    [containerConfig addSubview:aeropuertoSwitch];
    
    puertaApuertaLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(margenLabels, 90, 130, 30)];
    [puertaApuertaLabel ponerTexto:@"Puerta a puerta" fuente:[UIFont fontWithName:kFontType size:30] color:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1]];
    [puertaApuertaLabel setOverlayOff:YES];
    [containerConfig addSubview:puertaApuertaLabel];
    
    puertaApuertaSwitch=[[CustomSwitch alloc]initWithFrame:CGRectMake(containerConfig.frame.size.width-65, 88, 0, 0)];
    [containerConfig addSubview:puertaApuertaSwitch];
    
    terminalLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(margenLabels, 130, 130, 30)];
    [terminalLabel ponerTexto:@"Terminal" fuente:[UIFont fontWithName:kFontType size:30] color:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1]];
    [terminalLabel setOverlayOff:YES];
    [containerConfig addSubview:terminalLabel];
    
    terminalSwitch=[[CustomSwitch alloc]initWithFrame:CGRectMake(containerConfig.frame.size.width-65, 128, 0, 0)];
    [containerConfig addSubview:terminalSwitch];
    
    UIView *containerValoresYTiempo=[[UIView alloc]initWithFrame:CGRectMake(0, 0, paginaUnoContainer.frame.size.width-20, 40)];
    containerValoresYTiempo.backgroundColor=[UIColor clearColor];
    containerValoresYTiempo.center=CGPointMake(paginaUnoContainer.frame.size.width/2, (bannerView.frame.size.height+configTituloLabel.frame.size.height+containerConfig.frame.size.height+10)+(containerValoresYTiempo.frame.size.height/2));
    [paginaUnoContainer addSubview:containerValoresYTiempo];
    
    CustomButton *botonEnviarPlaca=[[CustomButton alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    botonEnviarPlaca.center=CGPointMake(paginaUnoContainer.frame.size.width-5-(botonEnviarPlaca.frame.size.width/2), paginaUnoContainer.frame.size.height-(botonEnviarPlaca.frame.size.height/2)-8);
    [botonEnviarPlaca setTitle:@"Consultar Placa" forState:UIControlStateNormal];
    botonEnviarPlaca.backgroundColor=kDarkRedColor;
    [botonEnviarPlaca setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [botonEnviarPlaca setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [botonEnviarPlaca addTarget:self action:@selector(irAPlaca) forControlEvents:UIControlEventTouchUpInside];
    [paginaUnoContainer addSubview:botonEnviarPlaca];
    
}

#pragma mark - pagina dos
-(void)crearPaginaDos{
    paginaDos=[[UIView alloc]initWithFrame:CGRectMake(mainScrollView.frame.size.width*1, 0, mainScrollView.frame.size.width, mainScrollView.frame.size.height)];
    paginaDos.backgroundColor=[UIColor clearColor];
    [mainScrollView addSubview:paginaDos];
    
    taximetro=[[Taximetro alloc]initWithCiudad:@"bogota"];
    
    bannerPaginaDos=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, paginaDos.frame.size.width-10, 50)];
    bannerPaginaDos.center=CGPointMake(paginaDos.frame.size.width/2, 25);
    [bannerPaginaDos ponerTexto:@"CALCULAR" fuente:[UIFont fontWithName:kFontType size:40] color:kTitleBlueColor];
    [bannerPaginaDos setCentrado:YES];
    [paginaDos addSubview:bannerPaginaDos];
    
    containerBotonesPaginaDos=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 35)];
    containerBotonesPaginaDos.center=CGPointMake(paginaDos.frame.size.width/2, 62);
    containerBotonesPaginaDos.layer.cornerRadius=3;
    containerBotonesPaginaDos.backgroundColor=kBeigeColor;
    containerBotonesPaginaDos.layer.shadowColor = [[UIColor colorWithWhite:0.1 alpha:1] CGColor];
    containerBotonesPaginaDos.layer.shadowOffset = CGSizeMake(0.0f,1.0f);
    containerBotonesPaginaDos.layer.shadowRadius = 1;
    containerBotonesPaginaDos.layer.shadowOpacity = 0.3;
    [paginaDos addSubview:containerBotonesPaginaDos];
    
    UIView *separador=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, containerBotonesPaginaDos.frame.size.height-5)];
    separador.center=CGPointMake(containerBotonesPaginaDos.frame.size.width/2, containerBotonesPaginaDos.frame.size.height/2);
    separador.backgroundColor=[UIColor grayColor];
    [containerBotonesPaginaDos addSubview:separador];
    
    ledSalida=[[UIView alloc]initWithFrame:CGRectMake(80, 7.5, 15, 15)];
    ledSalida.center=CGPointMake((containerBotonesPaginaDos.frame.size.width/2)-20, containerBotonesPaginaDos.frame.size.height/2);
    ledSalida.backgroundColor=kLiteRedColor;
    ledSalida.layer.cornerRadius=ledSalida.frame.size.width/2;
    [containerBotonesPaginaDos addSubview:ledSalida];
    botonSalida=[UIButton buttonWithType:UIButtonTypeCustom];
    botonSalida.frame=CGRectMake(0, 0, 88, containerBotonesPaginaDos.frame.size.height);
    botonSalida.titleLabel.font=[UIFont fontWithName:kFontType size:25];
    [botonSalida setTitle:@"Salida" forState:UIControlStateNormal];
    botonSalida.tag=1;
    //botonSalida.backgroundColor=kGreenColor;
    [botonSalida setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [botonSalida setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [containerBotonesPaginaDos addSubview:botonSalida];
    [botonSalida addTarget:self action:@selector(callAlert:) forControlEvents:UIControlEventTouchUpInside];
    
    botonDestino=[UIButton buttonWithType:UIButtonTypeCustom];
    botonDestino.frame=CGRectMake(containerBotonesPaginaDos.frame.size.width-88, 0, 95, containerBotonesPaginaDos.frame.size.height);
    botonDestino.titleLabel.font=[UIFont fontWithName:kFontType size:25];
    //botonDestino.backgroundColor=kGreenColor;
    [botonDestino setTitle:@"Destino" forState:UIControlStateNormal];
    [botonDestino setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [botonDestino setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    botonDestino.tag=2;
    [containerBotonesPaginaDos addSubview:botonDestino];
    [botonDestino addTarget:self action:@selector(callAlert:) forControlEvents:UIControlEventTouchUpInside];
    
    ledDestino=[[UIView alloc]initWithFrame:CGRectMake(120, 7.5, 15, 15)];
    ledDestino.center=CGPointMake((containerBotonesPaginaDos.frame.size.width/2)+20, containerBotonesPaginaDos.frame.size.height/2);

    ledDestino.backgroundColor=kGreenColor;
    ledDestino.layer.cornerRadius=ledSalida.frame.size.width/2;
    [containerBotonesPaginaDos addSubview:ledDestino];
    
    locationManager = [[CLLocationManager alloc] init];
	locationManager.delegate = self;
	locationManager.distanceFilter = kCLLocationAccuracyHundredMeters;
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    mapaPaginaDos=[[MKMapView alloc]initWithFrame:CGRectMake(5, bannerPaginaDos.frame.size.height+configTituloLabel.frame.size.height+35, paginaUnoContainer.frame.size.width-10, 195)];
    if (self.view.frame.size.height>480) {
        mapaPaginaDos.frame=CGRectMake(5, bannerPaginaDos.frame.size.height+configTituloLabel.frame.size.height+5, paginaUnoContainer.frame.size.width-10, 280);
    }
    mapaPaginaDos.delegate=self;
    mapaPaginaDos.layer.cornerRadius=3;
    mapaPaginaDos.tag=1001;
    recognizerAnotattion = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandler:)];
    recognizerAnotattion.delegate=self;
    [mapaPaginaDos addGestureRecognizer:recognizerAnotattion];
    myRegionAnnotation = [[RegionAnnotation alloc] init];
    annotationA= [[RegionAnnotation alloc] init];
    annotationB= [[RegionAnnotation alloc] init];
    [paginaDos addSubview:mapaPaginaDos];
    routeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mapaPaginaDos.frame.size.width, mapaPaginaDos.frame.size.height)];
    routeView.userInteractionEnabled = NO;
    [mapaPaginaDos addSubview:routeView];

    /*UITapGestureRecognizer *zoomTapMap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zoomMapView)];
    [mapaPaginaDos addGestureRecognizer:zoomTapMap];*/
    
    botonCalcular=[[CustomButton alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    botonCalcular.center=CGPointMake(paginaUnoContainer.frame.size.width-10-(botonCalcular.frame.size.width/2), paginaDos.frame.size.height-(botonCalcular.frame.size.height/2)-8);
    [botonCalcular setTitle:@"Calcular" forState:UIControlStateNormal];
    [botonCalcular addTarget:self action:@selector(callCalcular) forControlEvents:UIControlEventTouchUpInside];
    [paginaDos addSubview:botonCalcular];
    
}
#pragma mark - ViewCalcular
-(void)crearViewCalcular{
    calcular=[[CalcularView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [calcular construirMenuConDeviceKind:deviceKind];
    [self.view addSubview:calcular];
}
#pragma mark - ViewAlert
-(void)crearViewAlert{
    alert=[[AlertView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [alert crearView];    
    [self.view addSubview:alert];
}
#pragma mark - pagina tres
-(void)crearPaginaTres{
    paginaTres=[[UIView alloc]initWithFrame:CGRectMake(mainScrollView.frame.size.width*2, 0, mainScrollView.frame.size.width, mainScrollView.frame.size.height)];
    paginaTres.backgroundColor=kYellowColor;
    [mainScrollView addSubview:paginaTres];
    
    BannerView *bannerView=[[BannerView alloc]initWithFrame:CGRectMake(0, 0, mainScrollView.frame.size.width-10, 0)];
    [bannerView ponerTexto:@"CONSULTAR PLACA"];
    bannerView.configBannerLabel.textColor=[UIColor colorWithRed:0.75390625 green:0.02734375 blue:0.02734375 alpha:1];
    [bannerView.configBannerLabel setOverlayOff:NO];
    [bannerView setBannerColor:[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1]];
    bannerView.center=CGPointMake(self.view.frame.size.width/2, 50);
    [paginaTres addSubview:bannerView];
    
    /*bannerPaginaTres=[[BannerView alloc]initWithFrame:CGRectMake(0, 0, mainScrollView.frame.size.width-10, 0)];
    [bannerPaginaTres ponerTexto:@"ENVÍA TU PLACA"];
    bannerPaginaTres.center=CGPointMake(mainScrollView.frame.size.width/2, 50);
    [paginaTres addSubview:bannerPaginaTres];*/
    
    containerPlacaPaginaTres=[[UIView alloc]initWithFrame:CGRectMake(5, bannerView.frame.size.height+20,paginaTres.frame.size.width-10, 190)];
    
    if (deviceKind==2) {
        containerPlacaPaginaTres.frame=CGRectMake(5, bannerPaginaTres.frame.size.height+45, paginaTres.frame.size.width-10, 190);
    }
    containerPlacaPaginaTres.backgroundColor=[UIColor clearColor];
    [paginaTres addSubview:containerPlacaPaginaTres];
    
    UIButton *buttonConsultar=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 90, 40)];
    buttonConsultar.center=CGPointMake(self.view.frame.size.width/2, 130);
    buttonConsultar.titleLabel.font=[UIFont fontWithName:kFontType size:24];
    [buttonConsultar setTitle:@"Consultar" forState:UIControlStateNormal];
    buttonConsultar.backgroundColor=kDarkRedColor;
    [buttonConsultar addTarget:self action:@selector(consultar) forControlEvents:UIControlEventTouchUpInside];
    [containerPlacaPaginaTres addSubview:buttonConsultar];
    
    UIView *placaContainer=[[UIView alloc]initWithFrame:CGRectMake(30, 20, containerPlacaPaginaTres.frame.size.width-60, 90)];
    placaContainer.backgroundColor=kWhiteColor;
    placaContainer.layer.shadowColor = [[UIColor colorWithWhite:0.1 alpha:1] CGColor];
    placaContainer.layer.shadowOffset = CGSizeMake(0.0f,1.0f);
    placaContainer.layer.shadowRadius = 1;
    placaContainer.layer.shadowOpacity = 0.3;
    [containerPlacaPaginaTres addSubview:placaContainer];
    placa=[[UITextField alloc]initWithFrame:CGRectMake(10, 5, placaContainer.frame.size.width-20, placaContainer.frame.size.height-10)];
    placa.backgroundColor=[UIColor clearColor];
    placa.placeholder=@"#PLACA";
    placa.delegate=self;
    placa.font=[UIFont fontWithName:kFontType size:70];
    //placa.textAlignment=UITextAlignmentCenter;
    placa.textAlignment=ALIGN_CENTER;

    placa.autocorrectionType=UITextAutocorrectionTypeNo;
    placa.autocapitalizationType=UITextAutocapitalizationTypeAllCharacters;
    placa.textColor=kDarkGrayColor;
    [placaContainer addSubview:placa];
    
    footer=[[UILabel alloc]initWithFrame:CGRectMake(0, 150, containerPlacaPaginaTres.frame.size.width, 50)];
    footer.backgroundColor=[UIColor clearColor];
    //&footer.textAlignment=UITextAlignmentCenter;
    footer.textAlignment=ALIGN_CENTER;

    footer.font=[UIFont fontWithName:kFontType size:28];
    footer.textColor=[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
    footer.text=@"Por favor escriba una placa valida";
    footer.alpha=0;
    [containerPlacaPaginaTres addSubview:footer];
}
-(BOOL)checkPlaca:(NSString *)placaConsultada {
    
    NSString* placaRegex = @"[A-Za-z]{3,3}[0-9]{3,3}";
    NSPredicate* placaTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", placaRegex];
    
    return [placaTest evaluateWithObject:placaConsultada];
}
-(void)consultar{
    BOOL *resultado= [self checkPlaca:placa.text];
    if ([placa.text isEqual:@""] || resultado==NO) {
        [self animarView:footer ConOpacidad:1];
    }
    else{
        ConsultarPlacaViewController *cPVC=[[ConsultarPlacaViewController alloc]init];
        cPVC=[self.storyboard instantiateViewControllerWithIdentifier:@"ConsultarPlaca"];
        cPVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        cPVC.stringPlaca=placa.text;
        [cPVC.self consutar];
        [self presentModalViewController:cPVC animated:YES];
    }
   
}
#pragma mark - animaciones
-(void)animacionNoche:(CustomSwitch*)switch1{
    if (switch1.isOn) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.view.backgroundColor=kNightColor;
        configTituloLabel.textColor=kWhiteColor;
        [UIView commitAnimations];
    }
    else{
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.view.backgroundColor=backgroundColor;
        configTituloLabel.textColor=kTitleBlueColor;
        [UIView commitAnimations];
    }
}
-(void)animarViewPorTeclado{
    if (tecladoUp) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.view.frame=CGRectMake(0, -115, viewWidth, viewHeight);
        [UIView commitAnimations];
    }
    else{
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.25];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.view.frame=viewFrame;
        [UIView commitAnimations];
    }
}
int counter=0;
-(void)startAnimationSequence{
    if (animationFinished) {
        [self.view setUserInteractionEnabled:NO];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:1];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDidStopSelector:@selector(bringMenuToFront)];
        containerSuperior.frame=CGRectMake(0, 0, self.view.frame.size.width, 126);
        mapView.frame=CGRectMake(0,(self.view.frame.size.height-126)*-1, self.view.frame.size.width, self.view.frame.size.height-126);
        [UIView commitAnimations];
        animationFinished=NO;
        [botonBarraSuperior setTitle:@"Mapa" forState:UIControlStateNormal];
        counter=0;
    }
    else{
        [self.view setUserInteractionEnabled:NO];
        [self.view bringSubviewToFront:containerSuperior];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.4-(counter/3)];
        if (counter%2) {
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        }
        else{
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        }
        if (counter<4) {
            [UIView setAnimationDidStopSelector:@selector(startAnimationSequence)];
        }
        if (counter==0) {
            containerSuperior.frame=CGRectMake(0,self.view.frame.size.height-126, self.view.frame.size.width, 126);
            mapView.frame=CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height-126);
        }
        else if (counter==1){
            containerSuperior.frame=CGRectMake(0,self.view.frame.size.height-176, self.view.frame.size.width, 126);
            mapView.frame=CGRectMake(0,-50, self.view.frame.size.width, self.view.frame.size.height-126);
        }
        else if (counter==2){
            containerSuperior.frame=CGRectMake(0,self.view.frame.size.height-126, self.view.frame.size.width, 126);
            mapView.frame=CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height-126);
        }
        else if (counter==3){
            containerSuperior.frame=CGRectMake(0,self.view.frame.size.height-136, self.view.frame.size.width, 126);
            mapView.frame=CGRectMake(0,-10, self.view.frame.size.width, self.view.frame.size.height-126);
        }
        else if (counter==4){
            containerSuperior.frame=CGRectMake(0,self.view.frame.size.height-126, self.view.frame.size.width, 126);
            mapView.frame=CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height-126);
            [botonBarraSuperior setTitle:@"Esconder" forState:UIControlStateNormal];
            animationFinished=YES;
            [self.view setUserInteractionEnabled:YES];
        }
        counter++;
        
        [UIView commitAnimations];
    }
}
-(void)animarView:(UIView*)view ConOpacidad:(float)opacidad{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    view.alpha=opacidad;
    [UIView commitAnimations];
}
#pragma mark - timer
-(void)clockStart {
    if (![vTimer isValid]) {
        vTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(vTimerVoid) userInfo:nil repeats:YES];
    }
    lastMovementTime = seconds;
}
-(void)clockStop {
    if ([vTimer isValid]) {
        [vTimer invalidate];
        vTimer = nil;
    }
    lastMovementTime = seconds;
}
-(void)vTimerVoid{
    seconds +=1;
    
    NSString *Seconds;
    NSString *Minutes;
    if (seconds/60<10)
        Minutes=[NSString stringWithFormat:@"0%i",seconds/60];
    else
        Minutes=[NSString stringWithFormat:@"%i",seconds/60];
    
    if (seconds%60<10)
        Seconds=[NSString stringWithFormat:@"0%i",seconds%60];
    else
        Seconds=[NSString stringWithFormat:@"%i",seconds%60];
    
    tiempoInputLabel.text = [NSString stringWithFormat:@"%@:%@",Minutes,Seconds];
    
}
#pragma mark - menu principal
-(void)callMenu{
    [self.view bringSubviewToFront:menu];
    [self.view bringSubviewToFront:containerMenu];
    [self.view bringSubviewToFront:menuButton];
    [menu changeState];
}
-(void)irAPlaca{
    [mainScrollView setContentOffset:CGPointMake(mainScrollView.frame.size.width*2, 0) animated:YES];
}
-(void)irAPaginaDeScroll:(int)pagina{
    [mainScrollView setContentOffset:CGPointMake(mainScrollView.frame.size.width*pagina, 0) animated:YES];
}
-(void)bringMenuToFront{
    [self.view setUserInteractionEnabled:YES];
    //[self.view bringSubviewToFront:menu];
    //[self.view bringSubviewToFront:containerMenu];
    //[self.view bringSubviewToFront:menuButton];
}
#pragma mark Calcular
-(void)callCalcular{
    //double distanciaPreliminar;
    CLLocationDistance distanciaPreliminar=[ptoA distanceFromLocation:ptoB];
    routes =[self calculateRoutesFrom:ptoA.coordinate to:ptoB.coordinate];
    if (distanciaPreliminar<120000) {
        [self updateRouteView];
     }
     else{
     routeView.Hidden=YES;
     }
    calcular.metros=distanciaMetros;
    float temp=[taximetro unidadesADinero:distanciaMetros];
    NSLog(@"Este es el valor %f",temp);
    calcular.valueTotalAprox.text=[NSString stringWithFormat:@"$%.0f",temp];
    calcular.valueRecorrido.text=[NSString stringWithFormat:@"%.0f m",distanciaMetros];
    [calcular changeState];
    [self.view bringSubviewToFront:calcular];
}

#pragma mark Alert
-(void)callAlert:(CustomButton*)button{
    [alert changeState];
    [self.view bringSubviewToFront:alert];
    if (button.tag==1) {
        seleccionarAB=1;
        [alert.buttonCancelar removeTarget:self action:@selector(backPaginados:) forControlEvents:UIControlEventTouchUpInside];
        [alert.buttonNo removeTarget:self action:@selector(showAlertMessageView:) forControlEvents:UIControlEventTouchUpInside];
        [alert.buttonSi removeTarget:self action:@selector(pocisionActual) forControlEvents:UIControlEventTouchUpInside];
        [alert.labelMensaje ponerTexto:@"¿Quieres que tu punto de salida sea el lugar donde te encuentras?" fuente:[UIFont fontWithName:kFontType size:32] color:kWhiteColor];
        alert.buttonCancelar.tag=2000;
        [alert.buttonCancelar addTarget:self action:@selector(backPaginados:) forControlEvents:UIControlEventTouchUpInside];
        alert.buttonNo.tag=1;
        [alert.buttonNo addTarget:self action:@selector(showAlertMessageView:) forControlEvents:UIControlEventTouchUpInside];
        [alert.buttonSi addTarget:self action:@selector(pocisionActual) forControlEvents:UIControlEventTouchUpInside];
        
    }
    else if(button.tag==2){
        seleccionarAB=2;
        [alert.buttonCancelar removeTarget:self action:@selector(backPaginados:) forControlEvents:UIControlEventTouchUpInside];
        [alert.buttonNo removeTarget:self action:@selector(showAlertMessageView:) forControlEvents:UIControlEventTouchUpInside];
        [alert.buttonSi removeTarget:self action:@selector(pocisionActual) forControlEvents:UIControlEventTouchUpInside];
        [alert.labelMensaje ponerTexto:@"¿Quieres que tu punto de destino sea el lugar donde te encuentras?" fuente:[UIFont fontWithName:kFontType size:32] color:kWhiteColor];
        alert.buttonCancelar.tag=2001;
        [alert.buttonCancelar addTarget:self action:@selector(backPaginados:) forControlEvents:UIControlEventTouchUpInside];
        alert.buttonNo.tag=2;
        [alert.buttonNo addTarget:self action:@selector(showAlertMessageView:) forControlEvents:UIControlEventTouchUpInside];
        [alert.buttonSi addTarget:self action:@selector(pocisionActual) forControlEvents:UIControlEventTouchUpInside];
    }
}
-(void)backPaginados:(CustomButton*)button{
    NSLog(@"%i", button.tag);
    if (button.tag==2000 && seleccionarAB==2) {
        seleccionarAB=2;
    }
    else if (button.tag==2001 && seleccionarAB==1){
        seleccionarAB=1;
    }
    [alert changeState];
}

-(void)pocisionActual{
    [alert changeState];
    currentLocation = locationManager.location.coordinate;
    MKCoordinateRegion extentsRegion = MKCoordinateRegionMakeWithDistance(currentLocation, 2000, 2000);
    [mapaPaginaDos setRegion:extentsRegion animated:YES];
    CLRegion *newRegion = [[CLRegion alloc] initCircularRegionWithCenter:currentLocation
                                                                  radius:1000.0
                                                              identifier:[NSString stringWithFormat:@"%f, %f", mapaPaginaDos.centerCoordinate.latitude, mapaPaginaDos.centerCoordinate.longitude]];
    if (seleccionarAB==1) {
        ptoA=[[CLLocation alloc] initWithLatitude:currentLocation.latitude longitude:currentLocation.longitude];
        NSString *annotationIdentifier = [annotationA title];
        RegionAnnotationView *regionView = (RegionAnnotationView *)[mapaPaginaDos dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
        regionView = [[RegionAnnotationView alloc] initWithAnnotation:annotationA withcolor:MKPinAnnotationColorRed];
        regionView.map = mapaPaginaDos;
        [annotationA setRegion:newRegion];
        [annotationA setCoordinate:newRegion.center];
        [mapaPaginaDos addAnnotation:annotationA];
    }
    else{
        ptoB=[[CLLocation alloc] initWithLatitude:currentLocation.latitude longitude:currentLocation.longitude];
        NSString *annotationIdentifier = [annotationB title];
        RegionAnnotationView *regionView = (RegionAnnotationView *)[mapaPaginaDos dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
        regionView = [[RegionAnnotationView alloc] initWithAnnotation:annotationB withcolor:MKPinAnnotationColorGreen];
        regionView.map = mapaPaginaDos;
        [annotationB setRegion:newRegion];
        [annotationB setCoordinate:newRegion.center];
        [mapaPaginaDos addAnnotation:annotationB];
    }
    
   
}

#pragma mark - ViewAlertMessage
-(void)crearViewAlertMessage{
    alertMessage=[[AlertMessageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [alertMessage crearView];
    [self.view addSubview:alertMessage];
}
-(void)showAlertMessageView:(CustomButton*)button{
    [alert changeState];
    [alertMessage changeState];
    [self.view bringSubviewToFront:alertMessage];
    if (button.tag==1) {
    alertMessage.tag=100;
    [alertMessage.labelMensaje ponerTexto:@"Ubica cual quieres que sea tu punto de salida tocando un punto en el mapa." fuente:[UIFont fontWithName:kFontType size:32] color:kWhiteColor];
    }
    else if(button.tag==2){
    alertMessage.tag=100;
    [alertMessage.labelMensaje ponerTexto:@"Ubica cual quieres que sea tu punto de destino tocando un punto en el mapa." fuente:[UIFont fontWithName:kFontType size:32] color:kWhiteColor];
    }
    
}
#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
	if([annotation isKindOfClass:[RegionAnnotation class]]) {
		RegionAnnotation *currentAnnotation = (RegionAnnotation *)annotation;
		NSString *annotationIdentifier = [currentAnnotation title];
		RegionAnnotationView *regionView = (RegionAnnotationView *)[mapaPaginaDos dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
        if (!regionView) {
            if (seleccionarAB==1) {
                regionView = [[RegionAnnotationView alloc] initWithAnnotation:annotation withcolor:MKPinAnnotationColorRed];
            }
            else if (seleccionarAB==2){
                regionView = [[RegionAnnotationView alloc] initWithAnnotation:annotation withcolor:MKPinAnnotationColorGreen];
            }
			regionView.map = mapaPaginaDos;
			
			// Create a button for the left callout accessory view of each annotation to remove the annotation and region being monitored.
			UIButton *removeRegionButton = [UIButton buttonWithType:UIButtonTypeCustom];
            removeRegionButton.backgroundColor=kLiteRedColor;
            [removeRegionButton setTitle:@"x" forState:UIControlStateNormal];
			[removeRegionButton setFrame:CGRectMake(0., 0., 25., 25.)];
			
			regionView.leftCalloutAccessoryView = removeRegionButton;
		} else {
			regionView.annotation = annotation;
			regionView.theAnnotation = annotation;
		}
		
		return regionView;
	}
	
	return nil;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState {
	if([annotationView isKindOfClass:[RegionAnnotationView class]]) {
		RegionAnnotationView *regionView = (RegionAnnotationView *)annotationView;
		RegionAnnotation *regionAnnotation = (RegionAnnotation *)regionView.annotation;
		
		// If the annotation view is starting to be dragged, remove the overlay and stop monitoring the region.
		if (newState == MKAnnotationViewDragStateStarting) {
			[locationManager stopMonitoringForRegion:regionAnnotation.region];
		}
		
		// Once the annotation view has been dragged and placed in a new location, update and add the overlay and begin monitoring the new region.
		if (oldState == MKAnnotationViewDragStateDragging && newState == MKAnnotationViewDragStateEnding) {
			
			CLRegion *newRegion = [[CLRegion alloc] initCircularRegionWithCenter:regionAnnotation.coordinate radius:1000.0 identifier:[NSString stringWithFormat:@"%f, %f", regionAnnotation.coordinate.latitude, regionAnnotation.coordinate.longitude]];
			regionAnnotation.region = newRegion;
            
		}
	}
}
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	RegionAnnotationView *regionView = (RegionAnnotationView *)view;
	RegionAnnotation *regionAnnotation = (RegionAnnotation *)regionView.annotation;
	
	// Stop monitoring the region, remove the radius overlay, and finally remove the annotation from the map.
	[locationManager stopMonitoringForRegion:regionAnnotation.region];
	[mapaPaginaDos removeAnnotation:regionAnnotation];
}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    [self updateRouteView];
	routeView.hidden = NO;
    [routeView setNeedsDisplay];
}

- (void)tapGestureHandler:(UITapGestureRecognizer *)tgr{
    NSLog(@"%i", seleccionarAB);
    CGPoint touchPoint = [tgr locationInView:mapaPaginaDos];
    CLLocationCoordinate2D touchMapCoordinate= [mapaPaginaDos convertPoint:touchPoint toCoordinateFromView:mapaPaginaDos];
    CLRegion *newRegion = [[CLRegion alloc] initCircularRegionWithCenter:touchMapCoordinate
                                                                  radius:1000.0
                                                              identifier:[NSString stringWithFormat:@"%f, %f", mapaPaginaDos.centerCoordinate.latitude, mapaPaginaDos.centerCoordinate.longitude]];
    routes = nil;
    [self updateRouteView];
    if (seleccionarAB==1) {
        if ([CLLocationManager regionMonitoringAvailable]) {
            NSString *annotationIdentifier = [annotationA title];
            RegionAnnotationView *regionView = (RegionAnnotationView *)[mapaPaginaDos dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
            
            if (!regionView) {
                NSLog(@"Entroo al 1");
                NSLog(@"%f",touchMapCoordinate.latitude);
                ptoA=[[CLLocation alloc] initWithLatitude:touchMapCoordinate.latitude longitude:touchMapCoordinate.longitude];
                regionView = [[RegionAnnotationView alloc] initWithAnnotation:annotationA withcolor:MKPinAnnotationColorRed];
                regionView.map = mapaPaginaDos;
                [mapaPaginaDos removeAnnotation:annotationA];
                [annotationA setRegion:newRegion];
                [annotationA setCoordinate:newRegion.center];
                [mapaPaginaDos addAnnotation:annotationA];
            }
            [locationManager stopMonitoringForRegion:newRegion];
        }
    }
    else if (seleccionarAB==2){
        if ([CLLocationManager regionMonitoringAvailable]) {
            NSString *annotationIdentifier = [annotationB title];
            RegionAnnotationView *regionView = (RegionAnnotationView *)[mapaPaginaDos dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
            
            if (!regionView) {
                NSLog(@"Entroo al 2");
                NSLog(@"%f",touchMapCoordinate.latitude);
                ptoB=[[CLLocation alloc] initWithLatitude:touchMapCoordinate.latitude longitude:touchMapCoordinate.longitude];
                regionView = [[RegionAnnotationView alloc] initWithAnnotation:annotationB withcolor:MKPinAnnotationColorGreen];
                regionView.map = mapaPaginaDos;
                [mapaPaginaDos removeAnnotation:annotationB];
                [annotationB setRegion:newRegion];
                [annotationB setCoordinate:newRegion.center];
                [mapaPaginaDos addAnnotation:annotationB];
           }
            [locationManager stopMonitoringForRegion:newRegion];
        }
        
    }
    
}
#pragma mark decodificacion
-(NSMutableArray *)decodePolyLine: (NSMutableString *)encoded {
	[encoded replaceOccurrencesOfString:@"\\\\" withString:@"\\"
								options:NSLiteralSearch
								  range:NSMakeRange(0, [encoded length])];
	NSInteger len = [encoded length];
	NSInteger index = 0;
	NSMutableArray *array = [[NSMutableArray alloc] init];
	NSInteger lat=0;
	NSInteger lng=0;
    banderaU = NO;
    distanciaMetros = 0;
	while (index < len) {
		NSInteger b;
		NSInteger shift = 0;
		NSInteger result = 0;
		do {
			b = [encoded characterAtIndex:index++] - 63;
			result |= (b & 0x1f) << shift;
			shift += 5;
		} while (b >= 0x20);
		NSInteger dlat = ((result & 1) ? ~(result >> 1) : (result >> 1));
		lat += dlat;
		shift = 0;
		result = 0;
		do {
			b = [encoded characterAtIndex:index++] - 63;
			result |= (b & 0x1f) << shift;
			shift += 5;
		} while (b >= 0x20);
		NSInteger dlng = ((result & 1) ? ~(result >> 1) : (result >> 1));
		lng += dlng;
		NSNumber *latitude = [[NSNumber alloc] initWithFloat:lat * 1e-5];
		NSNumber *longitude = [[NSNumber alloc] initWithFloat:lng * 1e-5];
		CLLocation *loc = [[CLLocation alloc] initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]];
        
        ////////
        locationOne.latitude = loc.coordinate.latitude;
        locationOne.longitude = loc.coordinate.longitude;
        if (banderaU) {
            locationOne.latitude= locationPast.latitude;
            locationOne.longitude= locationPast.longitude;
        }
        locationTwo.latitude=loc.coordinate.latitude;
        locationTwo.longitude=loc.coordinate.longitude;
        
        
        CLLocation *pointALocation = [[CLLocation alloc] initWithLatitude:locationTwo.latitude longitude:locationTwo.longitude];
        CLLocation *pointBLocation = [[CLLocation alloc] initWithLatitude:locationOne.latitude longitude:locationOne.longitude];
        distanciaMetros += [pointALocation getDistanceFrom:pointBLocation];
        //NSLog(@"Distancia metros %f",distanciaMetros);
        
        locationPast.latitude=locationTwo.latitude;
        locationPast.longitude=locationTwo.longitude;
        locationOne.latitude=locationPast.latitude;
        locationOne.longitude=locationPast.longitude;
        banderaU = YES;
		[array addObject:loc];
	}
	return array;
}

#pragma mark calcular ruta
-(NSArray*) calculateRoutesFrom:(CLLocationCoordinate2D) f to: (CLLocationCoordinate2D) t {
    /* UIActivityIndicatorView *myIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
     myIndicator.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
     myIndicator.hidesWhenStopped = NO;
     [self.view addSubview:myIndicator];
     [myIndicator startAnimating];*/
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	NSString* saddr = [NSString stringWithFormat:@"%f,%f", f.latitude, f.longitude];
	NSString* daddr = [NSString stringWithFormat:@"%f,%f", t.latitude, t.longitude];
	
	NSString* apiUrlStr = [NSString stringWithFormat:@"http://maps.google.com/maps?output=dragdir&saddr=%@&daddr=%@", saddr, daddr];
	NSURL* apiUrl = [NSURL URLWithString:apiUrlStr];
	NSString *apiResponse = [NSString stringWithContentsOfURL:apiUrl];
	NSString* encodedPoints = [apiResponse stringByMatching:@"points:\\\"([^\\\"]*)\\\"" capture:1];
	//NSLog(@" Puntos decodificados = %@",[self decodePolyLine:[encodedPoints mutableCopy]]);
    //printf("Lista la DECOOO00000\n");
    //NSLog(@"Terminada la decodificación");
    //[self delayer];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
	return [self decodePolyLine:[encodedPoints mutableCopy]];
}

#pragma mark mostrar ruta
-(void) updateRouteView {
    
    routeView.Hidden=NO;
	CGContextRef context = 	CGBitmapContextCreate(nil,
												  routeView.frame.size.width,
												  routeView.frame.size.height,
												  8,
												  4 * routeView.frame.size.width,
												  CGColorSpaceCreateDeviceRGB(),
												  kCGImageAlphaPremultipliedLast);
    
    
	for(int i = 0; i < routes.count; i++) {
        lineColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5];
        CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
        CGContextSetLineWidth(context, 3.0);
		CLLocation* location = [routes objectAtIndex:i];
		CGPoint point = [mapaPaginaDos convertCoordinate:location.coordinate toPointToView:routeView];
		
		if(i == 0) {
			CGContextMoveToPoint(context, point.x, routeView.frame.size.height - point.y);
		} else {
			CGContextAddLineToPoint(context, point.x, routeView.frame.size.height - point.y);
		}
        //CGContextBeginPath(context);
	}
	
    CGContextStrokePath(context);
    
	
	CGImageRef image = CGBitmapContextCreateImage(context);
	UIImage* img = [UIImage imageWithCGImage:image];
	
	routeView.image = img;
	CGContextRelease(context);
}

#pragma mark - dismiss keyboard
-(void)dismissKeyboard{
    [placa resignFirstResponder];
    tecladoUp=NO;
    [self animarViewPorTeclado];
}
/*-(void)zoomMapView{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    mapaPaginaDos.frame=CGRectMake(0, 100, viewWidth, viewHeight);
    [UIView commitAnimations];
}*/
#pragma mark - textfield delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    tecladoUp=YES;
    [self animarViewPorTeclado];
    [self animarView:footer ConOpacidad:0];
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    tecladoUp=NO;
    [self animarViewPorTeclado];
    textField.text=[[[textField.text uppercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"." withString:@""];
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self dismissKeyboard];
    BOOL *resultado= [self checkPlaca:placa.text];
    if ([placa.text isEqual:@""] || resultado==NO) {
        [self animarView:footer ConOpacidad:1];
    }
    else{
        ConsultarPlacaViewController *cPVC=[[ConsultarPlacaViewController alloc]init];
        
        //[cPVC.self consultarPlaca];
        cPVC=[self.storyboard instantiateViewControllerWithIdentifier:@"ConsultarPlaca"];
        
        cPVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        cPVC.stringPlaca=placa.text;
        [cPVC.self consutar];
        [self presentModalViewController:cPVC animated:YES];
    }
    return YES;
    
}

#pragma mark - scroll delegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self dismissKeyboard];
}
#pragma mark - actions
-(void)goTo:(CustomButton*)button{
    if ([button.titleLabel.text isEqualToString:@"Taxímetro Manual"]) {
        TaximetroManualViewController *mVC=[[TaximetroManualViewController alloc]init];
        mVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
        mVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentModalViewController:mVC animated:YES];
        //[menu changeState];
    }
    else if ([button.titleLabel.text isEqualToString:@"Taxímetro GPS"]){
        [self irAPaginaDeScroll:0];
        [menu changeState];
    }
    else if ([button.titleLabel.text isEqualToString:@"Calcular"]){
        [self irAPaginaDeScroll:1];
        [menu changeState];
    }
    else if ([button.titleLabel.text isEqualToString:@"Enviar Placa"]){
        [self irAPaginaDeScroll:2];
        [menu changeState];
    }
    else if ([button.titleLabel.text isEqualToString:@"Llamadas"]) {
        LlamadasViewController *lVC=[[LlamadasViewController alloc]init];
        lVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Llamadas"];
        lVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentModalViewController:lVC animated:YES];
        //[menu changeState];
    }
    else if ([button.titleLabel.text isEqualToString:@"Opciones"]) {
        OpcionesViewController *oVC=[[OpcionesViewController alloc]init];
        oVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Opciones"];
        oVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentModalViewController:oVC animated:YES];
        //[menu changeState];
    }
}
-(void)encenderTaximetro:(CustomSwitch*)customSwitch{
    if (customSwitch.isOn) {
        seconds=0;
        tiempoInputLabel.text=@"00:00";
        labelEncender.text=@"Apagar";

        [arregloDePuntos removeAllObjects];
        arregloDePuntos=nil;
        arregloDePuntos=[[NSMutableArray alloc]init];
        [locManager startUpdatingLocation];
        [self animarView:buttonAlert ConOpacidad:1];
        [self irAPaginaDeScroll:2];
        [self clockStart];
    }
    else{
        labelEncender.text=@"Encender";
        [locManager stopUpdatingLocation];
        [self animarView:buttonAlert ConOpacidad:0];
        //[self irAPaginaDeScroll:0];
        [self clockStop];
    }
}
#pragma mark location
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)location fromLocation:(CLLocation *)oldLocation{

    if (switchEncender.isOn) {
        zoomLocation.latitude = location.coordinate.latitude;
        zoomLocation.longitude = location.coordinate.longitude;
        if (banderaLocation) {
            zoomLocation.latitude=zoomLocationPast.latitude;
            zoomLocation.longitude=zoomLocationPast.longitude;
        }
        zoomLocation2.latitude = location.coordinate.latitude;
        zoomLocation2.longitude = location.coordinate.longitude;
        
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation,
                                                                           0.5*METERS_PER_MILE,
                                                                           0.5*METERS_PER_MILE);
        MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];
        [mapView setRegion:adjustedRegion animated:YES];
        CLLocation *pointALocation = [[CLLocation alloc] initWithLatitude:zoomLocation2.latitude longitude:zoomLocation2.longitude];
        CLLocation *pointBLocation = [[CLLocation alloc] initWithLatitude:zoomLocation.latitude longitude:zoomLocation.longitude];
        //double distanciaMetros = [pointALocation getDistanceFrom:pointBLocation];
        double distanciaMetros = [pointALocation distanceFromLocation:pointBLocation];

        double distanciaKm=distanciaMetros/1000;
        
        zoomLocationPast.latitude=zoomLocation2.latitude;
        zoomLocationPast.longitude=zoomLocation2.longitude;
        zoomLocation.latitude=zoomLocationPast.latitude;
        zoomLocation.longitude=zoomLocationPast.longitude;
        
        if (distanciaKm>0.001) {
            [arregloDePuntos addObject:[NSNumber numberWithDouble:distanciaMetros]];
            [coordenadasParaDibujar addObject:pointALocation];
            [coordenadasParaDibujar addObject:pointBLocation];
        }
        
        banderaLocation = YES;
        [self contarMetros];
    }
    else{
    }
    //[NSThread detachNewThreadSelector: @selector(updateRouteView) toTarget:self withObject:NULL];
    

}
#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}
-(NSString *)contarMetros{
    float metros=0;
    //int unidades=0;
    //float adicional=0;
    metros=[Taximetro medidorDeMetrosRecorridos:arregloDePuntos];
    labelMetros.text= [NSString stringWithFormat:@"%.1f m",metros];
    
    return @"";
}
/*#pragma mark map delegate
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    if (!switchEncender.isOn) {

    }
	else{
        
    }

}*/
@end
