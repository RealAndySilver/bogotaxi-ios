//
//  EstadisticasViewController.m
//  BogoTaxi
//
//  Created by Development on 12/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "EstadisticasViewController.h"
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

@interface EstadisticasViewController ()

@end

@implementation EstadisticasViewController

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
    CustomButton *backButton=[[CustomButton alloc]initWithFrame:CGRectMake(10, self.view.frame.size.height-40, 50, 30)];
    backButton.backgroundColor=kYellowColor;
    [backButton setTitleColor:kGrayColor forState:UIControlStateNormal];
    [backButton setTitle:@"Atrás" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    BannerView *bannerView=[[BannerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-10, 0)];
    [bannerView ponerTexto:@"ESTADÍSTICAS"];
    bannerView.configBannerLabel.textColor=kYellowColor;
    [bannerView.configBannerLabel setOverlayOff:YES];
    [bannerView setBannerColor:kDarkGrayColor];
    bannerView.center=CGPointMake(self.view.frame.size.width/2, 50);
    if (deviceKind==2) {
        bannerView.center=CGPointMake(self.view.frame.size.width/2, 95);
    }
    [self.view addSubview:bannerView];
    
    [self crearContainer];
    [self updateView];

}
-(void)crearContainer{
    contentView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-10, 270)];
    contentView.backgroundColor=kDarkGrayColor;
    contentView.center=CGPointMake((self.view.frame.size.width/2), 20+self.view.frame.size.height/2);
    [self.view addSubview:contentView];
    
    UIView *contentRecorrido=[[UIView alloc]initWithFrame:CGRectMake(5, 5, contentView.frame.size.width-10, 50)];
    contentRecorrido.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [contentView addSubview:contentRecorrido];
    
    labelRecorridos=[[CustomLabel alloc]initWithFrame:CGRectMake(5, 7, contentRecorrido.frame.size.width/2, 35)];
    [labelRecorridos ponerTexto:@"Km Recorridos:" fuente:[UIFont fontWithName:kFontType size:26] color:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1]];
    [labelRecorridos setOverlayOff:YES];
    [contentRecorrido addSubview:labelRecorridos];
    
    labelImputRecorridos=[[CustomLabel alloc]initWithFrame:CGRectMake(labelRecorridos.frame.size.width, 7, (contentRecorrido.frame.size.width/2)-10, 35)];
    [labelImputRecorridos ponerTexto:@"4.65 Km" fuente:[UIFont fontWithName:kFontType size:26] color:kYellowColor];
    [labelImputRecorridos setOverlayOff:YES];
    labelImputRecorridos.textAlignment=UITextAlignmentRight;
    [contentRecorrido addSubview:labelImputRecorridos];
    
    UIView *contentViajes=[[UIView alloc]initWithFrame:CGRectMake(5, contentRecorrido.frame.size.height+10, contentView.frame.size.width-10, 50)];
    contentViajes.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [contentView addSubview:contentViajes];
    
    labelNoViajes=[[CustomLabel alloc]initWithFrame:CGRectMake(5, 7, contentViajes.frame.size.width/2, 35)];
    [labelNoViajes ponerTexto:@"No. de viajes:" fuente:[UIFont fontWithName:kFontType size:26] color:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1]];
    [labelNoViajes setOverlayOff:YES];
    [contentViajes addSubview:labelNoViajes];
    
    labelImputNoViajes=[[CustomLabel alloc]initWithFrame:CGRectMake(labelRecorridos.frame.size.width, 7, (contentRecorrido.frame.size.width/2)-10, 35)];
    [labelImputNoViajes ponerTexto:@"4" fuente:[UIFont fontWithName:kFontType size:26] color:kYellowColor];
    [labelImputNoViajes setOverlayOff:YES];
    labelImputNoViajes.textAlignment=UITextAlignmentRight;
    [contentViajes addSubview:labelImputNoViajes];
    
    UIView *contentCantPagada=[[UIView alloc]initWithFrame:CGRectMake(5, contentRecorrido.frame.size.height+15+50, contentView.frame.size.width-10, 50)];
    contentCantPagada.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [contentView addSubview:contentCantPagada];
    
    labelCantPagada=[[CustomLabel alloc]initWithFrame:CGRectMake(5, 7, contentCantPagada.frame.size.width/2, 35)];
    [labelCantPagada ponerTexto:@"Cantidad pagada:" fuente:[UIFont fontWithName:kFontType size:26] color:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1]];
    [labelCantPagada setOverlayOff:YES];
    [contentCantPagada addSubview:labelCantPagada];
    
    labelImputCantPagada=[[CustomLabel alloc]initWithFrame:CGRectMake(labelRecorridos.frame.size.width, 5, (contentRecorrido.frame.size.width/2)-10, 35)];
    [labelImputCantPagada ponerTexto:@"$286000.00" fuente:[UIFont fontWithName:kFontType size:26] color:kYellowColor];
    [labelImputCantPagada setOverlayOff:YES];
    labelImputCantPagada.textAlignment=UITextAlignmentRight;
    [contentCantPagada addSubview:labelImputCantPagada];
    
    UIView *contentMinutos=[[UIView alloc]initWithFrame:CGRectMake(5, contentRecorrido.frame.size.height+20+50+50, contentView.frame.size.width-10, 50)];
    contentMinutos.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [contentView addSubview:contentMinutos];
    
    labelMinutos=[[CustomLabel alloc]initWithFrame:CGRectMake(5, 7, contentMinutos.frame.size.width/2, 35)];
    [labelMinutos ponerTexto:@"Minutos:" fuente:[UIFont fontWithName:kFontType size:26] color:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1]];
    [labelMinutos setOverlayOff:YES];
    [contentMinutos addSubview:labelMinutos];
    
    labelImputMinutos=[[CustomLabel alloc]initWithFrame:CGRectMake(labelRecorridos.frame.size.width, 7, (contentRecorrido.frame.size.width/2)-10, 35)];
    [labelImputMinutos ponerTexto:@"2.55 minutos" fuente:[UIFont fontWithName:kFontType size:26] color:kYellowColor];
    [labelImputMinutos setOverlayOff:YES];
    labelImputMinutos.textAlignment=UITextAlignmentRight;
    [contentMinutos addSubview:labelImputMinutos];
    
    reiniciar=[[CustomButton alloc]initWithFrame:CGRectMake(0, 0, (contentView.frame.size.width)-10, 40)];
    [reiniciar setTitle:@"Reiniciar" forState:UIControlStateNormal];
    reiniciar.titleLabel.font=[UIFont fontWithName:kFontType size:24];
    [reiniciar addTarget:self action:@selector(resetEstadisticas) forControlEvents:UIControlEventTouchUpInside];
    reiniciar.center=CGPointMake((contentView.frame.size.width/2), (contentView.frame.size.height)-25);
    [contentView addSubview:reiniciar];
}
-(void)dismissView{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateView{
    Modelador *mod=[[Modelador alloc]init];
    
    labelImputRecorridos.text=[NSString stringWithFormat:@"%.2f km",[mod getKm]/1000];
    labelImputNoViajes.text=[NSString stringWithFormat:@"%i",[mod getViajes]];
    labelImputCantPagada.text=[NSString stringWithFormat:@"$%.2f",[mod getCantidadTaxis]];
    labelImputMinutos.text=[NSString stringWithFormat:@"%.2f minutos",[mod getMinutosTaxi]/60];
}
-(void)resetEstadisticas{
    Modelador *mod=[[Modelador alloc]init];
    int resetVar=0;
    [mod setKm:resetVar];
    [mod setViajes:resetVar];
    [mod setCantidadTaxis:resetVar];
    [mod setMinutosTaxi:resetVar];
    [self updateView];
}

@end
