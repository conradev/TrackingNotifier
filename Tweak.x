#include <notify.h>

#import "TrackingNotifierProvider.h"

%hook AOSFMIPBaseServiceProvider

- (void)ackLocateCommand:(NSString *)command withStatusCode:(NSInteger)code andStatusMessage:(NSString *)message {
	notify_post(TRACKING_NOTIFICATION_NAME);
	%orig();
}

%end