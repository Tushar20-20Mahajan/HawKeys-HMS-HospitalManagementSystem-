
import Foundation

// MARK: DOCTOR



struct ScheduleSlot: Codable {
    var timeSlot: String
    var startTime: String
    var endTime: String
    var id: String
    
    enum CodingKeys: String, CodingKey {
        case timeSlot
        case startTime
        case endTime
        case id = "_id"
    }
}

let sampleScheduleSlot = ScheduleSlot(
    timeSlot: "Morning",
    startTime: "09:00",
    endTime: "11:00",
    id: "slot1"
)


struct Schedule: Codable {
    var date: Date
    var slots: [ScheduleSlot]
    var id: String
    
    enum CodingKeys: String, CodingKey {
        case date
        case slots
        case id = "_id"
    }
}

let sampleSchedule = Schedule(
    date: Date(),
    slots: [sampleScheduleSlot],
    id: "schedule1"
)

struct Doctor: Identifiable, Codable {
    var id: String
    var accountType: String
    var firstName: String
    var lastName: String
    var age: Int
    var gender: String
    var phoneNumber: Int
    var approved: Bool
    var email: String
    var password: String
    var fees: String
    var about: String
    var specialization: String
    var experience: String
    var qualification: String
    let labTestAppointments: [TestDetails]?
    var createdAt: Date
    var updatedAt: Date
    var schedule: [Schedule]?
    
    
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case accountType
        case firstName
        case lastName
        case age
        case gender
        case phoneNumber
        case approved
        case email
        case password
        case labTestAppointments
        case fees
        case about
        case specialization
        case experience
        case qualification
    
        case createdAt
        case updatedAt
        case schedule
    }
}





struct DoctorResponse: Codable {
    var success: Bool
    var data: [Doctor]
}



