//
//  GameModel.h
//  GRPPongHomework
//
//  Created by Дмитрий Ванюшкин on 11/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GameModel : NSObject

@property (nonatomic, readonly) CGFloat ballRadius;
@property (nonatomic, readonly) CGFloat ballSpeed;
@property (nonatomic, readonly) CGFloat rocketWidth;
@property (nonatomic, readonly) CGFloat aiCorrectness;
@property (nonatomic, readonly) NSInteger playerPoints;
@property (nonatomic, readonly) NSInteger opponentPoints;
@property (nonatomic, readonly) CGFloat aiAcceleration;

@property (nonatomic, readonly) CGFloat currentDirection;
@property (nonatomic, readonly) CGFloat currentBallSpeed;

@property (nonatomic, readonly) CGFloat horizontalDirection;        //Computable propeties
@property (nonatomic, readonly) CGFloat verticalDirection;

-(void) generateMistake;

-(instancetype) init: (CGFloat) ballRadius ballSpeed : (CGFloat) ballSpeed rocketWidth : (CGFloat) rocketWidth aiCorrectness : (CGFloat) aiCorrectness aiAcceleration : (CGFloat) aiReactionPing;
-(void) checkSystemState: (CGPoint) ballPosition upperRocketPosition:(CGPoint) upperRocketPosition bottomRocketPosition:(CGPoint) bottomRocketPosition;

-(BOOL) checkForGoal: (CGPoint) ballPosition upperRocketPosition:(CGPoint) upperRocketPosition bottomRocketPosition:(CGPoint) bottomRocketPosition;

-(void) setSize: (CGSize) size;

@end

NS_ASSUME_NONNULL_END
