//
//  ViewController.m
//  WoFiOS
//
//  Created by Tim.Milne on 2/19/15.
//  Copyright (c) 2015 Tim.Milne. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// Declare the interface outlets
@property (weak, nonatomic) IBOutlet UIButton *NewRoundButton;
@property (weak, nonatomic) IBOutlet UIButton *DingButton;
@property (weak, nonatomic) IBOutlet UIButton *BuzzButton;
@property (weak, nonatomic) IBOutlet UIButton *PuzzleSolvedButton;
@property (weak, nonatomic) IBOutlet UIButton *ApplauseButton;
@property (weak, nonatomic) IBOutlet UIButton *FinalSpinButton;
@property (weak, nonatomic) IBOutlet UIButton *DoubleBuzzButton;
@property (weak, nonatomic) IBOutlet UIButton *ThemeButton;
@property (weak, nonatomic) IBOutlet UIButton *StopButton;

// Declare an object for the audio player
@property (nonatomic, retain) AVAudioPlayer *player;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

// Play the specified sound (non blocking)
- (void)playSound:(NSString *)audioFile {

    NSString * audioFilePath = [[NSBundle mainBundle] pathForResource:audioFile ofType:@"mp3"];
    NSURL *pathAsURL = [[NSURL alloc] initFileURLWithPath:audioFilePath];
    
    // Init the audio player.
    NSError *error;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:pathAsURL error:&error];
    
    // Check out what's wrong in case that the player doesn't init.
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
        // If everything is fine, just play.
        [self.player play];
    }
}

// TPM - I could set up an NSDictionary key value pair where the key is the UIButton pointers, and the
// values the corresponding sound file.  Then the TouchUp() callback would be further simplified by
// calling the playSound method with the hash key

// One action to rule them all...
- (IBAction)TouchUp:(UIButton *)sender {
    if (sender == self.NewRoundButton) {
        [self playSound:@"wof_applause"];
    }
    else if (sender == self.DingButton) {
        [self playSound:@"wof_ding"];
    }
    else if (sender == self.BuzzButton) {
        [self playSound:@"wof_buzz"];
    }
    else if (sender == self.PuzzleSolvedButton) {
        [self playSound:@"wof_final_spin"];
        // TPM Rather than a sleep here, designate a delegate from the player class and intercept the message
        // when the file is done playing, at which point, if it is "puzzle solve", do the next two sounds in order
        sleep(2);
        [self playSound:@"wof_applause"];
        sleep(4);
        [self playSound:@"wof_theme"];
    }
    else if (sender == self.ApplauseButton) {
        [self playSound:@"wof_applause"];
    }
    else if (sender == self.FinalSpinButton) {
        [self playSound:@"wof_final_spin"];
    }
    else if (sender == self.DoubleBuzzButton) {
        [self playSound:@"wof_double_buzz"];
    }
    else if (sender == self.ThemeButton) {
        [self playSound:@"wof_theme"];
    }
    else if (sender == self.StopButton) {
        if (self.player){
            [self.player stop];
        }
        return;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
