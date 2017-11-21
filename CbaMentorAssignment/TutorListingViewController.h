//
//  TutorListingViewController.h
//  CbaMentorAssignment
//
//  Created by Mark Varney on 18/5/17.
//  Copyright © 2017 Mark Varney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorListingViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *radius;

@end
