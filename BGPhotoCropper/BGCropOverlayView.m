//
//  BGCropOverlayView.m
//  BGPhotoCropper
//
//  Created by Björn Goß on 16/05/14.
//  Copyright (c) 2014 BG. All rights reserved.
//

#import "BGCropOverlayView.h"

@interface BGCropOverlayView ()



@end

@implementation BGCropOverlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (CGRectIsEmpty(self.cropArea)) {
        CGSize windowSize = self.bounds.size;
        CGSize cropSize = CGSizeMake(280, 280/1.586);
        CGFloat originX = (windowSize.width - cropSize.width)/2;
        CGFloat originY = (windowSize.height - cropSize.height)/2;;
        self.cropArea = CGRectMake(originX, originY, cropSize.width, cropSize.height);
    }
    
    if (!self.cropBorderColor) {
        self.cropBorderColor = [UIColor blackColor];
    }
    
    if (!self.overlayColor) {
        self.overlayColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.65];
    }
    
    [self.overlayColor setFill];
    UIRectFill(rect);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, self.cropBorderColor.CGColor);
    CGContextStrokeRect(context, self.cropArea);
    
    CGRect holeRectIntersection = CGRectIntersection(self.cropArea, rect);
    [[UIColor clearColor] setFill];
    UIRectFill(holeRectIntersection);
}

@end
