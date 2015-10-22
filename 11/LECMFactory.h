//
//  LECMFactory.h
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>




NS_ASSUME_NONNULL_BEGIN

static NSString* kNameKey = @"name";
static NSString* kImageNameKey = @"imageName";

@interface LECMFactory : NSManagedObject

+(LECMFactory*) modelFromDictionary : (NSDictionary*) dictionary;

@end


NS_ASSUME_NONNULL_END


#import "LECMFactory+CoreDataProperties.h"