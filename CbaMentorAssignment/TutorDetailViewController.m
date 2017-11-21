//
//  TutorDetailViewController.m
//  CbaMentorAssignment
//
//  Created by Mark Varney on 19/5/17.
//  Copyright © 2017 Mark Varney. All rights reserved.
//

#import "TutorDetailViewController.h"
#import "Tutor.h"
#import "CustomButton.h"
#import <QuartzCore/QuartzCore.h>

@interface TutorDetailViewController ()
@property (weak, nonatomic) IBOutlet UIButton *callButton;

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *subjectLabel;
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;
@property (nonatomic, weak) IBOutlet UILabel *qualificationsLabel;
@property (nonatomic, weak) IBOutlet UILabel *bioLabel;
@property (nonatomic, weak) IBOutlet UIImageView *tutorImageView;

@end

@implementation TutorDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", self.tutor.fName, self.tutor.lName];
    self.subjectLabel.text = self.tutor.subject;
    self.addressLabel.text = self.tutor.address;
    self.callButton.layer.borderWidth = 1;
    self.qualificationsLabel.text = self.tutor.qualifications;
    self.bioLabel.text = self.tutor.bio;
    self.tutorImageView.image = [UIImage imageNamed: self.tutor.pictureFile];
    self.callButton.layer.borderColor = [UIColor colorWithRed: 0.0/255.0 green: 100.0/255.0 blue : 0/ 255.0 alpha: 1].CGColor;

}

- (IBAction)callButtonPressed:(id)sender {
    NSString *phoneNumber = [@"tel://" stringByAppendingString: self.tutor.phone];
    NSURL *phoneURL = [NSURL URLWithString:phoneNumber];
    NSDictionary *options = [[NSDictionary alloc] init];
    [[UIApplication sharedApplication] openURL:phoneURL options: options completionHandler:nil];
}

@end
