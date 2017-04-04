# JSON documentation
    * Every valid json document must have an array as the outer-most element.
    * Inside the array are objects, with the class 'screen', along with one and only one object of class 'main-screen'
    * Screen objects represent all the screens that are displayed in the app
    * Inside each screen object is an array called contents that contains all the controls in the page, such as buttons, textfields, dropdowns etc.


Classes:
1. screen
    * A screen that isn't the main screen 
    * Attributes:
        * id: a unique identifier for the screen, i.e screen1, screen2, etc.
        * title: what is displayed at tthe top of the screen
        * content: an array of objects such as dropdowns, switches, etc.
2. main-screen
    * The very first screen that shows up, contains references to all other screens
    * Attributes:
        * All the same as screen
3. multiple-choice
    * A multiple choice selector
    * Attributes:
        * text: What is displayed at the top
        * options: an array of strings that represent choices that can be selected.
4. dropdown
    * A drop down menu
    * Attributes:
        * text: What is displayed at the left side of the dropdown
        * options: an array of strings that represent choices that can be selected.
5. switch
    * text: What is dispalyed at the left (the actual switch is on the right)
6. textfield
    * text: What is displayed before any text is entered (aka placeholder)
7. button
    * text: What is displayed on the button
    * click: id value of the screen that will be navigated to when the button is clicked

##Example JSON:
 [{
		"id": "screen0",
		"class": "main-screen",
        "title": "Main Screen",
		"content": [
                    {
                    "class":"dropdown",
                    "text": "Dropdown 3",
                    "options":["1","2","3"]
                    },
                    {
                    "class": "switch",
                    "text": "Switch 1"
                    },
                    {
                    "class":"dropdown",
                    "text": "Dropdown 3",
                    "options":["4","5"]
                    },
                    {
                    "class":"dropdown",
                    "text": "Dropdown 4",
                    "options":["7"]
                    },
                    {
                    "class": "switch",
                    "text": "Switch 2"
                    },
                    {
                    "class": "textfield",
                    "text": "TextField 1"
                    },
                    {
                    "class":"dropdown",
                    "text": "Dropdown 1",
                    "options":["10","11","12","13"]
                    },
                    {
                    "class":"dropdown",
                    "text":"Dropdown 2",
                    "options":["13", "14"]
                    },
                    {
                    "class":"textfield",
                    "text":"bowen"
                    },
                    {
                    "class":"dropdown",
                    "text": "Dropdown 3",
                    "options":["pennsylvania avenue","dasdfadsfasdfasdfasdfasdf","hey sirui how are you this is bowen have a nice day","18"]
                    },
                    {"class":"button",
                    "text":"Go to Screen 1",
                    "click":"screen1"
                    },
                    {"class":"textfield",
                    "text":"hello world"},
                    {"class":"button",
                    "text":"Hi class",
                    "click":"screen2"}
                    ]
  },
  
  {
		"id": "screen1",
        "title": "Screen 1",
		"class": "screen",
		"content": [{"class":"button", "text":"Go to Screen 2", "click":"screen2"},
                    {"class":"label", "text":"Some label lol"}]
  },
  
  {
		"id": "screen2",
		"class": "screen",
        "title": "Screen 2",
		"content": [{"class":"button", "text":"Go back to main screen", "click":"screen0"}, {"class":"dropdown", "text":"some dropdown", "options":["hello","bowen","jin"]},
                    {
                    "class":"dropdown",
                    "text": "new dropdown",
                    "options":["15","16","17","18"]
                    },
                    {"class":"multiple-choice",
                    "text": "here are some choices",
                    "options":["choice1", "choice2", "choice3"]
                    },
                    {"class":"button",
                    "text":"go to screen3",
                    "click":"screen3"
                    },
                    {"class":"textfield",
                    "text":"hello world"}]
  },
  
  {
		"id": "screen3",
        "title": "Screen 3",
		"class": "screen",
		"content": []
  }
  ]
