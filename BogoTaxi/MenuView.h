//
//  MenuView.h
//  BogoTaxi
//
//  Created by Andres Abril on 29/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"

@interface MenuView : UIView{

    CGRect myFrame;
    
    float widthFrame;
    float heigthFrame;
    BOOL animationFinished;
}
@property(nonatomic,retain)NSArray *arrayLabels;
@property (retain) UIButton *mainButton;
@property (retain) NSArray *menuItems;
@property CGFloat radius;
@property CGFloat speed;
@property CGFloat bounce;
@property CGFloat bounceSpeed;
@property (readonly) BOOL expanded;
@property (readonly) BOOL transition;

- (id)initWithFrame:(CGRect)frame menuItems:(NSArray*) menuItems mainButton:(UIButton*) mainButton VCWidth:(float)width VCHeigth:(float)heigth andMenuItemsLabes:(NSArray*) menuItemsLabels;
- (void) expand;
- (void) collapse;


-(void)changeState;
@end
