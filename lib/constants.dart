// General
const title = 'Know Before You Go';
const appVersion = '1.0'; // Used in showAboutDialog() on AboutScreen()
const bullet = '\u2022 ';
const oregonLat = 43.8041; // Oregon lat lng coordinates to center ParkingMap()
const oregonLng = -120.5542;

// Model links
const linkRecArea = 'recreationArea';
const linkCounty = 'county';

// Preferences
const prefCounty = 'selectedCounty';
const prefDark = 'isDark'; // Save selected theme
const prefIntro = 'isFirstRun'; // Mobile - store whether to show intro screen

// Navbar page names
const pageHome = 'Home';
const pageLocations = 'Locations';
const pageHelp = 'Help';
const pageAbout = 'About';

// Navigation
const routeRoot = '/';
const routeHome = '/home';
const routeUnknown = '/404';
const routeHelp = '/help';
const routeAbout = '/about';

const routeLocations = '/locations';
const routeCountyId = 'countyId';
const routeRecAreaId = 'recAreaId';
const routeCounty = '$routeLocations/:$routeCountyId';
const routeRecArea = '$routeCounty/:$routeRecAreaId';
