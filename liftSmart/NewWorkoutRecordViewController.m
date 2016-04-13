//
//  ViewController.m
//  liftSmart
//
//  Created by Joshua O'Connor on 2/25/16.
//  Copyright © 2016 Joshua O'Connor. All rights reserved.
//

#import "NewWorkoutRecordViewController.h"
#import "WorkoutRecord.h"
#import "CoreDataStack.h"

@interface NewWorkoutRecordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *workoutTitleTextfield;

@end


//HANDLES NEW AND EXISTING(EDITING) RECORDS
@implementation NewWorkoutRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.entry != nil) {
        self.workoutTitleTextfield.text = self.entry.title;
    }
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissWorkOut {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)insertWorkoutRecord{
    CoreDataStack *coreDataStackInstance = [CoreDataStack defaultStack];
    WorkoutRecord *entry = [NSEntityDescription insertNewObjectForEntityForName:@"WorkoutRecord" inManagedObjectContext:coreDataStackInstance.managedObjectContext];
    entry.title = self.workoutTitleTextfield.text;
    entry.date = [[NSDate date] timeIntervalSince1970];
    [coreDataStackInstance saveContext];
    
}


- (IBAction)pressedDone:(id)sender {
    if (self.entry != nil) {
        [self updateWorkoutEntry];
    }
    else{
        [self insertWorkoutRecord];
    }

    [self dismissWorkOut];
}


- (IBAction)pressedCancel:(id)sender {
    [self dismissWorkOut];
}

-(void)updateWorkoutEntry{
    self.entry.title = self.workoutTitleTextfield.text;
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    [coreDataStack saveContext];
}

@end
