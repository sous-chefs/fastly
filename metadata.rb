name              'fastly'
maintainer        'Sous Chefs'
maintainer_email  'help@sous-chefs.org'
license           'Apache-2.0'
description       'Resources for Configuring Fastly Services'
version           '0.6.11'
source_url        'https://github.com/sous-chefs/fastly'
issues_url        'https://github.com/sous-chefs/fastly/issues'
# TODO(ramereth): This is still using the old style provider/resources and does not work on >= 16
chef_version      '>= 12.10', '< 16.0'

supports 'any'
