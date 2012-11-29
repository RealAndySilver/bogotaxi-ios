//
//  BannerView.m
//  BogoTaxi
//
//  Created by Andres Abril on 22/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "BannerView.h"
#define kFontType @"LeagueGothic"
#define kYellowColor [UIColor colorWithRed:0.984375 green:0.828125 blue:0.390625 alpha:1]

@implementation BannerView
@synthesize configBannerLabel;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame=CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 85);
        self.backgroundColor=[UIColor clearColor];
        banner=[[UIView alloc]initWithFrame:CGRectMake(0,0, frame.size.width, 60)];
        banner.backgroundColor=[UIColor whiteColor];
        banner.layer.shadowColor = [[UIColor colorWithWhite:0.1 alpha:1] CGColor];
        banner.layer.shadowOffset = CGSizeMake(0.0f,1.0f);
        banner.layer.shadowRadius = 1;
        banner.layer.shadowOpacity = 0.3;
        [self addSubview:banner];
        
        cuadradoArriba=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        cuadradoArriba.center=CGPointMake(banner.frame.size.width/2, banner.frame.size.height-25);
        cuadradoArriba.backgroundColor=[UIColor whiteColor];
        
        triangulito=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
        triangulito.center=CGPointMake(banner.frame.size.width/2, banner.frame.size.height);
        CGAffineTransform rotarTriangulito = CGAffineTransformMakeRotation(0.8);
        triangulito.transform = rotarTriangulito;
        triangulito.backgroundColor=[UIColor redColor];
        triangulito.backgroundColor=[UIColor whiteColor];
        triangulito.layer.shadowColor = [[UIColor colorWithWhite:0.1 alpha:1] CGColor];
        triangulito.layer.shadowOffset = CGSizeMake(0.0f,1.0f);
        triangulito.layer.shadowRadius = 1;
        triangulito.layer.shadowOpacity = 0.3;
        triangulito.layer.shouldRasterize=YES;
        [banner addSubview:triangulito];
        [banner addSubview:cuadradoArriba];
        configBannerLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(0,7, self.frame.size.width, 50)];
        [configBannerLabel setCentrado:YES];
        [banner addSubview:configBannerLabel];
    }
    return self;
}
-(void)ponerTexto:(NSString*)texto{
    [configBannerLabel ponerTexto:texto fuente:[UIFont fontWithName:kFontType size:45] color:kYellowColor];
}
-(void)setBannerColor:(UIColor *)color{
    cuadradoArriba.backgroundColor=triangulito.backgroundColor=banner.backgroundColor=color;
}
@end
