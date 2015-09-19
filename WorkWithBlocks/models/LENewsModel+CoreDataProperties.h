//
//  LENewsModel+CoreDataProperties.h
//  WorkWithBlocks
//
//  Created by Jack Lapin on 12.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "LENewsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LENewsModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *category;
@property (nullable, nonatomic, retain) NSURL *link;
@property (nullable, nonatomic, retain) NSDate *creationDate;
@property (nullable, nonatomic, retain) NSString *descriptionText;

@end

NS_ASSUME_NONNULL_END
