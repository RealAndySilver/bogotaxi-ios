//
//  TaximetroManualViewController.h
//  BogoTaxi
//
//  Created by Andres Abril on 23/11/12.
//  Copyright (c) 2013 iAmStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"
#import "CustomSwitch.h"
#import "CustomLabel.h"
#import "BannerView.h"
#import "Taximetro.h"

@interface TaximetroManualViewController : UIViewController{
    int deviceKind;//1=iphone4, 2=iphone5, 3=ipad.

    CustomLabel *configTituloLabel;
    UIView *containerConfig;
    CustomLabel *nocDomFesLabel;
    CustomSwitch *nocDomFesSwitch;
    CustomLabel *aeropuertoLabel;
    CustomSwitch *aeropuertoSwitch;
    CustomLabel *puertaApuertaLabel;
    CustomSwitch *puertaApuertaSwitch;
    CustomLabel *terminalLabel;
    CustomSwitch *terminalSwitch;
    
    CustomLabel *labelUnidades;
    CustomLabel *valorInputLabel;
    Taximetro *taximetro;
    UISlider *slider;
}

@end
