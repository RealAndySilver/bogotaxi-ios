//
//  CustomCellCiudades.m
//  MedeTaxi
//
//  Created by Development on 30/07/13.
//  Copyright (c) 2013 iAmStudio. All rights reserved.
//

#import "CustomCellCiudades.h"
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

@implementation CustomCellCiudades
@synthesize viewMessage,labelCiudad;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andWidth:(float)width
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *viewMessageWrapper=[[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 60)];
        viewMessageWrapper.backgroundColor=[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1];
        //viewMessageWrapper.layer.borderWidth=1;
        [self addSubview:viewMessageWrapper];
        
        UIView *viewMessageContent=[[UIView alloc]initWithFrame:CGRectMake(7, 7, viewMessageWrapper.frame.size.width-24, viewMessageWrapper.frame.size.height-11)];
        viewMessageContent.backgroundColor=kWhiteColor;
        viewMessageContent.layer.shadowColor = [UIColor blackColor].CGColor;
        viewMessageContent.layer.shadowOpacity = 0.8;
        viewMessageContent.layer.shadowOffset = CGSizeMake(0,1);
        viewMessageContent.layer.shadowRadius = 1;
        [viewMessageWrapper addSubview:viewMessageContent];
        
        viewMessage=[[UIView alloc]initWithFrame:CGRectMake(3, 3, viewMessageContent.frame.size.width-6, viewMessageContent.frame.size.height-6)];
        viewMessage.backgroundColor=kBeigeColor;
        [viewMessageContent addSubview:viewMessage];
        
        
        labelCiudad=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, viewMessage.frame.size.width-10, 50)];
        labelCiudad.center=CGPointMake(viewMessage.frame.size.width/2, viewMessage.frame.size.height/2);
        labelCiudad.textColor=[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
        labelCiudad.numberOfLines = 2;
        labelCiudad.font = [UIFont fontWithName:kFontType size:30];
        labelCiudad.backgroundColor=[UIColor clearColor];
        [viewMessage addSubview:labelCiudad];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
