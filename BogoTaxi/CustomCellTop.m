//
//  CustomCellTop.m
//  BogoTaxiLite
//
//  Created by Nicolle Jimenez Vasquez on 20/02/13.
//  Copyright (c) 2013 iAmStudio. All rights reserved.
//

#import "CustomCellTop.h"
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

@implementation CustomCellTop
@synthesize labelTopPositivos,labelTopNegativos, labelTopPlaca;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andWidth:(float)width
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIView *viewTopWrapper=[[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 73)];
       // viewTopWrapper.backgroundColor=[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1];
        //viewTopWrapper.layer.borderWidth=1;
        //viewTopWrapper.layer.borderColor=[kYellowColor CGColor];
        [self addSubview:viewTopWrapper];
        
        UIView *viewPlaca=[[UIView alloc]initWithFrame:CGRectMake(0, 0, (viewTopWrapper.frame.size.width/2)-10, viewTopWrapper.frame.size.height-10)];
        viewPlaca.center=CGPointMake((viewTopWrapper.frame.size.width/2)/2, viewTopWrapper.frame.size.height/2);
        viewPlaca.backgroundColor=kWhiteColor;
        viewPlaca.layer.shadowColor = [[UIColor colorWithWhite:0.1 alpha:1] CGColor];
        viewPlaca.layer.shadowOffset = CGSizeMake(0.0f,1.0f);
        viewPlaca.layer.shadowRadius = 1;
        viewPlaca.layer.shadowOpacity = 0.8;
        [viewTopWrapper addSubview:viewPlaca];
        
        labelTopPlaca=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, viewPlaca.frame.size.width, 50)];
        labelTopPlaca.center=CGPointMake(viewPlaca.frame.size.width/2, viewPlaca.frame.size.height/2);
        labelTopPlaca.font=[UIFont fontWithName:kFontType size:50];
        labelTopPlaca.textAlignment=UITextAlignmentCenter;
        labelTopPlaca.backgroundColor=[UIColor clearColor];
        labelTopPlaca.textColor=kGrayColor;
        labelTopPlaca.textAlignment=NSTextAlignmentCenter;
        labelTopPlaca.text=@"SXO208";
        [viewPlaca addSubview:labelTopPlaca];
        
        UIView *viewNegativos=[[UIView alloc]initWithFrame:CGRectMake(viewPlaca.frame.size.width+10, 5, ((viewTopWrapper.frame.size.width/2)/2)-15, viewTopWrapper.frame.size.height-10)];
        viewNegativos.backgroundColor=kLiteRedColor;
        [viewTopWrapper addSubview:viewNegativos];
        
        UILabel *tituloNegativos=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 55, 25)];
        tituloNegativos.center=CGPointMake(viewNegativos.frame.size.width/2, 10);
        tituloNegativos.textColor=kWhiteColor;
        tituloNegativos.text=@"Negativos";
        tituloNegativos.backgroundColor=[UIColor clearColor];
        tituloNegativos.font=[UIFont fontWithName:kFontType size:20];
        [viewNegativos addSubview:tituloNegativos];
        
        labelTopNegativos=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, viewNegativos.frame.size.width, 40)];
        labelTopNegativos.center=CGPointMake(viewNegativos.frame.size.width/2, 43);
        labelTopNegativos.font=[UIFont fontWithName:kFontType size:40];
        labelTopNegativos.textAlignment=UITextAlignmentCenter;
        labelTopNegativos.backgroundColor=[UIColor clearColor];
        labelTopNegativos.textColor=kWhiteColor;
        labelTopNegativos.textAlignment=NSTextAlignmentCenter;
        labelTopNegativos.text=@"11";
        [viewNegativos addSubview:labelTopNegativos];
        
        UIView *viewPositivos=[[UIView alloc]initWithFrame:CGRectMake(viewPlaca.frame.size.width+viewNegativos.frame.size.width+15, 5, ((viewTopWrapper.frame.size.width/2)/2)-15, viewTopWrapper.frame.size.height-10)];
       // viewPositivos.center=CGPointMake((viewTopWrapper.frame.size.width/2)+(viewTopWrapper.frame.size.width/6)+(viewTopWrapper.frame.size.width/6), viewTopWrapper.frame.size.height/2);
        viewPositivos.backgroundColor=kGreenColor;
        [viewTopWrapper addSubview:viewPositivos];
        
        UILabel *tituloPositivos=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 55, 25)];
        tituloPositivos.center=CGPointMake(viewNegativos.frame.size.width/2, 10);
        tituloPositivos.textColor=kWhiteColor;
        tituloPositivos.text=@"Positivos";
        tituloPositivos.backgroundColor=[UIColor clearColor];
        tituloPositivos.font=[UIFont fontWithName:kFontType size:20];
        [viewPositivos addSubview:tituloPositivos];
        
        labelTopPositivos=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, viewNegativos.frame.size.width, 40)];
        labelTopPositivos.center=CGPointMake(viewNegativos.frame.size.width/2, 43);
        labelTopPositivos.font=[UIFont fontWithName:kFontType size:40];
        labelTopPositivos.textAlignment=UITextAlignmentCenter;
        labelTopPositivos.backgroundColor=[UIColor clearColor];
        labelTopPositivos.textColor=kWhiteColor;
        labelTopPositivos.textAlignment=NSTextAlignmentCenter;
        labelTopPositivos.text=@"12";
        [viewPositivos addSubview:labelTopPositivos];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
