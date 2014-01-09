//
//  RPFirstViewController.m
//  TabRP
//
//  Created by JJ  on 2014/1/7.
//  Copyright (c) 2014年 JJ Lai. All rights reserved.
//

#import "RPFirstViewController.h"
//#import "CGGeometry.h"
//#import "CGBase.h";


@interface RPFirstViewController ()

@end

@implementation RPFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   UIToolbar *toolbar = [[UIToolbar alloc] init];
   [toolbar setBarStyle:UIBarStyleBlackTranslucent];
   [toolbar sizeToFit];
   UIBarButtonItem *buttonflexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
   UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
   
   [toolbar setItems:[NSArray arrayWithObjects:buttonflexible,buttonDone, nil]];
   
   
   self.CountyPicker.dataSource=self;
   self.CountyPicker.delegate = self;
   
   
   _County.inputView=_CountyPicker;
   _County.inputAccessoryView = toolbar;
   self.CountyPicker.frame=CGRectMake(0, 480, 100, 216);
   NSString *path = [[NSBundle mainBundle] pathForResource:@"areaTW" ofType:@"plist"];
   self.citys = [NSArray arrayWithContentsOfFile:path];

   
   [self registerForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Search:(id)sender {
   
  
   
   
   [self addressquery];
   
   
}

-(void)addressquery{
   UIAlertView *alertdialog;
   
   
  NSString *URL=[NSString stringWithFormat:@"http://10.35.36.80/JSON/QueryAddress.aspx?City=%@&District=%@&Address=%@",[self.County.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [self.Countyship.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[self.Street.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
  
   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
      NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:URL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
      NSData *response =[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
   
   });
      dispatch_async(dispatch_get_main_queue(), ^{
         NSError *error;
         
         //[alertdialog dismissWithClickedButtonIndex:0animated:NO];
         
         
   
      });
            
                     

}


-(void)doneClicked:(UIBarButtonItem*)button
{
   [self.view endEditing:YES];
}




- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
   return  2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
   if (component == 0) return  self.citys.count;
   else return [[[self.citys objectAtIndex:self.rowInProvince] objectForKey:@"Cities"] count];
   
}
#pragma mark delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
   
   if (component == 0) {return [[self.citys objectAtIndex:row] objectForKey:@"State"];
   }
   else return [[[[self.citys objectAtIndex:self.rowInProvince] objectForKey:@"Cities"] objectAtIndex:row] objectForKey:@"city"];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
   if (component == 0){
      self.rowInProvince = row;
      [self.CountyPicker reloadComponent:1];
   }
   NSLog(@"component= %d ,row = %d",component,row);
   
   //NSInteger selectedRow0 = [self.CountyPicker selectedRowInComponent:0];
   // NSString *selectedPickerRow0=[self.citys objectAtIndex:selectedRow0];
   NSString *selectedRow0 = [NSString stringWithFormat:@"%@",[[self.citys objectAtIndex:[self.CountyPicker selectedRowInComponent:0]] objectForKey:@"State"]];
   self.County.text=selectedRow0;
   NSString *selectedRow1 = [NSString stringWithFormat:@"%@",[[[[self.citys objectAtIndex:self.rowInProvince] objectForKey:@"Cities"] objectAtIndex:[self.CountyPicker selectedRowInComponent:1]] objectForKey:@"city"]];
   self.Countyship.text=selectedRow1;
   
   //NSInteger selectedRow1 = [self.CountyPicker selectedRowInComponent:1];
   // NSString *selectedPickerRow1=[self.citys objectAtIndex:selectedRow1];
   //self.CountyShip.text=selectedPickerRow1;
   
}


// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
   [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(keyboardWasShown:)
                                                name:UIKeyboardDidShowNotification object:nil];
   [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(keyboardWillBeHidden:)
                                                name:UIKeyboardWillHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
   NSDictionary* info = [aNotification userInfo];
   CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
   UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
   _scrollView.contentInset = contentInsets;
   _scrollView.scrollIndicatorInsets = contentInsets;
   
   // If active text field is hidden by keyboard, scroll it so it's visible
   // Your application might not need or want this behavior.
   CGRect aRect = self.view.frame;
   aRect.size.height -= kbSize.height;
   if (!CGRectContainsPoint(aRect, _activeField.frame.origin) ) {
      CGPoint scrollPoint = CGPointMake(0.0, _activeField.frame.origin.y-kbSize.height);
      [_scrollView setContentOffset:scrollPoint animated:YES];
   }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
   UIEdgeInsets contentInsets = UIEdgeInsetsZero;
   _scrollView.contentInset = contentInsets;
   _scrollView.scrollIndicatorInsets = contentInsets;
}
@end
