//
//  MixpanelEvent.m
//  MPLib
//
//  Created by Elfred Pagan on 6/18/10.
//  Copyright 2010 elfredpagan.com. All rights reserved.
//

#import "MixpanelEvent.h"


@implementation MixpanelEvent
- (id) initWithName:(NSString*) aName type:(MPLibEventType) aType properties:(NSDictionary*) someProperties
{
	if ((self = [super init])) {
		if (aName) {
			name = [aName copy];			
		} else {
			name = @"mp_event";
		}
		eventType = aType;
		if (someProperties) {
			properties = [someProperties mutableCopy];			
		} else {
			properties = [[NSMutableDictionary alloc] init];
		}


		timestamp = [[NSDate alloc] init];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:name forKey:@"name"];
	[aCoder encodeInt:eventType forKey:@"eventType"];
	[aCoder encodeObject:properties forKey:@"properties"];
	[aCoder encodeDouble:[timestamp timeIntervalSince1970] forKey:@"timestamp"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ((self = [super init])) {
		name = [[aDecoder decodeObjectForKey:@"name"] retain];
		properties = [[aDecoder decodeObjectForKey:@"properties"] mutableCopy];
		eventType = [aDecoder decodeIntForKey:@"eventType"];
		NSTimeInterval interval = [aDecoder decodeDoubleForKey:@"timestamp"];
		timestamp = [[NSDate dateWithTimeIntervalSince1970:interval] retain];
	}
	return self;
}
- (void) dealloc
{
	[name release];
	[properties release];
	[timestamp release];
	[super dealloc];
}

- (NSDictionary*) dictionaryValue 
{
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
	[dictionary setObject:name forKey:@"event"];
	[properties setObject:[NSNumber numberWithLongLong:[timestamp timeIntervalSince1970]] forKey:@"time"];
	[dictionary setObject:properties forKey:@"properties"];
	return [[dictionary copy] autorelease];
}
@end
