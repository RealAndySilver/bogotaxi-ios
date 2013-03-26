//
//  Map.h
//  CryptoChat
//
//  Created by Nicolle on 20/09/12.
//  Copyright (c) 2012 iAmStudio. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "RegionAnnotation.h"

@class RegionAnnotation;

@interface RegionAnnotationView : MKPinAnnotationView{
   /* MKCircle *radiusOverlay;
	BOOL isRadiusUpdated;*/
}

@property (nonatomic, assign) MKMapView *map;
@property (nonatomic, assign) RegionAnnotation *theAnnotation;

- (id)initWithAnnotation:(id <MKAnnotation>)annotation withcolor:(MKPinAnnotationColor)color;

@end








