//
//  ViewController.h
//  Onkelinkx4cast
//
//  Created by Matthias Vermeulen on 3/11/14.
//  Copyright (c) 2014 Noizy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIViewControllerTransitioningDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *datumLabel;
@property (strong, nonatomic) IBOutlet UILabel *situatieLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusUitlegLabel;
@property (strong, nonatomic) IBOutlet UIImageView *image;


@end

