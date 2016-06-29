//
//  SGTouchPointerWindow.h
//
//  Created by ParkSanggeon on 01/09/14.
//  Copyright (c) 2014 - 2015 Sanggeon Park. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - Constants

typedef NS_ENUM(NSUInteger, SGTouchIndicatorPresentationMode) {
    SGTouchIndicatorPresentationModeExternalScreen = 0,
    SGTouchIndicatorPresentationModeAlways = 1,
    SGTouchIndicatorPresentationModeNever = 2
};

#pragma mark -

@interface SGTouchPointerWindow : UIWindow

@property (nonatomic, assign) SGTouchIndicatorPresentationMode presentationMode;


// When device orientation is UIDeviceOrientationFaceUp, touch events will not dispatch to sub views and show touch pointer with blockedTouchPointColor
// default is NO
@property (nonatomic, assign) BOOL blockTouches;

// color for normal state
@property (nonatomic, strong) UIColor *normalTouchPointColor;

/**
 * color for pointing state,
 * when app doesn't interact with any touch points except touch pointers.
 */
@property (nonatomic, strong) UIColor *focusedTouchPointColor __attribute__ ((deprecated("deprecated in 0.1.5, please use blockedTouchPointColorInstead.")));

@property (nonatomic, strong) UIColor *blockedTouchPointColor;

@end
