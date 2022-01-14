Function GitClone([Object[]] $config, [Object[]] $response)
{
    for ($j=0; $j -lt $response.values.Length; $j++) {
		
        $fullname = $response.values[$j].full_name
        $slug = $response.values[$j].slug

	git clone --bare "$($config.giturl+"/$fullname")"

    cd $slug".git"

	git remote set-url --push origin $($config.destinationAddress + $slug)
	git config http.sslVerify false
	git push --mirror
        
    cd ..
		
	#$location = Get-Location
	#$rmfolder = ("$location" + "\$slug").toString()
	#$rmfolder
	#Remove-Item $rmfolder -recurse -force
    }
}
