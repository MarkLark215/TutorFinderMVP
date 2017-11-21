//
//  Service.m
//  CbaMentorAssignment
//
//  Created by Mark Varney on 25/5/17.
//  Copyright © 2017 Mark Varney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Service.h"

@implementation Service

+ (void)asynchronousGetFromFile: (NSString *) endpoint complete: (void(^)(BOOL success,  NSDictionary *result)) completionHandler
{
    
    if (!endpoint)
    {
        completionHandler (NO, nil);
    }
    
    else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{NSDictionary *result = [Service synchronousGetFromFile:endpoint];
            BOOL success;
            
            if (result)
            {
                success = YES;
            }
            else
            {
                success = NO;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(success, result);              // call completion handler
            });
        });
    }
}

+(NSDictionary *)synchronousGetFromFile: (NSString * )endpoint
{
    //simulate slow internet connection
    [NSThread sleepForTimeInterval:3];
    NSData *jsonData = [NSData dataWithContentsOfFile: endpoint];
    NSError *error = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    return dict;
}

@end
