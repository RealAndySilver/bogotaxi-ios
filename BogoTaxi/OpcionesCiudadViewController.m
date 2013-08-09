//
//  OpcionesCiudadViewController.m
//  MedeTaxi
//
//  Created by Development on 29/07/13.
//  Copyright (c) 2013 iAmStudio. All rights reserved.
//

#import "OpcionesCiudadViewController.h"
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

@interface OpcionesCiudadViewController ()

@end

@implementation OpcionesCiudadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}
-(void)receivedDataFromServer:(ServerCommunicator*)server{
    if ([server.methodName isEqualToString:@"ListaCiudades"]) {
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [file setDictionary:server.resDic withKey:@"ciudades"];
        dic=[server.resDic objectForKey:@"array"];
        for (NSMutableDictionary *dic1 in dic) {
            Ciudad *ciudadDic=[[Ciudad alloc]leerCiudadConDiccionario:dic1];
            if (![file getDictionary:[NSString stringWithFormat:@"taximetro%@",ciudadDic.acr]]){
                [arrayCiudadesSinDescargar addObject:ciudadDic];
            }
            else{
                [arrayCiudades addObject:ciudadDic];
            }
            
        }
        [self crearTableView];
        [tableViewCiudad reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    else if ([server.methodName isEqualToString:@"UltimaVersion"]){
        NSDictionary *dic=[[NSDictionary alloc]init];
        NSString *status=[[NSString alloc]init];
        status=[server.resDic objectForKey:@"Status"];
        if ([status isEqualToString:@"no"]) {
            dic=[server.resDic objectForKey:@"Taximetro"];
            NSString *nameDictionary=[[NSString alloc]initWithString:[NSString stringWithFormat:@"taximetro%@",[file getLastCity]]];
            [file setDictionary:dic withKey:nameDictionary];
            //taximetro=nil;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"cuidad" object:arrayNameCiudad];
        }
        else{
            
        }
        [self dismissView];
    }
    
}
-(void)receivedDataFromServerWithError:(ServerCommunicator*)server{
    if ([server.methodName isEqualToString:@"ListaCiudades"]) {
        NSDictionary *resultado=[file getDictionary:@"ciudades"];
        NSArray *array=[resultado objectForKey:@"array"];
        for (NSDictionary *dic1 in array) {
            Ciudad *ciudadDic=[[Ciudad alloc]leerCiudadConDiccionario:dic1];
            if (![file getDictionary:[NSString stringWithFormat:@"taximetro%@",ciudadDic.acr]]){
                [arrayCiudadesSinDescargar addObject:ciudadDic];
            }
            else{
                [arrayCiudades addObject:ciudadDic];
            }
        }
        [self crearTableView];
        [tableViewCiudad reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    else if ([server.methodName isEqualToString:@"UltimaVersion"]){
        [alert changeState];
        [self.view bringSubviewToFront:alert];
        [alert.labelMensaje ponerTexto:@"No tienes conexión a internet, por favor conéctate a una red" fuente:[UIFont fontWithName:kFontType size:32] color:kWhiteColor];
        
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    file=[[FileSaver alloc]init];
    ServerCommunicator *server=[[ServerCommunicator alloc]init];
    arrayCiudades=[[NSMutableArray alloc]init];
    [arrayCiudades removeAllObjects];
    arrayNameCiudad=[[NSMutableArray alloc]init];
    [arrayNameCiudad removeAllObjects];
    arrayCiudadesSinDescargar=[[NSMutableArray alloc]init];
    [arrayCiudadesSinDescargar removeAllObjects];
    server.caller=self;
    server.methodName=@"ListaCiudades";
    //NSString *parameters=[NSString stringWithFormat:@"version=%@&ciudad=%@", taximetro.version,[saverObj getLastCity]];
    [server callServerWithMethod:server.methodName andParameter:@""];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    alert=[[AlertMessageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [alert crearView];
    [self.view addSubview:alert];
    
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
    BannerView *bannerView=[[BannerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-10, 0)];
    
    [bannerView ponerTexto:@"OPCIONES CIUDAD"];
    bannerView.configBannerLabel.textColor=[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1];
    [bannerView.configBannerLabel setOverlayOff:NO];
    [bannerView setBannerColor:kWhiteColor];
    bannerView.center=CGPointMake(self.view.frame.size.width/2, 50);
    [self.view addSubview:bannerView];
    
    tableViewCiudad=[[UITableView alloc]init];
    tableViewCiudad.delegate=self;
    tableViewCiudad.dataSource=self;
    tableViewCiudad.backgroundColor=[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1];
    tableViewCiudad.separatorStyle=NO;
    [self.view addSubview:tableViewCiudad];
    [self crearTableView];
    
    UIView *viewBottom=[[UIView alloc]initWithFrame:CGRectMake(0, (self.view.frame.size.height)-60, self.view.frame.size.width, 60)];
    viewBottom.backgroundColor=[UIColor colorWithRed:0.21484375 green:0.21484375 blue:0.21484375 alpha:1];
    [self.view addSubview:viewBottom];
    
    UILabel *labelMensaje=[[UILabel alloc]initWithFrame:CGRectMake(5, (self.view.frame.size.height)-60, (self.view.frame.size.width)-10, 60)];
    labelMensaje.text=[NSString stringWithFormat:@"Elige la ciudad para la cual quieres configurar el taximetro, la ciudada actual es %@.",[file getLastNameCity]];
    //labelMensaje.textAlignment=NSTextAlignmentCenter;
    labelMensaje.font=[UIFont fontWithName:kFontType size:18];
    labelMensaje.backgroundColor=[UIColor clearColor];
    labelMensaje.textColor=[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    labelMensaje.numberOfLines=2;
    [self.view addSubview:labelMensaje];
	// Do any additional setup after loading the view.
}
-(void)crearTableView{
    tableViewCiudad.frame=CGRectMake(0, 0, self.view.frame.size.width-10, (60*(arrayCiudades.count+arrayCiudadesSinDescargar.count))+50);
    if (tableViewCiudad.frame.size.height>(60*5)+50) {
        tableViewCiudad.frame=CGRectMake(0, 0, self.view.frame.size.width-10, (60*5)+50);
    }
    tableViewCiudad.center=CGPointMake(self.view.frame.size.width/2, (self.view.frame.size.height/2)+10);
}
#pragma mark - Delegate tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return arrayCiudades.count;
    }
    else if (section==1) {
        return arrayCiudadesSinDescargar.count;
    }
    return 0;
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if(section == 0){
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
        [headerView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        UILabel *titleHeader=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 20)];
        titleHeader.text=[NSString stringWithFormat:@"Taximetros guardados"];
        titleHeader.font=[UIFont fontWithName:kFontType size:16];
        titleHeader.textColor=[UIColor whiteColor];
        titleHeader.backgroundColor=[UIColor clearColor];
        [headerView addSubview:titleHeader];
        return headerView;
    }
    if(section == 1){
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
        [headerView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        UILabel *titleHeader=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 20)];
        if (arrayCiudadesSinDescargar.count==0) {
            titleHeader.text=[NSString stringWithFormat:@"No hay taximetros disponibles para descarga"];
        }
        else{
            titleHeader.text=[NSString stringWithFormat:@"Taximetros disponibles para descarga"];
        }
        
        titleHeader.font=[UIFont fontWithName:kFontType size:16];
        titleHeader.textColor=[UIColor whiteColor];
        titleHeader.backgroundColor=[UIColor clearColor];
        [headerView addSubview:titleHeader];
        return headerView;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableview cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
        static NSString *CellIdentifier = @"";
        CustomCellCiudades *cell1 = [tableview dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell1 == nil) {
            cell1=[[CustomCellCiudades alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier andWidth:self.view.frame.size.width];
        }
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        Ciudad *ciudad=[arrayCiudades objectAtIndex:indexPath.row];
        if ([ciudad.nombre isEqualToString:[file getLastNameCity]]) {
            cell1.viewMessage.backgroundColor=kLiteBlueColor;
        }
        cell1.labelCiudad.text=ciudad.nombre;
        return cell1;
    }
    else if (indexPath.section==1){
        static NSString *CellIdentifier = @"";
        CustomCellCiudades *cell2 = [tableview dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell2 == nil) {
            cell2=[[CustomCellCiudades alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier andWidth:self.view.frame.size.width];
        }
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        Ciudad *ciudad=[arrayCiudadesSinDescargar objectAtIndex:indexPath.row];
        if ([ciudad.nombre isEqualToString:[file getLastNameCity]]) {
            cell2.viewMessage.backgroundColor=kLiteBlueColor;
        }
        cell2.labelCiudad.text=ciudad.nombre;
        return cell2;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //[self.delegate cambiarCiudadCon:[arrayCiudades objectAtIndex:indexPath.row]];
    [arrayNameCiudad removeAllObjects];
    Ciudad *ciudad=[[Ciudad alloc]init];
    if (indexPath.section==0) {
        ciudad=[arrayCiudades objectAtIndex:indexPath.row];
    }
    else if(indexPath.section==1){
        ciudad=[arrayCiudadesSinDescargar objectAtIndex:indexPath.row];
    }
    
    [arrayNameCiudad addObject:ciudad.acr];
    [arrayNameCiudad addObject:ciudad.nombre];
    [file setLastCity:ciudad.acr];
    [file setLastNameCity:ciudad.nombre];
    if (![file getDictionary:[NSString stringWithFormat:@"taximetro%@",ciudad.acr]]) {
        ServerCommunicator *server=[[ServerCommunicator alloc]init];
        server.caller=self;
        server.methodName=@"UltimaVersion";
        NSString *parameters=[NSString stringWithFormat:@"version=0&ciudad=%@",[arrayNameCiudad objectAtIndex:0]];
        [server callServerWithMethod:server.methodName andParameter:parameters];
    }
    else{
        //NSLog(@"ya existe un diccionario con ese nombre taximetro%@",[arrayNameCiudad objectAtIndex:0]);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"cuidad" object:arrayNameCiudad];
        [self dismissView];
    }
}
-(void)dismissView{
    [self dismissModalViewControllerAnimated:YES];
}

@end
