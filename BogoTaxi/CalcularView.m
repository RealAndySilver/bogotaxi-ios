//
//  CalcularView.m
//  BogoTaxi
//
//  Created by Development on 5/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "CalcularView.h"
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

@implementation CalcularView
@synthesize metros,valueTotalAprox,valueRecorrido;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha=0;
        myFrame=frame;
        /*UITapGestureRecognizer *tapRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeState)];
        [self addGestureRecognizer:tapRecognizer];*/
    }
    return self;
}
-(void)construirMenuConDeviceKind:(int)deviceKind{
    UIView *background=[[UIView alloc]initWithFrame:myFrame];
    background.backgroundColor=[UIColor blackColor];
    background.alpha=0.9;
    [self addSubview:background];
    
    taximetro=[[Taximetro alloc]initWithCiudad:@"bogota"];
    
    contenedorCalcular=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.frame.size.width-10, 140+160+10)];
    contenedorCalcular.center=CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [self addSubview:contenedorCalcular];
    
    containerValores=[[UIView alloc]initWithFrame:CGRectMake(0, 0,contenedorCalcular.frame.size.width, 140)];
    containerValores.backgroundColor=[UIColor blackColor];
    containerValores.layer.cornerRadius=3;
    containerValores.layer.masksToBounds=YES;
    [containerValores setClipsToBounds:YES];
    [contenedorCalcular addSubview:containerValores];
    
    containerDinero=[[UIView alloc]initWithFrame:CGRectMake(0, 0, containerValores.frame.size.width, (containerValores.frame.size.height/2)-0.5)];
    containerDinero.center=CGPointMake(containerValores.frame.size.width/2, (containerValores.frame.size.height/2)/2);
    containerDinero.backgroundColor=kDarkGrayColor;
    [containerValores addSubview:containerDinero];
    
    totalAprox=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, 180, 50)];
    [totalAprox ponerTexto:@"Total Aproximado" fuente:[UIFont fontWithName:kFontType size:34] color:kYellowColor];
    totalAprox.center=CGPointMake(23+(containerDinero.frame.size.width/2)/2, containerDinero.frame.size.height/2);
    [totalAprox setOverlayOff:YES];
    //[totalAprox setCentrado:YES];
    [containerDinero addSubview:totalAprox];
    
    valueTotalAprox=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    [valueTotalAprox ponerTexto:@"$0" fuente:[UIFont fontWithName:kFontType size:40] color:kDarkRedColor];
    valueTotalAprox.center=CGPointMake(25+containerDinero.frame.size.width/2+(containerDinero.frame.size.width/2)/2, (containerDinero.frame.size.height/2));
    
    [valueTotalAprox setOverlayOff:YES];
    //[valueTotalAprox setCentrado:YES];
    [containerDinero addSubview:valueTotalAprox];
    
    containerRecorrido=[[UIView alloc]initWithFrame:CGRectMake(0, 0, containerValores.frame.size.width, (containerValores.frame.size.height/2)-0.5)];
    containerRecorrido.center=CGPointMake((containerRecorrido.frame.size.width/2),((containerValores.frame.size.height/2)+(containerValores.frame.size.height/2)/2)+0.5);
    containerRecorrido.backgroundColor=kDarkGrayColor;
    [containerValores addSubview:containerRecorrido];
    
    recorrido=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, 180, 50)];
    [recorrido ponerTexto:@"Distancia" fuente:[UIFont fontWithName:kFontType size:34] color:kYellowColor];
    recorrido.center=CGPointMake(23+(containerRecorrido.frame.size.width/2)/2, containerRecorrido.frame.size.height/2);
    [recorrido setOverlayOff:YES];
    //[recorrido setCentrado:YES];
    [containerRecorrido addSubview:recorrido];
    
    valueRecorrido=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    [valueRecorrido ponerTexto:@"0 Km" fuente:[UIFont fontWithName:kFontType size:36] color:kWhiteColor];
    valueRecorrido.center=CGPointMake(((containerRecorrido.frame.size.width/2)/2)+containerRecorrido.frame.size.width/2+25, containerRecorrido.frame.size.height/2);
    [valueRecorrido setOverlayOff:YES];
    //[valueRecorrido setCentrado:YES];
    [containerRecorrido addSubview:valueRecorrido];

    containerConfig=[[UIView alloc]initWithFrame:CGRectMake(0, containerValores.frame.size.height+10,contenedorCalcular.frame.size.width, 162)];
    containerConfig.backgroundColor=[UIColor darkGrayColor];
    containerConfig.layer.cornerRadius=3;
    [contenedorCalcular addSubview:containerConfig];
    
    int margenLabels=10;
    nocDomFesLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(margenLabels, 8, 130, 30)];
    [nocDomFesLabel ponerTexto:@"Noc-Dom-Fes" fuente:[UIFont fontWithName:kFontType size:30] color:[UIColor whiteColor]];
    [nocDomFesLabel setOverlayOff:YES];
    [containerConfig addSubview:nocDomFesLabel];
    
    nocDomFesSwitch=[[CustomSwitch alloc]initWithFrame:CGRectMake(containerConfig.frame.size.width-65, 6, 0, 0)];
    
    [nocDomFesSwitch addTarget:self action:@selector(animacionNoche:)];
    
    [containerConfig addSubview:nocDomFesSwitch];
    [nocDomFesSwitch addTarget:self action:@selector(switchChanged)];
    
    aeropuertoLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(margenLabels, 48, 130, 30)];
    [aeropuertoLabel ponerTexto:@"Aeropuerto" fuente:[UIFont fontWithName:kFontType size:30] color:[UIColor whiteColor]];
    [aeropuertoLabel setOverlayOff:YES];
    [containerConfig addSubview:aeropuertoLabel];
    
    aeropuertoSwitch=[[CustomSwitch alloc]initWithFrame:CGRectMake(containerConfig.frame.size.width-65, 46, 0, 0)];
    [containerConfig addSubview:aeropuertoSwitch];
    [aeropuertoSwitch addTarget:self action:@selector(switchChanged)];
    
    puertaApuertaLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(margenLabels, 88, 130, 30)];
    [puertaApuertaLabel ponerTexto:@"Puerta a puerta" fuente:[UIFont fontWithName:kFontType size:30] color:[UIColor whiteColor]];
    [puertaApuertaLabel setOverlayOff:YES];
    [containerConfig addSubview:puertaApuertaLabel];
    
    puertaApuertaSwitch=[[CustomSwitch alloc]initWithFrame:CGRectMake(containerConfig.frame.size.width-65, 86, 0, 0)];
    [containerConfig addSubview:puertaApuertaSwitch];
    [puertaApuertaSwitch addTarget:self action:@selector(switchChanged)];
    
    terminalLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(margenLabels, 128, 130, 30)];
    [terminalLabel ponerTexto:@"Terminal" fuente:[UIFont fontWithName:kFontType size:30] color:[UIColor whiteColor]];
    [terminalLabel setOverlayOff:YES];
    [containerConfig addSubview:terminalLabel];
    
    terminalSwitch=[[CustomSwitch alloc]initWithFrame:CGRectMake(containerConfig.frame.size.width-65, 126, 0, 0)];
    [containerConfig addSubview:terminalSwitch];
    [terminalSwitch addTarget:self action:@selector(switchChanged)];
    
    botonVolverAlMapa=[[CustomButton alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    botonVolverAlMapa.center=CGPointMake(60, self.frame.size.height-(botonVolverAlMapa.frame.size.height/2)-8);
    [botonVolverAlMapa setTitle:@"Volver al Mapa" forState:UIControlStateNormal];
    [botonVolverAlMapa addTarget:self action:@selector(changeState) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:botonVolverAlMapa];
}
-(void)changeState{
    if (self.alpha<1) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.alpha=1;
        [UIView commitAnimations];
    }
    else{
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.alpha=0;
        [UIView commitAnimations];
        BOOL off=NO;
        [nocDomFesSwitch onOff:off];
        [aeropuertoSwitch onOff:off];
        [puertaApuertaSwitch onOff:off];
        [terminalSwitch onOff:off];
    }
}
-(void)switchChanged{
    int unidades =[Taximetro conversorMetrosAUnidades:metros paraElTaximetro:taximetro];
    float temp=[taximetro unidadesADinero:unidades];
    //float temp=[taximetro unidadesADinero:metros];
    [self agregarOquitarCargos:temp];
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
    //float totalDinero=[valueTotalAprox float];
    valueTotalAprox.text=[NSString stringWithFormat:@"$%.0f",dinero];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
