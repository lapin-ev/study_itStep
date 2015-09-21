//
//  ViewController.m
//  WorkWithBlocks
//
//  Created by Jack Lapin on 12.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "ViewController.h"
#import "LENewsModel.h"
#import "RequestManager.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray * newsItems;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


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
    __block ViewController* weakSelf = self;// avoid retain circle
    [RequestManager loadAndSaveModelWithURL:url complition:^(id result, NSError * error) {
        if (!error) {
            weakSelf.newsItems = result;
            [weakSelf.tableView reloadData];
        }
    }];
}

#pragma mark TableView delegates
//
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    LENewsModel * model = self.newsItems[indexPath.row];
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.descriptionText;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.newsItems count];
}

@end
