//
//  BGViewController.m
//  BGPhotoCropper
//
//  Created by Björn Goß on 10/05/14.
//  Copyright (c) 2014 BG. All rights reserved.
//

#import "BGViewController.h"
#import "BGCropViewController.h"

@interface BGViewController ()

@end

@implementation BGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startCropperTouchUp:(id)sender
{
    BGCropViewController *cropViewController = [[BGCropViewController alloc] init];
    cropViewController.title = @"Test";
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:cropViewController];
    [self presentViewController:navigationController animated:YES completion:NULL];
}

@end
