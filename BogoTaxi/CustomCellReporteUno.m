//
//  CustomCellReporteUno.m
//  BogoTaxiLite
//
//  Created by Development on 11/02/13.
//  Copyright (c) 2013 iAmStudio. All rights reserved.
//

#import "CustomCellReporteUno.h"
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

@implementation CustomCellReporteUno
@synthesize labelPositivos, labelNegativos, labelTotal;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andWidth:(float)width
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *viewMessageWrapper=[[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 100)];
        //viewMessageWrapper.backgroundColor=kBlueColor;
        //viewMessageWrapper.layer.borderWidth=1;
        [self addSubview:viewMessageWrapper];
        
        UIView *viewTotalReportes=[[UIView alloc]initWithFrame:CGRectMake(10, 10, (self.frame.size.width/3)-10, 80)];
        viewTotalReportes.center=CGPointMake(viewMessageWrapper.frame.size.width/6, viewMessageWrapper.frame.size.height/2);
        viewTotalReportes.backgroundColor=kBlueColor;
        [viewMessageWrapper addSubview:viewTotalReportes];
        
        UILabel *tituloTotal=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, 90, 25)];
        tituloTotal.center=CGPointMake(viewTotalReportes.frame.size.width/2, 15);
        tituloTotal.textColor=kWhiteColor;
        tituloTotal.text=@"Total reportes";
        tituloTotal.backgroundColor=[UIColor clearColor];
        tituloTotal.font=[UIFont fontWithName:kFontType size:22];
        [viewTotalReportes addSubview:tituloTotal];
        
        labelTotal=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, viewTotalReportes.frame.size.width, 50)];
        labelTotal.center=CGPointMake(viewTotalReportes.frame.size.width/2, 53);
        labelTotal.font=[UIFont fontWithName:kFontType size:50];
        labelTotal.textAlignment=UITextAlignmentCenter;
        labelTotal.backgroundColor=[UIColor clearColor];
        labelTotal.textColor=kWhiteColor;
        labelTotal.textAlignment=NSTextAlignmentCenter;
        //labelTotal.text=@"11";
        [viewTotalReportes addSubview:labelTotal];
        
        UIView *viewReportesNeg=[[UIView alloc]initWithFrame:CGRectMake(viewTotalReportes.frame.size.width+12, 10, (self.frame.size.width/3)-10, 80)];
        viewReportesNeg.center=CGPointMake(viewMessageWrapper.frame.size.width/2, viewMessageWrapper.frame.size.height/2);
        viewReportesNeg.backgroundColor=kLiteRedColor;
        [viewMessageWrapper addSubview:viewReportesNeg];
        
        UILabel *tituloNegativos=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, 65, 25)];
        tituloNegativos.center=CGPointMake(viewReportesNeg.frame.size.width/2, 15);
        tituloNegativos.textColor=kWhiteColor;
        tituloNegativos.text=@"Negativos";
        tituloNegativos.backgroundColor=[UIColor clearColor];
        tituloNegativos.font=[UIFont fontWithName:kFontType size:22];
        [viewReportesNeg addSubview:tituloNegativos];
        
        labelNegativos=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, viewTotalReportes.frame.size.width, 50)];
        labelNegativos.center=CGPointMake(viewTotalReportes.frame.size.width/2, 53);
        labelNegativos.font=[UIFont fontWithName:kFontType size:50];
        labelNegativos.textAlignment=UITextAlignmentCenter;
        labelNegativos.backgroundColor=[UIColor clearColor];
        labelNegativos.textColor=kWhiteColor;
        labelNegativos.textAlignment=NSTextAlignmentCenter;
        //labelNegativos.text=@"11";
        [viewReportesNeg addSubview:labelNegativos];
        
        UIView *viewReportesPos=[[UIView alloc]initWithFrame:CGRectMake(viewTotalReportes.frame.size.width+viewReportesNeg.frame.size.width+14, 10, (self.frame.size.width/3)-10, 80)];
        viewReportesPos.backgroundColor=kGreenColor;
        viewReportesPos.center=CGPointMake(viewMessageWrapper.frame.size.width/2+viewMessageWrapper.frame.size.width/3, viewMessageWrapper.frame.size.height/2);
        [viewMessageWrapper addSubview:viewReportesPos];
        
        UILabel *tituloPositivos=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, 60, 25)];
        tituloPositivos.center=CGPointMake(viewReportesPos.frame.size.width/2, 15);
        tituloPositivos.textColor=kWhiteColor;
        tituloPositivos.text=@"Positivos";
        tituloPositivos.backgroundColor=[UIColor clearColor];
        tituloPositivos.font=[UIFont fontWithName:kFontType size:22];
        [viewReportesPos addSubview:tituloPositivos];
        
        labelPositivos=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, viewTotalReportes.frame.size.width, 50)];
        labelPositivos.center=CGPointMake(viewTotalReportes.frame.size.width/2, 53);
        labelPositivos.font=[UIFont fontWithName:kFontType size:50];
        labelPositivos.textAlignment=UITextAlignmentCenter;
        labelPositivos.backgroundColor=[UIColor clearColor];
        labelPositivos.textColor=kWhiteColor;
        labelPositivos.textAlignment=NSTextAlignmentCenter;
        //labelPositivos.text=@"11";
        [viewReportesPos addSubview:labelPositivos];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
