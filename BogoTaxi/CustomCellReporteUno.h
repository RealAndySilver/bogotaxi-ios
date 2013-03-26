//
//  CustomCellReporteUno.h
//  BogoTaxiLite
//
//  Created by Development on 11/02/13.
//  Copyright (c) 2013 iAmStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCellReporteUno : UITableViewCell{
    
}
@property (nonatomic,retain) UILabel *labelPositivos;
@property (nonatomic,retain) UILabel *labelNegativos;
@property (nonatomic,retain) UILabel *labelTotal;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andWidth:(float)width;
@end
