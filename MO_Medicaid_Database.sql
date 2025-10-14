CREATE TABLE Applicant (
	UserID               INT             PRIMARY Key,
	FirstName            VARCHAR(50),
	LastName             VARCHAR(50),
	DateOfBirth          DATE,
	SSN                  VARCHAR(11),
	Address              VARCHAR(100),
	City                 VARCHAR(50),
	USState              VARCHAR(50),
	ZipCode              VARCHAR(10),
	MOCounty             VARCHAR(30),
	MedicaidNumber       VARCHAR(20)
);

CREATE TABLE Staff (
	StaffID              INT             PRIMARY Key,
	FirstName            VARCHAR(50),
	LastName             VARCHAR(50),
	Role                 VARCHAR(20)
);

CREATE TABLE Demographics (
	UserID               INT             PRIMARY Key,
	IsDisabled           BOOLEAN,
	IsVeteran            BOOLEAN,
	IsChild              BOOLEAN,
	IsElderly            BOOLEAN,
	IsPregnant           BOOLEAN,
	IsTribal             BOOLEAN,
	IsCaregiver          BOOLEAN,
	
	FOREIGN KEY (UserID)         REFERENCES Applicant(UserID)
);

CREATE TABLE Employment (
	EmploymentID         INT             PRIMARY KEY,
	UserID               INT,
	EmploymentStatus     VARCHAR(20),
	EmployerName         VARCHAR(100),
	HoursPerWeek         INT,
	DateVerified         DATE,
	
	FOREIGN KEY (UserID)           REFERENCES Applicant(UserID)
);

CREATE TABLE Unemployment (
	UnemploymentID       INT             PRIMARY KEY,
	UserID               INT,
	ApplicationDate      DATE,
	CompanyName          VARCHAR(100),
	JobTitle             VARCHAR(100),
	StaffID              INT,
	DateVerified         DATE,
	VerificationStatus   VARCHAR(20),
	VerificationNotes    TEXT,
	
	FOREIGN KEY (UserID)           REFERENCES Applicant(UserID),
	FOREIGN KEY (StaffID)          REFERENCES Staff(StaffID)
);

CREATE TABLE Application (
	ApplicationID        INT             PRIMARY KEY,
	UserID               INT,
	SubmissionDate       DATETIME,
	Status               VARCHAR(20),
	CaseWorkerID         INT,
	
	FOREIGN KEY (UserID)           REFERENCES Applicant(UserID),
	FOREIGN KEY (CaseWorkerID)     REFERENCES Staff(StaffID),
);

CREATE TABLE RequiredDocuments (
	DocID                INT             PRIMARY KEY,
	DocName              VARCHAR(100),
	Description          TEXT
):

CREATE TABLE SubmittedDocuments (
	SubmissionID         INT             PRIMARY KEY,
	ApplicationID        INT,
	DocID                INT,
	SateSubmitted        DATE,
	IsVerified           BOOLEAN,
	
	FOREIGN KEY (ApplicationID)    REFERENCES Application(ApplicationID),
	FOREIGN KEY (DocID)            REFERENCES RequiredDocuments(DocID)
);

CREATE TABLE AuditLog (
	LogID                INT             PRIMARY KEY,
	ApplicationID        INT,
	StaffID              INT,
	ChangeDate           DATE,
	Description          TEXT,
	FOREIGN KEY (ApplicationID)    REFERENCES Application(ApplicationID),
	FOREIGN KEY (StaffID)          REFERENCES Staff(StaffID)
);