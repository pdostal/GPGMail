/*
 *     Generated by class-dump 3.3.3 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2010 by Steve Nygard.
 */

#import <Message/Message.h>

@class NSData, NSString;

@interface POPMessage : Message
{
    unsigned long long _messageNumber;
    NSString *_messageID;
    NSData *_messageData;
}

- (id)initWithPOP3FetchStore:(id)arg1;
- (void)dealloc;
- (void)finalize;
- (unsigned long long)messageNumber;
- (void)setMessageNumber:(unsigned long long)arg1;
- (id)messageData;
- (void)setMessageData:(id)arg1;
- (unsigned long long)messageSize;
- (id)messageDataIncludingFromSpace:(BOOL)arg1 newDocumentID:(id)arg2;
- (id)messageID;
- (void)setMessageID:(id)arg1;
- (id)remoteMailboxURL;
- (id)originalMailboxURL;

@end
