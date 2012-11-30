//
//  InformacionLlamadaView.h
//  BogoTaxi
//
//  Created by Development on 30/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformacionLlamadaView : UIView{
    CGRect myFrame;
}
-(void)changeState;
-(void)construirInformaconConDeviceKind:(int)deviceKind;

@end
