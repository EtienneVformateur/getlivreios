//
//  ViewController.swift
//  Livre
//
//  Created by Etienne VAYTILINGOM on 08/07/2021.
//

import UIKit
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class ViewController: UIViewController {

    @IBOutlet weak var idlivre: UITextField!
    @IBOutlet weak var titre: UILabel!
    @IBOutlet weak var auteur: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    struct Livre: Codable {
        var titre: String?
        var auteur: String?
    }
    
    @IBAction func getlivre(_ sender: Any) {
        let id = idlivre.text
        var request = URLRequest(url: URL(string: "https://module5.etienne-vaytilingom.re/livres/" + id!)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Livre.self, from: data) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        // update our UI
                       
                        self.titre.text = decodedResponse.titre
                        self.auteur.text = decodedResponse.auteur
                    }

                    // everything is good, so we can exit
                    return
                }
            }
            else {
                print(String(describing: error))
                
                return
              }
        
        }.resume()
        
        
    }
    

}

