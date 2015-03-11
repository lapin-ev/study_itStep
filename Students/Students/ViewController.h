//
//  ViewController.h
//  Students
//
//  Created by Jack Lapin on 10.03.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEStudent.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (weak, nonatomic) IBOutlet UINavigationBar *naviTitle;
@property (weak, nonatomic) IBOutlet UIButton *addElement;
@property (weak, nonatomic) IBOutlet UIButton *searchReloadButton;
@property (weak, nonatomic) IBOutlet UITextField *searchText;
- (IBAction)searchButtonTouchUp:(id)sender;
- (LEStudent*) searchStudent :(NSString*) byName;

@end

