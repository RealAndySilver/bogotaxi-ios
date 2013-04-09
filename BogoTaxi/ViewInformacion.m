//
//  ViewInformacion.m
//  BogoTaxiLite
//
//  Created by Development on 11/03/13.
//  Copyright (c) 2013 iAmStudio. All rights reserved.
//

#import "ViewInformacion.h"
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

@implementation ViewInformacion
@synthesize labelNombreTaxista,labelTwitterTaxista,labelAsociacionTaxista,labelHoraInicio,labelHoraFin;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *labelTituloInformacion=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 35)];
        labelTituloInformacion.center=CGPointMake(self.frame.size.width/2, 22);
        labelTituloInformacion.text=@"INFORMACIÓN TAXISTA";
        labelTituloInformacion.textAlignment=UITextAlignmentCenter;
        labelTituloInformacion.textAlignment=NSTextAlignmentCenter;
        labelTituloInformacion.backgroundColor=[UIColor clearColor];
        labelTituloInformacion.textColor=kYellowColor;
        /*labelTituloInformacion.layer.shadowColor= [UIColor whiteColor].CGColor;
        labelTituloInformacion.layer.shadowOpacity = 0.8;
        labelTituloInformacion.layer.shadowOffset = CGSizeMake(1,1);
        labelTituloInformacion.layer.shadowRadius = 0.1;*/
        labelTituloInformacion.font=[UIFont fontWithName:kFontType size:30];
        [self addSubview:labelTituloInformacion];
        
        labelNombreTaxista=[[UILabel alloc]initWithFrame:CGRectMake(5, 40, self.frame.size.width-10, 30)];
        labelNombreTaxista.text=@"Nombre:";
        labelNombreTaxista.font=[UIFont fontWithName:kFontType size:24];
        labelNombreTaxista.backgroundColor=kBeigeColor;
        labelNombreTaxista.textAlignment=UITextAlignmentCenter;
        labelNombreTaxista.textAlignment=NSTextAlignmentCenter;
        labelNombreTaxista.textColor=kDarkGrayColor;
        [self addSubview:labelNombreTaxista];
        
        labelTwitterTaxista=[[UILabel alloc]initWithFrame:CGRectMake(5, 75, self.frame.size.width-10, 30)];
        labelTwitterTaxista.text=@"Twitter:";
        labelTwitterTaxista.font=[UIFont fontWithName:kFontType size:24];
        labelTwitterTaxista.textAlignment=UITextAlignmentCenter;
        labelTwitterTaxista.textAlignment=NSTextAlignmentCenter;
        labelTwitterTaxista.textColor=kDarkGrayColor;
        labelTwitterTaxista.backgroundColor=kBeigeColor;
        [self addSubview:labelTwitterTaxista];
        
        labelAsociacionTaxista=[[UILabel alloc]initWithFrame:CGRectMake(5, 110, self.frame.size.width-10, 30)];
        labelAsociacionTaxista.text=@"Asociación:";
        labelAsociacionTaxista.font=[UIFont fontWithName:kFontType size:24];
        labelAsociacionTaxista.textAlignment=UITextAlignmentCenter;
        labelAsociacionTaxista.textAlignment=NSTextAlignmentCenter;
        labelAsociacionTaxista.textColor=kDarkGrayColor;
        labelAsociacionTaxista.backgroundColor=kBeigeColor;
        [self addSubview:labelAsociacionTaxista];
        
        labelHoraInicio=[[UILabel alloc]initWithFrame:CGRectMake(5, 145, self.frame.size.width-10, 30)];
        labelHoraInicio.text=@"Hora Inicio: ";
        labelHoraInicio.font=[UIFont fontWithName:kFontType size:24];
        labelHoraInicio.textAlignment=UITextAlignmentCenter;
        labelHoraInicio.textAlignment=NSTextAlignmentCenter;
        labelHoraInicio.textColor=kDarkGrayColor;
        labelHoraInicio.backgroundColor= kBeigeColor;
        [self addSubview:labelHoraInicio];
        
        labelHoraFin=[[UILabel alloc]initWithFrame:CGRectMake(5, 180, self.frame.size.width-10, 30)];
        labelHoraFin.text=@"Hora Fin: ";
        labelHoraFin.font=[UIFont fontWithName:kFontType size:24];
        labelHoraFin.textAlignment=UITextAlignmentCenter;
        labelHoraFin.textAlignment=NSTextAlignmentCenter;
        labelHoraFin.textColor=kDarkGrayColor;
        labelHoraFin.backgroundColor=kBeigeColor;
        [self addSubview:labelHoraFin];
    }
    return self;
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
