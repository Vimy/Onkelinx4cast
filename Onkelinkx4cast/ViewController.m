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
#import "ButtonView.h"
#import "SlideAnimationController.h"
#import "OnkelinxViewViewController.h"



#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *buttonListScrollView;
@property (strong, nonatomic) IBOutlet UIImageView *imageOnky;
@property (strong, nonatomic) SlideAnimationController  *animator;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.animator = [SlideAnimationController new];
    
    self.buttonListScrollView.userInteractionEnabled = YES;
    self.buttonListScrollView.scrollEnabled = YES;
    int x = 0;
    int count = 7;

    self.buttonListScrollView.contentSize = CGSizeMake(700, 0);
 
  
    OnkelinxViewViewController *onkyVC =  [self.storyboard instantiateViewControllerWithIdentifier:@"OnkelinxView"];
    [self addChildViewController:onkyVC];
    onkyVC.view.frame = self.containerView.bounds;
    [self.containerView addSubview:onkyVC.view];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd/MM"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    NSDateFormatter *weekdayFormatter = [[NSDateFormatter alloc]init];
    [weekdayFormatter setDateFormat:@"E"];
    NSString *weekday = [weekdayFormatter stringFromDate:date];
    
    if ([weekday isEqualToString:@"Thu"])
    {
        onkyVC.view.backgroundColor = [UIColor redColor];
        onkyVC.statusUitlegLabel.text = @"Vandaag is de kamer in sessie. Verwacht u aan een hevige Onkelinx storm!";
        onkyVC.situatieLabel.text = @"ALARM";
        onkyVC.profileImageView.image = [UIImage imageNamed:@"onky2.jpg"];
        
        onkyVC.datumLabel.text = [NSString stringWithFormat:@"Datum: %@", dateString];
        self.view.backgroundColor = [UIColor redColor];

    }
    
    
    
    
  //  NSLog(@"Date %@", dateString);
    
    
    
    for (int i = 0; count > i; i++)
    {
 
        NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
        dayComponent.day = 1;
        NSCalendar *theCalendar = [NSCalendar currentCalendar];
        NSDate *nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:date options:0];
        NSString *nextDateString = [dateFormatter stringFromDate:nextDate];
       // NSLog(@"nextDate: %@", nextDateString   );
        
    
        NSString *weekday = [weekdayFormatter stringFromDate:date];
        NSLog(@"Date & weekday: %@ %@", dateString, weekday );
        
     
        NSArray *buttonArray = [[NSBundle mainBundle] loadNibNamed:@"Button" owner:nil options:nil];
        ButtonView *button = buttonArray[0];
        button.buttonDayLabel.text = weekday;
        button.buttonDateLabel.text = dateString;
        button.frame = CGRectMake(x, 0, 100, 100);
        x += button.frame.size.width;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappedStatusButton:)];
        tap.delegate = self;
        [button addGestureRecognizer:tap];
        //#F69686
        button.backgroundColor = [weekday isEqualToString:@"Thu"] ? [UIColor redColor]: button.backgroundColor;
        
        
        [self.buttonListScrollView addSubview:button];
        date = nextDate;
        dateString = nextDateString;
        
    }
    
    
 
    
}

- (void)tappedStatusButton:(UITapGestureRecognizer *)sender
{
    ButtonView *button = sender.view;
    
    
    NSLog(@"De tap werkt, datum: %@", button.buttonDateLabel.text);
    //  NSLog(@"Biertap???");
    //  NSLog(@"Nee, mong");
    //  NSLog(@"3/10");
    
    OnkelinxViewViewController *onkyVC =  [self.storyboard instantiateViewControllerWithIdentifier:@"OnkelinxView"];
    UIViewController *vc = self.childViewControllers[0];

    if ([button.buttonDayLabel.text isEqualToString:@"Thu"])
    {
        onkyVC.view.backgroundColor = [UIColor redColor];
        onkyVC.statusUitlegLabel.text = @"Vandaag is de kamer in sessie. Verwacht u aan een hevige Onkelinx storm!";
        onkyVC.situatieLabel.text = @"ALARM";
         onkyVC.profileImageView.image = [UIImage imageNamed:@"onky2.jpg"];
        self.view.backgroundColor = [UIColor redColor];
    }
    NSLog(@"Datum: %@", button.buttonDateLabel.text);
    self.view.backgroundColor = onkyVC.view.backgroundColor;
    onkyVC.datumLabel.text = [NSString stringWithFormat:@"Datum: %@", button.buttonDateLabel.text];
     [self swapFromViewController:vc toViewController:onkyVC];
    
}



- (void)swapFromViewController:(UIViewController *)oldVC toViewController:(UIViewController *)newVC
{
    newVC.view.frame = oldVC.view.frame;
    [oldVC willMoveToParentViewController:nil];
    [self addChildViewController:newVC];
    [self transitionFromViewController:oldVC toViewController:newVC duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft   animations:^{
        
    } completion:^(BOOL finished){
        [oldVC removeFromParentViewController];
        [newVC didMoveToParentViewController:self];
    }];

}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    HamburgerViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"hamburger"];
    toViewController = segue.destinationViewController;
    toViewController.transitioningDelegate = self;
    
    
}

- (IBAction)slideMenuButton:(UIButton *)sender
{
    
  
    HamburgerViewController *burger = [self.storyboard instantiateViewControllerWithIdentifier:@"hamburger"];
    if (burger)
    {
        NSLog(@"Burger is go");
    }
    burger.transitioningDelegate = self;
    
    [self presentViewController:burger animated:YES completion:nil];
    
    //[self transitionToViewcontroller:burger comingFromLeft:YES];
    
 // http://stackoverflow.com/questions/11412467/dismissmodalviewcontroller-with-transition-left-to-right
}

/*
- (void)transitionToViewcontroller:(UIViewController *)vc comingFromLeft:(BOOL)isFromLeft
{
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.35;
    transition.timingFunction =
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    
    transition.subtype = isFromLeft ? kCATransitionFromLeft : kCATransitionFromRight;

    
    // NSLog(@"%s: self.view.window=%@", _func_, self.view.window);
    UIView *containerView = self.view.window;
    [containerView.layer addAnimation:transition forKey:nil];
    //[self presentModalViewController:burger animated:NO];
    [self presentViewController:vc animated:NO completion:nil];

    
}
- (void)switchView
{
    NSLog(@"Hoi");
    
    ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    [self presentViewController:vc animated:YES completion:nil];
}
*/

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.animator.isPresenting = YES;
    return self.animator;
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.animator.isPresenting = NO;
    return self.animator;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
