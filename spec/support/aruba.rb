def start
  @aruba_io_wait_seconds = 5
  run_interactive './../bin/netatlas-test'
end


def netatlas(args, input = nil, cassette = nil)
  credentials = "-u admin@netatlas.com -p password"
  ENV['CASSETTE'] = if cassette
                      cassette
                    elsif example.metadata[:vcr]
                      "#{example.metadata[:full_description]}" 
                    else
                      nil
                    end
  command = "netatlas_test #{credentials} #{args}"
  puts command
  puts input
  process = run_interactive(command)
  if input
    process.stdin << input
    process.stdin.close
  end
  process
end
