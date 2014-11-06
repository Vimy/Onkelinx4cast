//
//  SlideAnimationController.m
//  Onkelinkx4cast
//
//  Created by Matthias Vermeulen on 4/11/14.
//  Copyright (c) 2014 Noizy. All rights reserved.
//

#import "SlideAnimationController.h"

@implementation SlideAnimationController


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1;
    
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *container = transitionContext.containerView;
    
    CGAffineTransform offScreenRight = CGAffineTransformMakeTranslation(container.frame.size.width, 0);
    CGAffineTransform offScreenLeft = CGAffineTransformMakeTranslation(-container.frame.size.width, 0);
    
    
    
    
    [container addSubview:toViewController.view];
    toViewController.view.alpha = 0;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromViewController.view.transform = offScreenLeft;
    } completion:^(BOOL finished) {
        fromViewController.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:[transitionContext transitionWasCancelled]];
    }];
    
    
}



@end
