//
//  DetailReporteViewController.h
//  BogoTaxiLite
//
//  Created by Development on 12/02/13.
//  Copyright (c) 2013 iAmStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Reportes.h"
@interface DetailReporteViewController : UIViewController{
    int deviceKind;//1=iphone4, 2=iphone5, 3=ipad.
    
}
@property(nonatomic,retain) UIView *viewMessage;
@property(nonatomic,retain) UIView *viewTipo;
@property(nonatomic,retain) UILabel *labelTipo;
@property (nonatomic,retain) UILabel *fecha;
@property (nonatomic,retain) UITextView *comentario;
@property(nonatomic,retain)Reportes *reporte;
@end
