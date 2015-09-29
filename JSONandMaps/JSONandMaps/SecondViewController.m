//
//  SecondViewController.m
//  JSONandMaps
//
//  Created by Jack Lapin on 26.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "SecondViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface SecondViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) MKPolyline * routePolyline;
@property (nonatomic, strong) CLLocationManager * locationManager;


@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc ] init];
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    
    MKUserTrackingBarButtonItem * userTrackingBarButtonItem = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapView];
    self.toolBar.items = @[userTrackingBarButtonItem];
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.mapView];
    CLLocationCoordinate2D touchCoordinates = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    MKPointAnnotation * point = [[MKPointAnnotation alloc] init];
    point.coordinate = touchCoordinates;
    [self.mapView addAnnotation:point];
    
    MKDirectionsRequest * directionRequest = [[MKDirectionsRequest alloc]init];
    MKPlacemark * sourceMark = [[MKPlacemark alloc] initWithCoordinate:touchCoordinates addressDictionary:nil];
    
    directionRequest.source = [MKMapItem mapItemForCurrentLocation];
    directionRequest.destination = [[MKMapItem alloc] initWithPlacemark:sourceMark];
    directionRequest.transportType = MKDirectionsTransportTypeWalking;
    
    MKDirections * directions = [[MKDirections alloc] initWithRequest:directionRequest];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
        // поличили респонд теперь нужно нарисовать дорожку на карте
        MKRoute * route = [response.routes firstObject];
        self.routePolyline = route.polyline;
        [self.mapView addOverlay:self.routePolyline];
    }];
    
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay {
    MKPolylineRenderer * render = [[MKPolylineRenderer alloc] initWithOverlay:self.routePolyline];
    render.strokeColor = [UIColor greenColor];
    render.lineWidth = 3.0f;
    
    return render;
}

@end
