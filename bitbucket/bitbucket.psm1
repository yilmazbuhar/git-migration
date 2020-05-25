Function GitClone([Object[]] $config, [Object[]] $response)
{
    for ($j=0; $j -lt $response.values.Length; $j++) {
		
        $fullname = $response.values[$j].full_name
        
		git clone "$($config.giturl+"/$fullname")"
    }
}