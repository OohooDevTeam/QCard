/**
 **************************************************************************
 **                              QCard                                   **
 **************************************************************************
 * @package     app                                                      **
 * @subpackage  N/A                                                      **
 * @name        QCard                                                    **
 * @copyright   oohoo.biz                                                **
 * @link        http://oohoo.biz                                         **
 * @author      Theodore Pham                                            **
 * @license     http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later **
 **************************************************************************
 **************************************************************************/

#import <UIKit/UIKit.h>

//Internet connectivity
#import "Reachability.h"

@interface AuthenticateViewController : UIViewController <UITextFieldDelegate> {
    
    //www.edumobile.org/iphone/iphone-programming-tutorials/create-a-loginscreen-in-iphone/
    IBOutlet UITextField *username;
    IBOutlet UITextField *password;
    IBOutlet UITextField *servername;
    IBOutlet UIButton *authenticate;
    IBOutlet UIButton *recoverpass;
    
    IBOutlet UIButton *checkBox;
    BOOL isChecked;

}

@property (nonatomic, retain) UITextField *username;
@property (nonatomic, retain) UITextField *password;
@property (nonatomic, retain) UITextField *servername;
@property (nonatomic, retain) UIButton *authenticate;
@property (nonatomic, retain) UIButton *recoverpass;
@property (nonatomic, retain) UIButton *checkBox;

@property (nonatomic, assign) BOOL isChecked;

- (IBAction) authenticate: (id) sender;
- (IBAction) recoverpass: (id) sender;
- (IBAction) checkBox: (id) sender;

@end
