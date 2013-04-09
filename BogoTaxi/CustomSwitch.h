//
//  CustomSwitch.h
//  BogoTaxi
//
//  Created by Andres Abril on 22/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CustomSwitch : UIView<UIScrollViewDelegate>{
    UIScrollView *scrollView;
    UIView *bolita;
    UIView *cuadrito;
    UITapGestureRecognizer *scrollTap;
    
    SEL delegatedSelector;
    id targetClass;
    
}
@property(nonatomic,readonly)BOOL isOn;
@property(nonatomic,retain)UILabel *onLabel;
@property(nonatomic,retain)UILabel *offLabel;
-(void)addTarget:(id)target action:(SEL)selector;
-(void)onOff:(BOOL)on;
@end
