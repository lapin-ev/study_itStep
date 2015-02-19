//
// Created by Jack Lapin on 05.02.15.
// Copyright (c) 2015 JackLapin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AVLNode : NSObject

+ (AVLNode *)node:(int)data;

- (int)data;

- (int)height;

- (AVLNode *)left;

- (AVLNode *)right;

- (int)height:(AVLNode *)node;

- (void) setHeight : (int)value;

- (void)setLeft:(AVLNode *)value;

- (void)setRight:(AVLNode *)value;

- (void)setData:(int)value;


@end