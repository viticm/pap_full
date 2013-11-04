require('ReadVcproj')

function  update_CMakeList(cmakefile, vcprog, include_path)
  local strNewContent = ""
  local f = io.open(cmakefile, "r")
  local filecontent = f:read("*all")
  local len = string.len(filecontent)
  local bpos1, bpos2= string.find(filecontent, '##update_begin')
  local strBeginText = string.sub(filecontent, 1, bpos2 + 1 );
  local strMakeFile = get_vcproj_cmake(vcprog, include_path)
  local epos = string.find(filecontent, '##update_end')
  local strEndText = string.sub(filecontent, epos - 1 );
  f:close()
  strNewContent = strBeginText .. '\n\n' .. strMakeFile .. '\n\n' ..strEndText
  local wf = io.open(cmakefile, "w")
  wf:write(strNewContent)
  wf:close()
end

local odbc_include_path = "/usr/local/unixODBC/include"
update_CMakeList("ShareMemory//ShareMemory//CMakeLists.txt", "ShareMemory//ShareMemory//ShareMemory.vcproj", odbc_include_path)
update_CMakeList("World//World//CMakeLists.txt", "World//World//World.vcproj", odbc_include_path)
update_CMakeList("Server//Server//CMakeLists.txt", "Server//Server//Server.vcproj", odbc_include_path)
update_CMakeList("Billing//Billing//CMakeLists.txt", "Billing//Billing//Billing.vcproj", odbc_include_path)
update_CMakeList("Login//Login//CMakeLists.txt", "Login//Login//Login.vcproj", odbc_include_path)
