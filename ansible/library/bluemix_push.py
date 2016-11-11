#!/usr/bin/python

#from ansible.module_utils.azure_rm_common import *
DOCUMENTATION = '''
---
module:
'''

import os.path
import json
import base64

from urlparse import urlparse
from distutils.version import LooseVersion
from subprocess import check_output

try:
    import time
    import yaml
except ImportError as exc:
    IMPORT_ERROR = "Error importing module prerequisites: %s" % exc

class bluemix_push():
    def __init__(self, module):
        self.module = module

        self.app_name = self.module.params.get('app_name')
        self.manifest_path = self.module.params.get('manifest_path')

        self.log = list()

    def message(self):
            self.log.append("test print")
            self.log.append(self.username)

    def push(self):
        return check_output(["cf", "push", self.app_name, "-f", self.manifest_path, "--health-check-type", "none"])

    def get_msg(self):
        return ". ".join(self.log)



def main():
    module = AnsibleModule(
        argument_spec     = dict(
            app_name      = dict(type='str', required=True),
            manifest_path = dict(type='str', required=True),
        ),
        supports_check_mode=True
    )

    try:
        bluemix =  bluemix_push(module)
        if  bluemix.push():
            module.exit_json(changed=False)
        else:
            module.exit_json(message="push failed")
    except Exception as e:
        module.fail_json(msg="Module execution has failed due to an unexpected error", error=repr(e))


from ansible.module_utils.basic import *
if __name__ == '__main__':
    main()
