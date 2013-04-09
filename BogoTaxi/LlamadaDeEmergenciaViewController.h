//
//  LlamadaDeEmergenciaViewController.h
//  BogoTaxi
//
//  Created by Development on 9/04/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"
#import "BannerView.h"
#import "CustomLabel.h"
#import "CustomSwitch.h"
#import "Modelador.h"

@interface LlamadaDeEmergenciaViewController : UIViewController<UITextFieldDelegate, UIGestureRecognizerDelegate >{
    int deviceKind;//1=iphone4, 2=iphone5, 3=ipad.
    CustomSwitch *switchLlamada;
    UITextField *textFieldNumero;
    UITapGestureRecognizer *recognizer;
    BOOL tecladoUp;
    Modelador *guardar;
}

@end
