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
    banderaInfo=YES;
    CGRect tfRect = CGRectMake(90, 50, 200, 30);
    CGRect tfMailRect = CGRectMake(10, 50, 200, 30);
    CGRect tvRect = CGRectMake(85, 0, 200, 45);
    CGRect tvRectMail = CGRectMake(5, 0, 200, 45);
    tf=[[UITextField alloc]initWithFrame:tfRect];
    tfMail=[[UITextField alloc]initWithFrame:tfMailRect];
    tfMail.autocorrectionType=UITextAutocorrectionTypeNo;
    tv=[[UITextView alloc]initWithFrame:tvRect];
    tvMail=[[UITextView alloc]initWithFrame:tvRectMail];
    
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
    //[saveButton addTarget:self action:@selector(enviarMensaje) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
    
    BannerView *bannerView=[[BannerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-10, 0)];
    [bannerView ponerTexto:@"BOTÓN DE PANICO"];
    bannerView.configBannerLabel.textColor=kYellowColor;
    [bannerView.configBannerLabel setOverlayOff:YES];
    [bannerView setBannerColor:kDarkGrayColor];
    bannerView.center=CGPointMake(self.view.frame.size.width/2, 45);
    [self.view addSubview:bannerView];
    
    [self crearContainer];
    
}
-(void)crearContainer{
    labelMensajeUbicacion=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, (self.view.frame.size.width)-20, 70)];
    [labelMensajeUbicacion ponerTexto:@"Ingresa el texto que irá en el mensaje de pánico" fuente:[UIFont fontWithName:kFontType size:28] color:kTitleBlueColor];
    labelMensajeUbicacion.numberOfLines = 2;
    labelMensajeUbicacion.overlayLabel.numberOfLines=2;
    labelMensajeUbicacion.center=CGPointMake(self.view.frame.size.width/2, 110);
    [labelMensajeUbicacion setOverlayOff:NO];
    //[labelMensajeUbicacion setCentrado:YES];
    [self.view addSubview:labelMensajeUbicacion];
    
    textFieldUbicacion = [[UITextField alloc] initWithFrame:CGRectMake(90, 112, 215, 30)];
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
    //[textFieldUbicacion addTarget:self action:@selector(actualizarMensaje) forControlEvents:UIControlEventEditingChanged];
    //[textFieldUbicacion addTarget:self action:@selector(enviarMensaje) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:textFieldUbicacion];
    textFieldUbicacion.delegate = self;
    
    Modelador *obj=[[Modelador alloc]init];
    NSString *mensajePanico;
    NSString *numeroSMS;
    NSString *correo;
    
    if ([[obj obtenerMensajeDePanico] isEqualToString:@" "]||[[obj obtenerMensajeDePanico] isEqualToString:@""]||[obj obtenerMensajeDePanico]==nil) {
        mensajePanico=@"Mi Ubicación actual es ";
    }
    else{
        mensajePanico=[obj obtenerMensajeDePanico];
    }
    if ([[obj getNumeroSMS] isEqualToString:@" "]||[[obj getNumeroSMS] isEqualToString:@""]||[obj getNumeroSMS]==nil
        ||[[obj getNumeroSMS] isEqualToString:@"0"]) {
        tf.placeholder=@"# predeterminado";
        
    }
    else{
        numeroSMS=[obj getNumeroSMS];
        tf.text=numeroSMS;
    }
    if ([[obj getMail] isEqualToString:@" "]||[[obj getMail] isEqualToString:@""]||[obj getMail]==nil
        ||[[obj getMail] isEqualToString:@"0"]) {
        tfMail.placeholder=@"Correo";
        
    }
    else{
        correo=[obj getMail];
        tfMail.text=correo;
    }
    textFieldUbicacion.text=mensajePanico;
    //[[[[[self tabBarController] tabBar] items] objectAtIndex:3] setBadgeValue:@"Editando"];
    /*UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];*/
    
    NSString *redSocialName=[obj obtenerNombreDeRedSocial];
    if ([redSocialName isEqualToString:@""]||[redSocialName isEqualToString:@" "]||redSocialName ==nil) {
        [obj redSocialConNombre:@"Twitter"];
        //redSocialLabel.text=[obj obtenerNombreDeRedSocial];
    }
    
    labelMensaje=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, (self.view.frame.size.width)-20, 80)];
    [labelMensaje ponerTexto:@"Si no ingresas ningún mensaje la aplicación pondra por defecto ''Mi ubicación actual es''. Tu mensaje siempre llevará una imagen del mapa con tu ubicación actual para que tus seguidores o a quién decidas enviar el mensaje lo pueda ver." fuente:[UIFont fontWithName:kFontType size:14] color:kTitleBlueColor];
    //labelMensaje.backgroundColor=kGreenColor;
    labelMensaje.numberOfLines = 4;
    labelMensaje.overlayLabel.numberOfLines=4;
    labelMensaje.center=CGPointMake(self.view.frame.size.width/2, 180);
    [labelMensaje setOverlayOff:NO];
    [self.view addSubview:labelMensaje];
    
    labelTitulo=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, (self.view.frame.size.width)-20, 60)];
    [labelTitulo ponerTexto:@"ENVIÓ DEL MENSAJE" fuente:[UIFont fontWithName:kFontType size:40] color:kTitleBlueColor];
    labelTitulo.numberOfLines = 2;
    labelTitulo.overlayLabel.numberOfLines=2;
    labelTitulo.center=CGPointMake(self.view.frame.size.width/2, 230);
    [labelTitulo setOverlayOff:NO];
    [labelTitulo setCentrado:YES];
    [self.view addSubview:labelTitulo];
    
    contentMensajeView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, (self.view.frame.size.width)-10, 90)];
    contentMensajeView.center=CGPointMake(self.view.frame.size.width/2, (self.view.frame.size.height)-163);
    contentMensajeView.backgroundColor=kDarkGrayColor;
    [self.view addSubview:contentMensajeView];
    
    viewDesplazar=[[UIView alloc]initWithFrame:CGRectMake(0, 0, contentMensajeView.frame.size.width, contentMensajeView.frame.size.height)];
    //viewDesplazar.backgroundColor=kGreenColor;
    [contentMensajeView addSubview:viewDesplazar];
    
    banderaDesplazar=NO;
    
    //Textfield del sms////////////////////////////
    tf.borderStyle = UITextBorderStyleRoundedRect;
    [contentMensajeView addSubview:tf];
    tf.alpha=0;
    [tf addTarget:self
           action:@selector(moverViewArriba)
 forControlEvents:UIControlEventEditingDidBegin];
    [tf addTarget:self
           action:@selector(moverViewAbajo)
 forControlEvents:UIControlEventEditingDidEnd];
    //tf.placeholder = @"Número predeterminado";
    tf.returnKeyType = UIReturnKeyDone;
    tf.keyboardType = UIKeyboardTypeNumberPad;
    
    //TextField del Mail////////////////////////////
    tfMail.borderStyle = UITextBorderStyleRoundedRect;
    [contentMensajeView addSubview:tfMail];
    tfMail.alpha=0;
    [tfMail addTarget:self
               action:@selector(moverViewArriba)
     forControlEvents:UIControlEventEditingDidBegin];
    [tfMail addTarget:self
               action:@selector(moverViewAbajo)
     forControlEvents:UIControlEventEditingDidEnd];
    [tfMail addTarget:self
               action:@selector(enviarMensaje)
     forControlEvents:UIControlEventEditingDidEndOnExit];
    //tf.placeholder = @"Número predeterminado";
    tfMail.returnKeyType = UIReturnKeyDone;
    tfMail.keyboardType = UIKeyboardTypeEmailAddress;
    
    
    
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
    
    buttonTwitter=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    buttonTwitter.backgroundColor=kBlueColor;
    buttonTwitter.center=CGPointMake((((contentMensajeView.frame.size.width/2)/2)/2)+5, contentMensajeView.frame.size.height/2);
    [buttonTwitter addTarget:self action:@selector(twitterTrigger) forControlEvents:UIControlEventTouchUpInside];
    [viewDesplazar addSubview:buttonTwitter];
    
    buttonFacebook=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    buttonFacebook.backgroundColor=kGreenColor;
    buttonFacebook.center=CGPointMake((((contentMensajeView.frame.size.width/2)/2)/2)+(((contentMensajeView.frame.size.width/2)/2)/2)+40, contentMensajeView.frame.size.height/2);
    [buttonFacebook addTarget:self action:@selector(facebookTrigger) forControlEvents:UIControlEventTouchUpInside];
    [viewDesplazar addSubview:buttonFacebook];
    
    buttonMail=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    buttonMail.backgroundColor=kYellowColor;
    buttonMail.center=CGPointMake((((contentMensajeView.frame.size.width/2)/2)/2)+(((contentMensajeView.frame.size.width/2)/2)/2)+(((contentMensajeView.frame.size.width/2)/2)/2)+75, contentMensajeView.frame.size.height/2);
    [buttonMail addTarget:self action:@selector(mailTrigger) forControlEvents:UIControlEventTouchUpInside];
    [viewDesplazar addSubview:buttonMail];
    
    buttonSms=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    buttonSms.center=CGPointMake((((contentMensajeView.frame.size.width/2)/2)/2)+(((contentMensajeView.frame.size.width/2)/2)/2)+(((contentMensajeView.frame.size.width/2)/2)/2)+(((contentMensajeView.frame.size.width/2)/2)/2)+110, contentMensajeView.frame.size.height/2);
    buttonSms.backgroundColor=kBlueColor;
    [buttonSms addTarget:self action:@selector(smsTrigger) forControlEvents:UIControlEventTouchUpInside];
    [viewDesplazar addSubview:buttonSms];
    
    CustomLabel *labelMensaje2=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, (self.view.frame.size.width)-20, 40)];
    [labelMensaje2 ponerTexto:@"El servicio que escojas será el utilizado para enviar el mensaje de pánico. El servicio predeterminado es Twitter. Solo podrás elegir uno a la vez." fuente:[UIFont fontWithName:kFontType size:14] color:kTitleBlueColor];
    labelMensaje2.numberOfLines = 4;
    labelMensaje2.overlayLabel.numberOfLines=4;
    labelMensaje2.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height-100);
    [labelMensaje2 setOverlayOff:NO];
    //[labelMensaje setCentrado:YES];
    [self.view addSubview:labelMensaje2];
    
    CustomLabel *labelMensajeServicio=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, (self.view.frame.size.width)-20, 16)];
    [labelMensajeServicio ponerTexto:@"Servicio actual seleccionado:" fuente:[UIFont fontWithName:kFontType size:18] color:kTitleBlueColor];
    labelMensajeServicio.numberOfLines = 4;
    labelMensajeServicio.overlayLabel.numberOfLines=4;
    labelMensajeServicio.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height-62);
    [labelMensajeServicio setOverlayOff:NO];
    //[labelMensaje setCentrado:YES];
    [self.view addSubview:labelMensajeServicio];
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
- (void)viewDidAppear: (BOOL)animated {
    Modelador *obj=[[Modelador alloc]init];
    NSString *redSocialName=[obj obtenerNombreDeRedSocial];
    if ([redSocialName isEqualToString:@""]||[redSocialName isEqualToString:@" "]||redSocialName ==nil) {
        [obj redSocialConNombre:@"Twitter"];
        //redSocialLabel.text=[obj obtenerNombreDeRedSocial];
        NSLog(@"No existía y lo creé");
    }
    else
        //redSocialLabel.text=[obj obtenerNombreDeRedSocial];
    banderaInfo=YES;
}
-(NSString*)actualizarMensaje{
    mensaje = textFieldUbicacion.text;
    return mensaje;
}
-(void)enviarMensaje{
    [textFieldUbicacion resignFirstResponder];
    NSLog(@"Mensaje: %@",[self actualizarMensaje]);
    Modelador *msj=[[Modelador alloc]init];
    [msj mensajeConInput:[self actualizarMensaje]];
    [[[[[self tabBarController] tabBar] items]
      objectAtIndex:3] setBadgeValue:nil];
    [self.navigationController popViewControllerAnimated:YES];
    NSString *numeroString=tf.text;
    NSString *correo=tfMail.text;
    double numeroDouble = [numeroString doubleValue];
    [msj setNumeroSMS:numeroDouble];
    [msj setMail:correo];
}
-(void)twitterTrigger{
    Modelador *obj=[[Modelador alloc]init];
    [obj redSocialConNombre:@"Twitter"];
    //redSocialLabel.text=[obj obtenerNombreDeRedSocial];
    NSLog(@"Red Social: %@",[obj obtenerNombreDeRedSocial]);
}
-(void)facebookTrigger{
    Modelador *obj=[[Modelador alloc]init];
    [obj redSocialConNombre:@"Facebook"];
    //redSocialLabel.text=[obj obtenerNombreDeRedSocial];
    NSLog(@"Red Social: %@",[obj obtenerNombreDeRedSocial]);
}
-(void)mailTrigger{
    Modelador *obj=[[Modelador alloc]init];
    [obj redSocialConNombre:@"Mail"];
    //redSocialLabel.text=[obj obtenerNombreDeRedSocial];
    NSLog(@"Red Social: %@",[obj obtenerNombreDeRedSocial]);
    if (!banderaDesplazar) {
        
        CGRect myMapRect = CGRectMake(75, 0, contentMensajeView.frame.size.width, contentMensajeView.frame.size.height);
        //viewDesplazar.alpha=1;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        viewDesplazar.frame = myMapRect;
        buttonTwitter.alpha=0;
        buttonFacebook.alpha=0;
        buttonSms.alpha=0;
        //viewDesplazar.alpha=0;
        [UIView commitAnimations];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1.0];
        tfMail.alpha=1;
        tvMail.alpha=1;
        //viewDesplazar.alpha=0;
        [UIView commitAnimations];
        banderaDesplazar=YES;
        return;
    }
    else{
        CGRect myMapRect = CGRectMake(0, 0, contentMensajeView.frame.size.width, contentMensajeView.frame.size.height);
        //viewDesplazar.alpha=1;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        viewDesplazar.frame = myMapRect;
        buttonTwitter.alpha=1;
        buttonFacebook.alpha=1;
        buttonSms.alpha=1;
        //viewDesplazar.alpha=0;
        [UIView commitAnimations];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        tfMail.alpha=0;
        tvMail.alpha=0;
        //viewDesplazar.alpha=0;
        [UIView commitAnimations];
        banderaDesplazar=NO;
        return;
    }
}
-(void)smsTrigger{
    Modelador *obj=[[Modelador alloc]init];
    [obj redSocialConNombre:@"SMS"];
    //redSocialLabel.text=[obj obtenerNombreDeRedSocial];
    NSLog(@"Red Social: %@",[obj obtenerNombreDeRedSocial]);
    if (!banderaDesplazar) {
        
        CGRect myMapRect = CGRectMake(-220, 0, contentMensajeView.frame.size.width, contentMensajeView.frame.size.height);
        //viewDesplazar.alpha=1;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        viewDesplazar.frame = myMapRect;
        buttonMail.alpha=0;
        //viewDesplazar.alpha=0;
        [UIView commitAnimations];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1.0];
        viewDesplazar.frame = myMapRect;
        tf.alpha=1;
        tv.alpha=1;
        //viewDesplazar.alpha=0;
        [UIView commitAnimations];
        banderaDesplazar=YES;
        return;
    }
    else{
        CGRect myMapRect = CGRectMake(0, 0, contentMensajeView.frame.size.width, contentMensajeView.frame.size.height);
        //viewDesplazar.alpha=1;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        viewDesplazar.frame = myMapRect;
        buttonMail.alpha=1;
        //viewDesplazar.alpha=0;
        [UIView commitAnimations];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        viewDesplazar.frame = myMapRect;
        tf.alpha=0;
        tv.alpha=0;
        //viewDesplazar.alpha=0;
        [UIView commitAnimations];
        banderaDesplazar=NO;
        return;
    }
    
}
-(void)moverViewArriba{
    CGRect myMapRect = CGRectMake(0, -150, self.view.frame.size.width, self.view.frame.size.height);
    //viewDesplazar.alpha=1;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    self.view.frame = myMapRect;
    //viewDesplazar.alpha=0;
    [UIView commitAnimations];
    
}
-(void)moverViewAbajo{
    CGRect myMapRect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    //viewDesplazar.alpha=1;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    self.view.frame = myMapRect;
    //viewDesplazar.alpha=0;
    [UIView commitAnimations];
    
    
}

@end
