//
//  GameModelFactory.m
//  GRPPongHomework
//
//  Created by Дмитрий Ванюшкин on 11/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import "GameModel.h"


#import "GameModelFactory.h"

@implementation GameModelFactory

-(GameModel*)createGameModel: (DifficultLevel) level
{
    GameModel* gameModel = [GameModel new];
    switch (level) {
        case easy:
            gameModel = [[GameModel alloc] init:20 ballSpeed:120 rocketWidth:100 aiCorrectness : 0.3  aiAcceleration : 0.1];
            break;
        case medium:
            gameModel = [[GameModel alloc] init:15 ballSpeed:150 rocketWidth:75 aiCorrectness : 0.6 aiAcceleration : 0.2];
            break;
        case hard:
            gameModel = [[GameModel alloc] init:10 ballSpeed:180 rocketWidth:50 aiCorrectness : 0.8  aiAcceleration : 0.3];
            break;
        default:
            break;
    }
    
    return gameModel;
}

@end
