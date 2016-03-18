#!/usr/bin/env python
from mod_pbxproj import XcodeProject
project = XcodeProject.Load('/Users/admin/Desktop/Mytest/TestPythonScriptModify/TestPythonScriptModify.xcodeproj/project.pbxproj')
project.backup()
group = project.get_or_create_group('testSubgetOrCreateGroup')
group1 = project.get_or_create_group('testSubgetOrCreateGroup',parent=group)
group2 = project.get_or_create_group('testSubgetOrCreateGroup',parent=group1)
project.add_folder('/Users/admin/Desktop/Mytest/testScriptAddDirectory/libs')
##project.remove_group('')   #group id ?
project.remove_group_by_name('testgetOrCreateGroup')
#project.add_file_if_doesnt_exist('/Users/admin/Desktop/Mytest/testScriptAddDirectory/Reachability/Reachability.m',create_build_files=False,parent=group2)
project.add_file_if_doesnt_exist('/Users/admin/Desktop/Mytest/testScriptAddDirectory/Reachability/Reachability.m',create_build_files=True,parent=group2,target='TestPythonScriptModify copy 2')   #target invalid ?
project.add_file_if_doesnt_exist('System/Library/Frameworks/AdSupport.framework', parent=group1, weak=True, tree='SDKROOT')
project.add_file_if_doesnt_exist('System/Library/Frameworks/libsqlite3.0.dylib', parent=group1, weak=True, tree='SDKROOT')
project.add_file_if_doesnt_exist('/Users/admin/Desktop/Mytest/testScriptAddDirectory/frameworktest1/xsdkFramework.framework', parent=group2, weak=True)
project.add_file_if_doesnt_exist('/Users/admin/Desktop/Mytest/testScriptAddDirectory/libtest1/iiappleSDK.a', parent=group2, weak=True)
#project.add_other_ldflags('-ObjC')
#project.add_other_ldflags(['-ObjC', '-all_load', '-fobjc-arc'])
#project.add_flags('OTHER_LDFLAGS', ['-ObjC', '-all_load', '-fobjc-arc'])   #using ?
fileId = project.get_file_id_by_path('../testScriptAddDirectory/libs/ASIHTTPRequest/ASIHTTPRequest.m')  #必须要../这种
print 'fildid "%s"' % (fileId)
files = project.get_build_files(fileId)
for f in files:
    print 'f in files'
    f.add_compiler_flag('-fobjc-arc')
project.add_single_valued_flag('ENABLE_BITCODE', 'YES') #error
project.save()   #master
