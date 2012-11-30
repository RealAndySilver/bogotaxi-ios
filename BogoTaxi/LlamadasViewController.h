//
//  LlamadasViewController.h
//  BogoTaxi
//
//  Created by Development on 29/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCell.h"
#import "CustomButton.h"
#import "InformacionLlamadaView.h"

@interface LlamadasViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>{
    NSMutableArray *arrayTableView;
    UITableView *tableViewLlamadas;
    /*InformacionLlamadaView *informacion;*/
    int deviceKind;//1=iphone4, 2=iphone5, 3=ipad.
}

@end
