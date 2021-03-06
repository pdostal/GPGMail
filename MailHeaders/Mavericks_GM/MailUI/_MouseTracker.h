/*
 *     Generated by class-dump 3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2012 by Steve Nygard.
 */

#import "NSObject.h"

@class NSView;

@interface _MouseTracker : NSObject
{
    NSView *_view;
    struct CGRect _trackingRect;
    long long _trackingRectTag;
    BOOL _mouseOver;
    id _delegate;
}

- (void)mouseMoved:(id)arg1;
- (void)mouseExited:(id)arg1;
- (void)mouseEntered:(id)arg1;
- (void)_updateMouseIsOver;
- (BOOL)mouseOver;
- (id)view;
- (struct CGRect)trackingRect;
- (void)setDelegate:(id)arg1;
- (void)dealloc;
- (id)initWithTrackingRect:(struct CGRect)arg1 inView:(id)arg2;

@end

