

#import "OrderConfirmationViewController.h"
#import "CCKFNavDrawer.h"

@interface OrderConfirmationViewController()
@end


@implementation OrderConfirmationViewController

-(void)backButtonTapped
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(BOOL)shouldShowCart
{
    return NO;
}


-(NSString*)leftNavigationBarItemTitle
{
    return @"Your cart";
}



- (void)viewDidLoad
{
    self.modalPresentationStyle = UIModalPresentationFormSheet;

    self.containerView.layer.cornerRadius = 4;
    self.okButton.layer.cornerRadius = 4;
    
    NSDictionary* dict = nil;

    dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"loggedinUserDetails"];
    if(dict)
    {
        self.emailTxtField.text = [dict objectForKey:@"emailId"];
        self.nameTField.text = [dict objectForKey:@"fullName"];
    }
    else
    {
        dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"shippingAddress"];
        self.nameTField.text = [dict objectForKey:@"name"];
        self.emailTxtField.text = [dict objectForKey:@"email"];
        self.address1TxtField.text = [dict objectForKey:@"address1"];
        self.address2TxtField.text = [dict objectForKey:@"address2"];
        self.phoneNumberTxtField.text = [dict objectForKey:@"phoneNumber"];
    }
}

-(IBAction)okTapped:(id)sender
{
    self.cartViewController.name = self.nameTField.text;
    self.cartViewController.email = self.emailTxtField.text;
    self.cartViewController.phoneNumber = self.phoneNumberTxtField.text;
    self.cartViewController.address = [NSString stringWithFormat:@"%@ %@",self.address1TxtField.text,self.address2TxtField.text];
    
    NSMutableDictionary* shippingAddress = [NSMutableDictionary new];
    [shippingAddress setObject:self.nameTField.text forKey:@"name"];
    [shippingAddress setObject:self.emailTxtField.text forKey:@"email"];
    [shippingAddress setObject:self.address1TxtField.text forKey:@"address1"];
    [shippingAddress setObject:self.address2TxtField.text forKey:@"address2"];
    [shippingAddress setObject:self.cartViewController.phoneNumber forKey:@"phoneNumber"];

    [[NSUserDefaults standardUserDefaults] setObject:shippingAddress forKey:@"shippingAddress"];

    [self.cartViewController processOrder];
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(IBAction)cancelTapped:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.nameTField.editing==YES)
    {
        self.nameEditImgView.image=[UIImage imageNamed:@"red_line"];
        
    }
    else
    {
        self.nameEditImgView.image=[UIImage imageNamed:@"grey_line-1"];
    }
    if(self.emailTxtField.editing==YES)
    {
        self.emailEditImgView.image=[UIImage imageNamed:@"red_line"];
    }
    else
    {
        self.emailEditImgView.image=[UIImage imageNamed:@"grey_line-1"];
    }
    
    if(self.address1TxtField.editing==YES)
    {
        self.address1EditImgView.image=[UIImage imageNamed:@"red_line"];
    }
    else
    {
        self.address1EditImgView.image=[UIImage imageNamed:@"grey_line-1"];
    }
    
    if(self.address2TxtField.editing==YES)
    {
        self.address2EditImgView.image=[UIImage imageNamed:@"red_line"];
    }
    else
    {
        self.address2EditImgView.image=[UIImage imageNamed:@"grey_line-1"];
    }
    
    if(self.phoneNumberTxtField.editing==YES)
    {
        self.phoneNumberEditImgView.image=[UIImage imageNamed:@"red_line"];
    }
    else
    {
        self.phoneNumberEditImgView.image=[UIImage imageNamed:@"grey_line-1"];
    }
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.nameEditImgView.image=[UIImage imageNamed:@"grey_line-1"];
    self.emailEditImgView.image=[UIImage imageNamed:@"grey_line-1"];

    self.address1EditImgView.image=[UIImage imageNamed:@"grey_line-1"];
    
    self.address2EditImgView.image=[UIImage imageNamed:@"grey_line-1"];
    self.phoneNumberEditImgView.image=[UIImage imageNamed:@"grey_line-1"];
    
    if(textField == self.emailTxtField)
    {
        //Email Validation..
        self.emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        self.emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", self.emailRegEx];
        //Valid email address
        if ([self.emailTest evaluateWithObject:self.emailTxtField.text] == YES)
        {
            //UIAlertView *emailAlert = [[UIAlertView alloc]initWithTitle:@"Email alert" message:@"Email is in proper formate" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            //[emailAlert show];
        }
        else
        {
            UIAlertView *emailAlert = [[UIAlertView alloc]initWithTitle:@"Messege" message:@"Email not in proper format" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [emailAlert show];
        }

    }
    
    
    
}

-(IBAction)keyboardReturn:(id)sender
{
    [self.nameTField resignFirstResponder];
    [self.emailTxtField resignFirstResponder];
    [self.address1TxtField resignFirstResponder];
    [self.address2TxtField resignFirstResponder];
    [self.phoneNumberTxtField resignFirstResponder];
}


@end


