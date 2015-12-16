/**
 * Copyright (c) 2015-present, Parse, LLC.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "PFConstants.h"

NSInteger const PARSE_API_VERSION          = 2;

#if TARGET_OS_IOS
NSString *const kPFDeviceType                = @"ios";
#elif PF_TARGET_OS_OSX
NSString *const kPFDeviceType                = @"osx";
#elif TARGET_OS_TV
NSString *const kPFDeviceType                = @"apple-tv";
#elif TARGET_OS_WATCH
NSString *const kPFDeviceType                = @"apple-watch";
#endif

NSString *const kPFParseServer               = @"https://api.parse.com";

NSString *const PFParseErrorDomain = @"Parse";

///--------------------------------------
#pragma mark - Network Notifications
///--------------------------------------

NSString *const PFNetworkWillSendURLRequestNotification = @"PFNetworkWillSendURLRequestNotification";
NSString *const PFNetworkDidReceiveURLResponseNotification = @"PFNetworkDidReceiveURLResponseNotification";
NSString *const PFNetworkNotificationURLRequestUserInfoKey = @"PFNetworkNotificationURLRequestUserInfoKey";
NSString *const PFNetworkNotificationURLResponseUserInfoKey = @"PFNetworkNotificationURLResponseUserInfoKey";
NSString *const PFNetworkNotificationURLResponseBodyUserInfoKey = @"PFNetworkNotificationURLResponseBodyUserInfoKey";
