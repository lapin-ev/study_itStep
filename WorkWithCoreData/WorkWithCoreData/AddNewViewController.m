//
//  AddNewViewController.m
//  WorkWithCoreData
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "AddNewViewController.h"
#import "AppDelegate.h"
#import "Users+CoreDataProperties.h"


@interface AddNewViewController ()

@end

@implementation AddNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.dtofBirthtextField.inputView = self.datePicker;
    self.dtofBirthtextField.inputAccessoryView = self.accessoryToolBar;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.dtofBirthtextField resignFirstResponder];
}

- (IBAction)datePickerValueChange:(id)sender {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd MMM, yyyy"];
    
    NSString *dateString = [format stringFromDate:self.datePicker.date];
    
    self.dtofBirthtextField.text = dateString;
}

- (IBAction)donePressed:(UIBarButtonItem *)sender {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd MMM, yyyy"];
    
    NSString *dateString = [format stringFromDate:self.datePicker.date];
    
    self.dtofBirthtextField.text = dateString;
    [self.dtofBirthtextField resignFirstResponder];
}

- (IBAction)changeGender:(id)sender {
    self.GenderDescription.text = self.genderType.on?@"Male":@"Female";
}

- (IBAction)editingDidFinished:(id)sender {
    [(UITextField *) sender resignFirstResponder];
}

-(void) save : (id)sender{
    
    NSManagedObjectContext *context = [AppDelegate sharedDelegate].managedObjectContext;
    NSString * dataName = NSStringFromClass([Users class]);
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:dataName inManagedObjectContext:context];
    Users *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    newManagedObject.dtOfBirth = self.datePicker.date;
    newManagedObject.name = self.name.text;
    newManagedObject.gender =[NSNumber numberWithBool:self.genderType.on];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

@end
