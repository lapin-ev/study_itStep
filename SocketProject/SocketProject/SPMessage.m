//
//  SPMessage.m
//  SocketProject
//
//  Created by Genrih Korenujenko on 06.10.15.
//  Copyright (c) 2015 Genrih Korenujenko. All rights reserved.
//

#import "SPMessage.h"

#import <objc/runtime.h>

@implementation SPMessage

- (void)messageWithDictionary:(NSDictionary *)dictionary {
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    NSMutableDictionary *rv = [NSMutableDictionary new];
    
    unsigned i;
    for (i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        [rv setValue:@"1" forKey:name];
    }
    free(properties);
    
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([rv valueForKey:key]) {
            [self setValue:obj forKey:key];
        }
    }];
}

- (NSString *)description {
    NSMutableDictionary *propertyValues = [NSMutableDictionary dictionary];
    
    unsigned int propertyCount;
    
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    
    for (unsigned int i = 0; i < propertyCount; i++) {
        char const *propertyName = property_getName(properties[i]);
        const char *attr = property_getAttributes(properties[i]);
        
        if (attr[1] == '@') {
            NSString *selector = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
            id propertyValue = [self valueForKey:selector];
            propertyValues[selector] = [propertyValue description];
        }
    }
    free(properties);
    return [NSString stringWithFormat:@"%@:\n%@", self.class, propertyValues];
}


@end
