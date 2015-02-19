//
//  main.m
//  lesson9
//
//  Created by Jack Lapin on 27.01.15.
//  Copyright (c) 2015 JackLapin. All rights reserved.
//

#import "RBNode.h"
#import "RBTree.h"

int main(int argc, const char *argv[])
{
    @autoreleasepool
    {

        RBTree *myTree = [[RBTree alloc] init];

        [myTree insert:[RBNode makeNode:3]];
        [myTree insert:[RBNode makeNode:1]];
        [myTree insert:[RBNode makeNode:7]];
        [myTree insert:[RBNode makeNode:2]];
        [myTree insert:[RBNode makeNode:5]];
        [myTree insert:[RBNode makeNode:9]];
        [myTree insert:[RBNode makeNode:0]];
        
        [myTree print:myTree.root];

    }


    return 0;
}