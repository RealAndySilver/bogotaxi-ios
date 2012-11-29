//
//  CustomButton.m
//  BogoTaxi
//
//  Created by Andres Abril on 23/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "CustomButton.h"
#define kFontType @"LeagueGothic"
#define kYellowColor [UIColor colorWithRed:0.984375 green:0.828125 blue:0.390625 alpha:1]
@implementation CustomButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self=[UIButton buttonWithType:UIButtonTypeCustom];
        self.titleLabel.font=[UIFont fontWithName:kFontType size:20];
        self.backgroundColor=kYellowColor;
        self.frame=frame;
        self.layer.shadowColor = [[UIColor colorWithWhite:0.1 alpha:1] CGColor];
        self.layer.shadowOffset = CGSizeMake(0.0f,1.0f);
        self.layer.shadowRadius = 1;
        self.layer.shadowOpacity = 0.3;
        self.layer.cornerRadius=3;
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];

    }
    return self;
}


@end
