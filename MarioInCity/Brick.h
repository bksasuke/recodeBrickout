//
//  Brick.h
//  Re-codeBrickOut
//
//  Created by student on 10/22/15.
//  Copyright © 2015 Cuong Trinh. All rights reserved.
//

#import "Sprite.h"

@interface Brick : Sprite
@property (nonatomic, assign) BOOL alive1;
- (void) getImpacted;
@end
