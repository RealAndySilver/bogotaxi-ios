//
//  ActualizarTaximetroViewController.h
//  MedeTaxi
//
//  Created by Development on 25/07/13.
//  Copyright (c) 2013 iAmStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"
#import "CustomLabel.h"

@protocol ActualizarTaximetroDelegate
@required
-(void)recargarTaximetro;
@end
@interface ActualizarTaximetroViewController : UIViewController{
}
@property(nonatomic,retain)id<ActualizarTaximetroDelegate> delegate;
@end
