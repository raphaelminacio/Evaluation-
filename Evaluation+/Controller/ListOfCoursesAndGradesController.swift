
import Foundation

import UIKit

class ListOfCoursesAndGradesController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var course_grade_tableview: UITableView!
    @IBOutlet weak var student_name_label: UILabel!
    @IBOutlet weak var gradeAverage: UILabel!
    
    typealias studentName = String
    typealias course = String
    typealias grade = Double
    //===========
    let userDefaultsObj = UserDefaultsManager()
    var studentsGrades: [String: [course: Double]]!
    var arrOfCourses: [course]!
    var arrOfGrades: [grade]!
    //===========
    override func viewDidLoad() {
        student_name_label.text = userDefaultsObj.getValue(theKey: "name") as? String
        loadUserDefaults()
        filUpArray()
    }
    //===========
    func filUpArray(){
        let name = student_name_label.text
        let courses_and_grades = studentsGrades[name!]
        arrOfCourses = [course](courses_and_grades!.keys)
        arrOfGrades = [grade](courses_and_grades!.values)
    }
    //=========== Here's how to make an average of values from TableViewCells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var sum = 0.0
        
        for number in arrOfGrades {
            sum += number
        }
        let  ave: Double = Double(sum) / Double(arrOfGrades.count)
        gradeAverage.text = String(format: "Student's average grade is: %.1f", ave)
        
        return arrOfGrades.count
    }

    //===========
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = course_grade_tableview.dequeueReusableCell(withIdentifier: "proto2")!
        
        if let aCourse = cell.viewWithTag(200) as! UILabel! {
            aCourse.text = arrOfCourses[indexPath.row]
        }
        
        if let aGrade = cell.viewWithTag(201) as! UILabel! {
            aGrade.text = String(arrOfGrades[indexPath.row])
        }
        
        return cell
    }
    //=========== Here's the fonction to delete a row in a TableViewCell
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
            tableView.reloadData()
        }
    }
    //===========
    func loadUserDefaults() {     /* Verify if there's somethin in the memory */
        
        if userDefaultsObj.doesKeyExist(theKey: "grades") {
            studentsGrades = userDefaultsObj.getValue(theKey: "grades") as! [studentName: [course: grade]]
            
        } else {
            studentsGrades = [studentName: [course: grade]]()
        }
    }
    
}
