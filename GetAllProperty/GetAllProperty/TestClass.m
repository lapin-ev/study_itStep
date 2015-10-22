//
//  TestClass.m
//  GetAllProperty
//
//  Created by Genrih Korenujenko on 20.08.15.
//  Copyright (c) 2015 Genrih Korenujenko. All rights reserved.
//

#import "TestClass.h"

@implementation TestClass

- (void)someMethod {
    NSLog(@"Hello from %@.%@!", self, NSStringFromSelector(_cmd));
}

- (void)callSomeMethod {
    NSLog(@"Hello from %@.%@!", self, NSStringFromSelector(_cmd));
    [self someMethod];
}

- (void)methodWithParam:(const char *)param bparam:(NSString *)b {
    NSLog(@"Hello from %@.%@! My parameter is: <%s>, %@", self, NSStringFromSelector(_cmd), param, b);
}

+ (void)someClassMethod {
    NSLog(@"Hello from some class method!");
}
- (void)someInstanceMethod {
    NSLog(@"Hello from some instance method!");
}

@end
