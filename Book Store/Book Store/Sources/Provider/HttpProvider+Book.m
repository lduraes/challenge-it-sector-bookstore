//
//  HttpProvider+Book.m
//  Book Store
//
//  Created by Luiz Duraes on 09/03/19.
//  Copyright © 2019 IT Sector. All rights reserved.
//

#import "HttpProvider+Book.h"

static NSString *const kUri = @"/books/v1/volumes?q=ios";
static NSString *const kMaxResults = @"&maxResults=";
static NSString *const kStartIndex = @"&startIndex=";


@implementation HttpProvider (Book)

#pragma mark - Public methods

-(void)listBooksWithMaxResults:(NSInteger)maxResults
                withStartIndex:(NSInteger)startIndex
         withCompletionHandler:(HttpProviderItems)handler {
    NSString *bookFullUrl = [self bookEndpointWithMaxResults:maxResults withStartIndex:startIndex];
    
    [self GET:bookFullUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        handler(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        handler(@{}, error);
    }];
}

#pragma mark - Private methods

-(NSString *)bookEndpointWithMaxResults:(NSInteger)maxResults
                         withStartIndex:(NSInteger)startIndex {
    NSString *endpoint = [NSString stringWithFormat:@"%@%@%@%@%@", kUri, kMaxResults, @(maxResults), kStartIndex, @(startIndex)];
    
    return endpoint;
}

@end
