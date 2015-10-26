//
//  Brick.m
//  Re-codeBrickOut
//
//  Created by student on 10/22/15.
//  Copyright © 2015 Cuong Trinh. All rights reserved.
//

#import "Brick.h"
#import <AVFoundation/AVFoundation.h>
@implementation Brick
{
AVAudioPlayer* audioPlayer1;
}

- (instancetype) initWithName:(NSString *)name inScene:(Scene *)scene {
    self = [super initWithName:name
                       ownView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar.png"]]
                       inScene:scene];
    return self;
}

- (void) getImpacted {
    self.alive1 =false;
    [self playSong:@"touchBrick"];
}
- (void) playSong: (NSString*) song {
    NSString* filePath = [[NSBundle mainBundle] pathForResource:song
                                                         ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSError *error;
    audioPlayer1 = [[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                         error:&error];
    [audioPlayer1 prepareToPlay];
    [audioPlayer1 play];
}
@end
