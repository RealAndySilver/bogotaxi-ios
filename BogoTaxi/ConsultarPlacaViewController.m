//
//  ConsultarPlacaViewController.m
//  BogoTaxi
//
//  Created by Development on 11/03/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import "ConsultarPlacaViewController.h"
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

@interface ConsultarPlacaViewController ()

@end

@implementation ConsultarPlacaViewController
@synthesize stringPlaca;

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
	// Do any additional setup after loading the view.
    if (self.view.frame.size.height<480) {
        deviceKind=1;
    }
    else if (self.view.frame.size.height>480 && self.view.frame.size.height<560){
        deviceKind=2;
    }
    else if (self.view.frame.size.height>600){
        deviceKind=3;
    }
    recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(processTap:)];
    recognizer.delegate=self;
    [self.view setUserInteractionEnabled:YES];
    [self.view addGestureRecognizer:recognizer];
    
    [DeviceInfo getDeviceName];
    [DeviceInfo getModel];
    [DeviceInfo getMacAddress];
    [DeviceInfo getSystemVersion];
    
    posIniTableView=CGRectMake(0, 520, self.view.frame.size.width, 0);
    posFinTableView=CGRectMake(0, 215, self.view.frame.size.width, self.view.frame.size.height-255);
    
    [self crearScrollView];
    
    viewFrame=self.view.frame;
    viewWidth=self.view.frame.size.width;
    viewHeight=self.view.frame.size.height;
    tecladoUp=NO;
    
    arrayReportes=[[NSMutableArray alloc]init];
    arrayTaxista=[[NSMutableArray alloc]init];
    arrayTiposMalos=[[NSMutableArray alloc]init];
    arrayTiposBuenos=[[NSMutableArray alloc]init];
    
    UIView *containerBotones=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-41, self.view.frame.size.width, 45)];
    containerBotones.backgroundColor=[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
    [self.view addSubview:containerBotones];
    
    menuButtonAtras=[[UIButton alloc]initWithFrame:CGRectMake(1, 1, (containerBotones.frame.size.width/4)-1, 44)];
    [menuButtonAtras setTitle:@"Atras" forState:UIControlStateNormal];
    menuButtonAtras.backgroundColor=[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1];
    menuButtonAtras.titleLabel.font=[UIFont fontWithName:kFontType size:22];
    [menuButtonAtras addTarget:self action:@selector(viewMain:) forControlEvents:UIControlEventTouchUpInside];
    [containerBotones addSubview:menuButtonAtras];
    
    menuButtonConsultar=[[UIButton alloc]initWithFrame:CGRectMake(menuButtonAtras.frame.size.width+2, 1, (containerBotones.frame.size.width/4)-1, 44)];
    [menuButtonConsultar setTitle:@"Consultar" forState:UIControlStateNormal];
    menuButtonConsultar.backgroundColor=kDarkRedColor;
    menuButtonConsultar.titleLabel.font=[UIFont fontWithName:kFontType size:22];
    [menuButtonConsultar addTarget:self action:@selector(viewConsultar:) forControlEvents:UIControlEventTouchUpInside];
    [containerBotones addSubview:menuButtonConsultar];
    
    menuButtonReportar=[[UIButton alloc]initWithFrame:CGRectMake(menuButtonAtras.frame.size.width+menuButtonConsultar.frame.size.width+3, 1, (containerBotones.frame.size.width/4)-1, 44)];
    //menuButtonReportar.center=CGPointMake((containerBotones.frame.size.width/2)-(((containerBotones.frame.size.width/2)/2)/2), containerBotones.frame.size.height/2);
    [menuButtonReportar setTitle:@"Reportar" forState:UIControlStateNormal];
    menuButtonReportar.backgroundColor=[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1];
    menuButtonReportar.titleLabel.font=[UIFont fontWithName:kFontType size:22];
    [menuButtonReportar addTarget:self action:@selector(viewReportar:) forControlEvents:UIControlEventTouchUpInside];
    [containerBotones addSubview:menuButtonReportar];
    
    menuButtonTop10=[[UIButton alloc]initWithFrame:CGRectMake(menuButtonConsultar.frame.size.width+menuButtonReportar.frame.size.width+menuButtonAtras.frame.size.width+4, 1, (containerBotones.frame.size.width/4)-1, 44)];
    [menuButtonTop10 setTitle:@"Top 10" forState:UIControlStateNormal];
    menuButtonTop10.backgroundColor=[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1];
    menuButtonTop10.titleLabel.font=[UIFont fontWithName:kFontType size:22];
    [menuButtonTop10 addTarget:self action:@selector(viewTop:) forControlEvents:UIControlEventTouchUpInside];
    [containerBotones addSubview:menuButtonTop10];
    
    alert=[[AlertMessageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [alert crearView];
    [self.view addSubview:alert];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)crearScrollView{
    scrollViewContent=[[UIScrollView alloc]init];
    scrollViewContent.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    scrollViewContent.backgroundColor=[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
    scrollViewContent.showsHorizontalScrollIndicator=NO;
    scrollViewContent.PagingEnabled=YES;
    scrollViewContent.delegate=self;
    [self.view addSubview:scrollViewContent];
    for (int i = 0; i < 3; i++) {
        CGRect frame;
        frame.origin.x = scrollViewContent.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = scrollViewContent.frame.size;
        UIView *subview = [[UIView alloc] initWithFrame:frame];
        
        if (i==0) {
            subview.backgroundColor = kYellowColor;
            subview.tag=1;
            BannerView *bannerView=[[BannerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-10, 0)];
            [bannerView ponerTexto:@"CONSULTAR PLACA"];
            bannerView.configBannerLabel.textColor=[UIColor colorWithRed:0.75390625 green:0.02734375 blue:0.02734375 alpha:1];
            [bannerView.configBannerLabel setOverlayOff:NO];
            [bannerView setBannerColor:[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1]];
            bannerView.center=CGPointMake(self.view.frame.size.width/2, 50);
            [subview addSubview:bannerView];
            
            contentViewConsulta=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 120)];
            contentViewConsulta.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
            [subview addSubview:contentViewConsulta];
            
            buttonInformacion=[UIButton buttonWithType:UIButtonTypeInfoLight];
            buttonInformacion.frame=CGRectMake(contentViewConsulta.frame.size.width-60, contentViewConsulta.frame.size.height-32, 40, 40);
            buttonInformacion.alpha=0;
            [buttonInformacion addTarget:self action:@selector(informacionTaxista:) forControlEvents:UIControlEventTouchUpInside];
            [contentViewConsulta addSubview:buttonInformacion];
            
            buttonConsultar=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 90, 35)];
            buttonConsultar.center=CGPointMake(self.view.frame.size.width/2, 105);
            buttonConsultar.titleLabel.font=[UIFont fontWithName:kFontType size:24];
            [buttonConsultar setTitle:@"Consultar" forState:UIControlStateNormal];
            buttonConsultar.backgroundColor=kDarkRedColor;
            [buttonConsultar addTarget:self action:@selector(consutar) forControlEvents:UIControlEventTouchUpInside];
            [contentViewConsulta addSubview:buttonConsultar];
            
            UIView *placaContainer=[[UIView alloc]initWithFrame:CGRectMake(0, 0, subview.frame.size.width-60, 90)];
            placaContainer.center=CGPointMake(self.view.frame.size.width/2, 45);
            placaContainer.backgroundColor=kWhiteColor;
            placaContainer.layer.shadowColor = [[UIColor colorWithWhite:0.1 alpha:1] CGColor];
            placaContainer.layer.shadowOffset = CGSizeMake(0.0f,1.0f);
            placaContainer.layer.shadowRadius = 1;
            placaContainer.layer.shadowOpacity = 0.3;
            [contentViewConsulta addSubview:placaContainer];
            textFieldPlaca=[[UITextField alloc]initWithFrame:CGRectMake(10, 5, placaContainer.frame.size.width-20, placaContainer.frame.size.height-10)];
            textFieldPlaca.tag=3000;
            textFieldPlaca.backgroundColor=[UIColor clearColor];
            textFieldPlaca.placeholder=@"#PLACA";
            textFieldPlaca.text=stringPlaca;
            textFieldPlaca.delegate=self;
            textFieldPlaca.font=[UIFont fontWithName:kFontType size:70];
            textFieldPlaca.textAlignment=UITextAlignmentCenter;
            textFieldPlaca.textAlignment=NSTextAlignmentCenter;
            textFieldPlaca.autocorrectionType=UITextAutocorrectionTypeNo;
            textFieldPlaca.autocapitalizationType=UITextAutocapitalizationTypeAllCharacters;
            textFieldPlaca.textColor=kDarkGrayColor;
            [placaContainer addSubview:textFieldPlaca];
            
            mensajeConsulta=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 280, 150)];
            mensajeConsulta.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height+100);
            mensajeConsulta.text=@"Por favor ingresa un numero de placa para consultar.";
            mensajeConsulta.textAlignment=UITextAlignmentCenter;
            mensajeConsulta.textAlignment=NSTextAlignmentCenter;
            mensajeConsulta.backgroundColor=[UIColor clearColor];
            mensajeConsulta.textColor=kDarkGrayColor;
            mensajeConsulta.numberOfLines = 3;
            mensajeConsulta.font=[UIFont fontWithName:kFontType size:40];
            [subview addSubview:mensajeConsulta];
            
            tableViewReportes=[[UITableView alloc]initWithFrame:posIniTableView];
            tableViewReportes.delegate=self;
            tableViewReportes.dataSource=self;
            tableViewReportes.separatorStyle=NO;
            tableViewReportes.tag=2000;
            tableViewReportes.superview.tag=2000;
            tableViewReportes.backgroundColor=[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1];
            [subview addSubview:tableViewReportes];
            
            viewPlacaSinreporte=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
            viewPlacaSinreporte.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height+100);
            [subview addSubview:viewPlacaSinreporte];
            
            UILabel *labelNoHayReportes=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, viewPlacaSinreporte.frame.size.width-20, 60)];
            labelNoHayReportes.center=CGPointMake(viewPlacaSinreporte.frame.size.width/2, 30);
            labelNoHayReportes.font=[UIFont fontWithName:kFontType size:24];
            labelNoHayReportes.numberOfLines = 2;
            labelNoHayReportes.text=@"La placa ingresada aun no tiene reportes, quieres reportarla?";
            labelNoHayReportes.textColor=[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
            labelNoHayReportes.backgroundColor=[UIColor clearColor];
            labelNoHayReportes.textAlignment=UITextAlignmentCenter;
            labelNoHayReportes.textAlignment=NSTextAlignmentCenter;
            [viewPlacaSinreporte addSubview:labelNoHayReportes];
            
            UIButton *buttonReportarPlacaConsultada=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 35)];
            buttonReportarPlacaConsultada.center=CGPointMake(viewPlacaSinreporte.frame.size.width/2, 82);
            buttonReportarPlacaConsultada.titleLabel.font=[UIFont fontWithName:kFontType size:24];
            [buttonReportarPlacaConsultada setTitle:@"Reportar" forState:UIControlStateNormal];
            buttonReportarPlacaConsultada.backgroundColor=kDarkRedColor;
            [buttonReportarPlacaConsultada addTarget:self action:@selector(reportarPlacaConsultada:) forControlEvents:UIControlEventTouchUpInside];
            [viewPlacaSinreporte addSubview:buttonReportarPlacaConsultada];
            
            contentViewInformacion=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            contentViewInformacion.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
            contentViewInformacion.alpha=0;
            recognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(processTapViewInformacion:)];
            recognizer.delegate=self;
            [contentViewInformacion addGestureRecognizer:recognizer];
            [subview addSubview:contentViewInformacion];
            
            viewMessageContent=[[UIView alloc]initWithFrame:CGRectMake(0, 0, contentViewInformacion.frame.size.width-80, 222)];
            viewMessageContent.center=CGPointMake(contentViewInformacion.frame.size.width/2, contentViewInformacion.frame.size.height/2);
            viewMessageContent.backgroundColor=[UIColor whiteColor];
            viewMessageContent.layer.shadowColor = [UIColor blackColor].CGColor;
            viewMessageContent.layer.shadowOpacity = 0.8;
            viewMessageContent.layer.shadowOffset = CGSizeMake(0,1);
            viewMessageContent.layer.shadowRadius = 1;
            [contentViewInformacion addSubview:viewMessageContent];
        }
        else if (i==1) {
            subview.backgroundColor = [UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1];
            BannerView *bannerView=[[BannerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-10, 0)];
            [bannerView ponerTexto:@"REPORTAR PLACA"];
            bannerView.configBannerLabel.textColor=kDarkGrayColor;
            [bannerView.configBannerLabel setOverlayOff:YES];
            [bannerView setBannerColor:kYellowColor];
            bannerView.center=CGPointMake(self.view.frame.size.width/2, 50);
            [subview addSubview:bannerView];
            
            viewLabelsReportes=[[UIView alloc]initWithFrame:CGRectMake(0, 0, subview.frame.size.width, 35)];
            viewLabelsReportes.center=CGPointMake(self.view.frame.size.width/2, subview.frame.size.height+35);
            [subview addSubview:viewLabelsReportes];
            
            
            labelNegativo=[[UILabel alloc]init];
            if (deviceKind==3) {
                labelNegativo.frame=CGRectMake(5, 0, 0, 35);
            }
            else{
                labelNegativo.frame=CGRectMake(5, 0, 0, 35);
            }
            labelNegativo.textAlignment=UITextAlignmentCenter;
            labelNegativo.textAlignment=NSTextAlignmentCenter;
            labelNegativo.backgroundColor=[UIColor clearColor];
            labelNegativo.font=[UIFont fontWithName:kFontType size:35];
            labelNegativo.textColor=[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1];
            labelNegativo.text=@"NEGATIVO";
            [viewLabelsReportes addSubview:labelNegativo];
            
            labelPositivo=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 35)];
            if (deviceKind==3) {
                labelPositivo.frame=CGRectMake(215, 0, 0, 35);
            }
            else{
                labelPositivo.frame=CGRectMake(215, 0, 0, 35);
            }
            labelPositivo.textAlignment=UITextAlignmentCenter;
            labelPositivo.textAlignment=NSTextAlignmentCenter;
            labelPositivo.backgroundColor=[UIColor clearColor];
            labelPositivo.font=[UIFont fontWithName:kFontType size:35];
            labelPositivo.textColor=[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1];
            labelPositivo.text=@"POSITIVO";
            [viewLabelsReportes addSubview:labelPositivo];
            
            contentViewReporta=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 120)];
            if (deviceKind==3) {
                contentViewReporta.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
            }
            else{
                contentViewReporta.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
            }
            [subview addSubview:contentViewReporta];
            
            UIView *placaContainer=[[UIView alloc]initWithFrame:CGRectMake(0, 0, subview.frame.size.width-60, 90)];
            placaContainer.center=CGPointMake(self.view.frame.size.width/2, 45);
            placaContainer.backgroundColor=kWhiteColor;
            placaContainer.layer.shadowColor = [[UIColor colorWithWhite:0.1 alpha:1] CGColor];
            placaContainer.layer.shadowOffset = CGSizeMake(0.0f,1.0f);
            placaContainer.layer.shadowRadius = 1;
            placaContainer.layer.shadowOpacity = 0.3;
            [contentViewReporta addSubview:placaContainer];
            textFieldPlacaReportar=[[UITextField alloc]initWithFrame:CGRectMake(10, 5, placaContainer.frame.size.width-20, placaContainer.frame.size.height-10)];
            textFieldPlacaReportar.tag=3001;
            textFieldPlacaReportar.backgroundColor=[UIColor clearColor];
            textFieldPlacaReportar.placeholder=@"#PLACA";
            textFieldPlacaReportar.delegate=self;
            textFieldPlacaReportar.font=[UIFont fontWithName:kFontType size:70];
            textFieldPlacaReportar.textAlignment=UITextAlignmentCenter;
            textFieldPlacaReportar.autocorrectionType=UITextAutocorrectionTypeNo;
            textFieldPlacaReportar.autocapitalizationType=UITextAutocapitalizationTypeAllCharacters;
            textFieldPlacaReportar.textColor=kDarkGrayColor;
            [placaContainer addSubview:textFieldPlacaReportar];
            
            mensajeReporte=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 280, 150)];
            mensajeReporte.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height+100);
            mensajeReporte.text=@"Por favor ingresa el numero de placa que quieres reportar.";
            mensajeReporte.textAlignment=UITextAlignmentCenter;
            mensajeReporte.textAlignment=NSTextAlignmentCenter;
            mensajeReporte.backgroundColor=[UIColor clearColor];
            mensajeReporte.textColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
            mensajeReporte.numberOfLines = 3;
            mensajeReporte.font=[UIFont fontWithName:kFontType size:40];
            [subview addSubview:mensajeReporte];
            
            if (deviceKind==3) {
                containerTipo=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 163, 82)];
                containerTipo.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height+82);
            }
            else{
                containerTipo=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 103, 52)];
                containerTipo.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height+52);
            }
            //containerTipo.backgroundColor=[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1];
            [subview addSubview:containerTipo];
            
            UIButton *buttonBad=[[UIButton alloc]init];
            if (deviceKind==3) {
                buttonBad.frame=CGRectMake(1, 1, 80, 80);
                buttonBad.titleLabel.font=[UIFont fontWithName:kFontType size:70];
            }
            else{
                buttonBad.frame=CGRectMake(1, 1, 50, 50);
                buttonBad.titleLabel.font=[UIFont fontWithName:kFontType size:40];
            }
            [buttonBad setTitle:@":(" forState:UIControlStateNormal];
            buttonBad.backgroundColor=kLiteRedColor;
            [buttonBad addTarget:self action:@selector(reporteMalo:) forControlEvents:UIControlEventTouchUpInside];
            [containerTipo addSubview:buttonBad];
            
            UIButton *buttonGood=[[UIButton alloc]init];
            if (deviceKind==3) {
                buttonGood.frame=CGRectMake(buttonBad.frame.size.width+2, 1, 80, 80);
                buttonGood.titleLabel.font=[UIFont fontWithName:kFontType size:70];
            }
            else{
                buttonGood.frame=CGRectMake(buttonBad.frame.size.width+2, 1, 50, 50);
                buttonGood.titleLabel.font=[UIFont fontWithName:kFontType size:40];
            }
            [buttonGood setTitle:@":)" forState:UIControlStateNormal];
            buttonGood.backgroundColor=kGreenColor;
            [buttonGood addTarget:self action:@selector(reporteBueno:) forControlEvents:UIControlEventTouchUpInside];
            [containerTipo addSubview:buttonGood];
            
            mensajeReporte2=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 280, 150)];
            mensajeReporte2.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height+100);
            mensajeReporte2.text=@"Elige si el reporte es negativo o positivo.";
            mensajeReporte2.textAlignment=UITextAlignmentCenter;
            mensajeReporte2.textAlignment=NSTextAlignmentCenter;
            mensajeReporte2.backgroundColor=[UIColor clearColor];
            mensajeReporte2.textColor=[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
            mensajeReporte2.numberOfLines = 3;
            mensajeReporte2.font=[UIFont fontWithName:kFontType size:35];
            [subview addSubview:mensajeReporte2];
            
            
            viewReporteWrapper=[[UIView alloc]init];
            if (deviceKind==3) {
                viewReporteWrapper.frame=CGRectMake(0, self.view.frame.size.height+150, self.view.frame.size.width, 260);
            }
            else{
                viewReporteWrapper.frame=CGRectMake(0, self.view.frame.size.height+150, self.view.frame.size.width, 160);
            }
            [subview addSubview:viewReporteWrapper];
            
            
            buttonReportar=[[UIButton alloc]init];
            if (deviceKind==3) {
                buttonReportar.frame=CGRectMake(0, 0, 135, 60);
                buttonReportar.center=CGPointMake(self.view.frame.size.width/2, 250);
                buttonReportar.titleLabel.font=[UIFont fontWithName:kFontType size:30];
            }
            else{
                buttonReportar.frame=CGRectMake(0, 0, 90, 35);
                buttonReportar.center=CGPointMake(self.view.frame.size.width/2, 142);
                buttonReportar.titleLabel.font=[UIFont fontWithName:kFontType size:24];
            }
            [buttonReportar setTitle:@"Reportar" forState:UIControlStateNormal];
            buttonReportar.backgroundColor=kDarkRedColor;
            [buttonReportar addTarget:self action:@selector(reportar:) forControlEvents:UIControlEventTouchUpInside];
            [viewReporteWrapper addSubview:buttonReportar];
            
            UIView *viewReporteContent=[[UIView alloc]initWithFrame:CGRectMake(5, 3, viewReporteWrapper.frame.size.width-10, viewReporteWrapper.frame.size.height-37)];
            viewReporteContent.backgroundColor=[UIColor whiteColor];
            viewReporteContent.layer.shadowColor = [UIColor blackColor].CGColor;
            viewReporteContent.layer.shadowOpacity = 0.8;
            viewReporteContent.layer.shadowOffset = CGSizeMake(0,1);
            viewReporteContent.layer.shadowRadius = 1;
            [viewReporteWrapper addSubview:viewReporteContent];
            
            UIView *viewReporte=[[UIView alloc]initWithFrame:CGRectMake(3, 3, viewReporteContent.frame.size.width-6, viewReporteContent.frame.size.height-6)];
            viewReporte.backgroundColor=kLiteBlueColor;
            [viewReporteContent addSubview:viewReporte];
            
            UILabel *tituloReporte=[[UILabel alloc]init];
            tituloReporte.textColor=[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
            if (deviceKind==3) {
                tituloReporte.frame=CGRectMake(5, 6, 275, 35);
                tituloReporte.font = [UIFont fontWithName:kFontType size:35];
            }
            else{
                tituloReporte.frame=CGRectMake(5, 2, 275, 25);
                tituloReporte.font = [UIFont fontWithName:kFontType size:24];
            }
            tituloReporte.text=@"Comentario:";
            tituloReporte.backgroundColor=[UIColor clearColor];
            [viewReporte addSubview:tituloReporte];
            
            textViewComentarioReportar=[[UITextView alloc]init];
            textViewComentarioReportar.backgroundColor=[UIColor clearColor];
            textViewComentarioReportar.textColor=kWhiteColor;
            if (deviceKind==3) {
                textViewComentarioReportar.frame=CGRectMake(0, 30, viewReporte.frame.size.width, viewReporte.frame.size.height-30);
                textViewComentarioReportar.font=[UIFont fontWithName:kFontType size:35];
            }
            else{
                textViewComentarioReportar.frame=CGRectMake(0, 22, viewReporte.frame.size.width, viewReporte.frame.size.height-30);
                textViewComentarioReportar.font=[UIFont fontWithName:kFontType size:20];
            }
            textViewComentarioReportar.delegate=self;
            [viewReporte addSubview:textViewComentarioReportar];
            
            UILabel *reporte=[[UILabel alloc]initWithFrame:CGRectMake(5, 21, viewReporte.frame.size.width-10, 50)];
            reporte.textColor=kWhiteColor;
            reporte.numberOfLines = 2;
            reporte.font = [UIFont fontWithName:kFontType size:17];
            reporte.backgroundColor=[UIColor clearColor];
            [viewReporte addSubview:reporte];
            
            buttonVerMasReportes=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 90, 35)];
            buttonVerMasReportes.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height+35);
            buttonVerMasReportes.titleLabel.font=[UIFont fontWithName:kFontType size:24];
            [buttonVerMasReportes setTitle:@"Ver reportes" forState:UIControlStateNormal];
            buttonVerMasReportes.backgroundColor=kDarkRedColor;
            [buttonVerMasReportes addTarget:self action:@selector(consultarPlacaReportada:) forControlEvents:UIControlEventTouchUpInside];
            [subview addSubview:buttonVerMasReportes];
        }
        else if (i==2) {
            subview.backgroundColor = kYellowColor;
            BannerView *bannerView=[[BannerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-10, 0)];
            [bannerView ponerTexto:@"TOP 10"];
            bannerView.configBannerLabel.textColor=[UIColor colorWithRed:0.75390625 green:0.02734375 blue:0.02734375 alpha:1];
            [bannerView.configBannerLabel setOverlayOff:NO];
            [bannerView setBannerColor:[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1]];
            bannerView.center=CGPointMake(self.view.frame.size.width/2, 50);
            [subview addSubview:bannerView];
            
            topMalos=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-20, 45)];
            if (deviceKind==3) {
                topMalos.center=CGPointMake(self.view.frame.size.width/2, 480);
            }
            else{
                topMalos.center=CGPointMake(self.view.frame.size.width/2, 200);
            }
            topMalos.titleLabel.font=[UIFont fontWithName:kFontType size:30];
            topMalos.layer.shadowColor = [[UIColor colorWithWhite:0.1 alpha:1] CGColor];
            topMalos.layer.shadowOffset = CGSizeMake(0.0f,1.0f);
            topMalos.layer.shadowRadius = 1;
            topMalos.layer.shadowOpacity = 0.8;
            [topMalos setTitle:@"Top Malos" forState:UIControlStateNormal];
            topMalos.backgroundColor=kDarkRedColor;
            [topMalos addTarget:self action:@selector(topMalos:) forControlEvents:UIControlEventTouchUpInside];
            [subview addSubview:topMalos];
            
            tableViewMalos=[[UITableView alloc]init];
            if (deviceKind==3) {
                tableViewMalos.frame=CGRectMake(10, 500, self.view.frame.size.width-20, 0);
            }
            else{
                tableViewMalos.frame=CGRectMake(10, 200, self.view.frame.size.width-20, 0);
            }
            tableViewMalos.delegate=self;
            tableViewMalos.dataSource=self;
            tableViewMalos.separatorStyle=NO;
            tableViewMalos.tag=2001;
            tableViewMalos.backgroundColor=[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1];
            [subview addSubview:tableViewMalos];
            
            topBuenos=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-20, 45)];
            if (deviceKind==3) {
                topBuenos.center=CGPointMake(self.view.frame.size.width/2, 550);
            }
            else{
                topBuenos.center=CGPointMake(self.view.frame.size.width/2, 270);
            }
            topBuenos.titleLabel.font=[UIFont fontWithName:kFontType size:30];
            topBuenos.layer.shadowColor = [[UIColor colorWithWhite:0.1 alpha:1] CGColor];
            topBuenos.layer.shadowOffset = CGSizeMake(0.0f,1.0f);
            topBuenos.layer.shadowRadius = 1;
            topBuenos.layer.shadowOpacity = 0.8;
            topBuenos.titleLabel.textColor=kDarkGrayColor;
            [topBuenos setTitle:@"Top Buenos" forState:UIControlStateNormal];
            topBuenos.backgroundColor=kBlueColor;
            [topBuenos addTarget:self action:@selector(topBuenos:) forControlEvents:UIControlEventTouchUpInside];
            [subview addSubview:topBuenos];
            
            tableViewBuenos=[[UITableView alloc]init];
            if (deviceKind==3) {
                tableViewBuenos.frame=CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height-580);
            }
            else{
                tableViewBuenos.frame=CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height-300);
            }
            tableViewBuenos.delegate=self;
            tableViewBuenos.dataSource=self;
            tableViewBuenos.separatorStyle=NO;
            tableViewBuenos.tag=2002;
            tableViewBuenos.backgroundColor= [UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1];
            [subview addSubview:tableViewBuenos];
        }
        
        [scrollViewContent addSubview:subview];
    }
    
    scrollViewContent.contentSize = CGSizeMake(scrollViewContent.frame.size.width * 3, scrollViewContent.frame.size.height);
    
    
}

#pragma mark - acción botones menu
-(void)viewMain:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil]; 
    [self seleccionarBoton:1];
}
-(void)viewConsultar:(id)sender{
    [scrollViewContent setContentOffset:CGPointMake(scrollViewContent.frame.size.width * 0, 0.0f) animated:YES];
    [self seleccionarBoton:2];
}
-(void)viewReportar:(id)sender{
    [scrollViewContent setContentOffset:CGPointMake(scrollViewContent.frame.size.width * 1, 0.0f) animated:YES];
    [self seleccionarBoton:3];
}
-(void)viewTop:(id)sender{
    [scrollViewContent setContentOffset:CGPointMake(scrollViewContent.frame.size.width * 2, 0.0f) animated:YES];
    [self seleccionarBoton:4];
}
-(void)reportarPlacaConsultada:(id)sender{
    textFieldPlacaReportar.text=textFieldPlaca.text;
    [self animarView:labelPositivo ConPosicion:CGRectMake(self.view.frame.size.width-105, 0, 0, 35)];
    [self animarView:labelNegativo ConPosicion:CGRectMake(5, 0, 0, 35)];
    [self animarCentroView:viewReporteWrapper ConCentro:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height+200)];
    [self animarCentroView:contentViewReporta ConCentro:CGPointMake(self.view.frame.size.width/2, 150)];
    [self animarCentroView:mensajeReporte ConCentro:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height+100)];
    [self animarCentroView:buttonVerMasReportes ConCentro:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height+35)];
    textViewComentarioReportar.text=@"";
    if (deviceKind==3) {
        [self animarCentroView:viewLabelsReportes ConCentro:CGPointMake(self.view.frame.size.width/2, 390)];
        [self animarCentroView:containerTipo ConCentro:CGPointMake(self.view.frame.size.width/2, 390)];
        [self animarCentroView:mensajeReporte2 ConCentro:CGPointMake(self.view.frame.size.width/2, 660)];
    }
    else {
        [self animarCentroView:viewLabelsReportes ConCentro:CGPointMake(self.view.frame.size.width/2, 215)];
        [self animarCentroView:containerTipo ConCentro:CGPointMake(self.view.frame.size.width/2, 215)];
        [self animarCentroView:mensajeReporte2 ConCentro:CGPointMake(self.view.frame.size.width/2, 315)];
    }
    [scrollViewContent setContentOffset:CGPointMake(scrollViewContent.frame.size.width * 1, 0.0f) animated:YES];
    [self seleccionarBoton:3];
}
-(void)consultarPlacaReportada:(id)sender{
    [scrollViewContent setContentOffset:CGPointMake(scrollViewContent.frame.size.width * 0, 0.0f) animated:YES];
    [self seleccionarBoton:2];
    textFieldPlaca.text=textFieldPlacaReportar.text;
    [self animarCentroView:mensajeConsulta ConCentro:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height+100)];
    [self animarCentroView:contentViewConsulta ConCentro:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
    [self animarCentroView:viewPlacaSinreporte ConCentro:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height+100)];
    [self animarView:tableViewReportes ConPosicion:posIniTableView];
    
    [self consutar];
}
#pragma mark - hilight method

-(void)seleccionarBoton:(int)numeroDeBoton{
    
    UIColor *colorNormal=[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1];
    UIColor *colorHilight=kDarkRedColor;
    
    switch (numeroDeBoton) {
            
        case 1:
            [menuButtonAtras setBackgroundColor:colorHilight];
            [menuButtonConsultar setBackgroundColor:colorNormal];
            [menuButtonReportar setBackgroundColor:colorNormal];
            [menuButtonTop10 setBackgroundColor:colorNormal];
            [menuButtonAtras setHighlighted:YES];
            [menuButtonConsultar setHighlighted:NO];
            [menuButtonReportar setHighlighted:NO];
            [menuButtonTop10 setHighlighted:NO];
            break;
            
        case 2:
            
            [menuButtonAtras setBackgroundColor:colorNormal];
            [menuButtonConsultar setBackgroundColor:colorHilight];
            [menuButtonReportar setBackgroundColor:colorNormal];
            [menuButtonTop10 setBackgroundColor:colorNormal];
            [menuButtonAtras setHighlighted:YES];
            [menuButtonConsultar setHighlighted:NO];
            [menuButtonReportar setHighlighted:NO];
            [menuButtonTop10 setHighlighted:NO];
            break;
            
        case 3:
            
            [menuButtonAtras setBackgroundColor:colorNormal];
            [menuButtonConsultar setBackgroundColor:colorNormal];
            [menuButtonReportar setBackgroundColor:colorHilight];
            [menuButtonTop10 setBackgroundColor:colorNormal];
            [menuButtonAtras setHighlighted:YES];
            [menuButtonConsultar setHighlighted:NO];
            [menuButtonReportar setHighlighted:NO];
            [menuButtonTop10 setHighlighted:NO];
            break;
            
        case 4:
            
            [menuButtonAtras setBackgroundColor:colorNormal];
            [menuButtonConsultar setBackgroundColor:colorNormal];
            [menuButtonReportar setBackgroundColor:colorNormal];
            [menuButtonTop10 setBackgroundColor:colorHilight];
            [menuButtonAtras setHighlighted:YES];
            [menuButtonConsultar setHighlighted:NO];
            [menuButtonReportar setHighlighted:NO];
            [menuButtonTop10 setHighlighted:NO];
            break;
            
        default:
            
            break;
            
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGRect frame=[[UIScreen mainScreen] applicationFrame];
    float roundedValue = round(scrollViewContent.contentOffset.x / frame.size.width);
    [self seleccionarBoton:roundedValue+2];
}

#pragma mark - animar view por teclado
-(void)animarViewPorTeclado{
    if (tecladoUp) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.view.frame=CGRectMake(0, -((self.view.frame.size.height/2)/2)+50, viewWidth, viewHeight);
        [UIView commitAnimations];
    }
    else{
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.25];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.view.frame=viewFrame;
        [UIView commitAnimations];
    }
}
#pragma mark - dismiss keyboard
-(void)dismissKeyboard{
    [textFieldPlaca resignFirstResponder];
    [textFieldPlacaReportar resignFirstResponder];
    [textViewComentarioReportar resignFirstResponder];
    tecladoUp=NO;
    [self animarViewPorTeclado];
}
#pragma mark - textfield delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag==3000) {
        [self animarCentroView:mensajeConsulta ConCentro:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height+100)];
        [self animarCentroView:contentViewConsulta ConCentro:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
        [self animarCentroView:viewPlacaSinreporte ConCentro:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height+100)];
        [self animarView:tableViewReportes ConPosicion:posIniTableView];
        tecladoUp=YES;
        [self animarViewPorTeclado];
        [self animarView:buttonInformacion ConOpacidad:0];
        [scrollViewContent setScrollEnabled:NO];
    }
    else if (textField.tag==3001){
        textViewComentarioReportar.text=@"";
        [self animarCentroView:mensajeReporte ConCentro:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height+100)];
        [self animarCentroView:mensajeReporte2 ConCentro:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height+100)];
        [self animarCentroView:viewLabelsReportes ConCentro:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height+35)];
        [self animarView:labelPositivo ConPosicion:CGRectMake(self.view.frame.size.width-105, 0, 0, 35)];
        [self animarView:labelNegativo ConPosicion:CGRectMake(5, 0, 0, 35)];
        [self animarCentroView:containerTipo ConCentro:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height+82)];
        [self animarCentroView:viewReporteWrapper ConCentro:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height+200)];
        [self animarCentroView:contentViewReporta ConCentro:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
        [self animarCentroView:buttonVerMasReportes ConCentro:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height+35)];
        
        tecladoUp=YES;
        [self animarViewPorTeclado];
        [scrollViewContent setScrollEnabled:NO];
    }
    
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField.tag==3000) {
        tecladoUp=NO;
        [self animarViewPorTeclado];
        [scrollViewContent setScrollEnabled:YES];
    }
    else if (textField.tag==3001){
        tecladoUp=NO;
        [self animarViewPorTeclado];
        [scrollViewContent setScrollEnabled:YES];
        [self animarCentroView:contentViewReporta ConCentro:CGPointMake(self.view.frame.size.width/2, 150)];
        BOOL *resultado= [self checkPlaca:textFieldPlacaReportar.text];
        if ([textField.text isEqualToString:@""]) {
            [self animarCentroView:mensajeReporte ConCentro:CGPointMake(self.view.frame.size.width/2, 280)];
        }
        else if (resultado==NO){
            mensajeReporte.text=@"Porfavor ingresa un número de placa valido.";
            [self animarCentroView:mensajeReporte ConCentro:CGPointMake(self.view.frame.size.width/2, 280)];
        }
        else{
            if (deviceKind==3) {
                [self animarCentroView:containerTipo ConCentro:CGPointMake(self.view.frame.size.width/2, 390)];
                [self animarCentroView:viewLabelsReportes ConCentro:CGPointMake(self.view.frame.size.width/2, 390)];
                [self animarCentroView:mensajeReporte2 ConCentro:CGPointMake(self.view.frame.size.width/2, 660)];
            }
            else {
                [self animarCentroView:containerTipo ConCentro:CGPointMake(self.view.frame.size.width/2, 215)];
                
                [self animarCentroView:viewLabelsReportes ConCentro:CGPointMake(self.view.frame.size.width/2, 215)];
                [self animarCentroView:mensajeReporte2 ConCentro:CGPointMake(self.view.frame.size.width/2, 315)];
            }
        }
    }
    textField.text=[[[textField.text uppercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"." withString:@""];
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag==3000) {
        [self dismissKeyboard];
        [self consutar];
    }
    else if (textField.tag==3001){
        [self dismissKeyboard];
    }
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 6) ? NO : YES;
}
-(void)processTap:(id)sender{
    tecladoUp=NO;
    [self dismissKeyboard];
}
-(void)processTapViewInformacion:(id)sender{
    [self animarView:contentViewInformacion ConOpacidad:0];
}
#pragma mark - textview delegate
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.view.frame=CGRectMake(0, -((self.view.frame.size.height/2)/2)-3, viewWidth, viewHeight);
    [UIView commitAnimations];
    [scrollViewContent setScrollEnabled:NO];
    return YES;
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.view.frame=viewFrame;
    [UIView commitAnimations];
    [self dismissKeyboard];
    [scrollViewContent setScrollEnabled:YES];
    return YES;
}


#pragma mark - server communication
-(void)receivedDataFromServer:(ServerCommunicator*)server{
    if ([server.methodName isEqualToString:@"Consultar"]) {
        [arrayReportes removeAllObjects];
        [arrayTaxista removeAllObjects];
        pos=0;
        neg=0;
        NSArray *arrayTax=[server.resDic objectForKey:@"Taxistas"];
        
        if (arrayTax.count) {
            [self animarView:buttonInformacion ConOpacidad:1];
            UIScrollView *scrollViewInformacion=[[UIScrollView alloc]init];
            scrollViewInformacion.frame=CGRectMake(3, 3, viewMessageContent.frame.size.width-6, viewMessageContent.frame.size.height-6);
            scrollViewInformacion.backgroundColor=[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
            scrollViewInformacion.showsHorizontalScrollIndicator=NO;
            scrollViewInformacion.PagingEnabled=YES;
            scrollViewInformacion.delegate=self;
            [viewMessageContent addSubview:scrollViewInformacion];
            
            for (int i=0; i<arrayTax.count; i++) {
                Taxista *taxista=[[Taxista alloc]leerTaxistaConDiccionario:[arrayTax objectAtIndex:i]];
                [arrayTaxista addObject:taxista];
                /*labelNombreTaxista.text=[NSString stringWithFormat:@"Nombre:%@",taxista.nombre];
                 labelTwitterTaxista.text=taxista.twitter;
                 labelAsociacionTaxista.text=taxista.asociacion;
                 labelHoraInicio.text=taxista.horaInicio;
                 labelHoraFin.text=taxista.horaFin;*/
                CGRect frame;
                frame.origin.x = 0;
                frame.origin.y = scrollViewInformacion.frame.size.height * i;
                frame.size = scrollViewInformacion.frame.size;
                ViewInformacion *subViewInformacion=[[ViewInformacion alloc]initWithFrame:frame];
                subViewInformacion.labelNombreTaxista.text=[NSString stringWithFormat:@"Nombre: %@",taxista.nombre];
                subViewInformacion.labelTwitterTaxista.text=[NSString stringWithFormat:@"Twitter: %@",taxista.twitter];
                subViewInformacion.labelAsociacionTaxista.text=[NSString stringWithFormat:@"Asociación: %@",taxista.asociacion];
                subViewInformacion.labelHoraInicio.text=[NSString stringWithFormat:@"Hora Inicio: %@",taxista.horaInicio];
                subViewInformacion.labelHoraFin.text=[NSString stringWithFormat:@"Hora Fin: %@",taxista.horaFin];
                [scrollViewInformacion addSubview:subViewInformacion];
            }
            scrollViewInformacion.contentSize = CGSizeMake(scrollViewInformacion.frame.size.width , scrollViewInformacion.frame.size.height * arrayTax.count);
        }
        else{
            [self animarView:buttonInformacion ConOpacidad:0];
        }
        
        if (!([[server.resDic objectForKey:@"Reportes"]isEqual:@"0"])) {
            NSArray *array=[server.resDic objectForKey:@"Reportes"];
            for (int i=0; i<array.count; i++) {
                Reportes *reportes=[[Reportes alloc]leerReporteConDiccionario:[array objectAtIndex:i]];
                if ([reportes.tipo isEqualToString:@"positivo"]) {
                    pos=pos+1;
                }
                else if ([reportes.tipo isEqualToString:@"negativo"]){
                    neg=neg+1;
                }
                [arrayReportes addObject:reportes];
            }
            
        }
        else{
            [self animarCentroView:viewPlacaSinreporte ConCentro:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height-100)];
        }
        [tableViewReportes reloadData];
    }
    else if ([server.methodName isEqualToString:@"TopDiezMalos"]){
        [arrayTiposMalos removeAllObjects];
        for (NSDictionary *dic in [server.resDic objectForKey:@"Reportes"]) {
            TopTaxi *topDiezMalos=[[TopTaxi alloc]leerTopTaxiConDiccionario:dic];
            [arrayTiposMalos addObject:topDiezMalos];
            
        }
        
        [tableViewMalos reloadData];
        
    }
    else if ([server.methodName isEqualToString:@"TopDiezBuenos"]){
        [arrayTiposBuenos removeAllObjects];
        for (NSDictionary *dic in [server.resDic objectForKey:@"Reportes"]) {
            TopTaxi *topDiezMalos=[[TopTaxi alloc]leerTopTaxiConDiccionario:dic];
            [arrayTiposBuenos addObject:topDiezMalos];
            
        }
        
        [tableViewBuenos reloadData];
        
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
-(void)receivedDataFromServerWithError:(ServerCommunicator*)server{
    NSLog(@"NO HAY CONEXION");
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [alert changeState];
    [self.view bringSubviewToFront:alert];
    //[alert.buttonCancelar removeTarget:self action:@selector(backScrollContent) forControlEvents:UIControlEventTouchUpInside];
    [alert.labelMensaje ponerTexto:@"No tienes conexion a internet, por favor conectate a una red" fuente:[UIFont fontWithName:kFontType size:32] color:kWhiteColor];
    //[alert.buttonOK addTarget:self action:@selector(backScrollContent) forControlEvents:UIControlEventTouchUpInside];
}
-(void)backScrollContent{
    [alert changeState];
}
#pragma mark - Animaciones
-(void)animarView:(UIView*)view ConPosicion:(CGRect)posicion{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    view.frame=posicion;
    [UIView commitAnimations];
}
-(void)animarCentroView:(UIView*)view ConCentro:(CGPoint)centro{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    view.center=centro;
    [UIView commitAnimations];
}
-(void)animarView:(UIView*)view ConOpacidad:(float)opacidad{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    view.alpha=opacidad;
    [UIView commitAnimations];
}

-(void)animarComentarioHaciaAbajo{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDidStopSelector:@selector(animarComentarioHaciaArriba)];
    
    viewReporteWrapper.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height+200);
    [UIView commitAnimations];
}
-(void)animarComentarioHaciaArriba{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    if (deviceKind==3) {
        viewReporteWrapper.center=CGPointMake(self.view.frame.size.width/2, 700);
    }
    else{
        viewReporteWrapper.center=CGPointMake(self.view.frame.size.width/2, 328);
    }
    
    [UIView commitAnimations];
}
#pragma mark - checkPlaca
-(BOOL)checkPlaca:(NSString *)placa {
    
    NSString* placaRegex = @"[A-Za-z]{3,4}[0-9]{3,3}";
    NSPredicate* placaTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", placaRegex];
    
    return [placaTest evaluateWithObject:placa];
    
}
#pragma mark - Acción botones
-(void)consutar{
    tecladoUp=NO;
    [self dismissKeyboard];
    [self animarCentroView:contentViewConsulta ConCentro:CGPointMake(self.view.frame.size.width/2, 150)];
    [self animarCentroView:viewPlacaSinreporte ConCentro:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height+100)];
    BOOL *resultado= [self checkPlaca:textFieldPlaca.text];
    
    NSString *resultadoString=[NSString stringWithFormat:@"%i",(int)resultado];
    NSLog(@"resultado: %@", resultadoString);
    
    if ([textFieldPlaca.text isEqual:@""] || resultado==NO) {
        [self animarView:tableViewReportes ConPosicion:posIniTableView];
        [self animarCentroView:mensajeConsulta ConCentro:CGPointMake(self.view.frame.size.width/2, 300)];
    }
    else{
        [self animarView:tableViewReportes ConPosicion:posFinTableView];
        [self consultarPlaca];
        
    }
}
-(void)consultarPlaca{
    ServerCommunicator *server=[[ServerCommunicator alloc]init];
    server.caller=self;
    server.methodName=@"Consultar";
    NSString *parameters=[NSString stringWithFormat:@"placa=%@",textFieldPlaca.text];
    [server callServerWithMethod:server.methodName andParameter:parameters];
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Consultando Placa";
    
}
-(void)informacionTaxista:(UIButton*)sender{
    [self animarView:contentViewInformacion ConOpacidad:1];
}
-(void)reportar: (UIButton*) sender{
    ServerCommunicator *server=[[ServerCommunicator alloc]init];
    server.caller=self;
    server.methodName=@"Reportar";
    NSString *parameters=[NSString stringWithFormat:@"placa=%@&tipo=%@&comentarios=%@&usuario=%@&token=%@&secret=%@&peticion=%@",textFieldPlacaReportar.text,tipoReporte,textViewComentarioReportar.text,[DeviceInfo getMacAddress],[DeviceInfo getDeviceName], [DeviceInfo getModel],@"iOS"];
    [server callServerWithMethod:server.methodName andParameter:parameters];
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Creando Reporte";
    
    [self animarCentroView:mensajeReporte2 ConCentro:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height+100)];
    [self animarCentroView:containerTipo ConCentro:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height+82)];
    [self animarView:labelPositivo ConPosicion:CGRectMake(self.view.frame.size.width-105, 0, 0, 35)];
    [self animarView:labelNegativo ConPosicion:CGRectMake(5, 0, 0, 35)];
    [self animarCentroView:viewLabelsReportes ConCentro:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height+35)];
    [self animarCentroView:viewReporteWrapper ConCentro:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height+200)];
    mensajeReporte.text=@"Tu reporte se ha ingresado correctamente.";
    [self animarCentroView:mensajeReporte ConCentro:CGPointMake(self.view.frame.size.width/2, 280)];
    [self animarCentroView:buttonVerMasReportes ConCentro:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height-80)];
}
-(void)reporteMalo: (UIButton*) sender{
    tipoReporte=@"negativo";
    [self animarComentarioHaciaAbajo];
    [self animarView:labelNegativo ConPosicion:CGRectMake(5, 0, 100, 35)];
    [self animarView:labelPositivo ConPosicion:CGRectMake(self.view.frame.size.width-105, 0, 0, 35)];
}
-(void)reporteBueno: (UIButton*) sender{
    tipoReporte=@"positivo";
    [self animarComentarioHaciaAbajo];
    [self animarView:labelPositivo ConPosicion:CGRectMake(self.view.frame.size.width-105, 0, 100, 35)];
    [self animarView:labelNegativo ConPosicion:CGRectMake(5, 0, 0, 35)];
}
-(void)topMalos: (UIButton*) sender{
    [self consultarTopMalos];
    [self animarCentroView:topMalos ConCentro:CGPointMake(self.view.frame.size.width/2, 110)];
    [self animarView:tableViewMalos ConPosicion:CGRectMake(10, 140, self.view.frame.size.width-20, self.view.frame.size.height-240)];
    [self animarCentroView:topBuenos ConCentro:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height-70)];
    [self animarView:tableViewBuenos ConPosicion:CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, 0)];
}
-(void)consultarTopMalos{
    ServerCommunicator *server=[[ServerCommunicator alloc]init];
    server.caller=self;
    server.methodName=@"TopDiezMalos";
    //NSString *parameters=[NSString stringWithFormat:@"placa=%@",textFieldPlaca.text];
    [server callServerWithMethod:server.methodName andParameter:@""];
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Cargando Top Diez Malos";
}
-(void)topBuenos: (UIButton*) sender{
    [self consultarTopBuenos];
    [self animarCentroView:topMalos ConCentro:CGPointMake(self.view.frame.size.width/2, 110)];
    [self animarView:tableViewMalos ConPosicion:CGRectMake(10, 140, self.view.frame.size.width-20, 0)];
    [self animarCentroView:topBuenos ConCentro:CGPointMake(self.view.frame.size.width/2, 160)];
    [self animarView:tableViewBuenos ConPosicion:CGRectMake(10, 190, self.view.frame.size.width-20, self.view.frame.size.height-240)];
}
-(void)consultarTopBuenos{
    ServerCommunicator *server=[[ServerCommunicator alloc]init];
    server.caller=self;
    server.methodName=@"TopDiezBuenos";
    [server callServerWithMethod:server.methodName andParameter:@""];
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Cargando Top Diez Buenos";
}

#pragma mark - Delegate tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag==2000) {
        return (arrayReportes.count)+1;
    }
    else if (tableView.tag==2001){
        return arrayTiposMalos.count;
    }
    else{
        return arrayTiposBuenos.count;
    }
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableview cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableview.tag==2000) {
        if (indexPath.row==0) {
            static NSString *CellIdentifier = @"p1";
            CustomCellReporteUno *cell1 = [tableview dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell1 == nil) {
                cell1 = [[CustomCellReporteUno alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier andWidth:self.view.frame.size.width];
            }
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            cell1.labelTotal.text=[NSString stringWithFormat:@"%i",arrayReportes.count];
            cell1.labelPositivos.text=[NSString stringWithFormat:@"%i",pos];
            cell1.labelNegativos.text=[NSString stringWithFormat:@"%i",neg];
            return cell1;
        }
        else{
            static NSString *CellIdentifier = @"p2";
            CustomCellReporte *cell = [tableview dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[CustomCellReporte alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier andWidth:self.view.frame.size.width];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            Reportes *reporte=[arrayReportes objectAtIndex:indexPath.row-1];
            NSString *tipo=[NSString stringWithFormat:@"%@",reporte.tipo];
            if ([tipo isEqualToString:@"negativo"]) {
                cell.viewTipo.backgroundColor=kLiteRedColor;
                cell.labelTipo.text=@":(";
            }
            else{
                cell.viewTipo.backgroundColor=kGreenColor;
                cell.labelTipo.text=@":)";
            }
            cell.fecha.text=[NSString stringWithFormat:@"Reportado el: %@",reporte.fecha];
            cell.comentario.text=reporte.comentarios;
            
            return cell;
        }
    }
    else if (tableview.tag==2001){
        static NSString *CellIdentifier = @"p3";
        CustomCellTop *cell2= [tableview dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell2 == nil) {
            cell2 = [[CustomCellTop alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier andWidth:self.view.frame.size.width];
        }
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        TopTaxi *topMalo=[arrayTiposMalos objectAtIndex:indexPath.row];
        cell2.labelTopPlaca.text=topMalo.placa;
        cell2.labelTopNegativos.text=topMalo.negativos;
        cell2.labelTopPositivos.text=topMalo.positivos;
        
        return cell2;
    }
    else{
        static NSString *CellIdentifier = @"p4";
        CustomCellTop *cell3= [tableview dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell3 == nil) {
            cell3 = [[CustomCellTop alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier andWidth:self.view.frame.size.width];
        }
        cell3.selectionStyle = UITableViewCellSelectionStyleNone;
        TopTaxi *topMalo=[arrayTiposBuenos objectAtIndex:indexPath.row];
        cell3.labelTopPlaca.text=topMalo.placa;
        cell3.labelTopNegativos.text=topMalo.negativos;
        cell3.labelTopPositivos.text=topMalo.positivos;
        
        return cell3;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==2000) {
        return 100;
    }
    else{
        return 73;
    }
}

#pragma mark - tv delegate
- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableview.tag==2000) {
        if (indexPath.row==0) {
        }
        else{
            DetailReporteViewController *dVC=[[DetailReporteViewController alloc]init];
            dVC=[self.storyboard instantiateViewControllerWithIdentifier:@"DetailReporte"];
            dVC.reporte=[arrayReportes objectAtIndex:indexPath.row-1];
            dVC.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
            [self presentViewController:dVC animated:YES completion:nil];
        }
    }
    else if (tableview.tag==2001){
        [scrollViewContent setContentOffset:CGPointMake(scrollViewContent.frame.size.width * 0, 0.0f) animated:YES];
        [self seleccionarBoton:2];
        TopTaxi *topMalo=[arrayTiposMalos objectAtIndex:indexPath.row];
        textFieldPlaca.text=topMalo.placa;
        [self consutar];
    }
    else {
        [scrollViewContent setContentOffset:CGPointMake(scrollViewContent.frame.size.width * 0, 0.0f) animated:YES];
        [self seleccionarBoton:2];
        TopTaxi *topMalo=[arrayTiposBuenos objectAtIndex:indexPath.row];
        textFieldPlaca.text=topMalo.placa;
        [self consutar];
        
    }
}

#pragma mark - gesture delegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (tableViewReportes.superview !=nil) {
        if ([touch.view isDescendantOfView:tableViewReportes]) {
            return NO;
        }
        else if ([touch.view isDescendantOfView:tableViewMalos]){
            return NO;
        }
        else if ([touch.view isDescendantOfView:tableViewBuenos]){
            return NO;
        }
    }
    return YES;
}


@end
