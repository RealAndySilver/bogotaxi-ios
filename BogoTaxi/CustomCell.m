//
//  CustomCell.m
//  BogoTaxi
//
//  Created by Development on 29/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "CustomCell.h"
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

@implementation CustomCell
@synthesize backgroundCell,backgroundOverlay,labelEmpresaTaxi,accessoryCell;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andWidth:(float)width
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        backgroundCell=[[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 55)];
        backgroundCell.backgroundColor=[UIColor colorWithRed:0.3484375 green:0.6765625 blue:0.7390625 alpha:1];
        [self addSubview:backgroundCell];
        
        backgroundOverlay=[[UIView alloc]initWithFrame:CGRectMake(0, 1, backgroundCell.frame.size.width, 54)];
        backgroundOverlay.backgroundColor=kTitleBlueColor;
        //backgroundOverlay.layer.cornerRadius=3;
        [backgroundCell addSubview:backgroundOverlay];
        
        UIView *backgroundOverlay2=[[UIView alloc]initWithFrame:CGRectMake(0, 0, backgroundCell.frame.size.width, 53)];
        backgroundOverlay2.backgroundColor=[UIColor colorWithRed:0.2484375 green:0.5765625 blue:0.6390625 alpha:1];
        [backgroundOverlay addSubview:backgroundOverlay2];
        
        labelEmpresaTaxi=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, (backgroundCell.frame.size.width)-25, (backgroundCell.frame.size.height)-10)];
        labelEmpresaTaxi.textColor=kWhiteColor;
        labelEmpresaTaxi.font=[UIFont fontWithName:kFontType size:24];
        labelEmpresaTaxi.backgroundColor=[UIColor clearColor];
        [backgroundCell addSubview:labelEmpresaTaxi];
        
        accessoryCell=[[UIView alloc]initWithFrame:CGRectMake(width-30, 22, 15, 15)];
        accessoryCell.backgroundColor=kYellowColor;
        accessoryCell.layer.cornerRadius=accessoryCell.frame.size.width/2;
        [self addSubview:accessoryCell];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
