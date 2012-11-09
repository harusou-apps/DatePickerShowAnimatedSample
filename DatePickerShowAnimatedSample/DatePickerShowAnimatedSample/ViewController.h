//
//  ViewController.h
//  DatePickerShowAnimatedSample
//
//  Created by okada yuichi on 12/11/09.
//  Copyright (c) 2012年 harusou apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{

@private
	UIDatePicker *pickerView;
    NSDateFormatter* dateFormatter;
    UILabel* labelDate;
    UIButton* buttonShow;
}
@property(nonatomic,retain)UIDatePicker *pickerView;
@property(nonatomic,retain)NSDateFormatter* dateFormatter;
@property(nonatomic,retain)UILabel* labelDate;
@property(nonatomic,retain)UIButton* buttonShow;

@end
