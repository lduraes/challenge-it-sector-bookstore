//
//  Book.h
//  Book Store
//
//  Created by Luiz Duraes on 09/03/19.
//  Copyright © 2019 IT Sector. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface Book : JSONModel

@property (nonatomic) NSString *bookId;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString <Optional> *bookDescription;
@property (nonatomic) NSString <Optional> *smallThumbnail;
@property (nonatomic) NSArray <Optional> *authors;
@property (nonatomic) NSString <Optional> *buyLink;
@property (nonatomic) UIImage <Optional> *thumbImage;
@property (assign) BOOL favorite;

@end

NS_ASSUME_NONNULL_END
