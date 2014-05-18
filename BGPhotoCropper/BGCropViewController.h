//
//  BGCropViewController.h
//  BGPhotoCropper
//
//  Created by Björn Goß on 10/05/14.
//  Copyright (c) 2014 BG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BGCropViewDelegate <NSObject>

- (void)didFinishCropping:(UIImage *)croppedImage;

@end

@interface BGCropViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate>

@property id<BGCropViewDelegate> delegate;
@property UIImage *image;

@end
