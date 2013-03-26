//
//  ViewInformacion.h
//  BogoTaxiLite
//
//  Created by Development on 11/03/13.
//  Copyright (c) 2013 iAmStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewInformacion : UIView

@property (nonatomic,retain) UILabel *labelNombreTaxista;
@property (nonatomic,retain) UILabel *labelTwitterTaxista;
@property (nonatomic,retain) UILabel *labelAsociacionTaxista;
@property (nonatomic,retain) UILabel *labelHoraInicio;
@property (nonatomic,retain) UILabel *labelHoraFin;

- (id)initWithFrame:(CGRect)frame;

@end
