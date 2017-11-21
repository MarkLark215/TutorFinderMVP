//
//  TutorPin.m
//  CbaMentorAssignment
//
//  Created by Mark Varney on 23/5/17.
//  Copyright © 2017 Mark Varney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TutorPin.h"
#import "MapKit/MapKit.h"

@implementation TutorPin

@synthesize coordinate; 

- (id)initWithLocation:(CLLocationCoordinate2D)coord {
    self = [super init];
    if (self) {
        coordinate = coord;
    }
    return self;
    
}

@end
