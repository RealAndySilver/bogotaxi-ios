//
//  AlertMessageView.h
//  BogoTaxi
//
//  Created by Development on 13/12/12.
//  Copyright (c) 2012 iAmStudio S.A.S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSwitch.h"
#import "CustomLabel.h"
#import "CustomButton.h"

@interface AlertMessageView : UIView{
    CGRect myFrame;
    UIView *contentView;
    UIView *contentLabel;
    CustomLabel *labelMensaje;
    UIView *contentBotones;
    CustomButton *buttonOk;
}
@property(nonatomic,retain) CustomLabel *labelMensaje;
-(void)changeState;
-(void)crearView;
@end
