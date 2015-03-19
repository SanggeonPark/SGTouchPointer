//
//  SGTouchPointerWindow.m
//
//  Created by ParkSanggeon on 01/09/14.
//  Copyright (c) 2014 - 2015 Sanggeon Park. All rights reserved.
//

#import "SGTouchPointerWindow.h"
#import "SGTouchPointerView.h"
#import <objc/runtime.h>

@interface SGTouchPointerWindow () <SGTouchPointerViewDelegate>
@property (nonatomic, strong) SGTouchPointerView *touchPointerView;
@end


@implementation SGTouchPointerWindow

#pragma mark - SGTouchPointerViewDelegate

- (BOOL)hasMirroredScreen
{
    BOOL hasMirroredScreen = NO;
    NSArray *screens = [UIScreen screens];
    
    if ([screens count] > 1)
    {
        for (UIScreen *screen in screens)
        {
            if (screen.mirroredScreen != nil)
            {
                hasMirroredScreen = YES;
                break;
            }
        }
    }
    return hasMirroredScreen;
}

#pragma mark - Accessors

- (SGTouchPointerView *)touchPointerView
{
    if (_touchPointerView) {
        [_touchPointerView.window bringSubviewToFront:_touchPointerView];
        return _touchPointerView;
    } else {
        _touchPointerView = [[SGTouchPointerView alloc] init];
        _touchPointerView.userInteractionEnabled = NO;
        _touchPointerView.delegate = self;
    }
    [self addSubview:_touchPointerView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_touchPointerView);
    
    [_touchPointerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_touchPointerView]|"
                                             options:0
                                             metrics:nil
                                               views:views]];
    
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_touchPointerView]|"
                                             options:0
                                             metrics:nil
                                               views:views]];
    
    [_touchPointerView.window bringSubviewToFront:_touchPointerView];
    return _touchPointerView;
}

#pragma mark - Overwritten From Super Class

- (void)becomeKeyWindow
{
    [super becomeKeyWindow];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.normalTouchPointColor = [UIColor grayColor];
        self.focusedTouchPointColor = [UIColor orangeColor];
    });
}

- (void)sendEvent:(UIEvent *)event
{
    if (![self hasMirroredScreen]) {
        [super sendEvent:event];
        return;
    }
    
    if ([UIDevice currentDevice].orientation != UIDeviceOrientationFaceUp) {
        [super sendEvent:event];
        self.touchPointerView.indicatorColor = self.normalTouchPointColor;
    } else {
        self.touchPointerView.indicatorColor = self.focusedTouchPointColor;
    }
    
    [[self touchPointerView] handleTouches:[event allTouches]];
}

- (void)addSubview:(UIView *)view
{
    if ([view isKindOfClass:[SGTouchPointerView class]]) {
        if (view.superview == nil) {
            [super addSubview:view];
        }
    } else {
        [super addSubview:view];
        [self bringSubviewToFront:[self touchPointerView]];
    }
}

@end
