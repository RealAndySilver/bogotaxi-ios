//
//  OpcionesTaximetroView.m
//  BogoTaxi
//
//  Created by Development on 5/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "OpcionesTaximetroView.h"
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


@implementation OpcionesTaximetroView
@synthesize estadisticas;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha=0;
        myFrame=frame;
    }
    return self;
}
-(void)construirMenuConDeviceKind:(int)deviceKind{
    UIView *background=[[UIView alloc]initWithFrame:myFrame];
    background.backgroundColor=[UIColor blackColor];
    background.alpha=0.9;
    UITapGestureRecognizer *tapRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeState)];
    [background addGestureRecognizer:tapRecognizer];
    [self addSubview:background];

    containerOpciones=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width-10, 185)];
    containerOpciones.center=CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    containerOpciones.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    [self addSubview:containerOpciones];
    
    bannerOpcionesTaxi=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, containerOpciones.frame.size.width, 60)];
    bannerOpcionesTaxi.center=CGPointMake(containerOpciones.frame.size.width/2, 30);
    [bannerOpcionesTaxi ponerTexto:@"OPCIONES TAXÍMETRO GPS" fuente:[UIFont fontWithName:kFontType size:36] color:[UIColor colorWithRed:0 green:0 blue:0 alpha:1]];
    bannerOpcionesTaxi.backgroundColor=kDarkGrayColor;
    [bannerOpcionesTaxi setCentrado:YES];
    [containerOpciones addSubview:bannerOpcionesTaxi];
    
    contenidoOpcionesView=[[UIView alloc]initWithFrame:CGRectMake(0, bannerOpcionesTaxi.frame.size.height+1, containerOpciones.frame.size.width, containerOpciones.frame.size.height-bannerOpcionesTaxi.frame.size.height)];
    contenidoOpcionesView.backgroundColor=kDarkGrayColor;
    [containerOpciones addSubview:contenidoOpcionesView];
    
    resumenViajeLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(10, bannerOpcionesTaxi.frame.size.height+20, containerOpciones.frame.size.width-100, 30)];
    [resumenViajeLabel ponerTexto:@"Resumen de Viaje" fuente:[UIFont fontWithName:kFontType size:28] color:kWhiteColor];
    [resumenViajeLabel setOverlayOff:YES];
    [containerOpciones addSubview:resumenViajeLabel];
    
    Modelador *mod=[[Modelador alloc]init];
    switchResumen=[[CustomSwitch alloc]initWithFrame:CGRectMake(containerOpciones.frame.size.width-70, bannerOpcionesTaxi.frame.size.height+20, 0, 0)];
    [containerOpciones addSubview:switchResumen];
    [switchResumen addTarget:mod action:@selector(alertSwitch)];
    
    if (!mod.getAlertSwitchValue) {
        [switchResumen onOff:YES];
    }
    else {
        [switchResumen onOff:NO];
    }
    
    estadisticas=[[CustomButton alloc]initWithFrame:CGRectMake(0, 0, containerOpciones.frame.size.width-20, 40)];
    [estadisticas setTitle:@"Estadísticas" forState:UIControlStateNormal];
    estadisticas.titleLabel.font=[UIFont fontWithName:kFontType size:24];
    estadisticas.center=CGPointMake((containerOpciones.frame.size.width/2), bannerOpcionesTaxi.frame.size.height+resumenViajeLabel.frame.size.height+60);
    [containerOpciones addSubview:estadisticas];
    
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
    }
}
/*-(void)alertSwitch{
    
}*/
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
