//
//  BGCropViewController.m
//  BGPhotoCropper
//
//  Created by Björn Goß on 10/05/14.
//  Copyright (c) 2014 BG. All rights reserved.
//

#import "BGCropViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "BGCropOverlayView.h"

@interface BGCropViewController () {
    
    __weak IBOutlet UIImageView *_imageView;
    __weak IBOutlet UIScrollView *_scrollView;
    __weak IBOutlet UIView *_containerView;
    __weak IBOutlet BGCropOverlayView *_cropOverlay;
}

@end

@implementation BGCropViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpNavigationBar];
    CGRect visible = [_containerView convertRect:_imageView.bounds fromView:_imageView];
    _scrollView.contentOffset = visible.origin;
    _imageView.image = self.image;
}

- (void)setUpNavigationBar
{
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveImage)];
    self.navigationItem.rightBarButtonItem = saveItem;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveImage
{
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate didFinishCropping:self.croppedImage];
    }];
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)croppedImage
{
    CGFloat borderWidth = 1.0;
    CGRect cropArea = _cropOverlay.cropArea;
    CGRect drawRect = CGRectMake(- cropArea.origin.x - borderWidth, - cropArea.origin.y - borderWidth, _cropOverlay.frame.size.width, _cropOverlay.frame.size.height);
    
    UIGraphicsBeginImageContext(CGSizeMake(cropArea.size.width - 2*borderWidth, cropArea.size.height - 2*borderWidth));
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

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
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
