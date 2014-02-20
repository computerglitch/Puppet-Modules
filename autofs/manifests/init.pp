# == Class: autofs
#
# This class wraps autofs::install and autofs::service
#
class autofs {
  include autofs::install, autofs::service
}
