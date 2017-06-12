//
//  ViewController.m
//  poker
//
//  Created by Tristan Kreindler on 6/2/17.
//  Copyright © 2017 ___TRISTANKREINDLER___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

static NSInteger deck[52];
static NSInteger hand[5];
static NSInteger opponent[5];
static NSInteger handN[5];
static NSInteger handDupesN[15];
static NSInteger handDupesS[5];
static NSInteger opponentDupesN[15];
static NSInteger opponentDupesS[5];
static NSInteger opponentN[5];
static NSInteger handS[5];
static NSInteger opponentS[5];
static NSInteger handScore;
static NSInteger opponentScore;
static NSInteger handHighest;
static NSInteger opponentHighest;
static NSInteger handMoney = 1000;
static NSInteger opponentMoney = 1000;
static NSInteger potMoney = 0;
static NSInteger callAmount = 0;
static NSInteger callCounter = 0;
static bool myTurn;
static NSString *OhandCard1;
static NSString *OhandCard2;
static NSString *OhandCard3;
static NSString *OhandCard4;
static NSString *OhandCard5;

@implementation ViewController

-(void)updateText {
    _oMoney.text = [NSString stringWithFormat:@"%ld", (long)opponentMoney];
    _hMoney.text = [NSString stringWithFormat:@"%ld", (long)handMoney];
    _pot.text = [NSString stringWithFormat:@"%ld", (long)potMoney];
    
    
    
}

-(void)checkBroke {
    if(handMoney <= 0 || opponentMoney <= 0) {
        if (handScore > opponentScore) {
            callCounter = 0;
            handMoney = handMoney + potMoney;
            [self startRound];
            _winner.text = @"He Lost";
            [self updateText];
        } else if (handScore < opponentScore) {
            callCounter = 0;
            opponentMoney = opponentMoney + potMoney;
            [self startRound];
            _winner.text = @"He Won";
            [self updateText];
        } else {
            NSLog(@"You broke the system");
        }
        if(handMoney <= 0 || opponentMoney <= 0) {
            //lose or win
        }
    }
}

-(void)startRound {
    [self checkVictory];
    callCounter = 0;
    callAmount = 0;
    potMoney = 0;
    handMoney = handMoney - 100;
    opponentMoney = opponentMoney - 100;
    potMoney = potMoney + 200;
    myTurn = true;
    
    
    _Ocard1.image = [UIImage imageNamed: OhandCard1];
    _Ocard2.image = [UIImage imageNamed: OhandCard2];
    _Ocard3.image = [UIImage imageNamed: OhandCard3];
    _Ocard4.image = [UIImage imageNamed: OhandCard4];
    _Ocard5.image = [UIImage imageNamed: OhandCard5];
    
    [self shuffle];
    [self displayHand];
    [self updateText];
    
    
    
}

-(void)checkFold {
    if (callCounter == 2) {
        if (handScore > opponentScore) {
            callCounter = 0;
            handMoney = handMoney + potMoney;
            [self startRound];
            _winner.text = @"He Lost";
            [self updateText];
        } else if (handScore < opponentScore) {
            callCounter = 0;
            opponentMoney = opponentMoney + potMoney;
            [self startRound];
            _winner.text = @"He Won";
            [self updateText];
        } else {
            NSLog(@"You broke the system");
        }
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    handMoney = 1000;
    opponentMoney = 1000;
    potMoney = 0;
    
    
    for (NSInteger i = 0; i < 52; i++) { //assigning deck values
        NSInteger x = i;
        while (x > 12) {
            x = x - 13;
        }
        deck[i] = x + 1;
        x = i;
        if(i < 13) {//suit 1 is spades, suit 2 is clubs, suit 3 is diamonds, suit four is hearts
            x = 1;
        } else if(i < 26) {//suit 1 is spades, suit 2 is clubs, suit 3 is diamonds, suit four is hearts
            x = 2;
        } else if(i < 39) {//suit 1 is spades, suit 2 is clubs, suit 3 is diamonds, suit four is hearts
            x = 3;
        } else if(i < 52) {//suit 1 is spades, suit 2 is clubs, suit 3 is diamonds, suit four is hearts
            x = 4;
        }
        deck[i] = x * 100 + deck[i];
    }
    //fix my idiot mistake
    deck[0] = 114;
    deck[13] = 214;
    deck[26] = 314;
    deck[39] = 414;
    
    [self startRound];
    _Ocard1.image = [UIImage imageNamed: @"card"];
    _Ocard2.image = [UIImage imageNamed: @"card"];
    _Ocard3.image = [UIImage imageNamed: @"card"];
    _Ocard4.image = [UIImage imageNamed: @"card"];
    _Ocard5.image = [UIImage imageNamed: @"card"];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)shuffle:(id)sender {
    [self shuffle];
    [self displayHand];
}

- (IBAction)bet:(id)sender {
    callCounter = 0;
    callAmount = callAmount + 100;
    handMoney = handMoney - callAmount;
    potMoney = potMoney + callAmount;
    myTurn = false;
    _Ocard1.image = [UIImage imageNamed: @"card"];
    _Ocard2.image = [UIImage imageNamed: @"card"];
    _Ocard3.image = [UIImage imageNamed: @"card"];
    _Ocard4.image = [UIImage imageNamed: @"card"];
    _Ocard5.image = [UIImage imageNamed: @"card"];
    [self updateText];
    [self opponentChoose];
    
}

- (IBAction)call:(id)sender {
    callCounter++;
    handMoney = handMoney - callAmount;
    potMoney = potMoney + callAmount;
    callAmount = 0;
    myTurn = false;
    _Ocard1.image = [UIImage imageNamed: @"card"];
    _Ocard2.image = [UIImage imageNamed: @"card"];
    _Ocard3.image = [UIImage imageNamed: @"card"];
    _Ocard4.image = [UIImage imageNamed: @"card"];
    _Ocard5.image = [UIImage imageNamed: @"card"];
    [self checkFold];
    [self updateText];
    [self opponentChoose];
    
    
}

- (IBAction)fold:(id)sender {
    callCounter = 0;
    opponentMoney = opponentMoney + potMoney;
    [self startRound];
    [self updateText];
    [self opponentChoose];
    
    
}

-(void)opponentChoose {
    NSInteger randomizer = (arc4random_uniform(6));
    if (opponentScore < 100) {
        if (randomizer < 2) {
            [self oFold];
        } else {
            [self oCall];
        }
    } else if (opponentScore >= 100 && opponentScore < 200) {
        if (randomizer == 0) {
            [self oFold];
        } else if (randomizer == 5) {
            [self oBet];
        } else {
            [self oCall];
        }
    } else if (opponentScore >= 200 && opponentScore < 300) {
        if (randomizer < 2) {
            [self oBet];
        } else {
            [self oCall];
        }
    } else if (opponentScore >= 300 && opponentScore < 400) {
        if (randomizer < 3) {
            [self oBet];
        } else {
            [self oCall];
        }
    } else if (opponentScore >= 400 && opponentScore < 500) {
        if (randomizer < 4) {
            [self oBet];
        } else {
            [self oCall];
        }
    } else if (opponentScore >= 500) {
        if (randomizer < 5) {
            [self oBet];
        } else {
            [self oCall];
        }
    }
    
    
}

-(void)oCall {
    callCounter++;
    opponentMoney = opponentMoney - callAmount;
    potMoney = potMoney + callAmount;
    callAmount = 0;
    myTurn = true;
    _winner.text = @"He Called";
    [self checkFold];
    [self updateText];
}

-(void)oBet {
    callCounter = 0;
    callAmount = callAmount + 100;
    opponentMoney = opponentMoney - callAmount;
    potMoney = potMoney + callAmount;
    myTurn = true;
    _winner.text = @"He Bet";
    [self updateText];
}

-(void)oFold {
    callCounter = 0;
    handMoney = handMoney + potMoney;
    [self startRound];
    _winner.text = @"He Folded";
    [self updateText];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSString *identifier;
    BOOL isSaved = [[NSUserDefaults standardUserDefaults] stringForKey:@"loginSaved"];
    if (isSaved)
    {
        identifier=@"home";
    }
    else
    {
        identifier=@"login";
    }
    UIStoryboard *storyboardobj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *screen = [storyboardobj instantiateViewControllerWithIdentifier:identifier];
    
    
    // Override point for customization after application launch.
    return YES;
}

-(void)checkVictory {
    if(handMoney <= 0 ) {
        UIStoryboard *storyboardobj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *screen = [storyboardobj instantiateViewControllerWithIdentifier:@"lose"];
        [self presentViewController:screen animated:YES completion:nil];
        
    } else if (opponentMoney <= 0) {
        UIStoryboard *storyboardobj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *screen = [storyboardobj instantiateViewControllerWithIdentifier:@"win"];
        [self presentViewController:screen animated:YES completion:nil];
    }
}

-(void)displayHand {
    NSString *handCard1 = [NSString stringWithFormat:@"%ld", (long)hand[0]];
    NSString *handCard2 = [NSString stringWithFormat:@"%ld", (long)hand[1]];
    NSString *handCard3 = [NSString stringWithFormat:@"%ld", (long)hand[2]];
    NSString *handCard4 = [NSString stringWithFormat:@"%ld", (long)hand[3]];
    NSString *handCard5 = [NSString stringWithFormat:@"%ld", (long)hand[4]];
    OhandCard1 = [NSString stringWithFormat:@"%ld", (long)opponent[0]];
    OhandCard2 = [NSString stringWithFormat:@"%ld", (long)opponent[1]];
    OhandCard3 = [NSString stringWithFormat:@"%ld", (long)opponent[2]];
    OhandCard4 = [NSString stringWithFormat:@"%ld", (long)opponent[3]];
    OhandCard5 = [NSString stringWithFormat:@"%ld", (long)opponent[4]];
    _card1.image = [UIImage imageNamed: handCard1];
    _card2.image = [UIImage imageNamed: handCard2];
    _card3.image = [UIImage imageNamed: handCard3];
    _card4.image = [UIImage imageNamed: handCard4];
    _card5.image = [UIImage imageNamed: handCard5];
    
}

-(void)shuffle {
    for(NSInteger i = 0; i < 200; i++) { //shuffle 200 times
        NSInteger randomizer1 = (int)(arc4random_uniform(51.99999)); //make sure to double check this randomization algorithm
        NSInteger randomizer2 = (int)(arc4random_uniform(51.99999));
        NSInteger temp[52];
        temp[randomizer1] = deck[randomizer2];
        temp[randomizer2] = deck[randomizer1];
        deck[randomizer1] = temp[randomizer1];
        deck[randomizer2] = temp[randomizer2];
    }
    
    hand[0] = deck[0];
    hand[1] = deck[2];
    hand[2] = deck[4];
    hand[3] = deck[6];
    hand[4] = deck[8];
    
    opponent[0] = deck[1];
    opponent[1] = deck[3];
    opponent[2] = deck[5];
    opponent[3] = deck[7];
    opponent[4] = deck[9];
    
    for (NSInteger i = 0; i < 5; i++) {
        handN[i] = hand[i];
        while (handN[i] > 100) {
            handN[i] = handN[i] - 100;
        }
    }
    for (NSInteger i = 0; i < 5; i++) {
        opponentN[i] = opponent[i];
        while (opponentN[i] > 100) {
            opponentN[i] = opponentN[i] - 100;
        }
    }
    for (NSInteger i = 0; i < 5; i++) {
        handS[i] = hand[i] / 100;
    }
    for (NSInteger i = 0; i < 5; i++) {
        opponentS[i] = opponent[i] / 100;
    }
    
    
    //clearing the dupe counters back to 0
    for(NSInteger i = 0; i < 5; i++) {
        handDupesS[i] = 0;
    }
    for(NSInteger i = 0; i < 15; i++) {
        handDupesN[i] = 0;
    }
    for(NSInteger i = 0; i < 5; i++) {
        opponentDupesS[i] = 0;
    }
    for(NSInteger i = 0; i < 15; i++) {
        opponentDupesN[i] = 0;
    }
    
    
    handScore = 0;
    opponentScore = 0;
    
    
    
    for (NSInteger i = 1; i<5; i++) { //finding recurrances of all numbers
        for (NSInteger x = 0; x<5; x++) {
            if(handS[x] == i) {
                handDupesS[i]++;
            }
        }
    }
    for (NSInteger i = 2; i<15; i++) {
        for (NSInteger x = 0; x<5; x++) { //finding recurrances of all numbers
            if(handN[x] == i) {
                handDupesN[i]++;
            }
        }
    }
    NSInteger highestNum = 0;
    for (NSInteger i = 2; i < 15; i++) {
        if (handDupesN[i] > handDupesN[highestNum]) { //finding the highest recurrance of a number in hand
            highestNum = i;
        }
    }
    
    //testing
    
    
    
    //end testing
    
    NSInteger secondNum = 0;
    for (NSInteger i = 2; i < 15; i++) {
        if (handDupesN[i] > handDupesN[secondNum]) { //finding the second highest recurrance of a number in hand
            if (i != highestNum) {
            secondNum = i;
            }
        }
    }
    
    //opponent
    for (NSInteger i = 1; i<5; i++) {
        for (NSInteger x = 0; x<5; x++) { //finding recurrances of all suits
            if(opponentS[x] == i) {
                opponentDupesS[i]++;
            }
        }
    }
    for (NSInteger i = 2; i<15; i++) {
        for (NSInteger x = 0; x<5; x++) { //finding recurrances of all numbers
            if(opponentN[x] == i) {
                opponentDupesN[i]++;
            }
        }
    }
    
    
    
    
    
    
    NSInteger OhighestNum = 0;
    for (NSInteger i = 2; i < 15; i++) {
        if (opponentDupesN[i] > opponentDupesN[OhighestNum]) { //finding the highest recurrance of a number in opponent
            OhighestNum = i;
        }
    }
    NSInteger OsecondNum = 0;
    for (NSInteger i = 2; i < 15; i++) {
        if (opponentDupesN[i] > opponentDupesN[OsecondNum]) { //finding the second highest recurrance of a number in opponent
            if (i != OhighestNum) {
                OsecondNum = i;
            }
        }
    }
    
    
    //end opponent
    
//    //testing
    
//    //done testing
    
    
    
    NSInteger highestSuit = 0;
    for (NSInteger i = 1; i < 5; i++) {
        if (handDupesS[i] > handDupesS[highestSuit]) { //finding the highest recurrance of a suit
            highestSuit = i;
        }
    }
    
    
    //opponent
    NSInteger OhighestSuit = 0;
    for (NSInteger i = 1; i < 5; i++) {
        if (opponentDupesS[i] > opponentDupesS[OhighestSuit]) { //finding the highest recurrance of a suit
            OhighestSuit = i;
        }
    }
    //end opponent
    
    BOOL straight = false;
    for (NSInteger i = 2; i < 15; i++) {
        if (handDupesN[i] > 0) {
            if (handDupesN[i+1] > 0) {
                if (handDupesN[i+2] > 0) {
                    if (handDupesN[i+3] > 0) {
                        if (handDupesN[i+4] > 0) { //detecting a straight
                            straight = true;
                        }
                    }
                }
            }
        }
    }
    
    
    //opponent
    BOOL Ostraight = false;
    for (NSInteger i = 2; i < 15; i++) {
        if (opponentDupesN[i] > 0) {
            if (opponentDupesN[i+1] > 0) {
                if (opponentDupesN[i+2] > 0) {
                    if (opponentDupesN[i+3] > 0) {
                        if (opponentDupesN[i+4] > 0) { //detecting a straight
                            Ostraight = true;
                        }
                    }
                }
            }
        }
    }
    //end opponent
    
    
    
    NSInteger pair = 0; //5 = four of a kind, 4 = full house, 3 = three of a kind, 2 = two pair, 1 = one pair
    if (handDupesN[highestNum] == 4) { //detecting four of a kind
        pair = 5;
    } else if (handDupesN[highestNum] == 3) { //detecting three of a kind
        pair = 3;
        
        
        if (handDupesN[secondNum] == 2) { //detecting a full house
            pair = 4;
        }
    } else if (handDupesN[highestNum] == 2) { //detecting a pair
        pair = 1;
        if (handDupesN[secondNum] == 2) { //detecting a two pair
            pair = 2;
        }
    }
    BOOL flush = false;
    if (handDupesS[highestSuit] == 5) { //detecting a flush
        flush = true;
    }
    
    //now for opponent
    NSInteger Opair = 0; //5 = four of a kind, 4 = full house, 3 = three of a kind, 2 = two pair, 1 = one pair
    if (opponentDupesN[OhighestNum] == 4) { //detecting four of a kind
        Opair = 5;
    } else if (opponentDupesN[OhighestNum] == 3) { //detecting three of a kind
        Opair = 3;
        
        
        if (opponentDupesN[OsecondNum] == 2) { //detecting a full house
            Opair = 4;
        }
    } else if (opponentDupesN[OhighestNum] == 2) { //detecting a pair
        Opair = 1;
        if (opponentDupesN[OsecondNum] == 2) { //detecting a two pair
            Opair = 2;
        }
    }
    BOOL Oflush = false;
    if (opponentDupesS[OhighestSuit] == 5) { //detecting a flush
        Oflush = true;
    }
    
    
    
    if (flush && straight) {
        if (handDupesN[13] > 0) { //detecting royal flush
            handScore = 1000;
        } else { //detecting straight flush
            handScore = 800;
        }
    } else if (flush) {
        handScore = 700;
    } else if (straight) {
        handScore = 600;
    } else {
        handScore = pair * 100;
    }
    
    
    
    
    
    
    if (Oflush && Ostraight) {
        if (opponentDupesN[13] > 0) { //detecting royal flush
            opponentScore = 1000;
            
        } else { //detecting straight flush
            opponentScore = 800;
        }
    } else if (Oflush) {
        opponentScore = 700;
    } else if (Ostraight) {
        opponentScore = 600;
    } else {
        opponentScore = Opair * 100;
    }
    
    //more tie breaking
    if (secondNum > highestNum && OsecondNum > OhighestNum) {
        if (pair > 0 && Opair > 0 && pair == Opair) {
            if (secondNum > OsecondNum) {
                handScore = handScore + 50;
            } else if (secondNum < OsecondNum) {
                opponentScore = opponentScore + 50;
            }
        }
    } else if (secondNum > highestNum && OsecondNum < OhighestNum) {
        if (pair > 0 && Opair > 0 && pair == Opair) {
            if (secondNum > OhighestNum) {
                handScore = handScore + 50;
            } else if (secondNum < OhighestNum) {
                opponentScore = opponentScore + 50;
            }
        }
    } else if (secondNum < highestNum && OsecondNum > OhighestNum) {
        if (pair > 0 && Opair > 0 && pair == Opair) {
            if (highestNum > OsecondNum) {
                handScore = handScore + 100;
            } else if (highestNum < OsecondNum) {
                opponentScore = opponentScore + 100;
            }
        }
    } else if (secondNum < highestNum && OsecondNum < OhighestNum) {
        if (pair > 0 && Opair > 0 && pair == Opair) {
            if (highestNum > OhighestNum) {
                handScore = handScore + 100;
            } else if (highestNum < OhighestNum) {
                opponentScore = opponentScore + 100;
            }
        }
    }
    
    
    if (opponentDupesN[14] > 0) {
        opponentHighest = 14;
    } else if (opponentDupesN[13] > 0) {
        opponentHighest = 13;
    } else if (opponentDupesN[12] > 0) {
        opponentHighest = 12;
    } else if (opponentDupesN[11] > 0) {
        opponentHighest = 11;
    } else if (opponentDupesN[10] > 0) {
        opponentHighest = 10;
    } else if (opponentDupesN[9] > 0) {
        opponentHighest = 9;
    } else if (opponentDupesN[8] > 0) {
        opponentHighest = 8;
    } else if (opponentDupesN[7] > 0) {
        opponentHighest = 7;
    } else if (opponentDupesN[6] > 0) {
        opponentHighest = 6;
    } else if (opponentDupesN[5] > 0) {
        opponentHighest = 5;
    } else if (opponentDupesN[4] > 0) {
        opponentHighest = 4;
    } else if (opponentDupesN[3] > 0) {
        opponentHighest = 3;
    } else if (opponentDupesN[2] > 0) {
        opponentHighest = 2;
    }
    opponentScore = opponentScore + handHighest; //giving tie breaker score
    
    if (handDupesN[14] > 0) {
        handHighest = 14;
    } else if (handDupesN[13] > 0) {
        handHighest = 13;
    } else if (handDupesN[12] > 0) {
        handHighest = 12;
    } else if (handDupesN[11] > 0) {
        handHighest = 11;
    } else if (handDupesN[10] > 0) {
        handHighest = 10;
    } else if (handDupesN[9] > 0) {
        handHighest = 9;
    } else if (handDupesN[8] > 0) {
        handHighest = 8;
    } else if (handDupesN[7] > 0) {
        handHighest = 7;
    } else if (handDupesN[6] > 0) {
        handHighest = 6;
    } else if (handDupesN[5] > 0) {
        handHighest = 5;
    } else if (handDupesN[4] > 0) {
        handHighest = 4;
    } else if (handDupesN[3] > 0) {
        handHighest = 3;
    } else if (handDupesN[2] > 0) {
        handHighest = 2;
    }
    handScore = handScore + handHighest; //giving tie breaker score
    
    NSLog(@"Hand Score");
    NSLog(@"%ld", (long)handScore);
    NSLog(@"%ld", (long)pair);
    
    NSLog(@"Hand");
    NSLog(@"%ld", (long)handDupesN[2]);
    NSLog(@"%ld", (long)handDupesN[3]);
    NSLog(@"%ld", (long)handDupesN[4]);
    NSLog(@"%ld", (long)handDupesN[5]);
    NSLog(@"%ld", (long)handDupesN[6]);
    NSLog(@"%ld", (long)handDupesN[7]);
    NSLog(@"%ld", (long)handDupesN[8]);
    NSLog(@"%ld", (long)handDupesN[9]);
    NSLog(@"%ld", (long)handDupesN[10]);
    NSLog(@"%ld", (long)handDupesN[11]);
    NSLog(@"%ld", (long)handDupesN[12]);
    NSLog(@"%ld", (long)handDupesN[13]);
    NSLog(@"%ld", (long)handDupesN[14]);
    NSLog(@"Opponent Score");
    NSLog(@"%ld", (long)opponentScore);
    NSLog(@"%ld", (long)Opair);
    NSLog(@"Opponent");
    NSLog(@"%ld", (long)opponentDupesN[2]);
    NSLog(@"%ld", (long)opponentDupesN[3]);
    NSLog(@"%ld", (long)opponentDupesN[4]);
    NSLog(@"%ld", (long)opponentDupesN[5]);
    NSLog(@"%ld", (long)opponentDupesN[6]);
    NSLog(@"%ld", (long)opponentDupesN[7]);
    NSLog(@"%ld", (long)opponentDupesN[8]);
    NSLog(@"%ld", (long)opponentDupesN[9]);
    NSLog(@"%ld", (long)opponentDupesN[10]);
    NSLog(@"%ld", (long)opponentDupesN[11]);
    NSLog(@"%ld", (long)opponentDupesN[12]);
    NSLog(@"%ld", (long)opponentDupesN[13]);
    NSLog(@"%ld", (long)opponentDupesN[14]);
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)checkFrequency {
    //detect frequency of terms in an array
    
}



@end
