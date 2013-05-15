//
//  OpcionesViewController.m
//  BogoTaxi
//
//  Created by Development on 4/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "OpcionesViewController.h"
#define kFontType @"LeagueGothic"
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

@interface OpcionesViewController ()

@end

@implementation OpcionesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	if (self.view.frame.size.height<480) {
        deviceKind=1;
    }
    else if (self.view.frame.size.height>480 && self.view.frame.size.height<560){
        deviceKind=2;
    }
    else if (self.view.frame.size.height>600){
        deviceKind=3;
    }
    self.view.backgroundColor=kBlueColor;
   
    alertMessage=[[AlertMessageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [alertMessage crearView];
    [self.view addSubview:alertMessage];
    
    CustomButton *backButton=[[CustomButton alloc]initWithFrame:CGRectMake(10, self.view.frame.size.height-40, 50, 30)];
    backButton.backgroundColor=kYellowColor;
    [backButton setTitleColor:kGrayColor forState:UIControlStateNormal];
    [backButton setTitle:@"Atrás" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    [self crearContainerConfiguracion];
    [self crearViewOpcionesTaximetro];
    [self crearViewOpcionesCompartir];
    [self crearViewOpcionesContacto];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dismissView{
    [self dismissModalViewControllerAnimated:YES];
}
-(void)crearContainerConfiguracion{
    BannerView *bannerView=[[BannerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-10, 0)];
    
    [bannerView ponerTexto:@"OPCIONES"];
    bannerView.configBannerLabel.textColor=kYellowColor;
    //[bannerView.configBannerLabel setOverlayOff:YES];
    [bannerView setBannerColor:kWhiteColor];
    bannerView.center=CGPointMake(self.view.frame.size.width/2, 55);
    if (deviceKind==2) {
        bannerView.center=CGPointMake(self.view.frame.size.width/2, 60);
    }
    [self.view addSubview:bannerView];
    
    configTituloLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-20, 30)];
    
    configTituloLabel.center=CGPointMake(self.view.frame.size.width/2, 114);
    if (deviceKind==2) {
        configTituloLabel.center=CGPointMake(self.view.frame.size.width/2, 127);
    }
    [configTituloLabel ponerTexto:@"CONFIGURA TUS OPCIONES" fuente:[UIFont fontWithName:kFontType size:30] color:kTitleBlueColor];
    [configTituloLabel setCentrado:YES];
    [self.view addSubview:configTituloLabel];
    
    containerView=[[UIView alloc]initWithFrame:CGRectMake(5, bannerView.frame.size.height+50, (self.view.frame.size.width)-10, (self.view.frame.size.height)-(bannerView.frame.size.height)-100)];
    containerView.backgroundColor=kDarkGrayColor;
    containerView.layer.cornerRadius=3;
    if (deviceKind==2) {
        containerView.frame=CGRectMake(10, bannerView.frame.size.height+70, (self.view.frame.size.width)-20, (self.view.frame.size.height)-(bannerView.frame.size.height)-120);
    }
    [self.view addSubview:containerView];
    
    opcionesTaxi=[[CustomButton alloc]initWithFrame:CGRectMake(0, 0, (containerView.frame.size.width)-20, (containerView.frame.size.height/2)-60)];
    [opcionesTaxi setTitle:@"Opciones Taximetro" forState:UIControlStateNormal];
    opcionesTaxi.titleLabel.font=[UIFont fontWithName:kFontType size:24];
    opcionesTaxi.center=CGPointMake((containerView.frame.size.width/2), ((containerView.frame.size.height/3)/2)+5);
    if (deviceKind==2) {
        opcionesTaxi.frame=CGRectMake(0, 0, (containerView.frame.size.width)-20, (containerView.frame.size.height/2)-80);
        opcionesTaxi.center=CGPointMake((containerView.frame.size.width/2), ((containerView.frame.size.height/3)/2)+5);
    }
    else if (deviceKind==3) {
        opcionesTaxi.frame=CGRectMake(0, 0, (containerView.frame.size.width)-20, 250);
        opcionesTaxi.center=CGPointMake((containerView.frame.size.width/2), ((containerView.frame.size.height/3)/2)+10);
    }
    [opcionesTaxi addTarget:self action:@selector(callOpcionesTaxi) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:opcionesTaxi];
    
    compartirGPS=[[CustomButton alloc]initWithFrame:CGRectMake(0, 0, (containerView.frame.size.width)-20, (containerView.frame.size.height/2)-60)];
    [compartirGPS setTitle:@"Opciones Compartir GPS y seguridad" forState:UIControlStateNormal];
    compartirGPS.titleLabel.font=[UIFont fontWithName:kFontType size:24];
    compartirGPS.center=CGPointMake((containerView.frame.size.width/2), opcionesTaxi.frame.size.height+60);
    if (deviceKind==2) {
        compartirGPS.frame=CGRectMake(0, 0, (containerView.frame.size.width)-20, (containerView.frame.size.height/2)-80);
        compartirGPS.center=CGPointMake((containerView.frame.size.width/2), opcionesTaxi.frame.size.height+80);
    }
    else if (deviceKind==3) {
        compartirGPS.frame=CGRectMake(0, 0, (containerView.frame.size.width)-20, 250);
        compartirGPS.center=CGPointMake((containerView.frame.size.width/2), opcionesTaxi.frame.size.height+160);
    }
    [compartirGPS addTarget:self action:@selector(callOpcionesCompartir) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:compartirGPS];
    
    contacto=[[CustomButton alloc]initWithFrame:CGRectMake(0, 0, (containerView.frame.size.width)-20, (containerView.frame.size.height/2)-60)];
    [contacto setTitle:@"Contacto e información" forState:UIControlStateNormal];
    contacto.titleLabel.font=[UIFont fontWithName:kFontType size:24];
    contacto.center=CGPointMake((containerView.frame.size.width/2), opcionesTaxi.frame.size.height+ compartirGPS.frame.size.height+70);
    if (deviceKind==2) {
        contacto.frame=CGRectMake(0, 0, (containerView.frame.size.width)-20, (containerView.frame.size.height/2)-80);
        contacto.center=CGPointMake((containerView.frame.size.width/2), opcionesTaxi.frame.size.height+ compartirGPS.frame.size.height+97);
     }
    else if (deviceKind==3) {
        contacto.frame=CGRectMake(0, 0, (containerView.frame.size.width)-20, 250);
        contacto.center=CGPointMake((containerView.frame.size.width/2), opcionesTaxi.frame.size.height+ compartirGPS.frame.size.height+175);
    }
    [contacto addTarget:self action:@selector(callOpcionesContacto) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:contacto];
    
    
}
-(void)crearViewOpcionesTaximetro{
    opcionesTaxiView=[[OpcionesTaximetroView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [opcionesTaxiView construirMenuConDeviceKind:deviceKind];
    [self.view addSubview:opcionesTaxiView];
}
-(void)crearViewOpcionesCompartir{
    opcionesCompartir=[[OpcionesCompartirView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [opcionesCompartir construirMenuConDeviceKind:deviceKind];
    [self.view addSubview:opcionesCompartir];
}
-(void)crearViewOpcionesContacto{
    opcionesContactoeInformacion=[[OpcionesContactoView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [opcionesContactoeInformacion construirConDeviceKind:deviceKind];
    [self.view addSubview:opcionesContactoeInformacion];
}
-(void)callOpcionesTaxi{
    
    [opcionesTaxiView changeState];
    [opcionesTaxiView.estadisticas addTarget:self action:@selector(goTo:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)callOpcionesCompartir{
    
    [opcionesCompartir changeState];
    [opcionesCompartir.botonDePanico addTarget:self action:@selector(goTo:) forControlEvents:UIControlEventTouchUpInside];
    [opcionesCompartir.LlamadaEmergencia addTarget:self action:@selector(goTo:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)callOpcionesContacto{
    
    [opcionesContactoeInformacion changeState];
    [opcionesContactoeInformacion.advertencia addTarget:self action:@selector(goTo:) forControlEvents:UIControlEventTouchUpInside];
    [opcionesContactoeInformacion.acercaDeBogoTaxi addTarget:self action:@selector(goTo:) forControlEvents:UIControlEventTouchUpInside];
    [opcionesContactoeInformacion.contactanos addTarget:self action:@selector(goTo:) forControlEvents:UIControlEventTouchUpInside];
    [opcionesContactoeInformacion.cuentaleaUnAmigo addTarget:self action:@selector(goTo:) forControlEvents:UIControlEventTouchUpInside];
    [opcionesContactoeInformacion.meEncanta addTarget:self action:@selector(goTo:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)goTo:(CustomButton*)button{
    if ([button.titleLabel.text isEqualToString:@"Estadísticas"]) {
        EstadisticasViewController *eVC=[[EstadisticasViewController alloc]init];
        eVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Estadisticas"];
        eVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentModalViewController:eVC animated:YES];
    }
    else if ([button.titleLabel.text isEqualToString:@"Botón de Panico"]) {
        PanicoViewController *pVC=[[PanicoViewController alloc]init];
        pVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Panico"];
        pVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentModalViewController:pVC animated:YES];
    }
    else if ([button.titleLabel.text isEqualToString:@"Llamada de emergencia"]) {
        if (deviceKind==3) {
            [self.view bringSubviewToFront:alertMessage];
            [alertMessage changeState];
            [alertMessage.labelMensaje ponerTexto:@"Opción válida solo para iPhone." fuente:[UIFont fontWithName:kFontType size:32] color:kWhiteColor];
        }
        else{
            LlamadaDeEmergenciaViewController *lVC=[[LlamadaDeEmergenciaViewController alloc]init];
            lVC=[self.storyboard instantiateViewControllerWithIdentifier:@"LlamadaEmergencia"];
            lVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [self presentModalViewController:lVC animated:YES];
        }
    }
    else if ([button.titleLabel.text isEqualToString:@"Advertencia"]) {
        AdvertenciaViewController *adVC=[[AdvertenciaViewController alloc]init];
        adVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Advertencia"];
        adVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentModalViewController:adVC animated:YES];
    }
    else if ([button.titleLabel.text isEqualToString:@"Acerca de BogoTaxi"]) {
        AcercaDeViewController *aVC=[[AcercaDeViewController alloc]init];
        aVC=[self.storyboard instantiateViewControllerWithIdentifier:@"AcercaDe"];
        aVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentModalViewController:aVC animated:YES];
    }
    else if ([button.titleLabel.text isEqualToString:@"Contáctanos"]) {
        MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
		controller.mailComposeDelegate = self;
		[controller setToRecipients:[NSArray arrayWithObject:@"support@iamstudio.co"]];
		[controller setSubject:@"BogoTaxi"];
		[self presentModalViewController:controller animated:YES];
    }
    else if ([button.titleLabel.text isEqualToString:@"Cuéntale a un Amigo"]) {
        MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
		controller.mailComposeDelegate = self;
		[controller setSubject:@"Prueba BogoTaxi"];
		[controller setMessageBody:@"Con BogoTaxi podrás medir tu trayectoria, conocer el valor a pagar aproximado, y postear la placa y lugar donde cogiste tu Taxi en la red social que elijas." isHTML:NO];
		[self presentModalViewController:controller animated:YES];
	}
    else if ([button.titleLabel.text isEqualToString:@"Me encanta esta App!"]) {
        NSString *iRateMacAppStoreURLFormat = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=474509867";
        NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:iRateMacAppStoreURLFormat]];
		[[UIApplication sharedApplication] openURL:url];
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
@end
