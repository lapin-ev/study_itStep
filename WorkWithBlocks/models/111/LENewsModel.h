//
//  LENewsModel.h
//  WorkWithBlocks
//
//  Created by Jack Lapin on 12.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString* kTitleKey = @"title";
static NSString* kLinkKey = @"link";
static NSString* kDescriptionTextKey = @"description";
static NSString* kCategoryKey = @"category";
static NSString* kCreationDateKey = @"pubDate";

@interface LENewsModel : NSObject

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSURL * link;
@property (nonatomic, strong) NSString * descriptionText;
@property (nonatomic, strong) NSString * category;
@property (nonatomic, strong) NSDate * creationDate;

+(LENewsModel*) modelFromDictionary : (NSDictionary*) dictionary;

@end
