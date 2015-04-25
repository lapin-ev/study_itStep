//
//  SaveMyData.h
//  Students
//
//  Created by Jack Lapin on 19.03.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveMyData : NSObject

+ (void) saveMyArray : (NSMutableArray *) withArr forKey:(NSString*)key;
+ (NSMutableArray *) loadMyArray :(NSString*)key;

@end
