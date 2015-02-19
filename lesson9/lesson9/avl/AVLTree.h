//
// Created by Jack Lapin on 05.02.15.
// Copyright (c) 2015 JackLapin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVLNode.h"

@interface AVLTree : NSObject

- (AVLNode *)root;

- (int)bFactor:(AVLNode *)node;

- (void) fixHeight: (AVLNode*)node;

-(AVLNode*) rotateRight :(AVLNode*)node; // правый поворот вокруг p

-(AVLNode*) rotateLeft:(AVLNode*)node; // левый поворот вокруг q

-(AVLNode*) balance :(AVLNode*)node; // балансировка узла p

-(AVLNode*) insert : (AVLNode*)node with: (int) data; // вставка data в дерево с корнем p

-(AVLNode*) findMin : (AVLNode*) node; // поиск узла с минимальным ключом в дереве p

-(AVLNode*) removeMin : (AVLNode*) node; // удаление узла с минимальным ключом из дерева p

-(AVLNode*) remove : (AVLNode*)node with: (int) data; // удаление ключа k из дерева p




@end