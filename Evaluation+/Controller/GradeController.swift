
import Foundation

import UIKit

class GradeContoller: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    //===========
    @IBOutlet weak var course_grade_tableview: UITableView!
    @IBOutlet weak var student_name_label: UILabel!
    @IBOutlet weak var course_field: UITextField!
    @IBOutlet weak var grade_field: UITextField!
    //===========
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
    //===========
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfCourses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = course_grade_tableview.dequeueReusableCell(withIdentifier: "proto")!
        
        if let aCourse = cell.viewWithTag(100) as! UILabel! {
            aCourse.text = arrOfCourses[indexPath.row]
        }
        
        if let aGrade = cell.viewWithTag(101) as! UILabel! {
            aGrade.text = String(arrOfGrades[indexPath.row])
        }
        
        return cell
    }
    func loadUserDefaults() {       /*verifica se tem alguma coisa na memoria*/
        if userDefaultsObj.doesKeyExist(theKey: "grades") {
            studentsGrades = userDefaultsObj.getValue(theKey: "grades") as! [studentName: [course: grade]]
            
        } else {
            studentsGrades = [studentName: [course: grade]]()
        }
    }
    @IBAction func save_course_and_grade(_ sender: UIButton) {
        let name = student_name_label.text!
        var student_courses = studentsGrades[name]!
        student_courses[course_field.text!] = Double(grade_field.text!)
        studentsGrades[name] = student_courses
        userDefaultsObj.setKey(theValue: studentsGrades as AnyObject, theKey: "grades")
        filUpArray()
        course_grade_tableview.reloadData()
    }
    
}
