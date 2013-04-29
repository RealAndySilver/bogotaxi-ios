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
@synthesize lastAcceleration, shakeDetected, geoCoder;

-(void)viewWillAppear:(BOOL)animated {
    Modelador *obj=[[Modelador alloc]init];
    
    if ([[obj getNumeroEmergencia] length]>2) {
        [self animarView:buttonCallUser ConOpacidad:1];
    }
    else{
        [self animarView:buttonCallUser ConOpacidad:0];
    }
    if (![obj getNumero123]) {
        [obj setNumero123:1];
    }
    else if ([[obj getNumero123] isEqualToString:@"1"]) {
        [self animarView:buttonEmergencyCall ConOpacidad:1];
    }
    else if([[obj getNumero123] isEqualToString:@"0"]){
        [self animarView:buttonEmergencyCall ConOpacidad:0];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=kBlueColor;
    CustomLabel *labelHechoPor=[[CustomLabel alloc]initWithFrame:CGRectMake(0,0, 100, 30)];
    labelHechoPor.center=CGPointMake(15, self.view.frame.size.height/2);
    [labelHechoPor ponerTexto:@"Creado por" fuente:[UIFont fontWithName:kFontType size:24] color:kTitleBlueColor];
    CGAffineTransform rotarLabelHechoPor = CGAffineTransformMakeRotation(-1.591);
    labelHechoPor.transform = rotarLabelHechoPor;
    [self.view addSubview:labelHechoPor];
    
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
    [self performSelector:@selector(callAdvertencia) withObject:nil afterDelay:0.1];
    
    hud=[[MBProgressHUD alloc]init];
    
    mainScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 126, self.view.frame.size.width, self.view.frame.size.height-126)];
    mainScrollView.backgroundColor=[UIColor clearColor];
    mainScrollView.contentSize=CGSizeMake(mainScrollView.frame.size.width*4, mainScrollView.frame.size.height);
    [mainScrollView setShowsHorizontalScrollIndicator:NO];
    [mainScrollView setPagingEnabled:YES];
    mainScrollView.delegate=self;
    [mainScrollView setScrollEnabled:YES];
    UITapGestureRecognizer *scrollTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [mainScrollView addGestureRecognizer:scrollTap];
    [self.view addSubview:mainScrollView];
    
    [self crearPaginaUno];
    [self crearPaginaDos];
    [self crearViewCalcular];
    [self crearPaginaTres];
    [self crearPaginaCuatro];
    [self crearInterfazSuperior];
    backgroundColor=self.view.backgroundColor;
    [paginaUnoContainer bringSubviewToFront:containerConfig];
    [self crearMenu];
    [self crearViewAlert];
    [self crearViewAlertMessage];
    locManager=[[CLLocationManager alloc]init];
    locManager.delegate=self;
    mapViewGPS.showsUserLocation=YES;
    mapViewGPS.delegate=self;
    
    banderaSecs=YES;
    unidadesAjuste=0;
    unidadesAjusteTotal=0;
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / 40)];
    [[UIAccelerometer sharedAccelerometer] setDelegate:self];
    tiempoQuieto=0;
    totalQuieto=0;
    estaMoviendose = NO;
}
-(void)callAdvertencia{
    saverObj=[[FileSaver alloc]init];
    if (![saverObj getUserFirstTime:@"entre"]) {
        [saverObj  setUserFirstTime:@"entre"];
        NSLog(@"holaaa %@", [saverObj getUserFirstTime:@"entre"]);
        AdvertenciaViewController *adVC=[[AdvertenciaViewController alloc]init];
        adVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Advertencia"];
        adVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentModalViewController:adVC animated:YES];
    }
    else{
        NSLog(@"Ya existe");
    }
}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark - interfaz superior
-(void)crearInterfazSuperior{
    mapViewGPS=[[MKMapView alloc]initWithFrame:CGRectMake(0, (self.view.frame.size.height-126)*-1, self.view.frame.size.width, self.view.frame.size.height-126)];
    mapViewGPS.tag=1000;
    [self.view addSubview:mapViewGPS];
    
    routeView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mapViewGPS.frame.size.width, mapViewGPS.frame.size.height)];
    routeView2.userInteractionEnabled = NO;
    [mapViewGPS addSubview:routeView2];
    
    alertButtonImage = [UIImage imageNamed:@"buttonPanic.png"];
    callUserButtonImage = [UIImage imageNamed:@"buttonUser.png"];
    emergencytButtonImage = [UIImage imageNamed:@"button123.png"];
    
    buttonAlert=[[UIButton alloc]initWithFrame:CGRectMake(mapViewGPS.frame.size.width-50, mapViewGPS.frame.size.height-60, 40, 40)];
    [buttonAlert setBackgroundImage:alertButtonImage forState:UIControlStateNormal];
    //buttonAlert.backgroundColor=kLiteRedColor;
    buttonAlert.layer.shadowColor = [[UIColor colorWithWhite:0.1 alpha:1] CGColor];
    buttonAlert.layer.shadowOffset = CGSizeMake(0.0f,1.0f);
    buttonAlert.layer.shadowRadius = 1;
    buttonAlert.layer.shadowOpacity = 0.8;
    //buttonAlert.layer.cornerRadius=3;
    buttonAlert.layer.opacity=0;
    [buttonAlert addTarget:self action:@selector(panicButtonTrigger) forControlEvents:UIControlEventTouchUpInside];
    [mapViewGPS addSubview:buttonAlert];
    
    buttonCallUser=[[UIButton alloc]initWithFrame:CGRectMake(mapViewGPS.frame.size.width-50, mapViewGPS.frame.size.height-110, 40, 40)];
    [buttonCallUser setBackgroundImage:callUserButtonImage forState:UIControlStateNormal];
    //buttonCallUser.backgroundColor=kGreenColor;
    buttonCallUser.layer.shadowColor = [[UIColor colorWithWhite:0.1 alpha:1] CGColor];
    buttonCallUser.layer.shadowOffset = CGSizeMake(0.0f,1.0f);
    buttonCallUser.layer.shadowRadius = 1;
    buttonCallUser.layer.shadowOpacity = 0.8;
    //buttonCallUser.layer.cornerRadius=3;
    buttonCallUser.layer.opacity=0;
    [buttonCallUser addTarget:self action:@selector(userCallTrigger) forControlEvents:UIControlEventTouchUpInside];
    [mapViewGPS addSubview:buttonCallUser];
    
    buttonEmergencyCall=[[UIButton alloc]initWithFrame:CGRectMake(mapViewGPS.frame.size.width-50, mapViewGPS.frame.size.height-160, 40, 40)];
    [buttonEmergencyCall setBackgroundImage:emergencytButtonImage forState:UIControlStateNormal];
    //buttonEmergencyCall.backgroundColor=kYellowColor;
    buttonEmergencyCall.layer.shadowColor = [[UIColor colorWithWhite:0.1 alpha:1] CGColor];
    buttonEmergencyCall.layer.shadowOffset = CGSizeMake(0.0f,1.0f);
    buttonEmergencyCall.layer.shadowRadius = 1;
    buttonEmergencyCall.layer.shadowOpacity = 0.8;
    //buttonEmergencyCall.layer.cornerRadius=3;
    buttonEmergencyCall.layer.opacity=0;
    [buttonEmergencyCall addTarget:self action:@selector(emergencyCallTrigger) forControlEvents:UIControlEventTouchUpInside];
    [mapViewGPS addSubview:buttonEmergencyCall];
    
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
    [valorInputLabel ponerTexto:@"$3500" fuente:[UIFont fontWithName:kFontType size:32] color:kDarkRedColor];
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
    if (deviceKind==3) {
        containerInfoTaximetro.frame=CGRectMake(5, 5, (135*2)+50, 78);
    }
    containerInfoTaximetro.backgroundColor=[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1];
    [containerSuperiorInferior addSubview:containerInfoTaximetro];
    
    
    containerTiempo=[[UIView alloc]initWithFrame:CGRectMake(137+4, 5, 70, 78)];
    if (deviceKind==3) {
        containerTiempo.frame=CGRectMake((137+4+23)*2, 5, (70*2)+50, 78);
    }
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
    if (deviceKind==3) {
        containerUnidades.frame=CGRectMake((6+206+48)*2, 5, (103*2)+35, 78);
    }
    [containerSuperiorInferior addSubview:containerUnidades];
    UIView *containerUnidadesOverlay=[[UIView alloc]initWithFrame:CGRectMake(3, 3, containerUnidades.frame.size.width-5, containerUnidades.frame.size.height-5)];
    containerUnidadesOverlay.backgroundColor=[UIColor whiteColor];
    containerUnidadesOverlay.alpha=0.08;
    //[containerUnidades addSubview:containerUnidadesOverlay];
    UIView *containerBotonesUnidades=[[UIView alloc]initWithFrame:CGRectMake(0, containerUnidades.frame.size.height-30, containerUnidades.frame.size.width, 30)];
    containerBotonesUnidades.backgroundColor=[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1];
    [containerUnidades addSubview:containerBotonesUnidades];
    //unidades=25;
    UIButton *botonMenos=[UIButton buttonWithType:UIButtonTypeCustom];
    botonMenos.frame=CGRectMake(0, 0, (containerBotonesUnidades.frame.size.width/2)-0.5, containerBotonesUnidades.frame.size.height);
    [botonMenos setTitle:@"-" forState:UIControlStateNormal];
    botonMenos.titleLabel.font=[UIFont  boldSystemFontOfSize:22];
    botonMenos.tag=3000;
    botonMenos.backgroundColor=kDarkGrayColor;
    [botonMenos addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [containerBotonesUnidades addSubview:botonMenos];
    
    UIButton *botonMas=[UIButton buttonWithType:UIButtonTypeCustom];
    botonMas.frame=CGRectMake((containerBotonesUnidades.frame.size.width/2)+0.5, 0, (containerBotonesUnidades.frame.size.width/2)-0.5, containerBotonesUnidades.frame.size.height);
    [botonMas setTitle:@"+" forState:UIControlStateNormal];
    botonMas.titleLabel.font=[UIFont  boldSystemFontOfSize:22];
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
    [self startAnimationSequence];
}
#pragma mark Acciones botones de llamada
-(void)userCallTrigger{
    Modelador *guardar=[[Modelador alloc]init];
    NSLog(@"Cuantos hay %i", [[guardar getNumeroEmergencia] length]);
    NSString *phoneNumber1=@"";
    if ([[guardar getNumeroEmergencia] length]>2) {
        //NSString *numeroEmergenciaString=[guardar getNumeroEmergencia];
        phoneNumber1=[guardar getNumeroEmergencia];
    }
    else{
        NSLog(@"No hay numero");
        phoneNumber1=@"123";
    }
    
    NSString *phoneNumber = [@"tel://" stringByAppendingString:phoneNumber1];
    UIWebView *webview=[[UIWebView alloc]init];
    NSURL *theURL=[NSURL URLWithString:phoneNumber];
    [webview loadRequest:[NSURLRequest requestWithURL:theURL]];
    [self.view addSubview:webview];
}
-(void)emergencyCallTrigger{
    NSString *phoneNumber1=[NSString stringWithFormat:@"%.0f",taximetro.numeroDeEmergenciasLocal];
    NSLog(@" %@",phoneNumber1);
    NSString *phoneNumber = [@"tel://" stringByAppendingString:phoneNumber1];
    UIWebView *webview=[[UIWebView alloc]init];
    NSURL *theURL=[NSURL URLWithString:phoneNumber];
    [webview loadRequest:[NSURLRequest requestWithURL:theURL]];
    [self.view addSubview:webview];
}
-(void)panicButtonTrigger{
    NSLog(@"panic button trigger");
    Modelador *obj=[[Modelador alloc]init];
    NSString *mensajePanico;
    if ([[obj obtenerMensajeDePanico] isEqualToString:@" "]||[[obj obtenerMensajeDePanico] isEqualToString:@""]||[obj obtenerMensajeDePanico]==nil) {
            mensajePanico=@"Mi Ubicación actual es ";
    }
    else{
            mensajePanico=[obj obtenerMensajeDePanico];
    }
    double lat=zoomLocation.latitude;
    double longi=zoomLocation.longitude;
    NSString *ubicacion=[NSString stringWithFormat:@"%@ http://maps.google.com/maps?q=%f,%f",mensajePanico,lat,longi];
    
    if ([[obj obtenerNombreDeRedSocial] isEqualToString:@"SMS "]){
        
        MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
        if([MFMessageComposeViewController canSendText])
        {
            NSString *smsTel=@"";
            if ([[obj getNumeroSMS] isEqualToString:@" "]||[[obj getNumeroSMS] isEqualToString:@""]||[obj getNumeroSMS]==nil
                ||[[obj getNumeroSMS] isEqualToString:@"0"]) {
                smsTel=@"";
            }
            else{
                smsTel=[obj getNumeroSMS];
            }
            
            controller.body = ubicacion;
            controller.recipients = [NSArray arrayWithObjects:smsTel, nil];
            controller.messageComposeDelegate = self;
            [self presentModalViewController:controller animated:YES];
        }
        return;
    }
    
    //SHKItem *item = [SHKItem text:contenido];
    //SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
    [self saveScreenshot];
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Screenshot.jpg"];
    
    UIImage *image = [UIImage imageWithContentsOfFile:documentsDirectory];
    //    NSString *ubicacion=[NSString stringWithFormat:@"Mi Ubicación en este momento es Lat<%.6f>, Long<%.6f>",lat,longi];
    
    //SHKItem *item = [SHKItem image:image title:ubicacion];
    if ([[obj obtenerNombreDeRedSocial] isEqualToString:@"Twitter "]||
        [[obj obtenerNombreDeRedSocial] isEqualToString:@"Twitter"]){
        NSString *ubicacion=[NSString stringWithFormat:@"%@ http://maps.google.com/maps?q=%f,%f",mensajePanico,lat,longi];
        [self publicarEnTwttConMensaje:ubicacion];
    }
    if ([[obj obtenerNombreDeRedSocial] isEqualToString:@"Facebook "]||
        [[obj obtenerNombreDeRedSocial] isEqualToString:@"Facebook"]){
        NSString *ubicacion=[NSString stringWithFormat:@"%@ http://maps.google.com/maps?q=%f,%f",mensajePanico,lat,longi];
        [self publicarEnFbConMensaje:ubicacion];
    }
    if ([[obj obtenerNombreDeRedSocial] isEqualToString:@"Mail "]||
        [[obj obtenerNombreDeRedSocial] isEqualToString:@"Mail"]){
        //[SHKMail shareItem:item];
        NSString *correo;
        if ([obj getMail]==nil) {
            correo=@"";
        }
        else
            correo=[obj getMail];
        
        NSData *imageAttachment = UIImageJPEGRepresentation(image,1);
        MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
		controller.mailComposeDelegate = self;
        NSString *ubicacion=[NSString stringWithFormat:@"%@ http://maps.google.com/maps?q=%f,%f",mensajePanico,lat,longi];
		[controller setSubject:mensajePanico];
        [controller setToRecipients:[NSArray arrayWithObject:correo]];
		[controller setMessageBody:ubicacion isHTML:YES];
        [controller addAttachmentData:imageAttachment mimeType:@"image/jpeg" fileName:@"mapa.jpg"];
		[self presentModalViewController:controller animated:YES];
    }
    
}
-(void)buttonPressed:(UIButton*)button{
    if (button.tag==3000) {
        if (unidadesAjuste+25>25) {
            unidadesAjuste-=1;
        }
        else{
            
        }
        
        labelUnidades.text=[NSString stringWithFormat:@"%i",unidadesAjuste+25];
        [self contarMetros];
        
    }
    else if (button.tag==3001){
        unidadesAjuste+=1;
        labelUnidades.text=[NSString stringWithFormat:@"%i",unidadesAjuste+25];
        [self contarMetros];
    }
}
-(NSString *)contarMetros{
    float metros=0;
    int unidades=0;
    //float adicional=0;
    metros=[Taximetro medidorDeMetrosRecorridos:arregloDePuntos];
    labelMetros.text= [NSString stringWithFormat:@"%.1f m",metros];
    
    unidadesAjusteTotal=[Taximetro conversorSegundosAUnidades:totalQuieto :taximetro.segundosDeEspera]+unidadesAjuste;
    unidades=[Taximetro conversorMetrosAUnidades:metros paraElTaximetro:taximetro]+unidadesAjusteTotal;
    /*if (unidades>299)unidades=299;*/
    NSLog(@"unidades ajuestetotal %i", unidadesAjusteTotal);
    float temp=[taximetro unidadesADinero:(int)unidades];
    //valorInputLabel.text=[NSString stringWithFormat:@"$%.0f",temp];
    labelUnidades.text= [NSString stringWithFormat:@"%i",unidades];
    [self agregarOquitarCargos:temp];
    return [NSString stringWithFormat:@"%.0f",temp];
}
#pragma mark método de movimiento
-(void) empezoAMoverse {
    NSLog(@"empezoAMoverse");
}
-(void) dejarDeMoverse {    
    tiempoQuieto = 0;
    estaMoviendose = NO;
    NSLog(@"dejarDeMoverse");
    
}
#pragma mark método de aceleración
static BOOL IsDeviceShaking(UIAcceleration* last, UIAcceleration* current, double threshold) {
    double deltaX = fabs(last.x - current.x);
    double deltaY = fabs(last.y - current.y);
    double deltaZ = fabs(last.z - current.z);
    return (deltaX > threshold && deltaY > threshold) ||
    (deltaX > threshold && deltaZ > threshold) ||
    (deltaY > threshold && deltaZ > threshold);
}

-(void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    
	if (self.lastAcceleration) {
        if (!shakeDetected && IsDeviceShaking(self.lastAcceleration, acceleration, 0.035)) {
            shakeDetected = YES;
            //NSLog(@"unidades de secs %i", [self conversorSegundosAUnidades:seconds]);
            
            if (!estaMoviendose) {
                [self empezoAMoverse];
            }
            estaMoviendose = YES;
            
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dejarDeMoverse) object:nil];
            Modelador *model = [[Modelador alloc]init];
            BOOL ok=[model getBackgroundResponse];
            //NSLog(@"se esta o no moviendo %d",ok);
            if (ok) {
                [self performSelector:@selector(dejarDeMoverse) withObject:nil afterDelay:1];
            }
            else if(!ok){
                [self performSelector:@selector(dejarDeMoverse) withObject:nil afterDelay:30];
                
            }
        }
        else if (shakeDetected && !IsDeviceShaking(lastAcceleration, acceleration, 0.035)) {
            shakeDetected = NO;
        }
    }
    self.lastAcceleration = acceleration;
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
    
    bannerViewPaginaUno=[[BannerView alloc]initWithFrame:CGRectMake(0, 0, mainScrollView.frame.size.width-10, 0)];
    [bannerViewPaginaUno ponerTexto:@"CONFIGURACIÓN"];
    bannerViewPaginaUno.configBannerLabel.textColor=[UIColor colorWithRed:0.75390625 green:0.02734375 blue:0.02734375 alpha:1];
    [bannerViewPaginaUno.configBannerLabel setOverlayOff:NO];
    [bannerViewPaginaUno setBannerColor:[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1]];
    bannerViewPaginaUno.center=CGPointMake(self.view.frame.size.width/2, 50);
    [paginaUnoContainer addSubview:bannerViewPaginaUno];
    
    containerConfig=[[UIView alloc]initWithFrame:CGRectMake(5, bannerViewPaginaUno.frame.size.height+15,paginaUnoContainer.frame.size.width-10, 165)];
    
    if (deviceKind==2) {
        containerConfig.frame=CGRectMake(5, bannerViewPaginaUno.frame.size.height+40, paginaUnoContainer.frame.size.width-10, 165);
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
    
    //[nocDomFesSwitch addTarget:self action:@selector(animacionNoche:)];
    [nocDomFesSwitch addTarget:self action:@selector(switchChanged:)];
    
    [containerConfig addSubview:nocDomFesSwitch];
    
    aeropuertoLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(margenLabels, 50, 130, 30)];
    [aeropuertoLabel ponerTexto:@"Aeropuerto" fuente:[UIFont fontWithName:kFontType size:30] color:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1]];
    [aeropuertoLabel setOverlayOff:YES];
    [containerConfig addSubview:aeropuertoLabel];
    
    aeropuertoSwitch=[[CustomSwitch alloc]initWithFrame:CGRectMake(containerConfig.frame.size.width-65, 48, 0, 0)];
    [aeropuertoSwitch addTarget:self action:@selector(switchChanged:)];
    [containerConfig addSubview:aeropuertoSwitch];
    
    puertaApuertaLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(margenLabels, 90, 130, 30)];
    [puertaApuertaLabel ponerTexto:@"Puerta a puerta" fuente:[UIFont fontWithName:kFontType size:30] color:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1]];
    [puertaApuertaLabel setOverlayOff:YES];
    [containerConfig addSubview:puertaApuertaLabel];
    
    puertaApuertaSwitch=[[CustomSwitch alloc]initWithFrame:CGRectMake(containerConfig.frame.size.width-65, 88, 0, 0)];
    [puertaApuertaSwitch addTarget:self action:@selector(switchChanged:)];
    [containerConfig addSubview:puertaApuertaSwitch];
    
    terminalLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(margenLabels, 130, 130, 30)];
    [terminalLabel ponerTexto:@"Terminal" fuente:[UIFont fontWithName:kFontType size:30] color:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1]];
    [terminalLabel setOverlayOff:YES];
    [containerConfig addSubview:terminalLabel];
    
    terminalSwitch=[[CustomSwitch alloc]initWithFrame:CGRectMake(containerConfig.frame.size.width-65, 128, 0, 0)];
    [terminalSwitch addTarget:self action:@selector(switchChanged:)];
    [containerConfig addSubview:terminalSwitch];
    
    UIView *containerValoresYTiempo=[[UIView alloc]initWithFrame:CGRectMake(0, 0, paginaUnoContainer.frame.size.width-20, 40)];
    containerValoresYTiempo.backgroundColor=[UIColor clearColor];
    containerValoresYTiempo.center=CGPointMake(paginaUnoContainer.frame.size.width/2, (bannerViewPaginaUno.frame.size.height+containerConfig.frame.size.height+10)+(containerValoresYTiempo.frame.size.height/2));
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
#pragma mark - switch changed

-(void)switchChanged:(CustomSwitch*)switcht{
   /* NSLog(@"Estos son los metros: %f",metros);
    float temp=[taximetro unidadesADinero:metros];*/
    NSString *resultadoContarMetros=[self contarMetros];
    float temp=[resultadoContarMetros floatValue];
    [self agregarOquitarCargos:temp];
    [self animacionNoche:switcht];
}
-(void)agregarOquitarCargos:(float)dinero{
    if (nocDomFesSwitch.isOn) {
        dinero+=taximetro.costoNoc;
    }
    if (aeropuertoSwitch.isOn) {
        dinero+=taximetro.costoAero;
    }
    if (puertaApuertaSwitch.isOn) {
        dinero+=taximetro.costoPuerta;
    }
    if (terminalSwitch.isOn) {
        dinero+=taximetro.costoTerm;
    }
    valorInputLabel.text=[NSString stringWithFormat:@"$%.0f",dinero];
}
#pragma mark guardar estadisticas
-(void)guardarEstadisticas{
    Modelador *obj=[[Modelador alloc]init];
    if (seconds>10) {
        //Registro para el Rate
       // iRate *rate= [[iRate alloc]init];
        //[rate logEvent:YES];
        float metros=[Taximetro medidorDeMetrosRecorridos:arregloDePuntos];
        
        metros+=[obj getKm];
        [obj setKm:metros];
        
        int viajes=[obj getViajes]+1;
        [obj setViajes:viajes];
        
        int segundos = seconds;
        segundos+=[obj getMinutosTaxi];
        [obj setMinutosTaxi:segundos];
        
        if (!taximetro.medicionEnPrecio) {
            NSString *stringA= valorInputLabel.text;
            stringA = [stringA stringByReplacingOccurrencesOfString:@"$" withString:@""];
            
            float precio = [stringA floatValue];
            precio+=[obj getCantidadTaxis];
            [obj setCantidadTaxis:precio];
        }
        else if(taximetro.medicionEnPrecio){
            NSString *stringA= labelUnidades.text;
            stringA = [stringA stringByReplacingOccurrencesOfString:@"$"
                                                         withString:@""];
            float precio = [stringA floatValue];
            if (precio<taximetro.carreraMinima) {
                precio=taximetro.carreraMinima;
            }
            precio+=[obj getCantidadTaxis];
            [obj setCantidadTaxis:precio];
        }
        
    }
}

#pragma mark - pagina dos
-(void)crearPaginaDos{
    paginaDos=[[UIView alloc]initWithFrame:CGRectMake(mainScrollView.frame.size.width*1, 0, mainScrollView.frame.size.width, mainScrollView.frame.size.height)];
    paginaDos.backgroundColor=kBlueColor;
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
    
    mapaPaginaDos=[[MKMapView alloc]initWithFrame:CGRectMake(5, bannerPaginaDos.frame.size.height+35, paginaUnoContainer.frame.size.width-10, 195)];
    if (deviceKind==3) {
        mapaPaginaDos.frame=CGRectMake(5, 120, paginaUnoContainer.frame.size.width-10, 670);
    }
    else if(deviceKind==2){
        mapaPaginaDos.frame=CGRectMake(5, bannerPaginaDos.frame.size.height+35, paginaUnoContainer.frame.size.width-10, 280);
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
    
    containerPlacaPaginaTres=[[UIView alloc]init];
    if (deviceKind==2) {
        containerPlacaPaginaTres.frame=CGRectMake(5, bannerView.frame.size.height+25, paginaTres.frame.size.width-10, 190);
    }
    else{
        containerPlacaPaginaTres.frame=CGRectMake(5, bannerView.frame.size.height+20,paginaTres.frame.size.width-10, 190);
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
#pragma mark - pagina cuatro
-(void)crearPaginaCuatro{
    paginaCuatro=[[UIView alloc]initWithFrame:CGRectMake(mainScrollView.frame.size.width*3, 0, mainScrollView.frame.size.width, mainScrollView.frame.size.height)];
    paginaCuatro.backgroundColor=[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1];
    [mainScrollView addSubview:paginaCuatro];
    
    BannerView *bannerViewPaginaCuatro=[[BannerView alloc]initWithFrame:CGRectMake(0, 0, mainScrollView.frame.size.width-10, 0)];
    [bannerViewPaginaCuatro ponerTexto:@"SÍGUENOS"];
    bannerViewPaginaCuatro.configBannerLabel.textColor=[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1];
    [bannerViewPaginaCuatro.configBannerLabel setOverlayOff:NO];
    [bannerViewPaginaCuatro setBannerColor:kYellowColor];
    bannerViewPaginaCuatro.center=CGPointMake(self.view.frame.size.width/2, 50);
    [paginaCuatro addSubview:bannerViewPaginaCuatro];
    
    UIView *viewContentSiguenos=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-10, 45)];
    if (deviceKind==3) {
        viewContentSiguenos.center=CGPointMake(self.view.frame.size.width/2, 480);
    }
    else{
        viewContentSiguenos.center=CGPointMake(self.view.frame.size.width/2, 200);
    }
    viewContentSiguenos.backgroundColor=kGrayColor;
    [paginaCuatro addSubview:viewContentSiguenos];
    
    UILabel *labelSiguenos=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 155, 30)];
    labelSiguenos.center=CGPointMake((viewContentSiguenos.frame.size.width/4)+10, viewContentSiguenos.frame.size.height/2);
    labelSiguenos.font=[UIFont fontWithName:kFontType size:28];
    labelSiguenos.backgroundColor=[UIColor clearColor];
    labelSiguenos.textColor=kWhiteColor;
    labelSiguenos.text=@"Síguenos en twitter";
    [viewContentSiguenos addSubview:labelSiguenos];
    
    
    FollowMeButton *buttonTwitter=[[FollowMeButton alloc]initWithTwitterAccount:@"@BogoTaxiReporta" atOrigin:CGPointMake((viewContentSiguenos.frame.size.width/2)+(viewContentSiguenos.frame.size.width/5), 7) isSmallButton:NO];
    [viewContentSiguenos addSubview:buttonTwitter];
}
#pragma mark - animaciones
-(void)animacionNoche:(CustomSwitch*)switch1{
    NSLog(@"entree a la animación");
    if (switch1.isOn) {
        if (switch1==nocDomFesSwitch) {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            paginaUnoContainer.backgroundColor=kNightColor;
            bannerViewPaginaUno.configBannerLabel.textColor=kYellowColor;
            [bannerViewPaginaUno.configBannerLabel setOverlayOff:YES];
            [bannerViewPaginaUno setBannerColor:kWhiteColor];
            [UIView commitAnimations];
        }
        else if (switch1==aeropuertoSwitch) {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            paginaUnoContainer.backgroundColor=kBlueColor;
            bannerViewPaginaUno.configBannerLabel.textColor=kYellowColor;
            [bannerViewPaginaUno.configBannerLabel setOverlayOff:YES];
            [bannerViewPaginaUno setBannerColor:kWhiteColor];
            [UIView commitAnimations];
        }
        else if (switch1==puertaApuertaSwitch) {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            paginaUnoContainer.backgroundColor=kGrayColor;
            bannerViewPaginaUno.configBannerLabel.textColor=kYellowColor;
            [bannerViewPaginaUno.configBannerLabel setOverlayOff:YES];
            [bannerViewPaginaUno setBannerColor:kWhiteColor];
            [UIView commitAnimations];
        }
        else if (switch1==terminalSwitch) {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            paginaUnoContainer.backgroundColor=kLiteRedColor;
            bannerViewPaginaUno.configBannerLabel.textColor=kYellowColor;
            [bannerViewPaginaUno.configBannerLabel setOverlayOff:YES];
            [bannerViewPaginaUno setBannerColor:kWhiteColor];
            [UIView commitAnimations];
        }
    }
    else{
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        paginaUnoContainer.backgroundColor=kYellowColor;
        bannerViewPaginaUno.configBannerLabel.textColor=[UIColor colorWithRed:0.75390625 green:0.02734375 blue:0.02734375 alpha:1];
        [bannerViewPaginaUno.configBannerLabel setOverlayOff:NO];
        [bannerViewPaginaUno setBannerColor:[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1]];
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
        mapViewGPS.frame=CGRectMake(0,(self.view.frame.size.height-126)*-1, self.view.frame.size.width, self.view.frame.size.height-126);
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
            mapViewGPS.frame=CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height-126);
        }
        else if (counter==1){
            containerSuperior.frame=CGRectMake(0,self.view.frame.size.height-176, self.view.frame.size.width, 126);
            mapViewGPS.frame=CGRectMake(0,-50, self.view.frame.size.width, self.view.frame.size.height-126);
        }
        else if (counter==2){
            containerSuperior.frame=CGRectMake(0,self.view.frame.size.height-126, self.view.frame.size.width, 126);
            mapViewGPS.frame=CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height-126);
        }
        else if (counter==3){
            containerSuperior.frame=CGRectMake(0,self.view.frame.size.height-136, self.view.frame.size.width, 126);
            mapViewGPS.frame=CGRectMake(0,-10, self.view.frame.size.width, self.view.frame.size.height-126);
        }
        else if (counter==4){
            containerSuperior.frame=CGRectMake(0,self.view.frame.size.height-126, self.view.frame.size.width, 126);
            mapViewGPS.frame=CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height-126);
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
    
    if (!estaMoviendose) {
        Modelador *model=[[Modelador alloc]init];
        BOOL ok=[model getBackgroundResponse];
        NSLog(@"esta moviendose %d",ok);
        if (ok) {
            tiempoQuieto++;
            totalQuieto++;
            NSLog(@"aumento tiempo quieto %i", totalQuieto);
            [self contarMetros];
        }
        else if(!ok){
            NSLog(@"Sigo igual");
        }
    }
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
    if (ptoA && ptoB) {
        CLLocationDistance distanciaPreliminar=[ptoA distanceFromLocation:ptoB];
        routes =[self calculateRoutesFrom:ptoA.coordinate to:ptoB.coordinate];
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Calculando";
        if (distanciaPreliminar<120000) {
            [self updateRouteView];
        }
        else{
            routeView.Hidden=YES;
        }
        calcular.metros=distanciaMetros;
        int unidades =[Taximetro conversorMetrosAUnidades:distanciaMetros paraElTaximetro:taximetro];
        float temp=[taximetro unidadesADinero:unidades];
        calcular.valueTotalAprox.text=[NSString stringWithFormat:@"$%.0f",temp];
        calcular.valueRecorrido.text=[NSString stringWithFormat:@"%.2f Km",distanciaMetros/1000];
        [calcular changeState];
        [self.view bringSubviewToFront:calcular];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    else{
        [alertMessage changeState];
        [self.view bringSubviewToFront:alertMessage];
        [alertMessage.labelMensaje ponerTexto:@"Por favor selecciona un punto de Salida y un punto de Destino en el mapa." fuente:[UIFont fontWithName:kFontType size:32] color:kWhiteColor];

    }
    
}

#pragma mark Alert
-(void)callAlert:(CustomButton*)button{
    [alert changeState];
    [self.view bringSubviewToFront:alert];
    if (seleccionarAB==0) {
        seleccion=button.tag;
    }
    else{
        seleccion=seleccionarAB;
    }
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
    if (button.tag==2000 && seleccion==2) {
        seleccionarAB=2;
    }
    else if (button.tag==2001 && seleccion==1){
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
            removeRegionButton.layer.cornerRadius=5;
            [removeRegionButton setTitle:@"x" forState:UIControlStateNormal];
            removeRegionButton.titleLabel.font=[UIFont fontWithName:@"helvetica" size:25];
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
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    if (mapView.tag==1000) {
        routeView2.hidden=YES;
    }
    else{
        routeView.hidden = YES;
    }
}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    if (mapView.tag==1000) {
        if (!switchEncender.isOn) {
            routeView2.hidden = NO;
            /*newThread = [[NSThread alloc] initWithTarget:self selector:@selector(updateRouteView) object:NULL];
             [newThread start];*/
            [NSThread detachNewThreadSelector: @selector(updateRouteView2) toTarget:self withObject:NULL];
            //[self updateRouteView];
        }
        else
            routeView2.hidden = YES;
        [routeView2 setNeedsDisplay];
    }
    else{
        [self updateRouteView];
        routeView.hidden = NO;
        [routeView setNeedsDisplay];
    }
}

- (void)tapGestureHandler:(UITapGestureRecognizer *)tgr{
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
                ptoA=[[CLLocation alloc] initWithLatitude:touchMapCoordinate.latitude longitude:touchMapCoordinate.longitude];
                regionView = [[RegionAnnotationView alloc] initWithAnnotation:annotationA withcolor:MKPinAnnotationColorRed];
                regionView.map = mapaPaginaDos;
                annotationA.title=@"Salida";
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
                ptoB=[[CLLocation alloc] initWithLatitude:touchMapCoordinate.latitude longitude:touchMapCoordinate.longitude];
                regionView = [[RegionAnnotationView alloc] initWithAnnotation:annotationB withcolor:MKPinAnnotationColorGreen];
                regionView.map = mapaPaginaDos;
                annotationB.title=@"Destino";
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
    banderaCalcular = NO;
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
        if (banderaCalcular) {
            locationOne.latitude= locationPast.latitude;
            locationOne.longitude= locationPast.longitude;
        }
        locationTwo.latitude=loc.coordinate.latitude;
        locationTwo.longitude=loc.coordinate.longitude;
        
        
        CLLocation *pointALocation = [[CLLocation alloc] initWithLatitude:locationTwo.latitude longitude:locationTwo.longitude];
        CLLocation *pointBLocation = [[CLLocation alloc] initWithLatitude:locationOne.latitude longitude:locationOne.longitude];
        distanciaMetros += [pointALocation distanceFromLocation:pointBLocation];
        //NSLog(@"Distancia metros %f",distanciaMetros);
        
        locationPast.latitude=locationTwo.latitude;
        locationPast.longitude=locationTwo.longitude;
        locationOne.latitude=locationPast.latitude;
        locationOne.longitude=locationPast.longitude;
        banderaCalcular = YES;
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
    //hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.labelText = @"Calculando";
}
-(void) updateRouteView2{
    CGContextRef context = 	CGBitmapContextCreate(nil,
												  routeView2.frame.size.width,
												  routeView2.frame.size.height,
												  8,
												  4 * routeView2.frame.size.width,
												  CGColorSpaceCreateDeviceRGB(),
												  kCGImageAlphaPremultipliedLast);
	lineColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5];
	CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
	CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1.0);
	CGContextSetLineWidth(context, 3.0);
	
	for(int i = 0; i < coordenadasParaDibujar.count; i++) {
		CLLocation* location = [coordenadasParaDibujar objectAtIndex:i];
		CGPoint point = [mapViewGPS convertCoordinate:location.coordinate toPointToView:routeView2];
		
		if(i == 0) {
			CGContextMoveToPoint(context, point.x, routeView2.frame.size.height - point.y);
		} else {
			CGContextAddLineToPoint(context, point.x, routeView2.frame.size.height - point.y);
		}
	}
	
	CGContextStrokePath(context);
	
	CGImageRef image = CGBitmapContextCreateImage(context);
	UIImage* img = [UIImage imageWithCGImage:image];
	
	routeView2.image = img;
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
    mapaPaginaDos.frame=CGRectMake(5, 40, paginaDos.frame.size.width-10, paginaDos.frame.size.height-95 );
    bannerPaginaDos.frame=CGRectMake(0, 0, 0,0);
    containerBotonesPaginaDos.center=CGPointMake(paginaDos.frame.size.width/2, 20);
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
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 6) ? NO : YES;
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
        Modelador *obj=[[Modelador alloc]init];
        int userCallAlpha;
        int emergencyCallAlpha;
        routeView2.hidden = YES;
        tiempoInputLabel.text=@"00:00";
        labelEncender.text=@"Apagar";
        [arregloDePuntos removeAllObjects];
        arregloDePuntos=nil;
        arregloDePuntos=[[NSMutableArray alloc]init];
        [self animarView:buttonAlert ConOpacidad:1];
        if ([[obj getNumeroEmergencia] length]>2) {
            userCallAlpha=1;
        }
        else{
            userCallAlpha=0;
        }
        
        if ([[obj getNumero123] isEqualToString:@"1"]) {
            emergencyCallAlpha=1;
        }
        else if([[obj getNumero123] isEqualToString:@"0"]){
            emergencyCallAlpha=0;
        }
        [self animarView:buttonCallUser ConOpacidad:userCallAlpha];
        [self animarView:buttonEmergencyCall ConOpacidad:emergencyCallAlpha];
        //[self irAPaginaDeScroll:2];
        [self clockStart];
        if (banderaSecs) {
            seconds = 0;
            tiempoQuieto = 0;
        }
        coordenadasParaDibujar=[[NSMutableArray alloc]init];
        [locManager startUpdatingLocation];
        banderaSecs = NO;
        totalQuieto=0;
        unidadesAjuste=0;
    }
    else{
        labelEncender.text=@"Encender";
        [locManager stopUpdatingLocation];
        [self animarView:buttonAlert ConOpacidad:0];
        [self animarView:buttonCallUser ConOpacidad:1];
        [self animarView:buttonEmergencyCall ConOpacidad:1];
        //[self irAPaginaDeScroll:0];
        [self updateRouteView2];
        Modelador *obj=[[Modelador alloc]init];
        if (![obj getAlertSwitchValue]) {
            
            [alertMessage changeState];
            [self.view bringSubviewToFront:alertMessage];
            NSString *resumenUnidades=labelUnidades.text;
            NSString *resumenValorViaje=valorInputLabel.text;
            NSString *resumenTiempo=tiempoInputLabel.text;
            NSString *resumen=[NSString stringWithFormat:@"Total \n Total unidades: %@ \n Total dinero: %@ \n Total tiempo: %@",resumenUnidades,resumenValorViaje, resumenTiempo];
            [alertMessage.labelMensaje ponerTexto:resumen fuente:[UIFont fontWithName:kFontType size:24] color:kWhiteColor];
        }
        routeView2.hidden = NO;
        [self guardarEstadisticas];
        [self clockStop];
        banderaSecs=YES;
        banderaU = NO;
    }
}
#pragma mark location
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)location fromLocation:(CLLocation *)oldLocation{

    if (switchEncender.isOn) {
        zoomLocation.latitude = location.coordinate.latitude;
        zoomLocation.longitude = location.coordinate.longitude;
        if (banderaU) {
            zoomLocation.latitude=oldLocation.coordinate.latitude;
            zoomLocation.longitude=oldLocation.coordinate.longitude;
        }
        zoomLocation2.latitude = location.coordinate.latitude;
        zoomLocation2.longitude = location.coordinate.longitude;
        
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation,
                                                                           0.5*METERS_PER_MILE,
                                                                           0.5*METERS_PER_MILE);
        MKCoordinateRegion adjustedRegion = [mapViewGPS regionThatFits:viewRegion];
        [mapViewGPS setRegion:adjustedRegion animated:YES];
        
        CLLocation *pointALocation = [[CLLocation alloc] initWithLatitude:zoomLocation2.latitude longitude:zoomLocation2.longitude];
        CLLocation *pointBLocation = [[CLLocation alloc] initWithLatitude:zoomLocation.latitude longitude:zoomLocation.longitude];
        //double distanciaMetros = [pointALocation getDistanceFrom:pointBLocation];
        double distMetros = [pointALocation distanceFromLocation:pointBLocation];

        double distanciaKm=distMetros/1000;
        
        zoomLocationPast.latitude=zoomLocation2.latitude;
        zoomLocationPast.longitude=zoomLocation2.longitude;
        zoomLocation.latitude=zoomLocationPast.latitude;
        zoomLocation.longitude=zoomLocationPast.longitude;
        
        if (distanciaKm>0.001) {
            [arregloDePuntos addObject:[NSNumber numberWithDouble:distMetros]];
            [coordenadasParaDibujar addObject:pointALocation];
            [coordenadasParaDibujar addObject:pointBLocation];
        }
        banderaU = YES;
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
#pragma mark Guardar imagen
- (void)saveScreenshot {
    
    // Define the dimensions of the screenshot you want to take (the entire screen in this case)
    //CGSize size =  [[UIScreen mainScreen] bounds].size;
    
    // Create the screenshot
    UIGraphicsBeginImageContextWithOptions(mapViewGPS.bounds.size, NO, 0.0);
    
    // Put everything in the current view into the screenshot
    [[mapViewGPS layer] renderInContext:UIGraphicsGetCurrentContext()];
    // Save the current image context info into a UIImage
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Save the screenshot to the device's photo album
    //UIImageWriteToSavedPhotosAlbum(newImage, self,
    //                             @selector(image:didFinishSavingWithError:contextInfo:), nil);
    NSString *savePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Screenshot.jpg"];
    
    // Write image to PNG
    //[UIImagePNGRepresentation(newImage) writeToFile:savePath atomically:YES];
    [UIImageJPEGRepresentation(newImage, 0.1 ) writeToFile:savePath atomically:YES];
    NSError *error;
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    // Point to Document directory
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    // Write out the contents of home directory to console
    NSLog(@"Documents directory: %@", [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error]);
    
}
// callback for UIImageWriteToSavedPhotosAlbum
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    if (error) {
        NSLog(@"Error al guardar");    }
    else {
        NSLog(@"Guardada con éxito");
    }
}
#pragma mark delegates de mensajes
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
	switch (result) {
		case MessageComposeResultCancelled:
			break;
		case MessageComposeResultFailed:
			break;
		case MessageComposeResultSent:
            
			break;
		default:
			break;
	}
    
	[self dismissModalViewControllerAnimated:YES];
}
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
	switch (result) {
		case MFMailComposeResultCancelled:
			break;
		case MFMailComposeResultFailed:
			break;
		case MFMailComposeResultSent:
            
			break;
		default:
			break;
	}
    
	[self dismissModalViewControllerAnimated:YES];
}
-(void)publicarEnFbConMensaje:(NSString*)mensaje{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
        SLComposeViewController *controller=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        SLComposeViewControllerCompletionHandler block=^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultCancelled) {
               // NSLog(@"Paila cancelado");
            }
            else{
                //NSLog(@"Listo parcero");
            }
            [controller dismissViewControllerAnimated:YES completion:nil];
        };
        controller.completionHandler=block;
        [controller setInitialText:mensaje];
        [self saveScreenshot];
        NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Screenshot.jpg"];
        UIImage *image = [UIImage imageWithContentsOfFile:documentsDirectory];
        NSData *imageAttachment = UIImageJPEGRepresentation(image,1);
        [controller addImage:[UIImage imageWithData:imageAttachment]];
        [self presentViewController:controller animated:YES completion:nil];
        
    }
    else{
        [alertMessage changeState];
        [self.view bringSubviewToFront:alertMessage];
        [alertMessage.labelMensaje ponerTexto:@"Tu mensaje no puede ser enviado en este momento, asegúrate que tienes conexión a internet y que tienes regitrada al menos una cuenta de facebook en tu dispositivo (Ajustes->facebook)." fuente:[UIFont fontWithName:kFontType size:24] color:kWhiteColor];
    }
}
-(void)publicarEnTwttConMensaje:(NSString*)mensaje{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:mensaje];
        [self saveScreenshot];
        NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Screenshot.jpg"];
        UIImage *image = [UIImage imageWithContentsOfFile:documentsDirectory];
        NSData *imageAttachment = UIImageJPEGRepresentation(image,1);
        [tweetSheet addImage:[UIImage imageWithData:imageAttachment]];
        [self presentModalViewController:tweetSheet animated:NO];
    }
    else
    {
        [alertMessage changeState];
        [self.view bringSubviewToFront:alertMessage];
        [alertMessage.labelMensaje ponerTexto:@"Tu mensaje no puede ser enviado en este momento, asegúrate que tienes conexión a internet y que tienes regitrada al menos una cuenta de twitter en tu dispositivo (Ajustes->twitter)." fuente:[UIFont fontWithName:kFontType size:24] color:kWhiteColor];
    }
}
@end
