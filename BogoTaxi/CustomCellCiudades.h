//
//  CustomCellCiudades.h
//  MedeTaxi
//
//  Created by Development on 30/07/13.
//  Copyright (c) 2013 iAmStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CustomCellCiudades : UITableViewCell{
    
}
@property(nonatomic,retain) UIView *viewMessage;
@property (nonatomic,retain) UILabel *labelCiudad;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andWidth:(float)width;

@end
