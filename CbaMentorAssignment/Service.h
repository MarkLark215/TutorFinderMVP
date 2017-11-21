//
//  Service.h
//  CbaMentorAssignment
//
//  Created by Mark Varney on 25/5/17.
//  Copyright © 2017 Mark Varney. All rights reserved.
//

@interface Service : NSObject

+ (void)asynchronousGetFromFile: (NSString *) endpoint complete: (void(^)(BOOL success,  NSDictionary *jsonResult)) completionHandler;
@end
