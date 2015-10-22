//
//  TestClass.h
//  GetAllProperty
//
//  Created by Genrih Korenujenko on 20.08.15.
//  Copyright (c) 2015 Genrih Korenujenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestClass : NSObject

- (void)someMethod;
- (void)callSomeMethod;
- (void)methodWithParam:(const char *)param bparam:(NSString *)b;

+ (void)someClassMethod;
- (void)someInstanceMethod;

@end
