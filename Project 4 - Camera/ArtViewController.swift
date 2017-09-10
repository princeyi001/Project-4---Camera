//
//  ArtViewController.swift
//  Project 4 - Camera
//
//  Created by Dong Hun Yi on 9/9/17.
//  Copyright © 2017 PrinceYiCoding. All rights reserved.
//

import UIKit

class ArtViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var artView: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var addUpdateButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    var art : Art? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imagePicker.delegate = self
        
        if art != nil {
            artView.image = UIImage(data: art!.image! as Data)
            nameTextField.text = art!.name
            
            addUpdateButton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func photosTapped(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        artView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
    }

    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        if art != nil {
            art!.name = nameTextField.text
            art!.image = UIImagePNGRepresentation(artView.image!) as NSData?
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let art = Art(context: context)
            art.name = nameTextField.text
            art.image = UIImagePNGRepresentation(artView.image!) as NSData?
        }

        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        context.delete(art!)
        
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
