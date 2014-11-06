//
//  SlideAnimationController.h
//  Onkelinkx4cast
//
//  Created by Matthias Vermeulen on 4/11/14.
//  Copyright (c) 2014 Noizy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL isPresenting;

@end
