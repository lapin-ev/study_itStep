//
// Created by Jack Lapin on 05.02.15.
// Copyright (c) 2015 JackLapin. All rights reserved.
//

#import "AVLNode.h"

@implementation AVLNode
{
    int _data;

    int _height;

    AVLNode *_left;

    AVLNode *_right;
};

+ (AVLNode *)node:(int)data
{
    AVLNode *result = [[AVLNode alloc] init];

    [result setData:data];
    [result setLeft:nil];
    [result setRight:nil];
    [result height:result];

    return result;
}


- (int)data
{
    return _data;
}

- (AVLNode *)left
{
    return _left;
}

- (AVLNode *)right
{
    return _right;
}

- (int)height
{
    return _height;
}


- (int)height:(AVLNode *)node
{
    return node ? [node height] : 0;;
}

- (void)setHeight:(int)value
{

    _height = value;
}


- (void)setLeft:(AVLNode *)value
{
    _left = value;
}

- (void)setRight:(AVLNode *)value
{
    _right = value;
}

- (void)setData:(int)value
{
    _data = value;
}


@end