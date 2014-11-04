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

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *buttonListScrollView;
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *statusUitlegLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.buttonListScrollView.userInteractionEnabled = YES;
    self.buttonListScrollView.scrollEnabled = YES;
    int x = 0;
    int y = 0;
    int count = 7;

    self.buttonListScrollView.contentSize = CGSizeMake(700, 0);
    self.statusUitlegLabel.text = @"Het parlement komt niet samen vandaag. Er is geen reden tot ongerustheid!";
  //  self.buttonListScrollView.panGestureRecognizer.delaysTouchesBegan = self.buttonListScrollView.delaysContentTouches;
  
    
    self.image.clipsToBounds = YES;
  //  self.image.layer.cornerRadius = self.image.frame.size.width/2;
    self.image.layer.borderWidth = 1.0f;
    self.image.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    NSArray *weekdays = @[@"MA", @"DI", @"WO",@"D0",@"VR",@"ZA",@"ZO"];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd/MM"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    NSLog(@"Date %@", dateString);
    
    
    
    for (int i = 0; count > i; i++)
    {
      
        /*
        NSDateComponents *dayComponent = [[[NSDateComponents alloc] init] autorelease];
        dayComponent.day = 1;
        
        NSCalendar *theCalendar = [NSCalendar currentCalendar];
        NSDate *nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:[NSDate date] options:0];
        
        NSLog(@"nextDate: %@ ...", nextDate);
        */
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button addTarget:self action:@selector(switchView) forControlEvents:UIControlEventTouchDown];
        NSString *string = weekdays[i];
        [button setTitle:string forState:UIControlStateNormal];
        button.Frame = CGRectMake(x,0, 100, 100);
        //button.imageView.image = [UIImage imageNamed:@"graybox.jpg"];
        button.layer.borderWidth = 1.0f;
        button.layer.borderColor = [[UIColor blackColor] CGColor];
        [self.buttonListScrollView addSubview:button];
         NSLog(@"int %d",x);
        x += button.frame.size.width;
        NSLog(@"int %d",x);
        
        
        
        
      /*
        NSArray *buttonArray = [[NSBundle mainBundle] loadNibNamed:@"Button" owner:self options:nil];
        ButtonView *button = buttonArray[1];
        button.buttonDayLabel.text = @"MA";
        button.buttonDateLabel.text = @"3/11";
        [self.buttonListScrollView addSubview:button];
        */
        
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
    
    ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    [self presentViewController:vc animated:YES completion:nil];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
