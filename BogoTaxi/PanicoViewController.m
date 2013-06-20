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
    viewFrame=self.view.frame;
    viewWidth=self.view.frame.size.width;
    viewHeight=self.view.frame.size.height;
    tecladoUp=NO;
    
    banderaInfo=YES;
    CGRect tfRect = CGRectMake(90, 50, 200, 30);
    CGRect tfMailRect = CGRectMake(10, 50, 200, 30);
    CGRect tvRect = CGRectMake(85, 0, 200, 45);
    CGRect tvRectMail = CGRectMake(5, 0, 200, 45);
    if (deviceKind==3) {
        tf=[[UITextField alloc]initWithFrame:tfMailRect];
    }
    else{
        tf=[[UITextField alloc]initWithFrame:tfRect];
    }
    tfMail=[[UITextField alloc]initWithFrame:tfMailRect];
    tfMail.autocorrectionType=UITextAutocorrectionTypeNo;
    if (deviceKind==3) {
        tv=[[UITextView alloc]initWithFrame:tvRectMail];
    }
    else{
        tv=[[UITextView alloc]initWithFrame:tvRect];
    }
    tvMail=[[UITextView alloc]initWithFrame:tvRectMail];
    
    redSocialLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    redSocialLabel.textColor=kTitleBlueColor;
    if (deviceKind==3) {
        redSocialLabel.font=[UIFont fontWithName:kFontType size:40];
        redSocialLabel.center=CGPointMake(350, 690);
    }
    else if (deviceKind==2){
        redSocialLabel.font=[UIFont fontWithName:kFontType size:24];
        redSocialLabel.center=CGPointMake(210, self.view.frame.size.height-90);
    }
    else{
        redSocialLabel.font=[UIFont fontWithName:kFontType size:24];
        redSocialLabel.center=CGPointMake(210, self.view.frame.size.height-70);
    }
    [redSocialLabel setOverlayOff:YES];
    [self.view addSubview:redSocialLabel];

    
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
    [saveButton addTarget:self action:@selector(enviarMensaje) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
    
    BannerView *bannerView=[[BannerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-10, 0)];
    [bannerView ponerTexto:@"BOTÓN DE PANICO"];
    bannerView.configBannerLabel.textColor=kYellowColor;
    [bannerView.configBannerLabel setOverlayOff:YES];
    [bannerView setBannerColor:kDarkGrayColor];
    bannerView.center=CGPointMake(self.view.frame.size.width/2, 45);
    [self.view addSubview:bannerView];
    objeto=[[Modelador alloc]init];
    redSocial=[objeto obtenerNombreDeRedSocial];
    [self crearContainer];
}
-(void)crearContainer{
    labelMensajeUbicacion=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, (self.view.frame.size.width)-20, 70)];
    [labelMensajeUbicacion ponerTexto:@"Ingresa el texto que irá en el mensaje de pánico" fuente:[UIFont fontWithName:kFontType size:28] color:kTitleBlueColor];
    labelMensajeUbicacion.numberOfLines = 2;
    labelMensajeUbicacion.overlayLabel.numberOfLines=2;
    labelMensajeUbicacion.center=CGPointMake(self.view.frame.size.width/2, 110);
    if (deviceKind==3) {
        labelMensajeUbicacion.center=CGPointMake(self.view.frame.size.width/2, 200);
    }
    [labelMensajeUbicacion setOverlayOff:NO];
    [self.view addSubview:labelMensajeUbicacion];
    
    textFieldUbicacion = [[UITextField alloc] initWithFrame:CGRectMake(90, 112, 215, 30)];
    if (deviceKind==3) {
        textFieldUbicacion.frame=CGRectMake(400, 189, 350, 30);
    }
    textFieldUbicacion.borderStyle = UITextBorderStyleRoundedRect;
    textFieldUbicacion.textColor = kTitleBlueColor;
    textFieldUbicacion.font = [UIFont fontWithName:kFontType size:22];
    textFieldUbicacion.placeholder = @"Mi ubicación actual es";  //place holder
    textFieldUbicacion.backgroundColor = [UIColor whiteColor];
    textFieldUbicacion.autocorrectionType = UITextAutocorrectionTypeNo;
    textFieldUbicacion.keyboardType = UIKeyboardTypeDefault;
    textFieldUbicacion.returnKeyType = UIReturnKeyDone;
    textFieldUbicacion.clearButtonMode = UITextFieldViewModeWhileEditing;
    [textFieldUbicacion addTarget:self action:@selector(actualizarMensaje) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:textFieldUbicacion];
    textFieldUbicacion.delegate = self;
    textFieldUbicacion.tag=3000;
    //Modelador *obj=[[Modelador alloc]init];
    NSString *mensajePanico=@"";
    NSString *numeroSMS=@"";
    NSString *correo=@"";
    if ([[objeto obtenerMensajeDePanico] isEqualToString:@" "]||[[objeto obtenerMensajeDePanico] isEqualToString:@""]||[objeto obtenerMensajeDePanico]==nil) {
        mensajePanico=@"Mi Ubicación actual es ";
    }
    else{
        mensajePanico=[objeto obtenerMensajeDePanico];
    }
    if ([[objeto getNumeroSMS] isEqualToString:@" "]||[[objeto getNumeroSMS] isEqualToString:@""]||[objeto getNumeroSMS]==nil
        ||[[objeto getNumeroSMS] isEqualToString:@"0"]) {
        tf.placeholder=@"# Predeterminado";
        
    }
    else{
        numeroSMS=[objeto getNumeroSMS];
        tf.text=numeroSMS;
    }
    if ([[objeto getMail] isEqualToString:@" "]||[[objeto getMail] isEqualToString:@""]||[objeto getMail]==nil
        ||[[objeto getMail] isEqualToString:@"0"]) {
        tfMail.placeholder=@"Correo";
        
    }
    else{
        correo=[objeto getMail];
        tfMail.text=correo;
    }
    textFieldUbicacion.text=mensajePanico;
    
    NSString *redSocialName=[objeto obtenerNombreDeRedSocial];
    if ([redSocialName isEqualToString:@""]||[redSocialName isEqualToString:@" "]||redSocialName ==nil) {
        [objeto redSocialConNombre:@"Twitter"];
        redSocialLabel.text=[objeto obtenerNombreDeRedSocial];
    }
    
    labelMensaje=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, (self.view.frame.size.width)-20, 100)];
    [labelMensaje ponerTexto:@"Si no ingresas ningún mensaje la aplicación pondra por defecto ''Mi ubicación actual es''. Tu mensaje siempre llevará una imagen del mapa con tu ubicación actual para que tus seguidores o a quién decidas enviar el mensaje lo pueda ver." fuente:[UIFont fontWithName:kFontType size:14] color:kTitleBlueColor];
    labelMensaje.numberOfLines = 4;
    labelMensaje.overlayLabel.numberOfLines=4;
    labelMensaje.center=CGPointMake(self.view.frame.size.width/2, 180);
    if (deviceKind==3) {
        [labelMensaje ponerTexto:@"Si no ingresas ningún mensaje la aplicación pondra por defecto ''Mi ubicación actual es''. Tu mensaje siempre llevará una imagen del mapa con tu ubicación actual para que tus seguidores o a quién decidas enviar el mensaje lo pueda ver." fuente:[UIFont fontWithName:kFontType size:28] color:kTitleBlueColor];
        labelMensaje.center=CGPointMake(self.view.frame.size.width/2, 280);
    }
    else if (deviceKind==2) {
        labelMensaje.center=CGPointMake(self.view.frame.size.width/2, 190);
    }

    [labelMensaje setOverlayOff:NO];
    [self.view addSubview:labelMensaje];
    
    labelTitulo=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, (self.view.frame.size.width)-20, 60)];
    [labelTitulo ponerTexto:@"ENVIÓ DEL MENSAJE" fuente:[UIFont fontWithName:kFontType size:40] color:kTitleBlueColor];
    labelTitulo.numberOfLines = 2;
    labelTitulo.overlayLabel.numberOfLines=2;
    labelTitulo.center=CGPointMake(self.view.frame.size.width/2, 230);
    if (deviceKind==3) {
        labelTitulo.center=CGPointMake(self.view.frame.size.width/2, 390);
    }
    else if (deviceKind==2){
        labelTitulo.center=CGPointMake(self.view.frame.size.width/2, 260);
    }
    [labelTitulo setOverlayOff:NO];
    [labelTitulo setCentrado:YES];
    [self.view addSubview:labelTitulo];
    
    contentMensajeView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, (self.view.frame.size.width)-10, 90)];
    contentMensajeView.center=CGPointMake(self.view.frame.size.width/2, (self.view.frame.size.height)-163);
    if (deviceKind==3) {
        contentMensajeView.center=CGPointMake(self.view.frame.size.width/2, 500);
    }
    else if(deviceKind==2){
        contentMensajeView.center=CGPointMake(self.view.frame.size.width/2, (self.view.frame.size.height)-203);
    }
    contentMensajeView.backgroundColor=kDarkGrayColor;
    [self.view addSubview:contentMensajeView];
    
    viewDesplazar=[[UIView alloc]initWithFrame:CGRectMake(0, 0, contentMensajeView.frame.size.width, contentMensajeView.frame.size.height)];
    [contentMensajeView addSubview:viewDesplazar];
    
    banderaDesplazar=NO;
    
    //Textfield del sms////////////////////////////
    tf.borderStyle = UITextBorderStyleRoundedRect;
    [contentMensajeView addSubview:tf];
    tf.alpha=0;
    tf.tag=3001;
    tf.delegate=self;
    tf.returnKeyType = UIReturnKeyDone;
    tf.keyboardType = UIKeyboardTypeNumberPad;
    tf.font = [UIFont fontWithName:kFontType size:22];
    
    //TextField del Mail////////////////////////////
    tfMail.borderStyle = UITextBorderStyleRoundedRect;
    [contentMensajeView addSubview:tfMail];
    tfMail.alpha=0;
    tfMail.tag=3002;
    tfMail.delegate=self;
    tfMail.returnKeyType = UIReturnKeyDone;
    tfMail.keyboardType = UIKeyboardTypeEmailAddress;
    tfMail.font = [UIFont fontWithName:kFontType size:22];
    
    
    
    //TextView del SMS//////////////////////////////
    tv.text=@"Ingresa el número al cual llegará el mensaje de texto";
    tv.textColor=[UIColor whiteColor];
    tv.backgroundColor=[UIColor clearColor];
    tv.font=[UIFont fontWithName:kFontType size:16];
    tv.alpha=0;
    tv.editable=NO;
    tv.scrollEnabled=NO;
    [contentMensajeView addSubview:tv];
    
    //TextView del MAIL//////////////////////////////
    tvMail.text=@"Ingresa el mail al cual será enviado el mensaje de pánico";
    tvMail.textColor=[UIColor whiteColor];
    tvMail.backgroundColor=[UIColor clearColor];
    tvMail.font=[UIFont fontWithName:kFontType size:16];
    tvMail.alpha=0;
    tvMail.editable=NO;
    tvMail.scrollEnabled=YES;
    [contentMensajeView addSubview:tvMail];
    
    UIImage *twitterButtonImage = [UIImage imageNamed:@"buttonTwitter.png"];
    
    buttonTwitter=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    [buttonTwitter setBackgroundImage:twitterButtonImage forState:UIControlStateNormal];
    buttonTwitter.center=CGPointMake((((contentMensajeView.frame.size.width/2)/2)/2)+5, contentMensajeView.frame.size.height/2);
    if (deviceKind==3) {
        buttonTwitter.center=CGPointMake((((contentMensajeView.frame.size.width/2)/2)/2)+85, contentMensajeView.frame.size.height/2);
    }
    [buttonTwitter addTarget:self action:@selector(twitterTrigger) forControlEvents:UIControlEventTouchUpInside];
    [viewDesplazar addSubview:buttonTwitter];
    
    //Label Twitter//////////////////////////////
    labelTwitter=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    labelTwitter.center=CGPointMake(120, contentMensajeView.frame.size.height/2);
    labelTwitter.text=@"Has selccionado twitter.";
    labelTwitter.textColor=[UIColor whiteColor];
    labelTwitter.backgroundColor=[UIColor clearColor];
    labelTwitter.font=[UIFont fontWithName:kFontType size:24];
    labelTwitter.alpha=0;
    [contentMensajeView addSubview:labelTwitter];
    
    UIImage *fbButtonImage = [UIImage imageNamed:@"buttonFB.png"];
    buttonFacebook=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    [buttonFacebook setBackgroundImage:fbButtonImage forState:UIControlStateNormal];
    buttonFacebook.center=CGPointMake((((contentMensajeView.frame.size.width/2)/2)/2)+(((contentMensajeView.frame.size.width/2)/2)/2)+40, contentMensajeView.frame.size.height/2);
    if (deviceKind==3) {
        buttonFacebook.center=CGPointMake((((contentMensajeView.frame.size.width/2)/2)/2)+(((contentMensajeView.frame.size.width/2)/2)/2)+125, contentMensajeView.frame.size.height/2);
    }
    [buttonFacebook addTarget:self action:@selector(facebookTrigger) forControlEvents:UIControlEventTouchUpInside];
    [viewDesplazar addSubview:buttonFacebook];
    
    //Label Facebook//////////////////////////////
    labelFacebook=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    labelFacebook.center=CGPointMake(contentMensajeView.frame.size.width-110, contentMensajeView.frame.size.height/2);
    labelFacebook.text=@"Has selccionado facebook.";
    labelFacebook.textColor=[UIColor whiteColor];
    labelFacebook.backgroundColor=[UIColor clearColor];
    labelFacebook.font=[UIFont fontWithName:kFontType size:24];
    labelFacebook.alpha=0;
    [contentMensajeView addSubview:labelFacebook];
    
    UIImage *mailButtonImage = [UIImage imageNamed:@"buttonMail.png"];
    buttonMail=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    [buttonMail setBackgroundImage:mailButtonImage forState:UIControlStateNormal];
    buttonMail.center=CGPointMake((((contentMensajeView.frame.size.width/2)/2)/2)+(((contentMensajeView.frame.size.width/2)/2)/2)+(((contentMensajeView.frame.size.width/2)/2)/2)+75, contentMensajeView.frame.size.height/2);
    if (deviceKind==3) {
        buttonMail.center=CGPointMake((((contentMensajeView.frame.size.width/2)/2)/2)+(((contentMensajeView.frame.size.width/2)/2)/2)+(((contentMensajeView.frame.size.width/2)/2)/2)+160, contentMensajeView.frame.size.height/2);
    }
    [buttonMail addTarget:self action:@selector(mailTrigger) forControlEvents:UIControlEventTouchUpInside];
    [viewDesplazar addSubview:buttonMail];
    
    UIImage *smsButtonImage = [UIImage imageNamed:@"buttonSMS.png"];
    buttonSms=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    buttonSms.center=CGPointMake((((contentMensajeView.frame.size.width/2)/2)/2)+(((contentMensajeView.frame.size.width/2)/2)/2)+(((contentMensajeView.frame.size.width/2)/2)/2)+(((contentMensajeView.frame.size.width/2)/2)/2)+110, contentMensajeView.frame.size.height/2);
    if (deviceKind==3) {
        buttonSms.center=CGPointMake((((contentMensajeView.frame.size.width/2)/2)/2)+(((contentMensajeView.frame.size.width/2)/2)/2)+(((contentMensajeView.frame.size.width/2)/2)/2)+(((contentMensajeView.frame.size.width/2)/2)/2)+190, contentMensajeView.frame.size.height/2);
    }
    [buttonSms setBackgroundImage:smsButtonImage forState:UIControlStateNormal];
    [buttonSms addTarget:self action:@selector(smsTrigger) forControlEvents:UIControlEventTouchUpInside];
    [viewDesplazar addSubview:buttonSms];
    
    CustomLabel *labelMensaje2=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, (self.view.frame.size.width)-20, 160)];
    [labelMensaje2 ponerTexto:@"El servicio que escojas será el utilizado para enviar el mensaje de pánico. El servicio predeterminado es Twitter. Solo podrás elegir uno a la vez." fuente:[UIFont fontWithName:kFontType size:14] color:kTitleBlueColor];
    labelMensaje2.numberOfLines = 4;
    labelMensaje2.overlayLabel.numberOfLines=4;
    labelMensaje2.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height-100);
    if (deviceKind==3) {
        labelMensaje2.center=CGPointMake(self.view.frame.size.width/2, 600);
        [labelMensaje2 ponerTexto:@"El servicio que escojas será el utilizado para enviar el mensaje de pánico. El servicio predeterminado es Twitter. Solo podrás elegir uno a la vez." fuente:[UIFont fontWithName:kFontType size:30] color:kTitleBlueColor];
    }
    else if(deviceKind==2){
        labelMensaje2.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height-120);
    }
    [labelMensaje2 setOverlayOff:NO];
    [self.view addSubview:labelMensaje2];
    
    CustomLabel *labelMensajeServicio=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, (self.view.frame.size.width)-20, 30)];
    [labelMensajeServicio ponerTexto:@"Servicio actual seleccionado:" fuente:[UIFont fontWithName:kFontType size:18] color:kTitleBlueColor];
    labelMensajeServicio.numberOfLines = 4;
    labelMensajeServicio.overlayLabel.numberOfLines=4;
    labelMensajeServicio.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height-70);
    if (deviceKind==3) {
        labelMensajeServicio.center=CGPointMake(self.view.frame.size.width/2, 690);
        [labelMensajeServicio ponerTexto:@"Servicio actual seleccionado:" fuente:[UIFont fontWithName:kFontType size:34] color:kTitleBlueColor];
    }
    else if (deviceKind==2){
        labelMensajeServicio.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height-90);
    }
    [labelMensajeServicio setOverlayOff:NO];
    [self.view addSubview:labelMensajeServicio];
    
}
-(void)dismissView{
    [self dismissModalViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear: (BOOL)animated {
    //Modelador *obj=[[Modelador alloc]init];
    NSString *redSocialName=[objeto obtenerNombreDeRedSocial];
    if ([redSocialName isEqualToString:@""]||[redSocialName isEqualToString:@" "]||redSocialName ==nil) {
        [objeto redSocialConNombre:@"Twitter"];
        redSocialLabel.text=[objeto obtenerNombreDeRedSocial];
    }
    else
        redSocialLabel.text=[objeto obtenerNombreDeRedSocial];
        banderaInfo=YES;
}
-(NSString*)actualizarMensaje{
    if ([textFieldUbicacion.text isEqualToString:@""]) {
        mensaje=@"Mi Ubicación actual es";
    }
    else{
    mensaje = textFieldUbicacion.text;
    }
    return mensaje;
}
-(void)enviarMensaje{
    [textFieldUbicacion resignFirstResponder];
    [objeto mensajeConInput:[self actualizarMensaje]];
    [[[[[self tabBarController] tabBar] items]
      objectAtIndex:3] setBadgeValue:nil];
    [self.navigationController popViewControllerAnimated:YES];
    NSString *correo=tfMail.text;
    double numeroDouble = [tf.text doubleValue];
    if ([tf.text length]>2) {
        [objeto setNumeroSMS:numeroDouble];
    }
    else if ([tf.text isEqualToString:@""]) {
        [objeto setNumeroSMS:0];
    }
    [objeto setMail:correo];
    [objeto redSocialConNombre:redSocial];
    [self dismissModalViewControllerAnimated:YES];
}
-(void)twitterTrigger{
    redSocial=@"Twitter";
    redSocialLabel.text=redSocial;
    if (!banderaDesplazar) {
        CGRect myMapRect;
        if (deviceKind==3) {
            myMapRect = CGRectMake(contentMensajeView.frame.size.width-227, 0, contentMensajeView.frame.size.width, contentMensajeView.frame.size.height);
        }
        else{
            myMapRect = CGRectMake(220, 0, contentMensajeView.frame.size.width, contentMensajeView.frame.size.height);
        }
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        viewDesplazar.frame = myMapRect;
        buttonMail.alpha=0;
        buttonFacebook.alpha=0;
        buttonSms.alpha=0;
        [UIView commitAnimations];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1.0];
        viewDesplazar.frame = myMapRect;
        labelTwitter.alpha=1;
        [UIView commitAnimations];
        banderaDesplazar=YES;
        return;
    }
    else{
        CGRect myMapRect = CGRectMake(0, 0, contentMensajeView.frame.size.width, contentMensajeView.frame.size.height);
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        viewDesplazar.frame = myMapRect;
        buttonMail.alpha=1;
        buttonFacebook.alpha=1;
        buttonSms.alpha=1;
        [UIView commitAnimations];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        viewDesplazar.frame = myMapRect;
        labelTwitter.alpha=0;
        [UIView commitAnimations];
        banderaDesplazar=NO;
        return;
    }
}
-(void)facebookTrigger{
    redSocial=@"Facebook";
    redSocialLabel.text=redSocial;
    
    if (!banderaDesplazar) {
        CGRect myMapRect;
        if (deviceKind==3) {
            myMapRect = CGRectMake(contentMensajeView.frame.size.width-1027, 0, contentMensajeView.frame.size.width, contentMensajeView.frame.size.height);
        }
        else{
            myMapRect = CGRectMake(-73, 0, contentMensajeView.frame.size.width, contentMensajeView.frame.size.height);
        }
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        viewDesplazar.frame = myMapRect;
        buttonMail.alpha=0;
        buttonTwitter.alpha=0;
        buttonSms.alpha=0;
        [UIView commitAnimations];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1.0];
        viewDesplazar.frame = myMapRect;
        labelFacebook.alpha=1;
        [UIView commitAnimations];
        banderaDesplazar=YES;
        return;
    }
    else{
        CGRect myMapRect = CGRectMake(0, 0, contentMensajeView.frame.size.width, contentMensajeView.frame.size.height);
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        viewDesplazar.frame = myMapRect;
        buttonMail.alpha=1;
        buttonTwitter.alpha=1;
        buttonSms.alpha=1;
        [UIView commitAnimations];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        viewDesplazar.frame = myMapRect;
        labelFacebook.alpha=0;
        [UIView commitAnimations];
        banderaDesplazar=NO;
        return;
    }

}
-(void)mailTrigger{
    redSocial=@"Mail";
    redSocialLabel.text=redSocial;

    if (!banderaDesplazar) {
        CGRect myMapRect;
        if (deviceKind==3) {
            myMapRect = CGRectMake(contentMensajeView.frame.size.width-490, 0, contentMensajeView.frame.size.width, contentMensajeView.frame.size.height);
        }
        else{
            myMapRect = CGRectMake(72, 0, contentMensajeView.frame.size.width, contentMensajeView.frame.size.height);
        }
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        viewDesplazar.frame = myMapRect;
        buttonTwitter.alpha=0;
        buttonFacebook.alpha=0;
        buttonSms.alpha=0;
        [UIView commitAnimations];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1.0];
        tfMail.alpha=1;
        tvMail.alpha=1;
        [UIView commitAnimations];
        banderaDesplazar=YES;
        return;
    }
    else{
        CGRect myMapRect = CGRectMake(0, 0, contentMensajeView.frame.size.width, contentMensajeView.frame.size.height);
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        viewDesplazar.frame = myMapRect;
        buttonTwitter.alpha=1;
        buttonFacebook.alpha=1;
        buttonSms.alpha=1;
        [UIView commitAnimations];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        tfMail.alpha=0;
        tvMail.alpha=0;
        [UIView commitAnimations];
        banderaDesplazar=NO;
        return;
    }
}
-(void)smsTrigger{
    redSocial=@"SMS";
    redSocialLabel.text=redSocial;
    if (!banderaDesplazar) {
        CGRect myMapRect;
        if (deviceKind==3) {
            myMapRect = CGRectMake(contentMensajeView.frame.size.width-615, 0, contentMensajeView.frame.size.width, contentMensajeView.frame.size.height);
        }
        else{
            myMapRect = CGRectMake(-220, 0, contentMensajeView.frame.size.width, contentMensajeView.frame.size.height);
        }
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        viewDesplazar.frame = myMapRect;
        buttonMail.alpha=0;
        buttonTwitter.alpha=0;
        buttonFacebook.alpha=0;
        [UIView commitAnimations];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1.0];
        viewDesplazar.frame = myMapRect;
        tf.alpha=1;
        tv.alpha=1;
        [UIView commitAnimations];
        banderaDesplazar=YES;
        return;
    }
    else{
        CGRect myMapRect = CGRectMake(0, 0, contentMensajeView.frame.size.width, contentMensajeView.frame.size.height);
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        viewDesplazar.frame = myMapRect;
        buttonMail.alpha=1;
        buttonTwitter.alpha=1;
        buttonFacebook.alpha=1;
        [UIView commitAnimations];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        viewDesplazar.frame = myMapRect;
        tf.alpha=0;
        tv.alpha=0;
        [UIView commitAnimations];
        banderaDesplazar=NO;
        return;
    }
    
}
#pragma mark - textfield delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag==3000) {
        
    }
    else{
        tecladoUp=YES;
        [self animarViewPorTeclado];
    }
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    tecladoUp=NO;
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self dismissKeyboard];
    return YES;
}
-(void)processTap:(id)sender{
    tecladoUp=NO;
    [self dismissKeyboard];
}

#pragma mark - animar view por teclado
-(void)animarViewPorTeclado{
    if (tecladoUp) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.view.frame=CGRectMake(0, -((self.view.frame.size.height/2)/2)+10, viewWidth, viewHeight);
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
    [textFieldUbicacion resignFirstResponder];
    [tf resignFirstResponder];
    [tfMail resignFirstResponder];
    tecladoUp=NO;
    [self animarViewPorTeclado];
}

@end
