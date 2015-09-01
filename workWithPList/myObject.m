//
//  myObject.m
//  workWithPList
//
//  Created by Jack Lapin on 29.08.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "myObject.h"

@implementation myObject

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.stu = [decoder decodeObjectForKey:@"stu"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.stu forKey:@"stu"];
}


@end
