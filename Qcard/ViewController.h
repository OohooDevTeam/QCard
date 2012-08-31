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

//  ViewController.h
//  OpenEarsSampleApp
//
//  ViewController.h demonstrates the use of the OpenEars framework. 
//
//  Copyright Politepix UG (haftungsbeschränkt) 2012. All rights reserved.
//  http://www.politepix.com
//  Contact at http://www.politepix.com/contact
//
//  This file is licensed under the Politepix Shared Source license found in the root of the source distribution.

// ********************************************************************************************************************************************************************
// ********************************************************************************************************************************************************************
// ********************************************************************************************************************************************************************
// IMPORTANT NOTE: This version of OpenEars introduces a much-improved low-latency audio driver for recognition. However, it is no longer compatible with the Simulator.
// Because I understand that it can be very frustrating to not be able to debug application logic in the Simulator, I have provided a second driver that is based on
// Audio Queue Services instead of Audio Units for use with the Simulator exclusively. However, this is purely provided as a convenience for you: please do not evaluate
// OpenEars' recognition quality based on the Simulator because it is better on the device, and please do not report Simulator-only bugs since I only actively support 
// the device driver and generally, audio code should never be seriously debugged on the Simulator since it is just hosting your own desktop audio devices. Thanks!
// ********************************************************************************************************************************************************************
// ********************************************************************************************************************************************************************
// ********************************************************************************************************************************************************************

#import <UIKit/UIKit.h>

#import <stdio.h>
#import <stdlib.h>
#import <math.h>
#import <string.h>

#import </Users/LQX/Xcode/Qcard/cmusphinx/pocketsphinx-0.7/include/pocketsphinx.h>
#import </Users/LQX/Xcode/Qcard/cmusphinx/sphinxbase/include/sphinxbase/err.h>
#import </Users/LQX/Xcode/Qcard/cmusphinx/sphinxbase/include/sphinxbase/cont_ad.h>

//Different Views
#import "AnswerViewController.h"

@class PocketsphinxController;
@class FliteController;
#import <OpenEars/OpenEarsEventsObserver.h> // We need to import this here in order to use the delegate.

//Global Variables
#define DEFAULT_DEVICE NULL
#define MAX_LINE_LEN 256
#define MAX_CHAR_LEN 256

@interface ViewController : UIViewController <OpenEarsEventsObserverDelegate> {
	
	// Pocketsphinx
	ps_decoder_t *ps;
	cmd_ln_t *config;
	char audioFilePath[256];
    
    // Sphinxbase
    ad_rec_t *ad;
    cont_ad_t *cont;
    
    //Noise Threshold
    agc_t *agc;
    Float32 agcthresh;
    Float32 noise;
    
    int32_t thresh;
    int32_t sil;
    int32_t sp;

    NSMutableArray *target;
    NSMutableArray *target2;

    int j;
    int x;
    int k;
    
    double x_wrong;
	double x_right;
    
	// These three are important OpenEars classes that ViewController demonstrates the use of. There is a fourth important class (LanguageModelGenerator) demonstrated
	// inside the ViewController implementation in the method viewDidLoad.
	
	OpenEarsEventsObserver *openEarsEventsObserver; // A class whose delegate methods which will allow us to stay informed of changes in the Flite and Pocketsphinx statuses.
	PocketsphinxController *pocketsphinxController; // The controller for Pocketsphinx (voice recognition).
	FliteController *fliteController; // The controller for Flite (speech).
    
	// Some UI, not specifically related to OpenEars.
	IBOutlet UIButton *stopButton;
	IBOutlet UIButton *startButton;	
	IBOutlet UIButton *suspendListeningButton;	
	IBOutlet UIButton *resumeListeningButton;
	IBOutlet UITextView *statusTextView;
	IBOutlet UITextView *heardTextView;
	IBOutlet UILabel *pocketsphinxDbLabel;
	IBOutlet UILabel *fliteDbLabel;
    
    //Labels
    IBOutlet UILabel *lblWORD;
    IBOutlet UILabel *lblCORRECTNESS;
    IBOutlet UILabel *lblRIGHT;
    IBOutlet UILabel *lblWRONG;
    IBOutlet UILabel *lblDIFFICULTY;
    IBOutlet UILabel *totalWORDS;
    
    //Buttons
    IBOutlet UIButton *Pass;
    IBOutlet UIButton *Peek;
    IBOutlet UIButton *buttonANSWER;
    
    IBOutlet UIButton *buttonCHECK1;
    IBOutlet UIButton *buttonCHECK2;
    IBOutlet UIButton *buttonCHECK3;
    
    //Boolean
	BOOL usingStartLanguageModel;
	
	// Strings which aren't required for OpenEars but which will help us show off the dynamic language features in this sample app.
	NSString *pathToGrammarToStartAppWith;
	NSString *pathToDictionaryToStartAppWith;
	
	NSString *pathToDynamicallyGeneratedGrammar;
	NSString *pathToDynamicallyGeneratedDictionary;
	
	// Strings which aren't required for OpenEars but which will help us show off the dynamic voice features in this sample app.
	NSString *firstVoiceToUse;
	NSString *secondVoiceToUse;
	
	// Our NSTimer that will help us read and display the input and output levels without locking the UI
	NSTimer *uiUpdateTimer;
    
    // Views for the 3 blank images for incorrect answers
    IBOutlet UIImageView * imageView1;
    IBOutlet UIImageView * imageView2;
    IBOutlet UIImageView * imageView3;
    
    // Bools for pausing and voice enabling/disabling
    BOOL isPaused;
    BOOL isEnabled;
    
    IBOutlet UIButton *voiceControl;
    IBOutlet UIButton *gameOver;
    
}

// UI actions, not specifically related to OpenEars other than the fact that they invoke OpenEars methods.
- (IBAction) stopButtonAction;
- (IBAction) startButtonAction;
- (IBAction) suspendListeningButtonAction;
- (IBAction) resumeListeningButtonAction;

- (IBAction) muteVoice;

- (IBAction) Pass:(id)sender;

- (IBAction) switch2answer;

// Example for reading out the input audio levels without locking the UI using an NSTimer
- (void) startDisplayingLevels;
- (void) stopDisplayingLevels;

// These three are the important OpenEars objects that this class demonstrates the use of.
@property (nonatomic, strong) OpenEarsEventsObserver *openEarsEventsObserver;
@property (nonatomic, strong) PocketsphinxController *pocketsphinxController;
@property (nonatomic, strong) FliteController *fliteController;

// Some UI, not specifically related to OpenEars.
@property (nonatomic, strong) IBOutlet UIButton *stopButton;
@property (nonatomic, strong) IBOutlet UIButton *startButton;
@property (nonatomic, strong) IBOutlet UIButton *suspendListeningButton;	
@property (nonatomic, strong) IBOutlet UIButton *resumeListeningButton;	
@property (nonatomic, strong) IBOutlet UITextView *statusTextView;
@property (nonatomic, strong) IBOutlet UITextView *heardTextView;
@property (nonatomic, strong) IBOutlet UILabel *pocketsphinxDbLabel;
@property (nonatomic, strong) IBOutlet UILabel *fliteDbLabel;

@property (nonatomic, assign) BOOL usingStartLanguageModel;
//recognition 
@property (nonatomic, assign) BOOL isPaused;
//voice
@property (nonatomic, assign) BOOL isEnabled;


// Things which help us show off the dynamic language features.
@property (nonatomic, copy) NSString *pathToGrammarToStartAppWith;
@property (nonatomic, copy) NSString *pathToDictionaryToStartAppWith;
@property (nonatomic, copy) NSString *pathToDynamicallyGeneratedGrammar;
@property (nonatomic, copy) NSString *pathToDynamicallyGeneratedDictionary;

// Things which will help us to show off the dynamic voice feature
@property (nonatomic, copy) NSString *firstVoiceToUse;
@property (nonatomic, copy) NSString *secondVoiceToUse;

// Our NSTimer that will help us read and display the input and output levels without locking the UI
@property (nonatomic, strong) 	NSTimer *uiUpdateTimer;

@property (nonatomic, strong) IBOutlet UIButton *voiceControl;
@property (nonatomic, strong) IBOutlet UIButton *gameOver;

@end