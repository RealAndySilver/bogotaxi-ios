//
//  CustomCellTop.h
//  BogoTaxiLite
//
//  Created by Nicolle Jimenez Vasquez on 20/02/13.
//  Copyright (c) 2013 iAmStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CustomCellTop : UITableViewCell{
    
}
@property (nonatomic,retain) UILabel *labelTopPositivos;
@property (nonatomic,retain) UILabel *labelTopNegativos;
@property (nonatomic,retain) UILabel *labelTopPlaca;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andWidth:(float)width;

@end
