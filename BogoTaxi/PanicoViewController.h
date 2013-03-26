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

@interface PanicoViewController : UIViewController<UITextFieldDelegate>{
    int deviceKind;//1=iphone4, 2=iphone5, 3=ipad.
    CustomLabel *labelMensajeUbicacion;
    UITextField *textFieldUbicacion;
    CustomLabel *labelMensaje;
    CustomLabel *labelTitulo;
    UIView *contentMensajeView;
    UIView *twitterView;
    UIButton *buttonTwitter;
    UIView *facebookView;
    UIButton *buttonFacebook;
    UIView *mailView;
    UIButton *buttonMail;
    UIView *smsView;
    UIButton *buttonSms;
   
}

@end
