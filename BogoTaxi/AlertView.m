//
//  AlertView.m
//  BogoTaxi
//
//  Created by Development on 6/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "AlertView.h"
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

@implementation AlertView
@synthesize labelMensaje,buttonSi,buttonNo,buttonCancelar;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha=0;
        myFrame=frame;
    }
    return self;
}
/*-(id)initWithEmpezar{
    if (self=[super init]) {
        
    }
    return self;
}*/
-(void)crearView{
    counter=0;
    animationFinished=NO;
    contentView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width-40, 200)];
    contentView.center=CGPointMake(self.frame.size.width/2, -100);
    contentView.backgroundColor=kDarkRedColor;
    contentView.layer.shadowColor = [[UIColor blackColor] CGColor];
    contentView.layer.shadowOffset = CGSizeMake(0,1);
    contentView.layer.shadowRadius = 1;
    contentView.layer.shadowOpacity = 0.4;
    contentView.layer.cornerRadius=6;
    contentView.layer.masksToBounds=YES;
    //[contentView setClipsToBounds:YES];
    [self addSubview:contentView];
    
    contentLabel=[[UIView alloc]initWithFrame:CGRectMake(2, 2, contentView.frame.size.width-4, contentView.frame.size.height-4)];
    contentLabel.backgroundColor=kDarkRedColor;
    contentLabel.layer.cornerRadius=6;
    [contentView addSubview:contentLabel];
    
    labelMensaje=[[CustomLabel alloc]initWithFrame:CGRectMake(10, 10, contentView.frame.size.width-20, contentView.frame.size.height-70)];
    labelMensaje.backgroundColor=[UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.1];
    //contentLabel.layer.cornerRadius=6;
    [labelMensaje setCentrado:YES];
    labelMensaje.textColor=kWhiteColor;
    labelMensaje.numberOfLines = 3;
    [labelMensaje setOverlayOff:YES];
    [contentView addSubview:labelMensaje];
    
    /*contentLabel=[[UIView alloc]initWithFrame:CGRectMake(0, 141, contentView.frame.size.width, 59)];
    contentLabel.backgroundColor=[UIColor colorWithHue:0 saturation:0.67 brightness:0.94 alpha:0.9];
    contentLabel.layer.shadowOffset = CGSizeMake(0,-1);
    contentLabel.layer.shadowRadius = 1;
    contentLabel.layer.shadowOpacity = 0.3;
    //contentLabel.layer.cornerRadius=6;
    [contentView addSubview:contentLabel];*/
    
    buttonSi=[[CustomButton alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    [buttonSi setTitle:@"Si" forState:UIControlStateNormal];
    buttonSi.titleLabel.font=[UIFont fontWithName:kFontType size:24];
    buttonSi.center=CGPointMake(((contentView.frame.size.width/2)/2)-15, labelMensaje.frame.size.height+40);
    [contentView addSubview:buttonSi];
    
    buttonNo=[[CustomButton alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    [buttonNo setTitle:@"No" forState:UIControlStateNormal];
    buttonNo.titleLabel.font=[UIFont fontWithName:kFontType size:24];
    buttonNo.center=CGPointMake((contentView.frame.size.width/2), labelMensaje.frame.size.height+40);
    [contentView addSubview:buttonNo];
    
    buttonCancelar=[[CustomButton alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    [buttonCancelar setTitle:@"Cancelar" forState:UIControlStateNormal];
    buttonCancelar.titleLabel.font=[UIFont fontWithName:kFontType size:24];
    buttonCancelar.center=CGPointMake(15+(contentView.frame.size.width/2)+(contentView.frame.size.width/2)/2, labelMensaje.frame.size.height+40);
    [contentView addSubview:buttonCancelar];
    
}
-(void)ok{
    contentView.center=CGPointMake(self.frame.size.width/2, -100);
}
-(void)changeState{
    if (animationFinished){
        NSLog(@"alpha 1");
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDidStopSelector:@selector(ok)];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.alpha=0;
        [UIView commitAnimations];
        animationFinished=NO;
        counter=0;
    }
    else {
        [self setUserInteractionEnabled:YES];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2-(counter/3)];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        if (counter%2) {
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        }
        else{
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        }
        if (counter<5) {
            [UIView setAnimationDidStopSelector:@selector(changeState)];
        }
        if (counter==0) {
            contentView.center=CGPointMake(self.frame.size.width/2, (self.frame.size.height/2)+70);
        }
        else if (counter==1){
            contentView.center=CGPointMake(self.frame.size.width/2, (self.frame.size.height/2)-50);
        }
        else if (counter==2){
            contentView.center=CGPointMake(self.frame.size.width/2, (self.frame.size.height/2)+20);
        }
        else if (counter==3){
            contentView.center=CGPointMake(self.frame.size.width/2, (self.frame.size.height/2)-10);
        }
        else if (counter==4){
            contentView.center=CGPointMake(self.frame.size.width/2, (self.frame.size.height/2)+5);
        }
        else if (counter==5){
            contentView.center=CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
            animationFinished=YES;
        }
        
        counter++;
        self.alpha=1;
        [UIView commitAnimations];
        NSLog(@"alpha 0");
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
