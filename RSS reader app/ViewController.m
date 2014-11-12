//
//  ViewController.m
//  RSS reader app
//
//  Created by Kervins Valcourt on 11/9/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "ViewController.h"
#import "Datasource.h"

@interface ViewController ()
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UITextView *postLabel;
@property (nonatomic,strong)UIImageView *imageview;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIBarButtonItem *sharedButton;
@property (nonatomic,strong)UIBarButtonItem *favoirtedButton;
@property (nonatomic,strong)NSMutableArray *buttonArray;
@end

@implementation ViewController


- (void)loadView {
    [super loadView];
    self.view = [[UIView alloc]init];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 400, 700)];
    _scrollView.pagingEnabled = YES;
   _scrollView.contentSize = CGSizeMake(400, 1700);
    
    _sharedButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareButtonDidFired:)];
    _favoirtedButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"like"] style:UIBarButtonItemStylePlain target:self action:@selector(favoirtedButtonFired:)];
    
    _buttonArray = [NSMutableArray arrayWithObjects: _sharedButton,_favoirtedButton,nil];
    self.navigationItem.rightBarButtonItems = _buttonArray;
    
    _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 70, 70)];
    if (_favorPost) {
        _imageview.image = [UIImage imageWithData:(NSData *)_currentPost.postImage];
        [_buttonArray removeObject:_favoirtedButton];
        [self.navigationItem setRightBarButtonItems:_buttonArray animated:YES];
    } else {
        _imageview.image = _currentPost.postImage;
    }
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 20, 270, 70)];
    _titleLabel.text = _currentPost.title;
    _titleLabel.numberOfLines = 0;
    UIFont *myFontTitle = [UIFont  fontWithName:@"Courier" size:15];
    _titleLabel.font = myFontTitle;
    
    _postLabel = [[UITextView alloc]initWithFrame:CGRectMake(20, 100, 345, 1600)];
    _postLabel.text = _currentPost.post;
    UIFont *myFont = [UIFont  fontWithName:@"Courier" size:16];
    _postLabel.font = myFont;
    _postLabel.editable = NO;
    
    
    [self.view addSubview:_scrollView];
    [_scrollView addSubview:_imageview];
    [_scrollView addSubview:_titleLabel];
    [_scrollView addSubview:_postLabel];
}

- (void)shareButtonDidFired:(id)sender {
    NSArray *objectsToShare = @[self.currentPost.title, self.currentPost.linkToSite];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    
    
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (void)favoirtedButtonFired:(id)sender {
    [[Datasource sharedInstance] addNewPost:_currentPost.title andPost:_currentPost.post andImage:_currentPost.postImage andLink:_currentPost.linkToSite andCost:_currentPost.cost];
}

@end
