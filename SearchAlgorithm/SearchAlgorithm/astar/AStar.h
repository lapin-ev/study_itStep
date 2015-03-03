//
// Created by Jack Lapin on 12.02.15.
// Copyright (c) 2015 JackLapin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AStar.h"
#import "ASnode.h"


@interface AStar : NSObject


/*
 * methods
 */

- (id)initWithGrid:(NSUInteger)width height:(NSUInteger)height;

- (void)print;

- (ASnode *)findPath:(CGPoint)positionStart :(CGPoint)positionFinish;

- (void)setObstacle:(ASnode *)node;


@end