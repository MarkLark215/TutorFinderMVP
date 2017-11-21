//
//  CustomButton.m
//  CbaMentorAssignment
//
//  Created by Mark Varney on 7/6/17.
//  Copyright © 2017 Mark Varney. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    UIBezierPath *border = [UIBezierPath bezierPathWithRect:rect];
    [[UIColor colorWithRed: 23.0/255.0 green: 94.0/255.0 blue : 164.0/ 255.0 alpha: 1]setStroke];
    border.lineWidth = 1;
    [border stroke];
}

@end
