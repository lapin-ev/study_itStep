//
//  AddContactControllerViewController.m
//  CamApp
//
//  Created by Jack Lapin on 28.08.15.
//  Copyright © 2015 student. All rights reserved.
//

#import "AddContactViewController.h"

@interface AddContactViewController ()

{
UIScrollView* scrollView; //  указатель на наш UIScrollView
UITextField* activeField; // указывает на активный элемент ввода
}
@end

@implementation AddContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // регистрация на центре уведомлений
    
    self.phoneNumberMobile.keyboardType = UIKeyboardTypePhonePad;
    self.phoneNumberWork.keyboardType = UIKeyboardTypePhonePad;
    self.email.keyboardType = UIKeyboardTypeEmailAddress;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    NSArray* arrV = self.view.subviews; // получаем массив всех пеодвидов
    for(UIView* v in arrV){
        if([v isKindOfClass:[UIScrollView class]]){
            scrollView = (UIScrollView*)v; // находим наш scrollView и сохраняем его
            break;
        }
    }
    if(scrollView){
        UIView* contentView = scrollView.subviews[0]; // определяем contentView
        // как первый подвид у нашего scrollView
        CGRect r = [contentView frame];
        scrollView.contentSize = r.size; // устанавливаем значение размера вида с контентом
        //
        if([contentView isKindOfClass:[UIControl class]])// если contentView установлен в "Identity Inspector" в UIControl
            // устанавливаем для него обработчик касания
            [(UIControl*)contentView addTarget:self action:@selector(touchFieldsView:)
                              forControlEvents:UIControlEventTouchDown];
        NSArray* arrC = contentView.subviews; // получаем массив из подвидов contentView
        for(id editOrNo in arrC){
            if([editOrNo isKindOfClass:[UITextField class]]){
                UITextField* tf = editOrNo; // если подвид является экземпляром UITextField, устанавливаем его делегат
                [tf setDelegate:self];
            }
        }
    }
}

- (void)keyboardWasShown:(NSNotification*)aNotification // Обработка сообщения о отображении клавиатуры
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size; // получаем размер клавиатуры
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    // Если активное поле ввода спрятано клавиатурой, скроллируем, чтобы показать его
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        [scrollView scrollRectToVisible:activeField.frame animated:YES];
    }
}

// Вызывается когда клавиатура скрывается
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}

- (IBAction)touchFieldsView:(id)sender {
    if(activeField)
        [activeField resignFirstResponder];
}

// Вызывается при окончании редактирования текстового поля, метод делегата
-(void)textFieldDidEndEditing:(UITextField *)textField {
    activeField = nil;
}

// Вызывается при нажатии Enter на клавиатуре
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

// При освобождении из памяти, снимаем контроллер вида с центра уведомлений
- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
