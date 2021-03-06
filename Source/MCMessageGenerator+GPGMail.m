/* MCMessageGenerator+GPGMail.m created by Lukas Pitschl (@lukele) on Sat 04-Oct-2014 */

/*
 * Copyright (c) 2000-2014, GPGTools Team <team@gpgtools.org>
 * All rights reserved.
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of GPGTools Team nor the names of GPGMail
 *       contributors may be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE GPGTools Team ``AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE GPGTools Project Team BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "MCMessageGenerator+GPGMail.h"
#import "MCMessageGenerator.h"
#import "MimePart.h"
#import "NSObject+LPDynamicIvars.h"

@implementation MCMessageGenerator_GPGMail

- (id)MA_newDataForMimePart:(id)mimePart withPartData:(id)partData NS_RETURNS_RETAINED {
	// MailTags likes to duplicate the headers of the mime part for some reason.
	// It looks like it's easily detectable by checking for the header and body separator \n\n.
	// If we find two header separators, we can assume that a duplicate header was added
	// and will remove the first one.
	
	// The bug has only been seen in combinations with encryted drafts yet, so in any other case,
	// we'll just call into the original method and return the result.
	NSData *newData = [self MA_newDataForMimePart:mimePart withPartData:partData];
	if([mimePart parentPart] || ![[self getIvar:@"IsDraft"] boolValue] || !(BOOL)[(GM_CAST_CLASS(MCMessageGenerator *, id))self encryptsOutput])
		return newData;
	
	[self removeIvar:@"IsDraft"];
	
	NSData *NL = [@"\n\n" dataUsingEncoding:NSUTF8StringEncoding];
	
	NSUInteger messageSeparatorsFound = 0;
	NSRange firstHeaderEndRange = [newData rangeOfData:NL options:0 range:NSMakeRange(0, [newData length])];
	// One header separator is found. Expected, so on to the next check.
	if(firstHeaderEndRange.location != NSNotFound) {
		messageSeparatorsFound++;
		NSRange secondHeaderEndRange = [newData rangeOfData:NL options:0 range:NSMakeRange(firstHeaderEndRange.location + firstHeaderEndRange.length, [newData length] - firstHeaderEndRange.location - firstHeaderEndRange.length)];
		// Oh oh, a second one has been found.
		if(secondHeaderEndRange.location != NSNotFound)
			messageSeparatorsFound++;
	}
	// Two header separators? Let's only keep the data after the first one.
	if(messageSeparatorsFound > 1)
		newData = [newData subdataWithRange:NSMakeRange(firstHeaderEndRange.location + firstHeaderEndRange.length, [newData length] - firstHeaderEndRange.location - firstHeaderEndRange.length)];
	return newData;
}

@end
