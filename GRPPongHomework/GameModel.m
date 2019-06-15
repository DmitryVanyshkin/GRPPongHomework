//
//  GameModel.m
//  GRPPongHomework
//
//  Created by Дмитрий Ванюшкин on 11/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import "GameModel.h"


@interface GameModel()

@property (nonatomic, assign) CGSize gameFieldSize;
@property (nonatomic, assign) CGFloat ballRadius;
@property (nonatomic, assign) CGFloat ballSpeed;
@property (nonatomic, assign) CGFloat currentBallSpeed;
@property (nonatomic, assign) CGFloat rocketWidth;
@property (nonatomic, assign) CGFloat aiCorrectness;
@property (nonatomic, assign) CGFloat aiAcceleration;

@property (nonatomic, assign) CGFloat currentDirection;

@property (nonatomic, assign) CGFloat ballAngle;    //Can be from 0 to 360. Angle between horizontal axis and ball direction. Po 4asovoi strelke esli chto ugol (angle)

@property (nonatomic, assign) NSInteger playerPoints;
@property (nonatomic, assign) NSInteger opponentPoints;



@end

@implementation GameModel



-(instancetype) init: (CGFloat) ballRadius ballSpeed : (CGFloat) ballSpeed rocketWidth : (CGFloat) rocketWidth aiCorrectness : (CGFloat) aiCorrectness aiAcceleration : (CGFloat) aiAcceleration
{
    self = [super init];
    
    
    if (self)
    {
        _ballRadius = ballRadius;
        _ballSpeed = ballSpeed;
        _currentBallSpeed = ballSpeed;
        _rocketWidth = rocketWidth;
        _aiCorrectness = aiCorrectness;
        _aiAcceleration = aiAcceleration;
        _currentDirection = 1;
        _playerPoints = 0;
        _opponentPoints = 0;
        _ballAngle = 225;
    }
    
    return self;
}

-(void) setSize: (CGSize) size
{
    self.gameFieldSize = size;
}

-(CGFloat) horizontalDirection
{
    if (self.ballAngle < 90 || self.ballAngle > 270)
    {
        return -1;
    }
    
    else if (self.ballAngle == 90 || self.ballAngle == 270)
    {
        return 0;
    }
    else
    {
        return 1;
    }
}

-(CGFloat) verticalDirection
{
    if (self.ballAngle < 180)
    {
        return -1;
    }
    
    else if (self.ballAngle == 180 || self.ballAngle == 0)
    {
        return 0;
    }
    else
    {
        return 1;
    }
}

-(void) playerMakeGoal
{
    self.playerPoints++;
    self.currentBallSpeed = self.ballSpeed;
    
}

-(void) opponentMakeGoal
{
    self.opponentPoints++;
    self.currentBallSpeed = self.ballSpeed;
    
}

-(void) generateMistake
{
//    CGPoint deviation;
    
    int isMistake = arc4random() % 100;
    
    if (isMistake > self.aiCorrectness * 100)
    {
        self.currentDirection = -1;
    }
    else
    {
       self.currentDirection = 1;
    }
}

-(void) makeWallColission
{
    if (self.ballAngle < 180)
    {
        self.ballAngle = 180 - self.ballAngle;
    }
    else{
        self.ballAngle = 540 - self.ballAngle;
    }
}

-(void) checkSystemState: (CGPoint) ballPosition upperRocketPosition:(CGPoint) upperRocketPosition bottomRocketPosition:(CGPoint) bottomRocketPosition
{
    
    if (ballPosition.x - self.ballRadius <= 0 || ballPosition.x + self.ballRadius >= self.gameFieldSize.width)
    {
        [self makeWallColission];
    }
    
    if (ballPosition.y + self.ballRadius >= bottomRocketPosition.y && (ballPosition.x + self.ballRadius >= bottomRocketPosition.x && ballPosition.x - self.ballRadius <= bottomRocketPosition.x + self.rocketWidth)   )
    {
        [self makeBallAndBoardColission:ballPosition rocketPos:bottomRocketPosition];
    }
    
    else
    {
        if (ballPosition.y - self.ballRadius <= upperRocketPosition.y && (ballPosition.x + self.ballRadius >= upperRocketPosition.x && ballPosition.x - self.ballRadius <= upperRocketPosition.x + self.rocketWidth)   )
        {
            [self makeBallAndBoardColission:ballPosition rocketPos:upperRocketPosition];
        }
    }
    
}

-(BOOL) checkForGoal: (CGPoint) ballPosition upperRocketPosition:(CGPoint) upperRocketPosition bottomRocketPosition:(CGPoint) bottomRocketPosition
{
    if (ballPosition.y < upperRocketPosition.y)
    {
        [self playerMakeGoal];
        return YES;
    }
    
    if (ballPosition.y > bottomRocketPosition.y)
    {
        [self opponentMakeGoal];
        return YES;
    }
    
    return NO;
}

-(void) makeBallAndBoardColission: (CGPoint) ballCenterPos rocketPos: (CGPoint) rocketCenterPos
{
    
    if (ballCenterPos.x < rocketCenterPos.x + self.rocketWidth && ballCenterPos.x > rocketCenterPos.x)
    {

        if (self.ballAngle < 180)
        {
            self.ballAngle -= 2*(180 - (360 -  self.ballAngle));
        }
        else
        {
            self.ballAngle -= 2*(180 - (360 -  self.ballAngle));
        }
    }
    
    else
    {
        if (self.ballAngle < 180)
        {
            self.ballAngle +=180;
        }
        else
        {
            self.ballAngle -= 180;
        }
    }
    
    self.currentBallSpeed *= (1 + self.aiAcceleration);
    
}



@end
