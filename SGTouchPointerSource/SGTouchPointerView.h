//
//  SGTouchPointerView.h
//  AnlageFinder
//
//  Created by ParkSanggeon on 01/09/14.
//  Copyright (c) 2014 - 2015 Sanggeon Park. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - Protocols
@protocol SGTouchPointerViewDelegate <NSObject>
@required
- (BOOL)showTouchIndicator;

@end

#pragma mark -

@interface SGTouchPointerView : UIView
@property (nonatomic, weak) id <SGTouchPointerViewDelegate> delegate;
@property (nonatomic, strong) UIColor *indicatorColor;

- (void)handleTouches:(NSSet *)touches;

@end
