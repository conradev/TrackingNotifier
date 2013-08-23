@protocol BBSectionIdentity <NSObject>
- (NSString *)sectionIdentifier;
@optional
- (NSData *)sectionIconData;
- (NSString *)sectionDisplayName;
@end

@protocol BBDataProvider <BBSectionIdentity>
- (NSArray *)sortDescriptors;
- (NSArray *)bulletinsFilteredBy:(unsigned int)filter count:(unsigned int)count lastCleared:(id)cleared;
@optional
- (void)dataProviderDidLoad;
@end

@interface BBAction : NSObject
+ (instancetype)actionWithLaunchURL:(NSURL *)url callblock:(void(^)())callblock;
@end

@interface BBBulletin : NSObject <NSCopying, NSCoding>
@property(copy, nonatomic) NSString *recordID;
@property(copy, nonatomic) BBAction *defaultAction;
@property(copy, nonatomic) NSString *title;
@property(copy, nonatomic) NSString *message;
@property(retain, nonatomic) NSDate *date;
@end

@interface BBBulletinRequest : BBBulletin
@end

extern void BBDataProviderAddBulletin(id <BBDataProvider>, BBBulletin *);

#define TRACKING_NOTIFICATION_NAME "com.conradkramer.trackingnotifier"

@interface TrackingNotifierProvider : NSObject <BBDataProvider>

@end