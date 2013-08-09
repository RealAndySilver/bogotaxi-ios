//
//  ActualizarTaximetroViewController.m
//  MedeTaxi
//
//  Created by Development on 25/07/13.
//  Copyright (c) 2013 iAmStudio. All rights reserved.
//

#import "ActualizarTaximetroViewController.h"
#define kFontType @"LeagueGothic"
#define kYellowColor [UIColor colorWithRed:0.984375 green:0.828125 blue:0.390625 alpha:1]
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

@interface ActualizarTaximetroViewController ()

@end

@implementation ActualizarTaximetroViewController
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1];
    
    UIView *viewContentWrapper=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-10, 140)];
    viewContentWrapper.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    [self.view addSubview:viewContentWrapper];
    
    UIButton *ActualizarButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    ActualizarButton.center=CGPointMake(viewContentWrapper.frame.size.width/2, (viewContentWrapper.frame.size.height/2)+48);
    ActualizarButton.backgroundColor=kDarkRedColor;
    [ActualizarButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [ActualizarButton setTitle:@"Actualizar" forState:UIControlStateNormal];
    ActualizarButton.titleLabel.font=[UIFont fontWithName:kFontType size:24];
    [ActualizarButton addTarget:self action:@selector(actualizarTaximetro) forControlEvents:UIControlEventTouchUpInside];
    [viewContentWrapper addSubview:ActualizarButton];
    
    
    UIView *viewContent=[[UIView alloc]initWithFrame:CGRectMake(5, 0, viewContentWrapper.frame.size.width-10, 100)];
    viewContent.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    viewContent.layer.shadowColor = [[UIColor colorWithWhite:0.1 alpha:1] CGColor];
    viewContent.layer.shadowOffset = CGSizeMake(0.0f,1.0f);
    viewContent.layer.shadowRadius = 1;
    viewContent.layer.shadowOpacity = 0.3;
    [viewContentWrapper addSubview:viewContent];
    
    UIView *viewMarco=[[UIView alloc]initWithFrame:CGRectMake(5, 5, viewContent.frame.size.width-10, viewContent.frame.size.height-10)];
    viewMarco.backgroundColor=kBlueColor;
    [viewContent addSubview:viewMarco];
    
    CustomLabel *labelActualizar=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, viewContent.frame.size.width-10, 80)];
    labelActualizar.center=CGPointMake(viewContent.frame.size.width/2, viewContent.frame.size.height/2);
    [labelActualizar ponerTexto:@"Hay actualizaciones nuevas para tu taxímetro." fuente:[UIFont fontWithName:kFontType size:30] color:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1]];
    labelActualizar.numberOfLines = 2;
    labelActualizar.textAlignment=NSTextAlignmentCenter;
    labelActualizar.overlayLabel.numberOfLines=2;
    labelActualizar.overlayLabel.textAlignment=NSTextAlignmentCenter;
    [labelActualizar setOverlayOff:YES];
    [viewContent addSubview:labelActualizar];
    
	
}
-(void)actualizarTaximetro{
    [self.delegate recargarTaximetro];
    [self dismissView];
}
-(void)dismissView{
    [self dismissModalViewControllerAnimated:YES];
}


@end
