//
// Created by Jack Lapin on 12.02.15.
// Copyright (c) 2015 JackLapin. All rights reserved.
//

#import "ASnode.h"


@implementation ASnode
{
    int _f;
    int _g;
    int _h;

    CGPoint _point;

    ASnode *_parentNode;
}


+ (ASnode *)nodeWithPosition:(CGPoint)position;
{
    ASnode *result = [[ASnode alloc] init];

    [result setH:0];
    [result setG:0];
    [result setF:0];
    [result setParent:nil];

    result->_point = position;

    return result;
}

- (CGPoint)point
{
    return _point;
}


- (int)f
{
    return _f;
}

- (void)setF:(int)value
{
    _f = value;
}

- (void)setG:(int)value
{
    _g = value;
}

- (void)setH:(NSInteger)value
{
    _h = value;
}

- (void)setParent:(ASnode *)parent
{
    _parentNode = parent;
}

- (int)g
{
    return _g;
}

- (int)h
{
    return _h;
}

- (ASnode *)parentNode
{
    return _parentNode;
}

@end