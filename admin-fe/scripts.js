function login() {
    let username = $("#username_input").val();
    let password = $("#password_input").val();
    if (username === "username" && password === "password") {
        console.log("login sucess");
        window.location.assign("notes.html");
    } else {
        alert("Login failed");
    }
}

let exampleNotes = [
    {
        time: "08:35 3/21/2017",
        name: "Jane Doe",
        vumc_unit: "General Medical",
        clinician_type: "Physician Assistant",
        tenure: "Less than 5 Years",
        code: "4356811",
        symptoms: [
            "Visual hallucinations",
            "Focal seizures"
        ]
    },
    {
        time: "14:35 3/24/2017",
        name: "John Doe",
        vumc_unit: "Geriatrics",
        clinician_type: "Resident",
        tenure: "more than 5 years",
        code: "4356810",
        symptoms: [
            "Severe pitting edema",
            "Fragile hair",
            "Swelling of eyes"
        ]
    },
    {
        time: "18:35 3/24/2017",
        name: "Jane Doe",
        vumc_unit: "General Medical",
        clinician_type: "Physician Assistant",
        tenure: "Less than 5 years",
        code: "4356811",
        symptoms: [
            "Severe pitting edema",
            "Visual hallucinations",
            "Epileptic encephalopathy"
        ]
    }
]

function showNotes(notes) {
    let notesListEl = $("#notes_list");
    notesListEl.empty();
    $.each(notes, function(i) {
        let note = notes[i];
        let li = $("<li/>")
            .addClass("note-element")
            .appendTo(notesListEl);
        $("<p/>").text(note.time).appendTo(li);
        $("<p/>").text(note.name).appendTo(li);
        $("<p/>").text(note.vumc_unit).appendTo(li);
        $("<p/>").text(note.clinician_type).appendTo(li);
        $("<p/>").text(note.tenure).appendTo(li);
        $("<br/>").appendTo(li);
        $("<p/>").text("Diagnosis ICD-10 Code: " + note.code);
        $("<p/>").text("Symptoms present:");
        $.each(note.symptoms, function(i) {
            let symptom = note.symptoms[i];
            $("<p/>").text(symptom).appendTo(li);
        });
    });
   
}

function setupNotes() {
    console.log("setting up notes");
    let notes = exampleNotes;
    showNotes(notes);
}

function updateNotes() {
    console.log("updating notes");
    let notes = exampleNotes;
    let vumc_unit = $("#vumc_unit :selected").text();
    let clinician_type = $("#clinician_type :selected").text();
    let years_in_practice = $("#years_in_practice :selected").text();
    if (vumc_unit !== "All Units") {
        notes = notes.filter(function(note) {
            return note.vumc_unit === vumc_unit;
        });
    }
    if (clinician_type !== "All Types") {
        console.log(clinician_type);
        notes = notes.filter(function(note) {
            return note.clinician_type === clinician_type;
        });
    }
    if (years_in_practice !== "All") {
        notes = notes.filter(function(note) {
            return note.years_in_practice === years_in_practice;
        });
    }
    showNotes(notes);
}