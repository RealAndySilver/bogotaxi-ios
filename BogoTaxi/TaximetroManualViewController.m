//
//  TaximetroManualViewController.m
//  BogoTaxi
//
//  Created by Andres Abril on 23/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "TaximetroManualViewController.h"
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


@interface TaximetroManualViewController ()

@end

@implementation TaximetroManualViewController

- (void)viewDidLoad{
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
    self.view.backgroundColor=kDarkGrayColor;
    CustomButton *backButton=[[CustomButton alloc]initWithFrame:CGRectMake(10, self.view.frame.size.height-40, 50, 30)];
    backButton.backgroundColor=kYellowColor;
    [backButton setTitleColor:kGrayColor forState:UIControlStateNormal];
    [backButton setTitle:@"Atrás" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    [self crearContainerConfiguracion];
    taximetro=[[Taximetro alloc]initWithCiudad:@"bogota"];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dismissView{
    [self dismissModalViewControllerAnimated:YES];
}
-(void)crearContainerConfiguracion{
    BannerView *bannerView=[[BannerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-10, 0)];

    [bannerView ponerTexto:@"TAXÍMETRO MANUAL"];
    bannerView.configBannerLabel.textColor=kYellowColor;
    [bannerView.configBannerLabel setOverlayOff:YES];
    [bannerView setBannerColor:kDarkGrayColor];
    bannerView.center=CGPointMake(self.view.frame.size.width/2, 50);
    if (deviceKind==2) {
        bannerView.center=CGPointMake(self.view.frame.size.width/2, 95);
    }
    [self.view addSubview:bannerView];
    UIView *containerValores=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-240-120, self.view.frame.size.width, 110)];
    if (deviceKind==2) {
        containerValores.frame=CGRectMake(0, self.view.frame.size.height-240-170, self.view.frame.size.width, 110);
    }
    containerValores.backgroundColor=kWhiteColor;
    [self.view addSubview:containerValores];
    UIView *containerPlata=[[UIView alloc]initWithFrame:CGRectMake(10, 10, (containerValores.frame.size.width/2)-10-1, 90)];
    
    
    containerPlata.backgroundColor=[UIColor darkGrayColor];
    [containerValores addSubview:containerPlata];
    
    CustomLabel *valorLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 10, containerPlata.frame.size.width, 35)];
    [valorLabel ponerTexto:@"Valor Total" fuente:[UIFont fontWithName:kFontType size:32] color:kWhiteColor];
    [valorLabel setOverlayOff:YES];
    [valorLabel setCentrado:YES];
    [containerPlata addSubview:valorLabel];
    
    valorInputLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(0 , 50, containerPlata.frame.size.width, 35)];
    [valorInputLabel ponerTexto:@"$3.400" fuente:[UIFont fontWithName:kFontType size:40] color:kDarkRedColor];
    [valorInputLabel setOverlayOff:YES];
    [valorInputLabel setCentrado:YES];
    [containerPlata addSubview:valorInputLabel];
    
    UIView *containerUnidades=[[UIView alloc]initWithFrame:CGRectMake((containerValores.frame.size.width/2)+3, 10, (containerValores.frame.size.width/2)-10-3, 90)];
    containerUnidades.backgroundColor=[UIColor darkGrayColor];
    [containerValores addSubview:containerUnidades];
    
    UIView *containerUnidadesOverlay=[[UIView alloc]initWithFrame:CGRectMake(3, 3, containerUnidades.frame.size.width-5, containerUnidades.frame.size.height-5)];
    containerUnidadesOverlay.backgroundColor=[UIColor whiteColor];
    containerUnidadesOverlay.alpha=0.08;
    //[containerUnidades addSubview:containerUnidadesOverlay];
    UIView *containerBotonesUnidades=[[UIView alloc]initWithFrame:CGRectMake(0, containerUnidades.frame.size.height-30, containerUnidades.frame.size.width, 30)];
    containerBotonesUnidades.backgroundColor=[UIColor darkGrayColor];
    [containerUnidades addSubview:containerBotonesUnidades];
    UIButton *botonMenos=[UIButton buttonWithType:UIButtonTypeCustom];
    botonMenos.tag=0;
    [botonMenos addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    botonMenos.frame=CGRectMake(0, 0, (containerBotonesUnidades.frame.size.width/2)-0.5, containerBotonesUnidades.frame.size.height);
    [botonMenos setTitle:@"-" forState:UIControlStateNormal];
    botonMenos.titleLabel.font=[UIFont  boldSystemFontOfSize:15];
    botonMenos.backgroundColor=[UIColor grayColor];
    [containerBotonesUnidades addSubview:botonMenos];
    
    UIButton *botonMas=[UIButton buttonWithType:UIButtonTypeCustom];
    botonMas.tag=1;
    [botonMas addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    botonMas.frame=CGRectMake((containerBotonesUnidades.frame.size.width/2)+0.5, 0, (containerBotonesUnidades.frame.size.width/2)-0.5, containerBotonesUnidades.frame.size.height);
    [botonMas setTitle:@"+" forState:UIControlStateNormal];
    botonMas.titleLabel.font=[UIFont  boldSystemFontOfSize:15];
    botonMas.backgroundColor=[UIColor grayColor];
    [containerBotonesUnidades addSubview:botonMas];
    
    labelUnidades=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, containerUnidades.frame.size.width-10, containerUnidades.frame.size.height-20)];
    labelUnidades.center=CGPointMake(containerUnidades.frame.size.width/2, (containerUnidades.frame.size.height/2)-11);
    labelUnidades.textAlignment=UITextAlignmentCenter;
    [labelUnidades ponerTexto:@"25" fuente:[UIFont fontWithName:kFontType size:60] color:kDarkRedColor];
    [labelUnidades setOverlayOff:YES];
    [containerUnidades addSubview:labelUnidades];
    
    
    
    slider=[[UISlider alloc]initWithFrame:CGRectMake(10, self.view.frame.size.height-210-30, self.view.frame.size.width-20, 20)];
    if (deviceKind==2) {
        slider.frame=CGRectMake(10, self.view.frame.size.height-210-80, self.view.frame.size.width-20, 20);
    }
    [slider setMinimumTrackTintColor:kYellowColor];
    [slider setThumbTintColor:kDarkGrayColor];
    [slider setMaximumTrackTintColor:[UIColor whiteColor]];
    [self.view addSubview:slider];
    slider.minimumValue=25;
    slider.maximumValue=399;
    [slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
    containerConfig=[[UIView alloc]initWithFrame:CGRectMake(5, self.view.frame.size.height-160-50, self.view.frame.size.width-10, 160)];
    if (deviceKind==2) {
        containerConfig.frame=CGRectMake(5, self.view.frame.size.height-160-100, self.view.frame.size.width-10, 160);
    }
    containerConfig.backgroundColor=kDarkGrayColor;
    containerConfig.layer.cornerRadius=3;
    containerConfig.layer.shadowColor = [[UIColor colorWithWhite:0.1 alpha:1] CGColor];
    containerConfig.layer.shadowOffset = CGSizeMake(0.0f,0.0f);
    containerConfig.layer.shadowRadius = 2;
    containerConfig.layer.shadowOpacity = 0.3;
    [self.view addSubview:containerConfig];
    
    int margenLabels=10;
    nocDomFesLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(margenLabels, 10, 130, 20)];
    [nocDomFesLabel ponerTexto:@"Noc-Dom-Fes" fuente:[UIFont fontWithName:kFontType size:25] color:[UIColor whiteColor]];
    [nocDomFesLabel setOverlayOff:YES];
    [containerConfig addSubview:nocDomFesLabel];
    
    nocDomFesSwitch=[[CustomSwitch alloc]initWithFrame:CGRectMake(containerConfig.frame.size.width-60, 8, 0, 0)];
    
    [nocDomFesSwitch addTarget:self action:@selector(switchChanged)];
    
    [containerConfig addSubview:nocDomFesSwitch];
    
    aeropuertoLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(margenLabels, 50, 130, 20)];
    [aeropuertoLabel ponerTexto:@"Aeropuerto" fuente:[UIFont fontWithName:kFontType size:25] color:[UIColor whiteColor]];
    [aeropuertoLabel setOverlayOff:YES];
    [containerConfig addSubview:aeropuertoLabel];

    aeropuertoSwitch=[[CustomSwitch alloc]initWithFrame:CGRectMake(containerConfig.frame.size.width-60, 48, 0, 0)];
    [containerConfig addSubview:aeropuertoSwitch];
    [aeropuertoSwitch addTarget:self action:@selector(switchChanged)];

    puertaApuertaLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(margenLabels, 90, 130, 20)];
    [puertaApuertaLabel ponerTexto:@"Puerta a puerta" fuente:[UIFont fontWithName:kFontType size:25] color:[UIColor whiteColor]];
    [puertaApuertaLabel setOverlayOff:YES];
    [containerConfig addSubview:puertaApuertaLabel];
    
    puertaApuertaSwitch=[[CustomSwitch alloc]initWithFrame:CGRectMake(containerConfig.frame.size.width-60, 88, 0, 0)];
    [containerConfig addSubview:puertaApuertaSwitch];
    [puertaApuertaSwitch addTarget:self action:@selector(switchChanged)];

    terminalLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(margenLabels, 130, 130, 20)];
    [terminalLabel ponerTexto:@"Terminal" fuente:[UIFont fontWithName:kFontType size:25] color:[UIColor whiteColor]];
    [terminalLabel setOverlayOff:YES];
    [containerConfig addSubview:terminalLabel];
    
    terminalSwitch=[[CustomSwitch alloc]initWithFrame:CGRectMake(containerConfig.frame.size.width-60, 128, 0, 0)];
    [containerConfig addSubview:terminalSwitch];
    [terminalSwitch addTarget:self action:@selector(switchChanged)];

}
-(void)sliderChange:(UISlider*)slider1{
    float temp=[taximetro unidadesADinero:(int)slider1.value];
    [self agregarOquitarCargos:temp];
    labelUnidades.text=[NSString stringWithFormat:@"%.0f",slider1.value];
}
-(void)buttonPressed:(UIButton*)button{
    if (button.tag==0) {
        slider.value-=1;
    }
    else if (button.tag==1){
        slider.value+=1;
    }
    [self sliderChange:slider];
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
-(void)switchChanged{
    [self sliderChange:slider];
}
@end
