import UIKit

class MenuController: UIViewController {
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuButton: UIButtonX!
    @IBOutlet weak var gradeButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var logo: UIImageView!
    
    
    
    //================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //--------- Here is the logo "Évaluation+" animation
        
        logo.center.x = self.view.frame.width + 30
        
        UIView.animate(withDuration: 2.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 30, options: [], animations: {
            
            self.logo.center.x = self.view.frame.width / 2
            
        })
        
        
        
        //---------
        
        closeMenu()
    }
    //================
    @IBAction func menuTapped(_ sender: FloatActionButton) {
        
        UIView.animate(withDuration: 0.3, animations: {
            
            if self.menuView.transform == .identity {
                //menu when its open
                self.closeMenu()
            } else {
                self.menuView.transform = .identity
            }
        })
        
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations:{
            if self.menuView.transform == .identity {
                self.gradeButton.transform = .identity
                self.addButton.transform = .identity
            }
        })
        
    }
    //================
    func closeMenu() {
        menuView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        gradeButton.transform = CGAffineTransform(translationX: 0, y: 15)
        addButton.transform = CGAffineTransform(translationX: 15, y: 0)
    }
    
}


