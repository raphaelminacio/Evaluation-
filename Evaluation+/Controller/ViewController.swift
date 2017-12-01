

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentsGrades.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        cell.textLabel?.text = [studentName](studentsGrades.keys)[indexPath.row]
        return cell
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {          /* essa funcao é pra esconder o teclado*/
        textField.resignFirstResponder()
        return true
    }
    @IBOutlet weak var student_name_field: UITextField!
    @IBOutlet weak var student_name_tableview: UITableView!
    
    //-------------
    typealias studentName = String
    typealias course = String
    typealias grade = Double
    
    //-------------
    let userDefaultsObj = UserDefaultsManager()
    var studentsGrades: [String: [course: Double]]!
    
    //-------------
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserDefaults()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func add_student(_ sender: UIButton) {
        if student_name_field.text != "" {
            studentsGrades[student_name_field.text!] = [course: grade]()
            student_name_field.text = ""
            userDefaultsObj.setKey(theValue: studentsGrades as AnyObject, theKey: "grades")
            student_name_tableview.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = [studentName](studentsGrades.keys)[indexPath.row]
        userDefaultsObj.setKey(theValue: name as AnyObject, theKey: "name")
        performSegue(withIdentifier: "seg", sender: nil)
    }
    
    
    //-------------
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let name = [studentName](studentsGrades.keys)[indexPath.row]
            studentsGrades[name] = nil
            userDefaultsObj.setKey(theValue: studentsGrades as AnyObject, theKey: "grades")
            
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic) /* é pra deletar uma linha no tableView */
        }
    }
    
    //-------------
    func loadUserDefaults() {       /*verifica se tem alguma coisa na memoria*/
        if userDefaultsObj.doesKeyExist(theKey: "grades") {
            studentsGrades = userDefaultsObj.getValue(theKey: "grades") as! [studentName: [course: grade]]
            
        } else {
            studentsGrades = [studentName: [course: grade]]()
        }
    }
}



