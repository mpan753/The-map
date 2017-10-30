//
//  Annotation.h
//  MapLocation
//
//  Created by Mia on 27/10/2017.
//  Copyright © 2017 dniswhite. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@interface Annotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end
