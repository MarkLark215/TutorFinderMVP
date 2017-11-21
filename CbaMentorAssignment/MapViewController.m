//
//  MapViewController.m
//  CbaMentorAssignment
//
//  Created by Mark Varney on 23/5/17.
//  Copyright © 2017 Mark Varney. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "TutorPin.h"
#import "Manager.h"
#import "TutorDetailViewController.h"
#import "Tutor.h"

// Sydney
static const CGFloat sydLatitude = -33.8688;
static const CGFloat sydLongitude = 151.2099;

// Span
static const CGFloat spanValue =  0.3f;

@interface MapViewController ()

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSArray * tutors;
@property (nonatomic, strong) UIActivityIndicatorView * gettingTutorsSpinner;
@property (nonatomic, strong) Tutor *selectedTutor;
@property (nonatomic, strong) TutorPin *tutorPin;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = (id)self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.mapView.delegate self];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [self.locationManager requestWhenInUseAuthorization];
    
    if (([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied))
    {
        MKCoordinateRegion region;
        region.center.latitude = sydLatitude;
        region.center.longitude = sydLongitude;
        region.span.latitudeDelta = spanValue;
        region.span.longitudeDelta = spanValue;
        [self.mapView setRegion:region animated:YES];
    }
    
    else
    {
        [self.locationManager startUpdatingLocation];
        [self.mapView setShowsUserLocation:YES];
        [self loadMap];
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sorry"
                                                                   message:@"There are no tutors within that distance for that subject" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              [self.navigationController popViewControllerAnimated:YES];
                                                          }];
    [alert addAction:defaultAction];
    
    self.gettingTutorsSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.gettingTutorsSpinner.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    self.gettingTutorsSpinner.hidesWhenStopped = YES;
    [self.view addSubview:self.gettingTutorsSpinner];
    [self.gettingTutorsSpinner startAnimating];
    
    [Manager getTutors: self.subject radius: self.radius complete:^(BOOL success, NSArray * tutors)
     {
         if (success)
         {
             self.tutors = tutors;
             
             if (tutors == nil || tutors.count == 0)
             {
                 [self.gettingTutorsSpinner stopAnimating];
                 [self presentViewController:alert animated:YES completion:nil];
             }
             
             else
             {
                 [self.gettingTutorsSpinner stopAnimating];
                 
                 for (Tutor *tutor in self.tutors)
                 {
                     CLLocationCoordinate2D tempPoint = CLLocationCoordinate2DMake(tutor.latitude, tutor.longitude);
                     TutorPin *pin = [[TutorPin alloc] initWithLocation: tempPoint];
                     pin.pinsTutor = tutor;
                     pin.title = [NSString stringWithFormat:@"%@ %@", tutor.fName, tutor.lName];
                     pin.subtitle = tutor.subject;
                     [self.mapView addAnnotation: pin];
                     
                 }
             }
         }
         
         if (!success)
         {
             [self.gettingTutorsSpinner stopAnimating];
             [self presentViewController:alert animated:YES completion:nil];
         }
     }];
    
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    self.tutorPin  = (TutorPin*) view.annotation;
    self.selectedTutor = self.tutorPin.pinsTutor;
    [self performSegueWithIdentifier:@"showTutorDetails" sender:view];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    MKAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"loc"];
    annotationView.canShowCallout = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return annotationView;
}

-(void) loadMap
{
    CLLocation *clocation = [self.locationManager location];
    CLLocationCoordinate2D loc = [clocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 10000,  10000);
    [self.mapView setRegion:region animated: YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    TutorDetailViewController * destView = [segue destinationViewController];
    destView.tutor = self.selectedTutor;
    
}

@end
