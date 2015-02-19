//
// Created by Jack Lapin on 29.01.15.
// Copyright (c) 2015 JackLapin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RBNode.h"

@interface RBTree : NSObject

- (RBNode *)root;

- (int)depth;

- (RBNode *)rotateSingle:(RBNode *)root isDirectionLeftNode:(BOOL)isDirectionLeftNode;

- (RBNode *)rotateDouble:(RBNode *)root to:(RBNode *)dir;

- (void)insert:(RBNode *)node;

- (void)print:(RBNode *)root;


@end