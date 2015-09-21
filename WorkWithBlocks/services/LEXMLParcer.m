//
//  LEXMLParcer.m
//  WorkWithBlocks
//
//  Created by Jack Lapin on 12.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LEXMLParcer.h"

static NSString* kItemElementName = @"item";

@interface LEXMLParcer ()

@property (nonatomic, copy) ComplitionBlock complitionBock; // copy from stack to heep
@property (nonatomic, strong) NSMutableArray * itemsArray;
@property (nonatomic, strong) NSMutableString * currentElementString;
@property (nonatomic, strong) NSMutableDictionary * currentItemDictionary;
@property (nonatomic, strong) NSXMLParser * parcer;


@end

@implementation LEXMLParcer

@synthesize url=_url;

-(NSMutableArray *)itemsArray {
    if (!_itemsArray) {
        _itemsArray = [NSMutableArray array];
    }
    return _itemsArray;
}

-(void) parceNewItemsWithComplition:(ComplitionBlock)block {
    
    self.parcer = [[NSXMLParser alloc] initWithContentsOfURL:_url];
    self.parcer.delegate = self;
    
#warning TODO: handle error;
    self.complitionBock = block;
    [self.parcer parse];
    
}


+ (LEXMLParcer * ) parceWithUrl : (NSURL*) url {
    return [[LEXMLParcer alloc] initWithUrl:url];
}

- (LEXMLParcer*)initWithUrl:(NSURL*)url {
    _url = url;

    return self;
}

# pragma mark NSXMLParcer Delegat

-(void)parserDidStartDocument:(NSXMLParser *)parser {
    NSLog(@"started");
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict{
    if ([elementName isEqualToString:kItemElementName]) {
        self.currentItemDictionary = [NSMutableDictionary dictionary];
    }
    self.currentElementString = [NSMutableString string];
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [self.currentElementString appendString:string];
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName {
    if ([elementName isEqualToString:kItemElementName]) {
        [self.itemsArray addObject:self.currentItemDictionary];
    }
    else {
        [self.currentItemDictionary setObject:self.currentElementString forKey:elementName];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if (self.complitionBock) {
        self.complitionBock(self.itemsArray);
    }
}


@end
