//
//  NSObject+Binding.h
//  clutils
//
//  Created by Elad Ben-Israel on 12/17/13.
//  Copyright (c) 2013 Citylifeapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "keypath.h"

@interface NSObject (Binding)

- (void)addObserver:(NSObject *)observer forKeyPaths:(NSArray *)keyPaths block:(void(^)(void))block;
- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath block:(void(^)(id oldValue, id newValue))block;

@end
