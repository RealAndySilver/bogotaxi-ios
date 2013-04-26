//
//  DetailReporteViewController.m
//  BogoTaxiLite
//
//  Created by Development on 12/02/13.
//  Copyright (c) 2013 iAmStudio. All rights reserved.
//

#import "DetailReporteViewController.h"
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

@interface DetailReporteViewController ()
@end

@implementation DetailReporteViewController
@synthesize reporte,comentario,viewMessage, fecha, viewTipo,labelTipo;

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
    if (self.view.frame.size.height<480) {
        deviceKind=1;
    }
    else if (self.view.frame.size.height>480 && self.view.frame.size.height<560){
        deviceKind=2;
    }
    else if (self.view.frame.size.height>600){
        deviceKind=3;
    }
    self.view.backgroundColor=kYellowColor;
	// Do any additional setup after loading the view.
    
    UIView *contentViewReporta=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 120)];
    if (deviceKind==3) {
        contentViewReporta.center=CGPointMake(self.view.frame.size.width/2, (self.view.frame.size.height/2)/2);
    }
    else{
        contentViewReporta.center=CGPointMake(self.view.frame.size.width/2, ((self.view.frame.size.height/2)/2)+25);
    }
    [self.view addSubview:contentViewReporta];
    
    UIView *placaContainer=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-60, 90)];
    placaContainer.center=CGPointMake(contentViewReporta.frame.size.width/2, contentViewReporta.frame.size.height/2);
    placaContainer.backgroundColor=kWhiteColor;
    placaContainer.layer.shadowColor = [[UIColor colorWithWhite:0.1 alpha:1] CGColor];
    placaContainer.layer.shadowOffset = CGSizeMake(0.0f,1.0f);
    placaContainer.layer.shadowRadius = 1;
    placaContainer.layer.shadowOpacity = 0.3;
    [contentViewReporta addSubview:placaContainer];
    UILabel *textFieldPlacaReportar=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, placaContainer.frame.size.width-20, placaContainer.frame.size.height-10)];
    textFieldPlacaReportar.tag=3001;
    textFieldPlacaReportar.backgroundColor=[UIColor clearColor];
    textFieldPlacaReportar.font=[UIFont fontWithName:kFontType size:70];
    textFieldPlacaReportar.textAlignment=UITextAlignmentCenter;
    textFieldPlacaReportar.textColor=kDarkGrayColor;
    textFieldPlacaReportar.text=reporte.placa;
    [placaContainer addSubview:textFieldPlacaReportar];
    
    UIView *containerBotones=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 45)];
    containerBotones.backgroundColor=[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
    [self.view addSubview:containerBotones];
    UIView *containerBotones2=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    containerBotones2.backgroundColor=[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
    containerBotones2.layer.shadowColor = [[UIColor colorWithWhite:0.1 alpha:1] CGColor];
    containerBotones2.layer.shadowOffset = CGSizeMake(0.0f,1.0f);
    containerBotones2.layer.shadowRadius = 1;
    containerBotones2.layer.shadowOpacity = 0.9;
    [containerBotones addSubview:containerBotones2];
    
    UIButton *buttonBack=[[UIButton alloc]initWithFrame:CGRectMake(7, 7, 60 , 30)];
    //buttonBack.center=CGPointMake(containerBotones.frame.size.width/2, containerBotones.frame.size.height-22);
    [buttonBack setTitle:@"Atras" forState:UIControlStateNormal];
    buttonBack.backgroundColor=kLiteRedColor;
    buttonBack.titleLabel.font=[UIFont fontWithName:kFontType size:22];
    [buttonBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [containerBotones addSubview:buttonBack];
    
    UIView *viewMessageWrapper=[[UIView alloc]initWithFrame:CGRectMake(0, (self.view.frame.size.height/2), self.view.frame.size.width, self.view.frame.size.height/2)];
    //viewMessageWrapper.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    viewMessageWrapper.backgroundColor=[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1];
    //viewMessageWrapper.layer.borderWidth=1;
    [self.view addSubview:viewMessageWrapper];
    
    viewTipo=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 50)];
    viewTipo.center=CGPointMake(38, viewMessageWrapper.frame.size.height/2);
    //viewTipo.backgroundColor=[UIColor whiteColor];
    [viewMessageWrapper addSubview:viewTipo];
    
    labelTipo=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 50, 48)];
    labelTipo.textColor=kWhiteColor;
    labelTipo.font = [UIFont fontWithName:kFontType size:45];
    labelTipo.backgroundColor=[UIColor clearColor];
    if ([reporte.tipo isEqualToString:@"negativo"]) {
        viewTipo.backgroundColor=kLiteRedColor;
        labelTipo.text=@":(";
    }
    else{
        viewTipo.backgroundColor=kGreenColor;
        labelTipo.text=@":)";
    }

    [viewTipo addSubview:labelTipo];
    
    UIView *viewMessageContent=[[UIView alloc]initWithFrame:CGRectMake(0, 0, viewMessageWrapper.frame.size.width-viewTipo.frame.size.width+4, viewMessageWrapper.frame.size.height-100)];
    if (deviceKind==3) {
         viewMessageContent.center=CGPointMake((viewMessageWrapper.frame.size.width/2)+(((((viewMessageWrapper.frame.size.width/2)/2)/2)/4)-5), viewMessageWrapper.frame.size.height/2);
    }
    else{
         viewMessageContent.center=CGPointMake((viewMessageWrapper.frame.size.width/2)+(viewMessageWrapper.frame.size.width/14), viewMessageWrapper.frame.size.height/2);
    }
    viewMessageContent.backgroundColor=[UIColor whiteColor];
    viewMessageContent.layer.shadowColor = [UIColor blackColor].CGColor;
    viewMessageContent.layer.shadowOpacity = 0.8;
    viewMessageContent.layer.shadowOffset = CGSizeMake(0,1);
    viewMessageContent.layer.shadowRadius = 1;
    [viewMessageWrapper addSubview:viewMessageContent];
    
    viewMessage=[[UIView alloc]initWithFrame:CGRectMake(3, 3, viewMessageContent.frame.size.width-6, viewMessageContent.frame.size.height-6)];
    viewMessage.backgroundColor=kBlueColor;
    [viewMessageContent addSubview:viewMessage];
    
    UILabel *tituloComentario=[[UILabel alloc]init];
    tituloComentario.textColor=[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
    if (deviceKind==3) {
        tituloComentario.frame=CGRectMake(7, 10, 275, 35);
        tituloComentario.font = [UIFont fontWithName:kFontType size:35];
    }
    else{
        tituloComentario.frame=CGRectMake(7, 2, 275, 25);
        tituloComentario.font = [UIFont fontWithName:kFontType size:24];
    }
    tituloComentario.text=@"Comentario:";
    tituloComentario.backgroundColor=[UIColor clearColor];
    [viewMessage addSubview:tituloComentario];
    
    comentario=[[UITextView alloc]init];
    comentario.textColor=kWhiteColor;
    if (deviceKind==3) {
        comentario.frame=CGRectMake(0, 45, viewMessage.frame.size.width, viewMessage.frame.size.height-80);
        comentario.font = [UIFont fontWithName:kFontType size:42];
    }
    else{
        comentario.frame=CGRectMake(0, 25, viewMessage.frame.size.width, 80);
        comentario.font = [UIFont fontWithName:kFontType size:17];
    }
    [comentario setEditable:NO];
    comentario.backgroundColor=[UIColor clearColor];
    comentario.text=reporte.comentarios;
    [viewMessage addSubview:comentario];
    
    fecha=[[UILabel alloc]init];
    fecha.textColor=[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    if (deviceKind==3) {
        fecha.frame=CGRectMake(5, viewMessage.frame.size.height-30, 275, 30);
        fecha.font = [UIFont fontWithName:kFontType size:20];
    }
    else{
        fecha.frame=CGRectMake(5, viewMessage.frame.size.height-25, 275, 30);
        fecha.font = [UIFont fontWithName:kFontType size:12];
    }
    fecha.backgroundColor=[UIColor clearColor];
    fecha.text=reporte.fecha;
    [viewMessage addSubview:fecha];
    
    UISwipeGestureRecognizer *swipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
    [swipeGesture setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
