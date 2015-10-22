//
//  LENewsModel.m
//  WorkWithBlocks
//
//  Created by Jack Lapin on 12.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LENewsModel.h"

@implementation LENewsModel

+(LENewsModel*) modelFromDictionary : (NSDictionary*) dictionary {
    LENewsModel * model = [LENewsModel new];

    model.title = [dictionary objectForKey:kTitleKey];
    NSString* urlString = [dictionary objectForKey:kLinkKey];
    NSCharacterSet* charactersSet = [NSCharacterSet characterSetWithCharactersInString:@"\n "];
    
    model.link = [NSURL URLWithString:[urlString stringByTrimmingCharactersInSet:charactersSet]];
    
    model.descriptionText = [dictionary objectForKey:kDescriptionTextKey];
    model.category = [dictionary objectForKey:kCategoryKey];
    //Wed, 09 Sep 2015 17:54:48 +0400\n
    
    NSDateFormatter* df = [NSDateFormatter new];
    [df setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss ZZZ\n"];
    model.creationDate = [df dateFromString:[dictionary objectForKey:kCreationDateKey]];

    
    return model;
}

-(NSString *)description {
    NSString * strDiscription = [NSString stringWithFormat:@"NewsModelItem: title = %@; link = %@", self.title, self.link];
    return strDiscription;
}

@end
