//
//  HeroViewController.m
//  Unmasked
//
//  Created by Junaid Rajah on 2021/10/19.
//

#import "HeroViewController.h"
#import "HeroViewModel.h"
#import <UnmaskedEngine/UnmaskedEngine-Swift.h>

@interface HeroViewController () {
    HeroViewModel *_viewModel;
    BOOL fromSearchView;
    NSInteger groupFromCollection;
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

- (void)setReturn:(BOOL) fromSearch {
    fromSearchView = fromSearch;
}

- (void)setGroup:(NSInteger) heroGroup {
    groupFromCollection = heroGroup;
}

- (void)setupViewModel {
    if (!_viewModel) {
        _viewModel = [[HeroViewModel alloc] init];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"returnToCollectionList"]) {
      HeroCollectionViewController *vc = segue.destinationViewController;
      vc.heroGroup = groupFromCollection;
  }
}

- (IBAction)returnButtonPressed:(UIButton *)sender {
    if (fromSearchView) {
        [self performSegueWithIdentifier:@"returnFromHero" sender:self];
    } else {
        [self performSegueWithIdentifier:@"returnToCollectionList" sender:self];
    }
}

- (void)setupView {
    NSURL *url = [NSURL URLWithString: _viewModel.heroImageURL];
    [heroPortraitView loadWithUrl: url];
    heroNameLabel.text = _viewModel.heroName;
    heroIntLabel.text = _viewModel.heroIntelligence;
    heroDurLabel.text = _viewModel.heroDurability;
    heroStrLabel.text = _viewModel.heroStrength;
    heroComLabel.text = _viewModel.heroCombat;
    heroPowLabel.text = _viewModel.heroPower;
    heroSpdLabel.text = _viewModel.heroSpeed;
}

@end
