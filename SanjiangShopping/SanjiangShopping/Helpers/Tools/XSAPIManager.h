//
//  XSAPIManager.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 11/5/15.
//  Copyright © 2015 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^successBlock)(id responseObject);
typedef void (^failureBlock)(NSError *error);

@interface XSAPIManager : NSObject

+ (instancetype)manager;

// GET
- (void)GET:(NSString *)URLString parameters:(id)parameters success:(successBlock)success failure:(failureBlock)failure;

@end
