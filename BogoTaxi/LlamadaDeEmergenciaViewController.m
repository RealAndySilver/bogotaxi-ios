//
//  LlamadaDeEmergenciaViewController.m
//  BogoTaxi
//
//  Created by Development on 9/04/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import "LlamadaDeEmergenciaViewController.h"
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

@interface LlamadaDeEmergenciaViewController ()

@end

@implementation LlamadaDeEmergenciaViewController

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
    self.view.backgroundColor=kTitleBlueColor;
	// Do any additional setup after loading the view.
    recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(processTap:)];
    recognizer.delegate=self;
    [self.view setUserInteractionEnabled:YES];
    [self.view addGestureRecognizer:recognizer];
    
    if (self.view.frame.size.height<480) {
        deviceKind=1;
    }
    else if (self.view.frame.size.height>480 && self.view.frame.size.height<560){
        deviceKind=2;
    }
    else if (self.view.frame.size.height>600){
        deviceKind=3;
    }
    guardar=[[Modelador alloc]init];
    BannerView *bannerView=[[BannerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-10, 0)];
    [bannerView ponerTexto:@"LLAMADA EMERGENCIA"];
    bannerView.configBannerLabel.textColor=kYellowColor;
    [bannerView.configBannerLabel setOverlayOff:YES];
    [bannerView setBannerColor:kDarkGrayColor];
    bannerView.center=CGPointMake(self.view.frame.size.width/2, 50);
    [self.view addSubview:bannerView];
    
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
    [saveButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
    
    UIView *viewLlamada123=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-10, 40)];
    viewLlamada123.backgroundColor=kDarkGrayColor;
    if (deviceKind==3) {
        viewLlamada123.center=CGPointMake(self.view.frame.size.width/2, 385);
    }
    else{
        viewLlamada123.center=CGPointMake(self.view.frame.size.width/2, 135);
    }
    viewLlamada123.layer.shadowColor = [UIColor blackColor].CGColor;
    viewLlamada123.layer.shadowOpacity = 0.8;
    viewLlamada123.layer.shadowOffset = CGSizeMake(0,1);
    viewLlamada123.layer.shadowRadius = 1;
    [self.view addSubview:viewLlamada123];
    
    CustomLabel *label123=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, viewLlamada123.frame.size.width/2, 30)];
    [label123 ponerTexto:@"Llamada al 123" fuente:[UIFont fontWithName:kFontType size:24] color:[UIColor colorWithRed:0 green:0 blue:0 alpha:1]];
    //label123.overlayLabel.numberOfLines=1;
    label123.center=CGPointMake(57, viewLlamada123.frame.size.height/2);
    [label123 setCentrado:YES];
    [label123 setOverlayOff:NO];
    [viewLlamada123 addSubview:label123];
    
    switchLlamada=[[CustomSwitch alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    switchLlamada.center=CGPointMake(viewLlamada123.frame.size.width-40, viewLlamada123.frame.size.height/2);
    [viewLlamada123 addSubview:switchLlamada];
    
    UIView *viewNumeroPerso=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-10, 40)];
    viewNumeroPerso.backgroundColor=kDarkGrayColor;
    if (deviceKind==3) {
        viewNumeroPerso.center=CGPointMake(self.view.frame.size.width/2, 430);
    }
    else{
        viewNumeroPerso.center=CGPointMake(self.view.frame.size.width/2, 180);
    }
    viewNumeroPerso.layer.shadowColor = [UIColor blackColor].CGColor;
    viewNumeroPerso.layer.shadowOpacity = 0.8;
    viewNumeroPerso.layer.shadowOffset = CGSizeMake(0,1);
    viewNumeroPerso.layer.shadowRadius = 1;
    [self.view addSubview:viewNumeroPerso];
    
    CustomLabel *labelNumeroUser=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, 50+(viewNumeroPerso.frame.size.width/2), 65)];
    [labelNumeroUser ponerTexto:@"Numero personalizado" fuente:[UIFont fontWithName:kFontType size:24] color:[UIColor colorWithRed:0 green:0 blue:0 alpha:1]];
    labelNumeroUser.center=CGPointMake(82, viewNumeroPerso.frame.size.height/2);
    [labelNumeroUser setCentrado:YES];
    [labelNumeroUser setOverlayOff:NO];
    [viewNumeroPerso addSubview:labelNumeroUser];
    
    textFieldNumero=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, 130, 30)];
    textFieldNumero.center=CGPointMake(viewLlamada123.frame.size.width-72, viewNumeroPerso.frame.size.height/2);
    textFieldNumero.borderStyle = UITextBorderStyleRoundedRect;
    textFieldNumero.textColor = kDarkGrayColor;
    textFieldNumero.font = [UIFont fontWithName:kFontType size:22];
    textFieldNumero.placeholder = @"# Predeterminado";  //place holder
    textFieldNumero.backgroundColor = [UIColor whiteColor];
    textFieldNumero.autocorrectionType = UITextAutocorrectionTypeNo;
    textFieldNumero.returnKeyType = UIReturnKeyDone;
    textFieldNumero.keyboardType = UIKeyboardTypeNumberPad;
    textFieldNumero.clearButtonMode = UITextFieldViewModeWhileEditing;
    textFieldNumero.textAlignment=UITextAlignmentRight;
    [viewNumeroPerso addSubview:textFieldNumero];
    
    CustomLabel *labelMensaje=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-20, 150)];
    if (deviceKind==3) {
        labelMensaje.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    }
    else{
        labelMensaje.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height-150);
    }
    [labelMensaje ponerTexto:@"Personaliza el numero al que desees llamar en caso de alguna emergencia, este aparecera en la sección \"Taximetro GPS\" mientras hayas ingresado algún número. También puedes activar o desactivar el ícono de llamada al 123. Recuerda siempre guardar los cambios realizados. " fuente:[UIFont fontWithName:kFontType size:20] color:kTitleBlueColor];
    labelMensaje.numberOfLines = 6;
    labelMensaje.overlayLabel.numberOfLines=6;
    [self.view addSubview:labelMensaje];
    
    if ([[guardar getNumeroEmergencia] isEqualToString:@"0"]) {
        textFieldNumero.text=nil;
    }
    if ([[guardar getNumeroEmergencia] length]>2) {
        NSString *numeroEmergenciaString=[guardar getNumeroEmergencia];
        textFieldNumero.text=numeroEmergenciaString;
    }
    
    
    
    //Set switch initial state
    if ([[guardar getNumero123] isEqualToString:@"1"]) {
        //switchLlamada.isOn=YES;
        [switchLlamada onOff:YES];
        NSLog(@"Prendido %d",switchLlamada.isOn);
    }
    else if ([[guardar getNumero123] isEqualToString:@"0"]) {
        //switchLlamada.isOn=NO;
        [switchLlamada onOff:NO];
        NSLog(@"Apagado %d",switchLlamada.isOn);
    }

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dismissView{
    [self dismissModalViewControllerAnimated:YES];
}
-(void)processTap:(id)sender{
    [textFieldNumero resignFirstResponder];
}
-(void)save{
    double numeroEmergencia = [textFieldNumero.text doubleValue];
    if ([textFieldNumero.text length]>2) {
        [guardar setNumeroEmergencia:numeroEmergencia];
    }
    if ([textFieldNumero.text isEqualToString:@""]) {
        [guardar setNumeroEmergencia:0];
    }
    
    if (switchLlamada.isOn) {
        [guardar setNumero123:1];
    }
    else{
        [guardar setNumero123:0];
    }
    
    [self dismissModalViewControllerAnimated:YES];
}


@end
