String sanitizeUrl(String str) =>
    str.replaceAll('%20', '-').replaceAll(' ', '-').toLowerCase();
