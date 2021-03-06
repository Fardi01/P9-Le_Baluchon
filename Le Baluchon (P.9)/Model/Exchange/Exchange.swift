//
//  Exchange.swift
//  Le Baluchon (P.9)
//
//  Created by fardi Issihaka on 12/10/2021.
//

import Foundation


struct ExchangeResponse: Codable {
    
    let base: String
    var rates: Rates
    
    struct Rates: Codable {
        var EUR: Double
        var USD: Double
    }
}




// MARK: - Reponse Json

//{
//    "success": true,
//    "timestamp": 1633989304,
//    "base": "EUR",
//    "date": "2021-10-11",
//    "rates": {
//        "AED": 4.244244,
//        "AFN": 104.829883,
//        "ALL": 121.285737,
//        "AMD": 553.164082,
//        "ANG": 2.074417,
//        "AOA": 691.159263,
//        "ARS": 114.221974,
//        "AUD": 1.572565,
//        "AWG": 2.080535,
//        "AZN": 1.956586,
//        "BAM": 1.95415,
//        "BBD": 2.333394,
//        "BDT": 98.894485,
//        "BGN": 1.956009,
//        "BHD": 0.435601,
//        "BIF": 2297.714772,
//        "BMD": 1.155532,
//        "BND": 1.565254,
//        "BOB": 7.985535,
//        "BRL": 6.398297,
//        "BSD": 1.155607,
//        "BTC": 2.0192679e-5,
//        "BTN": 87.119608,
//        "BWP": 13.058175,
//        "BYN": 2.856544,
//        "BYR": 22648.420313,
//        "BZD": 2.329398,
//        "CAD": 1.441175,
//        "CDF": 2328.396497,
//        "CHF": 1.071522,
//        "CLF": 0.034526,
//        "CLP": 952.678083,
//        "CNY": 7.453985,
//        "COP": 4336.710277,
//        "CRC": 723.647917,
//        "CUC": 1.155532,
//        "CUP": 30.621589,
//        "CVE": 110.170292,
//        "CZK": 25.390846,
//        "DJF": 205.360949,
//        "DKK": 7.440584,
//        "DOP": 65.086049,
//        "DZD": 158.756207,
//        "EGP": 18.16357,
//        "ERN": 17.338699,
//        "ETB": 53.788261,
//        "EUR": 1,
//        "FJD": 2.426152,
//        "FKP": 0.834849,
//        "GBP": 0.849906,
//        "GEL": 3.61099,
//        "GGP": 0.834849,
//        "GHS": 7.011872,
//        "GIP": 0.834849,
//        "GMD": 59.51,
//        "GNF": 11276.805908,
//        "GTQ": 8.944711,
//        "GYD": 241.782152,
//        "HKD": 8.989863,
//        "HNL": 27.843065,
//        "HRK": 7.516385,
//        "HTG": 114.408649,
//        "HUF": 359.532099,
//        "IDR": 16410.744921,
//        "ILS": 3.729906,
//        "IMP": 0.834849,
//        "INR": 87.129571,
//        "IQD": 1687.239567,
//        "IRR": 48760.543367,
//        "ISK": 149.9995,
//        "JEP": 0.834848,
//        "JMD": 171.035969,
//        "JOD": 0.819243,
//        "JPY": 130.941392,
//        "KES": 127.986129,
//        "KGS": 97.978808,
//        "KHR": 4711.549722,
//        "KMF": 491.852237,
//        "KPW": 1039.9785,
//        "KRW": 1381.773167,
//        "KWD": 0.348566,
//        "KYD": 0.963072,
//        "KZT": 491.033634,
//        "LAK": 11645.98854,
//        "LBP": 1747.297937,
//        "LKR": 231.12931,
//        "LRD": 197.013335,
//        "LSL": 17.263617,
//        "LTL": 3.411985,
//        "LVL": 0.698969,
//        "LYD": 5.267572,
//        "MAD": 10.479092,
//        "MDL": 20.090929,
//        "MGA": 4575.206929,
//        "MKD": 61.562078,
//        "MMK": 2267.957054,
//        "MNT": 3280.82912,
//        "MOP": 9.261638,
//        "MRO": 412.5246,
//        "MUR": 49.458922,
//        "MVR": 17.85295,
//        "MWK": 942.938404,
//        "MXN": 24.111844,
//        "MYR": 4.81895,
//        "MZN": 73.757906,
//        "NAD": 17.263319,
//        "NGN": 474.657605,
//        "NIO": 40.685025,
//        "NOK": 9.902722,
//        "NPR": 139.391173,
//        "NZD": 1.666074,
//        "OMR": 0.444803,
//        "PAB": 1.155706,
//        "PEN": 4.724239,
//        "PGK": 4.109667,
//        "PHP": 58.9529,
//        "PKR": 197.702246,
//        "PLN": 4.588327,
//        "PYG": 7970.448214,
//        "QAR": 4.207002,
//        "RON": 4.949717,
//        "RSD": 117.444039,
//        "RUB": 83.048174,
//        "RWF": 1175.509475,
//        "SAR": 4.333306,
//        "SBD": 9.322601,
//        "SCR": 16.820461,
//        "SDG": 510.135559,
//        "SEK": 10.134515,
//        "SGD": 1.566204,
//        "SHP": 1.591628,
//        "SLL": 12242.858262,
//        "SOS": 674.830857,
//        "SRD": 24.735366,
//        "STD": 23917.172118,
//        "SVC": 10.112307,
//        "SYP": 1453.009658,
//        "SZL": 17.286739,
//        "THB": 38.91808,
//        "TJS": 13.064456,
//        "TMT": 4.055916,
//        "TND": 3.271889,
//        "TOP": 2.619477,
//        "TRY": 10.400709,
//        "TTD": 7.861442,
//        "TWD": 32.417406,
//        "TZS": 2665.811887,
//        "UAH": 30.46591,
//        "UGX": 4154.528565,
//        "USD": 1.155532,
//        "UYU": 50.056969,
//        "UZS": 12326.123863,
//        "VEF": 247087589346.99875,
//        "VND": 26299.900323,
//        "VUV": 128.993999,
//        "WST": 2.95853,
//        "XAF": 655.393592,
//        "XAG": 0.051187,
//        "XAU": 0.000659,
//        "XCD": 3.122882,
//        "XDR": 0.819096,
//        "XOF": 655.393592,
//        "XPF": 119.655432,
//        "YER": 289.171733,
//        "ZAR": 17.407511,
//        "ZMK": 10401.174212,
//        "ZMW": 19.721147,
//        "ZWL": 372.080719
//    }
//}
