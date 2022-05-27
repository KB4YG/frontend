/// Replaces all spaces and %20 characters with dashes (-) and converts to lower case.
String sanitizeUrl(String str) =>
    str.replaceAll('%20', '-').replaceAll(' ', '-').toLowerCase();
