//
//  TutorListingViewController.m
//  CbaMentorAssignment
//
//  Created by Mark Varney on 18/5/17.
//  Copyright © 2017 Mark Varney. All rights reserved.
//

#import "TutorListingViewController.h"
#import "Tutor.h"
#import "TutorDetailViewController.h"
#import "TutorTableCell.h"
#import "Manager.h"

@interface TutorListingViewController ()

@property (nonatomic, strong) NSArray *tutors;
@property (nonatomic, strong) UIActivityIndicatorView * gettingTutorsSpinner;
@property (nonatomic, weak) IBOutlet UITableView *myTableView;

@end

@implementation TutorListingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.gettingTutorsSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.gettingTutorsSpinner.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    self.gettingTutorsSpinner.hidesWhenStopped = YES;
    [self.view addSubview:self.gettingTutorsSpinner];
    [self.gettingTutorsSpinner startAnimating];
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Sorry"
                                                                   message:@"There are no tutors within that distance for that subject" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              [self.navigationController popViewControllerAnimated:YES];
                                                          }];
    
    [alert addAction:defaultAction];
    [Manager getTutors: self.subject radius: self.radius complete:^(BOOL success, NSArray * tutors)
     {
         if (success) {
             self.tutors = tutors;
             
             if (tutors == nil || tutors.count == 0)
             {
                 [self.gettingTutorsSpinner stopAnimating];
                 [self presentViewController:alert animated:YES completion:nil];
             }
             
             else
             {
                 [self.gettingTutorsSpinner stopAnimating]; 
                 [self.myTableView reloadData];
             }

         }
         
         if (!success)
         {
             [self.gettingTutorsSpinner stopAnimating];
             [self presentViewController:alert animated:YES completion:nil];
         }
     }];
    
    self.myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tutors.count;
}

-(UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    TutorTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[TutorTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Tutor *tutor = self.tutors[indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat: @"%@ %@", tutor.fName, tutor.lName];
    cell.addressLabel.text = tutor.address;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showDetail" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)showDetail sender:(id)sender {
    TutorDetailViewController *destView = [showDetail destinationViewController];
    NSIndexPath *path = [self.myTableView indexPathForSelectedRow];
    destView.tutor = self.tutors[path.row];

}

@end
