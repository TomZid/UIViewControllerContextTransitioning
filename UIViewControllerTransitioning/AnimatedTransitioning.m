//
//  AnimatedTransitioning.m
//  UIViewControllerTransitioning
//
//  Created by tom.zhu on 18/07/2017.
//  Copyright © 2017 tom.zhu. All rights reserved.
//

#import "AnimatedTransitioning.h"

static NSString *K_ANIMATIONCOMPLITIONHANDLER = @"ANIMATIONCOMPLITIONHANDLER";

@interface AnimatedTransitioning () <CAAnimationDelegate>

@end

@implementation AnimatedTransitioning
- (void)animateLayer:(CALayer*)layer completionHandler:(void(^)(void))handler {
    NSNumber *fromNum = @0, *toNum = @0;
    if (self.transitionDirection == AnimatedTransitioinDirectionForward) {
        fromNum = @0;
        toNum = @(M_PI);
    } else {
        fromNum = @(M_PI);
        toNum = @0;
    }
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation.fromValue = fromNum;
    animation.toValue = toNum;
    animation.duration = [self transitionDuration:nil];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = YES;
    [animation setValue:handler forKey:K_ANIMATIONCOMPLITIONHANDLER];
    animation.delegate = self;
    [layer addAnimation:animation forKey:@"transform.rotation.y"];
}


#pragma mark - UIViewControllerAnimatedTransitioning
// This is used for percent driven interactive transitions, as well as for
// container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 1;
}

// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = transitionContext.containerView;
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *rotateView = nil;
    if (self.transitionDirection == AnimatedTransitioinDirectionForward) {
        rotateView = [fromViewController valueForKey:@"backView"];
        [containerView insertSubview:toViewController.view atIndex:0];
    }else {
        rotateView = [toViewController valueForKey:@"backView"];
        [containerView insertSubview:toViewController.view aboveSubview:fromViewController.view];
    }
    [self animateLayer:rotateView.layer completionHandler:^{
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    void (^handler)(void) = [anim valueForKey:K_ANIMATIONCOMPLITIONHANDLER];
    if (handler) {
        handler();
    }
}

@end

