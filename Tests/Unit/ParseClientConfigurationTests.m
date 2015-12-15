/**
 * Copyright (c) 2015-present, Parse, LLC.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

@import Foundation;

#import "PFTestCase.h"
#import "ParseClientConfiguration.h"
#import "ParseClientConfiguration_Private.h"

@interface ParseClientConfigurationTests : PFTestCase
@end

@implementation ParseClientConfigurationTests

- (void)testConfigurationWithBlock {
    ParseClientConfiguration *configuration = [ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        configuration.applicationId = @"foo";
        configuration.clientKey = @"bar";
        configuration.localDatastoreEnabled = YES;
        configuration.networkRetryAttempts = 1337;
    }];

    XCTAssertEqualObjects(configuration.applicationId, @"foo");
    XCTAssertEqualObjects(configuration.clientKey, @"bar");
    XCTAssertTrue(configuration.localDatastoreEnabled);
    XCTAssertEqual(configuration.networkRetryAttempts, 1337);
}

- (void)testEqual {
    ParseClientConfiguration *configurationA = [(id)[ParseClientConfiguration alloc] init];
    ParseClientConfiguration *configurationB = [(id)[ParseClientConfiguration alloc] init];
    XCTAssertEqualObjects(configurationA, configurationB);
    XCTAssertEqual(configurationA.hash, configurationB.hash);

    configurationA.applicationId = configurationB.applicationId = @"foo";
    XCTAssertEqualObjects(configurationA, configurationB);
    XCTAssertEqual(configurationA.hash, configurationB.hash);
    configurationB.applicationId = @"test";
    XCTAssertNotEqualObjects(configurationA, configurationB);
    configurationB.applicationId = configurationA.applicationId;

    configurationA.clientKey = configurationB.clientKey = @"bar";
    XCTAssertEqualObjects(configurationA, configurationB);
    XCTAssertEqual(configurationA.hash, configurationB.hash);
    configurationB.clientKey = @"test";
    XCTAssertNotEqualObjects(configurationA, configurationB);
    configurationB.clientKey = configurationA.clientKey;

    configurationA.localDatastoreEnabled = configurationB.localDatastoreEnabled = YES;
    XCTAssertEqualObjects(configurationA, configurationB);
    XCTAssertEqual(configurationA.hash, configurationB.hash);
    configurationB.localDatastoreEnabled = NO;
    XCTAssertNotEqualObjects(configurationA, configurationB);
    configurationB.localDatastoreEnabled = configurationA.localDatastoreEnabled;

    configurationA.networkRetryAttempts = configurationB.networkRetryAttempts = 1337;
    XCTAssertEqualObjects(configurationA, configurationB);
    XCTAssertEqual(configurationA.hash, configurationB.hash);
    configurationB.networkRetryAttempts = 7;
    XCTAssertNotEqualObjects(configurationA, configurationB);
}

- (void)testCopy {
    ParseClientConfiguration *configurationA = [ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        configuration.applicationId = @"foo";
        configuration.clientKey = @"bar";
        configuration.localDatastoreEnabled = YES;
        configuration.networkRetryAttempts = 1337;
    }];

    ParseClientConfiguration *configurationB = [configurationA copy];

    XCTAssertNotEqual(configurationA, configurationB);
    XCTAssertEqualObjects(configurationA, configurationB);

    configurationA.localDatastoreEnabled = NO;

    XCTAssertNotEqualObjects(configurationA, configurationB);

    XCTAssertEqualObjects(configurationB.applicationId, @"foo");
    XCTAssertEqualObjects(configurationB.clientKey, @"bar");
    XCTAssertTrue(configurationB.localDatastoreEnabled);
    XCTAssertEqual(configurationB.networkRetryAttempts, 1337);
}

@end
