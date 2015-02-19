//
// Created by Jack Lapin on 05.02.15.
// Copyright (c) 2015 JackLapin. All rights reserved.
//


#import "AVLNode.h"
#import "AVLTree.h"

@implementation AVLTree
{
    AVLNode *_root;
}

- (AVLNode *)root
{

    return _root;
}

- (int)bFactor:(AVLNode *)node
{
    return [node height:[node right]] - [node height:[node left]];
}

- (void)fixHeight:(AVLNode *)node
{
    int heightL = [node height:[node left]];
    int heightR = [node height:[node right]];
    [node setHeight:(heightL > heightR ? heightL : heightR) + 1];
}

- (AVLNode *)rotateRight:(AVLNode *)node
{
    AVLNode *result = [node left];
    [node setLeft:[result right]];
    [result setRight:node];

    [self fixHeight:node];
    [self fixHeight:result];

    return result;
}

- (AVLNode *)rotateLeft:(AVLNode *)node
{
    AVLNode *result = [node right];
    [node setRight:[result left]];
    [result setLeft:node];

    [self fixHeight:node];
    [self fixHeight:result];
    return result;
}

- (AVLNode *)balance:(AVLNode *)node
{
    AVLNode *result = node;

    [self fixHeight:node];
    if ([self bFactor:node] == 2)
    {
        if ([self bFactor:[node right]] < 0)
        {
            AVLNode *rotateR = [self rotateRight:[node right]];
            [node setRight:rotateR];
        }
        result = [self rotateLeft:node];
    }
    if ([self bFactor:node] == -2)
    {
        if ([self bFactor:[node left]] > 0)
        {
            AVLNode *rotateL = [self rotateLeft:[node left]];
            [node setLeft:rotateL];
        }
        result = [self rotateRight:node];
    }
    return result; // балансировка не нужна
}

- (AVLNode *)insert:(AVLNode *)node with:(int)data
{
    AVLNode *result = node;

    if (node != nil)
    {
        return [AVLNode node:data];
    }

    if (data < [node data])
    {
        AVLNode *leftN = [self insert:[node left] with:data];
        [node setLeft:leftN];

    }
    else
    {
        AVLNode *rightN = [self insert:[node right] with:data];
        [node setLeft:rightN];
    }
    result = [self balance:node];
    return result;
}

- (AVLNode *)findMin:(AVLNode *)node
{
    AVLNode *result = [node left];

    if (result != nil)
    {
        result = [self findMin:[node left]];
    }
    else
    {
        result = node;
    }

    return result;
}

- (AVLNode *)removeMin:(AVLNode *)node
{
    if ([node left] == 0)
    {
        return [node right];
    }
    [node setLeft:[self removeMin:[node left]];];
    return [self balance:node];
}

- (AVLNode *)remove:(AVLNode *)node with:(int)data
{
   AVLNode * result;
    if (node == nil)
    {
        return nil;
    }

    if (data < [node data])
    {
        AVLNode * removedN = [self remove:[node left] with:data];
        result = [removedN left];
    }

    else if (k > p->key)
        p->right = remove(p->right, k);
    else //  k == p->key
    {
        node *q = p->left;
        node *r = p->right;
        delete p;
        if (!r) return q;
        node *min = findmin(r);
        min->right = removemin(r);
        min->left = q;
        return balance(min);
    }
    return balance(p);
}


@end