import ballerina/persist as _;

public type Patient record {|
    readonly string id;
    string name;
    int age;
    PatientAssignment[] physiciansAssigned;
	DrugAssignment[] drugassignment;
	BloodPressure[] bloodpressure;
|};

public type Physician record {|
    readonly string id;
    string name;
    string specialization;
    PatientAssignment[] patientsAssigned;
    DrugAssignment[] drugsAssigned;
|};

public type PatientAssignment record {|
   readonly string id; 
   Patient patient;
   Physician physician;
|};

type DrugAssignment record {|
    readonly string id;
    Physician physician;
    Drug drug;
    Patient patient;
    int quantity;
|};

type Manufacturer record {|
    readonly string id;
    string name;
    string countryOfOrigin;
    Drug[] drugsManufactured;
|};

public type Drug record {|
    readonly string id;
    string name;
    string description;
    DrugAssignment[] patientsAssigned;
    Manufacturer manufacturer;
|};

public type BloodPressure record {|
    readonly string id;
    readonly string timestamp;
    Patient patient;
    int systolic;
    int diastolic;
|};
