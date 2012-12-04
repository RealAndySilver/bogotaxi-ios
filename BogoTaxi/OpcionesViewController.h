//
//  OpcionesViewController.h
//  BogoTaxi
//
//  Created by Development on 4/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BannerView.h"
#import "CustomButton.h"

@interface OpcionesViewController : UIViewController{
    int deviceKind;
    CustomLabel *configTituloLabel;
    UIView *containerView;
    CustomButton *opcionesTaxi;
    CustomButton *compartirGPS;
    CustomButton *contacto;
}

@end
