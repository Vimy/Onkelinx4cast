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
    self.statusUitlegLabel.text = @"Het parlement komt niet samen vandaag. Er is geen reden tot ongerustheid!";
  //  self.buttonListScrollView.panGestureRecognizer.delaysTouchesBegan = self.buttonListScrollView.delaysContentTouches;
  
    
    self.image.clipsToBounds = YES;
  //  self.image.layer.cornerRadius = self.image.frame.size.width/2;
    self.image.layer.borderWidth = 1.0f;
    self.image.layer.borderColor = [UIColor whiteColor].CGColor;
    
  
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd/MM"];
    NSString *dateString = [dateFormatter stringFromDate:date];
  //  NSLog(@"Date %@", dateString);
    
    
    
    for (int i = 0; count > i; i++)
    {
      
        
        NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
        dayComponent.day = 1;
        NSCalendar *theCalendar = [NSCalendar currentCalendar];
        NSDate *nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:date options:0];
        NSString *nextDateString = [dateFormatter stringFromDate:nextDate];
       // NSLog(@"nextDate: %@", nextDateString   );
        
        NSDateFormatter *weekdayFormatter = [[NSDateFormatter alloc]init];
        
        [weekdayFormatter setDateFormat:@"E"];
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
    
    ViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    
    if ([button.buttonDayLabel.text isEqualToString:@"Thu"])
    {
        controller.view.backgroundColor = [UIColor redColor];
        controller.statusUitlegLabel.text = @"Vandaag is de kamer in sessie. Verwacht u aan een hevige Onkelinx storm!";
        controller.situatieLabel.text = @"ABANDON SHIP";
        controller.imageOnky.image = [UIImage imageNamed:@"onky2.jpg"];
    }
    
    controller.datumLabel.text = button.buttonDateLabel.text;
    
    
    [self transitionToViewcontroller:controller comingFromLeft:NO];
    
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
    burger.transitioningDelegate = self;
    
    [self presentViewController:burger animated:YES completion:nil];
    
    //[self transitionToViewcontroller:burger comingFromLeft:YES];
    
 // http://stackoverflow.com/questions/11412467/dismissmodalviewcontroller-with-transition-left-to-right
}

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
/*- (void)switchView
{
    NSLog(@"Hoi");
    
    ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    [self presentViewController:vc animated:YES completion:nil];
}
*/
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self.animator;
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self.animator;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
