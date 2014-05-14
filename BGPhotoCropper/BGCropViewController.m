//
//  BGCropViewController.m
//  BGPhotoCropper
//
//  Created by Björn Goß on 10/05/14.
//  Copyright (c) 2014 BG. All rights reserved.
//

#import "BGCropViewController.h"
#import "BGResultViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface BGCropViewController () {
    
    __weak IBOutlet UIImageView *_imageView;
    __weak IBOutlet UIScrollView *_scrollView;
    __weak IBOutlet UIView *_containerView;
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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    CGRect visible = [_containerView convertRect:_imageView.bounds fromView:_imageView];
    [_scrollView scrollRectToVisible:visible animated:NO];
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
    CGFloat borderWidth = _cropRect.layer.borderWidth;
    CGRect drawRect = CGRectMake(-_cropRect.frame.origin.x - borderWidth, -_cropRect.frame.origin.y - borderWidth , self.view.frame.size.width, self.view.frame.size.height);
    UIGraphicsBeginImageContext(CGSizeMake(_cropRect.bounds.size.width - 2*borderWidth, _cropRect.bounds.size.height - 2*borderWidth));
    [self.view drawViewHierarchyInRect:drawRect afterScreenUpdates:YES];
    UIImage *cropImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return cropImage;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _containerView;
}

#pragma mark - Storyboard

- (IBAction)rotationGesture:(UIRotationGestureRecognizer *)sender
{
    [self adjustAnchorPointForGestureRecognizer:sender];
    
    if (sender.state != UIGestureRecognizerStateBegan && sender.state != UIGestureRecognizerStateChanged) {
        return;
    }
    
    sender.view.transform = CGAffineTransformRotate(sender.view.transform, sender.rotation);
    sender.rotation = 0;
}

- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    
    // Something similar to this would allow to rotate around the centroid of the gesture
    // However, makes panning (i.e. moving) very complicated...
    // Rotation around center should be fine (the way it is now)
    // Thus, we return.
    
    return;
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIView *piece = gestureRecognizer.view;
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        
        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return YES;
}

#pragma mark - Take photo

- (IBAction)takePicture:(id)sender
{
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
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
