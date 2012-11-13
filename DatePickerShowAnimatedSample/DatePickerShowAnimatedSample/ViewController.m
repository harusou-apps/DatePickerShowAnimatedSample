//
//  ViewController.m
//  DatePickerShowAnimatedSample
//
//  Created by okada yuichi on 12/11/09.
//  Copyright (c) 2012年 harusou apps. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize pickerView;
@synthesize dateFormatter;
@synthesize labelDate;
@synthesize buttonShow;
@synthesize buttonShowWithBlocks;

- (void)viewDidLoad
{
    [super viewDidLoad];

}
- (void)viewDidUnload
{
	self.dateFormatter = nil;
}

- (void)dealloc
{
    [buttonShow release];
    [buttonShowWithBlocks release];
    [labelDate release];
	[pickerView release];
	[dateFormatter release];
	
	[super dealloc];
}
- (void)loadView{

    [super loadView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[self.dateFormatter setDateStyle:NSDateFormatterShortStyle];
	[self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    //DatePicker
    pickerView = [[UIDatePicker alloc] init];
    pickerView.minuteInterval = 1;
    pickerView.datePickerMode = UIDatePickerModeDateAndTime;
    [pickerView addTarget:self action:@selector(datePickerEventValueChanged) forControlEvents:UIControlEventValueChanged];
    
    //show button
    buttonShow = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonShow setTitle:@"showDatePicker" forState:UIControlStateNormal];
    buttonShow.frame = CGRectMake(10.0f,10.0f,200.0f,40.0f);
    [buttonShow addTarget:self action:@selector(showUpDatePicker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonShow];

    //show button with blocks
    buttonShowWithBlocks = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonShowWithBlocks setTitle:@"showDatePickerWithBlocks" forState:UIControlStateNormal];
    buttonShowWithBlocks.frame = CGRectMake(10.0f,60.0f,300.0f,40.0f);
    [buttonShowWithBlocks addTarget:self action:@selector(showUpDatePickerWithBlocks) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonShowWithBlocks];
    
    //date label
    labelDate = [[UILabel alloc] initWithFrame:CGRectMake(18.0f, 110.0f, 200.0f, 40.0)];
    [labelDate setTextAlignment:UITextAlignmentLeft];
    [labelDate setText:[self.dateFormatter stringFromDate:[NSDate date]]];
    labelDate.backgroundColor = [UIColor whiteColor];
    [labelDate setUserInteractionEnabled:YES];
    [self.view addSubview:labelDate];

}
-(void)showUpDatePicker
{
    self.pickerView.date = [self.dateFormatter dateFromString:self.labelDate.text];
    
	if (self.pickerView.superview == nil)
	{
    	[self.view.window addSubview: self.pickerView];
    		
        CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
        CGSize pickerSize = [self.pickerView sizeThatFits:CGSizeZero];
        CGRect startRect = CGRectMake(0.0,
                                      screenRect.origin.y + screenRect.size.height,
                                      pickerSize.width, pickerSize.height);
        self.pickerView.frame = startRect;
		
		CGRect pickerRect = CGRectMake(0.0,
									   screenRect.origin.y + screenRect.size.height - pickerSize.height,
									   pickerSize.width,
									   pickerSize.height);

		[UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
		
        [UIView setAnimationDelegate:self];
		
        self.pickerView.frame = pickerRect;
		
        CGRect newFrame = self.view.frame;
        newFrame.size.height -= self.pickerView.frame.size.height;
    
        self.view.frame = newFrame;
        
	    [buttonShow setTitle:@"closeDatePicker" forState:UIControlStateNormal];
        
		[UIView commitAnimations];

    }else{
    
        [self showDownDatePicker];
    }
    
}
-(void)showUpDatePickerWithBlocks
{
    self.pickerView.date = [self.dateFormatter dateFromString:self.labelDate.text];
    
	if (self.pickerView.superview == nil)
	{
    	[self.view.window addSubview: self.pickerView];
        
        CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
        CGSize pickerSize = [self.pickerView sizeThatFits:CGSizeZero];
        CGRect startRect = CGRectMake(0.0,
                                      screenRect.origin.y + screenRect.size.height,
                                      pickerSize.width, pickerSize.height);
        self.pickerView.frame = startRect;
		
		CGRect pickerRect = CGRectMake(0.0,
									   screenRect.origin.y + screenRect.size.height - pickerSize.height,
									   pickerSize.width,
									   pickerSize.height);
        
        [UIView animateWithDuration:0.3
						 animations:^{
                             self.pickerView.frame = pickerRect;
                             
                             CGRect newFrame = self.view.frame;
                             newFrame.size.height -= self.pickerView.frame.size.height;
                             
                             self.view.frame = newFrame;
                             
                             [buttonShowWithBlocks setTitle:@"showDownDatePickerWithBlocks" forState:UIControlStateNormal];
                         }];
        
    }else{
        
        [self showDownDatePickerWithBlocks];
    }
    
}
- (void)showDownDatePicker
{
	CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
	CGRect endFrame = self.pickerView.frame;
	endFrame.origin.y = screenRect.origin.y + screenRect.size.height;
	
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
	
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(slideDownDidStop)];
	
    self.pickerView.frame = endFrame;
    
    [buttonShow setTitle:@"showDatePicker" forState:UIControlStateNormal];
	
	CGRect newFrame = self.view.frame;
	newFrame.size.height += self.pickerView.frame.size.height;
	self.view.frame = newFrame;

	[UIView commitAnimations];
}
- (void)showDownDatePickerWithBlocks
{
	CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
	CGRect endFrame = self.pickerView.frame;
	endFrame.origin.y = screenRect.origin.y + screenRect.size.height;
	
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.pickerView.frame = endFrame;
                         
                         [buttonShowWithBlocks setTitle:@"showDatePickerWithBlocks" forState:UIControlStateNormal];
                         
                         CGRect newFrame = self.view.frame;
                         newFrame.size.height += self.pickerView.frame.size.height;
                         self.view.frame = newFrame;
                     } completion:^(BOOL finished){[self slideDownDidStop];}];

}
-(void)datePickerEventValueChanged
{
	self.labelDate.text = [self.dateFormatter stringFromDate:self.pickerView.date];
}
- (void)slideDownDidStop
{
	[self.pickerView removeFromSuperview];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
