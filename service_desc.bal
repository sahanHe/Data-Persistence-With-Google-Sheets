import ballerina/http;
import ballerina/time;


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
    record {|string patientId?; string physicianId?;|}[] physiciansAssigned;
    record {|string physicianId?; string drugId?; string patientId?; int quantity?;|}[] drugassignment;
    record {|string id?; string timestamp?; string patientId?; int systolic?; int diastolic?;|}[] bloodpressure;
|};

public type PhysicianLog record {|
    string id;
    string name;
    string specialization;
    record {|string patientId?;|}[] patientsAssigned;
    record {|string drugId?; string patientId?; int quantity?;|}[] drugsAssigned;
|};
