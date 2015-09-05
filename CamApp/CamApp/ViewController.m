//
//  ViewController.m
//  CamApp
//
//  Created by student on 22.08.15.
//  Copyright (c) 2015 student. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIToolbar *downToolBar;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"1" style:UIBarButtonItemStyleDone target:self action:@selector(test:)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"2" style:UIBarButtonItemStyleDone target:self action:@selector(test:)];
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithTitle:@"3" style:UIBarButtonItemStyleDone target:self action:@selector(test:)];
    
    [self.navigationItem setLeftBarButtonItems:@[item1, item2, item3]];
    
    // добавление кнопки с картинкой
    UIImage *faceImage = [UIImage imageNamed:@"back.png"];
    UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
    face.frame = CGRectMake(0, 0, 50, 40);
    [face setImage:faceImage forState:UIControlStateNormal];
    [face addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:face];
    self.navigationItem.rightBarButtonItem = backButton;
    
    self.title = @"CammApp";
    // добавление segmentcontrol
    NSArray *segmentTextContent = [NSArray arrayWithObjects:
                                   @"Image",
                                   @"Text",
                                   @"Video",
                                   nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentTextContent];
    segmentedControl.selectedSegmentIndex = 1;
    segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    segmentedControl.frame = CGRectMake(0.0f, 0.0f, 400.0f, 30.0f);
    [segmentedControl addTarget:self action:@selector(test:) forControlEvents:UIControlEventValueChanged];
    
    segmentedControl.frame = CGRectMake(0, 0, 150, 20);
    
    self.navigationItem.titleView = segmentedControl;
    
    UISegmentedControl * segmC = [[UISegmentedControl alloc]initWithItems:segmentTextContent];
    [segmC addTarget:self action:@selector(test:) forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *bottonItem = [[UIBarButtonItem alloc] initWithCustomView:segmC];
    
    UIBarButtonItem *addSharing = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(test:)];
    
    [self.downToolBar setItems:@[addSharing,flexibleItem,bottonItem,flexibleItem] animated:YES];
    
    
}


-(void) test : (id) sender {
    UILabel * labelB = [UILabel new];
    labelB.frame = CGRectMake(0, 0, 50, 40);
    
    labelB.text = @"PushMe";
    labelB.font = [UIFont systemFontOfSize:10];
    [self.navigationItem.rightBarButtonItem setCustomView:labelB];
    
    if ([[sender class]isSubclassOfClass:[UISegmentedControl class]]) {
        
        NSString * str =  [sender titleForSegmentAtIndex:[sender selectedSegmentIndex]];
        labelB.text = str;
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"tabbar"] animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
