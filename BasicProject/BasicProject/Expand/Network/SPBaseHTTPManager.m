//
//  SPBaseHTTPManager.m
//  BasicProject
//
//  Created by WangJie on 2017/12/2.
//  Copyright © 2017年 SnoopPanda. All rights reserved.
//

#import "SPBaseHTTPManager.h"
#import <CommonCrypto/CommonDigest.h>

@interface SPBaseHTTPManager()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation SPBaseHTTPManager

- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL: [NSURL URLWithString:UTIL_BASE_URL]];
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.manager.responseSerializer.acceptableContentTypes = [self.manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:[NSArray arrayWithObjects:@"text/plain", @"text/html", nil]];
    }
    return self;
}


- (void)getWithPath:(NSString *)path params:(NSDictionary *)params completion:(void(^)(NSDictionary *dictionary, NSError *error))completion {
    
    NSDictionary *signParams = [self signParams:params];
    [self GET:path parameters:signParams success:^(NSURLSessionDataTask *operation, id responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
        if (completion) {
            completion(nil, error);
        }
    }];
}

- (void)postWithPath:(NSString *)path params:(NSDictionary *)params completion:(void(^)(NSDictionary *dictionary, NSError *error))completion {
    
    NSDictionary *signParams = [self signParams:params];
    [self POST:path parameters:signParams success:^(NSURLSessionDataTask *operation, id responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        if (completion) {
            completion(nil, error);
        }
    }];
}

- (NSDictionary *)signParams:(NSDictionary *)params {
    
    NSString *spliceString = [self spliceString:params];
    NSString *signString = [self signString:spliceString];
    return @{ @"sign" : signString };
}

- (NSString *)spliceString:(NSDictionary *)params {
    NSArray *keyArray = [params allKeys];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    NSArray *orderedArray = [keyArray sortedArrayUsingDescriptors:@[sortDescriptor]];
    NSMutableArray *paramsArr = [NSMutableArray array];
    for (NSString *key in orderedArray) {
        NSString *paramStr = [NSString stringWithFormat:@"%@=%@", key, params[key]];
        [paramsArr addObject:paramStr];
    }
    
    NSString *spliceString = [NSString stringWithFormat:@"%@%@",[paramsArr componentsJoinedByString:@"&"], @"xxxxdasdasd"];
    return spliceString;
}

- (NSString *)signString:(NSString *)string {
    
    if (string  == nil || [string length] == 0)  {
        return nil;
    }
    const char *cString = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cString, (CC_LONG)strlen(cString), digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

#pragma mark -

- (void )POST:(NSString *)URLString
   parameters:(NSDictionary *)parameters
      success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
      failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:parameters];
    [self.manager POST:URLString parameters:dict progress:nil success:success failure:failure];
}


- (void)GET:(NSString *)URLString
 parameters:(NSDictionary *)parameters
    success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:parameters];
    [self.manager GET:URLString parameters:dict progress:nil success:success failure:failure];
}

@end
