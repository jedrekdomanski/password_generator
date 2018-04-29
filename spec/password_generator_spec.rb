RSpec.describe PasswordGenerator do
  it "has a version number" do
    expect(PasswordGenerator::VERSION).not_to be nil
  end

  it "generates alphabetic characters" do
    50.times do
      password = PasswordGenerator.generate
      expect(password).to match /^[[:alpha:]]+$/
    end
  end

  it "generates unique alphabetic characters" do
    50.times do
      password = PasswordGenerator.generate(unique: true)
      expect(password).to match /^[[:alpha:]]+$/
      expect(password.size).to eq password.chars.uniq.size
    end
  end

  it "generates unique alphabetic characters and punctions" do
    50.times do
      password = PasswordGenerator.generate(unique: true, punct: 2, length: 30)
      expect(password).to match /^[[:alpha:]]*[[:punct:]][[:alpha:]]*[[:punct:]][[:alpha:]]*$/
      expect(password.size).to eq 30
      expect(password.chars.uniq.size).to eq 30
    end
  end

  it "generates unique alphabetic characters and digits" do
    50.times do
      password = PasswordGenerator.generate(unique: true, digit: 1, length: 15)
      expect(password).to match /^[[:alpha:]]*[[:digit:]][[:alpha:]]*$/
      expect(password.size).to eq 15
      expect(password.chars.uniq.size).to eq 15
    end
  end

  it "generates unique alphabetic uppercase characters" do
    50.times do
      password = PasswordGenerator.generate(unique: true, upper: 1, length: 18)
      expect(password).to match /^[[:lower:]]*[[:upper:]][[:lower:]]*$/
      expect(password.size).to eq 18
      expect(password.chars.uniq.size).to eq 18
    end
  end

  it "generates unique alphabetic no uppercase characters" do
    50.times do
      password = PasswordGenerator.generate(unique: true, upper: 0, length: 19)
      expect(password).to match /^[[:lower:]]*$/
      expect(password.size).to eq 19
      expect(password.chars.uniq.size).to eq 19
    end
  end
end
