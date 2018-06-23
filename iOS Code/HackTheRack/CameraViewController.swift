//
//  CameraViewController.swift
//  HackTheRack
//
//  Created by KL on 23/6/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit
import TCPickerView

class CameraViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    let type = ["color_category", "age_group", "apparel_category", "apparel_pattern", "closure_type", "clothing_fit", "collar_type", "dress_length", "dress_occasion", "dress_style"]
    var content: [String] = []
    
    let cars = [
        "Red (79.90%)",
        "Yellow (20.05%)",
        "Green (0.04%)",
        "Blue (0.01%)",
        "Purple (0%)",
        "While (0%)",
        "Pink (0%)",
        "Black (0%)"
    ]

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "Table Cell")
        
        
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.clipsToBounds = true
    }
    
    @IBAction func openCamera(_ sender: Any) {
        print("dsadas")
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CameraViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return type.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let picker: TCPickerView = TCPickerView()
        picker.title = "Select Color"
        
        let values = cars.map { TCPickerView.Value(title: $0) }
        picker.values = values
        picker.delegate = self
        picker.layer.shadowColor = UIColor.darkGray.cgColor
        picker.layer.shadowOffset = CGSize(width: 0, height: 10)
        picker.selection = .multiply
        self.view.alpha = 0.5
        picker.completion = { (selectedIndexes) in
            self.view.alpha = 1
            print("completion")
            for i in selectedIndexes {
                print(values[i].title)
            }
        }
        
        picker.show()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(70)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Table Cell") as! TableViewCell
        cell.type.text = type[indexPath.row]
        
        if content.count > indexPath.row{
            cell.content.text = content[indexPath.row]
        }else{
            cell.content.text = " "
        }
        
        return cell
    }
}

extension CameraViewController: TCPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func pickerView(_ pickerView: TCPickerView, didSelectRowAtIndex index: Int) {
        print("selected")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.backgroundColor = nil
            imageView.image = image
            self.content = ["red", "Adult", "Women", "Solid", "Naah", "Regular", "V-Neck", "Mid", "work", "Sheath"]
            tableView.reloadData()
        }
        dismiss(animated:true, completion: nil)
    }
}
