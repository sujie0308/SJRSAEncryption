//
//  RSACode.h
//  contact
//
//  Created by susulo on 16/4/21.
//  Copyright © 2016年susulo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSACode : NSObject

@property (nonatomic, strong)NSString *mod;
@property (nonatomic, assign)NSUInteger *exp;

+ (instancetype)sharedInstance;

- (NSString *)encode:(NSString *)rawString;

- (NSString *)decode:(NSString *)rawString;
@end
