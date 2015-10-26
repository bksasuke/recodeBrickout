//
//  MainScene.m
//  MarioInGalaxy
//
//  Created by Cuong Trinh on 7/27/15.
//  Copyright (c) 2015 Cuong Trinh. All rights reserved.
//

#import "MainScene.h"
#import "Sprite.h"
#import "SlideBar.h"
#import "Galaxy.h"
#import "Ball.h"
#import "Brick.h"

@implementation MainScene
{
    Galaxy *galaxy;
    Ball *ball;
    SlideBar *bar;
    CGSize galaxySize;

    NSMutableArray *bricks;
    CGFloat x, y, maxHeight, maxWidth, ballRadius, brickWidth,brickHeight;
    CGFloat _vX, _vY,barHalfWidth;
    int columns,rows;
    BOOL rungame;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    CGFloat statusNavigationBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.bounds.size.height;
    
    self.size = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height - statusNavigationBarHeight);
    [self addGalaxy];
    [self addBrick];
    [self applyGesture];
    
        ball = [[Ball alloc] initWithName:@"Ball1"
                                  ownView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ballBlue"]]  //Add ball to Scene
                                  inScene:self];
        ball.view.frame = CGRectMake(self.view.bounds.size.width*0.5, self.view.bounds.size.height-118, 18, 18);
        [self addSprite:ball];
    
    //Configure default velocity. Need to randomize it
    _vX = -0.75;
    _vY = -1;
    barHalfWidth = bar.view.frame.size.width*0.5;
    //add brick
     rungame = false;

timer1 = [NSTimer scheduledTimerWithTimeInterval:.1
                                             target:self
                                           selector:@selector(gameloop)
                                           userInfo:nil
                                        repeats:true];
    
}
-(BOOL)checkballrun {

    if (rungame==true) {
        
        
        timer = [NSTimer scheduledTimerWithTimeInterval:.1
                                                 target:self
                                               selector:@selector(animateBall)
                                               userInfo:nil
                                                repeats:true];
        return true;
    }
    [timer invalidate];
    timer =nil ;
    return false;
    
}


- (void)applyGesture { //add bar to scene; create link of Pan gesture and bar;
    UIImage* barimage = [UIImage imageNamed:@"bar"];
    bar = [[SlideBar alloc] initWithName:@"bar"
                                 ownView:[[UIImageView alloc] initWithImage:barimage]
                                 inScene:self];
    
    bar.view.userInteractionEnabled =true;
    bar.view.multipleTouchEnabled =true;
    bar.view.frame = CGRectMake(self.view.bounds.size.width*0.5-18, self.view.bounds.size.height-100, 70, 15);
    [self.view addSubview:bar.view];
    UIPanGestureRecognizer * onDrag = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(onsPan:)];
    onDrag.minimumNumberOfTouches = 1;
 
    [bar.view addGestureRecognizer:onDrag];
}
- (void)onsPan:(UIPanGestureRecognizer *)pan {
   
    bar.view.center = [pan locationInView:bar.view.superview];
    rungame =true;
    
}

-(BOOL)animateBall {

    if (rungame ==true) {
        
    
    CGFloat newX = ball.view.center.x + _vX;
    CGFloat newY = ball.view.center.y + _vY;
    if (newX < ballRadius || newX > galaxySize.width-ballRadius) {
        _vX =-_vX; //Đập tường trái, phải
    }
    if (newY<ballRadius) { //Đập trên cùng
        _vY=-_vY;
    }
    if (newY > galaxySize.height - ballRadius ) {
        _vY =-_vY; // dap vao tuong duoi gameover
        
         [self gameOver];
        self.view.backgroundColor = [UIColor blackColor];
        
    }
    if (newX <bar.view.center.x +barHalfWidth &&
        newX >= bar.view.center.x - barHalfWidth &&
        _vY > 0                           &&
        newY + ballRadius >= bar.view.center.y - bar.view.bounds.size.height * 0.5) {
        _vY=-_vY;
        _vX= _vX*.5;
    }
    newX =ball.view.center.x +_vX;
    newY =ball.view.center.y +_vY;
    ball.view.center = CGPointMake(newX,newY);
        return true;
    }   return false;
}

-(void)gameOver {
   
   UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GameOver.png"]];

    view.center = CGPointMake(self.size.width * 0.5, -view.bounds.size.height * 0.5);
    [self.view addSubview:view];
    
    [UIView animateWithDuration:2 animations:^{
       view.center = CGPointMake(self.size.width * 0.5, self.size.height * 0.5);
    } completion:^(BOOL finished) {
        
    }];
    
    [galaxy.view removeFromSuperview];
            [ball getKilled];
    [ball.view removeFromSuperview];
    rungame =false;
     _vX= _vY=0;
    [timer1 invalidate];
    timer1 = nil;
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game over" message:@"To play again click button"
                                                   delegate:self cancelButtonTitle:@"End game"
                                          otherButtonTitles:@"Re-Play", nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){ // End game. Back to mainboard...
        
    }
    if (buttonIndex == 1){  //Replay game ...
       // galaxy.view.hidden =NO;
        [self restartGame ];
    }
}
-(void)restartGame {
    [galaxy.view removeFromSuperview ];
    [bar.view removeFromSuperview ];
    [ball.view removeFromSuperview];
   
    [self viewDidLoad];
    
}

- (void) addGalaxy {
    galaxySize = CGSizeMake(self.view.bounds.size.width,self.view.bounds.size.height);
    UIImage* galaxybackground = [UIImage imageNamed:@"galaxy"];
    galaxy = [[Galaxy alloc] initWithName:@"galaxy"
                                  ownView:[[UIImageView alloc] initWithImage:galaxybackground]
                                  inScene:self];
    galaxy.view.frame = CGRectMake(0, 0, galaxySize.width, galaxySize.height);
    
    [self.view addSubview:galaxy.view];
    printf("Devide size :Width %3.0f - Height: %3.0f",galaxySize.width,galaxySize.height);
    
}

-(void)addBrick {
    
    CGFloat topBrickWall =60;
    CGFloat hMargin = 25;
    CGFloat vMargin = 15;
    brickWidth = 40;
    brickHeight = 10;
    bricks = [[NSMutableArray alloc] initWithCapacity:100];
  
    int i=0;
 
    while (i< 0.5*(galaxySize.height-2*hMargin)/(brickHeight+ hMargin)) {
        int j=0;
        
        while (j <(galaxySize.width-2*vMargin)/(brickWidth + vMargin)-1) {
           
            
            
            Brick *brick = [[Brick alloc] initWithName:[NSString stringWithFormat:@"brick%d",j+i]
                                               inScene:self];
            j++;
            brick.view.frame = CGRectMake((brickWidth+vMargin)*j-25, (brickHeight +hMargin)*i +topBrickWall,brickWidth,brickHeight);
            [galaxy.view addSubview:brick.view];
            [bricks addObject:brick.view];
        }i++;
    }
}

-(BOOL) checkCollisionBetweenBallAndBricks {
    
    for (int i = 0; i < bricks.count; i++) {
        UIView* brick  = (UIView*)bricks[i];
        
        
        if (CGRectIntersectsRect(brick.frame, ball.view.frame)){
     
            _vY=_vY*-1;
           
           [brick removeFromSuperview];
            [bricks removeObject:brick];
            [bar getTouched];
            return true;
        }
        
    }
    return false;
}


- (void) gameloop {
    
    for (Sprite *sprite in self.sprites.allValues) {
        [sprite animate];
    }
    [self checkCollisionBetweenBallAndBricks];
    [self checkballrun];
}


@end
