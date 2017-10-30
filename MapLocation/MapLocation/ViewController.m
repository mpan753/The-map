//
//  ViewController.m
//  MapLocation
//
//  Created by Dennis White on 1/19/15.
//  Copyright (c) 2015 dniswhite. All rights reserved.
//

#import "ViewController.h"
#import "Annotation.h"

#define METERS_MILE 1609.344
#define METERS_FEET 3.28084

@interface ViewController ()
<CLLocationManagerDelegate, MKMapViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[self mapView] setShowsUserLocation:YES];
    
    self.locationManager = [[CLLocationManager alloc] init];
    
//    [[self locationManager] setDelegate:self];
    
    // we have to setup the location maanager with permission in later iOS versions
    if ([[self locationManager] respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [[self locationManager] requestWhenInUseAuthorization];
    }
    
    [[self locationManager] setDesiredAccuracy:kCLLocationAccuracyBest];
    [[self locationManager] startUpdatingLocation];
    
    [self addAnnotations];
//    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
//    [annotation setCoordinate:CLLocationCoordinate2DMake(37, -122)];
//    [annotation setTitle:@"Title"];
//    [self.mapView addAnnotation:annotation];
//    [self.mapView showAnnotations:@[annotation] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = locations.lastObject;
    [[self labelLatitude] setText:[NSString stringWithFormat:@"%.6f", location.coordinate.latitude]];
    [[self labelLongitude] setText:[NSString stringWithFormat:@"%.6f", location.coordinate.longitude]];
    [[self labelAltitude] setText:[NSString stringWithFormat:@"%.2f feet", location.altitude*METERS_FEET]];
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2*METERS_MILE, 2*METERS_MILE);
    [[self mapView] setRegion:viewRegion animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"DETAILPIN_ID"];
//    [pinView setAnimatesDrop:YES];
    [pinView setCanShowCallout:NO];
    return pinView;
}

- (void)addAnnotations {
    NSMutableArray *annotations = @[].mutableCopy;
    for (int i = 0; i < 10; i++) {
        Annotation *a = [Annotation new];
        a.coordinate = CLLocationCoordinate2DMake(0 + i, 0 + i);
        [annotations addObject:a];
    }
    [self.mapView addAnnotations:annotations];
    [self.mapView showAnnotations:annotations animated:YES];
}

@end
