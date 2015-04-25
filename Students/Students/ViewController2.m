//
//  ViewController2.m
//  Students
//
//  Created by Jack Lapin on 14.03.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import "ViewController2.h"
#import "TimerVC.h"
#import "LEAlbums.h"
#import "VCWithRandomItems.h"
#import "MyPhotoInAlbumsViewController.h"

@interface ViewController2 () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate >
{
        NSMutableArray * arrOfPickerItems;
}

@property (weak, nonatomic) IBOutlet UIButton *buttonImage;
- (IBAction)buttonImagePress:(id)sender;


@end


@implementation ViewController2

-(void)changePhoto : (NSNotification*) notification{
    if ([notification object]) {
        _stuPhoto.image = [notification object];
        _saveButton.enabled = YES;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrOfPickerItems  = [[NSMutableArray alloc] init];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new] ;
    [dateFormatter setDateFormat:@"yyyy"];
    int curYear =  [[dateFormatter  stringFromDate:[NSDate date]] intValue];
    
    for (int i = 1930; i< curYear; i++) {
        [arrOfPickerItems addObject:[NSString stringWithFormat:@"%i",i]];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePhoto:) name:@"changePhoto" object:nil] ;
    self.stuLastName.delegate = self;
    self.stuSex.enabled = NO;
    self.saveButton.enabled = NO;
    if (self.stu)
    {
        
        self.stuName.text = self.stu.name;
        self.stuLastName.text = self.stu.surname;
        //        self.stuSex.text = self.stu.sex;
        if (self.stu.sex == 0)
        {
            self.stuSex.text = @"Male";
            [self.isMaleSwitch setOn:YES];
        }
        else
        {
            self.stuSex.text = @"Female";
            [self.isMaleSwitch setOn:NO];
            
        }
        self.stuAge.text = [NSString stringWithFormat:@"%@", [NSNumber numberWithInt:self.stu.age.intValue]];
        self.stuInterests.text = self.stu.interests;
        
        //[self.buttonImage setImage:self.stu.photo forState:normal];
        self.stuPhoto.image = self.stu.photo;
        
    }
    else{
        self.isMaleSwitch.enabled = YES;
        self.isAdd = YES;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    NSDateFormatter *dateFormatter = [NSDateFormatter new] ;
    [dateFormatter setDateFormat:@"yyyy"];
    int row = [[dateFormatter  stringFromDate:[NSDate date]] intValue] - 1930 - 8;
    [_yearOfBirthPicker selectRow:row inComponent:0 animated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSMutableString *newString = [textField.text mutableCopy];
    [newString appendString:string];
    if (string.length == 0)
    {
        newString = [NSMutableString stringWithFormat:@"%@",[newString substringToIndex:(newString.length-1)]] ;
    }
    
    BOOL isChangeAnyField = FALSE;
    
    if (textField == self.stuName && ![newString isEqualToString:_stu.name])
    {
        isChangeAnyField = YES;
    }
    if (textField == self.stuLastName && ![newString isEqualToString:_stu.surname])
    {
        isChangeAnyField = YES;
    }
    NSMutableString * ageInString = [NSMutableString stringWithFormat:@"%@", [NSNumber numberWithInt:self.stu.age.intValue]];
    if (textField == self.stuAge && ![newString isEqualToString:ageInString])
    {
        isChangeAnyField = YES;
    }
    if (textField == self.stuInterests && ![newString isEqualToString:_stu.interests])
    {
        isChangeAnyField = YES;
    }
    
    if (isChangeAnyField){
        _saveButton.enabled = YES;
    }
    else {
        _saveButton.enabled = NO;
    }
    
    //    NSLog(@"Name : %@, string : %@, textField : %@, newstring : %@" , _stu.name, string, textField.text, newString);
    return  YES;
    
}


- (IBAction)saveStudent:(id)sender {
    self.stu.name = self.stuName.text;
    self.stu.surname = self.stuLastName.text;
    self.stu.age = [NSNumber numberWithInt:self.stuAge.text.intValue] ;
    self.stu.interests = self.stuInterests.text;
    self.stu.photo = _stuPhoto.image;
    if (_isMaleSwitch.isOn) {
        self.stu.sex = 0;
    }
    else {
        self.stu.sex = @1;
    }
    
    if (!self.isAdd && !_isSexChanged) {
        [self.myDelegate changeObjectAtIndex:self.index andArrayType:self.isMale andObject:self.stu];
        [self Done:nil];
    }
    if (!self.isAdd && _isSexChanged) {
        [self.myDelegate changedSex:self.index isMale:!_isMaleSwitch.isOn object:self.stu];
        [self Done:nil];
    }
    if (self.isAdd) {
        self.stu = [LEStudent new];
        self.stu.name = self.stuName.text;
        self.stu.surname = self.stuLastName.text;
        self.stu.age = [NSNumber numberWithInt:self.stuAge.text.intValue] ;
        self.stu.interests = self.stuInterests.text;
        if (_isMaleSwitch.isOn){
            self.stu.sex = [NSNumber numberWithInt:0];
        }
        else{
            self.stu.sex = [NSNumber numberWithInt:1];
        }
        [self.myDelegate addObjectInArray:self.stu andArrayType:self.isMale];
        [self Done:nil];
    }
    
}


- (IBAction)Done:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)TouchRandomItems:(id)sender {
    VCWithRandomItems *detailObject = [self.storyboard instantiateViewControllerWithIdentifier:@"VCWithRandomItems"];
    [self presentViewController:detailObject animated:YES completion:nil];
    
}
- (IBAction)touchFunnySlidersButton:(id)sender {
    TimerVC *detailObject = [self.storyboard instantiateViewControllerWithIdentifier:@"TimerVC"];
    [self presentViewController:detailObject animated:YES completion:nil];
    
}

- (IBAction)isMaleSwitchChanged:(id)sender {
    if (_isMale != _isMaleSwitch.isOn)  {
        _isSexChanged = YES;
        _saveButton.enabled = YES;
        self.stuSex.text = @"Male";
    }
    else {
        _saveButton.enabled = NO;
    }
    if (_isMaleSwitch.isOn)  {
        self.stuSex.text = @"Male";
    }
    else {
        self.stuSex.text = @"Female";
    }
    
}
- (IBAction)buttonImagePress:(id)sender {
    [self.view endEditing:YES];
    id detailObject = [self.storyboard instantiateViewControllerWithIdentifier:@"navController"];
    [self presentViewController:detailObject animated:YES completion:nil];
    
    //    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil
    //                                               destructiveButtonTitle:nil otherButtonTitles:@"Вибрати з галереї", nil];
    //
    //    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    //        [actionSheet addButtonWithTitle:@"Зняти на камеру"];
    //    }
    //
    //    [actionSheet addButtonWithTitle:@"Видмінити"];
    //    [actionSheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    if (buttonIndex == 0)
    {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:^{
        }];
    }
    else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] &&
             buttonIndex == 1)
    {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:^{
        }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    self.stuPhoto.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    _saveButton.enabled = YES;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    return arrOfPickerItems.count;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [arrOfPickerItems objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSLog(@"SelectedItem : %@", [arrOfPickerItems objectAtIndex:row]);
    NSDateFormatter *dateFormatter = [NSDateFormatter new] ;
    [dateFormatter setDateFormat:@"yyyy"];
    int curYear =  [[dateFormatter  stringFromDate:[NSDate date]] intValue];
    
    self.stu.age =[NSNumber numberWithInt:( curYear - [[arrOfPickerItems objectAtIndex:row] intValue]  )];

    self.stuAge.text = [NSString stringWithFormat:@"%i",self.stu.age.intValue ];
    _saveButton.enabled = YES;

}

@end

