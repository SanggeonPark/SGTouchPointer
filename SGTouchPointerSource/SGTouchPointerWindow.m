//
//  SGTouchPointerWindow.m
//
//  Created by ParkSanggeon on 01/09/14.
//  Copyright (c) 2014 - 2015 Sanggeon Park. All rights reserved.
//

#import "SGTouchPointerWindow.h"
#import "SGTouchPointerView.h"
#import <objc/runtime.h>

#pragma mark - Private

@interface SGTouchPointerWindow () <SGTouchPointerViewDelegate>
@property (nonatomic, strong) SGTouchPointerView *touchPointerView;
@end

#pragma mark - 

@implementation SGTouchPointerWindow

#pragma mark - Helper

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

#pragma mark - SGTouchPointerViewDelegate

- (BOOL)showTouchIndicator
{
    if (self.presentationMode == SGTouchIndicatorPresentationModeNever ||
        (self.presentationMode == SGTouchIndicatorPresentationModeExternalScreen && [self hasMirroredScreen] == NO))
    {
        return NO;
    }
    
    return YES;
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

- (void)setFocusedTouchPointColor:(UIColor *)focusedTouchPointColor
{
    _focusedTouchPointColor = focusedTouchPointColor;
    _blockedTouchPointColor = focusedTouchPointColor;
}

- (void)setBlockedTouchPointColor:(UIColor *)blockedTouchPointColor
{
    _focusedTouchPointColor = blockedTouchPointColor;
    _blockedTouchPointColor = blockedTouchPointColor;
}

#pragma mark - Overwritten From Super Class

- (void)becomeKeyWindow
{
    [super becomeKeyWindow];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.normalTouchPointColor = [UIColor grayColor];
        self.blockedTouchPointColor = [UIColor orangeColor];
    });
}

- (void)sendEvent:(UIEvent *)event
{
    if (![self showTouchIndicator]) {
        [super sendEvent:event];
        return;
    }
    
    if (self.blockTouches && [UIDevice currentDevice].orientation == UIDeviceOrientationFaceUp) {
        self.touchPointerView.indicatorColor = self.blockedTouchPointColor;
    } else {
        [super sendEvent:event];
        self.touchPointerView.indicatorColor = self.normalTouchPointColor;
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
