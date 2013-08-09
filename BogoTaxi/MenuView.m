//
//  MenuView.m
//  BogoTaxi
//
//  Copyright (c) 2012 iAmStudio S.A.S. All rights reserved.
//

#import "MenuView.h"
#define kFontType @"LeagueGothic"
#define kYellowColor [UIColor colorWithRed:0.30078125 green:0.65234375 blue:0.3984375 alpha:1]
#define kLiteRedColor [UIColor colorWithHue:0 saturation:0.53 brightness:0.95 alpha:1]
#define kDarkRedColor [UIColor colorWithHue:0 saturation:0.67 brightness:0.94 alpha:1]
#define kNightColor [UIColor colorWithRed:0.2265625 green:0.28515625 blue:0.3515625 alpha:1]
#define kGreenColor [UIColor colorWithRed:0.16015625 green:0.97265625 blue:0.65625 alpha:1]
#define kTitleBlueColor [UIColor colorWithRed:0.1484375 green:0.4765625 blue:0.5390625 alpha:1]
#define kBeigeColor [UIColor colorWithRed:1 green:0.984375 blue:0.87890625 alpha:1]
#define kLiteBlueColor [UIColor colorWithRed:0.47265625 green:0.87109375 blue:0.984375 alpha:1]
#define kBlueColor [UIColor colorWithRed:0.50390625 green:0.796875 blue:0.8515625 alpha:1]
#define kDarkGrayColor [UIColor darkGrayColor]
#define kGrayColor [UIColor grayColor]
#define kWhiteColor [UIColor whiteColor]
@implementation MenuView
@synthesize radius = _radius, speed, bounce, bounceSpeed, expanded, transition;
@synthesize mainButton = _mainButton;
@synthesize menuItems = _menuItems;
@synthesize arrayLabels= _arrayLabels;

- (id)initWithFrame:(CGRect)frame menuItems:(NSArray*) menuItems mainButton:(UIButton*) mainButton VCWidth:(float)width VCHeigth:(float)heigth andMenuItemsLabes:(NSArray*) menuItemsLabels{
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha=0;
        myFrame=frame;
        UITapGestureRecognizer *tapRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeState)];
        [self addGestureRecognizer:tapRecognizer];
        
        UIView *background=[[UIView alloc]initWithFrame:myFrame];
        background.backgroundColor=[UIColor blackColor];
        background.alpha=0.7;
        [self addSubview:background];
        
        animationFinished=NO;
        widthFrame=width;
        heigthFrame=heigth;
        self.arrayLabels=menuItemsLabels;
        self.menuItems = menuItems;
        self.mainButton = mainButton;
        self.speed = 0.03;
        self.bounce = 0.225;
        self.bounceSpeed = 0.1;
        expanded = NO;
        transition = NO;
        
        if( self.mainButton != nil ) {
            for (UIView* view in self.menuItems) {
                
                view.center = CGPointMake(-30, heigth-30);
            }
        }
        
    }
    
    
    return self;
}
- (id)init {
    // calling the default init method is not allowed, this will raise an exception if it is called.
    if( self = [super init] ) {
        [self doesNotRecognizeSelector:_cmd];
    }
    return nil;
}
- (void) expand {
    transition = YES;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.mainButton.frame=CGRectMake(-120, self.frame.size.height, 120, 100);
    }];
    
    for (UIView* view in self.menuItems) {
        int objects = self.menuItems.count-1;
        NSLog(@"objects %i",objects);
        int index = [self.menuItems indexOfObject:view];
        CGPoint center = CGPointMake( (((widthFrame-50)/objects)*index+20)+15 , heigthFrame-30);
        [UIView animateWithDuration: self.speed
                              delay: self.speed * (self.menuItems.count-index)
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             view.center = center;
                         }
                         completion:^(BOOL finished){
                             [UIView animateWithDuration:self.bounceSpeed
                                              animations:^{
                                                  CGPoint center = CGPointMake( (((widthFrame-50)/objects)*index)+15 , heigthFrame-30);
                                                  view.center = center;
                                                  
                                              }
                                              completion:^(BOOL finished){
                                                  [UIView animateWithDuration:self.bounceSpeed
                                                                   animations:^{
                                                                       CGPoint center = CGPointMake( (((widthFrame-50)/objects)*index+15)+15 , heigthFrame-30);
                                                                       view.center = center;
                                                                       
                                                                   }
                                                                   completion:^(BOOL finished){
                                                                       [UIView animateWithDuration:self.bounceSpeed
                                                                                        animations:^{
                                                                                            CGPoint center = CGPointMake( (((widthFrame-50)/objects)*index+5)+15 , heigthFrame-30);
                                                                                            view.center = center;
                                                                                            
                                                                                        }
                                                                                        completion:^(BOOL finished){
                                                                                            [UIView animateWithDuration:self.bounceSpeed
                                                                                                             animations:^{
                                                                                                                 CGPoint center = CGPointMake( (((widthFrame-50)/objects)*index+10)+15 , heigthFrame-30);
                                                                                                                 view.center = center;
                                                                                                                 
                                                                                                                 
                                                                                                                 
                                                                                                             }];
                                                                                            if( view == self.menuItems.lastObject ) {
                                                                                                expanded = YES;
                                                                                                transition = NO;
                                                                                            }
                                                                                        }];
                                                                   }];
                                                  
                                              }];
                         }];
    }
    for (UIView* view in self.arrayLabels) {
        int objects=self.arrayLabels.count-1;
        int index = [self.arrayLabels indexOfObject:view];
        [UIView animateWithDuration:self.speed +0.1
                              delay:self.speed * (self.arrayLabels.count-index)
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^ {
                             view.center=CGPointMake( (((widthFrame-50)/objects)*index+10)+15 , heigthFrame-115);
                         }
                         completion:^(BOOL finished){
                             [UIView animateWithDuration:self.bounceSpeed
                                              animations:^{
                                                  view.center=CGPointMake( (((widthFrame-50)/objects)*index+10)+15 , heigthFrame-140);
                                              }
                                              completion:^(BOOL finished){
                                                  [UIView animateWithDuration:self.bounceSpeed
                                                                   animations:^{
                                                                       view.center=CGPointMake( (((widthFrame-50)/objects)*index+10)+15 , heigthFrame-115);
                                                                       
                                                                   }];
                                                  if( view == self.arrayLabels.lastObject ) {
                                                      expanded = YES;
                                                      transition = NO;
                                                  }
                                                  
                                              }];
                             
                         }];
    }
}

- (void) collapse {
    transition = YES;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.mainButton.frame=CGRectMake(-15, self.frame.size.height-80, 120, 100);
    }];
    
    for (UIView* view in self.menuItems) {
        int objects = self.menuItems.count-1;
        int index = [self.menuItems indexOfObject:view];
        //CGFloat oneOverCount = self.menuItems.count<=1?1.0:(1.0/(self.menuItems.count-1));
        [UIView animateWithDuration:self.speed
                              delay:self.speed * index
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             view.center = CGPointMake((((widthFrame-50)/objects)*index+20)+15 , heigthFrame-30);
                         }
                         completion:^(BOOL finished){
                             [UIView animateWithDuration:self.bounceSpeed
                                              animations:^{
                                                  CGPoint center = CGPointMake((((widthFrame-50)/objects)*index)+15 , heigthFrame-30);
                                                  view.center = center;
                                                  
                                              }
                                              completion:^(BOOL finished){
                                                  [UIView animateWithDuration:self.bounceSpeed
                                                                   animations:^{
                                                                       CGPoint center = CGPointMake((((widthFrame-50)/objects)*index+10)+15 , heigthFrame-30);
                                                                       view.center = center;
                                                                       
                                                                       
                                                                   }
                                                                   completion:^(BOOL finished){
                                                                       [UIView animateWithDuration:self.bounceSpeed
                                                                                        animations:^{
                                                                                            CGPoint center = CGPointMake(-30 , heigthFrame-30);
                                                                                            view.center = center;
                                                                                            
                                                                                            
                                                                                        }];
                                                                       if( view == self.menuItems.lastObject ) {
                                                                           expanded = NO;
                                                                           transition = NO;
                                                                       }
                                                                   }];
                                              }];
                         }];
    }
    for (UIView* view in self.arrayLabels) {
        int objects=self.arrayLabels.count-1;
        int index = [self.arrayLabels indexOfObject:view];
        
        [UIView animateWithDuration:self.speed
                              delay:self.speed * index
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^ {
                             view.center=CGPointMake( (((widthFrame-50)/objects)*index+10)+15 , heigthFrame-100);
                         }
                         completion:^(BOOL finished){
                             [UIView animateWithDuration:self.bounceSpeed
                                              animations:^{
                                                  view.center=CGPointMake( (((widthFrame-50)/objects)*index+10)+15 , heigthFrame-130);
                                              }
                                              completion:^(BOOL finished){
                                                  [UIView animateWithDuration:self.bounceSpeed
                                                                   animations:^{
                                                                       view.center=CGPointMake( (((widthFrame-50)/objects)*index+10)+15 , -100);
                                                                   }];
                                                  if( view == self.arrayLabels.lastObject ) {
                                                      expanded = YES;
                                                      transition = NO;
                                                  }
                                                  
                                              }];
                             
                         }];
    }
}

-(void)changeState{
    [self setUserInteractionEnabled:NO];
    if (self.alpha<1) {
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDidStopSelector:@selector(turnOnTouchesAgain)];
        self.alpha=1;
        [UIView commitAnimations];
        [self expand];
        
    }
    else{
        [self collapse];
        [UIView animateWithDuration:0.5 delay:0.03*6 options:UIViewAnimationOptionCurveEaseIn animations:^{self.alpha=0;} completion:^(BOOL finished){}];
    }
}
-(void)turnOnTouchesAgain{
    [self setUserInteractionEnabled:YES];
}

@end
