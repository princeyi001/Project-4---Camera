//
//  ViewController.swift
//  Project 4 - Camera
//
//  Created by Dong Hun Yi on 9/9/17.
//  Copyright © 2017 PrinceYiCoding. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mainTableView: UITableView!
    
    var art : [Art] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mainTableView.dataSource = self
        mainTableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            art = try context.fetch(Art.fetchRequest())
            mainTableView.reloadData()
        } catch {
            
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return art.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let artS = art[indexPath.row]
        cell.textLabel?.text = artS.name
        cell.imageView?.image = UIImage(data: artS.image! as Data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let artS = art[indexPath.row]
        performSegue(withIdentifier: "artSegue", sender: artS)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! ArtViewController
        nextVC.art = sender as? Art
    }
    
}

