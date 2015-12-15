/**
 * Copyright (c) 2015-present, Parse, LLC.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import <Foundation/Foundation.h>

#import <Parse/PFConstants.h>

NS_ASSUME_NONNULL_BEGIN

/**
 The `ParseMutableClientConfiguration` represents a `ParseClientConfiguration` object that can be mutated.

 It is only usable during the execution of the block passed to `ParseClientConfiguration.+configurationWithBlock:`,
 during which time you should set your properties on it, similar to the following:

 ```
 configuration.applicationId = @"<#YOUR APPLICATION ID#>"
 configuration.clientKey = @"<#YOUR CLIENT KEY#>"
 configuration.localDatastoreEnabled = true
 ```
 */
@protocol ParseMutableClientConfiguration <NSObject>

/**
 The Parse.com application id to configure the SDK with.
 */
@property (nullable, nonatomic, copy, readwrite) NSString *applicationId;

/**
 The Parse.com client key to configure the SDK with.
 */
@property (nullable, nonatomic, copy, readwrite) NSString *clientKey;

/**
 Whether or not to enable pinning in the SDK.

 The default value is `NO`.
 */
@property (nonatomic, assign, readwrite, getter=isLocalDatastoreEnabled) BOOL localDatastoreEnabled;

/**
 When set, enables data sharing with an application group identifier.

 After enabling - Local Datastore, `PFUser.+currentUser`, `PFInstallation.+currentInstallation` and all eventually commands
 are going to be available to every application/extension in a group that have the same Parse applicationId.
 */
@property (nullable, nonatomic, copy, readwrite) NSString *applicationGroupIdentifier;

/**
 When set, controls the bundle identifier of the parent bundle to connect to.

 @warning This property should only be set from inside an extension environment.
 */
@property (nullable, nonatomic, copy, readwrite) NSString *containingApplicationBundleIdentifier;

/**
 The maximum number of retry attempts to make upon a failed network request.
 */
@property (nonatomic, assign, readwrite) NSUInteger networkRetryAttempts;

@end

/*!
 The `ParseClientConfiguration` represents the local configuration of the SDK to connect to the server with.

 These configurations can be stored, copied, and compared, but cannot be safely changed once the SDK is initialized.

 Use this object to construct a configuration for the SDK in your application, and pass it to
 `Parse.+initializeWithConfiguration:`.
 */
@interface ParseClientConfiguration : NSObject <NSCopying>

/**
 The Parse.com application id to configure the SDK with.
 */
@property (nullable, nonatomic, copy, readonly) NSString *applicationId;

/**
 The Parse.com client key to configure the SDK with.
 */
@property (nullable, nonatomic, copy, readonly) NSString *clientKey;

/**
 Whether or not to enable pinning in the SDK.

 The default value is `NO`.
 */
@property (nonatomic, assign, readonly, getter=isLocalDatastoreEnabled) BOOL localDatastoreEnabled;

/**
 When set, enables data sharing with an application group identifier.

 After enabling - Local Datastore, `PFUser.+currentUser`, `PFInstallation.+currentInstallation` and all eventually
 commands are going to be available to every application/extension in a group that have the same Parse applicationId.
 */
@property (nullable, nonatomic, copy, readonly) NSString *applicationGroupIdentifier;

/**
 When set, controls the bundle identifier of the parent bundle to connect to.

 @warning This property should only be set from inside an extension environment.
 */
@property (nullable, nonatomic, copy, readonly) NSString *containingApplicationBundleIdentifier;

/**
 The maximum number of retry attempts to make upon a failed network request.
 */
@property (nonatomic, assign, readonly) NSUInteger networkRetryAttempts;

+ (instancetype)configurationWithBlock:(void (^)(id<ParseMutableClientConfiguration> configuration))configurationBlock;

+ (instancetype) new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
