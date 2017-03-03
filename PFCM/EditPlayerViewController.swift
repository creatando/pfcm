//
//  EditPlayerViewController.swift
//  PFCM
//
//  Created by Thomas Anderson on 21/02/2017.
//  Copyright © 2017 Thomas Anderson. All rights reserved.
//

import UIKit
import RealmSwift
import SCLAlertView
import SwiftValidator




class EditPlayerViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, ValidationDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
        
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
        @IBOutlet weak var goalsText: UITextField!
        @IBOutlet weak var assistsText: UITextField!
        @IBOutlet weak var appsText: UITextField!
    
        @IBAction func appsPlus(_ sender: Any) {
            let result: Int = Int(appsText.text!)! + 1
            appsText.text = String(result)
        }
    
        @IBAction func assistsPlus(_ sender: Any) {
            let result: Int = Int(assistsText.text!)! + 1
            assistsText.text = String(result)
        }
    
        @IBAction func goalsPlus(_ sender: Any) {
            let result: Int = Int(goalsText.text!)! + 1
            goalsText.text = String(result)
        }
    
    
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
            
            if self.saveButtonClicked == false {
               confirmAlertView.addButton("Yes") {
                  _ = self.navigationController?.popViewController(animated: true)
                    self.saveButtonClicked = false
                }
                
                confirmAlertView.addButton("No") {
                    self.saveButtonClicked = false
                }
            
                self.view.endEditing(true)
                confirmAlertView.showInfo("Leave", subTitle: "Are you sure you want to exit before adding another player?")
            } else {
                _ = self.navigationController?.popViewController(animated: true)
            }
        }
        
        @IBAction func addPhoto(_ sender: UIBarButtonItem) {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            imagePicker.modalPresentationStyle = .popover
            present(imagePicker, animated: true, completion: nil)
            imagePicker.popoverPresentationController?.barButtonItem = sender
        }
        
    @IBAction func updatePlayer(_ sender: Any) {
        validator.validate(self)
        let  vc =  self.navigationController?.viewControllers.filter({$0 is ViewPlayersController}).first
        _ = navigationController?.popToViewController(vc!, animated: true)
    }
        
        let imagePicker = UIImagePickerController()
        let player = Player()
        var saveButtonClicked = false
        let validator = Validator()
        var positionData = ["", "GK", "LB", "CB", "RB", "LWB", "RWB", "DM", "CM", "LM", "RM", "CAM", "LW", "RW", "CF" ]
        var noData = ["","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99"]
        
        var picker = UIPickerView()
        var picker2 = UIPickerView()
        var picker3 = UIPickerView()
        var sNoPicker = UIPickerView()
        var goalsPicker = UIPickerView()
        var assistsPicker = UIPickerView()
        var appsPicker = UIPickerView()
        var selectedPlayer: String?
        var selectedPicPath: String?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        circlePicture()
        formDelegation()
        //formValidation()
        checkSelected ()
        checkImageExists()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func checkSelected () {
        if selectedPlayer == nil {
            print("Right player ID is not sent! \(selectedPlayer!)")
        } else {
            print("Retrieved")
            retrievePlayer()
        }
    }

    
    func retrievePlayer () {
        let singlePlayer = try! Realm().object(ofType: Player.self, forPrimaryKey: selectedPlayer)
        print("retrieve starting")
        firstName.text = singlePlayer?.firstName
        lastName.text = singlePlayer?.lastName
        dob.text = singlePlayer?.dob
        phoneNo.text = singlePlayer?.phoneNo
        emailAdd.text = singlePlayer?.emailAdd
        address1.text = singlePlayer?.address1
        address2.text = singlePlayer?.address2
        city.text = singlePlayer?.city
        postCode.text = singlePlayer?.postCode
        position.text = singlePlayer?.position
        position2.text = singlePlayer?.position2
        position3.text = singlePlayer?.position3
        squadNo.text = singlePlayer?.squadNo
        goalsText.text = singlePlayer?.goals
        assistsText.text = singlePlayer?.assists
        appsText.text = singlePlayer?.appearances
        selectedPicPath = singlePlayer?.picFilePath
        
        print("\(singlePlayer?.picFilePath) is SINGLEPLAYER selected pic path.")
        print("\(selectedPicPath) is selected pic path.")
    
        
        if selectedPicPath != nil {
            print ("Player's pic path = \(selectedPicPath!)")
             loadImageFromRealm(picName: (selectedPicPath!))
        } else {
           print ("Pic not loaded")
        }
        
        print("retrieval finished, load data")
        self.tableView.reloadData()
    }
    
    
    func loadImageFromRealm (picName: String) {
        
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath          = paths.first
        {   print("directory accessed")
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(picName)
            let image   = UIImage(contentsOfFile: imageURL.path)
        
        if image != nil
            { profilePic.image = image
    
        } else {
            profilePic.image = UIImage (named: "profile.jpg")
            }
            
        print("Directory image: \(profilePic.image!)")
        }
        
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
        goalsPicker.delegate = self
        goalsPicker.dataSource = self
        assistsPicker.delegate = self
        assistsPicker.dataSource = self
        appsPicker.delegate = self
        appsPicker.dataSource = self
        
        self.position.inputView = picker
        self.position2.inputView = picker2
        self.position3.inputView = picker3
        self.squadNo.inputView = sNoPicker
        self.goalsText.inputView = goalsPicker
        self.assistsText.inputView = assistsPicker
        self.appsText.inputView = appsPicker
        
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
        goalsText.delegate = self
        assistsText.delegate = self
        appsText.delegate = self
        
        imagePicker.delegate = self
        
    }
    
    // Validation Delegates
    
    func validationSuccessful() {
        
        player.pid = selectedPlayer!
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
        player.goals = goalsText.text!
        player.assists = assistsText.text!
        player.appearances = appsText.text!
        updateImage()
        player.picFilePath = selectedPicPath!
        
        
        let realm = try! Realm()
        try! realm.write() {
            realm.add(player, update: true)
        }

        self.saveButtonClicked = true
        
        let addSuccessAlertView = SCLAlertView()
        addSuccessAlertView.showSuccess("Congrats!", subTitle: "Player has successfully been updated.")
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
    func checkImageExists () {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        let filePath = url.appendingPathComponent("\(selectedPicPath!)")?.path
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath!) {
            print("FILE AVAILABLE")
        } else {
            print("FILE NOT AVAILABLE")
        }
    }
    
    func  updateImage() {
        
        print("Selected image is:\(selectedPicPath!)")
        
        let documentsDirectoryURL = try! FileManager().url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = documentsDirectoryURL.appendingPathComponent("\(selectedPicPath!)")
        print ("file url is: \(fileURL)")
        checkImageExists()
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                print(profilePic.image as Any)
                if profilePic.image != nil {
                print ("first file \(fileURL)")
                //removeImage(url: selectedPicPath!)
                let image = profilePic.image!.generateJPEGRepresentation()
                    print(profilePic.image!)
                    print (image)
                try! image.write(to: fileURL, options: .atomicWrite)
                print("Image Added Successfully")
                } else {
                    print("Image not added")
                }
            } catch {
                print(error)
            }
            
        }
        print(profilePic.image!)
    }
    
    
    func removeImage(url:String) {
        let fileManager = FileManager.default
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        guard let dirPath = paths.first else {
            return
        }
        let filePath = "\(dirPath)/\(url)"
        do {
            try fileManager.removeItem(atPath: filePath)
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    func circlePicture () {
        self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width / 2
        self.profilePic.layer.borderColor = UIColor.green.cgColor
        self.profilePic.layer.borderWidth = 2
        self.profilePic.layer.shouldRasterize = true
    }
    
    @IBAction func deletePlayer(_ sender: Any) {
        let appearance = SCLAlertView.SCLAppearance(showCloseButton: false)
        let confirmAlertView = SCLAlertView(appearance: appearance)
            confirmAlertView.addButton("Yes") {
                _ = self.navigationController?.popViewController(animated: true)
                self.saveButtonClicked = false
                
                let singlePlayer = try! Realm().object(ofType: Player.self, forPrimaryKey: self.selectedPlayer)
                let realm = try! Realm()
                try! realm.write() {
                    realm.delete(singlePlayer!)
                }
            }
        
            confirmAlertView.addButton("No") {
                self.saveButtonClicked = false
            }
            
            self.view.endEditing(true)
            confirmAlertView.showWarning("Delete", subTitle: "Are you sure you want to delete this player?")
        
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
        case goalsText:
            assistsText.becomeFirstResponder()
            break
        case assistsText:
            appsText.becomeFirstResponder()
            break
        case appsText:
            firstName.becomeFirstResponder()
            break
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
        return 1
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
        } else if pickerView == sNoPicker {
            return noData.count
        } else if pickerView == goalsPicker {
            return noData.count
        } else if pickerView == assistsPicker {
            return noData.count
        } else if pickerView == appsPicker {
            return noData.count
        } else {
            return noData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == picker {
            position.text = positionData[row]
        } else if pickerView == picker2 {
            position2.text = positionData[row]
        } else if pickerView == picker3 {
            position3.text = positionData[row]
        } else if pickerView == sNoPicker {
            squadNo.text = noData[row]
        } else if pickerView == goalsPicker {
            goalsText.text = noData[row]
        } else if pickerView == assistsPicker {
            assistsText.text = noData[row]
        } else if pickerView == appsPicker {
            appsText.text = noData[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == picker {
            return positionData[row]
        } else if pickerView == picker2 {
            return positionData[row]
        } else if pickerView == picker3 {
            return positionData[row]
        } else if pickerView == sNoPicker {
            return noData[row]
        } else if pickerView == goalsPicker {
            return noData[row]
        } else if pickerView == assistsPicker {
            return noData[row]
        } else if pickerView == appsPicker {
            return noData[row]
        } else {
            return noData[row]
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profilePic.image = pickedImage
            print(profilePic.image!)
        } else if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profilePic.image = pickedImage
            print(profilePic.image!)
        } else{
            print("Something went wrong")
        }

        
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButtonClicked = false
    }


    

}

