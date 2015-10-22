//
//  ViewController.m
//  GetAllProperty
//
//  Created by Genrih Korenujenko on 03.08.15.
//  Copyright (c) 2015 Genrih Korenujenko. All rights reserved.
//

#import "ViewController.h"
#import "MClass.h"
#import "NSObject+SetAllProperty.h"
#import "UITableView+Additions.h"
#import "TestClass.h"


@interface ViewController () <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView *tb;
    
    int i;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // заполнения класса
    
    MClass *m = [MClass new];
    
    UILabel *l = [UILabel new];
    l.text = @"qqqq";
    
    [m setObjectsWithDicationary:@{@"string1" : @"Good 1", @"string2" : @"sss", @"label1" : l}];
    
    NSLog(@"%@", m);
    
    NSLog(@"%@", [l.text description]);
    
    // tableView

    i = 0;

    tb.text = @"Count 0";
    
    
    // вызов метода и регистрация
    
//    TestClass * myObj = [[TestClass alloc] init];
//    
//    SEL mySelector = sel_registerName("methodWithParam:bparam:");
//    objc_msgSend(myObj, mySelector);
    
//    typedef void (*MethodWithoutParams)(id, SEL);
//    typedef void (*MethodWithParam)(id, SEL, const char *, NSString *);
//    
//    MethodWithoutParams someMethodImplementation = [myObj methodForSelector:@selector(someMethod)];
//    MethodWithoutParams callSomeMethodImplementation = [myObj methodForSelector:@selector(callSomeMethod)];
//    MethodWithParam methodWithParamImplementation = [myObj methodForSelector:@selector(methodWithParam:bparam:)];
//    
//    someMethodImplementation(myObj, @selector(someMethod));
//    callSomeMethodImplementation(myObj, @selector(callSomeMethod));
//    methodWithParamImplementation(myObj, @selector(methodWithParam:), "I'm a parameter", @"sss");
    
//    objc_msgSend(myObj, mySelector, "I'm a parameter", @"sss");

    
//    ....
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return i;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"c"];
    cell.textLabel.text = @"1";
    return cell;
}

- (IBAction)reload:(id)sender {
    i++;
    if (i == 5) {
        i = 0;
    }
    [tb reloadData];
}

@end
