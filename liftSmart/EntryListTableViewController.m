//
//  EntryListTableViewController.m
//  liftSmart
//
//  Created by Joshua O'Connor on 2/26/16.
//  Copyright © 2016 Joshua O'Connor. All rights reserved.
//

#import "EntryListTableViewController.h"
#import "CoreDataStack.h"
#import "WorkoutRecord.h"
#import "NewWorkoutRecordViewController.h"

//THIS CLASS HANDLES OUT NSFETCHEDRESULTSCONTROLLER

@interface EntryListTableViewController() <NSFetchedResultsControllerDelegate>

//Private methods & properties defined in @interface
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation EntryListTableViewController {
    
    //private instance variables
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.fetchedResultsController performFetch:nil];
}

//Called when segue is performed
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"edit"]){
        //Grab cell, its indexpath, then configure entryListTableViewController
        UITableViewCell *cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        UINavigationController *navigationController = segue.destinationViewController;
        NewWorkoutRecordViewController *entryListTableViewController = (NewWorkoutRecordViewController *) navigationController.topViewController;
        entryListTableViewController.entry = [self.fetchedResultsController objectAtIndexPath:indexPath];
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.fetchedResultsController.sections.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //retrieve the section information from the fetchedResultsController
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    //then we retrieve the number of objects in that section
    return [sectionInfo numberOfObjects];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //Create an instance of NSManaged object-> set it to NSFetchedResultsController indexpath.
    WorkoutRecord *entry = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //Display Data.
    cell.textLabel.text = entry.title;
    
    
    
    return cell;

}


//DELETE (this and following method required)
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

//Another method (commitEditingStyle required to implement delete functionality
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WorkoutRecord *entry = [self.fetchedResultsController objectAtIndexPath:indexPath];
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    [[coreDataStack managedObjectContext] deleteObject:entry];
    [coreDataStack saveContext];
    
}
    
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo name];
}

//Return an instance of an NS fetch request.  We need this to view our data from coreData.  Name the method whatever you want.
- (NSFetchRequest *)workoutEntryFetchRequest{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"WorkoutRecord"];
    
    //Tell NSFetchRequest what specific data you need.
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]];
    
    return fetchRequest;
}

//overrides the property getter.  Only used with UITableViews
- (NSFetchedResultsController *)fetchedResultsController{
    if (_fetchedResultsController != nil){
        return _fetchedResultsController;
    }
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    NSFetchRequest *fetchRequest = [self workoutEntryFetchRequest];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:coreDataStack.managedObjectContext sectionNameKeyPath:@"sectionName" cacheName:nil];
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}


-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView beginUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    
    if (type == NSFetchedResultsChangeInsert){
        [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else if (type == NSFetchedResultsChangeDelete){
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else if (type == NSFetchedResultsChangeUpdate){
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }

}

//When we delete the last row or insert first row, it creates a new section.  This prevents crashing when first row is inserted or deleted.
-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type{
    if (type == NSFetchedResultsChangeInsert){
        [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else if (type == NSFetchedResultsChangeDelete){
        [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

//When things change we can handle animations here
-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}


@end