//
//  SocialCentreViewController.swift
//  PFCM
//
//  Created by Thomas Anderson on 10/04/2017.
//  Copyright © 2017 Thomas Anderson. All rights reserved.
//

import UIKit
import Firebase
import SCLAlertView

class SocialCentreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addImage: UIButton!
    @IBOutlet weak var post: UIButton!
    @IBOutlet weak var txt: UITextField!
    
    var ref: FIRDatabaseReference = FIRDatabase.database().reference()
    var results: [Post] = []
    var searchResults: [Post] = []
    var searchController: UISearchController!
    let storage = FIRStorage.storage()
    let imagePicker = UIImagePickerController()
    var profilePic: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        retrievePosts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func retrievePosts() {
        let postsRef = ref.child("posts")
        
        postsRef.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    let post = Post(snapshot: snap)
                    self.results.append(post)
                }
            }
            self.tableView.reloadData()
        })
    }

    func setupSearch() {
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.tintColor = UIColor.black
        searchController.searchBar.delegate = self
        searchController.searchBar.barTintColor = UIColor.white
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView?.addSubview(searchController.searchBar)
        
    }

    @IBAction func addPhoto(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.modalPresentationStyle = .popover
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func post (_ sender: Any) {
       createPost()
    }

    
    func createPost () {
        let user = FIRAuth.auth()?.currentUser
        let key = ref.child("posts").childByAutoId().key
        let storage = FIRStorage.storage()
        let storageRef = storage.reference()
        let imageURL = "\(user!.uid)/posts/\(key).jpg"
        let picRef = storageRef.child(imageURL)
        let data = UIImageJPEGRepresentation(self.profilePic!, 0.7)! as Data
        picRef.put(data,metadata: nil)
        
        let postID = ["postID": key]
        let post = Post(postID: key, caption: txt.text!, imageURL: imageURL, likes: 0, timestamp: FIRServerValue.timestamp())
        let postsRef = ref.child("posts")
        let userRef = ref.child("users").child(user!.uid)
        postsRef.setValue(post.toAny())
        userRef.child("posts").setValue(postID)
        
        let addSuccessAlertView = SCLAlertView()
        addSuccessAlertView.showSuccess("Congrats!", subTitle: "Post has successfully been added.")
        self.tableView.setContentOffset(CGPoint.zero, animated: true)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.profilePic = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive ? searchResults.count : results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let posts: Post = searchController.isActive ? searchResults[indexPath.item] : results[indexPath.row]
        let storageRef = storage.reference(withPath: posts.imageURL)
        //let usersRef = ref.child("users")
        
        cell.caption.text = posts.caption
        cell.likes.text = String(posts.likes)
        storageRef.data(withMaxSize: 1 * 1024 * 1024) { (data, error) in
            if let error = error {
                print("error has occured: \(error)")
            } else {
                let image = UIImage(data: data!)
                cell.profilePic.image = image
            }
        }
        return cell
    }
}

// MARK: - UISearchResultsUpdating
extension SocialCentreViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = searchController.searchBar.text else {
            return
        }
        print (searchText)
        searchResults = results.filter { post in
            return post.caption.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
    
}

// MARK: - UISearchBarDelegate
extension SocialCentreViewController:  UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    }
}

