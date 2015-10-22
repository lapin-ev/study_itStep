//
//  NSObject+SetAllProperty.m
//  GetAllProperty
//
//  Created by Genrih Korenujenko on 20.08.15.
//  Copyright (c) 2015 Genrih Korenujenko. All rights reserved.
//

#import "NSObject+SetAllProperty.h"
//#import <objc/message.h>
#import <objc/runtime.h>

@implementation NSObject (SetAllProperty)

- (void)setObjectsWithDicationary:(NSDictionary *)dictionary {
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        NSString *propertyAttributes = [NSString stringWithUTF8String:property_getAttributes(property)];
        NSArray *splitPropertyAttributes = [propertyAttributes componentsSeparatedByString:@"\""];
        if ([splitPropertyAttributes count] >= 2) {
            NSLog(@"%@", [splitPropertyAttributes objectAtIndex:1]);
            [self setValue:[dictionary objectForKey:propertyName] forKeyPath:propertyName];
        }
    }
    free(properties);
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
            SEL sel = sel_registerName([selector UTF8String]);
            
             NSObject * propertyValue = objc_msgSend(self, sel);
            
            if (propertyValue.description) {
                propertyValues[selector] = propertyValue.description;
            }
        }
    }
    free(properties);
    return [NSString stringWithFormat:@"\n%@:\n%@", self.class, propertyValues];
}

@end
