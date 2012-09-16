def start
  @aruba_io_wait_seconds = 5
  run_interactive './../bin/netatlas-test'
end


def netatlas(args, input = nil)
  credentials = "-u admin@netatlas.com -p password"
  process = run_interactive("netatlas_test #{credentials} #{args}")
  if input
    process.stdin << input
    process.stdin.close
  end
    #puts all_stderr
end
