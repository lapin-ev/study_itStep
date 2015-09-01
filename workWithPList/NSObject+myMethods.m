//
//  NSObject+myMethods.m
//  workWithPList
//
//  Created by Jack Lapin on 29.08.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "NSObject+myMethods.h"

@implementation NSObject (myMethods)

- (void) setObjectWithDictionary : (NSDictionary*) dictionary

{
    unsigned int pCount;
    objc_property_t * properties = class_copyPropertyList([self class], &pCount);
    for (int i = 0; i < pCount; i++) {
        objc_property_t property = properties[i];
        NSString * propertyName = [NSString stringWithUTF8String:property_getName(property)];
        NSString * propertyAttribute = [NSString stringWithUTF8String:property_getAttributes(property)];
        NSArray * splitProperyAttr = [propertyAttribute componentsSeparatedByString:@"\""];
        
        if (splitProperyAttr.count >=2) {
            NSLog(@"%@",splitProperyAttr);
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
            //            SEL sel = sel_registerName([selector UTF8String]);
            
            //            NSObject * propertyValue = objc_msgSend(self, sel);
            id value = [self valueForKey:[NSString stringWithFormat: @"%s",propertyName]];
            if (value) {
                propertyValues[selector] = value;
            }
            
            else {
                propertyValues[selector] = @"nil";
            }
            //            id propertyValue = [self performSelector:sel withObject:selector];
            //
            //            propertyValues[selector] =[propertyValue description];
        }
    }
    free(properties);
    return [NSString stringWithFormat:@"%@: %@", self.class, propertyValues];
}


@end
