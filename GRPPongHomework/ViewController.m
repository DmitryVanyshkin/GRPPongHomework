//
//  ViewController.m
//  GRPPongHomework
//
//  Created by Дмитрий Ванюшкин on 11/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import "ViewController.h"
#import "GameViewController.h"
#import "GameModelFactory.h"



@interface ViewController ()

@property (nonatomic, strong) UIButton* easyButton;
@property (nonatomic, strong) UIButton* mediumButton;
@property (nonatomic, strong) UIButton* hardButton;
@property (nonatomic, strong) UIButton* pvpButton;
@property (nonatomic, strong) UIStackView* stackView;  //Lesha, pls don't hate me for this

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationController.navigationBar  setHidden:YES];
    
    [self loadStackViewAndButtons];
    // Do any additional setup after loading the view.
}

-(void) loadStackViewAndButtons
{
    self.easyButton = [UIButton new];
    [self.easyButton setTitle:@"Easy" forState:UIControlStateNormal];
    self.easyButton.backgroundColor = UIColor.greenColor;
    [self.easyButton addTarget:self action:@selector(openGame:) forControlEvents: UIControlEventTouchUpInside];
    
    
    self.mediumButton = [UIButton new];
    [self.mediumButton setTitle:@"Medium" forState:UIControlStateNormal];
    self.mediumButton.backgroundColor = UIColor.blueColor;
    [self.mediumButton addTarget:self action:@selector(openGame:) forControlEvents: UIControlEventTouchUpInside];
    
    self.hardButton = [UIButton new];
    [self.hardButton setTitle:@"Hard" forState:UIControlStateNormal];
    self.hardButton.backgroundColor = UIColor.redColor;
    [self.hardButton addTarget:self action:@selector(openGame:) forControlEvents: UIControlEventTouchUpInside];
    
    self.pvpButton = [UIButton new];
    [self.pvpButton setTitle:@"2 players" forState:UIControlStateNormal];
    self.pvpButton.backgroundColor = UIColor.purpleColor;
    [self.pvpButton addTarget:self action:@selector(openGame:) forControlEvents: UIControlEventTouchUpInside];
    
    NSArray *buttonsArray = [NSArray arrayWithObjects:self.easyButton, self.mediumButton, self.hardButton, self.pvpButton, nil];
    
    self.stackView = [[UIStackView alloc] initWithArrangedSubviews: buttonsArray];
    
    self.stackView.alignment = UIStackViewAlignmentFill;
    self.stackView.distribution = UIStackViewDistributionFillEqually;
    self.stackView.axis = UILayoutConstraintAxisVertical;
    self.stackView.spacing = 30;
    
    [self.view addSubview: self.stackView];
    
    self.stackView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame) / 1.5,  CGRectGetHeight(self.view.frame) / 2);
    
    self.stackView.center = self.view.center;
    
}

-(void) openGame: (UIButton*) sender
{
    DifficultLevel level = easy;
    BOOL isWithAI = false;
    
    if (sender == _easyButton)
    {
        level = easy;
        isWithAI = YES;
    }
  
    if (sender == _mediumButton)
    {
        level = medium;
        isWithAI = YES;
    }

    if (sender == _hardButton)
    {
        level = hard;
        isWithAI = YES;
    }
    
    if (sender == _pvpButton)
    {
        level = medium;
        isWithAI = NO;
    }
    
    GameModelFactory* factory = [GameModelFactory new];
    
    GameModel* model = [factory createGameModel:level];
    
    GameViewController *gameVC = [[GameViewController alloc]initWithModel:model isWithAI: isWithAI];
    
    [self.navigationController pushViewController:gameVC animated:YES];
    

}

@end
