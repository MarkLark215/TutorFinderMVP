//
//  Tutor.m
//  CbaMentorAssignment
//
//  Created by Mark Varney on 18/5/17.
//  Copyright © 2017 Mark Varney. All rights reserved.
//


#import "Tutor.h"
#import <Foundation/Foundation.h>

@implementation Tutor

- (instancetype)initWithParams:(NSDictionary *)params
{
    self = [super init];
    if (self)
    {
        _tutorId = params[@"id"];
        _fName = params[@"fName"];
        _lName = params[@"lName"];
        _address = params[@"address"];
        _subject = params[@"subject"];
        _qualifications = params[@"qualifications"];
        _bio = params[@"bio"];
        _pictureFile = params[@"pictureFile"];
        _phone = params[@"phone"];
        _latitude = [params[@"latitude"] floatValue];
        _longitude = [params[@"longitude"] floatValue];
        
    }
    return self;
}

@end
