//
//  WorkoutRecord+CoreDataProperties.m
//  liftSmart
//
//  Created by Joshua O'Connor on 2/25/16.
//  Copyright © 2016 Joshua O'Connor. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "WorkoutRecord+CoreDataProperties.h"



@implementation WorkoutRecord (CoreDataProperties)

@dynamic title;
@dynamic date;
@dynamic imageData;
@dynamic mood;
@dynamic sets;
@dynamic reps;
@dynamic weight;

- (NSString *)sectionName {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM yyyy"];
    
    return [dateFormatter stringFromDate:date];
}

@end
