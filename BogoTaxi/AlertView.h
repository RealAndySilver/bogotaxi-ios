//
//  AlertView.h
//  BogoTaxi
//
//  Created by Development on 6/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSwitch.h"
#import "CustomLabel.h"
#import "CustomButton.h"

@interface AlertView : UIView{
    CGRect myFrame;
    UIView *contentView;
    UIView *contentLabel;
    CustomLabel *labelMensaje;
    UIView *contentBotones;
    CustomButton *buttonSi;
    CustomButton *buttonNo;
    CustomButton *buttonCancelar;
    int counter;
    BOOL animationFinished;
}
@property(nonatomic,retain) CustomLabel *labelMensaje;
@property(nonatomic,retain) CustomButton *buttonSi;
@property(nonatomic,retain) CustomButton *buttonNo;
@property(nonatomic,retain) CustomButton *buttonCancelar;

-(void)changeState;
-(void)crearView;

@end
