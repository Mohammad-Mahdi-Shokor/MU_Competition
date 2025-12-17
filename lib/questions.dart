const List<String> triviaGeneralQuestions = [
  "What is the difference between data and information?",
  "Who was the first Lebanese president?",
  "What is the capital of Ethiopia?",
  "Which country currently has the highest inflation rate in the world?",
  "What is the largest company in the world by market capitalization?",
  "Data stored on a blockchain can be edited or deleted once recorded?",
];

const List<List<String>> triviaGeneralAnswers = [
  [
    "Data is raw facts, information processes data",
    "Data is always text. Information is always numbers",
    "Data is optional, information is mandatory",
    "Data is digital, information is physical",
  ],
  ["Bshara L Khory", "Emil La7ood", "Kamel Sham3oon", "Fo2ad Shhab"],
  ["Addis Ababa", "Asmara", "Kampala", "Kigali"],
  ["Venezuela", "Argentina", "Sudan", "Turkey"],
  ["Apple", "Amazon", "Microsoft", "Saudi Aramco"],
  [
    "False",
    "True",
    "It depends on the miner",
    "Only administrators can edit it",
  ],
];

const List<String> triviaCSQuestions = [
  "Why keep class attributes private?",
  "Why use const in JavaScript?",
  "Why choose a CSS class over an ID?",
  "Why split code into small functions?",
  "What does a constructor do?",
  "Why is === safer than ==?",
  "Why is composition flexible?",
  "Why prefer addEventListener()?",
  "Why does Flexbox help alignment?",
  "Why use method overriding?",
  "What does this refer to in JS?",
  "Why use position: absolute;?",
];

const List<List<String>> triviaCSAnswers = [
  [
    "To protect and control data",
    "To highlight variables",
    "To avoid constructors",
    "To speed up programs",
  ],
  ["Stops reassignment", "Improves speed", "Converts values", "Makes globals"],
  [
    "Classes can repeat",
    "IDs can’t style",
    "Classes load faster",
    "JS-only usage",
  ],
  ["Improves clarity", "Prevents crashes", "Removes variables", "Forces order"],
  [
    "Sets initial values",
    "Blocks inheritance",
    "Deletes objects",
    "Converts types",
  ],
  ["Checks type too", "Always true", "Converts types", "Only objects"],
  ["Easier changes", "Blocks overrides", "File limits", "Saves memory"],
  ["Cleaner and flexible", "Removes old ones", "Buttons only", "Runs faster"],
  ["Adjusts spacing", "Stops resizing", "Removes margins", "Forces equal size"],
  [
    "Customizes behavior",
    "Prevents calls",
    "Makes identical",
    "Removes constructors",
  ],
  ["Calling object", "Parent class", "Temp storage", "Window object"],
  ["Precise placement", "Removes styles", "Centers items", "Auto-resizes"],
];

const List<String> triviaBusinessQuestions = [
  "If a company adopts centralized decision-making, where are most decisions made?",
  "What is a SWOT analysis used for?",
  "What does CEO stand for?",
  "What does ROI stand for?",
  "What is the accounting equation for liabilities?",
  "What is break-even point?",
  "What is the purpose of financial forecasting?",
  "What is monopoly?",
  "What does BI stand for?",
  "These two products are?",
  "In double entry bookkeeping, which accounts are affected?",
  "What does SQL stand for?",
];

const List<List<String>> triviaBusinessAnswers = [
  [
    "Top management",
    "Middle managers",
    "Frontline employees",
    "External consultants",
  ],
  [
    "To analyze strengths, weaknesses, opportunities, and threats",
    "To calculate company profit",
    "To measure employee productivity",
    "To determine pricing strategy",
  ],
  [
    "Chief executive officer",
    "Central executive operator",
    "Chief enterprise officer",
    "Corporate efficiency organizer",
  ],
  [
    "Return on investment",
    "Rate of income",
    "Revenue over inventory",
    "Return on income",
  ],
  [
    "Liabilities equal assets minus equity",
    "Equity minus assets",
    "Assets plus equity",
    "Revenue minus expenses",
  ],
  [
    "Total revenue equals total cost",
    "When profit reaches maximum",
    "When expenses dropped to zero",
    "When sales exceeded production capacity",
  ],
  [
    "Predicting future financial performance",
    "Calculating last year’s taxes",
    "Determining employee bonuses",
    "Estimating product shelf-life",
  ],
  [
    "Single seller dominates the market",
    "Many sellers with identical products",
    "A government-sponsored charity",
    "A competitive market with price limits",
  ],
  [
    "Business intelligence",
    "Basic infrastructure",
    "Business integration",
    "Budget insights",
  ],
  ["Substitute", "Complimentary", "Independent goods", "Inferior goods"],
  [
    "Debit equipment and credit cash",
    "Debit cash and credit equipment",
    "Debit revenue and credit cash",
    "Debit assets and credit liabilities",
  ],
  [
    "Structured query language",
    "Standard quality logic",
    "System query level",
    "Scripted, quick language",
  ],
];
const List<String> triviaBackupQuestions = [
  "Which university was originally known as the Syrian Protestant College?",
  "What is the missing letter? A, C, F, J, O…",
  "What is the name of the international assessment used to measure 15-year-old students’ performance in reading, mathematics, and science across countries?",
  "Which Lebanese city is known for having the oldest continuously operating law school in the world during the Roman era?",
];

const List<List<String>> triviaBackupAnswers = [
  ["AUB", "USJ", "UL", "LAU"],
  ["U", "T", "V", "W"],
  [
    "PISA (Programme for International Student Assessment)",
    "TIMSS",
    "SAT Junior",
    "GPI (Global Performance Index)",
  ],
  ["Beirut", "Tyre", "Tripoli", "Baalbek"],
];

const List<String> backupQuestions = [
  "Which fruit is red?",
  "How many wheels does a bicycle have?",
  "What is the first month of the year?",
  "Which animal is known as man's best friend?",
  "Which day comes after Monday?",
  "Which device do you use to listen to music?",
  "Which planet is closest to the Sun?",
  "What color are bananas usually when ripe?",
];

const List<List<String>> backupAnswers = [
  ["Apple", "Banana", "Orange", "Grapes"],
  ["2", "3", "4", "1"],
  ["January", "February", "March", "December"],
  ["Dog", "Cat", "Bird", "Fish"],
  ["Tuesday", "Wednesday", "Sunday", "Friday"],
  ["Headphones", "Keyboard", "Mouse", "Printer"],
  ["Mercury", "Venus", "Earth", "Mars"],
  ["Yellow", "Green", "Red", "Blue"],
];

const List<String> triviaDemoQuestions = ["What is one plus one?"];

const List<List<String>> triviaDemoAnswers = [
  ["2", "3", "1", "IDK, I'll ask ChatGPT"],
];

const List<String> DemoQuestions = [
  "What is 2 + 2?",
  "Which device do we use to type on a computer?",
  "What is the capital of Lebanon?",
  "Which of these is a programming language?",
  "Who manages a company?",
  "Which animal says 'meow'?",
  "Which season comes after summer?",
  "What color are strawberries?",
];

const List<List<String>> DemoAnswers = [
  ["4", "3", "5", "2"],
  ["Keyboard", "Mouse", "Monitor", "Printer"],
  ["Beirut", "Tripoli", "Sidon", "Byblos"],
  ["Python", "Excel", "Windows", "Google"],
  ["Manager", "Teacher", "Student", "Driver"],
  ["Cat", "Dog", "Bird", "Cow"],
  ["Autumn", "Spring", "Winter", "Summer"],
  ["Red", "Yellow", "Green", "Blue"],
];

const List<String> generalQuestions = [
  "What is the capital of Lebanon?",
  "How many days are in a week?",
  "Which device is used to make phone calls?",
  "Which planet do humans live on?",
  "What color is the sky on a clear day?",
  "Which animal barks?",
  "What do we use to write on paper?",
  "Which season comes after winter?",
];

const List<List<String>> generalAnswers = [
  ["Beirut", "Tripoli", "Sidon", "Byblos"],
  ["7", "5", "10", "30"],
  ["Phone", "Television", "Printer", "Router"],
  ["Earth", "Mars", "Venus", "Jupiter"],
  ["Blue", "Green", "Red", "Yellow"],
  ["Dog", "Cat", "Bird", "Fish"],
  ["Pen", "Keyboard", "Monitor", "Phone"],
  ["Spring", "Summer", "Autumn", "Winter"],
];

const List<String> csQuestions = [
  "What do computer science students study?",
  "Which of these is a programming language?",
  "What does a computer use to store data?",
  "Which job is related to computer science?",
  "What device is used to input data into a computer?",
  "Which of these is a type of software?",
  "What does HTML stand for?",
  "Which device shows the output of a computer?",
];

const List<List<String>> csAnswers = [
  ["Computers and software", "Only math", "Typing", "Drawing"],
  ["Python", "Excel", "Windows", "Google"],
  ["Memory", "Mouse", "Keyboard", "Screen"],
  ["Software developer", "Doctor", "Teacher", "Chef"],
  ["Keyboard", "Printer", "Router", "Speaker"],
  ["Application", "Table", "Desk", "Folder"],
  [
    "HyperText Markup Language",
    "HighTech Machine Language",
    "Home Tool Main Link",
    "Hyper Training Math Logic",
  ],
  ["Monitor", "Keyboard", "Mouse", "Printer"],
];

const List<String> businessQuestions = [
  "What is business mainly about?",
  "Who manages a company?",
  "What do companies aim to make?",
  "Which major focuses on managing organizations?",
  "What is profit?",
  "Which of these is a business activity?",
  "What does CEO stand for?",
  "What is the purpose of marketing?",
];

const List<List<String>> businessAnswers = [
  [
    "Buying and selling goods or services",
    "Studying biology",
    "Playing games",
    "Traveling",
  ],
  ["Manager", "Customer", "Student", "Driver"],
  ["Profit", "Homework", "Loss", "Penalties"],
  ["Business management", "Physics", "History", "Biology"],
  ["Money earned after expenses", "Homework", "Expenses", "Debt"],
  ["Selling products", "Sleeping", "Watching movies", "Reading novels"],
  [
    "Chief Executive Officer",
    "Central Efficiency Operator",
    "Corporate Education Organizer",
    "Chief Enterprise Organizer",
  ],
  [
    "To promote products and reach customers",
    "To study math",
    "To write reports",
    "To cook food",
  ],
];
