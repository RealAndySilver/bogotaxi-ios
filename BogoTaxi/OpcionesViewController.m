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
    CustomButton *backButton=[[CustomButton alloc]initWithFrame:CGRectMake(10, self.view.frame.size.height-40, 50, 30)];
    backButton.backgroundColor=kYellowColor;
    [backButton setTitleColor:kGrayColor forState:UIControlStateNormal];
    [backButton setTitle:@"Atrás" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    [self crearContainerConfiguracion];
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
    BannerView *bannerView=[[BannerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-20, 0)];
    
    [bannerView ponerTexto:@"OPCIONES"];
    bannerView.configBannerLabel.textColor=kYellowColor;
    [bannerView.configBannerLabel setOverlayOff:YES];
    [bannerView setBannerColor:kWhiteColor];
    bannerView.center=CGPointMake(self.view.frame.size.width/2, 50);
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
    
    containerView=[[UIView alloc]initWithFrame:CGRectMake(10, bannerView.frame.size.height+50, (self.view.frame.size.width)-20, (self.view.frame.size.height)-(bannerView.frame.size.height)-100)];
    containerView.backgroundColor=kGrayColor;
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
    [containerView addSubview:opcionesTaxi];
    
    compartirGPS=[[CustomButton alloc]initWithFrame:CGRectMake(0, 0, (containerView.frame.size.width)-20, (containerView.frame.size.height/2)-60)];
    [compartirGPS setTitle:@"Opciones Copartir GPS y seguridad" forState:UIControlStateNormal];
    compartirGPS.titleLabel.font=[UIFont fontWithName:kFontType size:24];
    compartirGPS.center=CGPointMake((containerView.frame.size.width/2), opcionesTaxi.frame.size.height+60);
    if (deviceKind==2) {
        compartirGPS.frame=CGRectMake(0, 0, (containerView.frame.size.width)-20, (containerView.frame.size.height/2)-80);
        compartirGPS.center=CGPointMake((containerView.frame.size.width/2), opcionesTaxi.frame.size.height+80);
    }
    [containerView addSubview:compartirGPS];
    
    contacto=[[CustomButton alloc]initWithFrame:CGRectMake(0, 0, (containerView.frame.size.width)-20, (containerView.frame.size.height/2)-60)];
    [contacto setTitle:@"Opciones Copartir GPS y seguridad" forState:UIControlStateNormal];
    contacto.titleLabel.font=[UIFont fontWithName:kFontType size:24];
    contacto.center=CGPointMake((containerView.frame.size.width/2), opcionesTaxi.frame.size.height+ compartirGPS.frame.size.height+70);
    if (deviceKind==2) {
        contacto.frame=CGRectMake(0, 0, (containerView.frame.size.width)-20, (containerView.frame.size.height/2)-80);
        contacto.center=CGPointMake((containerView.frame.size.width/2), opcionesTaxi.frame.size.height+ compartirGPS.frame.size.height+95);
     }
    [containerView addSubview:contacto];
    
    
}

@end
