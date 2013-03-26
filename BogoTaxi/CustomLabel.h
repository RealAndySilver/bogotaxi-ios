//
//  CustomLabel.h
//  BogoTaxi
//
//  Created by Andres Abril on 22/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomLabel : UILabel{
    UILabel *overlayLabel;
}
@property(nonatomic,retain) UILabel *overlayLabel;
-(void)ponerTexto:(NSString *)text fuente:(UIFont*)fuente color:(UIColor*)color;
-(void)setOverlayOff:(BOOL)state;
-(void)setCentrado:(BOOL)state;
@end
