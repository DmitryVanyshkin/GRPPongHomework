//
//  GameModelFactory.h
//  GRPPongHomework
//
//  Created by Дмитрий Ванюшкин on 11/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameModel.h"

typedef enum {
    easy,
    medium,
    hard
} DifficultLevel;

NS_ASSUME_NONNULL_BEGIN

@interface GameModelFactory : NSObject

-(GameModel*)createGameModel: (DifficultLevel) level;

@end

NS_ASSUME_NONNULL_END
