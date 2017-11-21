//
//  ServiceAccess.m
//  CbaMentorAssignment
//
//  Created by Mark Varney on 25/5/17.
//  Copyright © 2017 Mark Varney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Manager.h"
#import "Tutor.h"
#import "Service.h"

@implementation Manager

+(void) getTutors: (NSString *) subject radius:(NSString*) radius complete: (void (^) (BOOL success, NSArray * tutors)) completionHandler
{
    
    NSString *path = [NSString stringWithFormat:@"Tutors-%@-%@", radius, subject];
    
    NSString *filename = [[NSBundle mainBundle] pathForResource:path ofType:@"json"];
    
    if (filename != NULL)
    {
        [Service asynchronousGetFromFile: filename complete: ^(BOOL success, NSDictionary *jsonDictionary)
         {
             
             if (success)
             {
                 NSMutableArray *tutors = [NSMutableArray array];
                 for (id key in jsonDictionary)
                 {
                     for (NSDictionary *tempDict in [jsonDictionary objectForKey:key])
                     {
                         Tutor *tempTutor = [[Tutor alloc] initWithParams:tempDict];
                         [tutors addObject:tempTutor];
                     }
                 }
                 completionHandler(YES, tutors);
             }
             else
             {
                 completionHandler(NO, nil);
             }
         }];
    }
    
    else
    {
        completionHandler(NO, nil);
    }
    
}

@end
