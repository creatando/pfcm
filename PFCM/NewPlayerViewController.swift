//
//  PlayerViewController.swift
//  Premier Football Club Management
//
//  Created by Thomas Anderson on 05/02/2017.
//  Copyright © 2017 Thomas Anderson. All rights reserved.
//

import UIKit
import RealmSwift
import SCLAlertView
import SwiftValidator

extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in PNG format
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the PNG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    var png: Data? { return UIImagePNGRepresentation(self) }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ quality: JPEGQuality) -> Data? {
        return UIImageJPEGRepresentation(self, quality.rawValue)
    }
}

class NewPlayerViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, ValidationDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var dob: UITextField!
    @IBOutlet weak var phoneNo: UITextField!
    @IBOutlet weak var emailAdd: UITextField!
    @IBOutlet weak var address1: UITextField!
    @IBOutlet weak var address2: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var postCode: UITextField!
    @IBOutlet weak var position: UITextField!
    @IBOutlet weak var position2: UITextField!
    @IBOutlet weak var position3: UITextField!
    @IBOutlet weak var squadNo: UITextField!
    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBAction func dateEditField(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(NewPlayerViewController.datePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
    }
    
    @IBAction func backNav(_ sender: Any) {
        let appearance = SCLAlertView.SCLAppearance(showCloseButton: false)
        let confirmAlertView = SCLAlertView(appearance: appearance)
        
        if self.createButtonClicked == false {
            confirmAlertView.addButton("Yes") {
                self.dismiss(animated: true, completion: nil)
                self.createButtonClicked = false
            }
            
            confirmAlertView.addButton("No") {
                self.createButtonClicked = false
            }
            self.view.endEditing(true)
            confirmAlertView.showInfo("Leave", subTitle: "Are you sure you want to exit before adding another player?")
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func addPhoto(_ sender: UIBarButtonItem) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.modalPresentationStyle = .popover
        present(imagePicker, animated: true, completion: nil)
        imagePicker.popoverPresentationController?.barButtonItem = sender
    }
    
    
    @IBAction func createPlayer(_ sender: Any) {
        print (player.pid)
        validator.validate(self)
    }
    
    let imagePicker = UIImagePickerController()
    let player = Player()
    var createButtonClicked = false
    let validator = Validator()
    var positionData = ["", "GK", "LB", "CB", "RB", "LWB", "RWB", "DM", "CM", "LM", "RM", "CAM", "LW", "RW", "CF" ]
    var squadNoData = ["","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99"]
    
    var picker = UIPickerView()
    var picker2 = UIPickerView()
    var picker3 = UIPickerView()
    var sNoPicker = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view. 
        
        circlePicture()
        
        formDelegation()
        formValidation()

    }
    
    // Save Image
    func saveImage () {
        
        let puid = "\(firstName.text ?? "")\(lastName.text ?? "")\(UUID().uuidString)pic.jpeg"
        
        let documentsDirectoryURL = try! FileManager().url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        // create a name for your image
        let fileURL = documentsDirectoryURL.appendingPathComponent("\(puid)")
        
        print (fileURL.standardizedFileURL.path)
        player.picFilePath = puid
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try UIImageJPEGRepresentation(profilePic.image!, 0.5)!.write(to: fileURL)
                print("Image Added Successfully")
            } catch {
                print(error)
            }
        } else {
            print("Image Not Added")
        }
            }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profilePic.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func formValidation() {
        // Validation Rules
        validator.registerField(firstName, rules: [RequiredRule()])
        validator.registerField(lastName, rules: [RequiredRule()])
        validator.registerField(dob, rules: [RequiredRule()])
        validator.registerField(phoneNo, rules: [RequiredRule(), MinLengthRule(length: 11), MaxLengthRule(length: 11)])
        validator.registerField(emailAdd, rules: [RequiredRule(), EmailRule(message: "Invalid email")])
        validator.registerField(address1, rules: [RequiredRule()])
        validator.registerField(address2, rules: [RequiredRule()])
        validator.registerField(city, rules: [RequiredRule()])
        validator.registerField(postCode, rules: [RequiredRule()])
        validator.registerField(position, rules: [RequiredRule()])
        validator.registerField(squadNo, rules: [RequiredRule()])
    }
    
    
    func formDelegation () {
        picker.delegate = self
        picker.dataSource = self
        picker2.delegate = self
        picker2.dataSource = self
        picker3.delegate = self
        picker3.dataSource = self
        sNoPicker.delegate = self
        sNoPicker.dataSource = self
        
        self.position.inputView = picker
        self.position2.inputView = picker2
        self.position3.inputView = picker3
        self.squadNo.inputView = sNoPicker
        
        firstName.delegate = self
        lastName.delegate = self
        dob.delegate = self
        phoneNo.delegate = self
        emailAdd.delegate = self
        address1.delegate = self
        address2.delegate = self
        city.delegate = self
        postCode.delegate = self
        position.delegate = self
        position2.delegate = self
        position3.delegate = self
        squadNo.delegate = self
        
        imagePicker.delegate = self

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
         createButtonClicked = false
    }
    
    // Validation Delegates
    
    func validationSuccessful() {
        
        player.pid = "\(firstName.text ?? "")\(lastName.text ?? "")\(NSUUID().uuidString)"
        player.firstName = firstName.text!
        player.lastName = lastName.text!
        player.dob = dob.text!
        player.phoneNo = phoneNo.text!
        player.emailAdd = emailAdd.text!
        player.address1 = address1.text!
        player.address2 = address2.text!
        player.city = city.text!
        player.postCode =  postCode.text!
        player.position = position.text!
        player.position2 = position2.text!
        player.position3 = position3.text!
        player.squadNo = squadNo.text!
        player.appearances = "0"
        player.goals = "0"
        player.assists = "0"
        if profilePic.image != nil {
            saveImage()
        } else {
            
        }
        
        let realm = try! Realm()
        try! realm.write() {
            realm.create(Player.self, value: player)
            player.pid = ""
        }
            resetValidation()
            resetProfile()
        
        
            self.createButtonClicked = true
        
            let addSuccessAlertView = SCLAlertView()
            addSuccessAlertView.showSuccess("Congrats!", subTitle: "Player has successfully been added.")
        
        
    }
    
    func validationFailed(_ errors:[(Validatable ,ValidationError)]) {
        
         let errorValAlertView = SCLAlertView()
         errorValAlertView.showWarning("Validation error", subTitle: "You have missed out/have entered some fields incorrectly.")
        
        // turn the fields to red
        for (field, error) in errors {
            if let field = field as? UITextField {
                field.layer.borderColor = UIColor.red.cgColor
                field.layer.borderWidth = 1.0
            }
            error.errorLabel?.text = error.errorMessage // works if you added labels
            }
        
    }
    
    func circlePicture () {
        self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width / 2
        self.profilePic.layer.borderColor = UIColor.green.cgColor
        self.profilePic.layer.borderWidth = 2
        self.profilePic.layer.shouldRasterize = true
    }
    
   func resetProfile () {
        
        firstName.text = ""
        lastName.text! = ""
        dob.text! = ""
        phoneNo.text! = ""
        emailAdd.text! = ""
        address1.text! = ""
        address2.text! = ""
        city.text! = ""
        postCode.text! = ""
        position.text! = ""
        position2.text! = ""
        position3.text! = ""
        squadNo.text! = ""
        profilePic.image = UIImage(named: "profile.jpg")
        picker.reloadAllComponents()
        picker2.reloadAllComponents()
        picker3.reloadAllComponents()
        sNoPicker.reloadAllComponents()
    _ = createButtonClicked == false
        self.position.inputView = picker
        self.position2.inputView = picker2
        self.position3.inputView = picker3
        self.squadNo.inputView = sNoPicker
        self.tableView.reloadData()
    }
    
    func resetValidation () {
        
        firstName.layer.borderWidth = 0
        lastName.layer.borderWidth = 0
        dob.layer.borderWidth = 0
        phoneNo.layer.borderWidth = 0
        emailAdd.layer.borderWidth = 0
        address1.layer.borderWidth = 0
        address2.layer.borderWidth = 0
        city.layer.borderWidth = 0
        postCode.layer.borderWidth = 0
        position.layer.borderWidth = 0
        squadNo.layer.borderWidth = 0
        
        validator.unregisterField(firstName)
        validator.unregisterField(lastName)
        validator.unregisterField(dob)
        validator.unregisterField(phoneNo)
        validator.unregisterField(emailAdd)
        validator.unregisterField(address1)
        validator.unregisterField(address2)
        validator.unregisterField(city)
        validator.unregisterField(postCode)
        validator.unregisterField(position)
        validator.unregisterField(squadNo)
    
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        dob.text = dateFormatter.string(from: sender.date)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        
        switch textField
        {
        case firstName:
            lastName.becomeFirstResponder()
            break
        case lastName:
            dob.becomeFirstResponder()
            break
        case dob:
            phoneNo.becomeFirstResponder()
            break
        case phoneNo:
            emailAdd.becomeFirstResponder()
            break
        case emailAdd:
            address2.becomeFirstResponder()
            break
        case address2:
            city.becomeFirstResponder()
            break
        case city:
            postCode.becomeFirstResponder()
            break
        case postCode:
            position.becomeFirstResponder()
            break
        case position:
            position2.becomeFirstResponder()
            break
        case position2:
            position3.becomeFirstResponder()
            break
        case position3:
            squadNo.becomeFirstResponder()
            break
        case squadNo:
            squadNo.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
    
    // returns the number of 'columns' to display.
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == picker {
            return 1
        } else if pickerView == picker2 {
            return 1
        } else if pickerView == picker3 {
            return 1
        } else {
            return 1
        }
    }
    
    
    // returns the # of rows in each component..
    @available(iOS 2.0, *)
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == picker {
            return positionData.count
        } else if pickerView == picker2 {
            return positionData.count
        } else if pickerView == picker3  {
            return positionData.count
        } else {
            return squadNoData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == picker {
            position.text = positionData[row]
        } else if pickerView == picker2 {
            position2.text = positionData[row]
        } else if pickerView == picker3 {
            position3.text = positionData[row]
        } else {
            squadNo.text = squadNoData[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == picker {
            return positionData[row]
        } else if pickerView == picker2 {
            return positionData[row]
        } else if pickerView == picker3 {
            return positionData[row]
        } else {
            return squadNoData[row]
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.red
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */



}
