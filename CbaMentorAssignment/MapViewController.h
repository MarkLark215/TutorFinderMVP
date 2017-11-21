//
//  MapViewController.h
//  CbaMentorAssignment
//
//  Created by Mark Varney on 23/5/17.
//  Copyright © 2017 Mark Varney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController: UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *radius;

@end
