//
//  Users+CoreDataProperties.h
//  WorkWithCoreData
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Users.h"

NS_ASSUME_NONNULL_BEGIN

@interface Users (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSDate *dtOfBirth;
@property (nullable, nonatomic, retain) NSNumber *gender;

@end

NS_ASSUME_NONNULL_END
