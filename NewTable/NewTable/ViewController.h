//
//  ViewController.h
//  NewTable
//
//  Created by Jack Lapin on 25.04.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTableViewCell.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) NSArray * news;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UITableViewCell *myCell;

@end

