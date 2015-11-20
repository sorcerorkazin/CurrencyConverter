#!/usr/bin/perl
use cPanelUserConfig;

use CGI qw(:standard);
use LWP::UserAgent;
use JSON qw( decode_json );
use XML::Simple;

$query = CGI->new();

$monetaryAmount = $query->param('monetaryAmount');
$fromCurrency = $query->param('fromCurrency');
$toCurrency = $query->param('toCurrency');

#http://www.webservicex.net/CurrencyConvertor.asmx/ConversionRate?FromCurrency={ISO4217}&ToCurrency={ISO4217}

$currencyURL = 'http://www.webservicex.net/CurrencyConvertor.asmx/ConversionRate?FromCurrency='.$fromCurrency.'&ToCurrency='.$toCurrency;

$userAgent = LWP::UserAgent->new;
$response = $userAgent->get($currencyURL);
$results = XMLin($response->decoded_content());
$conversion = $results->{'content'};
print "Content-Type: application/json\n";
print 'Access-Control-Allow-Origin: *'."\n\n";
$jsonObject = "{\"content\":";
$jsonObject .= "\"".$fromCurrency. " " . $monetaryAmount . " is equal to " . $toCurrency . " " . $monetaryAmount * $conversion."\"}";

print $jsonObject;