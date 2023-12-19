Update `requirements.txt`:
`pip freeze > requirements.txt`

Install packages from online repository:
`pip install -r requirements.txt`

Download referenced packages to local filesystem:
`pip download -r requirements.txt -d /path/to/packages`

Install packages from filesystem:
`pip install -r requirements.txt --no-index --find-links /path/to/packages`

Uninstall packages:
`pip uninstall -r requirements.txt` 
