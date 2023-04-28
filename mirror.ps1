$simple_replace = @{
    #'github\.com'                                 = 'hub.fastgit.org'
    #'raw\.githubusercontent\.com'                 = 'raw.fastgit.org'
    'https?://github\.com'                        = 'https://ghproxy.com/github.com'
    'https?://raw\.githubusercontent\.com'        = 'https://ghproxy.com/raw.githubusercontent.com'
    '(?<=//)(?:.*dl|downloads)\.sourceforge\.net' = 'udomain.dl.sourceforge.net'
}
function inject_url ($url) {
    foreach ($_ in $simple_replace.Keys) {
        $url = $url -replace $_, $simple_replace.$_
    }
    info $url
    return $url
}
