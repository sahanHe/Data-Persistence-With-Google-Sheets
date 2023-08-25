import ballerina/http;
import ballerina/time;
import medical_centre/patient_management.store;

type RecordCreated record {|
    *http:Created;
    record {
        string message;
    } body;
|};

type RecordNotFound record {|
    *http:NotFound;
    ErrorDetails body;
|};

type BatchCreated record {|
    *http:Created;
    record {
        string[] messages;
    } body;
|};

type ErrorDetails record {|
    time:Utc timeStamp;
    string message;
    string details;
|};

public type PatientLog record {|
    string id;
    string name;
    int age;
    store:PatientAssignmentOptionalized[] physiciansAssigned;
    store:DrugAssignmentOptionalized[] drugassignment;
    store:BloodPressureOptionalized[] bloodpressure;
|};

public type PhysicianLog record {|
    string id;
    string name;
    string specialization;
    store:PatientAssignmentOptionalized[] patientsAssigned;
    store:DrugAssignmentOptionalized[] drugsAssigned;
|};
