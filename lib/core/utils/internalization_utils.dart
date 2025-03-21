import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InternalizationUtils {
  static Map<String, Map<String, String>> countryDetails = {
    'US': {'name': 'United States', 'flag': '🇺🇸'},
    'GB': {'name': 'United Kingdom', 'flag': '🇬🇧'},
    'CA': {'name': 'Canada', 'flag': '🇨🇦'},
    'AU': {'name': 'Australia', 'flag': '🇦🇺'},
    'DE': {'name': 'Germany', 'flag': '🇩🇪'},
    'FR': {'name': 'France', 'flag': '🇫🇷'},
    'JP': {'name': 'Japan', 'flag': '🇯🇵'},
    'CN': {'name': 'China', 'flag': '🇨🇳'},
    'ET': {'name': 'Ethiopia', 'flag': '🇪🇹'},
    'IN': {'name': 'India', 'flag': '🇮🇳'},
    'BR': {'name': 'Brazil', 'flag': '🇧🇷'},
    'RU': {'name': 'Russia', 'flag': '🇷🇺'},
    'KR': {'name': 'South Korea', 'flag': '🇰🇷'},
    'IT': {'name': 'Italy', 'flag': '🇮🇹'},
    'ES': {'name': 'Spain', 'flag': '🇪🇸'},
    'MX': {'name': 'Mexico', 'flag': '🇲🇽'},
    'SA': {'name': 'Saudi Arabia', 'flag': '🇸🇦'},
    'NG': {'name': 'Nigeria', 'flag': '🇳🇬'},
    'ZA': {'name': 'South Africa', 'flag': '🇿🇦'},
    'ID': {'name': 'Indonesia', 'flag': '🇮🇩'},
    'TR': {'name': 'Turkey', 'flag': '🇹🇷'},
    'NL': {'name': 'Netherlands', 'flag': '🇳🇱'},
    'CH': {'name': 'Switzerland', 'flag': '🇨🇭'},
    'SE': {'name': 'Sweden', 'flag': '🇸🇪'},
    'BE': {'name': 'Belgium', 'flag': '🇧🇪'},
    'AR': {'name': 'Argentina', 'flag': '🇦🇷'},
    'AE': {'name': 'United Arab Emirates', 'flag': '🇦🇪'},
    'PL': {'name': 'Poland', 'flag': '🇵🇱'},
    'NO': {'name': 'Norway', 'flag': '🇳🇴'},
    'IR': {'name': 'Iran', 'flag': '🇮🇷'},
    'TH': {'name': 'Thailand', 'flag': '🇹🇭'},
    'EG': {'name': 'Egypt', 'flag': '🇪🇬'},
    'PK': {'name': 'Pakistan', 'flag': '🇵🇰'},
    'UA': {'name': 'Ukraine', 'flag': '🇺🇦'},
    'VN': {'name': 'Vietnam', 'flag': '🇻🇳'},
    'NZ': {'name': 'New Zealand', 'flag': '🇳🇿'},
    'SG': {'name': 'Singapore', 'flag': '🇸🇬'},
    'IE': {'name': 'Ireland', 'flag': '🇮🇪'},
    'DK': {'name': 'Denmark', 'flag': '🇩🇰'},
    'FI': {'name': 'Finland', 'flag': '🇫🇮'},
    'AT': {'name': 'Austria', 'flag': '🇦🇹'},
    'CL': {'name': 'Chile', 'flag': '🇨🇱'},
    'CO': {'name': 'Colombia', 'flag': '🇨🇴'},
    'GR': {'name': 'Greece', 'flag': '🇬🇷'},
    'PT': {'name': 'Portugal', 'flag': '🇵🇹'},
    'CZ': {'name': 'Czech Republic', 'flag': '🇨🇿'},
    'HU': {'name': 'Hungary', 'flag': '🇭🇺'},
    'RO': {'name': 'Romania', 'flag': '🇷🇴'},
    'IL': {'name': 'Israel', 'flag': '🇮🇱'},
    'MY': {'name': 'Malaysia', 'flag': '🇲🇾'},
    'KE': {'name': 'Kenya', 'flag': '🇰🇪'},
    'MA': {'name': 'Morocco', 'flag': '🇲🇦'},
    'PE': {'name': 'Peru', 'flag': '🇵🇪'},
    'GH': {'name': 'Ghana', 'flag': '🇬🇭'},
    'LU': {'name': 'Luxembourg', 'flag': '🇱🇺'},
    'IQ': {'name': 'Iraq', 'flag': '🇮🇶'},
    'AO': {'name': 'Angola', 'flag': '🇦🇴'},
    'UZ': {'name': 'Uzbekistan', 'flag': '🇺🇿'},
    'CR': {'name': 'Costa Rica', 'flag': '🇨🇷'},
    'DO': {'name': 'Dominican Republic', 'flag': '🇩🇴'},
    'PA': {'name': 'Panama', 'flag': '🇵🇦'},
    'EC': {'name': 'Ecuador', 'flag': '🇪🇨'},
    'GT': {'name': 'Guatemala', 'flag': '🇬🇹'},
    'BO': {'name': 'Bolivia', 'flag': '🇧🇴'},
    'PY': {'name': 'Paraguay', 'flag': '🇵🇾'},
    'SV': {'name': 'El Salvador', 'flag': '🇸🇻'},
    'HN': {'name': 'Honduras', 'flag': '🇭🇳'},
    'NI': {'name': 'Nicaragua', 'flag': '🇳🇮'},
    'UY': {'name': 'Uruguay', 'flag': '🇺🇾'},
    'JM': {'name': 'Jamaica', 'flag': '🇯🇲'},
    'TT': {'name': 'Trinidad and Tobago', 'flag': '🇹🇹'},
    'BH': {'name': 'Bahrain', 'flag': '🇧🇭'},
    'KW': {'name': 'Kuwait', 'flag': '🇰🇼'},
    'OM': {'name': 'Oman', 'flag': '🇴🇲'},
    'QA': {'name': 'Qatar', 'flag': '🇶🇦'},
    'JO': {'name': 'Jordan', 'flag': '🇯🇴'},
    'LB': {'name': 'Lebanon', 'flag': '🇱🇧'},
    'CY': {'name': 'Cyprus', 'flag': '🇨🇾'},
    'MT': {'name': 'Malta', 'flag': '🇲🇹'},
    'IS': {'name': 'Iceland', 'flag': '🇮🇸'},
    'LI': {'name': 'Liechtenstein', 'flag': '🇱🇮'},
    'MC': {'name': 'Monaco', 'flag': '🇲🇨'},
    'SM': {'name': 'San Marino', 'flag': '🇸🇲'},
    'VA': {'name': 'Vatican City', 'flag': '🇻🇦'},
    'AD': {'name': 'Andorra', 'flag': '🇦🇩'},
    'ME': {'name': 'Montenegro', 'flag': '🇲🇪'},
    'AL': {'name': 'Albania', 'flag': '🇦🇱'},
    'MK': {'name': 'North Macedonia', 'flag': '🇲🇰'},
    'BA': {'name': 'Bosnia and Herzegovina', 'flag': '🇧🇦'},
    'RS': {'name': 'Serbia', 'flag': '🇷🇸'},
    'XK': {'name': 'Kosovo', 'flag': '🇽🇰'},
    'MD': {'name': 'Moldova', 'flag': '🇲🇩'},
    'BY': {'name': 'Belarus', 'flag': '🇧🇾'},
    'LV': {'name': 'Latvia', 'flag': '🇱🇻'},
    'LT': {'name': 'Lithuania', 'flag': '🇱🇹'},
    'EE': {'name': 'Estonia', 'flag': '🇪🇪'},
    'GE': {'name': 'Georgia', 'flag': '🇬🇪'},
    'AM': {'name': 'Armenia', 'flag': '🇦🇲'},
    'AZ': {'name': 'Azerbaijan', 'flag': '🇦🇿'},
    'KZ': {'name': 'Kazakhstan', 'flag': '🇰🇿'},
    'TM': {'name': 'Turkmenistan', 'flag': '🇹🇲'},
    'KG': {'name': 'Kyrgyzstan', 'flag': '🇰🇬'},
    'TJ': {'name': 'Tajikistan', 'flag': '🇹🇯'},
    'MM': {'name': 'Myanmar', 'flag': '🇲🇲'},
    'NP': {'name': 'Nepal', 'flag': '🇳🇵'},
    'LK': {'name': 'Sri Lanka', 'flag': '🇱🇰'},
    'BD': {'name': 'Bangladesh', 'flag': '🇧🇩'},
    'KH': {'name': 'Cambodia', 'flag': '🇰🇭'},
    'LA': {'name': 'Laos', 'flag': '🇱🇦'},
    'BN': {'name': 'Brunei', 'flag': '🇧🇳'},
    'PG': {'name': 'Papua New Guinea', 'flag': '🇵🇬'},
    'FJ': {'name': 'Fiji', 'flag': '🇫🇯'},
    'SB': {'name': 'Solomon Islands', 'flag': '🇸🇧'},
    'VU': {'name': 'Vanuatu', 'flag': '🇻🇺'},
    'WS': {'name': 'Samoa', 'flag': '🇼🇸'},
    'KI': {'name': 'Kiribati', 'flag': '🇰🇮'},
    'TO': {'name': 'Tonga', 'flag': '🇹🇴'},
    'FM': {'name': 'Micronesia', 'flag': '🇫🇲'},
    'MH': {'name': 'Marshall Islands', 'flag': '🇲🇭'},
    'PW': {'name': 'Palau', 'flag': '🇵🇼'},
    'TV': {'name': 'Tuvalu', 'flag': '🇹🇻'},
    'NR': {'name': 'Nauru', 'flag': '🇳🇷'},
    'MV': {'name': 'Maldives', 'flag': '🇲🇻'},
    'SC': {'name': 'Seychelles', 'flag': '🇸🇨'},
    'ST': {'name': 'Sao Tome and Principe', 'flag': '🇸🇹'},
    'KM': {'name': 'Comoros', 'flag': '🇰🇲'},
    'MU': {'name': 'Mauritius', 'flag': '🇲🇺'},
    'CV': {'name': 'Cabo Verde', 'flag': '🇨🇻'},
    'DJ': {'name': 'Djibouti', 'flag': '🇩🇯'},
    'SO': {'name': 'Somalia', 'flag': '🇸🇴'},
    'SD': {'name': 'Sudan', 'flag': '🇸🇩'},
    'SS': {'name': 'South Sudan', 'flag': '🇸🇸'},
    'ER': {'name': 'Eritrea', 'flag': '🇪🇷'},
    'LY': {'name': 'Libya', 'flag': '🇱🇾'},
    'TN': {'name': 'Tunisia', 'flag': '🇹🇳'},
    'DZ': {'name': 'Algeria', 'flag': '🇩🇿'},
    'MR': {'name': 'Mauritania', 'flag': '🇲🇷'},
    'ML': {'name': 'Mali', 'flag': '🇲🇱'},
    'SN': {'name': 'Senegal', 'flag': '🇸🇳'},
    'GM': {'name': 'Gambia', 'flag': '🇬🇲'},
    'GN': {'name': 'Guinea', 'flag': '🇬🇳'},
    'GW': {'name': 'Guinea-Bissau', 'flag': '🇬🇼'},
    'SL': {'name': 'Sierra Leone', 'flag': '🇸🇱'},
    'LR': {'name': 'Liberia', 'flag': '🇱🇷'},
    'CI': {'name': 'Ivory Coast', 'flag': '🇨🇮'},
    'BF': {'name': 'Burkina Faso', 'flag': '🇧🇫'},
    'NE': {'name': 'Niger', 'flag': '🇳🇪'},
    'TD': {'name': 'Chad', 'flag': '🇹🇩'},
    'CF': {'name': 'Central African Republic', 'flag': '🇨🇫'},
    'CM': {'name': 'Cameroon', 'flag': '🇨🇲'},
    'GQ': {'name': 'Equatorial Guinea', 'flag': '🇬🇶'},
    'GA': {'name': 'Gabon', 'flag': '🇬🇦'},
    'CG': {'name': 'Congo', 'flag': '🇨🇬'},
    'CD': {'name': 'Democratic Republic of the Congo', 'flag': '🇨🇩'},
    'RW': {'name': 'Rwanda', 'flag': '🇷🇼'},
    'BI': {'name': 'Burundi', 'flag': '🇧🇮'},
    'TZ': {'name': 'Tanzania', 'flag': '🇹🇿'},
    'UG': {'name': 'Uganda', 'flag': '🇺🇬'},
    'ZM': {'name': 'Zambia', 'flag': '🇿🇲'},
    'MW': {'name': 'Malawi', 'flag': '🇲🇼'},
    'MZ': {'name': 'Mozambique', 'flag': '🇲🇿'},
    'ZW': {'name': 'Zimbabwe', 'flag': '🇿🇼'},
    'BW': {'name': 'Botswana', 'flag': '🇧🇼'},
    'NA': {'name': 'Namibia', 'flag': '🇳🇦'},
    'LS': {'name': 'Lesotho', 'flag': '🇱🇸'},
    'SZ': {'name': 'Eswatini', 'flag': '🇸🇿'},
    'TL': {'name': 'Timor-Leste', 'flag': '🇹🇱'},
    'BT': {'name': 'Bhutan', 'flag': '🇧🇹'},
    'AQ': {'name': 'Antarctica', 'flag': '🇦🇶'},
    'BV': {'name': 'Bouvet Island', 'flag': '🇧🇻'},
    'TF': {'name': 'French Southern Territories', 'flag': '🇹🇫'},
    'HM': {'name': 'Heard Island and McDonald Islands', 'flag': '🇭🇲'},
    'GS': {
      'name': 'South Georgia and the South Sandwich Islands',
      'flag': '🇬🇸'
    },
    'UM': {'name': 'United States Minor Outlying Islands', 'flag': '🇺🇲'},
    'CC': {'name': 'Cocos (Keeling) Islands', 'flag': '🇨🇨'},
    'CX': {'name': 'Christmas Island', 'flag': '🇨🇽'},
    'PN': {'name': 'Pitcairn Islands', 'flag': '🇵🇳'},
    'SH': {
      'name': 'Saint Helena, Ascension and Tristan da Cunha',
      'flag': '🇸🇭'
    },
    'PM': {'name': 'Saint Pierre and Miquelon', 'flag': '🇵🇲'},
    'GP': {'name': 'Guadeloupe', 'flag': '🇬🇵'},
    'MQ': {'name': 'Martinique', 'flag': '🇲🇶'},
    'GF': {'name': 'French Guiana', 'flag': '🇬🇫'},
    'AW': {'name': 'Aruba', 'flag': '🇦🇼'},
    'CW': {'name': 'Curaçao', 'flag': '🇨🇼'},
    'SX': {'name': 'Sint Maarten (Dutch part)', 'flag': '🇸🇽'},
    'BQ': {'name': 'Bonaire, Sint Eustatius and Saba', 'flag': '🇧🇶'},
    'GI': {'name': 'Gibraltar', 'flag': '🇬🇮'},
    'GG': {'name': 'Guernsey', 'flag': '🇬🇬'},
    'JE': {'name': 'Jersey', 'flag': '🇯🇪'},
    'IM': {'name': 'Isle of Man', 'flag': '🇮🇲'},
    'AX': {'name': 'Åland Islands', 'flag': '🇦🇽'},
    'FO': {'name': 'Faroe Islands', 'flag': '🇫🇴'},
    'SJ': {'name': 'Svalbard and Jan Mayen', 'flag': '🇸🇯'},
    'TK': {'name': 'Tokelau', 'flag': '🇹🇰'},
    'WF': {'name': 'Wallis and Futuna', 'flag': '🇼🇫'},
    'NU': {'name': 'Niue', 'flag': '🇳🇺'},
    'CK': {'name': 'Cook Islands', 'flag': '🇨🇰'},
    'AS': {'name': 'American Samoa', 'flag': '🇦🇸'},
    'GU': {'name': 'Guam', 'flag': '🇬🇺'},
    'MP': {'name': 'Northern Mariana Islands', 'flag': '🇲🇵'},
    'PR': {'name': 'Puerto Rico', 'flag': '🇵🇷'},
    'VI': {'name': 'United States Virgin Islands', 'flag': '🇻🇮'},
    'AI': {'name': 'Anguilla', 'flag': '🇦🇮'},
    'KY': {'name': 'Cayman Islands', 'flag': '🇰🇾'},
    'BM': {'name': 'Bermuda', 'flag': '🇧🇲'},
    'TC': {'name': 'Turks and Caicos Islands', 'flag': '🇹🇨'},
    'MS': {'name': 'Montserrat', 'flag': '🇲🇸'},
    'VG': {'name': 'British Virgin Islands', 'flag': '🇻🇬'},
    'IO': {'name': 'British Indian Ocean Territory', 'flag': '🇮🇴'},
    'PS': {'name': 'Palestine, State of', 'flag': '🇵🇸'},
    'EH': {'name': 'Western Sahara', 'flag': '🇪🇭'},
  };

  static String getCountryName(String isoCode) {
    return countryDetails[isoCode]?['name'] ?? isoCode;
  }

  static String getCountryFlag(String isoCode) {
    return countryDetails[isoCode]?['flag'] ?? '';
  }

  static String formatPhoneNumber(String phoneNumber, String locale) {
    try {
      if (locale == 'US' || locale == 'CA') {
        return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)}-${phoneNumber.substring(6)}';
      } else if (locale == 'GB') {
        return '${phoneNumber.substring(0, 5)} ${phoneNumber.substring(5)}';
      } else {
        return phoneNumber; // Default to returning the original phone number
      }
    } catch (e) {
      return phoneNumber;
    }
  }

  static String getLocaleFromIsoCode(String isoCode) {
    // Basic mapping, add more if you want to support more locales
    switch (isoCode) {
      case 'US':
        return 'en_US';
      case 'GB':
        return 'en_GB';
      case 'CA':
        return 'en_CA';
      case 'AU':
        return 'en_AU';
      case 'DE':
        return 'de_DE';
      case 'FR':
        return 'fr_FR';
      case 'JP':
        return 'ja_JP';
      case 'CN':
        return 'zh_CN';
      case 'ET':
        return 'am_ET';
      default:
        return 'en_US'; // Default to US locale
    }
  }
}
