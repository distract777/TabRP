//
//  RPFirstViewController.h
//  TabRP
//
//  Created by JJ  on 2014/1/7.
//  Copyright (c) 2014年 JJ Lai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RPFirstViewController : UIViewController<UIPickerViewDelegate, UITextFieldDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *County;
@property (weak, nonatomic) IBOutlet UITextField *Countyship;
@property (weak, nonatomic) IBOutlet UITextField *Street;
@property (weak, nonatomic) IBOutlet UIPickerView *CountyPicker;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *activeField;


- (IBAction)Search:(id)sender;
-(void)addressquery;


@property (retain ,nonatomic) NSArray *citys;
@property (assign ,nonatomic) NSInteger rowInProvince;
@end


