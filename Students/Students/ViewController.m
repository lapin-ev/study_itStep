//
//  ViewController.m
//  Students
//
//  Created by Jack Lapin on 10.03.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import "ViewController.h"
#import "LEStudent.h"

#define titleGirls @"girls"
#define titleBoys @"boys"


@interface ViewController ()

{
    
    NSMutableArray* arrayOfStudents;
    NSMutableArray* arrayOfBoys;

    NSMutableArray* arrayOfGirls;

    NSMutableArray* arrayOfFoundItems;
    NSMutableArray * arrayOfTitles;
    BOOL isSearch;
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
    arrayOfTitles = [ NSMutableArray arrayWithObjects:titleBoys,titleGirls, nil];
    
    for (int i=0; i<6; i++)
    {
        LEStudent* stud1 = [LEStudent initWith:([NSString stringWithFormat:@"Name%i",i]) andSurname:[NSString stringWithFormat:@"Surname%i",i]];
        [stud1 setAge:[NSNumber numberWithInt:(24+i)]];
        if (i%2 == 0 )
        {
            stud1.sex = H_MALE;
        }
        else
        {
            stud1.sex = H_FEMALE;
        }
        
        NSString * interest = [NSString stringWithFormat:@"Interest%i",i];
        [stud1 setInterests:interest];
        [arrayOfStudents addObject:stud1];
    }
    
    arrayOfBoys = [NSMutableArray new];
    arrayOfGirls = [NSMutableArray new];
    
    
    for (LEStudent* stu in arrayOfStudents)
    {
        if (stu.sex == H_MALE)
        {
            [arrayOfBoys addObject:stu];
        }
        else
        {
            [arrayOfGirls addObject:stu];
        }
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
        cell.detailTextLabel.text = [stud.surname stringByAppendingString:[NSString stringWithFormat:@" Sex:%i", stud.sex]];
    }
    if (arrayOfStudents.count > 0 && arrayOfFoundItems.count == 0)
    {
        LEStudent * stud = [arrayOfStudents objectAtIndex:indexPath.row];
        cell.textLabel.text = stud.name;
        cell.detailTextLabel.text = [stud.surname stringByAppendingString:[NSString stringWithFormat:@" Sex:%i", stud.sex]];
    }
    
    LEStudent * stu =nil;
    
    if (indexPath.section == 0 )
    {
        stu =[arrayOfBoys objectAtIndex:indexPath.row];
    }
    else
    {
        stu =[arrayOfGirls objectAtIndex:indexPath.row];
    }

    cell.textLabel.text = stu.name;
    cell.detailTextLabel.text = [stu.surname stringByAppendingString:[NSString stringWithFormat:@" Sex:%i", stu.sex]];

    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
     return [arrayOfTitles objectAtIndex:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (section == 0 )
    {
        return arrayOfBoys.count;
    }
    else
    {
        return arrayOfGirls.count;
    }
//    if (isSearch)
//    {
//        return [arrayOfFoundItems count];
//    }
//    else if (arrayOfStudents.count > 0)
//    {
//        return [arrayOfStudents count];
//    }
//    else
//    {
//        return 0;
//    }
    
    //    return [arrayOfStudents count];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchButtonTouchUp:(id)sender {
    if ([self.searchReloadButton.titleLabel.text isEqualToString:@"Search"])
    {
        if ([self searchStudent:self.searchText.text])
        {
            arrayOfFoundItems = [NSMutableArray new];
            [arrayOfFoundItems addObject: [self searchStudent:self.searchText.text]];            
        }
    }
    else
    {
        arrayOfFoundItems = nil;
    }
    [self.myTableView reloadData];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSMutableString *newString = [textField.text mutableCopy];
    [newString appendString:string];
    
    if (string.length == 0 && newString.length ==1)
    {
        [self.searchReloadButton setTitle:@"Display" forState:UIControlStateNormal];
        isSearch = false;
        return YES;
        
    }
    else
    {
        [self.searchReloadButton setTitle:@"Search" forState:UIControlStateNormal];
        isSearch = true;
    }
    
    return YES;
}
@end
