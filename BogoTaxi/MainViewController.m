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
    [self crearPaginaTres];
    [self crearInterfazSuperior];
    backgroundColor=self.view.backgroundColor;
    [paginaUnoContainer bringSubviewToFront:containerConfig];
    [self crearMenu];
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
    mapView=[[MKMapView alloc]initWithFrame:CGRectMake(0, -100, self.view.frame.size.width, 100)];
    [self.view addSubview:mapView];
    containerSuperior=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 126)];
    containerSuperior.backgroundColor=[UIColor grayColor];
    [self.view addSubview:containerSuperior];
    
    barraSuperior=[[UIView alloc]initWithFrame:CGRectMake(0, 0, containerSuperior.frame.size.width, 37)];
    barraSuperior.backgroundColor=[UIColor darkGrayColor];
    [containerSuperior addSubview:barraSuperior];
    botonBarraSuperior=[UIButton buttonWithType:UIButtonTypeCustom];
    animationFinished=NO;
    [botonBarraSuperior addTarget:self action:@selector(startAnimationSequence) forControlEvents:UIControlEventTouchUpInside];
    [botonBarraSuperior setTitle:@"Mapa" forState:UIControlStateNormal];
    [botonBarraSuperior setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [botonBarraSuperior setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];

    botonBarraSuperior.titleLabel.font=[UIFont fontWithName:kFontType size:20];
    botonBarraSuperior.backgroundColor=kLiteRedColor;
    botonBarraSuperior.frame=CGRectMake(containerSuperior.frame.size.width-96, 6, 81, 25);
    [barraSuperior addSubview:botonBarraSuperior];
    
    valorLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(25, 7, 120, 20)];
    [valorLabel ponerTexto:@"Valor Total:" fuente:[UIFont fontWithName:kFontType size:20] color:[UIColor whiteColor]];
    [valorLabel setOverlayOff:YES];
    [barraSuperior addSubview:valorLabel];
    
    valorInputLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(100, 4, 150, 30)];
    [valorInputLabel ponerTexto:@"$99.900" fuente:[UIFont fontWithName:kFontType size:30] color:kDarkRedColor];
    [valorInputLabel setOverlayOff:YES];
    [barraSuperior addSubview:valorInputLabel];
    
    containerSuperiorInferior=[[UIView alloc]initWithFrame:CGRectMake(0, barraSuperior.frame.size.height, containerSuperior.frame.size.width, containerSuperior.frame.size.height-barraSuperior.frame.size.height)];
    containerSuperiorInferior.backgroundColor=[UIColor whiteColor];
    containerSuperiorInferior.layer.shadowColor = [[UIColor colorWithWhite:0.1 alpha:1] CGColor];
    containerSuperiorInferior.layer.shadowOffset = CGSizeMake(0.0f,1.0f);
    containerSuperiorInferior.layer.shadowRadius = 1;
    containerSuperiorInferior.layer.shadowOpacity = 0.3;
    [containerSuperior addSubview:containerSuperiorInferior];
    
    containerInfoTaximetro=[[UIView alloc]initWithFrame:CGRectMake(15, 15.5, 135, 60)];
    containerInfoTaximetro.backgroundColor=[UIColor darkGrayColor];
    [containerSuperiorInferior addSubview:containerInfoTaximetro];
    
    
    containerTiempo=[[UIView alloc]initWithFrame:CGRectMake(137+15, 15.5, 70, 60)];
    containerTiempo.backgroundColor=[UIColor darkGrayColor];
    [containerSuperiorInferior addSubview:containerTiempo];
    
    tiempoLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, containerTiempo.frame.size.width, 30)];
    [tiempoLabel ponerTexto:@"Tiempo" fuente:[UIFont fontWithName:kFontType size:22] color:kYellowColor];
    [tiempoLabel setCentrado:YES];
    [tiempoLabel setOverlayOff:YES];
    [containerTiempo addSubview:tiempoLabel];
    tiempoInputLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 28, containerTiempo.frame.size.width, 30)];
    [tiempoInputLabel ponerTexto:@"00:00" fuente:[UIFont fontWithName:kFontType size:22] color:[UIColor whiteColor]];
    [tiempoInputLabel setCentrado:YES];
    [tiempoInputLabel setOverlayOff:YES];
    [containerTiempo addSubview:tiempoInputLabel];

    
    UIView *infoTaximetroOverlay=[[UIView alloc]initWithFrame:CGRectMake(3, 3, containerInfoTaximetro.frame.size.width-5, containerInfoTaximetro.frame.size.height-5)];
    infoTaximetroOverlay.backgroundColor=[UIColor whiteColor];
    infoTaximetroOverlay.alpha=0.08;
    [containerInfoTaximetro addSubview:infoTaximetroOverlay];
    
    labelEncender=[[CustomLabel alloc]initWithFrame:CGRectMake(5, 8, 80, 23)];
    [labelEncender ponerTexto:@"Encender" fuente:[UIFont fontWithName:kFontType size:22] color:kYellowColor];
    [labelEncender setOverlayOff:YES];
    [containerInfoTaximetro addSubview:labelEncender];
    
    labelRecorrido=[[CustomLabel alloc]initWithFrame:CGRectMake(5, 33, 80, 20)];
    [labelRecorrido ponerTexto:@"Recorrido" fuente:[UIFont fontWithName:kFontType size:22] color:kYellowColor];
    [labelRecorrido setOverlayOff:YES];
    [containerInfoTaximetro addSubview:labelRecorrido];
    
    switchEncender=[[CustomSwitch alloc]initWithFrame:CGRectMake(75, 8, 0, 0)];
    [switchEncender addTarget:self action:@selector(encenderTaximetro:)];
    [containerInfoTaximetro addSubview:switchEncender];
    
    labelMetros=[[CustomLabel alloc]initWithFrame:CGRectMake(78, 34, 80, 20)];
    [labelMetros ponerTexto:@"4.4 metros" fuente:[UIFont fontWithName:kFontType size:14] color:[UIColor whiteColor]];
    [labelMetros setOverlayOff:YES];
    [containerInfoTaximetro addSubview:labelMetros];
    
    containerUnidades=[[UIView alloc]initWithFrame:CGRectMake(15+206+3, 15.5, 81, 60)];
    containerUnidades.backgroundColor=[UIColor darkGrayColor];
    [containerSuperiorInferior addSubview:containerUnidades];
    UIView *containerUnidadesOverlay=[[UIView alloc]initWithFrame:CGRectMake(3, 3, containerUnidades.frame.size.width-5, containerUnidades.frame.size.height-5)];
    containerUnidadesOverlay.backgroundColor=[UIColor whiteColor];
    containerUnidadesOverlay.alpha=0.08;
    //[containerUnidades addSubview:containerUnidadesOverlay];
    UIView *containerBotonesUnidades=[[UIView alloc]initWithFrame:CGRectMake(0, containerUnidades.frame.size.height-20, containerUnidades.frame.size.width, 20)];
    containerBotonesUnidades.backgroundColor=[UIColor darkGrayColor];
    [containerUnidades addSubview:containerBotonesUnidades];
    UIButton *botonMenos=[UIButton buttonWithType:UIButtonTypeCustom];
    [botonMenos addTarget:self action:@selector(startAnimationSequence) forControlEvents:UIControlEventTouchUpInside];
    botonMenos.frame=CGRectMake(0, 0, (containerBotonesUnidades.frame.size.width/2)-0.5, containerBotonesUnidades.frame.size.height);
    [botonMenos setTitle:@"-" forState:UIControlStateNormal];
    botonMenos.titleLabel.font=[UIFont  boldSystemFontOfSize:15];
    botonMenos.backgroundColor=[UIColor grayColor];
    [containerBotonesUnidades addSubview:botonMenos];
    
    UIButton *botonMas=[UIButton buttonWithType:UIButtonTypeCustom];
    [botonMas addTarget:self action:@selector(startAnimationSequence) forControlEvents:UIControlEventTouchUpInside];
    botonMas.frame=CGRectMake((containerBotonesUnidades.frame.size.width/2)+0.5, 0, (containerBotonesUnidades.frame.size.width/2)-0.5, containerBotonesUnidades.frame.size.height);
    [botonMas setTitle:@"+" forState:UIControlStateNormal];
    botonMas.titleLabel.font=[UIFont  boldSystemFontOfSize:15];
    botonMas.backgroundColor=[UIColor grayColor];
    [containerBotonesUnidades addSubview:botonMas];
    
    labelUnidades=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, containerUnidades.frame.size.width-10, containerUnidades.frame.size.height-20)];
    labelUnidades.center=CGPointMake(containerUnidades.frame.size.width/2, (containerUnidades.frame.size.height/2)-8);
    labelUnidades.textAlignment=UITextAlignmentCenter;
    [labelUnidades ponerTexto:@"25" fuente:[UIFont fontWithName:kFontType size:40] color:kDarkRedColor];
    [labelUnidades setOverlayOff:YES];
    [containerUnidades addSubview:labelUnidades];
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
    
    containerMenu=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 120, 100)];
    containerMenu.backgroundColor=kDarkRedColor;
    containerMenu.layer.shouldRasterize=YES;
    containerMenu.center=CGPointMake(0, self.view.frame.size.height);
    CGAffineTransform rotarCuadrado = CGAffineTransformMakeRotation(1.57079633/2.1);
    containerMenu.transform = rotarCuadrado;
    
    menuButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [menuButton addTarget:self action:@selector(callMenu) forControlEvents:UIControlEventTouchUpInside];
    [menuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [menuButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
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
    paginaUnoContainer.backgroundColor=[UIColor clearColor];
    [mainScrollView addSubview:paginaUnoContainer];
    
    BannerView *bannerView=[[BannerView alloc]initWithFrame:CGRectMake(0, 0, mainScrollView.frame.size.width-20, 0)];
    [bannerView ponerTexto:@"CONFIGURACIÓN"];
    bannerView.center=CGPointMake(mainScrollView.frame.size.width/2, 50);
    [paginaUnoContainer addSubview:bannerView];
    
    configTituloLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-20, 30)];
    
    configTituloLabel.center=CGPointMake(paginaUnoContainer.frame.size.width/2, 104);
    if (deviceKind==2) {
        configTituloLabel.center=CGPointMake(paginaUnoContainer.frame.size.width/2, 124);
    }
    [configTituloLabel ponerTexto:@"CONFIGURA TU TAXÍMETRO" fuente:[UIFont fontWithName:kFontType size:30] color:kTitleBlueColor];
    [configTituloLabel setCentrado:YES];
    [paginaUnoContainer addSubview:configTituloLabel];
    
    containerConfig=[[UIView alloc]initWithFrame:CGRectMake(10, bannerView.frame.size.height+configTituloLabel.frame.size.height+5,paginaUnoContainer.frame.size.width-20, 160)];
    
    if (deviceKind==2) {
        containerConfig.frame=CGRectMake(10, bannerView.frame.size.height+configTituloLabel.frame.size.height+45, paginaUnoContainer.frame.size.width-20, 160);
    }
    
    containerConfig.backgroundColor=[UIColor darkGrayColor];
    containerConfig.layer.cornerRadius=3;
    [paginaUnoContainer addSubview:containerConfig];
    
    int margenLabels=10;
    nocDomFesLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(margenLabels, 10, 130, 20)];
    [nocDomFesLabel ponerTexto:@"Noc-Dom-Fes" fuente:[UIFont fontWithName:kFontType size:25] color:[UIColor whiteColor]];
    [nocDomFesLabel setOverlayOff:YES];
    [containerConfig addSubview:nocDomFesLabel];
    
    nocDomFesSwitch=[[CustomSwitch alloc]initWithFrame:CGRectMake(containerConfig.frame.size.width-60, 8, 0, 0)];
    
    [nocDomFesSwitch addTarget:self action:@selector(animacionNoche:)];
    
    [containerConfig addSubview:nocDomFesSwitch];
    
    aeropuertoLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(margenLabels, 50, 130, 20)];
    [aeropuertoLabel ponerTexto:@"Aeropuerto" fuente:[UIFont fontWithName:kFontType size:25] color:[UIColor whiteColor]];
    [aeropuertoLabel setOverlayOff:YES];
    [containerConfig addSubview:aeropuertoLabel];
    
    aeropuertoSwitch=[[CustomSwitch alloc]initWithFrame:CGRectMake(containerConfig.frame.size.width-60, 48, 0, 0)];
    [containerConfig addSubview:aeropuertoSwitch];
    
    puertaApuertaLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(margenLabels, 90, 130, 20)];
    [puertaApuertaLabel ponerTexto:@"Puerta a puerta" fuente:[UIFont fontWithName:kFontType size:25] color:[UIColor whiteColor]];
    [puertaApuertaLabel setOverlayOff:YES];
    [containerConfig addSubview:puertaApuertaLabel];
    
    puertaApuertaSwitch=[[CustomSwitch alloc]initWithFrame:CGRectMake(containerConfig.frame.size.width-60, 88, 0, 0)];
    [containerConfig addSubview:puertaApuertaSwitch];
    
    terminalLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(margenLabels, 130, 130, 20)];
    [terminalLabel ponerTexto:@"Terminal" fuente:[UIFont fontWithName:kFontType size:25] color:[UIColor whiteColor]];
    [terminalLabel setOverlayOff:YES];
    [containerConfig addSubview:terminalLabel];
    
    terminalSwitch=[[CustomSwitch alloc]initWithFrame:CGRectMake(containerConfig.frame.size.width-60, 128, 0, 0)];
    [containerConfig addSubview:terminalSwitch];
    
    UIView *containerValoresYTiempo=[[UIView alloc]initWithFrame:CGRectMake(0, 0, paginaUnoContainer.frame.size.width-20, 40)];
    containerValoresYTiempo.backgroundColor=[UIColor clearColor];
    containerValoresYTiempo.center=CGPointMake(paginaUnoContainer.frame.size.width/2, (bannerView.frame.size.height+configTituloLabel.frame.size.height+containerConfig.frame.size.height+10)+(containerValoresYTiempo.frame.size.height/2));
    [paginaUnoContainer addSubview:containerValoresYTiempo];
    
    CustomButton *botonEnviarPlaca=[[CustomButton alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    botonEnviarPlaca.center=CGPointMake(paginaUnoContainer.frame.size.width-10-(botonEnviarPlaca.frame.size.width/2), paginaUnoContainer.frame.size.height-(botonEnviarPlaca.frame.size.height/2)-8);
    [botonEnviarPlaca setTitle:@"Enviar Placa" forState:UIControlStateNormal];
    [botonEnviarPlaca addTarget:self action:@selector(irAPlaca) forControlEvents:UIControlEventTouchUpInside];
    [paginaUnoContainer addSubview:botonEnviarPlaca];
    
}

#pragma mark - pagina dos
-(void)crearPaginaDos{
    paginaDos=[[UIView alloc]initWithFrame:CGRectMake(mainScrollView.frame.size.width*1, 0, mainScrollView.frame.size.width, mainScrollView.frame.size.height)];
    paginaDos.backgroundColor=[UIColor clearColor];
    [mainScrollView addSubview:paginaDos];
    
    bannerPaginaDos=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, paginaDos.frame.size.width-20, 50)];
    bannerPaginaDos.center=CGPointMake(paginaDos.frame.size.width/2, 25);
    [bannerPaginaDos ponerTexto:@"CALCULAR" fuente:[UIFont fontWithName:kFontType size:40] color:kTitleBlueColor];
    [bannerPaginaDos setCentrado:YES];
    [paginaDos addSubview:bannerPaginaDos];
    
    containerBotonesPaginaDos=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 215, 30)];
    containerBotonesPaginaDos.center=CGPointMake(paginaDos.frame.size.width/2, 60);
    containerBotonesPaginaDos.layer.cornerRadius=3;
    containerBotonesPaginaDos.backgroundColor=kBeigeColor;
    [paginaDos addSubview:containerBotonesPaginaDos];
    UIView *separador=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, containerBotonesPaginaDos.frame.size.height-5)];
    separador.center=CGPointMake(containerBotonesPaginaDos.frame.size.width/2, containerBotonesPaginaDos.frame.size.height/2);
    separador.backgroundColor=[UIColor grayColor];
    [containerBotonesPaginaDos addSubview:separador];
    
    botonSalida=[UIButton buttonWithType:UIButtonTypeCustom];
    botonSalida.frame=CGRectMake(10, 5, 60, 20);
    botonSalida.titleLabel.font=[UIFont fontWithName:kFontType size:20];
    [botonSalida setTitle:@"Salida" forState:UIControlStateNormal];
    [botonSalida setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [botonSalida setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [containerBotonesPaginaDos addSubview:botonSalida];
    ledSalida=[[UIView alloc]initWithFrame:CGRectMake(80, 7.5, 15, 15)];
    ledSalida.center=CGPointMake((containerBotonesPaginaDos.frame.size.width/2)-20, containerBotonesPaginaDos.frame.size.height/2);
    ledSalida.backgroundColor=kLiteRedColor;
    ledSalida.layer.cornerRadius=ledSalida.frame.size.width/2;
    [containerBotonesPaginaDos addSubview:ledSalida];
    
    botonDestino=[UIButton buttonWithType:UIButtonTypeCustom];
    botonDestino.frame=CGRectMake(containerBotonesPaginaDos.frame.size.width-70, 5, 60, 20);
    botonDestino.titleLabel.font=[UIFont fontWithName:kFontType size:20];
    [botonDestino setTitle:@"Destino" forState:UIControlStateNormal];
    [botonDestino setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [botonDestino setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [containerBotonesPaginaDos addSubview:botonDestino];
    ledDestino=[[UIView alloc]initWithFrame:CGRectMake(120, 7.5, 15, 15)];
    ledDestino.center=CGPointMake((containerBotonesPaginaDos.frame.size.width/2)+20, containerBotonesPaginaDos.frame.size.height/2);

    ledDestino.backgroundColor=kGreenColor;
    ledDestino.layer.cornerRadius=ledSalida.frame.size.width/2;
    [containerBotonesPaginaDos addSubview:ledDestino];
    
    mapaPaginaDos=[[MKMapView alloc]initWithFrame:CGRectMake(10, bannerPaginaDos.frame.size.height+configTituloLabel.frame.size.height+5, paginaUnoContainer.frame.size.width-20, 195)];
    if (self.view.frame.size.height>480) {
        mapaPaginaDos.frame=CGRectMake(10, bannerPaginaDos.frame.size.height+configTituloLabel.frame.size.height+5, paginaUnoContainer.frame.size.width-20, 280);
    }
    mapaPaginaDos.layer.cornerRadius=3;
    [paginaDos addSubview:mapaPaginaDos];
    botonCalcular=[[CustomButton alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    botonCalcular.center=CGPointMake(paginaUnoContainer.frame.size.width-10-(botonCalcular.frame.size.width/2), paginaDos.frame.size.height-(botonCalcular.frame.size.height/2)-8);
    [botonCalcular setTitle:@"Calcular" forState:UIControlStateNormal];
    [paginaDos addSubview:botonCalcular];
    
    
}
#pragma mark - pagina tres
-(void)crearPaginaTres{
    paginaTres=[[UIView alloc]initWithFrame:CGRectMake(mainScrollView.frame.size.width*2, 0, mainScrollView.frame.size.width, mainScrollView.frame.size.height)];
    paginaTres.backgroundColor=[UIColor clearColor];
    [mainScrollView addSubview:paginaTres];
    
    bannerPaginaTres=[[BannerView alloc]initWithFrame:CGRectMake(0, 0, mainScrollView.frame.size.width-20, 0)];
    [bannerPaginaTres ponerTexto:@"ENVÍA TU PLACA"];
    bannerPaginaTres.center=CGPointMake(mainScrollView.frame.size.width/2, 50);
    [paginaTres addSubview:bannerPaginaTres];
    
    containerPlacaPaginaTres=[[UIView alloc]initWithFrame:CGRectMake(10, bannerPaginaTres.frame.size.height+5,paginaTres.frame.size.width-20, 190)];
    
    if (deviceKind==2) {
        containerPlacaPaginaTres.frame=CGRectMake(10, bannerPaginaTres.frame.size.height+45, paginaTres.frame.size.width-20, 190);
    }
    
    containerPlacaPaginaTres.backgroundColor=[UIColor darkGrayColor];
    containerPlacaPaginaTres.layer.cornerRadius=3;
    [paginaTres addSubview:containerPlacaPaginaTres];
    footer=[[CustomLabel alloc]initWithFrame:CGRectMake(10, containerPlacaPaginaTres.frame.size.height-50, containerPlacaPaginaTres.frame.size.width-20, 40)];
    //footer.backgroundColor=kYellowColor;
    [footer ponerTexto:@"Envía la placa a la red social que elijas, o consulta el historial del taxi en Denuncie Al Taxista." fuente:[UIFont fontWithName:kFontType size:15] color:kWhiteColor];
    footer.numberOfLines=3;
    [footer setCentrado:YES];
    [footer setOverlayOff:YES];
    [containerPlacaPaginaTres addSubview:footer];
    
    UIView *placaContainer=[[UIView alloc]initWithFrame:CGRectMake(30, 20, containerPlacaPaginaTres.frame.size.width-60, 90)];
    placaContainer.backgroundColor=kYellowColor;
    [containerPlacaPaginaTres addSubview:placaContainer];
    placa=[[UITextField alloc]initWithFrame:CGRectMake(10, 5, placaContainer.frame.size.width-20, placaContainer.frame.size.height-10)];
    placa.backgroundColor=[UIColor clearColor];
    placa.placeholder=@"#PLACA";
    placa.delegate=self;
    placa.font=[UIFont fontWithName:kFontType size:70];
    placa.textAlignment=UITextAlignmentCenter;
    placa.autocorrectionType=UITextAutocorrectionTypeNo;
    placa.autocapitalizationType=UITextAutocapitalizationTypeAllCharacters;
    placa.textColor=kDarkGrayColor;
    [placaContainer addSubview:placa];
    
    botonEnviarRedes=[[CustomButton alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    botonEnviarRedes.center=CGPointMake(paginaTres.frame.size.width-10-(botonEnviarRedes.frame.size.width/2), paginaTres.frame.size.height-(botonEnviarRedes.frame.size.height/2)-8);
    [botonEnviarRedes setTitle:@"Enviar" forState:UIControlStateNormal];
    [botonEnviarRedes setTitleColor:kGrayColor forState:UIControlStateNormal];
    [botonEnviarRedes setTitleColor:kDarkGrayColor forState:UIControlStateHighlighted];
    [paginaTres addSubview:botonEnviarRedes];
    
    botonEnviarDenuncie=[[CustomButton alloc]initWithFrame:CGRectMake(0, 0, 140, 40)];
    botonEnviarDenuncie.center=CGPointMake(paginaTres.frame.size.width-30-(botonEnviarDenuncie.frame.size.width), paginaTres.frame.size.height-(botonEnviarRedes.frame.size.height/2)-8);
    [botonEnviarDenuncie setTitle:@"Denuncie Al Taxista" forState:UIControlStateNormal];
    [botonEnviarDenuncie setTitleColor:kGrayColor forState:UIControlStateNormal];
    [botonEnviarDenuncie setTitleColor:kDarkGrayColor forState:UIControlStateHighlighted];
    [paginaTres addSubview:botonEnviarDenuncie];


    
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
        self.view.frame=CGRectMake(0, -100, viewWidth, viewHeight);
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
        mapView.frame=CGRectMake(0,0, self.view.frame.size.width, 1);
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
            containerSuperior.frame=CGRectMake(0,self.view.frame.size.height-170, self.view.frame.size.width, 126);
            mapView.frame=CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height-170);
        }
        else if (counter==2){
            containerSuperior.frame=CGRectMake(0,self.view.frame.size.height-126, self.view.frame.size.width, 126);
            mapView.frame=CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height-126);
        }
        else if (counter==3){
            containerSuperior.frame=CGRectMake(0,self.view.frame.size.height-130, self.view.frame.size.width, 126);
            mapView.frame=CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height-130);
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
    [self.view bringSubviewToFront:menu];
    [self.view bringSubviewToFront:containerMenu];
    [self.view bringSubviewToFront:menuButton];
}
#pragma mark - dismiss keyboard
-(void)dismissKeyboard{
    [placa resignFirstResponder];
    tecladoUp=NO;
    [self animarViewPorTeclado];
}
#pragma mark - textfield delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    tecladoUp=YES;
    [self animarViewPorTeclado];
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    tecladoUp=NO;
    [self animarViewPorTeclado];
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self dismissKeyboard];
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
        
        [self irAPaginaDeScroll:2];
        [self clockStart];
    }
    else{
        labelEncender.text=@"Encender";
        [locManager stopUpdatingLocation];
        [self irAPaginaDeScroll:0];
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
-(NSString *)contarMetros{
    float metros=0;
    int unidades=0;
    float adicional=0;
    metros=[Taximetro medidorDeMetrosRecorridos:arregloDePuntos];
    labelMetros.text= [NSString stringWithFormat:@"%.1f m",metros];
    
    return @"";
}
#pragma mark map delegate
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    if (!switchEncender.isOn) {

    }
	else{
        
    }

}
@end
