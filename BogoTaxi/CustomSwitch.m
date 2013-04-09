//
//  CustomSwitch.m
//  BogoTaxi
//
//  Created by Andres Abril on 22/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "CustomSwitch.h"

@implementation CustomSwitch
#define kANCHO 60
#define kALTO 30
#define kFontSize 20
#define kFontType @"LeagueGothic"
@synthesize isOn,onLabel,offLabel;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame=CGRectMake(frame.origin.x, frame.origin.y, kANCHO, kALTO);
        [self setUserInteractionEnabled:YES];
        self.backgroundColor=[UIColor clearColor];
        UIView *container=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kANCHO+1, kALTO)];
        container.layer.cornerRadius=kALTO/2;
        [container setClipsToBounds:YES];
        container.backgroundColor=[UIColor whiteColor];
        [self addSubview:container];
        bolita=[[UIView alloc]initWithFrame:CGRectMake(kANCHO/2, 0, kANCHO-2, kANCHO-2)];
        bolita.backgroundColor=[UIColor colorWithRed:0.47265625 green:0.87109375 blue:0.984375 alpha:1];
        bolita.layer.cornerRadius=kALTO/2;
        
        cuadrito=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kANCHO/2, kALTO)];
        cuadrito.backgroundColor=[UIColor clearColor];
        self.onLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 2, kANCHO, kFontSize-3)];
        self.onLabel.textAlignment=UITextAlignmentCenter;
        self.onLabel.backgroundColor=[UIColor clearColor];
        self.onLabel.center=CGPointMake(kANCHO/4, kALTO/2);
        self.onLabel.text=@"On";
        self.onLabel.textColor=[UIColor darkGrayColor];
        self.onLabel.font=[UIFont systemFontOfSize:12];
        self.onLabel.font=[UIFont fontWithName:kFontType size:kFontSize];
        
        
        self.offLabel=[[UILabel alloc]initWithFrame:CGRectMake(28, 2, kANCHO, kFontSize-3)];
        self.offLabel.backgroundColor=[UIColor clearColor];
        self.offLabel.textAlignment=UITextAlignmentCenter;
        self.offLabel.center=CGPointMake(kANCHO-(kANCHO/4), kALTO/2);
        self.offLabel.text=@"Off";
        self.offLabel.textColor=[UIColor darkGrayColor];
        self.offLabel.font=[UIFont fontWithName:kFontType size:kFontSize];
        [container addSubview:self.offLabel];
        [container addSubview:self.onLabel];
        [container addSubview:cuadrito];
        [container addSubview:bolita];
        
        scrollTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cambiarEstado:)];
        [self addGestureRecognizer:scrollTap];
        
        scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kANCHO, kALTO)];
        scrollView.backgroundColor=[UIColor clearColor];
        [scrollView setClipsToBounds:NO];
        [scrollView setPagingEnabled:YES];
        [scrollView setShowsHorizontalScrollIndicator:NO];
        [scrollView setBounces:NO];
        scrollView.layer.masksToBounds=NO;
        scrollView.contentSize=CGSizeMake((kANCHO*2), kALTO);
        scrollView.delegate=self;
        [container addSubview:scrollView];
        [self cambiarEstado:nil];
    }
    return self;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView1{
    bolita.frame=CGRectMake((31)+(scrollView.contentOffset.x/2)*-1, 0.5, (kANCHO-2)/2, (kANCHO-2)/2);
    cuadrito.frame=CGRectMake(0, 0, bolita.center.x, kALTO);
    int roundedValue = round(scrollView.contentOffset.x / scrollView.frame.size.width);
    if (roundedValue==1) {
        isOn = NO;
        [self animarColorUno];
        //[self setUserInteractionEnabled:NO];
    }
    else{
        isOn = YES;
        [self animarColorDos];
        //[self setUserInteractionEnabled:NO];
    }
}
-(void)onOff:(BOOL)on{
    if (!on) {
        isOn=on;
        //[self animarColorDos];
        [scrollView setContentOffset:CGPointMake(60, 0)];
    }
    else{
        isOn=on;
        [self animarColorUno];
        [scrollView setContentOffset:CGPointMake(0, 0)];
    }
    //[self scrollViewDidScroll:scrollView];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView1 willDecelerate:(BOOL)decelerate{
    [self setUserInteractionEnabled:YES];
    [self callSelector];
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView1{
    [self setUserInteractionEnabled:YES];
    [self callSelector];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self setUserInteractionEnabled:YES];
    [self callSelector];
}
-(void)callSelector{
    if ([targetClass respondsToSelector:delegatedSelector]) {
        [targetClass performSelector:delegatedSelector withObject:self];
    }
}
-(void)cambiarEstado:(UIScrollView*)scrollview1{
    [self setUserInteractionEnabled:NO];
    if (scrollView.contentOffset.x>40) {
        [scrollView setContentOffset:CGPointMake(0, 0.0f) animated:YES];
    }
    else{
        [scrollView setContentOffset:CGPointMake(60, 0.0f) animated:YES];
    }
}
-(void)animarColorUno{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    bolita.backgroundColor=[UIColor grayColor];
    [UIView commitAnimations];
}
-(void)animarColorDos{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    bolita.backgroundColor=[UIColor colorWithRed:0.47265625 green:0.87109375 blue:0.984375 alpha:1];
    [UIView commitAnimations];
}
-(void)addTarget:(id)target action:(SEL)selector{
    if ([target respondsToSelector:selector]) {
        targetClass=target;
        delegatedSelector=selector;
    }
}

@end
