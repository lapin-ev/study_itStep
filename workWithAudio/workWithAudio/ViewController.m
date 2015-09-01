//
//  ViewController.m
//  workWithAudio
//
//  Created by Jack Lapin on 29.08.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "ViewController.h"
#import "LESong.h"

@interface ViewController ()

@property AVAudioPlayer *player;



@end

NSMutableArray *arraySounds;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arraySounds = [NSMutableArray new];
    
}

-(void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    for (int i = 1; i <= 2; i++) {
        NSURL *audioFileURL = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"%i.mp3", i] withExtension:nil];
        AVAsset *asset = [AVURLAsset URLAssetWithURL:audioFileURL options:nil];
        LESong *song = [LESong new];
        song.path = [NSString stringWithFormat:@"%i.mp3", i];
        for (AVMetadataItem *item in asset.metadata) {
            if ([[item commonKey] isEqualToString:AVMetadataCommonKeyTitle]) {
                NSLog(@"%@", [item value]);
                song.title = (NSString *)item.value;
            }
            if ([[item commonKey] isEqualToString:AVMetadataCommonKeyArtist]) {
                NSLog(@"%@", [item value]);
                song.artist = (NSString *)item.value;
                
            }
            if ([[item commonKey] isEqualToString:AVMetadataCommonKeyAlbumName]) {
                NSLog(@"%@", [item value]);
                song.albumName = (NSString *)item.value;
                
            }
            if ([[item commonKey] isEqualToString:AVMetadataCommonKeyArtwork]) {
                NSData *data = (NSData *)[item value];
                if (data) {
                    song.image = YES;
                }
            }
            
        }
        [arraySounds addObject:song];
    }
    
    [self.tableOfSongs reloadData];
    
//    NSURL *audioFileURL = [[NSBundle mainBundle] URLForResource:@"1.mp3" withExtension:nil];
//    
//    NSError *error;
//    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:audioFileURL error:&error];
//    if (error) {
//        NSLog(@"%@", [error localizedDescription]);
//    }
//    else {
//        self.player.numberOfLoops = 0;
//        
//        self.player.volume = 0.1;
//        
//        [self.player play];
    
        
//    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arraySounds.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"LESongCell";
    
    //Поиск ячейки
    LESongCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //Если ячейка не найдена
    if (cell == nil) {
        //Создание ячейки
        cell = [[LESongCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];


        }
    LESong * song = [arraySounds objectAtIndex:indexPath.row];
    
    cell.albumName.text = song.albumName;
    cell.artist.text = song.artist;
    cell.title.text = song.title;
    if (song.image) {
        NSURL *audioFileURL = [[NSBundle mainBundle] URLForResource:song.path withExtension:nil];
        AVAsset *asset = [AVURLAsset URLAssetWithURL:audioFileURL options:nil];
        
        NSData *data = (NSData *)[(AVMetadataItem *)[[AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyArtwork keySpace:AVMetadataKeySpaceCommon] objectAtIndex:0] value];
        cell.imageView.image = [UIImage imageWithData:data];
        
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
