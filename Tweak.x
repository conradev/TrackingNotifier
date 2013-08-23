#include <notify.h>

#import "TrackingNotifierProvider.h"

%hook AOSCommandHandlerLocate

- (void)handleCommand {
	notify_post(TRACKING_NOTIFICATION_NAME);
	%orig();
}

%end
