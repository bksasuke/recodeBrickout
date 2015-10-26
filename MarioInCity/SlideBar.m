//
//  SlideBar.m
//  Re-codeBrickOut
//
//  Created by student on 10/22/15.
//  Copyright © 2015 Cuong Trinh. All rights reserved.
//

#import "SlideBar.h"
#import <AVFoundation/AVFoundation.h>
@implementation SlideBar
{
    AVAudioPlayer *audioPlayer1;
}

- (instancetype) initWithName:(NSString *)name
                      inScene:(Scene *)scene {
    self = [super initWithName:name
                       ownView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fireleft.png"]]
                       inScene:scene];
    return self;
    
}

-(void) animate {
    
    
}


- (void) getTouched {
    [self playSong2:@"touchBrick"];
}
- (void) playSong2: (NSString*) song2 {
    NSString* filePath1 = [[NSBundle mainBundle] pathForResource:song2
                                                          ofType:@"wav"];
    NSURL *url1 = [NSURL fileURLWithPath:filePath1];
    NSError *error1;
    audioPlayer1 = [[AVAudioPlayer alloc] initWithContentsOfURL:url1
                                                          error:&error1];
    [audioPlayer1 prepareToPlay];
    [audioPlayer1 play];
}

@end
