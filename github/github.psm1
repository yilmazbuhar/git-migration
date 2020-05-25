Function GitClone([Object[]] $config, [Object[]] $response)
{
    for ($j=0; $j -lt $response.length; $j++) {
        $fullname = $response[$j].full_name
        git clone $($config.giturl+"/$fullname")
    }
}