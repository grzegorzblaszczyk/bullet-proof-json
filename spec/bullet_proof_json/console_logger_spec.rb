require "spec_helper"

RSpec.describe BulletProofJson::ConsoleLogger do
  let(:logger) { described_class.new }

  describe "#fatal" do
    it "prints a fatal message" do
      expect { logger.fatal("TestClass", "something went wrong") }
        .to output("FATAL [TestClass] something went wrong ").to_stdout
    end
  end

  describe "#error" do
    it "prints an error message" do
      expect { logger.error("MyClass", "error occurred") }
        .to output("ERROR [MyClass] error occurred ").to_stdout
    end
  end

  describe "#warn" do
    it "prints a warning message" do
      expect { logger.warn("X", "low disk space") }
        .to output("WARN [X] low disk space ").to_stdout
    end
  end

  describe "#info" do
    it "prints an info message" do
      expect { logger.info("App", "started") }
        .to output("INFO [App] started ").to_stdout
    end
  end

  describe "#debug" do
    it "prints a debug message" do
      expect { logger.debug("DebugModule", "value is 42") }
        .to output("DEBUG [DebugModule] value is 42 ").to_stdout
    end
  end
end
