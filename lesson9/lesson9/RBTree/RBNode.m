//
// Created by Jack Lapin on 29.01.15.
// Copyright (c) 2015 JackLapin. All rights reserved.
//

#import "RBNode.h"


@implementation RBNode
{
    BOOL _isRed;
    int _data;
    RBNode *_left;
    RBNode *_right;
}

- (BOOL)isRed
{
    return _isRed;
}

- (int)data
{
    return _data;
}

- (RBNode *)right
{
    return _right;
}

- (void)setRight:(RBNode *)value
{
    _right = value;
}

- (void)setLeft:(RBNode *)value
{
    _left = value;
}

- (RBNode *)left
{
    return _left;
}

- (void)changeColor:(BOOL)isRed
{
    _isRed = isRed;
}

- (void)setData:(int)value
{
    _data = value;
}

+ (RBNode *)makeNode:(int)data
{
    RBNode *result = [[RBNode alloc] init];

    [result setData:data];
    [result changeColor:TRUE];
    [result setRight:nil];
    [result setLeft:nil];

    return result;

}


- (NSString *)description
{
    return [NSString stringWithFormat:@"data: %d", _data];
}


@end