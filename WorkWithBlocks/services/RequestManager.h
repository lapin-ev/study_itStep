//
//  RequestManager.h
//  WorkWithBlocks
//
//  Created by Jack Lapin on 19.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//


#import <Foundation/Foundation.h>

typedef void (^RequestComplitionBlock) (id result, NSError * error) ;


@interface RequestManager : NSObject

+(void) loadAndSaveModelWithURL : (NSURL*) url complition:(RequestComplitionBlock) complitionBlock;

@end
