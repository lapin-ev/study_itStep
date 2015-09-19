//
//  ViewController.m
//  AudioWorkWith
//
//  Created by Jack Lapin on 12.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "ViewController.h"

#define kMAXOldPower 0
#define kMINOldPower -160
#define kMAXNewPower 1
#define kMINNewPower 0

@interface ViewController () <AVAudioRecorderDelegate, AVAudioPlayerDelegate>
{
    AVAudioRecorder * recoder;
    AVAudioPlayer * player;
    NSTimer * powerMeseringTimer;
}

@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *recordPauseButton;
@property (weak, nonatomic) IBOutlet UILabel *powerLabel;

- (IBAction)recordStopButtonPressed:(id)sender;

- (IBAction)stopButtonPressd:(id)sender;

- (IBAction)playButtonPressed:(id)sender;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray * pathComponent = [NSArray arrayWithObjects:
                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                               @"MyAudioMemo.m4a", nil];
    NSURL * outputFileUrl = [NSURL fileURLWithPathComponents:pathComponent];
    
    AVAudioSession * session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    NSDictionary * recordSettings = @{AVFormatIDKey:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] ,
                                      AVSampleRateKey: [NSNumber numberWithFloat:44100.0] ,
                                      AVNumberOfChannelsKey :[NSNumber numberWithInt:2]};
    
    recoder = [[AVAudioRecorder alloc] initWithURL:outputFileUrl settings:recordSettings error:nil];
    
    recoder.delegate = self;
//    recoder.meteringEnabled = YES;
    [recoder prepareToRecord];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)recordStopButtonPressed:(id)sender {
    if(player.playing) {
        [ player stop];
    }
    
    if (!recoder.recording) {
        AVAudioSession * session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        [recoder record];
        [self.recordPauseButton setTitle:@"Pause" forState:UIControlStateNormal];
    }
    else {
        [recoder pause];
        [self.recordPauseButton setTitle:@"Record" forState:UIControlStateNormal];
    }
    self.stopButton.enabled = YES;
    self.playButton.enabled = NO;
    
}

- (IBAction)stopButtonPressd:(id)sender {
    [recoder stop];
    [[AVAudioSession sharedInstance] setActive:NO error:NULL];
}

- (IBAction)playButtonPressed:(id)sender {
    
    if (!recoder.recording) {
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:recoder.url error:NULL];
        player.meteringEnabled = YES;
        player.delegate = self;
        [player play];
        
         powerMeseringTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updatePowerValue) userInfo:nil repeats:YES];
        [powerMeseringTimer fire];
    }
    
}

-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {

    self.playButton.enabled = YES;
    self.stopButton.enabled = NO;
    
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    NSLog(@"Player did finish playing");
    [powerMeseringTimer invalidate];
}

- (void) updatePowerValue {
    CGFloat power = 0.0f;
    if (player.playing) {
        [player updateMeters];
        for (int i=0; i < [player numberOfChannels]; i++) {
            power += [player averagePowerForChannel:i];
        }
        power /= [player numberOfChannels];
      //  NewValue = (((OldValue - OldMin) * (NewMax - NewMin)) / (OldMax - OldMin)) + NewMin
        power = (((power - kMINOldPower) * (kMAXNewPower - kMINNewPower)) / (kMAXOldPower - kMINOldPower)) + kMINNewPower;
        self.powerLabel.backgroundColor = [UIColor colorWithRed:power green:power blue:power alpha:1.0];
    }
    self.powerLabel.text = [NSString stringWithFormat:@"%f",power];
}

@end
