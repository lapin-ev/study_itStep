//
//  LEImagePicker.m
//  Students
//
//  Created by Jack Lapin on 02.04.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import "LEAlbums.h"
#import "ViewController2.h"
#import "MyPhotoInAlbumsViewController.h"

@interface LEAlbums () <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray * arrOfAlbums;
}


@end

@implementation LEAlbums

-(IBAction)backButton:(UIButton*) sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!arrOfAlbums) {
        arrOfAlbums = [NSMutableArray new];
    }
    
    ALAssetsLibrary *albumInfo = [[ALAssetsLibrary alloc] init];
    [albumInfo enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        NSLog(@"name: %@", [group valueForProperty:ALAssetsGroupPropertyName]);
        NSLog(@"count: %lu", (unsigned long)[group numberOfAssets]);
        if (group) {
            NSString * name = [group valueForProperty:ALAssetsGroupPropertyName];
            NSNumber* count = [ NSNumber numberWithInteger:[group numberOfAssets]];
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:name, @"name" , count, @"count", nil];
            
            [arrOfAlbums addObject:dic];
        }
        if (stop) {
            [_albumsTableView reloadData];
        }
    } failureBlock:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Увага!" message:@"Приложению нужен доступ к альбомам, измените Настройки" delegate:self cancelButtonTitle:@"Ок" otherButtonTitles:nil];
        [alert show];
        NSLog(@"User did not allow access to library");
    }];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Albums";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"albumInfoCell";
    
    //Поиск ячейки
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //Если ячейка не найдена
    if (cell == nil) {
        //Создание ячейки
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                           reuseIdentifier:cellIdentifier];
        
    }
    
    cell.textLabel.text = arrOfAlbums[indexPath.row][@"name"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", arrOfAlbums[indexPath.row][@"count"]];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyPhotoInAlbumsViewController *detailObject = [self.storyboard instantiateViewControllerWithIdentifier:@"MyPhotoInAlbumsViewController"];
    
    detailObject.albumName = [[tableView cellForRowAtIndexPath:indexPath] textLabel].text;
//    [self presentViewController:detailObject animated:YES completion:nil];
    [self.navigationController pushViewController:detailObject animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!arrOfAlbums) {
        arrOfAlbums = [NSMutableArray new];
    }
    return arrOfAlbums.count;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
