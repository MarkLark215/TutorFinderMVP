//
//  TutorTableCell.m
//  CbaMentorAssignment
//
//  Created by Mark Varney on 23/5/17.
//  Copyright © 2017 Mark Varney. All rights reserved.
//

#import "TutorTableCell.h"

@implementation TutorTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.addressLabel.textColor = [UIColor grayColor];
}

@end
