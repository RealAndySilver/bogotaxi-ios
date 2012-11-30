//
//  LlamadasViewController.m
//  BogoTaxi
//
//  Created by Development on 29/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "LlamadasViewController.h"
#define kFontType @"LeagueGothic"
#define kBlueColor [UIColor colorWithRed:0.50390625 green:0.796875 blue:0.8515625 alpha:1]
#define kYellowColor [UIColor colorWithRed:0.984375 green:0.828125 blue:0.390625 alpha:1]
#define kYellowColor [UIColor colorWithRed:0.984375 green:0.828125 blue:0.390625 alpha:1]
#define kDarkGrayColor [UIColor darkGrayColor]
#define kGrayColor [UIColor grayColor]

@interface LlamadasViewController ()

@end

@implementation LlamadasViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=kBlueColor;
    tableViewLlamadas=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, (self.view.frame.size.height)-50)];
    tableViewLlamadas.backgroundColor=[UIColor clearColor];
    tableViewLlamadas.separatorStyle=NO;
    tableViewLlamadas.delegate=self;
    tableViewLlamadas.dataSource=self;
    [self.view addSubview:tableViewLlamadas];
    
    arrayTableView=[[NSMutableArray alloc]init];
    [arrayTableView addObject:@"Aero Taxi"];
    [arrayTableView addObject:@"Alo Taxis"];
    [arrayTableView addObject:@"Astaxdorado"];
    [arrayTableView addObject:@"Auto Taxi Ejecutivo"];
    [arrayTableView addObject:@"Aero Taxi"];
    [arrayTableView addObject:@"Alo Taxis"];
    [arrayTableView addObject:@"Astaxdorado"];
    [arrayTableView addObject:@"Auto Taxi Ejecutivo"];
    
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
#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrayTableView.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    //NSArray *arr=[[NSArray alloc]initWithArray:arrayTableView];
    cell.labelEmpresaTaxi.text=[arrayTableView objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - tv delegate
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    [headerView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    UILabel *titleHeader=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 20)];
    titleHeader.text=[NSString stringWithFormat:@"Empresas de taxi de Bogotá"];
    titleHeader.font=[UIFont fontWithName:kFontType size:16];
    titleHeader.textColor=[UIColor whiteColor];
    titleHeader.backgroundColor=[UIColor clearColor];
    [headerView addSubview:titleHeader];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self callInformacion];
}
-(void)callInformacion{
    InformacionLlamadaView *informacion=[[InformacionLlamadaView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [informacion construirInformaconConDeviceKind:deviceKind];
    [self.view addSubview:informacion];
    [informacion changeState];
}



@end
