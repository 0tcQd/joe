/*


Features:

Hide Dock Background
Hide Folder Icon Background
Hide Folder Background
Hide Page Dots
Hide Icon Labels
Hide Testflight Dot
Hide Notification Badges
Disable App Library
Hide App Library Blur
Hide Status Bar
Hide Folder Title
Disable Icon Fly
Hide Quick Actions
Hide Lock (Notched Devices Only)
Hide "No Older Notifications"
Hide Date
Use Compact Date Format
Hide Home Bar (Only in SpringBoard)
Hide Control Center Grabber
Hide Swipe up to Unlock
Set Number of Dock Icons


*/

#import "Joe.h"

#define TWEAK_PREFS_PATH @"/var/mobile/Library/Preferences/com.propr.joeprefs.plist"

static NSUserDefaults *prefs = [[NSUserDefaults alloc] initWithSuiteName:TWEAK_PREFS_PATH];

BOOL getBoolSetting(NSString* setting) {
    return [[prefs objectForKey:setting] ?: @NO boolValue];
}

int getIntSetting(NSString* setting) {
    return [[prefs objectForKey:setting] intValue];
}

int drm() {
	if (![[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/dpkg/info/com.propr.joe.list"]) {
		return NO;
	} else {
		return YES;
	}
}

// hide dock background
%hook SBDockView

- (void)setBackgroundView:(UIView *)arg1 {
	if (getBoolSetting(@"hideDockBG")) {
		%orig(nil);
	} else {
		%orig;
	}
}
	
%end

// hide dock background 2 electric boogaloo
%hook SBFloatingDockView

- (void)setBackgroundView:(UIView *)arg1 {
	if (getBoolSetting(@"hideDockBG")) {
		%orig(nil);
	} else {
		%orig;
	}
}

%end

// hide folder icon background
%hook SBFolderIconImageView

- (void)setBackgroundView:(id)bgView {
	if (getBoolSetting(@"hideFolderIconBG")) {
		bgView = nil;
	} else {
		%orig;
	}
}
	
%end

// hide page dots
%hook SBIconListPageControl

- (void)setAlpha:(double)alpha {
	if (getBoolSetting(@"hidePageDots")) {
		return %orig(0.0);
	} else {
		return %orig;
	}
}

- (BOOL)isHidden {
	if (getBoolSetting(@"hidePageDots")) {
		return YES;
	} else {
		return %orig;
	}
}

- (BOOL)actsAsButton {
	if (getBoolSetting(@"hidePageDots")) {
		return NO;
	} else {
		return %orig;
	}
}

%end

// hide app label
%hook SBIconView

- (void)setLabelHidden:(BOOL)hidden {
	if (getBoolSetting(@"hideLabel")) {
		%orig(YES);
	} else {
		%orig;
	}
}

%end

// hide testflight dot
%hook SBIconBetaLabelAccessoryView

- (void)setAlpha:(double)alpha {
	if (getBoolSetting(@"hideTestflight")) {
		%orig(0.0);
	} else {
		return %orig;
	}
}

%end

// hide folder background
%hook SBFolderBackgroundView
	
- (void)setAlpha:(double)alpha {
	if (getBoolSetting(@"hideFolderBG")) {
		%orig(0.0);
	} else {
		return %orig;
	}
}

%end

// hide notification badges
%hook SBIconBadgeView

- (BOOL)isHidden {
	if (getBoolSetting(@"hideNotificationBadges")) {
		return YES;
	} else {
		return NO;
	}
}
	
- (void)setAlpha:(double)alpha {
	if (getBoolSetting(@"hideNotificationBadges")) {
		%orig(0.0);
	} else {
		return %orig;
	}
}

%end

// pick how many icons on da dock
%hook SBIconListGridLayoutConfiguration

- (NSUInteger)numberOfPortraitColumns {
    NSUInteger rows = MSHookIvar<NSUInteger>(self, "_numberOfPortraitRows");
    if (rows == 1) {
		if (getIntSetting(@"numDockIcon") == 0) {
        	return %orig;
		} else {
			return getIntSetting(@"numDockIcon");
		}
	}
	
	return %orig;
}

%end

// hide app library folder blur
%hook SBHLibraryCategoryPodBackgroundView

- (void)setAlpha:(double)alpha {
	if (getBoolSetting(@"hideAppLibraryBlur")) {
		%orig(0.0);
	} else {
		return %orig;
	}
}

%end

// hide status bar
%hook UIStatusBar_Modern

- (void)setStatusBar:(id)porn {
	if (getBoolSetting(@"hideStatusBar")) {
		return %orig(nil);
	} else {
		return %orig;
	}
}

%end

// hide folder title
%hook SBFolderTitleTextField

- (BOOL)isHidden {
	if (getBoolSetting(@"hideFolderTitle")) {
		return YES;
	} else {
		return %orig;
	}
}

- (void)setText:(NSString*)balls {
		if (getBoolSetting(@"hideFolderTitle")) {
		return %orig(@"");
	} else {
		return %orig;
	}
}

%end

// disable icon fly
%hook CSCoverSheetTransitionSettings

- (BOOL)iconsFlyIn {
	if (getBoolSetting(@"hideIconFly")) {
		return NO;
	} else {
		return %orig;
	}
}

%end

// hide lock in lock screen (notched only)
%hook SBUIProudLockIconView

- (BOOL)isHidden {
	if (getBoolSetting(@"hideLockIcon")) {
		return YES;
	} else {
		return %orig;
	}
}

- (void)setAlpha:(double)alpha {
	if (getBoolSetting(@"hideLockIcon")) {
		%orig(0.0);
	} else {
		return %orig;
	}
}

%end

// hide quick actions
%hook CSQuickActionsView

- (BOOL)isHidden {
	if (getBoolSetting(@"hideQuickActions")) {
		return YES;
	} else {
		return %orig;
	}
}

- (void)setAlpha:(double)alpha {
	if (getBoolSetting(@"hideQuickActions")) {
		return %orig(0.0);
	} else {
		return %orig;
	}
}

%end

%hook CSQuickActionsButton

- (BOOL)isHidden {
	if (getBoolSetting(@"hideQuickActions")) {
		return YES;
	} else {
		return %orig;
	}
}

%end

// use compact date format
%hook SBFLockScreenDateView

- (void)setUseCompactDateFormat:(BOOL)isHidden {
	if (getBoolSetting(@"compactDate")) {
		return %orig(YES);
	} else {
		return %orig;
	}
}

%end

// hide date
%hook SBFLockScreenDateView

- (BOOL)isHidden {
	if (getBoolSetting(@"hideDate")) {
		return YES;
	} else {
		return %orig;
	}
}

- (void)setAlpha:(double)alpha {
	if (getBoolSetting(@"hideDate")) {
		return %orig(0.0);
	} else {
		return %orig;
	}
}

%end

// hide no older notifications
%hook NCNotificationListSectionRevealHintView

- (BOOL)isHidden {
	if (getBoolSetting(@"hideOlderNotifications")) {
		return YES;
	} else {
		return NO;
	}
}

- (void)setForceRevealed:(BOOL)ok {
	if (getBoolSetting(@"hideOlderNotifications")) {
		return %orig(YES);
	} else {
		return %orig;
	}
}

- (void)setRevealPercentage:(CGFloat)balls {
	if (getBoolSetting(@"hideOlderNotifications")) {
		return %orig(0);
	} else {
		return %orig;
	}
}

%end

// hide home bar and hide cc grabber and swipe to unlock
%hook CSTeachableMomentsContainerView

// hide control center grabber
- (void)setControlCenterGrabberView:(id)ccView {
	if (getBoolSetting(@"hideCCGrabber")) {
		return %orig(nil);
	} else {
		return %orig;
	}
}

- (void)setControlCenterGrabberEffectContainerView:(id)ccView {
	if (getBoolSetting(@"hideCCGrabber")) {
		return %orig(nil);
	} else {
		return %orig;
	}
}

- (void)setControlCenterTutorsContainerView:(id)ccView {
	if (getBoolSetting(@"hideCCGrabber")) {
		return %orig(nil);
	} else {
		return %orig;
	}
}

- (void)setControlCenterGrabberPositionPlaceholderView:(id)ccView {
	if (getBoolSetting(@"hideCCGrabber")) {
		return %orig(nil);
	} else {
		return %orig;
	}
}

// hide home bar
- (void)setHomeAffordanceContainerView:(id)homeView {
	if (getBoolSetting(@"hideHomeBar")) {
		return %orig(nil);
	} else {
		return %orig;
	}
}

- (void)setHomeAffordanceView:(id)homeView {
	if (getBoolSetting(@"hideHomeBar")) {
		return %orig(nil);
	} else {
		return %orig;
	}
}

// hide swipe to unlock
- (void)setCallToActionLabel:(id)label {
	if (getBoolSetting(@"hideSwipeToUnlock")) {
		return %orig(nil);
	} else {
		return %orig;
	}
}

- (void)setCallToActionLabelContainerView:(id)label {
	if (getBoolSetting(@"hideSwipeToUnlock")) {
		return %orig(nil);
	} else {
		return %orig;
	}
}

- (void)setCallToActionLabelPositionPlaceholderView:(id)label {
	if (getBoolSetting(@"hideSwipeToUnlock")) {
		return %orig(nil);
	} else {
		return %orig;
	}
}

%end

// hide do not disturb notification (currently does not work i am not sure why)
// %hook NCNotificationShortLookView

// BOOL isDnd;

// - (void)setSecondaryText:(id)text {
// 	%orig;
// 	if ([text hasSuffix:@"iPhone is locked."]) {
// 		isDnd = YES;
// 	} else {
// 		isDnd = NO;
// 	}
// }

// - (BOOL)isHidden {
// 	if (isDnd) {
// 		return YES;
// 	} else {
// 		return %orig;
// 	}
// }

// %end


// disable app library
%hook SBIconController

- (BOOL)isAppLibrarySupported {
	if (getBoolSetting(@"hideAppLibrary")) {
		return NO;
	} else {
		return %orig;
	}
}

%end

%ctor {
    NSString *bundleID = NSBundle.mainBundle.bundleIdentifier;
    if ([bundleID isEqualToString:@"com.apple.springboard"] && drm()) {
        %init;
    }
	NSLog(@"Partnered with Meth Development LLC");
}
