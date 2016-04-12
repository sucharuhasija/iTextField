#
# Be sure to run `pod lib lint iTextField.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "iTextField"
  s.version          = "1.0.0"
  s.summary          = "The Smart Textfield that identifies the content in it and also checks wheather the text in it is right or wrong."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
s.description      = "The Smart Textfield that identifies the content in it and also checks wheather the text in it is right or wrong
There are 5 type of iTextFields
1.  .Email - Use when email is to be entered in the TF. Validity Check and suggest Mail               survers after Adding '@' in the TextFields

2.  .SimplePassword - It automatically secures the Text Entered and , you can set the minimum and Maximun characters in TF and it has two modes?

3.  .StrictPassword - must have atleast one Capital , one lower case, one    numeric and          one special character


3.  .DateOfBirth -  To enetr the Date in the Numeric DD/MM/YYYY format and Also replies with valid/Invalid date and Age With respect to present on the basis of GMT +0.0


4. .UserDefined - In Which User Can set its Own Validity check and Notice the change of characters in textFields an Work on The Requirement

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

"


  s.homepage         = "https://github.com/sucharuhasija/iTextField"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "sucharuhasija" => "sucharuhasija@gmail.com" }
  s.source           = { :git => "https://github.com/sucharuhasija/iTextField.git", :tag => s.version.to_s }
   s.social_media_url = 'https://twitter.com/sucharuhasija'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'iTextField' => ['Pod/Assets/*.png']
  }


   s.frameworks = 'UIKit'

end
