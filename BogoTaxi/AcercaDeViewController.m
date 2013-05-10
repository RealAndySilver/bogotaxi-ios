//
//  AcercaDeViewController.m
//  BogoTaxi
//
//  Created by Development on 17/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "AcercaDeViewController.h"
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

@interface AcercaDeViewController ()

@end

@implementation AcercaDeViewController

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
	self.view.backgroundColor=[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1];
    if (self.view.frame.size.height<480) {
        deviceKind=1;
    }
    else if (self.view.frame.size.height>480 && self.view.frame.size.height<560){
        deviceKind=2;
    }
    else if (self.view.frame.size.height>600){
        deviceKind=3;
    }
    
    
    
    BannerView *bannerView=[[BannerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-10, 0)];
    [bannerView ponerTexto:@"BogoTaxi"];
    bannerView.configBannerLabel.textColor=[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1];
    [bannerView.configBannerLabel setOverlayOff:YES];
    [bannerView setBannerColor:kYellowColor];
    bannerView.center=CGPointMake(self.view.frame.size.width/2, 47);
    [self.view addSubview:bannerView];
    
    
    UIView *containerMensaje=[[UIView alloc]initWithFrame:CGRectMake(0, 0 ,self.view.frame.size.width-10, 300)];
    containerMensaje.backgroundColor=kWhiteColor;
    //containerMensaje.layer.cornerRadius=3;
    containerMensaje.layer.shadowColor = [[UIColor colorWithWhite:0.1 alpha:1] CGColor];
    containerMensaje.layer.shadowOffset = CGSizeMake(0.0f,1.0f);
    containerMensaje.layer.shadowRadius = 2;
    containerMensaje.layer.shadowOpacity = 0.8;
    if (deviceKind==3) {
        containerMensaje.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    }
    else{
        containerMensaje.center=CGPointMake(self.view.frame.size.width/2, (self.view.frame.size.height/2)+20);
    }
    [self.view addSubview:containerMensaje];
    
    UIView *containerMensajeblue=[[UIView alloc]initWithFrame:CGRectMake(0, 0 ,containerMensaje.frame.size.width-10, 290)];
    containerMensajeblue.backgroundColor=kBlueColor;
    containerMensajeblue.center=CGPointMake(containerMensaje.frame.size.width/2, containerMensaje.frame.size.height/2);
    [containerMensaje addSubview:containerMensajeblue];
    
    CustomLabel *mensaje=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, containerMensaje.frame.size.width-20, 290)];
    mensaje.center=CGPointMake(containerMensaje.frame.size.width/2, containerMensaje.frame.size.height/2);
    
    [mensaje ponerTexto:@"Esta aplicación fue creada con fines de entretenimiento, y no es un taximetro profesional. Las mediciones que este realice pueden no ser del todo exactas. Las llamadas realizadas al 123 son de total responsabilidad del usuario de BogoTaxi. iAm Studio SAS no se hace responsable del manejo unadecuado que el usuario de a los componentes de seguridad de la aplicación ni de los costos adicionales que puedan tener. Recuerda que esta es una herramienta que te puede orientar y ayudar en caso de emergencia. Utilízala con prudencia." fuente:[UIFont fontWithName:kFontType size:20] color:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1]];
    mensaje.numberOfLines = 18;
    mensaje.overlayLabel.numberOfLines=18;
    [mensaje setOverlayOff:NO];
    [containerMensaje addSubview:mensaje];
    
    CustomButton *backButton=[[CustomButton alloc]initWithFrame:CGRectMake(10, self.view.frame.size.height-40, 50, 30)];
    backButton.backgroundColor=kYellowColor;
    [backButton setTitleColor:kDarkGrayColor forState:UIControlStateNormal];
    [backButton setTitle:@"Atrás" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UIView *viewContentHechoPor=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-255, self.view.frame.size.height-40, 250, 30)];
    //viewContentHechoPor.backgroundColor=kGreenColor;
    [self.view addSubview:viewContentHechoPor];
    CustomLabel *labelHechoPor=[[CustomLabel alloc]initWithFrame:CGRectMake(5,5, 179, 20)];
    [labelHechoPor ponerTexto:@"Copyright (c) 2013 iAmStudio. All rights reserved." fuente:[UIFont fontWithName:kFontType size:12] color:kWhiteColor];
    [labelHechoPor setOverlayOff:YES];
    [viewContentHechoPor addSubview:labelHechoPor];
    UIView *viewImage=[[UIView alloc]initWithFrame:CGRectMake(175, 0, 76, 30)];
    [viewContentHechoPor addSubview:viewImage];
    UIImageView *LogoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 76, 30)];
    LogoImage.image = [UIImage imageNamed:@"logoiAmAbout.png"];
    [viewImage addSubview:LogoImage];
}
-(void)dismissView{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
