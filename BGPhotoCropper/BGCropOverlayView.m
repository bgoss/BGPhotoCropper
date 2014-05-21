//
//  BGCropOverlayView.m
//  BGPhotoCropper
//
//  Created by Björn Goß on 16/05/14.
//  Copyright (c) 2014 BG. All rights reserved.
//

#import "BGCropOverlayView.h"

@interface BGCropOverlayView () {
    __weak IBOutlet UILabel *_instructionsLabel;
}



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

- (void)awakeFromNib
{
    [super awakeFromNib];
    _instructionsLabel.text = NSLocalizedString(@"crop_instructions", @"");
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (CGRectIsEmpty(self.cropArea)) {
        CGSize windowSize = self.bounds.size;
        CGSize cropSize = CGSizeMake(280, 280/1.586);
        CGFloat originX = (windowSize.width - cropSize.width)/2;
        CGFloat originY = (windowSize.height - cropSize.height - self.frame.origin.y)/2;;
        self.cropArea = CGRectMake(originX, originY, cropSize.width, cropSize.height);
    }
    
    if (!self.cropBorderColor) {
        self.cropBorderColor = [UIColor blackColor];
    }
    
    if (!self.overlayColor) {
        self.overlayColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.65];
    }
    
    self.cropArea = CGRectMake(self.cropArea.origin.x, self.cropArea.origin.y - self.frame.origin.y, self.cropArea.size.width, self.cropArea.size.height);
    
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
