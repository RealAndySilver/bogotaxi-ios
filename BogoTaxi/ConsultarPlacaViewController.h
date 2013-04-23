//
//  ConsultarPlacaViewController.h
//  BogoTaxi
//
//  Created by Development on 11/03/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerCommunicator.h"
#import "BannerView.h"
#import "CustomCellReporteUno.h"
#import "CustomCellReporte.h"
#import "CustomCellTop.h"
#import "Reportes.h"
#import "Taxista.h"
#import "TopTaxi.h"
#import "CustomSwitch.h"
#import "Taximetro.h"
#import "DetailReporteViewController.h"
#import "MBProgressHud.h"
#import "DeviceInfo.h"
#import "ViewInformacion.h"
#import "AlertView.h"
#import "AlertMessageView.h"

@interface ConsultarPlacaViewController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate, UITextViewDelegate>{
    
    AlertMessageView *alert;
    AlertView *alertReporta;
    
    UIScrollView *scrollViewContent;
    
    UIButton *buttonConsultar;
    UITextField *textFieldPlaca;
    CGRect viewFrame;
    CGFloat viewWidth;
    CGFloat viewHeight;
    UIView *contentViewConsulta;
    NSMutableArray *arrayReportes;
    NSMutableArray *arrayTaxista;
    int pos;
    int neg;
    UITableView *tableViewReportes;
    CGRect posIniTableView;
    CGRect posFinTableView;
    BOOL tecladoUp;
    UITapGestureRecognizer *recognizer;
    UILabel *mensajeConsulta;
    UIView *viewPlacaSinreporte;
    UIView *contentViewInformacion;
    UIButton *buttonInformacion;
    UIView *viewMessageContent;
    
    UIView *contentViewReporta;
    UITextField *textFieldPlacaReportar;
    UIView *containerTipo;
    UILabel *labelPositivo;
    UILabel *labelNegativo;
    UIView *viewReporteWrapper;
    NSString *tipoReporte;
    UITextView *textViewComentarioReportar;
    UIButton *buttonReportar;
    UILabel *mensajeReporte;
    UILabel *mensajeReporte2;
    UIButton *buttonVerMasReportes;
    UIView *viewLabelsReportes;
    
    UIButton *topMalos;
    UIButton *topBuenos;
    UITableView *tableViewMalos;
    UITableView *tableViewBuenos;
    NSMutableArray *arrayTiposMalos;
    NSMutableArray *arrayTiposBuenos;
    
    int deviceKind;//1=iphone4, 2=iphone5, 3=ipad.
    
    UIButton *menuButtonConsultar;
    UIButton *menuButtonReportar;
    UIButton *menuButtonAtras;
    UIButton *menuButtonTop10;
    
    MBProgressHUD *hud;
}
@property (nonatomic,retain) NSString *stringPlaca;
-(void)consutar;

@end
