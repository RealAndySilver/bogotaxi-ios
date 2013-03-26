//
//  PanicoViewController.m
//  BogoTaxi
//
//  Created by Development on 14/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "PanicoViewController.h"
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

@interface PanicoViewController ()

@end

@implementation PanicoViewController

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
    CustomButton *backButton=[[CustomButton alloc]initWithFrame:CGRectMake(5, self.view.frame.size.height-50, 80, 40)];
    backButton.backgroundColor=kYellowColor;
    [backButton setTitleColor:kGrayColor forState:UIControlStateNormal];
    [backButton setTitle:@"Cancelar" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    CustomButton *saveButton=[[CustomButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-85, self.view.frame.size.height-50, 80, 40)];
    saveButton.backgroundColor=kYellowColor;
    [saveButton setTitleColor:kGrayColor forState:UIControlStateNormal];
    [saveButton setTitle:@"Guardar" forState:UIControlStateNormal];
    //[saveButton addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
    
    BannerView *bannerView=[[BannerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-10, 0)];
    [bannerView ponerTexto:@"BOTÓN DE PANICO"];
    bannerView.configBannerLabel.textColor=kYellowColor;
    [bannerView.configBannerLabel setOverlayOff:YES];
    [bannerView setBannerColor:kDarkGrayColor];
    bannerView.center=CGPointMake(self.view.frame.size.width/2, 50);
    [self.view addSubview:bannerView];
    
    [self crearContainer];
    
}
-(void)crearContainer{
    labelMensajeUbicacion=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, (self.view.frame.size.width)-20, 70)];
    [labelMensajeUbicacion ponerTexto:@"Ingresa el texto que irá en el mensaje de pánico" fuente:[UIFont fontWithName:kFontType size:28] color:kTitleBlueColor];
    labelMensajeUbicacion.numberOfLines = 2;
    labelMensajeUbicacion.overlayLabel.numberOfLines=2;
    labelMensajeUbicacion.center=CGPointMake(self.view.frame.size.width/2, 120);
    [labelMensajeUbicacion setOverlayOff:NO];
    //[labelMensajeUbicacion setCentrado:YES];
    [self.view addSubview:labelMensajeUbicacion];
    
    textFieldUbicacion = [[UITextField alloc] initWithFrame:CGRectMake(90, 122, 215, 30)];
    textFieldUbicacion.borderStyle = UITextBorderStyleRoundedRect;
    textFieldUbicacion.textColor = kTitleBlueColor;
    textFieldUbicacion.font = [UIFont fontWithName:kFontType size:22];
    textFieldUbicacion.placeholder = @"Mi ubicación actual es";  //place holder
    textFieldUbicacion.backgroundColor = [UIColor whiteColor];
    textFieldUbicacion.autocorrectionType = UITextAutocorrectionTypeNo;
    //textFieldUbicacion.backgroundColor = [UIColor clearColor];
    textFieldUbicacion.keyboardType = UIKeyboardTypeDefault;
    textFieldUbicacion.returnKeyType = UIReturnKeyDone;
    textFieldUbicacion.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:textFieldUbicacion];
    textFieldUbicacion.delegate = self;
    
    labelMensaje=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, (self.view.frame.size.width)-20, 80)];
    [labelMensaje ponerTexto:@"Si no ingresas ningún mensaje la aplicación pondra por defecto ''Mi ubicación actual es''. Tu mensaje siempre llevará una imagen del mapa con tu ubicación actual para que tus seguidores o a quién decidas enviar el mensaje lo pueda ver." fuente:[UIFont fontWithName:kFontType size:16] color:kTitleBlueColor];
    //labelMensaje.backgroundColor=kGreenColor;
    labelMensaje.numberOfLines = 4;
    labelMensaje.overlayLabel.numberOfLines=4;
    labelMensaje.center=CGPointMake(self.view.frame.size.width/2, 200);
    [labelMensaje setOverlayOff:NO];
    //[labelMensaje setCentrado:YES];
    [self.view addSubview:labelMensaje];
    
    labelTitulo=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, (self.view.frame.size.width)-20, 70)];
    [labelTitulo ponerTexto:@"ENVIÓ DEL MENSAJE" fuente:[UIFont fontWithName:kFontType size:40] color:kTitleBlueColor];
    labelTitulo.numberOfLines = 2;
    labelTitulo.overlayLabel.numberOfLines=2;
    labelTitulo.center=CGPointMake(self.view.frame.size.width/2, 270);
    [labelTitulo setOverlayOff:NO];
    [labelTitulo setCentrado:YES];
    [self.view addSubview:labelTitulo];
    
    contentMensajeView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, (self.view.frame.size.width)-10, 110)];
    contentMensajeView.center=CGPointMake(self.view.frame.size.width/2, (self.view.frame.size.height)-113);
    contentMensajeView.backgroundColor=kDarkGrayColor;
    [self.view addSubview:contentMensajeView];
    
    twitterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    twitterView.center=CGPointMake((((contentMensajeView.frame.size.width/2)/2)/2)+5, (contentMensajeView.frame.size.height/2)-10);
    twitterView.backgroundColor=kGreenColor;
    [contentMensajeView addSubview:twitterView];
    
    facebookView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    facebookView.center=CGPointMake((((contentMensajeView.frame.size.width/2)/2)/2)+(((contentMensajeView.frame.size.width/2)/2)/2)+40, (contentMensajeView.frame.size.height/2)-10);
    facebookView.backgroundColor=kLiteRedColor;
    [contentMensajeView addSubview:facebookView];
    
    mailView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    mailView.center=CGPointMake((((contentMensajeView.frame.size.width/2)/2)/2)+(((contentMensajeView.frame.size.width/2)/2)/2)+(((contentMensajeView.frame.size.width/2)/2)/2)+75, (contentMensajeView.frame.size.height/2)-10);
    mailView.backgroundColor=kLiteRedColor;
    [contentMensajeView addSubview:mailView];
    
    smsView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    smsView.center=CGPointMake((((contentMensajeView.frame.size.width/2)/2)/2)+(((contentMensajeView.frame.size.width/2)/2)/2)+(((contentMensajeView.frame.size.width/2)/2)/2)+(((contentMensajeView.frame.size.width/2)/2)/2)+110, (contentMensajeView.frame.size.height/2)-10);
    smsView.backgroundColor=kLiteRedColor;
    [contentMensajeView addSubview:smsView];
    
}
-(void)dismissView{
    [self dismissModalViewControllerAnimated:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
