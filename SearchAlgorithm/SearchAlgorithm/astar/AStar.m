//
// Created by Jack Lapin on 12.02.15.
// Copyright (c) 2015 JackLapin. All rights reserved.
//


#import "AStar.h"

@implementation AStar
{
    ASnode *_startPoint;
    ASnode *_finishPoint;
    NSArray *_grid;
    NSMutableArray *_obstacles;

    NSUInteger _width;
    NSUInteger _height;
}

/*
 * static
 */

- (NSUInteger)manhattanHeuristic:(ASnode *)gridCell destinationNode:(ASnode *)destinationNode cost:(NSUInteger)cost
{
    NSUInteger result;
    result = (abs((int) gridCell.point.x - (int) destinationNode.point.x) + abs((int) gridCell.point.y - (int) destinationNode.point.y)) * cost;
    return result;
}

//todo:review signature
- (NSMutableArray *)_connectedNodes:(CGPoint)position
{
    NSMutableArray *result = [[NSMutableArray alloc] init];

    ASnode *currentNode = _grid[(int)position.x][(int)position.y];

    for (NSInteger x = (NSInteger) position.x - 1; x <= position.x + 1; x++)
    {
        for (NSInteger y = (NSInteger) position.y - 1; y <= position.y + 1; y++)
        {
            BOOL isCurrentNode = x == position.x && y == position.y;

            //todo: invert and improve
            if (x > _height || x < 0 || y > _width || y < 0 || isCurrentNode)
            {
                continue;
            }
            else
            {
                ASnode *neighbour = _grid[x][y];

                [neighbour setParent:currentNode];
                [neighbour setH:[self manhattanHeuristic:neighbour destinationNode:_finishPoint cost:10]];

                if (x == (NSInteger)position.x || y == (NSInteger)position.y)
                {

                    //   direct way
                    NSLog(@"direct way");
                }
                else
                {
                    //   diagonal way
                }

                [result addObject:neighbour];
            }

            if (_obstacles.count > 0)
            {
                //todo: analize obstacles
            }

        }

    }

    return result;
}


/*
 * methods
 */

- (id)initWithGrid:(NSUInteger)width height:(NSUInteger)height
{
    self = [super init];

    if (self != nil)
    {
        _width = width;
        _height = height;

        [self _createGrid];
    }

    return self;
}

- (void)_createGrid
{
    NSMutableArray *rows = [NSMutableArray array];
    NSMutableArray *obstacle = [[NSMutableArray alloc] init];

    for (int i = 0; i < _height; i++)
    {
        NSMutableArray *row = [NSMutableArray array];

        for (int j = 0; j < _width; j++)
        {
            ASnode *node = [ASnode nodeWithPosition:CGPointMake(i, j)];
            [row addObject:node];
        }

        [rows addObject:row];
    }

    _grid = rows;
    _obstacles = obstacle;
}

- (void)print
{
    int startX = (int) _startPoint.point.x;
    int startY = (int) _startPoint.point.y;
    int finishX = (int) _finishPoint.point.x;
    int finishY = (int) _finishPoint.point.y;

    for (NSUInteger i = 0; i < _grid.count; i++)
    {
        NSString *string = @"";

        NSMutableArray *arrayRows = _grid[i];

        for (int j = 0; j < arrayRows.count; j++)
        {
            NSString *symbol;

            if ((startX == i && startY == j) || (finishX == i && finishY == j))
            {
                symbol = @"o ";
            }
            else
            {
                symbol = @"x ";
            }

            for (NSUInteger k = 0; k < _obstacles.count; k++)
            {
                ASnode *obs = _obstacles[k];

                if ((i == obs.point.x) && (j == obs.point.y))
                {
                    symbol = @"| ";
                }

            }

            string = [string stringByAppendingString:symbol];
        }

        NSLog(@"%@", string);
    }
}

- (void)setObstacle:(ASnode *)node
{
    NSAssert(_grid != nil, @"Grid not found");
    NSAssert(node.point.x <= _width && node.point.y <= _height, @"Obstacle %f , %f is out of range : %lu , %lu ", node.point.x, node.point.y, _width, _height);
    NSAssert(node.point.x != _startPoint.point.x && node.point.y != _startPoint.point.y, @"Obstacle and StartPoint at the same place");
    NSAssert(node.point.x != _finishPoint.point.x && node.point.y != _finishPoint.point.y, @"Obstacle and FinishPoint at the same place");

    if (_obstacles == nil)
    {
        _obstacles = [[NSMutableArray alloc] init];
    }

    for (NSUInteger i = 0; i < _obstacles.count; i++)
    {
        ASnode *existedObstacle = _obstacles[i];
        if ((node.point.x == existedObstacle.point.x) && (node.point.y == existedObstacle.point.y))
        {
            NSAssert(false, @"Obstacle %f , %f is already exist", node.point.x, node.point.y);
        }

    }

    ASnode *obstacle = [ASnode nodeWithPosition:node.point];
    [_obstacles addObject:obstacle];
}


- (ASnode *)findPath:(CGPoint)positionStart :(CGPoint)positionFinish
{
    ASnode *result = nil;

    NSMutableArray *openList = [[NSMutableArray alloc] init];
    NSMutableArray *closeList = [[NSMutableArray alloc] init];

    //todo:review
//    [openList addObject:positionStart];

//    while (currentNode != positionFinish)
//    {
    NSMutableArray *goingThroughNodes = [self _connectedNodes:positionStart];

    for (int i = 0; i<goingThroughNodes.count; i++)
    {
        NSLog(@"Neighbour %d", i);
        ASnode *aSnode = [[ASnode alloc] init];
        aSnode = [goingThroughNodes objectAtIndex:i];
    }

//    currentNode = positionFinish;
//    }

//    int i = [self manhattanHeuristic:positionStart destinationNode:positionFinish cost:10];
//    NSLog(@"%d", i);

   _startPoint = _grid[(int)positionStart.x][(int)positionStart.y];
   _finishPoint = _grid[(int)positionFinish.x][(int)positionFinish.y];

    return result;
}


@end