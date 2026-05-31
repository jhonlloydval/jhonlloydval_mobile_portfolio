import 'package:lloydportfolio/data/profile/profile_model.dart';

const personalInfo = PersonalInfo(
  name: 'Jhon Lloyd Valencia',
  fullName: 'Jhon Lloyd Montalbo Valencia',
  title: 'CS Student · Full-Stack Developer',
  location: 'Lucena City, Philippines',
  availabilityStatus: 'Available',
  profileImagePath: 'assets/images/jhon_profile.jpg',
);

const positions = <PositionEntry>[
  PositionEntry(
    role: 'Deputy Secretary',
    org: "MSEUF DOST Scholars' Guild ('25-'26)",
    iconName: 'description',
  ),
  PositionEntry(
    role: 'President',
    org: "MSEUF DOST Scholars' Guild ('25-'26)",
    iconName: 'workspace_premium',
  ),
  PositionEntry(
    role: 'Member', 
    org: 'MASTECH', 
    iconName: 'people'),
  PositionEntry(
    role: 'Delegate',
    org: 'DOST-SEI SLC, Quezon Province',
    iconName: 'flight_takeoff',
  ),
  PositionEntry(
    role: 'Academic Team Member',
    org: 'CCMS, MSEUF',
    iconName: 'school',
  ),
  PositionEntry(
    role: 'Scholar',
    org: 'START DOST x Data Camp',
    iconName: 'addchart',
  ),
  PositionEntry(role: 'Member', org: 'iSITE', iconName: 'ad_units'),
];

const bioSections = <BioEntry>[
  BioEntry(
    title: 'WHO I AM',
    body:
        'I am Jhon Lloyd Montalbo Valencia, a Computer Science student and product-focused developer who enjoys turning ideas into usable, polished software.',
  ),
  BioEntry(
    title: 'WHAT I BUILD',
    body:
        'My strongest interests are in Flutter, frontend architecture, and building experiences that feel clean, fast, and intentional. I value thoughtful UI decisions and solid technical foundations equally. I am also learning Data Science while juggling work as a software engineer major.',
  ),
  BioEntry(
    title: 'HOW I WORK',
    body:
        'Through projects, coding competitions, hackathons, and collaborations, I have learned to design with users in mind, communicate effectively with teams, and develop features iteratively. I work with data, statistics, and analytical thinking to deduce meaningful insights and identify areas that require improvement, optimization, or strategic decision-making.',
  ),
  BioEntry(
    title: 'MY GOAL',
    body:
        'My long-term goal is to grow as a software engineer capable of crafting excellent user experiences while building reliable and scalable systems behind them. Alongside software engineering, I have a strong interest in artificial intelligence, machine learning, and data science, and I aspire to explore opportunities where I can contribute, learn deeply, and develop impactful, technology-driven solutions.',
  ),
];
