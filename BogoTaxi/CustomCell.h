//
//  CustomCell.h
//  BogoTaxi
//
//  Created by Development on 29/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface CustomCell : UITableViewCell{
    
}
@property (nonatomic,retain) UIView *backgroundCell;
@property (nonatomic,retain) UIView *backgroundOverlay;
@property (nonatomic,retain) UILabel *labelEmpresaTaxi;
@property (nonatomic,retain) UIView *accessoryCell;

@end
