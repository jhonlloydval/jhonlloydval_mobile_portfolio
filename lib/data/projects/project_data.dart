import 'package:flutter/material.dart';
import 'package:lloydportfolio/data/projects/project_model.dart';

const projects = <ProjectItem>[
  ProjectItem(
    title: 'Hakbang',
    subtitle: 'College Journey Companion · Flutter + Node.js',
    details:
        'A full-stack mobile platform built for Filipino senior high students — aggregating college discovery, scholarship matching, an AI college counselor (Gabay), and review center resources into one app. Backed by a live Node.js API and a dedicated AI service, both deployed on Render.',
    tags: [
      'Flutter',
      'Dart',
      'Node.js',
      'REST API',
      'AI',
      'OpenStreetMap',
      '2025',
    ],
    status: 'Live',
    icon: Icons.school_outlined,
    imagePaths: [
      'assets/images/hakbang/HAKBANG-1.png',
      'assets/images/hakbang/HAKBANG-2.png',
      'assets/images/hakbang/HAKBANG-3.png',
      'assets/images/hakbang/HAKBANG-4.png',
      'assets/images/hakbang/HAKBANG-5.png',
      'assets/images/hakbang/HAKBANG-6.png',
      'assets/images/hakbang/HAKBANG-7.png',
      'assets/images/hakbang/HAKBANG-8.png',
      'assets/images/hakbang/HAKBANG-9.png',
      'assets/images/hakbang/HAKBANG-10.png',
      'assets/images/hakbang/HAKBANG-11.png',
      'assets/images/hakbang/HAKBANG-12.png',
      'assets/images/hakbang/HAKBANG-13.png',
      'assets/images/hakbang/HAKBANG-14.png',
      'assets/images/hakbang/HAKBANG-15.png',
      'assets/images/hakbang/HAKBANG-16.png',
      'assets/images/hakbang/HAKBANG-17.png',
      'assets/images/hakbang/HAKBANG-18.png',
      'assets/images/hakbang/HAKBANG-19.png',
      'assets/images/hakbang/HAKBANG-20.png',
      'assets/images/hakbang/HAKBANG-21.png',
      'assets/images/hakbang/HAKBANG-22.png',
      'assets/images/hakbang/HAKBANG-23.png',
      'assets/images/hakbang/HAKBANG-24.png',
      'assets/images/hakbang/HAKBANG-25.png',
      'assets/images/hakbang/HAKBANG-26.png',
      'assets/images/hakbang/HAKBANG-27.png',
      'assets/images/hakbang/HAKBANG-28.png',
      'assets/images/hakbang/HAKBANG-29.png',
    ],
    longDescription: [
      FeatureItem(
        'College Discovery',
        'Searchable, map-enabled directory of PH colleges and universities with program info, ratings, and geolocation via OpenStreetMap.',
      ),
      FeatureItem(
        'Scholarship Hub',
        'Curated database of government and non-government scholarships — eligibility, deadlines, allowances, and direct application links.',
      ),
      FeatureItem(
        'Gabay AI Assistant',
        'Conversational AI that answers questions about admissions, entrance exams, scholarships, and career paths with markdown-rendered responses.',
      ),
      FeatureItem(
        'Review Center Hub',
        'Directory of entrance exam review centers filterable by modality: on-site, online, and hybrid.',
      ),
      FeatureItem(
        'User Profile & Activity',
        'Saved schools, saved scholarships, editable bio, and a chronological activity log.',
      ),
    ],
    whyItMatters: [
      'Millions of Filipino students navigate college planning with no structured guidance.',
      'Scholarship opportunities go unclaimed because students can\'t find them.',
      'School counselors are overwhelmed — Hakbang fills the gap with an always-available AI assistant.',
      'Bridges the access divide between Metro Manila and provincial students.',
    ],
    sdgs: [
      SdgItem(
        'SDG 4',
        'Quality Education',
        'Improves access to college guidance, admissions information, and preparedness resources for senior high students.',
      ),
      SdgItem(
        'SDG 10',
        'Reduced Inequalities',
        'Bridges the information and opportunity gap between students in Metro Manila and provincial areas.',
      ),
      SdgItem(
        'SDG 8',
        'Decent Work & Economic Growth',
        'Expands pathways to higher education and scholarships, helping learners build stronger career opportunities.',
      ),
      SdgItem(
        'SDG 9',
        'Industry, Innovation & Infrastructure',
        'Uses AI and digital services to deliver scalable, always-available educational support infrastructure.',
      ),
    ],
  ),
  ProjectItem(
    title: 'RapidRail',
    subtitle: 'Modernized NSCR Transaction Processing System · Java + MySQL',
    details:
        'A modernized transaction processing system prototype for the North-South Commuter Railway (NSCR), focused on faster digital booking, real-time seat visibility, transparent pricing, and contactless kiosk verification to reduce queue times and commuter friction.',
    tags: ['Java', 'MySQL', 'Desktop/Web', 'OOP', 'TPS', '2025'],
    status: 'Completed',
    icon: Icons.train_rounded,
    imagePaths: [
      'assets/images/rapidrail/RapidRail-1.png',
      'assets/images/rapidrail/RapidRail-2.png',
      'assets/images/rapidrail/RapidRail-3.png',
      'assets/images/rapidrail/RapidRail-4.png',
      'assets/images/rapidrail/RapidRail-5.png',
      'assets/images/rapidrail/RapidRail-6.png',
      'assets/images/rapidrail/RapidRail-7.png',
      'assets/images/rapidrail/RapidRail-8.png',
      'assets/images/rapidrail/RapidRail-9.png',
      'assets/images/rapidrail/RapidRail-10.png',
      'assets/images/rapidrail/RapidRail-11.png',
      'assets/images/rapidrail/RapidRail-12.png',
      'assets/images/rapidrail/RapidRail-13.png',
      'assets/images/rapidrail/RapidRail-14.png',
      'assets/images/rapidrail/RapidRail-15.png',
      'assets/images/rapidrail/RapidRail-16.png',
      'assets/images/rapidrail/RapidRail-17.png',
      'assets/images/rapidrail/RapidRail-18.png',
      'assets/images/rapidrail/RapidRail-19.png',
      'assets/images/rapidrail/RapidRail-20.png',
      'assets/images/rapidrail/RapidRail-21.png',
      'assets/images/rapidrail/RapidRail-22.png',
      'assets/images/rapidrail/RapidRail-23.png',
      'assets/images/rapidrail/RapidRail-24.png',
    ],
    longDescription: [
      FeatureItem(
        'User Account System',
        'Passenger registration and secure login with profile data stored in the railway.sql database.',
      ),
      FeatureItem(
        'Train Type Selection & Booking',
        'Supports commuter and express flows with route direction logic and fixed-stop options.',
      ),
      FeatureItem(
        'Real-Time Transaction Menu',
        'Shows schedule, stations, seat availability, add-ons, and final fare details before checkout.',
      ),
      FeatureItem(
        'Pricing, Discounts & Payments',
        'Transparent fare display with Student/Senior/PWD discounts and support for major e-wallets and banks.',
      ),
      FeatureItem(
        'Receipt & Transaction History',
        'Full traceability through transaction IDs, booking details, and historical booking records.',
      ),
      FeatureItem(
        'RapidRail Kiosk Verification',
        'Contactless ticket validation using transaction IDs to speed up boarding and reduce queues.',
      ),
    ],
    whyItMatters: [
      'Metro Manila traffic congestion causes major time, emissions, and productivity losses for daily commuters.',
      'Outdated manual ticketing workflows create avoidable rail station bottlenecks and longer queues.',
      'RapidRail modernizes commuter transactions to help scale NSCR operations toward high passenger demand.',
      'Better transit flow supports cleaner mobility, stronger economic productivity, and a better commuter experience.',
    ],
    sdgs: [
      SdgItem(
        'SDG 8',
        'Decent Work & Economic Growth',
        'Reduces time lost in commuting and supports productivity through more efficient urban transport transactions.',
      ),
      SdgItem(
        'SDG 9',
        'Industry, Innovation & Infrastructure',
        'Modernizes rail transaction infrastructure through digital booking, seat tracking, and verification workflows.',
      ),
      SdgItem(
        'SDG 11',
        'Sustainable Cities & Communities',
        'Encourages mass transit adoption and smoother rail operations for more sustainable city mobility.',
      ),
    ],
  ),
  ProjectItem(
    title: 'ABTCares',
    subtitle: 'Animal Bite Treatment & Care Management System · Python',
    details:
        'A Python console application that digitizes patient record-keeping for Animal Bite Treatment Centers (ABTCs). Built with OOP principles, it enables healthcare workers to log, update, search, and track patient treatment progress — reducing manual errors and improving follow-up care.',
    tags: ['Python', 'OOP', 'CSV', 'Console', '2024'],
    status: 'Completed',
    icon: Icons.medical_services_outlined,
    imagePaths: ['assets/images/ABTCares/ABTCares-1.jpg'],
    longDescription: [
      FeatureItem(
        'Add Record',
        'Append new patient cases with complete incident and treatment details directly into the system.',
      ),
      FeatureItem(
        'Read Record',
        'View all stored patient records from the database in a structured, readable format.',
      ),
      FeatureItem(
        'Edit Record',
        'Modify existing patient details, including treatment progress and vaccination status.',
      ),
      FeatureItem(
        'Delete Record',
        'Remove outdated or incorrect records with a confirmation step to prevent accidental deletion.',
      ),
      FeatureItem(
        'Search Record',
        'Locate patient cases using two methods: search by any field value, or filter by a specific field such as Patient ID, name, age, or animal type.',
      ),
    ],
    whyItMatters: [
      'Most ABTCs still rely on manual logbooks — ABTCares replaces that with a fast, searchable digital system.',
      'Reduces documentation time so healthcare workers can focus more on patient care.',
      'Minimizes human errors like misspelled names, incorrect dates, and misplaced data in treatment records.',
      'Ensures patients don\'t miss critical follow-up vaccine doses through better record tracking.',
      'Inspired by real firsthand experience during a Grade 12 work immersion at a City Health Office ABTC.',
    ],
    sdgs: [
      SdgItem(
        'SDG 3',
        'Good Health & Well-being',
        'Ensures proper tracking and timely follow-up of animal bite cases to prevent infections and rabies fatalities.',
      ),
      SdgItem(
        'SDG 9',
        'Industry, Innovation & Infrastructure',
        'Utilizes digital tools and OOP-based software design to improve healthcare record management efficiency.',
      ),
      SdgItem(
        'SDG 11',
        'Sustainable Cities & Communities',
        'Supports public health initiatives by organizing case data for better medical response in local communities.',
      ),
    ],
  ),
  ProjectItem(
    title: 'EU-WALL',
    subtitle: 'Freedom Wall for MSEUF Students · PyQt6 + MySQL',
    details:
        'A PyQt6 and MySQL-powered digital Freedom Wall built exclusively for Manuel S. Enverga University Foundation (MSEUF) students. Lets users post messages, thoughts, or rants — anonymously or not — to foster emotional expression, openness, and campus connection.',
    tags: ['Python', 'PyQt6', 'MySQL', 'GUI', 'OOP', '2024'],
    status: 'Completed',
    icon: Icons.forum_outlined,
    imagePaths: [
      'assets/images/EUwall/EUwall-1.png',
      'assets/images/EUwall/EUwall-2.png',
      'assets/images/EUwall/EUwall-3.png',
      'assets/images/EUwall/EUwall-4.png',
      'assets/images/EUwall/EUwall-5.png',
      'assets/images/EUwall/EUwall-6.png',
      'assets/images/EUwall/EUwall-7.png',
    ],
    longDescription: [
      FeatureItem(
        'Register / Login',
        'Create an account or log in to access the freedom wall and manage your posts. Credentials are stored securely in MySQL.',
      ),
      FeatureItem(
        'Freedom Wall Feed',
        'View all public posts with timestamps and usernames (or anonymous labels) in a scrollable feed.',
      ),
      FeatureItem(
        'Create Post',
        'Write and share messages with a toggle to post anonymously while still retaining ownership for future edits or deletions.',
      ),
      FeatureItem(
        'Edit / Delete Post',
        'Manage your own posts through the My Posts section — hover and click to edit or remove any entry.',
      ),
      FeatureItem(
        'Search Functionality',
        'Filter the wall content by keywords or date of posting to quickly find specific messages.',
      ),
    ],
    whyItMatters: [
      'Students often lack a safe, judgment-free outlet for expressing academic stress and personal thoughts.',
      'Anonymous posting lowers the barrier for students who want to share but fear social repercussions.',
      'Builds campus community and empathy by letting students see shared experiences on a common wall.',
      'Applies real-world CRUD, GUI design, and database integration skills in a meaningful campus context.',
      'Promotes mental health awareness and responsible digital communication within an academic setting.',
    ],
    sdgs: [
      SdgItem(
        'SDG 3',
        'Good Health & Well-being',
        'Provides a safe, anonymous space for emotional expression, reducing stigma around mental health struggles.',
      ),
      SdgItem(
        'SDG 4',
        'Quality Education',
        'Gives every student a voice and fosters digital literacy through responsible online communication.',
      ),
      SdgItem(
        'SDG 9',
        'Industry, Innovation & Infrastructure',
        'Applies GUI development and database integration to address a real campus community need.',
      ),
      SdgItem(
        'SDG 16',
        'Peace, Justice & Strong Institutions',
        'Fosters a culture of peace and inclusivity through moderated yet open student communication.',
      ),
    ],
  ),
  ProjectItem(
    title: 'Web Portfolio',
    subtitle: 'Personal Portfolio Website · HTML + CSS + JavaScript',
    details:
        'A personal portfolio website built entirely from scratch with HTML, CSS, and JavaScript — featuring a responsive design, modern UI with gradients and hover styles, social links, and an embedded services section. Publicly deployed on GitHub Pages. Design format inspired by HowToWebDev.',
    tags: ['HTML', 'CSS', 'JavaScript', 'Responsive', '2024'],
    status: 'Completed',
    icon: Icons.web_outlined,
    imagePaths: [
      'assets/images/web_portfolio/web_portfolio-1.png',
      'assets/images/web_portfolio/web_portfolio-2.png',
      'assets/images/web_portfolio/web_portfolio-3.png',
      'assets/images/web_portfolio/web_portfolio-4.png',
    ],
    longDescription: [
      FeatureItem(
        'Responsive Design',
        'Adapts seamlessly to different screen sizes — optimized for both mobile and desktop.',
      ),
      FeatureItem(
        'Modern UI',
        'Smooth section navigation with gradient options, hover styles, and Poppins typography via Google Fonts.',
      ),
      FeatureItem(
        'Social Links',
        'Direct icon-based links to Facebook, Instagram, LinkedIn, and GitHub.',
      ),
      FeatureItem(
        'Services Section',
        'Embedded links to Blog, Projects, and Photography sites — each hosted on a dedicated Canva site.',
      ),
      FeatureItem(
        'Contact Form',
        'Allows visitors to send messages directly through the site.',
      ),
    ],
    whyItMatters: [
      'First complete web project built entirely from scratch — no templates or frameworks used.',
      'Demonstrates core front-end fundamentals: semantic HTML, CSS layout, and JavaScript interactivity.',
      'Publicly deployed on GitHub Pages at jhonlloydval.github.io, making it accessible to anyone.',
      'Consolidates personal brand, background, achievements, and services into a single site.',
      'Design format courtesy of HowToWebDev — fully reimplemented and personalized from the ground up.',
    ],
    sdgs: [
      SdgItem(
        'SDG 4',
        'Quality Education',
        'Demonstrates self-directed learning in web development and showcases academic and project achievements publicly.',
      ),
      SdgItem(
        'SDG 9',
        'Industry, Innovation & Infrastructure',
        'Applies web technologies to build and deploy a real digital presence, contributing to digital infrastructure skills.',
      ),
    ],
  ),
  ProjectItem(
    title: 'BarterBoard',
    subtitle: 'Reviving Barter, Reinventing Exchange · Python + MySQL',
    details:
        'A Python-MySQL console application inspired by traditional barter systems, promoting sustainability through the cashless exchange of goods and services. Built to close the gap between surplus and need in local communities.',
    tags: ['Python', 'MySQL', 'OOP', 'Console', '2024'],
    status: 'Completed',
    icon: Icons.swap_horiz,
    imagePaths: [
      'assets/images/barterboard/BarterBoard-1.png',
      'assets/images/barterboard/BarterBoard-2.png',
    ],
    longDescription: [
      FeatureItem(
        'Register / Login',
        'Create an account or log in to access personalized features and manage listings. Credentials are securely stored in MySQL.',
      ),
      FeatureItem(
        'BarterBoard',
        'Explore all available items for trade and propose your own items in exchange with a Bargain option.',
      ),
      FeatureItem(
        'Add & View Listings',
        'Post new items for trade and manage your own listings — edit or remove them as needed.',
      ),
      FeatureItem(
        'Listing Update',
        'Accept, reject, or skip trade proposals received from other users.',
      ),
      FeatureItem(
        'Transaction History',
        'View all completed exchanges to monitor contributions and build community trust.',
      ),
    ],
    whyItMatters: [
      'Online shopping has overshadowed local traditions — BarterBoard revives the spirit of barter in a digital format.',
      'Enables communities to exchange resources without financial barriers, promoting inclusivity.',
      'Encourages responsible consumption by giving surplus items a second life.',
      'Fosters local collaboration and builds resilient, self-sufficient communities.',
    ],
    sdgs: [
      SdgItem(
        'SDG 1',
        'No Poverty',
        'Enables users to trade goods and services without money, helping those in need and reducing financial barriers.',
      ),
      SdgItem(
        'SDG 2',
        'Zero Hunger',
        'Facilitates exchange of food and essentials, contributing to food security and combating hunger.',
      ),
      SdgItem(
        'SDG 8',
        'Decent Work & Economic Growth',
        'Stimulates economic participation by enabling non-monetary trade opportunities.',
      ),
      SdgItem(
        'SDG 11',
        'Sustainable Cities & Communities',
        'Promotes reuse and recycling of goods, fostering collaboration and resilient communities.',
      ),
      SdgItem(
        'SDG 12',
        'Responsible Consumption & Production',
        'Reduces waste by encouraging exchange of surplus items and promoting mindful resource use.',
      ),
    ],
  ),
];
