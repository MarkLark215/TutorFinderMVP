//
//  Tutor.h
//  CbaMentorAssignment
//
//  Created by Mark Varney on 18/5/17.
//  Copyright © 2017 Mark Varney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Tutor:NSObject

@property (nonatomic, copy) NSString *tutorId;
@property (nonatomic, copy) NSString *fName;
@property (nonatomic, copy) NSString *lName;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *qualifications;
@property (nonatomic, copy) NSString *bio;
@property (nonatomic, copy) NSString *pictureFile;

//string because leading zeros get annihilated if the number is stored as an int, not so great for phone nunbers
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;

-(instancetype) initWithParams:(NSDictionary *) params;

@end
