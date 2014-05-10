//
//  BGCropViewController.m
//  BGPhotoCropper
//
//  Created by Björn Goß on 10/05/14.
//  Copyright (c) 2014 BG. All rights reserved.
//

#import "BGCropViewController.h"
#import "BGResultViewController.h"

@interface BGCropViewController () {
    
    __weak IBOutlet UIImageView *_imageView;
    __weak IBOutlet UIScrollView *_scrollView;
    __weak IBOutlet UIView *_cropRect;
}

@end

@implementation BGCropViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _cropRect.layer.borderColor = UIColor.blackColor.CGColor;
    _cropRect.layer.borderWidth = 2.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showCroppedImage"]) {
        BGResultViewController *destinationViewController = (BGResultViewController *)segue.destinationViewController;
        destinationViewController.resultImage = self.croppedImage;
    }
}

- (UIImage *)croppedImage
{
    return _imageView.image;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}

#pragma mark - Take photo

- (IBAction)takePicture:(id)sender
{
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    cameraUI.allowsEditing = NO;
    cameraUI.delegate = self;
    [self presentViewController:cameraUI animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    _imageView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
