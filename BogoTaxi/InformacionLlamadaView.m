//
//  InformacionLlamadaView.m
//  BogoTaxi
//
//  Created by Development on 30/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "InformacionLlamadaView.h"

@implementation InformacionLlamadaView
@synthesize tableView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha=0;
        myFrame=frame;
    }
    return self;
}
-(void)construirInformaconConDeviceKind:(int)deviceKind{
    UIView *background=[[UIView alloc]initWithFrame:myFrame];
    background.backgroundColor=[UIColor blackColor];
    background.alpha=0.9;
    UITapGestureRecognizer *tapRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeState)];
    [background addGestureRecognizer:tapRecognizer];
    [self addSubview:background];
    tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width-10, self.frame.size.height-200)];
    tableView.center=CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    tableView.backgroundColor=[UIColor clearColor];
    [self addSubview:tableView];
}
-(void)changeState{
    if (self.alpha<1) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.alpha=1;
        [UIView commitAnimations];
    }
    else{
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.alpha=0;
        [UIView commitAnimations];
    }
}

@end
