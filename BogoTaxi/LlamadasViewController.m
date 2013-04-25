//
//  LlamadasViewController.m
//  BogoTaxi
//
//  Created by Development on 29/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "LlamadasViewController.h"
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

@interface LlamadasViewController ()

@end

@implementation LlamadasViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=kTitleBlueColor;
        
    tableViewLlamadas=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, (self.view.frame.size.height)-44)];
    tableViewLlamadas.backgroundColor=kTitleBlueColor;
    tableViewLlamadas.separatorStyle=NO;
    tableViewLlamadas.delegate=self;
    tableViewLlamadas.dataSource=self;
    [self.view addSubview:tableViewLlamadas];
 
    
    diccionarioDeLlamadas=[LLamadasObject traerDiccionarioConNumerosDeTaxis];
    arrayDeNumeros=[[NSMutableArray alloc]initWithArray:[diccionarioDeLlamadas allKeys]];
    arrayDeNumeros=[arrayDeNumeros sortedArrayUsingSelector:@selector(compare:)];
    
    UIView *barraAbajo=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width, 44)];
    barraAbajo.backgroundColor=[UIColor colorWithRed:0.0484375 green:0.3765625 blue:0.4390625 alpha:1];
    [self.view addSubview:barraAbajo];
    UIView *barraAbajoOver1=[[UIView alloc]initWithFrame:CGRectMake(0, 1, barraAbajo.frame.size.width, 43)];
    barraAbajoOver1.backgroundColor=[UIColor colorWithRed:0.2484375 green:0.5765625 blue:0.6390625 alpha:1];
    [barraAbajo addSubview:barraAbajoOver1];
    UIView *barraAbajoOver2=[[UIView alloc]initWithFrame:CGRectMake(0, 2, barraAbajo.frame.size.width, 42)];
    barraAbajoOver2.backgroundColor=[UIColor colorWithRed:0.1484375 green:0.4765625 blue:0.5390625 alpha:1];
    [barraAbajo addSubview:barraAbajoOver2];
    
    CustomButton *backButton=[[CustomButton alloc]initWithFrame:CGRectMake(5, self.view.frame.size.height-35, 50, 30)];
    backButton.backgroundColor=kYellowColor;
    [backButton setTitleColor:kDarkGrayColor forState:UIControlStateNormal];
    [backButton setTitle:@"Atrás" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    informacion=[[InformacionLlamadaView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [informacion construirInformaconConDeviceKind:deviceKind];
    informacion.tableView.delegate=self;
    informacion.tableView.dataSource=self;
    informacion.tableView.tag=100;
    informacion.tableView.separatorStyle=NO;
    [self.view addSubview:informacion];
}
-(void)dismissView{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag==100) {
        int count=[temporal allKeys].count;
        tableView.frame=CGRectMake(0, 0, informacion.frame.size.width, (55*count)+40);
        tableView.center=CGPointMake(informacion.frame.size.width/2, informacion.frame.size.height/2);
        return count;
    }
    return arrayDeNumeros.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier andWidth:self.view.frame.size.width];
    }
    //cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    //NSArray *arr=[[NSArray alloc]initWithArray:arrayTableView];
    if (tableView.tag==100) {
        NSArray *temp=[temporal allKeys];
        temp=[temp sortedArrayUsingSelector:@selector(compare:)];
        cell.labelEmpresaTaxi.text=[temp objectAtIndex:indexPath.row];
    }
    
    else{
        NSArray *sortedArray=[arrayDeNumeros sortedArrayUsingSelector:@selector(compare:) ];
        cell.labelEmpresaTaxi.text=[sortedArray objectAtIndex:indexPath.row];
        
    }
    return cell;
}

#pragma mark - tv delegate
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    [headerView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    UILabel *titleHeader=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 20)];
    titleHeader.text=[NSString stringWithFormat:@"Empresas de taxi de Bogotá"];
    if (tableView.tag==100) {
        titleHeader.text=[NSString stringWithFormat:@"Números %@",nombreEmpresa];
    }
    
    titleHeader.font=[UIFont fontWithName:kFontType size:16];
    titleHeader.textColor=[UIColor whiteColor];
    titleHeader.backgroundColor=[UIColor clearColor];
    [headerView addSubview:titleHeader];
    
    return headerView;
}
/*-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    [footerView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    UILabel *titleFooter=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 20)];
    titleFooter.text=[NSString stringWithFormat:@"Listado con todos los números de taxi de la ciudad"];
    if (tableView.tag==100) {
        titleFooter.text=[NSString stringWithFormat:@"Números %@",nombreEmpresa];
    }
    
    titleFooter.font=[UIFont fontWithName:kFontType size:16];
    titleFooter.textColor=kWhiteColor;
    titleFooter.backgroundColor=[UIColor clearColor];
    [footerView addSubview:titleFooter];
    
    return footerView;
}*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag==100) {
        NSArray *temp=[temporal allKeys];
        temp=[temp sortedArrayUsingSelector:@selector(compare:)];
        NSString *number=[temporal objectForKey:[temp objectAtIndex:indexPath.row]];
        NSString *phoneNumber = [@"tel://" stringByAppendingString:[NSString stringWithFormat:@"%@",number]];
        UIWebView *webview=[[UIWebView alloc]init];
        NSURL *theURL=[NSURL URLWithString:phoneNumber];
        [webview loadRequest:[NSURLRequest requestWithURL:theURL]];
        [self.view addSubview:webview];

    }
    else{
        temporal=nil;
        nombreEmpresa=[arrayDeNumeros objectAtIndex:indexPath.row];
        temporal=[LLamadasObject traerDiccionarioConNombre:nombreEmpresa];
        NSLog(@"Cell touched %@ at index %i",nombreEmpresa,indexPath.row);
        [informacion.tableView reloadData];
        [self callInformacion];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)callInformacion{
    
    [informacion changeState];
}



@end
