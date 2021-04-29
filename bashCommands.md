# bash Commands
## find
### Description:  
Find files that match a given filename and contain a specific string
### Command:
`find . -iname "filename" -exec grep -il "myString" {} \;`

## ack/grep
### Description:
Find files that contain both strings. Works with ack and grep. 
### Comand:
`ack secondaryString $(ack -l primaryString path/to/dir)`
#### Options:
`-l` returns filename and not the line

## wget
### Description
Get singele files form a Git Repository
`wget https://raw.githubusercontent.com/username/reponame/path/to/file`
