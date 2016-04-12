//
//  iTextField.swift
//  iTextField
//
//  Created by Sucharu hasija on 12/03/16.
//  Copyright © 2016 SucharuHasija. All rights reserved.
//




import UIKit
import QuartzCore
/*

DIRECTIONS FOR USE
###################################################################################
#                                                                                 #
#  Step 1a) Change the Type Of iTextField in Identity Inspector Of The textField  #
#          to change the class of Textfield to be iTextField                      #
#                       OR                                                        #
#  Step 1b) Define Programmatically a Textfield of Type SHTextField               #
#                                                                                 #
#  Step 2. Define The Method   (Neccessary)                                       #
#                                                                                 #
#         self.itextFeild.initilizeiTextFieldWithEmailHavingDefaultSettings()     #
#                                                                                 #
#  Step3. SetAppropriate Labels in method (Optional)                              #
#                                                                                 #
#   self.itextField.iTextFieldSetIntialPlaceholderText( primaryPlaceholder        #
#           withtypingPlaceholderText secondaryPlaceholder,                       #
#           withWarningPlaceholder warning                                        #
#                ,andCompletionPlaceholer completionPlaceholder:String)           #
#                                                                                 #
#                                                                                 #
###################################################################################

*/


enum PasswordStrengthType:Int
{

    case Weak       = 1
    case Moderate   = 2
    case Strong     = 3
    case VeryStrong = 4

}

/*
##############     USE OF SHTextField with    SHTextFieldTypes     ########


1.  .Email - Use when email is to be entered in the TF. Validity Check and suggest Mail               survers after Adding '@' in the TextFields

2.  .SimplePassword - It automatically secures the Text Entered and , you can set the minimum and Maximun characters in TF and it has two modes?

3.  .StrictPassword - must have atleast one Capital , one lower case, one    numeric and          one special character


3.  .DateOfBirth -  To enetr the Date in the Numeric DD/MM/YYYY format and Also replies with valid/Invalid date and Age With respect to present on the basis of GMT +0.0


4. .UserDefined - In Which User Can set its Own Validity check and Notice the change of characters in textFields an Work on The Requirement


*/



enum iTextFieldType: Int {

    
case Normal           = 1
case Email            = 2
case SimplePassword   = 3
case StrictPassword   = 4
case DateOfBirth      = 5
case UserDefined      = 6
//case MobileNumber     = 7
// case iTextFieldTypeGoogleAddress = 8



}

protocol iTextFieldProtocol:class
{
/*

It is the Protocol defined to Extend the Functionality of the TextFeild to use it Over Your Own Conditions and set it As Per the requirements of your own App

Steps To use Delegate


1. Add the Delegate method  as iTextFieldProtocol
2. Add Delegate as self.itextfield.delegateOfiTextField = self
3. Init the TextField with both methods in your class
4. Directions For Methods

*/


// 5.a this methods check if the Text in textfield fulfills your requirements of not return true if it fulfills the required conditions , otherwise return false, (It will mark the textfield Red)

    func isValidOnCondition(text:String) -> Bool
    
    // 5c. Change the Content of the Text in TextFeild As per Your Need and To change the Value of the Progress bar just below of the TextField.
    
    func valueOfUnderProgrssBarWhileTypingWithText(text:String) -> (Float,String)



}

extension String
{



    
  // Extension of String to have ablity to test the extered text has valid email or not (based on regular expressions
    func isValidEmail() -> Bool
    {
        
        // Regular expression
        let regex = try! NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$",
                                             options: [.CaseInsensitive])
        
    
        return regex.firstMatchInString(self, options:[],
                                        range: NSMakeRange(0, self.characters.count)) != nil
        
        
    }
    
    
    
    // Method to get Age and year as a tuple from this method that gets Date as a string in it.
    func getAgeAndYearFromDateInString() -> (String,Int)
    {
        
        
        
        // Initilize a calendar that is used to first get a year , month and day
        
        let calender = NSCalendar.currentCalendar()
        let df = NSDateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        
        
        // Test the string has valid date then procceds else return a default value
        if var birthDate  = df.dateFromString(self)
        {
            
            // Current Date
            let currentDate = NSDate()
            
            // Find Diffrence in years from current and Date in string
            let yearComponent = calender.components(NSCalendarUnit.Year, fromDate: birthDate, toDate: currentDate, options: NSCalendarOptions.init(rawValue: 0))
            
            // Add Year to find months from the existing Date
            let addYearInBirth:NSDateComponents = NSDateComponents()
            addYearInBirth.year  = yearComponent.year
            
            
            // Modified Date
            birthDate = calender.dateByAddingComponents(addYearInBirth, toDate: birthDate, options: NSCalendarOptions.init(rawValue: 0))!
            
            // Getting Month from Date
            let monthComponents = calender.components(NSCalendarUnit.Month, fromDate: birthDate, toDate: currentDate, options: NSCalendarOptions.init(rawValue: 0))
            
            
            // Find the diffrence if it is 12 then add one year else number of months
            let yearToAddIftweleweMonth:Int  =  monthComponents.month == 12 ? 1 :0
            monthComponents.year = yearToAddIftweleweMonth
            
            
            
            birthDate  = calender.dateByAddingComponents(monthComponents, toDate: birthDate, options: NSCalendarOptions.init(rawValue: 0))!
            
            
            // Getting Days
            let dayComponent = calender.components(NSCalendarUnit.Day, fromDate: birthDate, toDate: currentDate, options: .MatchFirst)
            
            
                //   Settiing the Final Version 
            
            var finalDate = ""
            if yearComponent.year != 0
            {
                finalDate += "\(yearComponent.year)Y"
                
            }
            if monthComponents.month != 0
            {
                finalDate += " \(monthComponents.month)M"
                
            }
            if dayComponent.day != 0
            {
                finalDate += " \(dayComponent.day)D"
                
            }
            
            let finalAge = yearComponent.year
            return (finalDate,finalAge)
            
        }
        
        return ("",-1)
        
    }
    // Test whether the text is valid for the set strong password having atleast one small, atleast one capital ,atleast one number and atleast one special characters
    
    func isValidPassword() -> Bool
    {
        
        let cs:NSCharacterSet = NSCharacterSet(charactersInString:"$%&@_-#!")
        let decimalCharacters = NSCharacterSet.decimalDigitCharacterSet()
        
        return (self.rangeOfCharacterFromSet(decimalCharacters) != nil) && (self.rangeOfCharacterFromSet(NSCharacterSet.lowercaseLetterCharacterSet()) != nil) && (self.rangeOfCharacterFromSet(cs) != nil) && (self.rangeOfCharacterFromSet(NSCharacterSet.uppercaseLetterCharacterSet()) != nil)
        
        
        
        
    }

}


public class iTextField: UITextField ,UITextFieldDelegate{

    
    // Delegate For the Custom User Actions
     weak var delegateOfiTextField:iTextFieldProtocol?
    /*
    
    The String That is shown just before the the user start typing and after the textfeild becomefirst responder to
    This String can be used to instruct the users to what to fill in text field
    
    */
        var initialPlaceholderText:String?
    
    
    /*
     
     The String That is shown just after the the user start typing and   This String can be used to instruct the users to what to fill and accpetable Values in textfiels
     
     */
    
        var typingPlaceholderText:String?
    
    
    /*
    
    The String That is shown to warn the user that format required for the TextFeild is not Right. Try Filling the right characters and remove this message with CompletionPlaceholderText
    */

    var warningPlaceholderText:String?
  
    
    // Complettion Text that is shown on the left side when text entered by the user is valid on Constraints
    
    var completionPlaceholderText:String?
    
    
    // side Label to Show
       var sideLabel:UILabel?
    
    //under progress label
     private var underProgressLabel:UILabel?
    
    // park button or autocomplete button
     var parkLabel:UIButton?
    
    
    // Array to store User suggestions
     var userSuggestions:[String]?
    
    //
     var minimumAge:Int?
     var MaximumAge:Int?
     var intialColor:UIColor?
     var typingColor:UIColor?
     var warningColor:UIColor?
     var CompletionColor:UIColor?
     var type:iTextFieldType?
     var contentOffset:CGFloat = 2
     var textCharacterCount:Int = 0
     var minimumCharacterRequired:Int = 2
     var maximumCharacterAllowed:Int = 50
     var dateFormat:String = "dd/MM/yyyy"
     public var addIntialDuringTyping:String = ""
     var df = NSDateFormatter()
     var willShowAge:Bool = true
    private var translateX: CGFloat!
        {
        get {
            let attributes = [NSFontAttributeName: self.font!]
            let TextSize = self.sideLabel!.text!.sizeWithAttributes(attributes)
            let TextWidth = TextSize.width + 5
            
            let translateX = CGRectGetWidth(textRectForBounds(bounds)) - TextWidth - 12.0
            return translateX
        }
    }
    private var sideLabelWidth: CGFloat!
        {
        get {
          //  let sideTextRect  = self.sideLabel?.frame
     
  
            let sideLabelWidth = translateX - (self.sideLabel?.frame.origin.x)!  + 10
           
            return sideLabelWidth
        }
    }
    private var underLabelWidth: CGFloat!
        {
        get {
            let attributes = [NSFontAttributeName: self.font!]
            let TextSize = self.text!.sizeWithAttributes(attributes)

            let TextWidth = TextSize.width + contentOffset
            
            return TextWidth
        }
    }
    
   private let emailArray = ["gmail.com","yahoo.com","hotmail.com","aol.com","comcast.net","me.com","msn.com","live.com","sbcglobal.net","ymail.com","mac.com","cox.net","verizon.net","hotmail.co.uk","bellsouth.net","rocketmail.com","aim.com","yahoo.co.uk","earthlink.net","charter.net","optonline.net","yahoo.ca","google.com","mail.com","qq.com","btinternet.com","mail.ru","live.co.uk","naver.com","rogers.com","juno.com","yahoo.com.tw","live.ca","walla.com","roadrunner.com","telus.net","embarqmail.com","hotmail.fr","pacbell.net","sky.com","sympatico.ca","cfl.rr.com","tampabay.rr.com",        "q.com","yahoo.co.in","yahoo.fr","hotmail.ca","windstream.net","hotmail.it","web.de","asu.edu","gmx.de","gmx.com","insightbb.com","netscape.net","icloud.com","frontier.com","126.com","hanmail.net","suddenlink.net","netzero.net","mindspring.com","ail.com","windowslive.com","netzero.com","yahoo.com.hk","yandex.ru","mchsi.com","cableone.net","yahoo.com.cn","yahoo.es","yahoo.com.br","cornell.edu","ucla.edu","us.army.mil","excite.com","ntlworld.com","usc.edu","nate.com","outlook.com","nc.rr.com","prodigy.net","wi.rr.com","videotron.ca","yahoo.it","yahoo.com.au","umich.edu","ameritech.net","libero.it","yahoo.de","rochester.rr.com","cs.com","frontiernet.net","swbell.net","msu.edu","ptd.net","hotmail.es","austin.rr.com","nyu.edu","sina.com","centurytel.net","usa.net","nycap.rr.com","uci.edu","hotmail.de","yahoo.com.sg","email.arizona.edu","yahoo.com.mx","ufl.edu","bigpond.com","unlv.nevada.edu","yahoo.cn","ca.rr.com","google.com","yahoo.co.id","inbox.com","fuse.net","hawaii.rr.com","talktalk.net","gmx.net","walla.co.il","ucdavis.edu","carolina.rr.com","comcast.com","live.fr","blueyonder.co.uk","live.cn","cogeco.ca","abv.bg","tds.net","centurylink.net","yahoo.com.vn","uol.com.br","osu.edu","san.rr.com","rcn.com","umn.edu","live.nl","live.com.au","tx.rr.com","eircom.net","sasktel.net","post.harvard.edu","snet.net","wowway.com","live.it","hoteltonight.com","att.com","vt.edu","rambler.ru","temple.edu","cinci.rr.com"]
    
   private let dateAutoCompletArray = ["01/MM/YYYY","02/MM/YYYY","03/MM/YYYY","04/MM/YYYY","05/MM/YYYY","06/MM/YYYY","07/MM/YYYY","08/MM/YYYY","09/MM/YYYY","10/MM/YYYY","11/MM/YYYY","12/MM/YYYY","13/MM/YYYY","14/MM/YYYY","15/MM/YYYY","16/MM/YYYY","17/MM/YYYY","18/MM/YYYY","19/MM/YYYY","20/MM/YYYY","21/MM/YYYY","22/MM/YYYY","23/MM/YYYY","24/MM/YYYY","25/MM/YYYY","26/MM/YYYY","27/MM/YYYY","28/MM/YYYY","29/MM/YYYY","30/MM/YYYY","31/MM/YYYY","/01/YYYY","/01/YYYY","/02/YYYY","/03/YYYY","/04/YYYY","/05/YYYY","/06/YYYY","/07/YYYY","/08/YYYY","/09/YYYY","/10/YYYY","/11/YYYY","/12/YYYY","/1YYY","/2YYY","19YY","20YY"]
    
    
    
    internal let emailRegex:String = "[A-Z0-9a-z._%+-]+[A-Za-z0-9.-]+\\.[A-Za-z]{2,5}"
    
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override public func drawRect(rect: CGRect) {
        
     // Drawing code
        
        super.drawRect(rect)
       
       
    }

    
    public func addIntialToTextFeild(text:String)
    {
    self.addIntialDuringTyping = text
    
    }
    
    
// MARK:  Initilizers
    
    
    // Following methods initlize on the way of use
    public func initilizeiTextFieldWithEmailHavingDefaultSettings()
    {
   
        self.initilizeNormalSupportAutoComple(true)
        self.type = iTextFieldType.Email
        self.iTextFieldSetIntialPlaceholderText("Email", withtypingPlaceholderText: "XXX@XX.XX", withWarningPlaceholder: "N/A", andCompletionPlaceholer: "😊")
       self.keyboardType = UIKeyboardType.EmailAddress
    
    }
    func initilizeiTextFieldWithSimplePasswordHavingRangeFrom(min:Int ,to max:Int )
    {
        
        
        self.initilizeNormalSupportAutoComple(false)
        self.type = iTextFieldType.SimplePassword
        self.minimumCharacterRequired = min
        self.maximumCharacterAllowed = max
        self.contentOffset = 4
        self.keyboardType = .Default
        self.secureTextEntry = true
        self.iTextFieldSetIntialPlaceholderText("Enter Password", withtypingPlaceholderText: "\(min)-\(max) characters", withWarningPlaceholder: "N/A", andCompletionPlaceholer: "")
    
    }
    func initilizeiTextFieldWithStrictPasswordHavingRangeFrom(min:Int ,to max:Int )
    {
    
            self.initilizeNormalSupportAutoComple(false)
            self.type = iTextFieldType.StrictPassword
            self.minimumCharacterRequired = min
            self.maximumCharacterAllowed = max
            self.keyboardType = .Default
            self.contentOffset = 4
            self.secureTextEntry = true
            self.iTextFieldSetIntialPlaceholderText("Enter Password", withtypingPlaceholderText:  "\(min)-\(max) characters", withWarningPlaceholder: "", andCompletionPlaceholer: "")
        
    }
    func initilizeiTextFieldWithDateOfBirthHavingAgeLimitFrom(min:Int ,to max:Int )
    {
        self.initilizeNormalSupportAutoComple(true)
        self.type = iTextFieldType.DateOfBirth
        self.minimumAge = min
        self.MaximumAge = max
        self.keyboardType = .NumberPad
        self.iTextFieldSetIntialPlaceholderText("Enter Age", withtypingPlaceholderText: "DD/MM/YYYY", withWarningPlaceholder: "N/A", andCompletionPlaceholer: "😊")
    
    }
    
    
    
    public  func intitlizeiTextFieldWithTypeUserDefinedMustAddDelegateWithAllowedCharacterRangeFrom(min:Int ,to max:Int ,andSuggestionArray suggestion:[String] )
    {
        self.initilizeNormalSupportAutoComple(true)
        self.type = iTextFieldType.UserDefined
        self.minimumCharacterRequired = min
        self.maximumCharacterAllowed = max
        self.userSuggestions = suggestion
        self.keyboardType = .Default
        self.iTextFieldSetIntialPlaceholderText("User defined", withtypingPlaceholderText: "Typing....", withWarningPlaceholder: "N/A", andCompletionPlaceholer: "😊")
    }
 
    
    // Default Setup of TextField
    private func initilizeNormalSupportAutoComple(value:Bool)
    {
    
        
        self.secureTextEntry = false
        
        self.type =                        .Normal
        self.initialPlaceholderText     = ""
        self.typingPlaceholderText      = ""
        self.warningPlaceholderText     = ""
        self.completionPlaceholderText  = ""
        
        self.textAlignment              = NSTextAlignment.Center
        
        self.contentOffset              = 2
        self.intialColor                = self.textColor
        self.delegate                   = self
        self.willShowAge                = true
        
        
        //Adding observer for the the textfield operions
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(iTextField.tfTextDidChange), name: UITextFieldTextDidChangeNotification, object: self)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(iTextField.CheckValidityOfText),name: UITextFieldTextDidEndEditingNotification, object: self)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(iTextField.tfStartTyping), name: UITextFieldTextDidBeginEditingNotification, object: self)
    
        
        
        if self.sideLabel == nil
        {
        
        self.sideLabel                  = UILabel(frame: self.borderRectForBounds(self.bounds))
        }
        self.sideLabel?.textColor                  = UIColor.lightGrayColor()
        self.addSubview(self.sideLabel!)
        
        if value
        {
        self.parkLabel                  = UIButton(frame: CGRectZero)
        self.parkLabel?.titleLabel!.font = self.font
        self.parkLabel?.addTarget(self, action: #selector(iTextField.autoCompleteText), forControlEvents: UIControlEvents.TouchUpInside)
        self.parkLabel?.titleLabel!.textColor                  = UIColor.lightGrayColor()
        self.parkLabel?.setTitleColor(.lightGrayColor(), forState: .Normal)
        self.parkLabel?.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        self.parkLabel?.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        self.addSubview(self.parkLabel!)
        
        }
        
        self.underProgressLabel         = UILabel(frame: CGRectZero)
        self.underProgressLabel?.backgroundColor = UIColor.lightGrayColor()
        self.addSubview(self.underProgressLabel!)
    
    }
    
     public func iTextFieldSetIntialPlaceholderText(initialPlaceholderText:String,withtypingPlaceholderText secondaryPlaceholder:String,withWarningPlaceholder warning:String ,andCompletionPlaceholer completionPlaceholder:String)
    {
        
        self.initialPlaceholderText = initialPlaceholderText
        self.warningPlaceholderText = warning
        self.typingPlaceholderText = secondaryPlaceholder
        self.completionPlaceholderText = completionPlaceholder
        self.sideLabel?.text = initialPlaceholderText
        
        
    }

    

    
     // MARK: iTextField Start Typing
    
    // Initilial method that setup the view for when Textfield become first responder, setup
    func tfStartTyping()
    {
        
        self.placeholder                = self.initialPlaceholderText
        self.textAlignment              = NSTextAlignment.Left
        
        if self.text!.isEmpty
        {
        self.text! = self.addIntialDuringTyping
        
        
        
        }
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .CurveEaseIn, animations: { () -> Void in
            if self.text!.isEmpty {
                
                
                let attachment = NSTextAttachment()
                attachment.image = UIImage(named: "Male67")
                
                let attachmentString  = NSAttributedString(attachment: attachment)
                let myString = NSMutableAttributedString(string: "T")
                myString.appendAttributedString(attachmentString)
                self.sideLabel?.attributedText = myString
                
              
                
                
                self.sideLabel?.text = self.typingPlaceholderText
                self.sideLabel?.frame.size = self.getRectForAutoCompleteLabelWithText((self.sideLabel?.text)!).size
                self.sideLabel?.frame.size.width += 50.0
                
                self.sideLabel!.transform = CGAffineTransformTranslate(self.sideLabel!.transform, self.translateX , 0.0)
                
                
                
            }
            }, completion: nil)

        
    }
    
    
    
//MARK: Uer Typing in TextField
     func tfTextDidChange()
    
    {
        
        self.parkLabel?.titleLabel!.textAlignment = .Left

        UIView.animateWithDuration(0.2, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .CurveLinear, animations: { () -> Void in
            
            
            
                self.layer.borderWidth = 1.0
                self.layer.borderColor = UIColor.blueColor().CGColor
                self.layer.cornerRadius = 5.0
                self.textColor = self.typingColor ?? UIColor.blueColor()
                let frame = self.textRectForBounds(self.bounds)
                let underWidth = self.underLabelWidth
                self.underProgressLabel?.backgroundColor = UIColor.blueColor()
                self.underProgressLabel?.frame = CGRectMake(frame.origin.x, frame.size.height - 1,underWidth , 1)
                if self.text!.characters.count > self.maximumCharacterAllowed
                {
        
                    self.sideLabel?.text = self.warningPlaceholderText
                    return
            
                }
                if ((self.text?.isEmpty) == nil)
                {
                    self.sideLabel!.text = self.initialPlaceholderText
                    return
                }
        
                switch(self.type!)
                {
        
                    case iTextFieldType.Email , .DateOfBirth:
            
                        self.bringSubviewToFront(self.parkLabel!)
                        let autoCompletetext = self.autoCompleteTextForiTextFieldOfType( self.type!, withTextForAutoCompletion: self.text!)

                        self.parkLabel?.titleLabel!.text =  autoCompletetext
                        self.parkLabel?.setTitle(autoCompletetext, forState: UIControlState.Normal)
                       
                        if !self.text!.isEmpty {
                  
                            self.parkLabel?.frame = self.getRectForAutoCompleteLabelWithText((self.parkLabel?.titleLabel!.text!)!)
                     
                        }
                        else
                        {
                
                            self.parkLabel?.frame = CGRectZero
                
                        }
              
            
                    case .StrictPassword:
            
                        let value  = self.checkPasswordStrength(self.text!)
                        switch(value)
                        {
                    
                        case .Weak:
                            self.sideLabel?.text! = "Weak"
                            self.layer.borderColor = UIColor.brownColor().CGColor
                            self.textColor = UIColor.brownColor()
                        case .Moderate:
                            self.sideLabel?.text! = "Moderate  "
                            self.layer.borderColor = UIColor.greenColor().CGColor
                            self.textColor = UIColor.greenColor()
                        case .Strong:
                            self.sideLabel?.text! = "Strong"
                            self.layer.borderColor = UIColor.greenColor().CGColor
                            self.textColor = UIColor.greenColor()
                    
                        default:
                            self.sideLabel?.text! = self.typingPlaceholderText!
                            break
                    
                    }
                    self.adjustSideLabelWidthWithText((self.sideLabel?.text)!)
       
                    case .UserDefined:
            
            
                       
                        if !self.text!.isEmpty {
                    
                    self.bringSubviewToFront(self.parkLabel!)
                    let autoCompletetext = self.autoCompleteTextForiTextFieldOfType( .UserDefined, withTextForAutoCompletion: self.text!)
                            
                    self.parkLabel?.titleLabel!.text =  autoCompletetext
                    self.parkLabel?.setTitle(autoCompletetext, forState: .Normal)

                   
                    self.parkLabel?.frame = self.getRectForAutoCompleteLabelWithText((self.parkLabel?.titleLabel!.text!)!)
//                    self.parkLabel?.backgroundColor = UIColor.blueColor()
//                    self.parkLabel?.titleLabel?.textColor = UIColor.blackColor()
                }
                else
                {
                    
                    self.parkLabel?.frame = CGRectZero
                    
                }
              
            
           
        
        default:
            break
        
        
        
        }
        
        
        
        
        
          }, completion: nil)
        
    
    
    
    }
// MARK: Check Validity When user Ended Typing
    func CheckValidityOfText()
    {
        
        
        
        switch (self.type!)
        {
            
        case .Email:
            if(self.text!.isValidEmail())
             {
                
                self.showCompletionOnsideLabelWithText(self.completionPlaceholderText!)
                
            }
            else {
                
                self.showWarningLabelOnSideLabel()
                
            }
        case .DateOfBirth:
            
            if self.isValidDate(self.text!)
            {
                
                
                self.showCompletionOnsideLabelWithText(self.willShowAge ? self.text!.getAgeAndYearFromDateInString().0 : self.completionPlaceholderText!)
           }
                
            else
            {
                
                self.showWarningLabelOnSideLabel()
                
            }
        case .SimplePassword:
            
            if self.type == iTextFieldType.SimplePassword
            {
                
                
                if self.text?.characters.count > self.minimumCharacterRequired && self.text?.characters.count < self.maximumCharacterAllowed
                {
                    
                    self.showCompletionOnsideLabelWithText(self.completionPlaceholderText!)
                    
                }
                    
                else
                {
                    
                    showWarningLabelOnSideLabel()
                    
                }
                
                
                
            }
            
        case .StrictPassword:
            
            if self.text?.characters.count > self.minimumCharacterRequired && self.text?.characters.count < self.maximumCharacterAllowed && self.text!.isValidPassword()
            {
                
                self.showCompletionOnsideLabelWithText(self.completionPlaceholderText!)
                
            }
                
            else
            {
                
                showWarningLabelOnSideLabel()
            }
            
        case .UserDefined:
            
            
            assert(delegateOfiTextField != nil, "itextField.delegateOfiTextField must define")
            
            if (delegateOfiTextField!.isValidOnCondition(self.text!))
            {
                
            
                self.showCompletionOnsideLabelWithText(self.completionPlaceholderText!)
                
            }
                
            else
            {
                
                showWarningLabelOnSideLabel()
            }
        default:
            break
            
            
        }
   }

//MARK: Delegate Method to prevent Typing to have limit users to type within limit of characters
  
    public func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        
        
        
        
        if(range.length + range.location > textField.text?.characters.count)
        {
            return false
        }
        
       let newLength = (textField.text?.characters.count)! + string.characters.count - range.length;
        return newLength <= self.maximumCharacterAllowed;
        
        
        
        
    }

    
    

    // Method that uses diffrent dictionaries and implement the autocomplete feature
    
    private func autoCompleteTextForiTextFieldOfType(type:iTextFieldType , withTextForAutoCompletion text:String ) -> String
    {
    
            /*
                    IT CHECKS THE LAST COMPONENET OF THE TEXT ENTERED IN THE iTEXTFIELD SO THAT  WE CAN TEST THAT STRING TO AVAIL AUTOCOMPLETE FUNCTIONALITY
         
 
            */
        var componentsString = text.componentsSeparatedByString(" ")
        
        if(type == .Email)
        {
           componentsString = text.componentsSeparatedByString("@")
        
        }
       
        
        
        var stringToLookFor:String = (componentsString.last?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()))!
        
        var AutoCompleteArray = [String]()
        
        // TEST FOR TYPE OF CONTENT NEEDED
        switch(type)
        {
        
        
            case .Email:
            
            
                    // TEST FOR PRESENCE OF '@'
                AutoCompleteArray = self.emailArray
         
                    if(!text.containsString("@"))
                    {
                    
                            return ""
                
                
                    }
                    else if(stringToLookFor.isEmpty)
                    {
                    
                        return AutoCompleteArray[0]
                    }
            
            
            case .DateOfBirth:
                    
            
                // TEST FOR DATE IN TEXT
                AutoCompleteArray = self.dateAutoCompletArray
            
                if(self.textCharacterCount < self.text!.characters.count)
                {
            
                    self.addSlashInDateField(self.text!)
                }
                    
                    
                stringToLookFor = self.text!
                
                if self.text!.characters.count > 3
                {
                    let index: String.Index = stringToLookFor.endIndex.advancedBy(-2)
                    stringToLookFor = stringToLookFor.substringFromIndex(index)
            
            
                }
                if self.text!.characters.count > 5
                {
                        let index: String.Index = self.text!.endIndex.advancedBy(-4)
                        stringToLookFor = self.text!.substringFromIndex(index)
                        
                        
                }
                self.textCharacterCount = self.text!.characters.count
                break
    
        case .UserDefined:
        
            AutoCompleteArray = self.userSuggestions ?? ["nothing is here"]
            
            
        default:
                return ""
            
    }
        
        // CHCECK FOR TEXT HAVING PREFIX THEN RETUEN THAT TEXT ELSE EMPTY STRING IS RETURNED
       for tempString in AutoCompleteArray
        {
        
        if tempString.hasPrefix(stringToLookFor)
        {
            
        return tempString.stringByReplacingCharactersInRange(tempString.rangeOfString(stringToLookFor)!, withString: "")
            
        }
        
        }
       
        
        return ""
    
    }
    private func getRectForAutoCompleteLabelWithText(text:String) -> CGRect
    {
        
        var returnRect = CGRectZero
        if(text.isEmpty)
        {
            return returnRect
        }
        
        let lineBrakingMode =  NSLineBreakMode.ByCharWrapping
        let paragragh:NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragragh.lineBreakMode = lineBrakingMode
        let attributes:NSDictionary = [NSFontAttributeName: self.font!, NSParagraphStyleAttributeName:paragragh]
        let rect = self.borderRectForBounds(self.bounds)
        let textSize = self.text!.sizeWithAttributes(attributes as? [String : AnyObject])
        let placeholderTextSize  = text.sizeWithAttributes(attributes as? [String : AnyObject])
        
        
        
        returnRect  = CGRectMake(rect.origin.x + textSize.width + 1, rect.origin.y  , placeholderTextSize.width + 25 , rect.size.height)
        
        
        
        return returnRect
        
        
        
    }
// MARK: Customize the Text Inside TextField
    private func addSlashInDateField(date:String)
    {
        
        // If User Enteered two digits it automatically add '/' to easy the user to type
        // It enters slash after day and month are added
        
        
        if(date.characters.count == 2 || date.characters.count == 5)
        {
        
            self.text!  = date + "/"
        
        
        }
    
   
    }
    
    // Test Valdity of the date inside iTextField
    
    func isValidDate(date:String) -> Bool
    {
    
        let rTuple = date.getAgeAndYearFromDateInString()
        
        let df:NSDateFormatter = NSDateFormatter()
        df.dateFormat = self.dateFormat
        if let _ = df.dateFromString(date) where rTuple.1 > self.minimumAge && rTuple.1 < self.MaximumAge
        {
            
        return true
        }
        
    return false
    }
    
    
    // Check the Password strength on the based of Text entered in the textfield for Strict user password checking
    func checkPasswordStrength(text:String) -> PasswordStrengthType
    {
        let cs:NSCharacterSet = NSCharacterSet(charactersInString:"$ % & @ _ - # !")
        let decimalCharacters = NSCharacterSet.decimalDigitCharacterSet()
        let length = text.characters.count
        var strength = 0
        if(length == 0)
        {
            return .Weak
            
        }
        else if(length > 7 )
        {
            strength += 2
            
        }
        else if(length > 5)
        {
            strength += 1
            
        }
        
        
        strength += (text.rangeOfCharacterFromSet(decimalCharacters) != nil) ? 1 : 0
        strength += (text.rangeOfCharacterFromSet(cs) != nil) ? 1 : 0
        strength += (text.rangeOfCharacterFromSet(NSCharacterSet.lowercaseLetterCharacterSet()) != nil) ? 1 : 0
        strength += (text.rangeOfCharacterFromSet(NSCharacterSet.uppercaseLetterCharacterSet()) != nil) ? 1 : 0
        
        if strength < 3
        {
            return .Weak
        }
        else if strength < 6
        {return .Moderate
        }
        else {
            
            return .Strong
        }
        
    }
    
    
    // MARK: Placeholder Text Setup
    
    // It Setup side view To red to show that the data entered in the textfield is not valid on constraints
    private func showWarningLabelOnSideLabel()
    {
        
        
        self.textColor = UIColor.redColor()
        self.sideLabel?.text = self.warningPlaceholderText
        self.layer.borderColor = UIColor.redColor().CGColor
        self.adjustSideLabelWidthWithText((self.sideLabel?.text!)!)
        self.underProgressLabel?.backgroundColor = UIColor.redColor()
        
        
        
    }
    
    // Completion Text : The Setup of side view when the text is valid on constraints
    func showCompletionOnsideLabelWithText(text:String)
    {
        
        self.textColor = self.intialColor
        self.sideLabel?.text = text
        self.adjustSideLabelWidthWithText((self.sideLabel?.text)!)
        self.layer.borderColor = self.intialColor?.CGColor
        
        self.underProgressLabel?.backgroundColor = UIColor.clearColor()
        
        
    }
    
   //   method that AutoComplete the remaining text to be filled by the User.
    func autoCompleteText()
    {
    
        self.text! += (self.parkLabel?.titleLabel?.text)!
        self.parkLabel?.frame = CGRectZero
        self.CheckValidityOfText()
    
    }
    
 
    //MARK: Adjust Side Label Width
    
    
    private func adjustSideLabelWidthWithText(text:String)
    {
        
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .CurveEaseIn, animations: { () -> Void in
            
            if !self.text!.isEmpty {
                    
                    
                    self.sideLabel?.text = text
                    self.sideLabel?.font = self.font
                    self.sideLabel!.transform = CGAffineTransformTranslate(self.sideLabel!.transform,self.sideLabelWidth, 0.0)
                
            }
           
            }, completion: nil)
       
    }

}
