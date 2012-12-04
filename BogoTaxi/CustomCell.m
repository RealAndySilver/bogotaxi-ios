//
//  CustomCell.m
//  BogoTaxi
//
//  Created by Development on 29/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "CustomCell.h"
#define kFontType @"LeagueGothic"
#define kTitleBlueColor [UIColor colorWithRed:0.1484375 green:0.4765625 blue:0.5390625 alpha:1]
#define kLiteRedColor [UIColor colorWithHue:0 saturation:0.53 brightness:0.95 alpha:1]
#define kYellowColor [UIColor colorWithRed:0.984375 green:0.828125 blue:0.390625 alpha:1]

@implementation CustomCell
@synthesize backgroundCell,backgroundOverlay,labelEmpresaTaxi,accessoryCell;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        backgroundCell=[[UIView alloc]initWithFrame:CGRectMake(5, 5, (self.frame.size.width)-10, 45)];
        backgroundCell.backgroundColor=kTitleBlueColor;
        backgroundCell.layer.cornerRadius=3;
        [self addSubview:backgroundCell];
        
        backgroundOverlay=[[UIView alloc]initWithFrame:CGRectMake(6, 6, (self.frame.size.width)-10, 45)];
        backgroundOverlay.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
        backgroundOverlay.layer.cornerRadius=3;
        [self addSubview:backgroundOverlay];
        
        labelEmpresaTaxi=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, (backgroundCell.frame.size.width)-25, (backgroundCell.frame.size.height)-10)];
        labelEmpresaTaxi.textColor=[UIColor whiteColor];
        labelEmpresaTaxi.font=[UIFont fontWithName:kFontType size:22];
        labelEmpresaTaxi.backgroundColor=[UIColor clearColor];
        [backgroundCell addSubview:labelEmpresaTaxi];
        
        accessoryCell=[[UIView alloc]initWithFrame:CGRectMake((self.frame.size.width)-30, 22, 15, 15)];
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
