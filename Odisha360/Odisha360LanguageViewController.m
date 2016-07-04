//
//  Odisha360LanguageViewController.m
//  OnGO
//
//  Created by Hanuman Kachwa on 29/02/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

#import "Odisha360LanguageViewController.h"

@interface Odisha360LanguageViewController ()

- (IBAction)didTapEnglishLanguage:(id)sender;
- (IBAction)didTapOdishaLanguage:(id)sender;

@end

@implementation Odisha360LanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapEnglishLanguage:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didTapEnglishLanguage:)]) {
        [_delegate didTapEnglishLanguage:sender];
    }
}

- (IBAction)didTapOdishaLanguage:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didTapOdishaLanguage:)]) {
        [_delegate didTapOdishaLanguage:sender];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
