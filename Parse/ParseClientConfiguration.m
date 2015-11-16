/**
 * Copyright (c) 2015-present, Parse, LLC.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "ParseClientConfiguration.h"

#import "PFHash.h"

@interface ParseClientConfiguration()

@property (nullable, nonatomic, copy, readwrite) NSString *applicationId;
@property (nullable, nonatomic, copy, readwrite) NSString *clientKey;

@property (nonatomic, assign, readwrite, getter=isLocalDatastoreEnabled) BOOL localDatastoreEnabled;

@property (nullable, nonatomic, copy, readwrite) NSString *applicationGroupIdentifier;
@property (nullable, nonatomic, copy, readwrite) NSString *containingApplicationBundleIdentifier;

@end

// We must implement the protocol here otherwise clang issues warnings about non-matching property declarations.
// For some reason if the property declarations are on a separate category, it doesn't care.
@interface ParseClientConfiguration(Private) <ParseMutableClientConfiguration>
@end

@implementation ParseClientConfiguration

///--------------------------------------
#pragma mark - Init
///--------------------------------------

- (instancetype)initWithConfigurationBlock:(void (^)(id<ParseMutableClientConfiguration>))configurationBlock {
    self = [super init];
    if (!self) return nil;

    configurationBlock(self);

    return self;
}

+ (instancetype)configurationWithBlock:(void (^)(id<ParseMutableClientConfiguration>))configurationBlock {
    return [[self alloc] initWithConfigurationBlock:configurationBlock];
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

    ParseClientConfiguration *other = object;
    return ([self.applicationId isEqual:other.applicationId] &&
            [self.clientKey isEqual:other.clientKey] &&
            self.localDatastoreEnabled == other.localDatastoreEnabled &&
            [self.applicationGroupIdentifier isEqual:other.applicationGroupIdentifier] &&
            [self.containingApplicationBundleIdentifier isEqual:other.containingApplicationBundleIdentifier]);
}

///--------------------------------------
#pragma mark - NSCopying
///--------------------------------------

- (instancetype)copyWithZone:(NSZone *)zone {
    return [ParseClientConfiguration configurationWithBlock:^(ParseClientConfiguration *configuration) {
        configuration.applicationId = self.applicationId;
        configuration.clientKey = self.clientKey;
        configuration.localDatastoreEnabled = self.localDatastoreEnabled;
        configuration.applicationGroupIdentifier = self.applicationGroupIdentifier;
        configuration.containingApplicationBundleIdentifier = self.containingApplicationBundleIdentifier;
    }];
}

@end
