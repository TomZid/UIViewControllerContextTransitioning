//
//  AnimatedTransitioning.h
//  UIViewControllerTransitioning
//
//  Created by tom.zhu on 18/07/2017.
//  Copyright © 2017 tom.zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AnimatedTransitioinDirection) {
    AnimatedTransitioinDirectionForward,
    AnimatedTransitioinDirectionBackward,
};

@interface AnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic) AnimatedTransitioinDirection transitionDirection;
@end
