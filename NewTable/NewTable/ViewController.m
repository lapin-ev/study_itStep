//
//  ViewController.m
//  NewTable
//
//  Created by Jack Lapin on 25.04.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import "ViewController.h"
#define c_height 170

@interface ViewController ()

{
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.news = [NSArray arrayWithObjects:
                 @"Подсчет высоты ячейки и ингрища с констэйнтами, геморная шняга, с которой постоянно одни мучения",
                 @"Как обновить свой iPhone 4 до 4S",
                 @"Отключаем функцию восстановления в `Просмотре` в Mac OS X Lion Отключаем функцию восстановления в `Просмотре` ",
                 @"За первые 24 часа Apple получила более миллиона предзаказов на iPhone 4S",
                 @"Fruit Ninja: Puss in Boots появится в App Store уже в этом месяце",
                 @"Sony Pictures хочет снять фильм про Стива Джобса", nil];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    
    //Поиск ячейки
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //Если ячейка не найдена
    if (cell == nil) {
        //Создание ячейки
        cell = [[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
    }
    
    cell.headerOfNew.text = [_news objectAtIndex:indexPath.row];
    cell.duplicateLabel.text = [_news objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * text = [_news objectAtIndex:indexPath.row];
    float height = c_height;
    MyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    CGFloat cell_heght = cell.frame.size.height;
    
    NSMutableArray *arrViews = [NSMutableArray new];
    for (id object in [cell.contentView subviews]) {
        if ([[object class] isSubclassOfClass:[UILabel class]]) {
            [arrViews addObject:object];
        }
    }
    if (arrViews.count > 0 ){
        for (int i = 0; i < arrViews.count; i++) {
            height = height + [self frameSize:text andLabel:[arrViews objectAtIndex:i]];
        }
    }
    
    return  height;
}

-(CGFloat) frameSize :(NSString *) text andLabel: (UILabel*) label{
    CGRect  frame;
    NSDictionary * dic = @{NSFontAttributeName:[UIFont systemFontOfSize:label.font.pointSize]};
    float sv = [UIDevice currentDevice].systemVersion.floatValue;
    
    if (sv >= 7.f) {
        frame = [text boundingRectWithSize:CGSizeMake(label.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    }
    
    return frame.size.height;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"News";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _news.count;
}

@end
