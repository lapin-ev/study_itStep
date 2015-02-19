//
// Created by Jack Lapin on 29.01.15.
// Copyright (c) 2015 JackLapin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RBNode : NSObject

- (BOOL)isRed;

- (int)data;

- (RBNode *)left;

- (RBNode *)right;

+ (RBNode *)makeNode:(int)data;

- (void)setLeft:(RBNode *)value;

- (void)setRight:(RBNode *)value;

- (void)setData:(int)value;


- (void)changeColor:(BOOL)isRed;

@end