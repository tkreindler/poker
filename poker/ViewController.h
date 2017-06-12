//
//  ViewController.h
//  poker
//
//  Created by Tristan Kreindler on 6/2/17.
//  Copyright © 2017 ___TRISTANKREINDLER___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *card1;
@property (strong, nonatomic) IBOutlet UIImageView *card2;
@property (strong, nonatomic) IBOutlet UIImageView *card3;
@property (strong, nonatomic) IBOutlet UIImageView *card4;
@property (strong, nonatomic) IBOutlet UIImageView *card5;
@property (strong, nonatomic) IBOutlet UIImageView *Ocard1;
@property (strong, nonatomic) IBOutlet UIImageView *Ocard2;
@property (strong, nonatomic) IBOutlet UIImageView *Ocard3;
@property (strong, nonatomic) IBOutlet UIImageView *Ocard4;
@property (strong, nonatomic) IBOutlet UIImageView *Ocard5;
@property (strong, nonatomic) IBOutlet UILabel *winner;
@property (strong, nonatomic) IBOutlet UILabel *pot;
@property (strong, nonatomic) IBOutlet UILabel *hMoney;
@property (strong, nonatomic) IBOutlet UILabel *oMoney;

- (IBAction)shuffle:(id)sender;
- (IBAction)bet:(id)sender;
- (IBAction)call:(id)sender;
- (IBAction)fold:(id)sender;


@property (strong, nonatomic) IBOutlet UILabel *label;


@end

