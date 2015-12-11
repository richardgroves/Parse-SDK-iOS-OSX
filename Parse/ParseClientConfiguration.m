/**
 * Copyright (c) 2015-present, Parse, LLC.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "ParseClientConfiguration.h"
#import "ParseClientConfiguration_Private.h"

#import "PFAssert.h"
#import "PFApplication.h"
#import "PFCommandRunningConstants.h"
#import "PFFileManager.h"
#import "PFHash.h"

@implementation ParseClientConfiguration

///--------------------------------------
#pragma mark - Init
///--------------------------------------

+ (instancetype)emptyConfiguration {
    return [super new];
}

- (instancetype)initWithBlock:(void (^)(id<ParseMutableClientConfiguration>))configurationBlock {
    self = [super init];
    if (!self) return nil;

    _networkRetryAttempts = PFCommandRunningDefaultMaxAttemptsCount;

    configurationBlock(self);

    return self;
}

+ (instancetype)configurationWithBlock:(void (^)(id<ParseMutableClientConfiguration>))configurationBlock {
    return [[self alloc] initWithBlock:configurationBlock];
}

///--------------------------------------
#pragma mark - Properties
///--------------------------------------

- (void)setApplicationId:(NSString *)applicationId {
    PFConsistencyAssert([applicationId length], @"'applicationId' should not be nil.");
    _applicationId = [applicationId copy];
}

- (void)setClientKey:(NSString *)clientKey {
    PFConsistencyAssert([clientKey length], @"'clientKey' should not be nil.");
    _clientKey = [clientKey copy];
}

- (void)setApplicationGroupIdentifier:(NSString *)applicationGroupIdentifier {
    PFConsistencyAssert(
        applicationGroupIdentifier == nil ||
        [PFFileManager isApplicationGroupContainerReachableForGroupIdentifier:applicationGroupIdentifier],
        @"ApplicationGroupContainer is unreachable. Please double check your Xcode project settings."
    );

    _applicationGroupIdentifier = [applicationGroupIdentifier copy];
}

- (void)setContainingApplicationBundleIdentifier:(NSString *)containingApplicationBundleIdentifier {
    PFConsistencyAssert(containingApplicationBundleIdentifier == nil ||
                        [PFApplication currentApplication].extensionEnvironment,
                        @"'containingApplicationBundleIdentifier' must be non-nil in extension environment");

    PFConsistencyAssert(containingApplicationBundleIdentifier != nil ||
                        ![PFApplication currentApplication].extensionEnvironment,
                        @"'containingApplicationBundleIdentifier' must be nil in non-extension environment");

    _containingApplicationBundleIdentifier = containingApplicationBundleIdentifier;
}

- (void)_resetDataSharingIdentifiers {
    _applicationGroupIdentifier = nil;
    _containingApplicationBundleIdentifier = nil;
}

///--------------------------------------
#pragma mark - NSObject
///--------------------------------------

- (NSUInteger)hash {
    return PFIntegerPairHash(self.applicationId.hash, self.clientKey.hash);
}

- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[ParseClientConfiguration class]]) {
        return NO;
    }

#define EQUAL_OBJECTS(a, b) ((a) == (b) || [(a) isEqual:(b)])
    ParseClientConfiguration *other = object;
    return (EQUAL_OBJECTS(self.applicationId, other.applicationId) &&
            EQUAL_OBJECTS(self.clientKey, other.clientKey) &&
            self.localDatastoreEnabled == other.localDatastoreEnabled &&
            EQUAL_OBJECTS(self.applicationGroupIdentifier, other.applicationGroupIdentifier) &&
            EQUAL_OBJECTS(self.containingApplicationBundleIdentifier, other.containingApplicationBundleIdentifier) &&
            self.networkRetryAttempts == other.networkRetryAttempts);
#undef EQUAL_OBJECTS
}

///--------------------------------------
#pragma mark - NSCopying
///--------------------------------------

- (instancetype)copyWithZone:(NSZone *)zone {
    return [ParseClientConfiguration configurationWithBlock:^(ParseClientConfiguration *configuration) {
        // Use direct assignment to skip over all of the assertions that may fail if we're not fully initialized yet.
        configuration->_applicationId = self->_applicationId;
        configuration->_clientKey = self->_clientKey;
        configuration->_localDatastoreEnabled = self->_localDatastoreEnabled;
        configuration->_applicationGroupIdentifier = self->_applicationGroupIdentifier;
        configuration->_containingApplicationBundleIdentifier = self->_containingApplicationBundleIdentifier;
        configuration->_networkRetryAttempts = self->_networkRetryAttempts;
    }];
}

@end
