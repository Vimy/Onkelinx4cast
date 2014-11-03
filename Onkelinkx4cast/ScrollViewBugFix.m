//
//  ScrollViewBugFix.m
//  Onkelinkx4cast
//
//  Created by Matthias Vermeulen on 3/11/14.
//  Copyright (c) 2014 Noizy. All rights reserved.
//

#import "ScrollViewBugFix.h"

@implementation ScrollViewBugFix

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


 - (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    NSLog(@"happens");
    return YES;
}



@end
