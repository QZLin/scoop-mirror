$simple_replace = @{
    'https?://github\.com'                        = 'https://ghproxy.net/github.com'
    'https?://raw\.githubusercontent\.com'        = 'https://ghproxy.net/raw.githubusercontent.com'
    'https?://raw\.github\.com'                   = 'https://ghproxy.net/raw.github.com'
    "https?://nodejs\.org/dist/"                  = 'https://registry.npmmirror.com/-/binary/node/'
    '(?<=//)(?:.*dl|downloads)\.sourceforge\.net' = 'nchc.dl.sourceforge.net'
}
function inject_url ($url) {
    foreach ($key in $simple_replace.Keys) {
        $url = $url -replace $key, $simple_replace.$key
    }
    info $url
    return $url
}
