//
//  ViewController.m
//  TextFieldAnimationHack
//
//  Created by Daniel Hammond on 1/6/15.
//  Copyright (c) 2015 Sparks Labs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) BOOL highlighted;
@property (nonatomic, weak, readonly) UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITextField *textField = [UITextField new];
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    textField.text = @"foobar";
    [self.view addSubview:textField];
    _textField = textField;
    
    UIButton *change = [UIButton buttonWithType:UIButtonTypeSystem];
    change.translatesAutoresizingMaskIntoConstraints = NO;
    [change setTitle:@"Toggle" forState:UIControlStateNormal];
    [change addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:change];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(textField, change);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[textField]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[change]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[textField]-20-[change]" options:0 metrics:nil views:views]];
}

- (void)buttonAction
{
    self.highlighted = !self.highlighted;
}

- (void)setHighlighted:(BOOL)highlighted
{
    _highlighted = highlighted;
    UIView *snapshot = [self.textField resizableSnapshotViewFromRect:self.textField.bounds afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
    [self.view addSubview:snapshot];
    snapshot.frame = self.textField.frame;
    self.textField.textColor = highlighted ? [UIColor redColor] : [UIColor blackColor];
    [UIView animateWithDuration:0.4 animations:^{
        snapshot.alpha = 0;
    } completion:^(BOOL finished) {
        [snapshot removeFromSuperview];
    }];
}

@end
