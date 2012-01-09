//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Chase Southard on 1/7/12.
//  Copyright (c) 2012 Cogitools Software Corp. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic) BOOL userAddedDecimalPoint;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

@synthesize display = _display;

@synthesize brain = _brain;
@synthesize userAddedDecimalPoint = _userAddedDecimalPoint;


- (CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;

- (IBAction)decimalPressed:(UIButton *)sender 
{
    self.userAddedDecimalPoint = YES;
    [sender setEnabled:NO]; // To toggle enabled / disabled
    // I don't know how to re-enable the button though
    // the hints seem to suggest that there is some substring / range methods that might be able to handle the problem of multiple '.'
}

- (IBAction)digitPressed:(UIButton *)sender 
{
    NSString *digit = sender.currentTitle;
    
    if (self.userIsInTheMiddleOfEnteringANumber){
        self.display.text = [self.display.text stringByAppendingString:digit]; 
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }

    // send to log if you want. helpful debug tip.
    // NSLog(@"digit pressed = %@", digit);
}

    

- (IBAction)enterPressed 
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.userAddedDecimalPoint = NO;
}


- (IBAction)operationPressed:(UIButton *)sender 
{
    if (self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];
    double result = [self.brain performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
    self.userAddedDecimalPoint = NO;
}


- (IBAction)resetDisplay
{
    // this resets the display to 0, but doesn't clear the array
    self.userIsInTheMiddleOfEnteringANumber = NO;
}





// All below: stubbed stuff built by xcode

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setDisplay:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
