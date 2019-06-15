//
//  BallView.m
//  GRPPongHomework
//
//  Created by Дмитрий Ванюшкин on 11/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import "BallView.h"

@implementation BallView

-(instancetype)initWithRadius:(CGFloat) radius
{
    self = [super initWithFrame:CGRectMake(0, 0, radius*2, radius*2)];
    
    if (self)
    {
        self.layer.cornerRadius = radius;
        self.backgroundColor = UIColor.orangeColor;
    }
    
    return self;
}

@end
