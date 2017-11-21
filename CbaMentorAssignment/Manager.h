//
//  ServiceAccess.h
//  CbaMentorAssignment
//
//  Created by Mark Varney on 25/5/17.
//  Copyright © 2017 Mark Varney. All rights reserved.
//

@interface Manager : NSObject

+(void) getTutors: (NSString *) subject radius:(NSString*) radius complete: (void (^) (BOOL success, NSArray *tutors)) completionHandler;

@end
