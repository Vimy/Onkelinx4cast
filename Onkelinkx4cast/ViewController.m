//
//  ViewController.m
//  Onkelinkx4cast
//
//  Created by Matthias Vermeulen on 3/11/14.
//  Copyright (c) 2014 Noizy. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "HamburgerViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *buttonListScrollView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.buttonListScrollView.userInteractionEnabled = YES;
    self.buttonListScrollView.scrollEnabled = YES;
    int x = 0;
    int y = 0;
    int count = 8;

    self.buttonListScrollView.contentSize = CGSizeMake(700, 0);

  //  self.buttonListScrollView.panGestureRecognizer.delaysTouchesBegan = self.buttonListScrollView.delaysContentTouches;
  
    for (int i = 1; count > i; i++)
    {
      
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button addTarget:self action:@selector(switchView) forControlEvents:UIControlEventTouchDown];
        NSString *string = [NSString stringWithFormat:@"hoi%d", i];
        [button setTitle:string forState:UIControlStateNormal];
        button.Frame = CGRectMake(x,0, 100, 100);
        //button.imageView.image = [UIImage imageNamed:@"graybox.jpg"];
        button.layer.borderWidth = 1.0f;
        button.layer.borderColor = [[UIColor blackColor] CGColor];
        [self.buttonListScrollView addSubview:button];
         NSLog(@"int %d",x);
        x += button.frame.size.width;
        NSLog(@"int %d",x);
    }
    
    
 
    
}
- (IBAction)slideMenuButton:(UIButton *)sender
{
    
    NSLog(@"Hoi - Hamburger");
    HamburgerViewController *burger = [self.storyboard instantiateViewControllerWithIdentifier:@"hamburger"];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:transition forKey:nil];
    
    
    [self presentViewController:burger animated:YES completion:nil];
    
}

- (void)switchView
{
    NSLog(@"Hoi");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
