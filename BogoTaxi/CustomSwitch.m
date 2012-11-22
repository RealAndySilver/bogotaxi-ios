//
//  CustomSwitch.m
//  BogoTaxi
//
//  Created by Andres Abril on 22/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "CustomSwitch.h"

@implementation CustomSwitch
#define kANCHO 50
#define kALTO 25
#define kFontSize 15
@synthesize isOn;
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
        UILabel *onLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 2, kANCHO, kFontSize-3)];
        onLabel.textAlignment=UITextAlignmentCenter;
        onLabel.backgroundColor=[UIColor clearColor];
        onLabel.center=CGPointMake(kANCHO/4, kALTO/2);
        onLabel.text=@"On";
        onLabel.textColor=[UIColor darkGrayColor];
        onLabel.font=[UIFont systemFontOfSize:12];
        onLabel.font=[UIFont fontWithName:@"LeagueGothic" size:kFontSize];

        
        UILabel *onLabel2=[[UILabel alloc]initWithFrame:CGRectMake(28, 2, kANCHO, kFontSize-3)];
        onLabel2.backgroundColor=[UIColor clearColor];
        onLabel2.textAlignment=UITextAlignmentCenter;
        onLabel2.center=CGPointMake(kANCHO-(kANCHO/4), kALTO/2);
        onLabel2.text=@"Off";
        onLabel2.textColor=[UIColor darkGrayColor];
        onLabel2.font=[UIFont fontWithName:@"LeagueGothic" size:kFontSize];
        [container addSubview:onLabel2];
        [container addSubview:onLabel];
        [container addSubview:cuadrito];
        [container addSubview:bolita];
        
        

        
        UITapGestureRecognizer *scrollTap=[[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                 action:@selector(cambiarEstado:)];
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
    //CGRect frame=[[UIScreen mainScreen] applicationFrame];
    bolita.frame=CGRectMake((26)+(scrollView.contentOffset.x/2)*-1, 0.5, (kANCHO-2)/2, (kANCHO-2)/2);
    cuadrito.frame=CGRectMake(0, 0, bolita.center.x, kALTO);
    int roundedValue = round(scrollView.contentOffset.x / self.frame.size.height);
    if (roundedValue==2) {
        isOn = NO;
    }
    else{
        isOn = YES;
    }
    NSLog(@"Is On %i",(int)isOn);
}
-(void)cambiarEstado:(UIScrollView*)scrollview{
    NSLog(@"Toque");
    if (scrollView.contentOffset.x>40) {
        [scrollView setContentOffset:CGPointMake(0, 0.0f) animated:YES];
    }
    else{
        [scrollView setContentOffset:CGPointMake(50, 0.0f) animated:YES];
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
