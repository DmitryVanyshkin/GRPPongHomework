//
//  RocketView.m
//  GRPPongHomework
//
//  Created by Дмитрий Ванюшкин on 11/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import "RocketView.h"

@interface  RocketView()

@property CGFloat xDeviation;


@end


@implementation RocketView

-(instancetype) initWith:(CGFloat) width height : (CGFloat) height color : (UIColor*) color
{
    self = [super initWithFrame:CGRectMake(0, 0, width, height)];
    
    if (self)
    {
        self.backgroundColor = color;
    }
    
    return self;
    
}

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *currentTouch = touches.anyObject;
    CGPoint coordinatesInTouch = [currentTouch locationInView: self.superview];
    [self countXDeviationFromCenter: self.center.x ourX:coordinatesInTouch.x];
    
}

-(void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *currentTouch = touches.anyObject;
    CGPoint coordinatesInTouch = [currentTouch locationInView: self.superview];
    
    CGPoint correctedCoordinateCenter = CGPointMake(coordinatesInTouch.x - [self xDeviation],self.center.y);
    
    self.center = correctedCoordinateCenter;
    
}

-(void) countXDeviationFromCenter:(CGFloat)centerX ourX:(CGFloat)xCoordinate
{
    
    [self setXDeviation:xCoordinate - centerX];
    
}

@end
