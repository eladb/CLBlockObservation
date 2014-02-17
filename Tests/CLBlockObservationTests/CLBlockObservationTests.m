//
//  CLBlockObservationTests.m
//  CLBlockObservation
//
//  Created by Elad Ben-Israel on 12/17/13.
//  Copyright (c) 2013 Citylifeapps. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <NSObject+CLBlockObservation.h>

#define XCTAssertTopCallbackValue(expected) XCTAssertEqualObjects(self.callbacks[self.callbacks.count - 1], expected);

@interface Observable : NSObject
@property (strong, nonatomic) NSString* p1;
@end

@interface Observer : NSObject
@end

@interface CLBlockObservationTests : XCTestCase
@property (strong, nonatomic) Observable* observable;
@property (strong, nonatomic) NSMutableArray* callbacks;
@end

@implementation CLBlockObservationTests

- (void)setUp {
    [super setUp];
    self.callbacks = [[NSMutableArray alloc] init];
}

- (void)tearDown {
    [super tearDown];
}

// observable outlives the observer so only those changes that occur within the lifetime
// of the observer are expected to be called back.
- (void)observerScope {
    Observer* observer = [Observer new];
    Observable* observable = self.observable;
    
    __weak CLBlockObservationTests* myself = self;
    [observable addObserver:observer forKeyPath:@keypath(observable.p1) block:^(id oldValue, id newValue) {
        [myself.callbacks addObject:newValue];
    }];
    XCTAssertTopCallbackValue(@"A1");
    observable.p1 = @"B1";
    XCTAssertTopCallbackValue(@"B1");
    observable.p1 = @"B2";
    XCTAssertTopCallbackValue(@"B2");
}

- (void)testObserverScope {
    self.observable = [Observable new];
    self.observable.p1 = @"A1";
    [self observerScope];
    NSLog(@"observer should have been released when scope was released");
    self.observable.p1 = @"A2";
    XCTAssertTopCallbackValue(@"B2");
    self.observable.p1 = @"A3";
    XCTAssertTopCallbackValue(@"B2");
}

// here the observer outlives it's observable
- (void)observableScope:(Observer*)observer {
    Observable* observable2 = [Observable new];
    observable2.p1 = @"a1";
    
    [observable2 addObserver:observer forKeyPath:@keypath(observable2.p1) block:^(id oldValue, id newValue) {
        [self.callbacks addObject:newValue];
    }];
    XCTAssertTopCallbackValue(@"a1");
    
    observable2.p1 = @"a2";
    XCTAssertTopCallbackValue(@"a2");
}

- (void)testObservableScope {
    Observer* observer2 = [Observer new];
    [self observableScope:observer2];
    XCTAssertTopCallbackValue(@"a2");
}

@end

@implementation Observable
@end

@implementation Observer
@end