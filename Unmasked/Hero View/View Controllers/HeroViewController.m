//
//  HeroViewController.m
//  Unmasked
//
//  Created by Junaid Rajah on 2021/10/19.
//

#import "HeroViewController.h"
#import "HeroViewModel.h"

@interface HeroViewController () {
    HeroViewModel *_viewModel;
    IBOutlet UILabel *heroNameLabel;
    IBOutlet UIImageView *heroPortraitView;
    IBOutlet UILabel *heroIntLabel;
    IBOutlet UILabel *heroDurLabel;
    IBOutlet UILabel *heroStrLabel;
    IBOutlet UILabel *heroComLabel;
    IBOutlet UILabel *heroPowLabel;
    IBOutlet UILabel *heroSpdLabel;
}

@end

@implementation HeroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)set:(SuperheroResponseModel *) hero {
    [self setupViewModel];
    [_viewModel set:hero];
}

- (void)setupViewModel {
    if (!_viewModel) {
        _viewModel = [[HeroViewModel alloc] init];
    }
}
- (IBAction)returnButtonPressed:(UIButton *)sender {
    [self performSegueWithIdentifier:@"returnFromHero" sender:self];
}

- (void)setupView {
    NSURL *url = [NSURL URLWithString: _viewModel.heroImageURL];
    [heroPortraitView loadWithUrl: url];
    heroNameLabel.text = _viewModel.heroName;
    heroIntLabel.text = _viewModel.heroInt;
    heroDurLabel.text = _viewModel.heroDur;
    heroStrLabel.text = _viewModel.heroStr;
    heroComLabel.text = _viewModel.heroCom;
    heroPowLabel.text = _viewModel.heroPow;
    heroSpdLabel.text = _viewModel.heroSpd;
}

@end