//
//  OptionsViewController.m
//  backgamon
//
//  Created by maxeler on 1/26/17.
//  Copyright © 2017 maxeler. All rights reserved.
//

#import "OptionsViewController.h"
#import "UINavigationController+ShowViewController.h"
#import "ViewController.h"

@interface OptionsViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property UIImageView *background;

@property UIPickerView *redBotDif;
@property UIPickerView *whiteBotDif;
@property UIPickerView *gameLength;

@end

@implementation OptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Options";
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.bounds.size.height-74;
    
    self.background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    self.background.image = [UIImage imageNamed:@"felt"];
    [self.view addSubview:self.background];
    
    self.redBotDif = [[UIPickerView alloc] initWithFrame:CGRectMake(width/2, height/5-100, width/4, 150)];
    self.redBotDif.delegate = self;
    self.redBotDif.dataSource = self;
    [self.view addSubview:self.redBotDif];
    
    self.whiteBotDif = [[UIPickerView alloc] initWithFrame:CGRectMake(width/2, 2*height/5-100, width/4, 150)];
    self.whiteBotDif.delegate = self;
    self.whiteBotDif.dataSource = self;
    [self.view addSubview:self.whiteBotDif];
    
    self.gameLength = [[UIPickerView alloc] initWithFrame:CGRectMake(width/2, 3*height/5-100, width/4, 150)];
    self.gameLength.delegate = self;
    self.gameLength.dataSource = self;
    [self.view addSubview:self.gameLength];
    
    UILabel *redLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/4, height/5-100, width/4, 150)];
    redLabel.text = @"Red Player Type:";
    redLabel.textAlignment = NSTextAlignmentCenter;
    redLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:redLabel];
    
    UILabel *whiteLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/4, 2*height/5-100, width/4, 150)];
    whiteLabel.text = @"White Player Type:";
    whiteLabel.textAlignment = NSTextAlignmentCenter;
    whiteLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:whiteLabel];
    
    UILabel *lengthLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/4, 3*height/5-100, width/4, 150)];
    lengthLabel.text = @"Game Length:";
    lengthLabel.textAlignment = NSTextAlignmentCenter;
    lengthLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:lengthLabel];
    
    UIButton *start = [[UIButton alloc] initWithFrame:CGRectMake(width/2-100, 4*height/5-100, 200, 100)];
    [start setTitle:@"Start" forState:UIControlStateNormal];
    [start addTarget:self action:@selector(startClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:start];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 6;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView == self.gameLength) {
        NSArray *gamelengths = @[@(1), @(3), @(5), @(7), @(11), @(15)];
        
        return [NSString stringWithFormat:@"%@", gamelengths[row]];
    }
    
    if(row == 0) {
        return @"Player";
    }
    
    return [NSString stringWithFormat:@"Bot with %ld tree depth", row];
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title;
    
    if(pickerView == self.gameLength) {
        NSArray *gamelengths = @[@(1), @(3), @(5), @(7), @(11), @(15)];
        
        title = [NSString stringWithFormat:@"%@", gamelengths[row]];
    } else if(row == 0) {
        title =  @"Player";
    } else {
        title =  [NSString stringWithFormat:@"Bot with %ld tree depth", row];
    }

    NSAttributedString *attString =
    [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    return attString;
}

-(void)startClicked;
{
    ViewController *view = (ViewController *) [self.navigationController showViewControllerWithClass:[ViewController class] animated:YES];
    view.redBotDif = [self.redBotDif selectedRowInComponent:0];
    view.whiteBotDif = [self.whiteBotDif selectedRowInComponent:0];
    
    NSArray *gamelengths = @[@(1), @(3), @(5), @(7), @(11), @(15)];
    view.gameLength = [gamelengths[[self.gameLength selectedRowInComponent:0]] integerValue];
}

@end
