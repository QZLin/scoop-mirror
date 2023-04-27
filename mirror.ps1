$simple_replace = @{
    'https://github\.com'                         = 'https://ghproxy.com/github.com'
    #'github\.com'                                 = 'hub.fgit.gq'
    #'raw\.githubusercontent\.com'                 = 'raw.fgit.gq'
    '(?<=//)(?:.*dl|downloads)\.sourceforge\.net' = 'udomain.dl.sourceforge.net'
}
function inject_url ($url) {
    foreach ($_ in $simple_replace.Keys) {
        $url = $url -replace $_, $simple_replace.$_
    }
    info $url
    return $url
}
