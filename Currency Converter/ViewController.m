//
//  ViewController.m
//  Currency Converter
//
//  Created by Admin on 16.07.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate> //Подписание на протокол


@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textfields;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;



@end

@implementation ViewController {
    Converter * converter;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer * handleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleEndEditing)];
    [self.view addGestureRecognizer:handleTap]; //добавление жеста на представление
  
    
    self->converter = [[Converter alloc] init]; //Создание экземпляра модели
    [self->converter setRates]; //Обновление курсов
    
    ((UITextField *)[self.textfields objectAtIndex:0]).text = @"1";
    [((UITextField *)[self.textfields objectAtIndex:0]) becomeFirstResponder];

}
- (IBAction)buttonRefresh:(id)sender {
    [self->converter setRates];
}

- (IBAction)buttonCopyCur1:(id)sender {
    UIPasteboard *gp = [UIPasteboard generalPasteboard];
    gp.string = ((UITextField *)[self.textfields objectAtIndex:0]).text;
}

- (IBAction)buttonCopyCur2:(id)sender {
    UIPasteboard *gp = [UIPasteboard generalPasteboard];
    gp.string = ((UITextField *)[self.textfields objectAtIndex:1]).text;
}

- (IBAction)buttonCopyCur3:(id)sender {
    UIPasteboard *gp = [UIPasteboard generalPasteboard];
    gp.string = ((UITextField *)[self.textfields objectAtIndex:2]).text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    [textField resignFirstResponder];
    return YES;
}

- (void) handleEndEditing{
    [self.view endEditing:YES]; //закрытие текстового поля
    
}



- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (![textField.textColor isEqual:[UIColor redColor]]) {
       textField.textColor = [UIColor redColor];
        textField.text = @"1";
        [self calculate:textField];
       for(UITextField * key in self.textfields){
          if (key != textField){
              key.textColor = nil;
          }
       }
        
    }
    
    //textField.text = @"1";
   // [self calculate:textField];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{

    if ([textField.text length] == 0){
        textField.text = @"1";
    }
    [self calculate:textField];
    
}
- (IBAction)test:(id)sender {
    for(UIButton * key in self.buttons){
        NSLog(@"%@",key.currentTitle);
    }
    [self calculate:((UITextField *)[self.textfields objectAtIndex:1])];
}

-(void) calculate: (UITextField *) textfield  {
    
    int index = [self.textfields indexOfObject:textfield];
    
    for(int i=0;i<3;i++){
        if (i!=index){
            ((UITextField*)[self.textfields objectAtIndex:i]).text=
            [NSString stringWithFormat:@"%.3f", [self->converter exchange:((UIButton*)[self.buttons objectAtIndex:index]).currentTitle to:((UIButton*)[self.buttons objectAtIndex:i]).currentTitle amt:[textfield.text doubleValue]]];
        }

    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    
    NSString *newStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSString *expression = @"^([0-9]*)(\\.([0-9]{0,3})?)?$";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    NSUInteger noOfMatches = [regex numberOfMatchesInString:newStr
                                                    options:0
                                                      range:NSMakeRange(0, [newStr length])];
    if (noOfMatches==0){
        return NO;
    }
    return YES;
}



@end
