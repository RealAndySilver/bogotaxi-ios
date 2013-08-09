//
//  OpcionesCiudadViewController.h
//  MedeTaxi
//
//  Created by Development on 29/07/13.
//  Copyright (c) 2013 iAmStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BannerView.h"
#import "CustomCellCiudades.h"
#import "ServerCommunicator.h"
#import "Ciudad.h"
#import "MBProgressHud.h"
#import "FileSaver.h"
#import "AlertMessageView.h"

@interface OpcionesCiudadViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    int deviceKind;//1=iphone4, 2=iphone5, 3=ipad.
    UITableView *tableViewCiudad;
    NSMutableArray *arrayCiudades;
    NSMutableArray *arrayCiudadesSinDescargar;
    NSMutableArray *arrayNameCiudad;
    FileSaver *file;
    AlertMessageView *alert;
}

@end
