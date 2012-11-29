//
//  BannerView.h
//  BogoTaxi
//
//  Created by Andres Abril on 22/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomLabel.h"
#import <QuartzCore/QuartzCore.h>
@interface BannerView : UIView{
    UIView *banner;
    CustomLabel *configBannerLabel;
    UIView *triangulito;
    UIView *cuadradoArriba;
}
@property(nonatomic,retain)CustomLabel *configBannerLabel;
-(void)ponerTexto:(NSString*)texto;
-(void)setBannerColor:(UIColor*)color;
@end
