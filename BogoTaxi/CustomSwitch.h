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
}
@property(nonatomic,readonly)BOOL isOn;
@end
