//
//  PanicoViewController.h
//  BogoTaxi
//
//  Created by Development on 14/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"
#import "BannerView.h"
#import "CustomLabel.h"
#import "Modelador.h"

@interface PanicoViewController : UIViewController<UITextFieldDelegate, UIGestureRecognizerDelegate>{
    int deviceKind;//1=iphone4, 2=iphone5, 3=ipad.
    CustomLabel *labelMensajeUbicacion;
    UITextField *textFieldUbicacion;
    CustomLabel *labelMensaje;
    CustomLabel *labelTitulo;
    UIView *contentMensajeView;
    UIButton *buttonTwitter;
    UIButton *buttonFacebook;
    UIButton *buttonMail;
    UIButton *buttonSms;
    UIView *viewDesplazar;
    BOOL banderaDesplazar;
    
    NSString *mensaje;
    BOOL banderaInfo;
    UITextField *tf;
    UITextField *tfMail;
    UITextView *tv;
    UITextView *tvMail;
    
    CustomLabel *redSocialLabel;
    
    CGRect viewFrame;
    CGFloat viewWidth;
    CGFloat viewHeight;
    BOOL tecladoUp;
    UITapGestureRecognizer *recognizer;
   
}
-(NSString *)actualizarMensaje;
-(void)enviarMensaje;
-(void)dismissKeyboard;
-(void)twitterTrigger;
-(void)facebookTrigger;
-(void)mailTrigger;
-(void)smsTrigger;

@end
