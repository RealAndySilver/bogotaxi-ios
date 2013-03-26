//
//  CustomCellReporte.h
//  BogoTaxiLite
//
//  Created by Development on 6/02/13.
//  Copyright (c) 2013 iAmStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CustomCellReporte : UITableViewCell{
    
}
@property(nonatomic,retain) UIView *viewMessage;
@property(nonatomic,retain) UIView *viewTipo;
@property(nonatomic,retain) UILabel *labelTipo;
@property (nonatomic,retain) UILabel *fecha;
@property (nonatomic,retain) UILabel *comentario;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andWidth:(float)width;
@end
