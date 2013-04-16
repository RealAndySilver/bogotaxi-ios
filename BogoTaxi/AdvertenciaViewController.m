//
//  AdvertenciaViewController.m
//  BogoTaxi
//
//  Created by Development on 17/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "AdvertenciaViewController.h"
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

@interface AdvertenciaViewController ()

@end

@implementation AdvertenciaViewController

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
	self.view.backgroundColor=kBlueColor;
    if (self.view.frame.size.height<480) {
        deviceKind=1;
    }
    else if (self.view.frame.size.height>480 && self.view.frame.size.height<560){
        deviceKind=2;
    }
    else if (self.view.frame.size.height>600){
        deviceKind=3;
    }
    BannerView *bannerView=[[BannerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-10, 0)];
    [bannerView ponerTexto:@"ADVERTENCIA"];
    bannerView.configBannerLabel.textColor=[UIColor colorWithRed:0.75390625 green:0.02734375 blue:0.02734375 alpha:1];
    [bannerView.configBannerLabel setOverlayOff:NO];
    [bannerView setBannerColor:[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1]];
    bannerView.center=CGPointMake(self.view.frame.size.width/2, 55);
    [self.view addSubview:bannerView];
    
    
    UIView *containerMensaje=[[UIView alloc]initWithFrame:CGRectMake(0, 0 ,self.view.frame.size.width-10, 210)];
    containerMensaje.backgroundColor=[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1];
    containerMensaje.layer.cornerRadius=3;
    containerMensaje.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    [self.view addSubview:containerMensaje];
    
    
    CustomLabel *mensaje=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, containerMensaje.frame.size.width-20, 200)];
    mensaje.center=CGPointMake(containerMensaje.frame.size.width/2, containerMensaje.frame.size.height/2);
    [mensaje ponerTexto:@"Esta aplicación fue desarrollada como una ayuda para orientar al ciudadano y funciona con el sistema GPS de su dispositivo para poder calcular el recorrido. Este puede no ser del todo preciso y el resultado probablemente tendrá un margen de error. Cualquier duda escríbanos a support@iamstudio.co" fuente:[UIFont fontWithName:kFontType size:22] color:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1]];
    mensaje.numberOfLines = 8;
    mensaje.overlayLabel.numberOfLines=8;
    [mensaje setOverlayOff:YES];
    [containerMensaje addSubview:mensaje];
    
    CustomButton *backButton=[[CustomButton alloc]initWithFrame:CGRectMake(10, self.view.frame.size.height-40, 50, 30)];
    backButton.backgroundColor=kYellowColor;
    [backButton setTitleColor:kGrayColor forState:UIControlStateNormal];
    [backButton setTitle:@"Atrás" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}
-(void)dismissView{
    [self dismissModalViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
