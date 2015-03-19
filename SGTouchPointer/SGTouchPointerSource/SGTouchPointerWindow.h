//
//  SGTouchPointerWindow.h
//
//  Created by ParkSanggeon on 01/09/14.
//  Copyright (c) 2014 - 2015 Sanggeon Park. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGTouchPointerWindow : UIWindow

// color for normal state
@property (nonatomic, strong) UIColor *normalTouchPointColor;

/**
 * color for pointing state,
 * when app doesn't interact with any touch points except touch pointers.
 */
@property (nonatomic, strong) UIColor *focusedTouchPointColor;

@end
