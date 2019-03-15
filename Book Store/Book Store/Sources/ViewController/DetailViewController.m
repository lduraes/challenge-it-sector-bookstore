//
//  DetailViewController.m
//  Book Store
//
//  Created by Luiz Duraes on 09/03/19.
//  Copyright © 2019 IT Sector. All rights reserved.
//

#import "DetailViewController.h"
#import "BookBusiness.h"

static NSString *const kBuyButton = @"Buy this book";
static NSString *const kFavoriteButtonNormalState = @"star";
static NSString *const kFavoriteButtonClickedState = @"star-full";
static NSInteger const kFavoriteButtonNormalStateTag = 0;
static NSInteger const kFavoriteButtonClickedStateTag = 1;

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (weak, nonatomic) IBOutlet UILabel *bookTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthorsLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyLinkButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *favoriteBarButtonItem;

@end

@implementation DetailViewController

#pragma mark - Overrides

-(void)viewDidLoad {
    [super viewDidLoad];
    [self loadBookInfo];
}

#pragma mark - IBActions

- (IBAction)actionUpdateFavoriteStatus:(UIBarButtonItem *)sender {
    if(sender.tag == kFavoriteButtonNormalStateTag) {
        sender.tag = kFavoriteButtonClickedStateTag;
        sender.image = [UIImage imageNamed:kFavoriteButtonClickedState];
        self.book = [BookBusiness saveBook:self.book];
    } else {
        sender.tag = kFavoriteButtonNormalStateTag;
        sender.image = [UIImage imageNamed:kFavoriteButtonNormalState];
        self.book = [BookBusiness removeBook:self.book];
    }
}

#pragma mark - Private methods

-(void)loadBookInfo {
    NSString *authors = [self.book.authors componentsJoinedByString:@", "];

    self.thumbImageView.image = self.book.thumbImage;
    self.bookTitleLabel.text = self.book.title;
    self.bookAuthorsLabel.text = authors;
    self.bookDescriptionLabel.text = self.book.bookDescription;
    
    if(self.book.buyLink) {
        self.buyLinkButton.enabled = YES;
        [self.buyLinkButton setTitle:kBuyButton forState:UIControlStateNormal];
        [self.buyLinkButton addTarget:self action:@selector(actionBuyBook:) forControlEvents:UIControlEventTouchDown];
    }
    
    if(self.book.favorite) {
        self.favoriteBarButtonItem.tag = kFavoriteButtonClickedStateTag;
        self.favoriteBarButtonItem.image = [UIImage imageNamed:kFavoriteButtonClickedState];
    }
}

-(void)actionBuyBook:(UIButton *) sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.book.buyLink] options:@{} completionHandler:nil];
}

@end
