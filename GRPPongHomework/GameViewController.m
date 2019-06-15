//
//  GameViewController.m
//  GRPPongHomework
//
//  Created by Дмитрий Ванюшкин on 11/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import "GameViewController.h"
#import "RocketView.h"
#import "BallView.h"

@interface GameViewController ()

@property (nonatomic, strong) RocketView *playerRocket;
@property (nonatomic, strong) RocketView *opponentRocket;
@property (nonatomic, strong) BallView* ballView;
@property (nonatomic, strong) UIView *gameView;
@property (nonatomic, strong) GameModel* model;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat timeTick;
@property (nonatomic, assign) BOOL isWithAI;

@property (nonatomic, strong) UILabel* playerPointsLabel;
@property (nonatomic, strong) UILabel* opponentPointsLabel;

@end

@implementation GameViewController

-(instancetype) initWithModel: (GameModel*) model isWithAI: (BOOL) isWithAI
{
    self = [super init];
    
    if (self)
    {
        _model = model;
        _isWithAI = isWithAI;
        self.timeTick = 0.0001;
        
    }
    
    return self;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.playerRocket = [[RocketView alloc] initWith: self.model.rocketWidth height:20 color:UIColor.redColor];
    self.opponentRocket = [[RocketView alloc] initWith: self.model.rocketWidth height:20 color:UIColor.blueColor];
    self.gameView = [UIView new];
    self.ballView = [[BallView alloc]initWithRadius:self.model.ballRadius];
    
    
    [self.view addSubview:_gameView];
    
    [self.gameView addSubview:self.playerRocket];
    [self.gameView addSubview:self.opponentRocket];
    [self.gameView addSubview:self.ballView];
    
    
    [self setConstraints];
    
    self.playerPointsLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.gameView.frame), CGRectGetMidY(self.view.frame) + CGRectGetHeight(self.view.frame) / 4, 100 , 30)];
    
    self.opponentPointsLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.gameView.frame), CGRectGetMidY(self.view.frame) - CGRectGetHeight(self.view.frame) / 3 - 30, 100 , 30)];
    
    self.playerPointsLabel.layer.zPosition = -1;
    self.opponentPointsLabel.layer.zPosition = - 1;
    
    self.playerPointsLabel.text = [NSString stringWithFormat:@"%ld", (long)self.model.playerPoints];
    self.opponentPointsLabel.text = [NSString stringWithFormat:@"%ld", (long)self.model.opponentPoints];
    
    [self.gameView addSubview:self.playerPointsLabel];
    [self.gameView addSubview:self.opponentPointsLabel];
    
    self.playerRocket.center = CGPointMake(self.gameView.center.x, self.gameView.frame.size.height - 100 );
    self.opponentRocket.center = CGPointMake(self.gameView.center.x, 10);
    self.ballView.center = self.gameView.center;
    self.opponentRocket.userInteractionEnabled = !self.isWithAI;
    
    [self.model setSize: CGSizeMake(CGRectGetMaxX(self.gameView.frame), CGRectGetMaxY(self.gameView.frame))];
    [self setupTimer];
    
    // Do any additional setup after loading the view.
}

-(void) setConstraints
{
    self.gameView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.gameView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [self.gameView.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor].active = YES;
    [self.gameView.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor].active = YES;
    [self.gameView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
    
    [self.view layoutIfNeeded];
    
}

-(void)setupTimer
{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeTick target:self selector:@selector(timerTick) userInfo:nil repeats:YES];
    self.timer.tolerance = 0.01;
    
}

-(void)timerTick
{
    
    CGPoint upperCoord = CGPointMake(CGRectGetMinX(self.opponentRocket.frame), CGRectGetMaxY(self.opponentRocket.frame));
    
    CGPoint bottomCoord = CGPointMake(CGRectGetMinX(self.playerRocket.frame), CGRectGetMinY(self.playerRocket.frame));
    
    
    
   BOOL result = [self.model checkForGoal:self.ballView.center upperRocketPosition:upperCoord bottomRocketPosition:bottomCoord];
    
    if (result)
    {
        self.ballView.center = self.gameView.center;
        self.playerPointsLabel.text = [NSString stringWithFormat:@"%ld", (long)self.model.playerPoints];
        self.opponentPointsLabel.text = [NSString stringWithFormat:@"%ld", (long)self.model.opponentPoints];
    }
    
    else
    {
        [self.model checkSystemState:self.ballView.center upperRocketPosition: upperCoord bottomRocketPosition:bottomCoord];
    }
    
    CGFloat horizontalRotation = self.model.horizontalDirection;
    CGFloat verticalRotation = self.model.verticalDirection;
    CGFloat delta = self.model.currentBallSpeed * self.timeTick;
    
    
    

    
    if (!self.opponentRocket.isUserInteractionEnabled)
    {
        self.opponentRocket.center = CGPointMake( self.opponentRocket.center.x + horizontalRotation * delta * self.model.aiCorrectness, self.opponentRocket.center.y);
    }
    
    self.ballView.center = CGPointMake(self.ballView.center.x + horizontalRotation * delta, self.ballView.center.y + verticalRotation * delta);

    
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
