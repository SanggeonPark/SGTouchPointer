//
//  SGTouchPointerView.m
//  AnlageFinder
//
//  Created by ParkSanggeon on 01/09/14.
//  Copyright (c) 2014 - 2015 Sanggeon Park. All rights reserved.
//

#import "SGTouchPointerView.h"
#import <objc/runtime.h>

@interface SGTouchView : UIView

@end

@implementation SGTouchView

- (void)removeFromSuperview
{
    [UIView animateWithDuration:0.5f animations:^{
        self.alpha = 0.0f;
        self.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1);
    } completion:^(BOOL completed){
        [super removeFromSuperview];
    }];
}

@end

@interface SGTouchPointerView ()
{
    CFMutableDictionaryRef _touchDictionary;
}

@end

@implementation SGTouchPointerView

- (void)handleTouches:(NSSet *)touches
{
    if ([self.delegate hasMirroredScreen] == NO) {
        [self removeTouches:nil];
        return;
    }
    
    [self.window bringSubviewToFront:self];
    for (UITouch *touch in touches)
    {
        CGPoint point = [touch locationInView:self];
        UIView *touchIndicationView = (UIView *)CFDictionaryGetValue(_touchDictionary, (__bridge const void *)(touch));
        
        if (touch.phase == UITouchPhaseCancelled || touch.phase == UITouchPhaseEnded)
        {
            if (touchIndicationView != NULL)
            {
                // Remove the touch from the
                CFDictionaryRemoveValue(_touchDictionary, (__bridge const void *)(touch));
                [touchIndicationView removeFromSuperview];
            }
        }
        else
        {
            if (touchIndicationView == NULL) {
                touchIndicationView = [[SGTouchView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
                [self addSubview:touchIndicationView];
                CFDictionarySetValue(_touchDictionary, (__bridge const void *)(touch), (__bridge const void *)(touchIndicationView));
                touchIndicationView.backgroundColor = self.indicatorColor;
                touchIndicationView.layer.cornerRadius = 12.5;
                touchIndicationView.alpha = 0.5f;
            }
            
            touchIndicationView.center = point;
        }
    }
    
    [self removeTouches:touches];
}

- (void)removeTouches:(NSSet *)touches
{
    CFIndex count = CFDictionaryGetCount(_touchDictionary);
    void const * keys[count];
    void const * values[count];
    CFDictionaryGetKeysAndValues(_touchDictionary, keys, values);
    for (CFIndex i = 0; i < count; ++i) {
        UITouch *touch = (__bridge UITouch *)keys[i];
        
        if (touches.count == 0 || ![touches containsObject:touch]) {
            UIView *view = (__bridge UIView *)values[i];
            CFDictionaryRemoveValue(_touchDictionary, (__bridge const void *)(touch));
            [view removeFromSuperview];
        }
    }

}

- (id)init
{
    if (self = [super init]) {
        _touchDictionary = CFDictionaryCreateMutable(NULL, 20, NULL, NULL);
        _indicatorColor = [UIColor grayColor];
    }
    
    return self;
}

- (void)dealloc
{
    CFRelease(_touchDictionary);
}

@end
