//
//  LECoreDataManager.h
//  WorkWithBlocks
//
//  Created by Jack Lapin on 19.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LENewsModel.h"

@interface LECoreDataManager : NSObject

+(LECoreDataManager*) sharedManager;
- (LENewsModel*) newObjectWithTitle : (NSString*) title
                       category:(NSString*) category
                           link:(NSURL*) link
                   creationDate:( NSDate * ) creationDate
                descriptionText:(NSString*) descriptionText;

-(NSArray *) saveModelsArray : (NSArray*) arrayOfModels;

@end
