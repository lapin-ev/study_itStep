//
//  LENewsModel.h
//  WorkWithBlocks
//
//  Created by Jack Lapin on 12.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

static NSString* kTitleKey = @"title";
static NSString* kLinkKey = @"link";
static NSString* kDescriptionTextKey = @"description";
static NSString* kCategoryKey = @"category";
static NSString* kCreationDateKey = @"pubDate";

@interface LENewsModel : NSManagedObject

+(LENewsModel*) modelFromDictionary : (NSDictionary*) dictionary;

@end

NS_ASSUME_NONNULL_END

#import "LENewsModel+CoreDataProperties.h"
