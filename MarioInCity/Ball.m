//
//  Ball.m
//  MarioInCity
//
//  Created by Cuong Trinh on 7/27/15.
//  Copyright (c) 2015 Cuong Trinh. All rights reserved.
//

#import "Ball.h"
#import <AVFoundation/AVFoundation.h>
@implementation Ball
{
AVAudioPlayer *audioPlayer, *audioPlayer1;
}
- (instancetype) initWithName:(NSString *)name
                      inScene:(Scene *)scene {
    return self;
}

- (void) animate {
   
}
- (void) getKilled {
    self.alive = false;
    [self playSong:@"die"];
}

- (void) playSong: (NSString*) song {
    NSString* filePath = [[NSBundle mainBundle] pathForResource:song
                                                         ofType:@"wav"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                         error:&error];
    [audioPlayer prepareToPlay];
    [audioPlayer play];
}


@end
