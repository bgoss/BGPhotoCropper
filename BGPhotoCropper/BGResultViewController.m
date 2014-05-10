//
//  BGResultViewController.m
//  BGPhotoCropper
//
//  Created by Björn Goß on 10/05/14.
//  Copyright (c) 2014 BG. All rights reserved.
//

#import "BGResultViewController.h"

@interface BGResultViewController () {
    __weak IBOutlet UIImageView *_imageView;
}

@end

@implementation BGResultViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _imageView.image = self.resultImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
