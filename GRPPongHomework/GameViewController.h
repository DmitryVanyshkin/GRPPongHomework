//
//  GameViewController.h
//  GRPPongHomework
//
//  Created by Дмитрий Ванюшкин on 11/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameViewController : UIViewController

-(instancetype) initWithModel: (GameModel*) model isWithAI: (BOOL) isWithAI;

@end

NS_ASSUME_NONNULL_END
