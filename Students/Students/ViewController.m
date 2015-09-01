//
//  ViewController.m
//  Students
//
//  Created by Jack Lapin on 10.03.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import "ViewController.h"
#import "ViewController2.h"
#import "LEStudent.h"
#import "StudentTableViewCell.h"
#import "SaveMyData.h"


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

-(void)addNewSudent:(id)sender{
    ViewController2 *detailObject = [self.storyboard instantiateViewControllerWithIdentifier:@"detailOfStudent"];
    detailObject.myDelegate = self;
    [self presentViewController:detailObject animated:YES completion:nil];
    
}

-(void)changedSex:(NSInteger)index isMale:(BOOL)isMale object:(LEStudent *)stu{
    if (isMale){
        [arrayOfBoys removeObjectAtIndex:index];
        [arrayOfGirls addObject:stu];
    }
    else{
        [arrayOfGirls removeObjectAtIndex:index];
        [arrayOfBoys addObject:stu];
    }
    [_myTableView reloadData];
    
}

-(void) changeObjectAtIndex:(NSInteger)index andArrayType:(BOOL)arayType andObject:(LEStudent *)stu
{
    NSInteger section;
    if (arayType)
    {
        [arrayOfBoys replaceObjectAtIndex:index withObject:stu];
        section = 0;
    }
    else
    {
        [arrayOfGirls replaceObjectAtIndex:index withObject:stu];
        section = 1;
        
    }
    
    [_myTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:section]] withRowAnimation:normal];
    
    // [_myTableView reloadData];
}

- (void) addObjectInArray : (LEStudent*)stu andArrayType :(BOOL) arayType{
    if (arayType){
        [arrayOfBoys addObject:stu];
    }
    else{
        [arrayOfGirls addObject:stu];
    }
    
    [_myTableView reloadData];
}




//- (void)alertView:(autoAlertView)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    NSLog(@"Button pressed %i", (int)buttonIndex);
//    if (buttonIndex == 0)
//    {
//        [self saveObject];
//    }
//
//}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    NSIndexPath *indexPath = [_myTableView indexPathForSelectedRow];
//
//    NSLog(@"%@",[arrayOfBoys objectAtIndex:indexPath.row]);
//
//    ViewController2 *detailObject = segue.destinationViewController;
//    detailObject.myDelegate = self;
//
//    detailObject.stu = [LEStudent new];
//    if (indexPath.section == 0) {
//        detailObject.stu = [arrayOfBoys objectAtIndex:(int)indexPath.row];
//        detailObject.isMale = YES;
//    } else {
//        detailObject.stu = [arrayOfGirls objectAtIndex:(int)indexPath.row];
//        detailObject.isMale = NO;
//    }
//    detailObject.index = indexPath.row;
//
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField  // Меотод обрабатывает нажатие на виртуальной клавиатуре
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


- (IBAction)save:(UIButton *)sender {
    
    [self saveObject];
    
    UIAlertView *saveAlert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Changes saved!"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:nil];
    saveAlert.transform = CGAffineTransformMake(1.0f, 0.5f, 0.0f, 1.0f, 0.0f, 0.0f);
    [saveAlert performSelector:@selector(dismissWithClickedButtonIndex:animated:)
                    withObject:nil
                    afterDelay:1.0f];
    [saveAlert show];
    
}

- (IBAction)segmentedControlValueChange:(UISegmentedControl *)sender {

    NSLog(@"%li", (long)[self.mySegmentedControll selectedSegmentIndex]);
    
    if ([_mySegmentedControll selectedSegmentIndex] == 0) {
        [_mySegmentedControll setTitle:@"double" forSegmentAtIndex:0];
    }
    else if ([_mySegmentedControll selectedSegmentIndex] == 1) {
        
        UIImage * image = [UIImage imageNamed:@"bright-green-check-mark-md.png"];

        [_mySegmentedControll setImage:image forSegmentAtIndex:1];
    }
    
    
    if (_mySegmentedControll.subviews.count > 4) {

    }

}


- (void) saveObject {
    
    [SaveMyData saveMyArray:arrayOfBoys forKey:@"boys"];
    [SaveMyData saveMyArray:arrayOfGirls forKey:@"girls"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrayOfStudents = [[NSMutableArray alloc] init];
    arrayOfTitles = [ NSMutableArray arrayWithObjects:titleBoys,titleGirls, nil];
    
    NSString * pathToImage1  =[[NSBundle mainBundle] pathForResource:@"img_b" ofType:@"jpg"];
    NSString * pathToImage2  =[[NSBundle mainBundle] pathForResource:@"img_g" ofType:@"jpg"];
    
    NSData * img1 = [NSData dataWithContentsOfFile:pathToImage1];
    NSData * img2 = [NSData dataWithContentsOfFile:pathToImage2];
    
    NSURL * urlToImg = [NSURL URLWithString:@"http://cs622421.vk.me/v622421100/2a499/W17XjI97Pug.jpg"];
    img1 = [NSData dataWithContentsOfURL:urlToImg];
    
    for (int i=0; i<6; i++)
    {
        LEStudent* stud1 = [LEStudent initWith:([NSString stringWithFormat:@"Name%i",i]) andSurname:[NSString stringWithFormat:@"Surname%i",i]];
        [stud1 setAge:[NSNumber numberWithInt:(24+i)]];
        if (i%2 == 0 )
        {
            stud1.sex = 0;
            stud1.photo = [UIImage imageWithData:img1];
            
        }
        else
        {
            stud1.sex = [NSNumber numberWithInt:1];
            stud1.photo = [UIImage imageWithData:img2];
            
        }
        
        NSString * interest = [NSString stringWithFormat:@"Interest%i",i];
        [stud1 setInterests:interest];
        [arrayOfStudents addObject:stud1];
    }
    
    arrayOfBoys = [SaveMyData loadMyArray:@"boys"];
    arrayOfGirls = [SaveMyData loadMyArray:@"girls"];
    
    if (!arrayOfGirls || !arrayOfBoys)
    {
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
    }

    // Потоки.
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void){
        //Background Thread
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
        });
    });
    
    //--------
    
    
    self.naviTitle.topItem.title = @"Students";
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    [_mySegmentedControll removeAllSegments];
    [_mySegmentedControll insertSegmentWithTitle:@"Table" atIndex:0 animated:YES];
    [_mySegmentedControll insertSegmentWithTitle:@"Collection" atIndex:1 animated:YES];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    //Поиск ячейки
    StudentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //Если ячейка не найдена
    if (cell == nil) {
        //Создание ячейки
        cell = [[StudentTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                           reuseIdentifier:cellIdentifier];
    }
    
    if (arrayOfFoundItems.count > 0 )
    {
        LEStudent * stud = [arrayOfFoundItems objectAtIndex:indexPath.row];
        cell.textLabel.text = stud.name;
        cell.detailTextLabel.text = [stud.surname stringByAppendingString:[NSString stringWithFormat:@" Sex:%i", stud.sex.intValue]];
    }
    if (arrayOfStudents.count > 0 && arrayOfFoundItems.count == 0)
    {
        LEStudent * stud = [arrayOfStudents objectAtIndex:indexPath.row];
        cell.LName.text = stud.name;
        cell.LSurname.text = [stud.surname stringByAppendingString:[NSString stringWithFormat:@" Sex:%i", stud.sex.intValue]];
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
    
    cell.LName.text = stu.name;
    cell.LSurname.text = stu.surname;
    if (stu.sex.intValue == 0) {
            cell.LSex.text = [NSString stringWithFormat:@"Male"];
    }
    else {
            cell.LSex.text = [NSString stringWithFormat:@"Female"];
    }

    cell.LAge.text = [NSString stringWithFormat:@" Age:%i", stu.age.intValue];
    cell.LInterests.text = stu.interests;
    cell.LPhoto.image = stu.photo;
    
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //  Привязываем к готовому контроллеру на который все накидано, без привязки к СЕГУЕ
    ViewController2 *detailObject = [self.storyboard instantiateViewControllerWithIdentifier:@"detailOfStudent"];
    
    detailObject.myDelegate = self;
    
    detailObject.stu = [LEStudent new];
    if (indexPath.section == 0) {
        detailObject.stu = [arrayOfBoys objectAtIndex:(int)indexPath.row];
        detailObject.isMale = ![[(LEStudent*)[arrayOfBoys objectAtIndex:(int)indexPath.row] sex] boolValue];
    } else {
        detailObject.stu = [arrayOfGirls objectAtIndex:(int)indexPath.row];
        detailObject.isMale = NO;
    }
    detailObject.index = indexPath.row;
    [self presentViewController:detailObject animated:YES completion:nil];
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
