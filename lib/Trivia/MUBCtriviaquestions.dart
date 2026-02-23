/// Question data structure
class Question {
  final String text;
  final List<String> options; // [A, B, C, D]
  final String correctAnswer; // "A", "B", "C", or "D"

  Question({
    required this.text,
    required this.options,
    required this.correctAnswer,
  });
}

/// Category enum for trivia questions
enum CategoryType {
  businessBasics,
  generalKnowledge,
  history,
  marketingBranding,
  politics,
  geography,
  lebaneseBusiness,
  lebaneseGeneral,
  lebaneseHistory,
  lebanesePoltics,
  lebaneseGeography,
  lebaneseculture,
  tiebreaker,
}

/// Extension for category display names
extension CategoryTypeName on CategoryType {
  String get displayName {
    switch (this) {
      case CategoryType.businessBasics:
        return "Business Basics";
      case CategoryType.generalKnowledge:
        return "General Knowledge";
      case CategoryType.history:
        return "History";
      case CategoryType.marketingBranding:
        return "Marketing & Branding";
      case CategoryType.politics:
        return "Politics";
      case CategoryType.geography:
        return "Geography";
      case CategoryType.lebaneseBusiness:
        return "Lebanese Business & Economy";
      case CategoryType.lebaneseGeneral:
        return "Lebanese General Knowledge";
      case CategoryType.lebaneseHistory:
        return "Lebanese History";
      case CategoryType.lebanesePoltics:
        return "Lebanese Politics";
      case CategoryType.lebaneseGeography:
        return "Lebanese Geography";
      case CategoryType.lebaneseculture:
        return "Lebanese Culture & Sports";
      case CategoryType.tiebreaker:
        return "Tiebreaker";
    }
  }
}

/// Round 1 & 2 categories (same 6 categories)
const Set<CategoryType> round1And2Categories = {
  CategoryType.businessBasics,
  CategoryType.generalKnowledge,
  CategoryType.history,
  CategoryType.marketingBranding,
  CategoryType.politics,
  CategoryType.geography,
};

/// Final round categories (Lebanese-focused)
const Set<CategoryType> finalCategories = {
  CategoryType.lebaneseBusiness,
  CategoryType.lebaneseGeneral,
  CategoryType.lebaneseHistory,
  CategoryType.lebanesePoltics,
  CategoryType.lebaneseGeography,
  CategoryType.lebaneseculture,
};

/// Complete trivia questions map organized by category
final Map<CategoryType, List<Question>> mubcTriviaQuestions = {
  // ============ ROUND 1 & 2: BUSINESS BASICS ============
  CategoryType.businessBasics: [
    Question(
      text: "Which business has only one owner?",
      options: [
        "Corporation",
        "Partnership",
        "Sole proprietorship",
        "Cooperative",
      ],
      correctAnswer: "C",
    ),
    Question(
      text: "A for-profit business mainly wants to:",
      options: [
        "Help charities",
        "Make profit",
        "Avoid competition",
        "Reduce workers",
      ],
      correctAnswer: "B",
    ),
    Question(
      text: "Which report shows income and expenses?",
      options: ["Balance Sheet", "Income Statement", "Cash Plan", "Asset List"],
      correctAnswer: "B",
    ),
    Question(
      text: "ROI is used to measure:",
      options: [
        "Worker effort",
        "Investment return",
        "Market size",
        "Brand power",
      ],
      correctAnswer: "B",
    ),
    Question(
      text: "Which cost stays the same each month?",
      options: [
        "Raw materials",
        "Sales commission",
        "Office rent",
        "Shipping cost",
      ],
      correctAnswer: "C",
    ),
    Question(
      text: "B2B means:",
      options: [
        "Business to Buyer",
        "Business to Business",
        "Brand to Buyer",
        "Budget to Business",
      ],
      correctAnswer: "B",
    ),
    Question(
      text: "An entrepreneur:",
      options: [
        "Works for government",
        "Starts and runs a business",
        "Only invests money",
        "Manages banks",
      ],
      correctAnswer: "B",
    ),
    Question(
      text: "Cash flow refers to:",
      options: [
        "Profit",
        "Money moving in and out",
        "Total sales",
        "Asset value",
      ],
      correctAnswer: "B",
    ),
    Question(
      text: "SWOT looks at:",
      options: [
        "Costs only",
        "Strengths and weaknesses",
        "Sales only",
        "Staff only",
      ],
      correctAnswer: "B",
    ),
    Question(
      text: "Liquidity means:",
      options: [
        "Debt level",
        "Ability to pay short-term bills",
        "Market size",
        "Revenue growth",
      ],
      correctAnswer: "B",
    ),
  ],

  // ============ ROUND 1 & 2: GENERAL KNOWLEDGE ============
  CategoryType.generalKnowledge: [
    Question(
      text: "Which planet is called the Red Planet?",
      options: ["Venus", "Mars", "Jupiter", "Saturn"],
      correctAnswer: "B",
    ),
    Question(
      text: "How many continents are there?",
      options: ["Five", "Six", "Seven", "Eight"],
      correctAnswer: "C",
    ),
    Question(
      text: "Which country hosted the 2022 World Cup?",
      options: ["Qatar", "UAE", "Russia", "Brazil"],
      correctAnswer: "A",
    ),
    Question(
      text: "Which language has the most native speakers?",
      options: ["English", "Spanish", "Mandarin Chinese", "French"],
      correctAnswer: "C",
    ),
    Question(
      text: "What is the capital of Australia?",
      options: ["Sydney", "Melbourne", "Canberra", "Perth"],
      correctAnswer: "C",
    ),
    Question(
      text: "Australia is both a:",
      options: [
        "Country and island",
        "Continent and country",
        "City and state",
        "Region and country",
      ],
      correctAnswer: "B",
    ),
    Question(
      text: "Adult humans have how many bones?",
      options: ["196", "206", "216", "226"],
      correctAnswer: "B",
    ),
    Question(
      text: "Chemical symbol 'Au' is:",
      options: ["Silver", "Aluminum", "Gold", "Copper"],
      correctAnswer: "C",
    ),
    Question(
      text: "Smallest country in the world:",
      options: ["Monaco", "Vatican City", "San Marino", "Liechtenstein"],
      correctAnswer: "B",
    ),
    Question(
      text: "Organ that produces insulin:",
      options: ["Liver", "Kidney", "Pancreas", "Heart"],
      correctAnswer: "C",
    ),
  ],

  // ============ ROUND 1 & 2: HISTORY ============
  CategoryType.history: [
    Question(
      text: "World War II ended in:",
      options: ["1939", "1942", "1945", "1950"],
      correctAnswer: "C",
    ),
    Question(
      text: "Who was the first US president?",
      options: ["Lincoln", "Washington", "Jefferson", "Adams"],
      correctAnswer: "B",
    ),
    Question(
      text: "Which Asian country was never colonized?",
      options: ["China", "Japan", "Thailand", "Vietnam"],
      correctAnswer: "C",
    ),
    Question(
      text: "Who taught Alexander the Great?",
      options: ["Plato", "Socrates", "Aristotle", "Homer"],
      correctAnswer: "C",
    ),
    Question(
      text: "Which Lebanese city was famous for purple dye?",
      options: ["Byblos", "Tyre", "Sidon", "Tripoli"],
      correctAnswer: "B",
    ),
    Question(
      text: "Hitler died by:",
      options: ["Execution", "Poison", "Suicide", "Shooting"],
      correctAnswer: "C",
    ),
    Question(
      text: "Berlin Wall fell in:",
      options: ["1985", "1987", "1989", "1991"],
      correctAnswer: "C",
    ),
    Question(
      text: "Who invented the telephone?",
      options: ["Edison", "Tesla", "Bell", "Franklin"],
      correctAnswer: "C",
    ),
    Question(
      text: "'Empire where sun never sets' was:",
      options: ["Roman", "Ottoman", "Mongol", "British"],
      correctAnswer: "D",
    ),
    Question(
      text: "WWI started after assassination in:",
      options: ["Vienna", "Berlin", "Sarajevo", "Prague"],
      correctAnswer: "C",
    ),
  ],

  // ============ ROUND 1 & 2: MARKETING & BRANDING ============
  CategoryType.marketingBranding: [
    Question(
      text: "'Just Do It' belongs to:",
      options: ["Adidas", "Nike", "Puma", "Reebok"],
      correctAnswer: "B",
    ),
    Question(
      text: "What is a brand mascot?",
      options: ["A logo", "A slogan", "A character for the brand", "A product"],
      correctAnswer: "C",
    ),
    Question(
      text: "What does marketing mainly aim to do?",
      options: ["Cut costs", "Attract customers", "Hire staff", "Manage money"],
      correctAnswer: "B",
    ),
    Question(
      text: "Guerrilla marketing is:",
      options: [
        "TV ads",
        "Online ads",
        "Low-cost creative marketing",
        "Email marketing",
      ],
      correctAnswer: "C",
    ),
    Question(
      text: "Brand equity means:",
      options: [
        "Stock value",
        "Extra value of a brand",
        "Ad budget",
        "Company profit",
      ],
      correctAnswer: "B",
    ),
    Question(
      text: "PR stands for:",
      options: [
        "Product Release",
        "Public Relations",
        "Profit Return",
        "Personal Reach",
      ],
      correctAnswer: "B",
    ),
    Question(
      text: "Color linked with trust:",
      options: ["Red", "Yellow", "Blue", "Green"],
      correctAnswer: "C",
    ),
    Question(
      text: "SEO means:",
      options: [
        "Search Engine Optimization",
        "Social Energy Online",
        "Sales Output",
        "Site Entry Order",
      ],
      correctAnswer: "A",
    ),
    Question(
      text: "USP means:",
      options: [
        "Unique Selling Point",
        "Universal Sales Plan",
        "User Service Program",
        "Unified Sales Process",
      ],
      correctAnswer: "A",
    ),
    Question(
      text: "4 Ps of marketing are:",
      options: [
        "Product, Price, Place, Promotion",
        "People, Plan, Price, Product",
        "Process, Profit, People, Plan",
        "Product, Profit, Place, People",
      ],
      correctAnswer: "A",
    ),
  ],

  // ============ ROUND 1 & 2: POLITICS ============
  CategoryType.politics: [
    Question(
      text: "The Lebanese Civil War lasted:",
      options: ["10 years", "15 years", "20 years", "30 years"],
      correctAnswer: "B",
    ),
    Question(
      text: "Which group keeps world peace?",
      options: ["NATO", "UN", "FIFA", "OPEC"],
      correctAnswer: "B",
    ),
    Question(
      text: "Where is the UN headquarters?",
      options: ["Paris", "Geneva", "New York", "London"],
      correctAnswer: "C",
    ),
    Question(
      text: "NATO stands for:",
      options: [
        "North Atlantic Treaty Organization",
        "National Army Treaty Office",
        "New Allied Trade Org",
        "Northern Alliance Team Org",
      ],
      correctAnswer: "A",
    ),
    Question(
      text: "Gerrymandering means:",
      options: [
        "Voting fraud",
        "Changing voting areas for advantage",
        "Buying votes",
        "Online voting",
      ],
      correctAnswer: "B",
    ),
    Question(
      text: "UN Security Council deals with:",
      options: ["Trade", "Peace and security", "Elections", "Money"],
      correctAnswer: "B",
    ),
    Question(
      text: "Permanent members of UN council:",
      options: ["3", "4", "5", "6"],
      correctAnswer: "C",
    ),
    Question(
      text: "Veto means:",
      options: ["Support", "Rejection", "Vote", "Election"],
      correctAnswer: "B",
    ),
    Question(
      text: "Ideology with small government role:",
      options: ["Socialism", "Communism", "Liberalism", "Fascism"],
      correctAnswer: "C",
    ),
    Question(
      text: "Agreement ending Lebanese Civil War:",
      options: ["Camp David", "Oslo", "Taif Agreement", "Dayton"],
      correctAnswer: "C",
    ),
  ],

  // ============ ROUND 1 & 2: GEOGRAPHY ============
  CategoryType.geography: [
    Question(
      text: "Largest ocean is:",
      options: ["Atlantic", "Indian", "Pacific", "Arctic"],
      correctAnswer: "C",
    ),
    Question(
      text: "Largest country by area:",
      options: ["USA", "China", "Canada", "Russia"],
      correctAnswer: "D",
    ),
    Question(
      text: "Capital of Brazil:",
      options: ["Rio", "São Paulo", "Brasília", "Salvador"],
      correctAnswer: "C",
    ),
    Question(
      text: "Largest desert in the world:",
      options: ["Sahara", "Gobi", "Arabian", "Antarctic"],
      correctAnswer: "D",
    ),
    Question(
      text: "Strait between Europe and Africa:",
      options: ["Bosphorus", "Hormuz", "Gibraltar", "Bering"],
      correctAnswer: "C",
    ),
    Question(
      text: "Capital of Japan:",
      options: ["Osaka", "Kyoto", "Tokyo", "Hiroshima"],
      correctAnswer: "C",
    ),
    Question(
      text: "Capital of France:",
      options: ["Lyon", "Nice", "Paris", "Marseille"],
      correctAnswer: "C",
    ),
    Question(
      text: "Sahara Desert is in:",
      options: ["Asia", "Africa", "Australia", "Europe"],
      correctAnswer: "B",
    ),
    Question(
      text: "Country with most lakes:",
      options: ["USA", "Russia", "Canada", "Finland"],
      correctAnswer: "C",
    ),
    Question(
      text: "Deepest lake in the world:",
      options: ["Superior", "Titicaca", "Caspian", "Baikal"],
      correctAnswer: "D",
    ),
  ],

  // ============ FINAL ROUND: LEBANESE BUSINESS & ECONOMY ============
  CategoryType.lebaneseBusiness: [
    Question(
      text: "Lebanon's official currency is:",
      options: ["Dinar", "Pound", "Dirham", "Lira"],
      correctAnswer: "B",
    ),
    Question(
      text: "Beirut was known as a financial center of the:",
      options: ["Gulf", "Middle East", "Africa", "Europe"],
      correctAnswer: "B",
    ),
    Question(
      text: "Money sent from abroad is called:",
      options: ["Aid", "Remittances", "Exports", "Savings"],
      correctAnswer: "B",
    ),
    Question(
      text: "Large Lebanese investment group:",
      options: ["M1 Group", "Azadea", "Hariri Group", "CMA CGM"],
      correctAnswer: "A",
    ),
    Question(
      text: "Lebanon depends a lot on:",
      options: [
        "Oil",
        "Local factories",
        "Expatriates abroad",
        "Heavy industry",
      ],
      correctAnswer: "C",
    ),
  ],

  // ============ FINAL ROUND: LEBANESE GENERAL KNOWLEDGE ============
  CategoryType.lebaneseGeneral: [
    Question(
      text: "Official language of Lebanon:",
      options: [
        "Arabic",
        "French",
        "Arabic and French",
        "Arabic, French, English",
      ],
      correctAnswer: "C",
    ),
    Question(
      text: "National airline of Lebanon:",
      options: ["Cedar Air", "MEA", "Fly Beirut", "Arab Wings"],
      correctAnswer: "B",
    ),
    Question(
      text: "Famous Lebanese designer:",
      options: ["Reem Acra", "Elie Saab", "Zuhair Murad", "All of the above"],
      correctAnswer: "D",
    ),
    Question(
      text: "Author of 'The Prophet':",
      options: [
        "Amin Maalouf",
        "Kahlil Gibran",
        "Naguib Mahfouz",
        "Elias Khoury",
      ],
      correctAnswer: "B",
    ),
    Question(
      text: "Independence Day is:",
      options: ["Nov 22", "Aug 4", "Oct 17", "July 1"],
      correctAnswer: "A",
    ),
  ],

  // ============ FINAL ROUND: LEBANESE HISTORY ============
  CategoryType.lebaneseHistory: [
    Question(
      text: "Lebanon became independent in:",
      options: ["1920", "1932", "1943", "1948"],
      correctAnswer: "C",
    ),
    Question(
      text: "Ancient traders of Lebanon:",
      options: ["Romans", "Persians", "Phoenicians", "Byzantines"],
      correctAnswer: "C",
    ),
    Question(
      text: "Mandate power after WWI:",
      options: ["Britain", "France", "Italy", "Ottomans"],
      correctAnswer: "B",
    ),
    Question(
      text: "Civil War began in:",
      options: ["1970", "1973", "1975", "1978"],
      correctAnswer: "C",
    ),
    Question(
      text: "Beirut port explosion date:",
      options: ["Aug 4, 2020", "Oct 17, 2019", "July 12, 2006", "Mar 15, 2021"],
      correctAnswer: "A",
    ),
  ],

  // ============ FINAL ROUND: LEBANESE POLITICS ============
  CategoryType.lebanesePoltics: [
    Question(
      text: "Parliament members number:",
      options: ["99", "108", "128", "150"],
      correctAnswer: "C",
    ),
    Question(
      text: "Prime Minister religion:",
      options: ["Maronite", "Sunni", "Shia", "Druze"],
      correctAnswer: "B",
    ),
    Question(
      text: "Parliament name:",
      options: [
        "Senate",
        "Chamber of Deputies",
        "Council of Ministers",
        "National Assembly",
      ],
      correctAnswer: "B",
    ),
    Question(
      text: "Governorates count:",
      options: ["4", "6", "8", "10"],
      correctAnswer: "C",
    ),
    Question(
      text: "Speaker of Parliament is:",
      options: ["Maronite", "Sunni", "Shia", "Druze"],
      correctAnswer: "C",
    ),
  ],

  // ============ FINAL ROUND: LEBANESE GEOGRAPHY ============
  CategoryType.lebaneseGeography: [
    Question(
      text: "Border country north/east:",
      options: ["Jordan", "Israel", "Syria", "Palestine"],
      correctAnswer: "C",
    ),
    Question(
      text: "Largest river:",
      options: ["Orontes", "Litani", "Jordan", "Nahr el Kalb"],
      correctAnswer: "B",
    ),
    Question(
      text: "'Bride of the North':",
      options: ["Zahle", "Jounieh", "Tripoli", "Baalbek"],
      correctAnswer: "C",
    ),
    Question(
      text: "Highest peak:",
      options: ["Hermon", "Qornet el Sawda", "Sannine", "Barouk"],
      correctAnswer: "B",
    ),
    Question(
      text: "Fertile valley:",
      options: [
        "Jordan Valley",
        "Orontes Valley",
        "Bekaa Valley",
        "Nahr Valley",
      ],
      correctAnswer: "C",
    ),
  ],

  // ============ FINAL ROUND: LEBANESE CULTURE & SPORTS ============
  CategoryType.lebaneseculture: [
    Question(
      text: "Most popular sport:",
      options: ["Basketball", "Football", "Tennis", "Volleyball"],
      correctAnswer: "B",
    ),
    Question(
      text: "Famous singer who rarely performed abroad:",
      options: ["Fairuz", "Sabah", "Wadih El Safi", "Nasri Shamseddine"],
      correctAnswer: "A",
    ),
    Question(
      text: "City with Roman ruins:",
      options: ["Tyre", "Byblos", "Baalbek", "Anjar"],
      correctAnswer: "C",
    ),
    Question(
      text: "First Olympic medal sport:",
      options: ["Wrestling", "Weightlifting", "Shooting", "Taekwondo"],
      correctAnswer: "A",
    ),
    Question(
      text: "Oldest private university:",
      options: ["LAU", "LU", "AUB", "USJ"],
      correctAnswer: "C",
    ),
  ],

  // ============ TIEBREAKER: VERY HARD ============
  CategoryType.tiebreaker: [
    Question(
      text: "Which number shows income difference in a country?",
      options: ["GDP", "Gini Index", "Inflation", "Interest rate"],
      correctAnswer: "B",
    ),
    Question(
      text: "When no player wants to change alone, it is called:",
      options: ["Free market", "Nash Equilibrium", "Monopoly", "Trade balance"],
      correctAnswer: "B",
    ),
    Question(
      text: "Global accounting rules are called:",
      options: ["GAAP", "IFRS", "ISO", "WTO"],
      correctAnswer: "B",
    ),
    Question(
      text:
          "When a country's money is used worldwide but hurts its own economy:",
      options: ["Inflation trap", "Triffin Dilemma", "Budget gap", "Trade war"],
      correctAnswer: "B",
    ),
  ],
};
