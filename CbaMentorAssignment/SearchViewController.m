//
//  SearchViewController.m
//  CbaMentorAssignment
//
//  Created by Mark Varney on 17/5/17.
//  Copyright © 2017 Mark Varney. All rights reserved.
//

#import "SearchViewController.h"
#import "Manager.h"
#import "TutorListingViewController.h"
#import "MapViewController.h"

@interface SearchViewController ()

@property (nonatomic, copy) NSString *radiusString;
@property (nonatomic, copy) NSString *subjectString;

@property (nonatomic, weak) IBOutlet UIPickerView *subjectAndDistancePicker;
@property (nonatomic, strong) NSArray *radius;
@property (nonatomic, strong) NSArray *subjectArea;

@end

@implementation SearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.radius = @[@"1km", @"5km", @"10km", @"25km", @"100km"];
    self.subjectArea = @[@"Maths", @"Biology", @"Piano", @"Singing", @"Physics"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"segueToTutorList"])
    {
    TutorListingViewController *destView = [segue destinationViewController];
        destView.subject = self.subjectString;
        destView.radius = self.radiusString;
    }
    
    if ([segue.identifier isEqualToString: @"segueToMap"])
    {
        MapViewController *destView = [segue destinationViewController];
        destView.subject = self.subjectString;
        destView.radius = self.radiusString;
    }
    
}

- (IBAction)onPickerButtonPressed:(id)sender
{
    NSInteger subjectAreaIndex = [self.subjectAndDistancePicker selectedRowInComponent:0];
    NSInteger radiusIndex = [self.subjectAndDistancePicker selectedRowInComponent:1];
    self.subjectString = self.subjectArea[subjectAreaIndex];
    self.radiusString = self.radius[radiusIndex];
}

- (IBAction)onShowMapButtonPressed:(id)sender
{
    NSInteger subjectAreaIndex = [self.subjectAndDistancePicker selectedRowInComponent:0];
    NSInteger radiusIndex = [self.subjectAndDistancePicker selectedRowInComponent:1];
    self.subjectString = self.subjectArea[subjectAreaIndex];
    self.radiusString = self.radius[radiusIndex];
}

-(NSInteger) numberOfComponentsInPickerView: (UIPickerView *) pickerView
{
    return 2;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return (component == 0) ? self.subjectArea.count : self.radius.count;
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return  (component == 0) ? self.subjectArea[row] : self.radius[row];
}

@end

