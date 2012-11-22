//
//  ViewController.m
//  BogoTaxi
//
//  Created by Andres Abril on 22/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CustomSwitch *switch1=[[CustomSwitch alloc]initWithFrame:CGRectMake(100, 300, 0, 0)];
    [self.view addSubview:switch1];
    
    CustomLabel *label1=[[CustomLabel alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [label1 ponerTexto:@"Hola Carambola"
                fuente:[UIFont fontWithName:@"LeagueGothic" size:20]
                 color:[UIColor darkGrayColor]];
    [self.view addSubview:label1];

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
