class BulletProofJson::ConsoleLogger

  def fatal(class_name="unknown class", message="")
  	print "FATAL [#{class_name}] #{message} "
  end

  def error(class_name="unknown class", message="")
    print "ERROR [#{class_name}] #{message} "
  end

  def warn(class_name="unknown class", message="")
    print "WARN [#{class_name}] #{message} "
  end

  def info(class_name="unknown class", message="")
    print "INFO [#{class_name}] #{message} "
  end

  def debug(class_name="unknown class", message="")
    print "DEBUG [#{class_name}] #{message} "
  end
end