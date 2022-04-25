//
//  SplashViewController.swift
//  DigiturkMiniAPP
//
//  Created by bora ateş on 25.04.2022.
//

import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPurple
        fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchData()
    }
    
    func fetchData() {
        NetworkManager().getGenresList { response in
            if response.genres?.count ?? 0 > 0 {
                self.startApp()
            }
            else {
                self.showAlert()
            }
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Uyarı", message: "Lütfen internet bağlantı ayarlarınızı kontrol ediniz", preferredStyle: .alert)
       
        let cancel = UIAlertAction(title: "KAPAT", style: .destructive) { action in
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
            }
        }
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func startApp() {
        let router = HomeRouter().prepareView()
        let vc = UINavigationController(rootViewController: router)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
