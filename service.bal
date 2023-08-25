import ballerina/http;
import ballerina/log;
import ballerina/persist;
import ballerina/time;

import medical_centre/patient_management.store;

final store:Client patientManagementDb;

isolated function initDbClient() returns store:Client|error => new ();

isolated service /patient\-management on new http:Listener(9090) {
    public isolated function init() returns error? {
        patientManagementDb = check initDbClient();
        log:printInfo("Patient management service started");
    }

    isolated resource function post patients(@http:Payload store:Patient[] patients)
        returns RecordCreated|error {
        string[] patientInsert = check patientManagementDb->/patients.post(patients);
        return {
            body: {message: string `Patients Created: ${patientInsert.toString()}    `}
        };
    }

    isolated resource function post physicians(@http:Payload store:Physician[] physicians)
        returns RecordCreated|error {
        string[] physiciansInsert = check patientManagementDb->/physicians.post(physicians);
        return {
            body: {message: string `Physicians Created: ${physiciansInsert.toString()}    `}
        };
    }

    isolated resource function post patient_assignments(@http:Payload store:PatientAssignment[] patientAssignments)
        returns RecordCreated|error {
        string[] patientAssignmentInsert = check patientManagementDb->/patientassignments.post(patientAssignments);
        return {
            body: {message: string `Patient Assignment Created: ${patientAssignmentInsert.toString()}    `}
        };
    }

    isolated resource function post drug_assignments(@http:Payload store:DrugAssignment[] drugAssignments)
        returns RecordCreated|error {
        string[] drugAssignmentInsert = check patientManagementDb->/drugassignments.post(drugAssignments);
        return {
            body: {message: string `Drug Assignment Created: ${drugAssignmentInsert.toString()}    `}
        };
    }

    isolated resource function post drugs(@http:Payload store:Drug[] drugs)
        returns RecordCreated|error {
        string[] drugInsert = check patientManagementDb->/drugs.post(drugs);
        return {
            body: {message: string `Drug Created: ${drugInsert.toString()}    `}
        };
    }

    isolated resource function post manufacturers(@http:Payload store:Manufacturer[] manufacturers)
        returns RecordCreated|error {
        string[] manufacturerInsert = check patientManagementDb->/manufacturers.post(manufacturers);
        return {
            body: {message: string `Manufacturer Created: ${manufacturerInsert.toString()}    `}
        };
    }

    isolated resource function post blood_pressures(@http:Payload store:BloodPressure[] bloodPressures)
        returns RecordCreated|error {
        [string, string][] bloodPressureInsert = check patientManagementDb->/bloodpressures.post(bloodPressures);
        return {
            body: {message: string `Blood Preassure Readings Created: ${bloodPressureInsert.toString()}    `}
        };
    }

    isolated resource function delete patients/[string patientId]()
        returns http:NoContent|RecordNotFound|error {
        _ = check patientManagementDb->/patients/[patientId].delete();
        return http:NO_CONTENT;
    }

    isolated resource function delete manufacturer/[string manufacturerId]()
        returns http:NoContent|RecordNotFound|error {
        _ = check patientManagementDb->/manufacturers/[manufacturerId].delete();
        return http:NO_CONTENT;
    }

    isolated resource function delete drug/[string drugId]()
        returns http:NoContent|RecordNotFound|error {
        _ = check patientManagementDb->/drugs/[drugId].delete();
        return http:NO_CONTENT;
    }

    isolated resource function delete patient_assignment/[string assignmentId]()
        returns http:NoContent|RecordNotFound|error {
        _ = check patientManagementDb->/patientassignments/[assignmentId].delete();
        return http:NO_CONTENT;
    }

    isolated resource function delete drug_assignment/[string assignmentId]()
        returns http:NoContent|RecordNotFound|error {
        _ = check patientManagementDb->/drugassignments/[assignmentId].delete();
        return http:NO_CONTENT;
    }

    isolated resource function delete physician/[string physicianId]()
        returns http:NoContent|RecordNotFound|error {
        _ = check patientManagementDb->/physicians/[physicianId].delete();
        return http:NO_CONTENT;
    }

    isolated resource function delete blood_pressure/[string patientId]/[string timestamp]()
        returns http:NoContent|RecordNotFound|error {
        _ = check patientManagementDb->/bloodpressures/[patientId]/[timestamp].delete();
        return http:NO_CONTENT;
    }

    isolated resource function get physicians()
        returns PhysicianLog[]|RecordNotFound|error {
        stream<PhysicianLog, persist:Error?> physiciansStream = check patientManagementDb->/physicians.get();
        PhysicianLog[]|error physicians = from PhysicianLog physician in physiciansStream
            select physician;
        if physicians is persist:NotFoundError {
            ErrorDetails errorDetails = buildErrorPayload(string `No records found for physicians`, string `physicians`);
            RecordNotFound physiciansNotFound = {
                body: errorDetails
            };
            return physiciansNotFound;
        }
        return physicians;
    }

    isolated resource function get patients/[string id]()
        returns PatientLog|RecordNotFound|error {
        PatientLog|error patient = patientManagementDb->/patients/[id].get();
        if patient is persist:NotFoundError {
            ErrorDetails errorDetails = buildErrorPayload(string `No records found for patient: ${id}`, string `patients/${id}`);
            RecordNotFound patientNotFound = {
                body: errorDetails
            };
            return patientNotFound;
        }
        return patient;
    }

    isolated resource function put bloodpressure/[string patientId]/[string timestamp](
            @http:Payload store:BloodPressureUpdate updatedBloodPressure)
        returns store:BloodPressure|RecordNotFound|error {
        store:BloodPressure|error result = patientManagementDb->/bloodpressures/[patientId]/[timestamp].put(updatedBloodPressure);
        if result is persist:NotFoundError {
            ErrorDetails errorDetails = buildErrorPayload(string `id: ${patientId}, ${timestamp}`, string `bloodpressurea/${patientId}/${timestamp}`);
            RecordNotFound userNotFound = {
                body: errorDetails
            };
            return userNotFound;
        } else {
            return result;
        }
    }

}

isolated function buildErrorPayload(string msg, string path) returns ErrorDetails => {
    message: msg,
    timeStamp: time:utcNow(),
    details: string `uri=${path}`
};
