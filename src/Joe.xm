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

#import "../include/Joe.h"

#define TWEAK_PREFS_PATH @"/var/mobile/Library/Preferences/com.propr.joeprefs.plist"

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
	if ([libpropr boolForKey:@"hideDockBG"]) {
		%orig(nil);
	} else {
		%orig;
	}
}
	
%end

// hide dock background 2 electric boogaloo
%hook SBFloatingDockView

- (void)setBackgroundView:(UIView *)arg1 {
	if ([libpropr boolForKey:@"hideDockBG"]) {
		%orig(nil);
	} else {
		%orig;
	}
}

%end

// hide folder icon background
%hook SBFolderIconImageView

- (void)setBackgroundView:(id)bgView {
	if ([libpropr boolForKey:@"hideFolderIconBG"]) {
		bgView = nil;
	} else {
		%orig;
	}
}
	
%end

// hide page dots
%hook SBIconListPageControl

- (void)setAlpha:(double)alpha {
	if ([libpropr boolForKey:@"hidePageDots"]) {
		return %orig(0.0);
	} else {
		return %orig;
	}
}

- (BOOL)isHidden {
	if ([libpropr boolForKey:@"hidePageDots"]) {
		return YES;
	} else {
		return %orig;
	}
}

- (BOOL)actsAsButton {
	if ([libpropr boolForKey:@"hidePageDots"]) {
		return NO;
	} else {
		return %orig;
	}
}

%end

// hide app label
%hook SBIconView

- (void)setLabelHidden:(BOOL)hidden {
	if ([libpropr boolForKey:@"hideLabel"]) {
		%orig(YES);
	} else {
		%orig;
	}
}

%end

// hide testflight dot
%hook SBIconBetaLabelAccessoryView

- (void)setAlpha:(double)alpha {
	if ([libpropr boolForKey:@"hideTestflight"]) {
		%orig(0.0);
	} else {
		return %orig;
	}
}

%end

// hide folder background
%hook SBFolderBackgroundView
	
- (void)setAlpha:(double)alpha {
	if ([libpropr boolForKey:@"hideFolderBG"]) {
		%orig(0.0);
	} else {
		return %orig;
	}
}

%end

// hide notification badges
%hook SBIconBadgeView

- (BOOL)isHidden {
	if ([libpropr boolForKey:@"hideNotificationBadges"]) {
		return YES;
	} else {
		return NO;
	}
}
	
- (void)setAlpha:(double)alpha {
	if ([libpropr boolForKey:@"hideNotificationBadges"]) {
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
		if ([libpropr intForKey:@"numDockIcon"] == 0) {
        	return %orig;
		} else {
			return [libpropr intForKey:@"numDockIcon"];
		}
	}
	
	return %orig;
}

%end

// hide app library folder blur
%hook SBHLibraryCategoryPodBackgroundView

- (void)setAlpha:(double)alpha {
	if ([libpropr boolForKey:@"hideAppLibraryBlur"]) {
		%orig(0.0);
	} else {
		return %orig;
	}
}

%end

// hide status bar
%hook UIStatusBar_Modern

- (void)setStatusBar:(id)porn {
	if ([libpropr boolForKey:@"hideStatusBar"]) {
		return %orig(nil);
	} else {
		return %orig;
	}
}

%end

// hide folder title
%hook SBFolderTitleTextField

- (BOOL)isHidden {
	if ([libpropr boolForKey:@"hideFolderTitle"]) {
		return YES;
	} else {
		return %orig;
	}
}

- (void)setText:(NSString*)balls {
		if ([libpropr boolForKey:@"hideFolderTitle"]) {
		return %orig(@"");
	} else {
		return %orig;
	}
}

%end

// disable icon fly
%hook CSCoverSheetTransitionSettings

- (BOOL)iconsFlyIn {
	if ([libpropr boolForKey:@"hideIconFly"]) {
		return NO;
	} else {
		return %orig;
	}
}

%end

// hide lock in lock screen (notched only)
%hook SBUIProudLockIconView

- (BOOL)isHidden {
	if ([libpropr boolForKey:@"hideLockIcon"]) {
		return YES;
	} else {
		return %orig;
	}
}

- (void)setAlpha:(double)alpha {
	if ([libpropr boolForKey:@"hideLockIcon"]) {
		%orig(0.0);
	} else {
		return %orig;
	}
}

%end

// hide quick actions
%hook CSQuickActionsView

- (BOOL)isHidden {
	if ([libpropr boolForKey:@"hideQuickActions"]) {
		return YES;
	} else {
		return %orig;
	}
}

- (void)setAlpha:(double)alpha {
	if ([libpropr boolForKey:@"hideQuickActions"]) {
		return %orig(0.0);
	} else {
		return %orig;
	}
}

%end

%hook CSQuickActionsButton

- (BOOL)isHidden {
	if ([libpropr boolForKey:@"hideQuickActions"]) {
		return YES;
	} else {
		return %orig;
	}
}

%end

// use compact date format
%hook SBFLockScreenDateView

- (void)setUseCompactDateFormat:(BOOL)isHidden {
	if ([libpropr boolForKey:@"compactDate"]) {
		return %orig(YES);
	} else {
		return %orig;
	}
}

%end

// hide date
%hook SBFLockScreenDateView

- (BOOL)isHidden {
	if ([libpropr boolForKey:@"hideDate"]) {
		return YES;
	} else {
		return %orig;
	}
}

- (void)setAlpha:(double)alpha {
	if ([libpropr boolForKey:@"hideDate"]) {
		return %orig(0.0);
	} else {
		return %orig;
	}
}

%end

// hide no older notifications
%hook NCNotificationListSectionRevealHintView

- (BOOL)isHidden {
	if ([libpropr boolForKey:@"hideOlderNotifications"]) {
		return YES;
	} else {
		return NO;
	}
}

- (void)setForceRevealed:(BOOL)ok {
	if ([libpropr boolForKey:@"hideOlderNotifications"]) {
		return %orig(YES);
	} else {
		return %orig;
	}
}

- (void)setRevealPercentage:(CGFloat)balls {
	if ([libpropr boolForKey:@"hideOlderNotifications"]) {
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
	if ([libpropr boolForKey:@"hideCCGrabber"]) {
		return %orig(nil);
	} else {
		return %orig;
	}
}

- (void)setControlCenterGrabberEffectContainerView:(id)ccView {
	if ([libpropr boolForKey:@"hideCCGrabber"]) {
		return %orig(nil);
	} else {
		return %orig;
	}
}

- (void)setControlCenterTutorsContainerView:(id)ccView {
	if ([libpropr boolForKey:@"hideCCGrabber"]) {
		return %orig(nil);
	} else {
		return %orig;
	}
}

- (void)setControlCenterGrabberPositionPlaceholderView:(id)ccView {
	if ([libpropr boolForKey:@"hideCCGrabber"]) {
		return %orig(nil);
	} else {
		return %orig;
	}
}

// hide home bar
- (void)setHomeAffordanceContainerView:(id)homeView {
	if ([libpropr boolForKey:@"hideHomeBar"]) {
		return %orig(nil);
	} else {
		return %orig;
	}
}

- (void)setHomeAffordanceView:(id)homeView {
	if ([libpropr boolForKey:@"hideHomeBar"]) {
		return %orig(nil);
	} else {
		return %orig;
	}
}

// hide swipe to unlock
- (void)setCallToActionLabel:(id)label {
	if ([libpropr boolForKey:@"hideSwipeToUnlock"]) {
		return %orig(nil);
	} else {
		return %orig;
	}
}

- (void)setCallToActionLabelContainerView:(id)label {
	if ([libpropr boolForKey:@"hideSwipeToUnlock"]) {
		return %orig(nil);
	} else {
		return %orig;
	}
}

- (void)setCallToActionLabelPositionPlaceholderView:(id)label {
	if ([libpropr boolForKey:@"hideSwipeToUnlock"]) {
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
	return [libpropr boolForKey:@"hideAppLibrary"];
}

%end

// enable floating dock
%hook SBFloatingDockController

+ (BOOL)isFloatingDockSupported {
	return [libpropr boolForKey:@"enableFloatingDock"];
}

%end

%ctor {
    NSString *bundleID = NSBundle.mainBundle.bundleIdentifier;
    if ([bundleID isEqualToString:@"com.apple.springboard"] && drm()) {

		[libpropr setupWithDomain:TWEAK_PREFS_PATH];
		
        %init;
    }
	NSLog(@"Partnered with Meth Development LLC");
}
