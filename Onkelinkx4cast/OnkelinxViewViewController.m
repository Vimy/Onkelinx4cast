//
//  OnkelinxViewViewController.m
//  Onkelinkx4cast
//
//  Created by Matthias Vermeulen on 6/11/14.
//  Copyright (c) 2014 Noizy. All rights reserved.
//

#import "OnkelinxViewViewController.h"

@interface OnkelinxViewViewController ()

@end

@implementation OnkelinxViewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.statusUitlegLabel.text = @"Het parlement komt niet samen vandaag. Er is geen reden tot ongerustheid!";
    //  self.buttonListScrollView.panGestureRecognizer.delaysTouchesBegan = self.buttonListScrollView.delaysContentTouches;
    
    
    self.profileImageView.clipsToBounds = YES;
    //  self.image.layer.cornerRadius = self.image.frame.size.width/2;
    self.profileImageView.layer.borderWidth = 1.0f;
    self.profileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
