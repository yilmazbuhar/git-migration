Function GitClone([Object[]] $config, [Object[]] $response)
{
    for ($j=0; $j -lt $response.length; $j++) {
        $fullname = $response[$j].full_name
        $slug = $response.values[$j].slug
        
        git clone --bare $($config.giturl + "/$fullname")
        cd $slug".git"

        git remote set-url --push origin $($config.destinationAddress + $slug)
        git config http.sslVerify false
        git push --mirror

        cd ..
    }
}