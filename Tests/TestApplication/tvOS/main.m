/**
 * Copyright (c) 2015-present, Parse, LLC.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

@import UIKit;

@import XCTest;

@interface XCTestLogObserver : NSObject

+ (instancetype)sharedInstance;

@end

@interface XCTestSuite(Private)

+ (instancetype)testSuiteWithBundle:(NSBundle *)bundle;

@end

@interface AppDelegate : NSObject <UIApplicationDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.rootViewController = [[UIViewController alloc] init];
    [window makeKeyAndVisible];

    CFRunLoopPerformBlock(CFRunLoopGetMain(), kCFRunLoopDefaultMode, ^{
        XCTestLogObserver *observer = [XCTestLogObserver sharedInstance];
        XCTestSuite *suite = [XCTestSuite testSuiteWithBundle:[NSBundle mainBundle]];
        [suite runTest];
    });

    return YES;
}

@end

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
