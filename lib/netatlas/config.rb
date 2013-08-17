require 'yaml'
require 'logger'
NETATLAS_CONFIG_DIR = ENV['NETATLAS_CONFIG_DIR'] || "/etc/netatlas"
NETATLAS_ENV= ENV['NETATLAS_ENV'] || "development"
CONFIG = YAML.load(File.open(NETATLAS_CONFIG_DIR + "/netatlas.yml"))[NETATLAS_ENV].with_indifferent_access


logfile = NETATLAS_ENV == "test" ? STDOUT : File.open(CONFIG['logfile'], File::WRONLY | File::APPEND | File::CREAT)
logfile.sync = true 
$log = Logger.new(logfile)
$log.level = eval "Logger::#{CONFIG['loglevel'].upcase}"

#$log.info "NETATLAS_ENV = #{NETATLAS_ENV}"
#$log.info "CONFIG = #{CONFIG.inspect}"

