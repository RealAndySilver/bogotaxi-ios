//
//  EstadisticasViewController.h
//  BogoTaxi
//
//  Created by Development on 12/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"
#import "BannerView.h"
#import "CustomLabel.h"

@interface EstadisticasViewController : UIViewController{
    int deviceKind;//1=iphone4, 2=iphone5, 3=ipad.
    UIView *contentView;
    CustomLabel *labelRecorridos;
    CustomLabel *labelImputRecorridos;
    CustomLabel *labelNoViajes;
    CustomLabel *labelImputNoViajes;
    CustomLabel *labelCantPagada;
    CustomLabel *labelImputCantPagada;
    CustomLabel *labelMinutos;
    CustomLabel *labelImputMinutos;
    CustomButton *reiniciar;
}

@end
