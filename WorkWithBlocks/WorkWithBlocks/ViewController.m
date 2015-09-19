//
//  ViewController.m
//  WorkWithBlocks
//
//  Created by Jack Lapin on 12.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "ViewController.h"
#import "LEXMLParcer.h"
#import "LENewsModel.h"

@interface ViewController ()

@property (nonatomic, strong) LEXMLParcer * parcer;
@property (nonatomic, strong) NSArray * newsItems;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    __block int i = 5;
//    void (^myBlock)() = ^ () {
//        int val = i+1;
//        NSLog(@"%d",val);
//    };
//    i = 7;
//    myBlock();
//    NSLog(@"%d",i);
    
    NSURL * url = [NSURL URLWithString:@"http://funzoo.ru/rss.xml"];
    self.parcer = [LEXMLParcer parceWithUrl:url];
    
    __block ViewController* weakSelf = self;// avoid retain circle

    [self.parcer parceNewItemsWithComplition:
     ^(NSArray* itemsArray) {
    
         NSMutableArray * tmpNewsArray = [NSMutableArray array];
         for (NSDictionary * dict in itemsArray) {
             LENewsModel * newsModel = [LENewsModel modelFromDictionary:dict];
             [tmpNewsArray addObject:newsModel];
         }
         
        weakSelf.newsItems = tmpNewsArray;
         
    }];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
