//
//  WorkoutRecord+CoreDataProperties.h
//  liftSmart
//
//  Created by Joshua O'Connor on 2/25/16.
//  Copyright © 2016 Joshua O'Connor. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "WorkoutRecord.h"


NS_ASSUME_NONNULL_BEGIN


@interface WorkoutRecord (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nonatomic) NSTimeInterval date;
@property (nullable, nonatomic, retain) NSData *imageData;
@property (nonatomic) int16_t mood;
@property (nonatomic) int16_t sets;
@property (nonatomic) int16_t reps;
@property (nonatomic) int16_t weight;
@property (nonatomic, readonly) NSString *sectionName;


@end

NS_ASSUME_NONNULL_END
