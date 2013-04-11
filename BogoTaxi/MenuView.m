//
//  MenuView.m
//  BogoTaxi
//
//  Created by Andres Abril on 29/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "MenuView.h"
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
@implementation MenuView
@synthesize taximetroGps,taximetroManual,calcular,llamadas,opciones,placa;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha=0;
        myFrame=frame;
        UITapGestureRecognizer *tapRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeState)];
        [self addGestureRecognizer:tapRecognizer];
    }
    return self;
}
-(void)construirMenuConDeviceKind:(int)deviceKind{
    UIView *background=[[UIView alloc]initWithFrame:myFrame];
    background.backgroundColor=[UIColor blackColor];
    background.alpha=0.9;
    [self addSubview:background];
    taximetroGps=[self crearBotonEnPosicion:0 conNombre:@"Taxímetro GPS" yTipo:deviceKind];
    [self addSubview:taximetroGps];
    calcular=[self crearBotonEnPosicion:1 conNombre:@"Calcular" yTipo:deviceKind];
    [self addSubview:calcular];
    placa=[self crearBotonEnPosicion:2 conNombre:@"Enviar Placa" yTipo:deviceKind];
    [self addSubview:placa];
    llamadas=[self crearBotonEnPosicion:3 conNombre:@"Llamadas" yTipo:deviceKind];
    [self addSubview:llamadas];
    taximetroManual=[self crearBotonEnPosicion:4 conNombre:@"Taxímetro Manual" yTipo:deviceKind];
    [self addSubview:taximetroManual];
    opciones=[self crearBotonEnPosicion:5 conNombre:@"Opciones" yTipo:deviceKind];
    [self addSubview:opciones];
}
-(CustomButton*)crearBotonEnPosicion:(int)posicion conNombre:(NSString*)nombre yTipo:(int)tipo{
    CustomButton *temp=[[CustomButton alloc]init];
    int espacio=30;
    if (tipo==2) {
        espacio=20;
    }
    temp.tag=posicion+300;
    temp.frame=CGRectMake(0, 0, (self.frame.size.width/2)-40, (self.frame.size.height/3)-60);
    if (posicion==0) {
        
        temp.center=CGPointMake((self.frame.size.width/2)/2, (((self.frame.size.height/3)/2)+espacio)*(posicion+1));
        
    }
    else if (posicion==2){
        temp.center=CGPointMake((self.frame.size.width/2)/2, (((self.frame.size.height/3)/2)+espacio)*(posicion));
        if (tipo==2) {
            temp.center=CGPointMake((self.frame.size.width/2)/2, (((self.frame.size.height/3)/2)+espacio+20)*(posicion));
        }
        else if (tipo==3){
            temp.center=CGPointMake((self.frame.size.width/2)/2, (((self.frame.size.height/3)/2)+espacio+50)*(posicion));
        }
    }
    else if (posicion==4){
        temp.center=CGPointMake((self.frame.size.width/2)/2, (((self.frame.size.height/3)/2)+espacio)*(posicion-1));
        if (tipo==2) {
            temp.center=CGPointMake((self.frame.size.width/2)/2, (((self.frame.size.height/3)/2)+espacio+27.5)*(posicion-1));
        }
        else if (tipo==3){
            temp.center=CGPointMake((self.frame.size.width/2)/2, (((self.frame.size.height/3)/2)+espacio+68)*(posicion-1));
        }
    }
    
    else if (posicion==1){
        temp.center=CGPointMake((self.frame.size.width/4)*3, (((self.frame.size.height/3)/2)+espacio)*(posicion));
    }
    else if (posicion==3){
        temp.center=CGPointMake((self.frame.size.width/4)*3, (((self.frame.size.height/3)/2)+espacio)*(posicion-1));
        if (tipo==2) {
            temp.center=CGPointMake((self.frame.size.width/4)*3, (((self.frame.size.height/3)/2)+espacio+20)*(posicion-1));
        }
        else if (tipo==3){
            temp.center=CGPointMake((self.frame.size.width/4)*3, (((self.frame.size.height/3)/2)+espacio+50)*(posicion-1));
        }
    }
    else if (posicion==5){
        
        temp.center=CGPointMake((self.frame.size.width/4)*3, (((self.frame.size.height/3)/2)+espacio)*(posicion-2));
        if (tipo==2) {
            temp.center=CGPointMake((self.frame.size.width/4)*3, (((self.frame.size.height/3)/2)+espacio+27.5)*(posicion-2));
        }
        else if (tipo==3){
            temp.center=CGPointMake((self.frame.size.width/4)*3, (((self.frame.size.height/3)/2)+espacio+68)*(posicion-2));
        }
    }
    
    [temp setTitle:nombre forState:UIControlStateNormal];
    [temp setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [temp setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    return temp;
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

@end
