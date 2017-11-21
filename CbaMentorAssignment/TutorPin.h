//
//  TutorPin.h
//  CbaMentorAssignment
//
//  Created by Mark Varney on 23/5/17.
//  Copyright © 2017 Mark Varney. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "Tutor.h"

@interface TutorPin : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subtitle;
@property (nonatomic, strong) Tutor *pinsTutor;

-(id)initWithLocation: (CLLocationCoordinate2D) coord;

@end
