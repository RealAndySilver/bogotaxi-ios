//
//  Map.m
//  CryptoChat
//
//  Created by Nicolle on 20/09/12.
//  Copyright (c) 2012 iAmStudio. All rights reserved.
//

#import "RegionAnnotationView.h"

@implementation RegionAnnotationView

@synthesize map, theAnnotation;

- (id)initWithAnnotation:(id <MKAnnotation>)annotation withcolor:(MKPinAnnotationColor)color{
	self = [super initWithAnnotation:annotation reuseIdentifier:[annotation title]];
	
	if (self) {
		self.canShowCallout	= YES;
		self.multipleTouchEnabled = NO;
		self.draggable = YES;
		self.animatesDrop = YES;
		self.map = nil;
		theAnnotation = (RegionAnnotation *)annotation;
		self.pinColor = color;
	}
	
	return self;
}
@end
