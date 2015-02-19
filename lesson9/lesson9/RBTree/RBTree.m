//
// Created by Jack Lapin on 29.01.15.
// Copyright (c) 2015 JackLapin. All rights reserved.
//

#import "RBTree.h"


@implementation RBTree
{
    RBNode *_root;
    int _depth;
}

- (RBNode *)root
{
    return _root;
}

- (int)depth
{
    return _depth;
}


- (RBNode *)rotateSingle:(RBNode *)root isDirectionLeftNode:(BOOL)isDirectionLeftNode
{
    RBNode *result;

    result = isDirectionLeftNode ? [root right] : [root left];

    if (isDirectionLeftNode)
    {
        [root setLeft:[result right]];
    }
    else
    {
        [result setRight:root];
    }

    [root changeColor:TRUE];
    [result changeColor:FALSE];
    return result;

}

- (RBNode *)rotateDouble:(RBNode *)root to:(RBNode *)dir
{
    RBNode *result;


    return result;
}


- (void)insert:(RBNode *)node
{
    if (_root == nil)
    {
        _root = node;
    }
    else
    {
        [self insertInternal:node];
    }
}

- (void)insertInternal:(RBNode *)node
{
    RBNode *parentNode = [self findParentFor:node];

    if (node.data < parentNode.data)
    {
        [parentNode setLeft:node];
    }
    else
    {
        [parentNode setRight:node];
    }
}

- (RBNode *)findParentFor:(RBNode *)node
{
    RBNode *result = nil;

    RBNode *currentNode = _root;

    do
    {
        BOOL goLeft = node.data < currentNode.data;

        if (goLeft)
        {
            result = currentNode;
            currentNode = [currentNode left];
        }
        else
        {
            result = currentNode;
            currentNode = [currentNode right];
        }
    }
    while (currentNode != nil);

    return result;
}

- (void)print:(RBNode *)node
{
    [self printWithIndent:node indent:@""];
}

- (void)printWithIndent:(RBNode *)node indent:(NSString *)indent
{
    NSLog(@"%@%d", indent, node.data);

    NSString *indentForChild = [indent stringByAppendingString:@" "];

    if ([node left] != nil)
    {
        [self printWithIndent:[node left] indent:indentForChild];
    }
    if (node.right != nil)
    {
        [self printWithIndent:[node right] indent:indentForChild];
    }
}

@end