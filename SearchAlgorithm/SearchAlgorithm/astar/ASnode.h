//
// Created by Jack Lapin on 12.02.15.
// Copyright (c) 2015 JackLapin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASnode : NSObject

/*
 * Static
 */

+(ASnode *) nodeWithPosition:(CGPoint)position;

/*
   properties
 */

-(CGPoint) point;

-(int) f;
-(void) setF :(int) value;

-(int) g;
-(void) setG :(int) value;

-(int) h;
-(void) setH :(int) value;

-(ASnode *) parentNode;
-(void) setParent :(ASnode *) parent;

/*
 * methods
 */




@end
