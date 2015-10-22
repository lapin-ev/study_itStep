//
//  MClass.m
//  GetAllProperty
//
//  Created by Genrih Korenujenko on 03.08.15.
//  Copyright (c) 2015 Genrih Korenujenko. All rights reserved.
//

#import "MClass.h"

@implementation MClass

//- (NSArray *)allPropertyNames {
//    unsigned count = 0;
//    objc_property_t *properties = class_copyPropertyList([self class], &count);
//    
//    NSMutableArray *rv = [NSMutableArray array];
//    
//    for (int i = 0; i < count; i++)
//    {
//        objc_property_t property = properties[i];
//        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
//        [rv addObject:name];
//        
//        NSString *propertyAttributes = [NSString stringWithUTF8String:property_getAttributes(property)];
//        NSArray *splitPropertyAttributes = [propertyAttributes componentsSeparatedByString:@"\""];
//        if ([splitPropertyAttributes count] >= 2)
//        {
//            NSLog(@"%@", [splitPropertyAttributes objectAtIndex:1]);
//        }
//        
//    }
//    
//    free(properties);
//    
//    self.string1 = @"1";
//    self.string2 = @"2";
//    
////    [self propertiesPlease];
//    
//    return rv;
//}

//- (NSDictionary *)propertiesPlease {
//    NSMutableDictionary *props = [NSMutableDictionary dictionary];
//    unsigned int outCount, i;
//    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
//    for (i = 0; i < outCount; i++) {
//        objc_property_t property = properties[i];
//        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
//        id propertyValue = [self valueForKey:(NSString *)propertyName];
//        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
//        
//        [self setValue:@"5" forKeyPath:propertyName];
//    }
//    free(properties);
//    return props;
//}


//- (void)setObjectsWithDicationary:(NSDictionary *)dictionary {
//    unsigned int outCount;
//    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
//    
//    for (int i = 0; i < outCount; i++) {
//        objc_property_t property = properties[i];
//        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
//        NSString *propertyAttributes = [NSString stringWithUTF8String:property_getAttributes(property)];
//        NSArray *splitPropertyAttributes = [propertyAttributes componentsSeparatedByString:@"\""];
//        if ([splitPropertyAttributes count] >= 2) {
//            NSLog(@"%@", [splitPropertyAttributes objectAtIndex:1]);
//            [self setValue:[dictionary objectForKey:propertyName] forKeyPath:propertyName];
//        }
//    }
//    free(properties);
//}

//- (NSString *)description {
//    NSMutableDictionary *propertyValues = [NSMutableDictionary dictionary];
//    unsigned int propertyCount;
//    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
//    for (unsigned int i = 0; i < propertyCount; i++) {
//        char const *propertyName = property_getName(properties[i]);
//        const char *attr = property_getAttributes(properties[i]);
//        if (attr[1] == '@') {
//            NSString *selector = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
//            SEL sel = sel_registerName([selector UTF8String]);
//            NSObject * propertyValue = objc_msgSend(self, sel);
//            if (propertyValue.description) {
//                propertyValues[selector] = propertyValue.description;                
//            }
//        }
//    }
//    free(properties);
//    return [NSString stringWithFormat:@"%@: %@", self.class, propertyValues];
//}



@end
