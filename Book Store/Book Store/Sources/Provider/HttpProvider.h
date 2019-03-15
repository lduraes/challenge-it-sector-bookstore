//
//  HttpProvider.h
//  Book Store
//
//  Created by Luiz Duraes on 09/03/19.
//  Copyright © 2019 IT Sector. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface HttpProvider : AFHTTPSessionManager

+(instancetype)sharedProvider;

@end

NS_ASSUME_NONNULL_END
