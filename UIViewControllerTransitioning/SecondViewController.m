//
//  SecondViewController.m
//  UIViewControllerTransitioning
//
//  Created by tom.zhu on 18/07/2017.
//  Copyright © 2017 tom.zhu. All rights reserved.
//

#import "SecondViewController.h"
#import "AnimatedTransitioning.h"

@interface SecondViewController () <UINavigationControllerDelegate>

@end

@implementation SecondViewController
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    AnimatedTransitioning *at = [AnimatedTransitioning new];
    if (operation == UINavigationControllerOperationPop) {
        at.transitionDirection = AnimatedTransitioinDirectionBackward;
    }
    return at;
}

@end
