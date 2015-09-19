//
//  LECoreDataManager.m
//  WorkWithBlocks
//
//  Created by Jack Lapin on 19.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LECoreDataManager.h"

@interface LECoreDataManager()

@property (nonatomic, strong) NSManagedObjectContext *defaultContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation LECoreDataManager

+ (LECoreDataManager *)sharedManager {
    static LECoreDataManager * sharedManagerObject ;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        if (!sharedManagerObject) {
            sharedManagerObject = [LECoreDataManager new];
        }
    });
    
    return sharedManagerObject;
}


+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [LECoreDataManager sharedManager];
}

-(id)copy {
    return [LECoreDataManager sharedManager];
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - getters

- (NSManagedObjectContext* ) defaultContext {
    if (!_defaultContext) {
        _defaultContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    }
    return _defaultContext;
}

- (NSPersistentStoreCoordinator*) persistentStoreCoordinator {
    if (!_persistentStoreCoordinator) {
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"rssNews.sqlite"];
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:nil];
#warning TODO handle error
    }
    return _persistentStoreCoordinator;
}
-(NSManagedObjectModel*) managedObjectModel {
    NSURL * pathForXCModel = [[NSBundle mainBundle] URLForResource:@"rssNews" withExtension:@"momd"];
    if (!_managedObjectModel) {
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:pathForXCModel];
    }
    return _managedObjectModel;
}

- (LENewsModel*) newObjectWithTitle : (NSString*) title
                       category:(NSString*) category
                           link:(NSURL*) link
                   creationDate:( NSDate * ) creationDate
                descriptionText:(NSString*) descriptionText{
    
    
    NSString * dataName = NSStringFromClass([LENewsModel class]);
    NSEntityDescription *entity = [NSEntityDescription entityForName:dataName inManagedObjectContext:self.defaultContext];
    
    LENewsModel * model = [[LENewsModel alloc] initWithEntity:entity insertIntoManagedObjectContext:self.defaultContext];
    
    model.title = title;
    model.category = category;
    model.link = link;
    model.creationDate = creationDate;
    model.descriptionText = descriptionText;
    return model;
    
}

-(NSArray*)saveModelsArray:(NSArray *)arrayOfModels {
    NSMutableArray * result = [NSMutableArray arrayWithCapacity:arrayOfModels.count];
    for (LENewsModel *model in arrayOfModels) {
        LENewsModel *newModel = [self newObjectWithTitle:model.title category:model.category
                                                    link:model.link creationDate:model.creationDate
                                         descriptionText:model.descriptionText];
        [result addObject:newModel];
    }
#warning  TODO handle error
    [self.defaultContext save:NULL];
    return result;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.defaultContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
