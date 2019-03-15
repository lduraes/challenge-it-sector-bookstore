//
//  Book.m
//  Book Store
//
//  Created by Luiz Duraes on 09/03/19.
//  Copyright © 2019 IT Sector. All rights reserved.
//

#import "Book.h"

@implementation Book

#pragma mark - Overrides

+(JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"bookId": @"id",
                                                                  @"title": @"volumeInfo.title",
                                                                  @"bookDescription": @"volumeInfo.description",
                                                                  @"smallThumbnail": @"volumeInfo.imageLinks.smallThumbnail",
                                                                  @"buyLink": @"saleInfo.buyLink",
                                                                  @"authors": @"volumeInfo.authors"
                                                                  }];
}

+(BOOL)propertyIsOptional:(NSString *)propertyName {
    return [propertyName isEqualToString:@"favorite"];
}

@end

@implementation JSONValueTransformer (CustomTransformer)

- (UIImage *)UIImageFromNSString:(NSString *)string {
    return nil;
}

- (NSString *)JSONObjectFromUIImage:(UIImage *)image {
    return nil;
}

@end
