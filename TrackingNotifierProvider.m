#import <UIKit/UIKit.h>
#include <notify.h>

#import "TrackingNotifierProvider.h"

@interface UIImage (Private)
+ (instancetype)imageNamed:(NSString *)name inBundle:(NSBundle *)bundle;
@end

@interface UIDevice (Private)
+ (NSString *)modelSpecificLocalizedStringKeyForKey:(NSString *)key;
@end

@interface TrackingNotifierProvider ()
@property (readonly, nonatomic) int token;
@end

@implementation TrackingNotifierProvider

#pragma mark - BBSectionIdentity

- (NSString *)sectionIdentifier {
	return @"com.apple.mobileme.fmip1";
}

- (NSData *)sectionIconData {
	NSBundle *bundle = [NSBundle bundleWithPath:@"/Applications/Preferences.app"];
	return UIImagePNGRepresentation([UIImage imageNamed:@"FindMyiPhone" inBundle:bundle]);
}

- (NSString *)sectionDisplayName {
	NSBundle *bundle = [NSBundle bundleWithPath:@"/Applications/Preferences.app"];
	NSString *key = [UIDevice modelSpecificLocalizedStringKeyForKey:@"FIND_MY_DEVICE"];
	return [bundle localizedStringForKey:key value:nil table:@"Location Services"];
}

#pragma mark - BBDataProvider

- (NSArray *)sortDescriptors {
	return @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]];
}

- (NSArray *)bulletinsFilteredBy:(unsigned)filter count:(unsigned)count lastCleared:(id)cleared {
	return nil;
}

- (void)dataProviderDidLoad {
	__weak __typeof__(self) weakSelf = self;
	notify_register_dispatch(TRACKING_NOTIFICATION_NAME, &_token, dispatch_get_main_queue(), ^(int token) {
		BBBulletinRequest *bulletin = [BBBulletinRequest new];
		bulletin.title = @"Tracking Activated";
		bulletin.message = [[self sectionDisplayName] stringByAppendingString:@" location tracking was enabled."];
		bulletin.defaultAction = [BBAction actionWithLaunchURL:[NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"] callblock:nil];
		bulletin.recordID = @(TRACKING_NOTIFICATION_NAME);
		bulletin.date = [NSDate date];
		BBDataProviderAddBulletin(weakSelf, bulletin);
	});
}

- (void)dealloc {
	notify_cancel(self.token);
}

@end
