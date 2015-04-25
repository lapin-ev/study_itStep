//
//  ViewController.h
//  Students
//
//  Created by Jack Lapin on 10.03.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEStudent.h"
#import "ViewController2.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, VC2Delegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (weak, nonatomic) IBOutlet UINavigationBar *naviTitle;
@property (weak, nonatomic) IBOutlet UIButton *addElement;
@property (weak, nonatomic) IBOutlet UIButton *searchReloadButton;

@property (nonatomic) IBOutlet UISegmentedControl *mySegmentedControll;
@property (weak, nonatomic) IBOutlet UIPickerView *myPickerView;

@property (weak, nonatomic) IBOutlet UITextField *searchText;
- (IBAction)searchButtonTouchUp:(id)sender;
- (IBAction)addNewSudent:(id)sender;

- (LEStudent*) searchStudent :(NSString*) byName;
- (IBAction)save:(UIButton *)sender;

- (IBAction)segmentedControlValueChange:(UISegmentedControl *)sender;


@end

