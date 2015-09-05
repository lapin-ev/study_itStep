//
//  ViewController.m
//  15
//
//  Created by student on 04.07.15.
//  Copyright (c) 2015 student. All rights reserved.
//

//#define X 5
//#define Y 5

//Сортировка:
//1) Заполнить массив CGRect http://stackoverflow.com/questions/2934178/how-to-store-cgrect-values-in-nsmutablearray
//2) Рандомное число arc4Rand()%arr.count
//3) Присвоить frame к объекту
//4) Удаление текущего индекса

#import "ViewController.h"
#import "LabelClass.h"

@interface ViewController ()
{
    NSMutableArray *arraBox;
    int countLabel;
    int g;
    LabelClass *clearLabel;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    arraBox = @[].mutableCopy;//создаем копию массива
    
    g = 5; //отступ между лейблами
    
    float yAndH = g + 20;
    
    float xAndW = g;
    
    countLabel = 15; //определение сетки лейблов
    
    
    int deviceWidth = self.view.frame.size.width;//ширина экрана
    int sumg = (g*countLabel)+g; // расчет суммы отступов между лейблами
    float labelWidth = (deviceWidth-sumg)/countLabel; //расчет ширины лейбла
    
    int numberBox = 1;
    
    for (int i = 0; i < countLabel; i++)
    {
        for (int c = 0; c<countLabel; c++)
        {
            LabelClass *l = [LabelClass new];
            l.font = [UIFont systemFontOfSize:12];
            l.textAlignment = NSTextAlignmentCenter;
            l.userInteractionEnabled = YES; //для определения нажатого лейбла
            l.coordinate = [NSString stringWithFormat:@"%i.%i", i, c];
            if (c==0)
            {
                xAndW = g;
            }
            else
            {
                CGRect rect = [(UILabel *)arraBox.lastObject frame]; //обращение к последнему к последнему объекту в массиве
                xAndW = rect.origin.x + rect.size.width + g;
            }
            l.frame=CGRectMake(xAndW, yAndH, labelWidth, labelWidth);
            
            if (c == countLabel - 1)
            {
                yAndH = l.frame.origin.y + l.frame.size.height + g;
            }
            
            if (numberBox == countLabel * countLabel)
            {
                [l setBackgroundColor:[UIColor yellowColor]];
                l.text = @"";
                clearLabel = l;
            }
            else
            {
                l.text = [NSString stringWithFormat:@"%i", numberBox];
                [l setBackgroundColor:[UIColor lightGrayColor]];
            }
            
                [self.view addSubview:l];
                [arraBox addObject:l];
                
                numberBox++;
        }
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event //обработка касания
{
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
    
    if ([[touch.view class] isSubclassOfClass:[LabelClass class]])
    {
        LabelClass *label = (LabelClass *)touch.view;
//        NSLog(@"%@", [self equalCoordinate:(LabelClass *)touch.view] ? @"Move" : @"0");
        if ([self equalCoordinate:label])
        {
            NSString *coord = label.coordinate;
            CGRect rect = label.frame;
            clearLabel.coordinate = coord;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3f];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            
            [label setFrame:clearLabel.frame];
            [clearLabel setFrame:rect];
            
            [UIView commitAnimations];
        }
    }

  
}

- (NSString *)equasinons:(NSString *)coordinate and:(float)calculationCoordinate
{
    float n = coordinate.floatValue;
    NSLog(@"%@", [NSString stringWithFormat:@"%.1f", n - calculationCoordinate]);
    
    return [NSString stringWithFormat:@"%.1f", n - calculationCoordinate];
}

- (BOOL)equalCoordinate:(LabelClass *)mLabelTouch //проверка координат
{

    if ([clearLabel.coordinate isEqualToString:[self equasinons:mLabelTouch.coordinate and:-0.1]] || [clearLabel.coordinate isEqualToString:[self equasinons:mLabelTouch.coordinate and:0.1]] || [clearLabel.coordinate isEqualToString:[self equasinons:mLabelTouch.coordinate and:1.0]] || [clearLabel.coordinate isEqualToString:[self equasinons:mLabelTouch.coordinate and:-1.0]]) {
        return YES;
    }
    return NO;
}


//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSSet *allTouches = [event allTouches];
//    UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
//    CGPoint touchLocation = [touch locationInView:self.view];
//
////    if (touch.view == self.userBoard)
////    {
////        self.userBoard.center = CGPointMake(touchLocation.x, self.userBoard.center.y);
////    }
//    //board moving border
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
