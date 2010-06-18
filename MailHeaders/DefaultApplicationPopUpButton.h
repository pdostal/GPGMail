/*
 *     Generated by class-dump 3.2 (32 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2009 by Steve Nygard.
 */

#import "NSPopUpButton.h"

@class NSArray, NSURL;

@interface DefaultApplicationPopUpButton : NSPopUpButton
{
    NSURL *_appURL;
    int _index;
    NSArray *_schemes;
}

- (void)dealloc;
- (id)mainScheme;
- (void)setHandler:(id)arg1 forScheme:(id)arg2;
- (id)imageForURL:(id)arg1;
- (long)addItemToPopup:(id)arg1;
- (void)populateSchemeHandlerPopupWithURL:(id)arg1;
- (id)copyDefaultURLForScheme:(id)arg1;
- (void)selectDefaultMailClientAtIndex:(long)arg1;
- (void)selectItemInPopup:(id)arg1;
- (void)setNewApplication;
- (void)selectNewAppSelected:(id)arg1;
- (void)sheetDidEnd:(id)arg1 returnCode:(long)arg2 contextInfo:(void *)arg3;
- (void)configurePopUpForURLSchemes:(id)arg1 usingExampleURLString:(id)arg2;

@end
