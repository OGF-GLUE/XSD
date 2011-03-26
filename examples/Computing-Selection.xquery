xquery version "1.0";
declare namespace glue = "http://schemas.ogf.org/glue/2008/05/spec_2.0_d42_r01";

<Results xmlns:glue="http://schemas.ogf.org/glue/2008/05/spec_2.0_d42_r01" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"> {

for 
    $service in doc("BES-Example-2.xml")/glue:Domains/AdminDomain/Services/ComputingService
for 
    $endpoint in $service/ComputingEndpoint[Interface eq "urn:ogsa:bes:1.0"]
                                                                                [QualityLevel eq "production"]
                                                                                [some $rule  in AccessPolicy/Rule satisfies ($rule/text() eq "fqan:/blue")],
    $share in $service/ComputingShares/ComputingShare[MaxWallTime > 400000]
                                                                      [MaxCPUTime > 40000]
                                                                      [some $rule  in MappingPolicy/Rule satisfies ($rule/text() eq "fqan:/blue")]
                                                                      [some $association in Associations/ComputingEndpointID satisfies ($association/text() eq $endpoint/ID)], 
    $exec in $service/ComputingManager/ExecutionEnvironment [OSName eq "scientificlinux"]
                                                                                                                   [Benchmark/Type[.="specint2000"]/../Value>200]
                                                                                                                   [some $association in Associations/ComputingShareLocalID satisfies ($association/text() eq $share/LocalID)] 
 return 
                <ComputingService>
                    {$service/ID} 
                    <ComputingEndpoint>{$endpoint/ID}</ComputingEndpoint>
                    <ComputingShare>{$share/LocalID}</ComputingShare>
                    <ExecutionEnvironment>{$exec/ID}</ExecutionEnvironment>
            </ComputingService>
          
          
} </Results>