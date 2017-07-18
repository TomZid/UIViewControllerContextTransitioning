//
//  ViewController.m
//  UIViewControllerTransitioning
//
//  Created by tom.zhu on 18/07/2017.
//  Copyright © 2017 tom.zhu. All rights reserved.
//

#import "ViewController.h"
#import "AnimatedTransitioning.h"

@interface ViewController () <UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *backView;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1 / 100.f;
    self.view.layer.sublayerTransform = transform;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    AnimatedTransitioning *at = [AnimatedTransitioning new];
    if (operation == UINavigationControllerOperationPush) {
        at.transitionDirection = AnimatedTransitioinDirectionForward;
    }
    return at;
}

@end
