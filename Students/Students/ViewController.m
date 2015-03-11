//
//  ViewController.m
//  Students
//
//  Created by Jack Lapin on 10.03.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import "ViewController.h"
#import "LEStudent.h"

@interface ViewController ()

{
    
    NSMutableArray* arrayOfStudents;
    NSMutableArray* arrayOfFoundItems;
    BOOL searchDidWell;
}

@end

@implementation ViewController

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.searchText resignFirstResponder];
    [self searchStudent:textField.text];
    return YES;
}


-(LEStudent*) searchStudent :(NSString*) byName
{
    LEStudent * result = nil;
    
    for (int i=0; i < arrayOfStudents.count; i++)
    {
        LEStudent * stud = [arrayOfStudents objectAtIndex:i];
        if ([stud.name isEqualToString:byName])
        {
            result = stud;
        }
    }
    
    return result;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrayOfStudents = [[NSMutableArray alloc] init];
    
    for (int i=0; i<5; i++)
    {
        LEStudent* stud1 = [LEStudent initWith:([NSString stringWithFormat:@"Name%i",i]) andSurname:[NSString stringWithFormat:@"Surname%i",i]];
        [stud1 setAge:[NSNumber numberWithInt:(24+i)]];
        NSString * interest = [NSString stringWithFormat:@"Interest%i",i];
        [stud1 setInterests:interest];
        [arrayOfStudents addObject:stud1];
    }
    self.naviTitle.topItem.title = @"Students";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    //Поиск ячейки
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //Если ячейка не найдена
    if (cell == nil) {
        //Создание ячейки
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
    }
    
    if (arrayOfFoundItems.count > 0 )
    {
        LEStudent * stud = [arrayOfFoundItems objectAtIndex:indexPath.row];
        
        cell.textLabel.text = stud.name;
        cell.detailTextLabel.text = stud.surname;
        
    }
    if (arrayOfStudents.count > 0 && arrayOfFoundItems.count == 0)
    {
        LEStudent * stud = [arrayOfStudents objectAtIndex:indexPath.row];
        
        cell.textLabel.text = stud.name;
        cell.detailTextLabel.text = stud.surname;
        
    }
    
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (searchDidWell)
    {
        return [arrayOfFoundItems count];
    }
    else if (arrayOfStudents.count > 0)
    {
        return [arrayOfStudents count];
    }
    else
    {
        return 0;
    }
        
    //    return [arrayOfStudents count];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchButtonTouchUp:(id)sender {
    if ([self.searchReloadButton.titleLabel.text isEqualToString:@"Search"])
    {
        searchDidWell = true;
        if ([self searchStudent:self.searchText.text])
        {
            arrayOfFoundItems = [NSMutableArray new];
            [arrayOfFoundItems addObject: [self searchStudent:self.searchText.text]];
            [self.myTableView reloadData];
        }
    }
    else
    {
        arrayOfFoundItems = nil;
        [self.myTableView reloadData];
        searchDidWell = false;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSMutableString *newString = [textField.text mutableCopy];
    [newString appendString:string];
    
    if (string.length == 0 && newString.length ==1)
    {
        [self.searchReloadButton setTitle:@"Display" forState:UIControlStateNormal];
        return YES;
        
    }
    else
    {
        [self.searchReloadButton setTitle:@"Search" forState:UIControlStateNormal];
    }
    
    return YES;
}
@end
