if((Split-Path -Path (Get-Location) -Leaf) -eq 'src' -or (Test-Path -Path "./src")) { 
    $root_dir = "./components" 
    if(Test-Path -Path "./src") {
        $root_dir = "./src/components"
    }

    if(!(Test-Path -Path $root_dir)) {
    mkdir $root_dir
    }

    if($args[0] -eq $null) {
        $name_of_file = Read-Host "Enter file name"
    } else {
      $name_of_file = $args[0]
    }

    if(!(Test-Path -Path $root_dir/$name_of_file)) {
        $make_new_dir = "$root_dir/$name_of_file"
    } else {
        Write-Output "Component already exist"
        Exit
    }
    mkdir $make_new_dir

    New-Item -Path .\$make_new_dir -Name "$name_of_file.component.tsx"
    New-Item -Path .\$make_new_dir -Name "$name_of_file.style.css"
    @"
    import "./$($name_of_file).css"
    interface Props {}
    export const $($name_of_file): React.FC<Props> = ({}) => {
        return <h1> $($name_of_file) Component </h1>
    }
"@ > ".\$make_new_dir\$name_of_file.component.tsx"
} else {
    Write-Output "Not in src or main directory"
}
