//
//  main.m
//  SearchAlgorithm
//
//  Created by Jack Lapin on 12.02.15.
//  Copyright (c) 2015 JackLapin. All rights reserved.
//

#import "AStar.h"

int main(int argc, const char *argv[])
{
    @autoreleasepool
    {
        AStar *myWay = [[AStar alloc] initWithGrid:11 height:9];

        ASnode *start = [ASnode nodeWithPosition:CGPointMake(1, 0)];
        ASnode *finish = [ASnode nodeWithPosition:CGPointMake(7, 9)];

        [myWay findPath:CGPointMake(1, 0) :CGPointMake(7, 9)];

        ASnode *obstacle0 = [ASnode nodeWithPosition:CGPointMake(4, 4)];
        [myWay setObstacle:obstacle0];

        ASnode *obstacle1 = [ASnode nodeWithPosition:CGPointMake(2, 3)];
        [myWay setObstacle:obstacle1];

        [myWay print];

    }

    return 0;
}