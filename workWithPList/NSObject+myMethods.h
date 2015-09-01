//
//  NSObject+myMethods.h
//  workWithPList
//
//  Created by Jack Lapin on 29.08.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (myMethods)

-(void) setObjectWithDictionary : (NSDictionary*) dictionary;

@end
