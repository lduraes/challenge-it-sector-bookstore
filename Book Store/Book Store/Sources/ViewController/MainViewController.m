//
//  MainViewController.m
//  Book Store
//
//  Created by Luiz Duraes on 09/03/19.
//  Copyright © 2019 IT Sector. All rights reserved.
//

#import "MainViewController.h"
#import "BookBusiness.h"
#import "BookListCollectionViewCell.h"
#import "DetailViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>

static NSString *const kCellIdentifier = @"BookListCell";
static NSString *const kSegueMainToDetail = @"SegueMainToDetail";
static NSString *const kLoadingBooks = @"Loading books...";
static NSString *const kFilterButtonNormalState = @"filter";
static NSString *const kFilterButtonClickedState = @"filter-full";
static NSInteger const kFilterButtonNormalStateTag = 0;
static NSInteger const kFilterButtonClickedStateTag = 1;
static CGFloat const kCollectionViewPadding = 20;

@interface MainViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray <Book *> * _Nonnull books;
@property (strong, nonatomic) NSMutableArray <Book *> * _Nonnull localStorageBooks;
@property (strong, nonatomic) Book * _Nonnull selectedBook;
@property (assign) NSInteger page;
@property (assign) BOOL loadingLocalBooks;

@end

@implementation MainViewController

#pragma mark - Overrides

-(void)awakeFromNib {
    [super awakeFromNib];
    [self initializeObjects];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if(self.loadingLocalBooks) {
        [self loadLocalData];
    } else {
        [self loadAsyncData];
    }
}

#pragma mark - IBActions

-(IBAction)actionFilterBooks:(UIBarButtonItem *)sender {
    if(sender.tag == kFilterButtonNormalStateTag) {
        sender.tag = kFilterButtonClickedStateTag;
        sender.image = [UIImage imageNamed:kFilterButtonClickedState];
        
        self.loadingLocalBooks = YES;
        [self loadLocalData];
    } else {
        sender.tag = kFilterButtonNormalStateTag;
        sender.image = [UIImage imageNamed:kFilterButtonNormalState];
        
        self.loadingLocalBooks = NO;
        [self loadAsyncData];
    }
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.loadingLocalBooks ? self.localStorageBooks.count : self.books.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Book *book = self.loadingLocalBooks ? [self.localStorageBooks objectAtIndex:indexPath.row] : [self.books objectAtIndex:indexPath.row];

    BookListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    [cell loadCellWithBooks:book];

    return cell;
}

#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if((!self.loadingLocalBooks) && (indexPath.row == self.books.count - 1) && ![SVProgressHUD isVisible]) {
        self.page++;
        [self loadAsyncData];
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedBook = self.loadingLocalBooks ? self.localStorageBooks[indexPath.row] : self.books[indexPath.row];

    BookListCollectionViewCell *cell = (BookListCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    self.selectedBook.thumbImage = cell.thumbImageView.image;

    [self performSegueWithIdentifier:kSegueMainToDetail sender:self];
}

#pragma mark - UICollectionViewDelegateFlowLayout

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(kCollectionViewPadding, kCollectionViewPadding, kCollectionViewPadding, kCollectionViewPadding);
}

#pragma mark - Private methods

-(void)initializeObjects {
    self.books = [NSMutableArray array];
    self.localStorageBooks = [NSMutableArray array];
    self.page = 0;
    self.loadingLocalBooks = NO;
}

-(void)loadAsyncData {
    [SVProgressHUD showWithStatus:kLoadingBooks];
   
    __weak typeof (self) weakSelf = self;
    [BookBusiness listBookWithPage:self.page withCompletionHandler:^(NSArray<Book *> * _Nullable books, NSError * _Nullable error) {
        [weakSelf.books addObjectsFromArray:books];
        [weakSelf.collectionView reloadData];
        [SVProgressHUD dismiss];
    }];
}

-(void)loadLocalData {
    self.localStorageBooks = [BookBusiness retrieveBookList];
    [self.collectionView reloadData];
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController *detailViewController = (DetailViewController *)segue.destinationViewController;
    detailViewController.book = self.selectedBook;
}

@end
