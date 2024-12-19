const String defaultApplePay = '''{
  "provider": "apple_pay",
  "data": {
    "merchantIdentifier": "merchant.mx.posibilidades.macrolife",
    "displayName": "Hungrimind Store",
    "merchantCapabilities": ["debit"],
    "supportedNetworks": ["visa", "masterCard"],
    "countryCode": "MX",
    "currencyCode": "MXN",
    "requiredBillingContactFields": ["emailAddress", "name", "phoneNumber", "postalAddress"],
    "requiredShippingContactFields": [],
    "shippingMethods": [
      {
        "amount": "100",
        "detail": "5-8 Business Days",
        "identifier": "flat_rate_shipping_id_2",
        "label": "UPS Ground"
      }
    ]
  }
}''';
