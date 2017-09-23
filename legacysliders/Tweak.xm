@interface MPUMediaControlsVolumeView : UIView
@property (nonatomic,readonly) UISlider * slider;
@property (nonatomic,readonly) long long style;
- (UIImage *)image:(UIImage *)image scaledToSize:(CGSize)newSize;
- (UIImage *)circleWithSize:(CGSize)size;
@end

NSString*imagePath @"/tweaks/legacysliders/Images/Black/small-knob.png;
UIImage*image = [UIImage imageWithContentsOfFile:imagePath];

%hook MPUMediaControlsVolumeView

- (void)viewDidLoad {
    %orig;
      
    // style 5 means we are on the lockscreen
    if (self.style == 5) {
        // check that thumb image has been set, if so we can just resize that image and return it. 
        if ([self.slider currentThumbImage]) {
            [self.slider setThumbImage:[self image:[self.slider currentThumbImage] scaledToSize:CGSizeMake(5, 5)]
                                  forState:UIControlStateNormal];
         } else {
             [self.slider setThumbImage:[self circleWithSize:CGSizeMake(5, 5)]
                               forState:UIControlStateNormal];
         }
         
    }
}

- (void)setFrame:(CGRect)frame {
    frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 5);
    %orig(frame);
}

%new
- (UIImage *)image:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)circleWithSize:(CGSize)size {
    UIImage *circle = nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);

    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextFillEllipseInRect(ctx, rect);

    CGContextRestoreGState(ctx);
    circle = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return circle;
}


%end