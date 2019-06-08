#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "CalendarEvent.h"
#import "CalendarEventParser.h"
#import "CalendarEventParserConstants.h"
#import "CalendarEventTimeZones.h"

FOUNDATION_EXPORT double iOSCalendarEventParserVersionNumber;
FOUNDATION_EXPORT const unsigned char iOSCalendarEventParserVersionString[];

