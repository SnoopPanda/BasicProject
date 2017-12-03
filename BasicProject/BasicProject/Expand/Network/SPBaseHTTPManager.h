//
//  SPBaseHTTPManager.h
//  BasicProject
//
//  Created by WangJie on 2017/12/2.
//  Copyright © 2017年 SnoopPanda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface SPBaseHTTPManager : NSObject

- (void)getWithPath:(NSString *)path params:(NSDictionary *)params completion:(void(^)(NSDictionary *dictionary, NSError *error))completion;

- (void)postWithPath:(NSString *)path params:(NSDictionary *)params completion:(void(^)(NSDictionary *dictionary, NSError *error))completion;

@end
