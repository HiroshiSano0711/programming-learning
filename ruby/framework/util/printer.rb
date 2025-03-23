module Printer
  COLOR_ASCI_CODE = { red: 31, green: 32 }

  def print_for_generator(str)
    print "\t\e[#{COLOR_ASCI_CODE[:green]}m\tcreate\t\e[m#{str}\n"
  end
end
