//
//  AlertViewReporta.h
//  BogoTaxi
//
//  Created by Nicolle Jimenez Vasquez on 24/04/13.
//  Copyright (c) 2013 iAmStudio S.A.S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSwitch.h"
#import "CustomLabel.h"
#import "CustomButton.h"

@interface AlertViewReporta : UIView{
    CGRect myFrame;
    UIView *contentView;
    UIView *contentLabel;
    CustomLabel *labelMensaje;
    UIView *contentBotones;
    CustomButton *buttonSi;
    CustomButton *buttonNo;
    int counter;
    BOOL animationFinished;
}
@property(nonatomic,retain) CustomLabel *labelMensaje;
@property(nonatomic,retain) CustomButton *buttonSi;
@property(nonatomic,retain) CustomButton *buttonNo;

-(void)changeState;
-(void)crearView;

@end
