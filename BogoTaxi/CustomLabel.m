//
//  CustomLabel.m
//  BogoTaxi
//
//  Created by Andres Abril on 22/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        overlayLabel=[[UILabel alloc]initWithFrame:CGRectMake(1,1,frame.size.width,frame.size.height)];
        overlayLabel.backgroundColor=[UIColor clearColor];
        overlayLabel.textColor=[UIColor whiteColor];
        overlayLabel.alpha=0.25;
        [self addSubview:overlayLabel];
    }
    return self;
}
-(void)ponerTexto:(NSString *)text fuente:(UIFont*)fuente color:(UIColor*)color{
    self.text=overlayLabel.text=text;
    self.textColor=color;
    self.font=overlayLabel.font=fuente;
}
-(void)setOverlayOff:(BOOL)state{
    if (state) {
        overlayLabel.alpha=0;
    }
    else{
        overlayLabel.alpha=0.25;
    }
}
-(void)setCentrado:(BOOL)state{
    if (state) {
        self.textAlignment=overlayLabel.textAlignment=UITextAlignmentCenter;
    }
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
