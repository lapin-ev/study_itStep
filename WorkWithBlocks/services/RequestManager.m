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

@implementation RequestManager

+(void)loadAndSaveModelWithURL:(NSURL *)url complition:(RequestComplitionBlock)complitionBlock {
    
    LEXMLParcer * parcer;
    parcer = [LEXMLParcer parceWithUrl:url];
    
    [parcer parceNewItemsWithComplition:
     ^(NSArray* itemsArray) {
         
         NSMutableArray * tmpNewsArray = [NSMutableArray array];
         for (NSDictionary * dict in itemsArray) {
             LENewsModel * newsModel = [LENewsModel modelFromDictionary:dict];
             [tmpNewsArray addObject:newsModel];
         }
     }];
}

@end
