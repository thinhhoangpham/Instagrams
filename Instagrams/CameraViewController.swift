//
//  CameraViewController.swift
//  Instagrams
//
//  Created by Thinh Pham on 10/10/21.
//

import UIKit
import AlamofireImage
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var statusTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func photolibButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
        
    }
    
    @IBAction func cameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }
        else {
            let alert = UIAlertController(title: "Oop!", message: "Camera is not available!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default))

            self.present(alert, animated: true, completion: nil)
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size =  CGSize(width: 500, height: 500)
        let scaledImage = image.af_imageScaled(to: size)
        
        postImageView.image = scaledImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendButton(_ sender: Any) {
        let post = PFObject(className: "Posts")
        
        post["status"] = statusTextField.text
        post["author"] = PFUser.current()!
        
        let imageData = postImageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        post["image"] = file
        
        post.saveInBackground { success, error in
            if success {
                print("Saved!")
                self.dismiss(animated: true, completion: nil)
            }
            else {
                print("Error!")
            }
        }
            
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
