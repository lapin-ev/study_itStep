//
//  LEXMLParcer.h
//  WorkWithBlocks
//
//  Created by Jack Lapin on 12.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ComplitionBlock) (NSArray * itemsArray) ;

@interface LEXMLParcer : NSObject <NSXMLParserDelegate>

@property (nonatomic, readonly) NSURL * url;

-(void) parceNewItemsWithComplition :(ComplitionBlock)block;

+ (LEXMLParcer * ) parceWithUrl : (NSURL*) url;

@end
