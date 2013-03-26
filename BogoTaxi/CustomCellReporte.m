//
//  CustomCellReporte.m
//  BogoTaxiLite
//
//  Created by Development on 6/02/13.
//  Copyright (c) 2013 iAmStudio. All rights reserved.
//

#import "CustomCellReporte.h"
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

@implementation CustomCellReporte
@synthesize comentario,viewMessage, fecha, viewTipo,labelTipo;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andWidth:(float)width
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *viewMessageWrapper=[[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 100)];
        viewMessageWrapper.backgroundColor=[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1];
        //viewMessageWrapper.layer.borderWidth=1;
        [self addSubview:viewMessageWrapper];
        
        viewTipo=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 50)];
        viewTipo.center=CGPointMake(38, viewMessageWrapper.frame.size.height/2);
        //viewTipo.backgroundColor=[UIColor whiteColor];
        [viewMessageWrapper addSubview:viewTipo];
        
        labelTipo=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 50, 48)];
        labelTipo.textColor=kWhiteColor;
        labelTipo.font = [UIFont fontWithName:kFontType size:45];
        //labelTipo.text=@":(";
        labelTipo.backgroundColor=[UIColor clearColor];
        [viewTipo addSubview:labelTipo];
        
        
        UIView *viewMessageContent=[[UIView alloc]initWithFrame:CGRectMake(viewTipo.frame.size.width-12, 3, viewMessageWrapper.frame.size.width-viewTipo.frame.size.width+4, viewMessageWrapper.frame.size.height-7)];
        viewMessageContent.backgroundColor=[UIColor whiteColor];
        viewMessageContent.layer.shadowColor = [UIColor blackColor].CGColor;
        viewMessageContent.layer.shadowOpacity = 0.8;
        viewMessageContent.layer.shadowOffset = CGSizeMake(0,1);
        viewMessageContent.layer.shadowRadius = 1;
        [viewMessageWrapper addSubview:viewMessageContent];
        
        viewMessage=[[UIView alloc]initWithFrame:CGRectMake(3, 3, viewMessageContent.frame.size.width-6, viewMessageContent.frame.size.height-6)];
        viewMessage.backgroundColor=kBlueColor;
        [viewMessageContent addSubview:viewMessage];
        
        UILabel *tituloComentario=[[UILabel alloc]initWithFrame:CGRectMake(5, 2, 275, 25)];
        tituloComentario.textColor=[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
        tituloComentario.font = [UIFont fontWithName:kFontType size:24];
        tituloComentario.text=@"Comentario:";
        tituloComentario.backgroundColor=[UIColor clearColor];
        [viewMessage addSubview:tituloComentario];
        
        fecha=[[UILabel alloc]initWithFrame:CGRectMake(5, 61, 275, 30)];
        fecha.textColor=[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
        fecha.font = [UIFont fontWithName:kFontType size:12];
        fecha.backgroundColor=[UIColor clearColor];
        [viewMessage addSubview:fecha];
        
        comentario=[[UILabel alloc]initWithFrame:CGRectMake(5, 21, viewMessage.frame.size.width-10, 50)];
        comentario.textColor=kWhiteColor;
        comentario.numberOfLines = 2;
        
        comentario.font = [UIFont fontWithName:kFontType size:17];
        comentario.backgroundColor=[UIColor clearColor];
        [viewMessage addSubview:comentario];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
