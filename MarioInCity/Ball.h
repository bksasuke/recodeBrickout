//
//  Ball.h
//  MarioInCity
//
//  Created by Cuong Trinh on 7/27/15.
//  Copyright (c) 2015 Cuong Trinh. All rights reserved.
//

#import "Sprite.h"

@interface Ball : Sprite

@property (nonatomic, assign) CGFloat ballRadius;
@property (nonatomic, assign) BOOL alive;
@property (nonatomic, weak) Sprite* fromSprite;
- (void) getKilled;

@end
