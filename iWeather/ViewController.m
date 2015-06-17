//
//  ViewController.m
//  iWeather
//
//  Created by cuong minh on 6/4/15.
//  Copyright (c) 2015 Techmaster. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UIButton *temperature;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *quote;
@property (weak, nonatomic) IBOutlet UILabel *degreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *CLabel;
@property (weak, nonatomic) IBOutlet UILabel *FLabel;

@end

@implementation ViewController
{
    NSArray* quotes;
    NSArray* locations;
    NSArray* photoFiles;
    BOOL _isCelciusMode;
    float _temperatureValue;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    quotes = @[@"Một con ngựa đau, cả tàu bỏ cỏ", @"Có công mài sắt có ngày nên kim", @"Chớ thấy sóng cả mà ngã tay chèo", @"Không có gì quý hơn độc lập tự do hạnh phúc", @"Đi một ngày đàng học một sàng khôn"];
    locations = @[@"Hai Ba Trung, Hanoi", @"Sydney, Australia", @"New York, USA"];
    
    photoFiles = @[@"rain", @"sunny", @"thunder", @"windy"];
    _isCelciusMode = true;
    [self setTemp];
}

- (IBAction)updateWeather:(id)sender {
    int quoteIndex = arc4random_uniform(quotes.count);
    NSLog(@"%d", quoteIndex);
    self.quote.text = quotes[quoteIndex];
    
    int locationIndex = arc4random_uniform(locations.count);
    self.location.text = locations[locationIndex];
    
    int photoIndex = arc4random_uniform(photoFiles.count);
    self.weatherIcon.image = [UIImage imageNamed:photoFiles[photoIndex]];
    
    [self setTemp];
}
- (IBAction)convertTemp:(id)sender {
    _isCelciusMode = !_isCelciusMode;
    if (_isCelciusMode) {
        self.degreeLabel.hidden = false;
        self.CLabel.hidden = false;
        self.FLabel.hidden = true;
        _temperatureValue = (_temperatureValue - 32.0) / 1.8;
    } else {
        self.degreeLabel.hidden = true;
        self.CLabel.hidden = true;
        self.FLabel.hidden = false;
        _temperatureValue = (_temperatureValue * 1.8) + 32.0;
    }
    NSString* string = [NSString stringWithFormat:@"%2.1f", _temperatureValue];
    [self.temperature setTitle:string forState:UIControlStateNormal];
}

- (void) setTemp {
   _temperatureValue = [self getTemperature];
   NSString* string = [NSString stringWithFormat:@"%2.1f", _temperatureValue];
   [self.temperature setTitle:string forState:UIControlStateNormal];
}
- (float) getTemperature {
    //generate a random value look like a celcius temperature
    float temp = 14.0 + arc4random_uniform(18) + (float)arc4random()/(float)UINT32_MAX;
    if (_isCelciusMode) {
        return temp;
    } else {
        return (temp * 1.8) + 32.0;
    }
}

@end
