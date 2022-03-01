// General
const title = 'Know Before You Go';
const bullet = '\u2022 ';

// Preferences
const prefCounty = 'selectedCounty';
const prefDark = 'isDark';
const prefIntro = 'isFirstRun';

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
