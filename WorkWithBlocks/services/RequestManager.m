//
//  RequestManager.m
//  WorkWithBlocks
//
//  Created by Jack Lapin on 19.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//



#import "RequestManager.h"
#import "LEXMLParcer.h"
#import "LECoreDataManager.h"
#import "LENewsModel+CoreDataProperties.h"


@implementation RequestManager

+(void)loadAndSaveModelWithURL:(NSURL *)url complition:(RequestComplitionBlock)complitionBlock {
    
    LEXMLParcer * parcer;
    parcer = [LEXMLParcer parceWithUrl:url];
    
    [parcer parceNewItemsWithComplition:
     ^(NSArray* itemsArray) {
         NSMutableArray * tmpArray = [NSMutableArray arrayWithCapacity:itemsArray.count];
         for (NSDictionary * dictionary in itemsArray) {
             
             
             NSString * title = [dictionary objectForKey:kTitleKey];
             NSString* urlString = [dictionary objectForKey:kLinkKey];
             NSCharacterSet* charactersSet = [NSCharacterSet characterSetWithCharactersInString:@"\n "];
             
             NSURL* link = [NSURL URLWithString:[urlString stringByTrimmingCharactersInSet:charactersSet]];
             
             NSString * descriptionText = [dictionary objectForKey:kDescriptionTextKey];
             NSString *  category = [dictionary objectForKey:kCategoryKey];
             
             NSDateFormatter* df = [NSDateFormatter new];
             [df setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss ZZZ\n"];
             //Wed, 09 Sep 2015 17:54:48 +0400\nb
             NSDate * creationDate = [df dateFromString:[dictionary objectForKey:kCreationDateKey]];
             
             LENewsModel * newModel = [[LECoreDataManager sharedManager] newObjectWithTitle:title category:category
                                                                                       link:link creationDate:creationDate
                                                                            descriptionText:descriptionText];
             [tmpArray addObject:newModel];
             
         }
         [[LECoreDataManager sharedManager] saveContext];
#warning TODO handle error
         if (complitionBlock) {
             complitionBlock (tmpArray, nil);
         }
     }];
}

@end
