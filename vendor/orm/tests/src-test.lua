local temper = require('temper-core');
local safeIdentifier, TableDef, FieldDef, StringField, IntField, FloatField, BoolField, changeset, NumberValidationOpts, SqlDefault, timestamps, deleteSql, Int64Field, DateField, from, SqlBuilder, col, SqlInt32, SqlString, countAll, countCol, sumCol, avgCol, minCol, maxCol, unionSql, unionAllSql, intersectSql, exceptSql, subquery, existsSql, update, SqlBoolean, deleteFrom, NullsFirst, NullsLast, ForUpdate, ForShare, local_1756, local_1757, csid__703, userTable__704, sid__709, exports;
safeIdentifier = temper.import('orm/src', 'safeIdentifier');
TableDef = temper.import('orm/src', 'TableDef');
FieldDef = temper.import('orm/src', 'FieldDef');
StringField = temper.import('orm/src', 'StringField');
IntField = temper.import('orm/src', 'IntField');
FloatField = temper.import('orm/src', 'FloatField');
BoolField = temper.import('orm/src', 'BoolField');
changeset = temper.import('orm/src', 'changeset');
NumberValidationOpts = temper.import('orm/src', 'NumberValidationOpts');
SqlDefault = temper.import('orm/src', 'SqlDefault');
timestamps = temper.import('orm/src', 'timestamps');
deleteSql = temper.import('orm/src', 'deleteSql');
Int64Field = temper.import('orm/src', 'Int64Field');
DateField = temper.import('orm/src', 'DateField');
from = temper.import('orm/src', 'from');
SqlBuilder = temper.import('orm/src', 'SqlBuilder');
col = temper.import('orm/src', 'col');
SqlInt32 = temper.import('orm/src', 'SqlInt32');
SqlString = temper.import('orm/src', 'SqlString');
countAll = temper.import('orm/src', 'countAll');
countCol = temper.import('orm/src', 'countCol');
sumCol = temper.import('orm/src', 'sumCol');
avgCol = temper.import('orm/src', 'avgCol');
minCol = temper.import('orm/src', 'minCol');
maxCol = temper.import('orm/src', 'maxCol');
unionSql = temper.import('orm/src', 'unionSql');
unionAllSql = temper.import('orm/src', 'unionAllSql');
intersectSql = temper.import('orm/src', 'intersectSql');
exceptSql = temper.import('orm/src', 'exceptSql');
subquery = temper.import('orm/src', 'subquery');
existsSql = temper.import('orm/src', 'existsSql');
update = temper.import('orm/src', 'update');
SqlBoolean = temper.import('orm/src', 'SqlBoolean');
deleteFrom = temper.import('orm/src', 'deleteFrom');
NullsFirst = temper.import('orm/src', 'NullsFirst');
NullsLast = temper.import('orm/src', 'NullsLast');
ForUpdate = temper.import('orm/src', 'ForUpdate');
ForShare = temper.import('orm/src', 'ForShare');
local_1756 = (unpack or table.unpack);
local_1757 = require('luaunit');
local_1757.FAILURE_PREFIX = temper.test_failure_prefix;
Test_ = {};
csid__703 = function(name__985)
  local return__483, t_186, local_187, local_188, local_189;
  local_187, local_188, local_189 = temper.pcall(function()
    t_186 = safeIdentifier(name__985);
    return__483 = t_186;
  end);
  if local_187 then
  else
    return__483 = temper.bubble();
  end
  return return__483;
end;
userTable__704 = function()
  return TableDef(csid__703('users'), temper.listof(FieldDef(csid__703('name'), StringField(), false, temper.null, false), FieldDef(csid__703('email'), StringField(), false, temper.null, false), FieldDef(csid__703('age'), IntField(), true, temper.null, false), FieldDef(csid__703('score'), FloatField(), true, temper.null, false), FieldDef(csid__703('active'), BoolField(), true, temper.null, false)), temper.null);
end;
Test_.test_castWhitelistsAllowedFields__2272 = function()
  temper.test('cast whitelists allowed fields', function(test_191)
    local params__989, t_192, t_193, t_194, cs__990, t_195, fn__16954, t_196, fn__16953, t_197, fn__16952, t_198, fn__16951;
    params__989 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice'), temper.pair_constructor('email', 'alice@example.com'), temper.pair_constructor('admin', 'true')));
    t_192 = userTable__704();
    t_193 = csid__703('name');
    t_194 = csid__703('email');
    cs__990 = changeset(t_192, params__989):cast(temper.listof(t_193, t_194));
    t_195 = temper.mapped_has(cs__990.changes, 'name');
    fn__16954 = function()
      return 'name should be in changes';
    end;
    temper.test_assert(test_191, t_195, fn__16954);
    t_196 = temper.mapped_has(cs__990.changes, 'email');
    fn__16953 = function()
      return 'email should be in changes';
    end;
    temper.test_assert(test_191, t_196, fn__16953);
    t_197 = not temper.mapped_has(cs__990.changes, 'admin');
    fn__16952 = function()
      return 'admin must be dropped (not in whitelist)';
    end;
    temper.test_assert(test_191, t_197, fn__16952);
    t_198 = cs__990.isValid;
    fn__16951 = function()
      return 'should still be valid';
    end;
    temper.test_assert(test_191, t_198, fn__16951);
    return nil;
  end);
end;
Test_.test_castIsReplacingNotAdditiveSecondCallResetsWhitelist__2273 = function()
  temper.test('cast is replacing not additive \xe2\x80\x94 second call resets whitelist', function(test_199)
    local params__992, t_200, t_201, cs__993, t_202, fn__16933, t_203, fn__16932;
    params__992 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice'), temper.pair_constructor('email', 'alice@example.com')));
    t_200 = userTable__704();
    t_201 = csid__703('name');
    cs__993 = changeset(t_200, params__992):cast(temper.listof(t_201)):cast(temper.listof(csid__703('email')));
    t_202 = not temper.mapped_has(cs__993.changes, 'name');
    fn__16933 = function()
      return 'name must be excluded by second cast';
    end;
    temper.test_assert(test_199, t_202, fn__16933);
    t_203 = temper.mapped_has(cs__993.changes, 'email');
    fn__16932 = function()
      return 'email should be present';
    end;
    temper.test_assert(test_199, t_203, fn__16932);
    return nil;
  end);
end;
Test_.test_castIgnoresEmptyStringValues__2274 = function()
  temper.test('cast ignores empty string values', function(test_204)
    local params__995, t_205, t_206, t_207, cs__996, t_208, fn__16915, t_209, fn__16914;
    params__995 = temper.map_constructor(temper.listof(temper.pair_constructor('name', ''), temper.pair_constructor('email', 'bob@example.com')));
    t_205 = userTable__704();
    t_206 = csid__703('name');
    t_207 = csid__703('email');
    cs__996 = changeset(t_205, params__995):cast(temper.listof(t_206, t_207));
    t_208 = not temper.mapped_has(cs__996.changes, 'name');
    fn__16915 = function()
      return 'empty name should not be in changes';
    end;
    temper.test_assert(test_204, t_208, fn__16915);
    t_209 = temper.mapped_has(cs__996.changes, 'email');
    fn__16914 = function()
      return 'email should be in changes';
    end;
    temper.test_assert(test_204, t_209, fn__16914);
    return nil;
  end);
end;
Test_.test_validateRequiredPassesWhenFieldPresent__2275 = function()
  temper.test('validateRequired passes when field present', function(test_210)
    local params__998, t_211, t_212, cs__999, t_213, fn__16898, t_214, fn__16897;
    params__998 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice')));
    t_211 = userTable__704();
    t_212 = csid__703('name');
    cs__999 = changeset(t_211, params__998):cast(temper.listof(t_212)):validateRequired(temper.listof(csid__703('name')));
    t_213 = cs__999.isValid;
    fn__16898 = function()
      return 'should be valid';
    end;
    temper.test_assert(test_210, t_213, fn__16898);
    t_214 = (temper.list_length(cs__999.errors) == 0);
    fn__16897 = function()
      return 'no errors expected';
    end;
    temper.test_assert(test_210, t_214, fn__16897);
    return nil;
  end);
end;
Test_.test_validateRequiredFailsWhenFieldMissing__2276 = function()
  temper.test('validateRequired fails when field missing', function(test_215)
    local params__1001, t_216, t_217, cs__1002, t_218, fn__16875, t_219, fn__16874, t_220, fn__16873;
    params__1001 = temper.map_constructor(temper.listof());
    t_216 = userTable__704();
    t_217 = csid__703('name');
    cs__1002 = changeset(t_216, params__1001):cast(temper.listof(t_217)):validateRequired(temper.listof(csid__703('name')));
    t_218 = not cs__1002.isValid;
    fn__16875 = function()
      return 'should be invalid';
    end;
    temper.test_assert(test_215, t_218, fn__16875);
    t_219 = (temper.list_length(cs__1002.errors) == 1);
    fn__16874 = function()
      return 'should have one error';
    end;
    temper.test_assert(test_215, t_219, fn__16874);
    t_220 = temper.str_eq((temper.list_get(cs__1002.errors, 0)).field, 'name');
    fn__16873 = function()
      return 'error should name the field';
    end;
    temper.test_assert(test_215, t_220, fn__16873);
    return nil;
  end);
end;
Test_.test_validateLengthPassesWithinRange__2277 = function()
  temper.test('validateLength passes within range', function(test_221)
    local params__1004, t_222, t_223, cs__1005, t_224, fn__16862;
    params__1004 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice')));
    t_222 = userTable__704();
    t_223 = csid__703('name');
    cs__1005 = changeset(t_222, params__1004):cast(temper.listof(t_223)):validateLength(csid__703('name'), 2, 50);
    t_224 = cs__1005.isValid;
    fn__16862 = function()
      return 'should be valid';
    end;
    temper.test_assert(test_221, t_224, fn__16862);
    return nil;
  end);
end;
Test_.test_validateLengthFailsWhenTooShort__2278 = function()
  temper.test('validateLength fails when too short', function(test_225)
    local params__1007, t_226, t_227, cs__1008, t_228, fn__16850;
    params__1007 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'A')));
    t_226 = userTable__704();
    t_227 = csid__703('name');
    cs__1008 = changeset(t_226, params__1007):cast(temper.listof(t_227)):validateLength(csid__703('name'), 2, 50);
    t_228 = not cs__1008.isValid;
    fn__16850 = function()
      return 'should be invalid';
    end;
    temper.test_assert(test_225, t_228, fn__16850);
    return nil;
  end);
end;
Test_.test_validateLengthFailsWhenTooLong__2279 = function()
  temper.test('validateLength fails when too long', function(test_229)
    local params__1010, t_230, t_231, cs__1011, t_232, fn__16838;
    params__1010 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')));
    t_230 = userTable__704();
    t_231 = csid__703('name');
    cs__1011 = changeset(t_230, params__1010):cast(temper.listof(t_231)):validateLength(csid__703('name'), 2, 10);
    t_232 = not cs__1011.isValid;
    fn__16838 = function()
      return 'should be invalid';
    end;
    temper.test_assert(test_229, t_232, fn__16838);
    return nil;
  end);
end;
Test_.test_validateIntPassesForValidInteger__2280 = function()
  temper.test('validateInt passes for valid integer', function(test_233)
    local params__1013, t_234, t_235, cs__1014, t_236, fn__16827;
    params__1013 = temper.map_constructor(temper.listof(temper.pair_constructor('age', '30')));
    t_234 = userTable__704();
    t_235 = csid__703('age');
    cs__1014 = changeset(t_234, params__1013):cast(temper.listof(t_235)):validateInt(csid__703('age'));
    t_236 = cs__1014.isValid;
    fn__16827 = function()
      return 'should be valid';
    end;
    temper.test_assert(test_233, t_236, fn__16827);
    return nil;
  end);
end;
Test_.test_validateIntFailsForNonInteger__2281 = function()
  temper.test('validateInt fails for non-integer', function(test_237)
    local params__1016, t_238, t_239, cs__1017, t_240, fn__16815;
    params__1016 = temper.map_constructor(temper.listof(temper.pair_constructor('age', 'not-a-number')));
    t_238 = userTable__704();
    t_239 = csid__703('age');
    cs__1017 = changeset(t_238, params__1016):cast(temper.listof(t_239)):validateInt(csid__703('age'));
    t_240 = not cs__1017.isValid;
    fn__16815 = function()
      return 'should be invalid';
    end;
    temper.test_assert(test_237, t_240, fn__16815);
    return nil;
  end);
end;
Test_.test_validateFloatPassesForValidFloat__2282 = function()
  temper.test('validateFloat passes for valid float', function(test_241)
    local params__1019, t_242, t_243, cs__1020, t_244, fn__16804;
    params__1019 = temper.map_constructor(temper.listof(temper.pair_constructor('score', '9.5')));
    t_242 = userTable__704();
    t_243 = csid__703('score');
    cs__1020 = changeset(t_242, params__1019):cast(temper.listof(t_243)):validateFloat(csid__703('score'));
    t_244 = cs__1020.isValid;
    fn__16804 = function()
      return 'should be valid';
    end;
    temper.test_assert(test_241, t_244, fn__16804);
    return nil;
  end);
end;
Test_.test_validateInt64_passesForValid64_bitInteger__2283 = function()
  temper.test('validateInt64 passes for valid 64-bit integer', function(test_245)
    local params__1022, t_246, t_247, cs__1023, t_248, fn__16793;
    params__1022 = temper.map_constructor(temper.listof(temper.pair_constructor('age', '9999999999')));
    t_246 = userTable__704();
    t_247 = csid__703('age');
    cs__1023 = changeset(t_246, params__1022):cast(temper.listof(t_247)):validateInt64(csid__703('age'));
    t_248 = cs__1023.isValid;
    fn__16793 = function()
      return 'should be valid';
    end;
    temper.test_assert(test_245, t_248, fn__16793);
    return nil;
  end);
end;
Test_.test_validateInt64_failsForNonInteger__2284 = function()
  temper.test('validateInt64 fails for non-integer', function(test_249)
    local params__1025, t_250, t_251, cs__1026, t_252, fn__16781;
    params__1025 = temper.map_constructor(temper.listof(temper.pair_constructor('age', 'not-a-number')));
    t_250 = userTable__704();
    t_251 = csid__703('age');
    cs__1026 = changeset(t_250, params__1025):cast(temper.listof(t_251)):validateInt64(csid__703('age'));
    t_252 = not cs__1026.isValid;
    fn__16781 = function()
      return 'should be invalid';
    end;
    temper.test_assert(test_249, t_252, fn__16781);
    return nil;
  end);
end;
Test_.test_validateBoolAcceptsTrue1_yesOn__2285 = function()
  temper.test('validateBool accepts true/1/yes/on', function(test_253)
    local fn__16778;
    fn__16778 = function(v__1028)
      local params__1029, t_254, t_255, cs__1030, t_256, fn__16767;
      params__1029 = temper.map_constructor(temper.listof(temper.pair_constructor('active', v__1028)));
      t_254 = userTable__704();
      t_255 = csid__703('active');
      cs__1030 = changeset(t_254, params__1029):cast(temper.listof(t_255)):validateBool(csid__703('active'));
      t_256 = cs__1030.isValid;
      fn__16767 = function()
        return temper.concat('should accept: ', v__1028);
      end;
      temper.test_assert(test_253, t_256, fn__16767);
      return nil;
    end;
    temper.list_foreach(temper.listof('true', '1', 'yes', 'on'), fn__16778);
    return nil;
  end);
end;
Test_.test_validateBoolAcceptsFalse0_noOff__2286 = function()
  temper.test('validateBool accepts false/0/no/off', function(test_257)
    local fn__16764;
    fn__16764 = function(v__1032)
      local params__1033, t_258, t_259, cs__1034, t_260, fn__16753;
      params__1033 = temper.map_constructor(temper.listof(temper.pair_constructor('active', v__1032)));
      t_258 = userTable__704();
      t_259 = csid__703('active');
      cs__1034 = changeset(t_258, params__1033):cast(temper.listof(t_259)):validateBool(csid__703('active'));
      t_260 = cs__1034.isValid;
      fn__16753 = function()
        return temper.concat('should accept: ', v__1032);
      end;
      temper.test_assert(test_257, t_260, fn__16753);
      return nil;
    end;
    temper.list_foreach(temper.listof('false', '0', 'no', 'off'), fn__16764);
    return nil;
  end);
end;
Test_.test_validateBoolRejectsAmbiguousValues__2287 = function()
  temper.test('validateBool rejects ambiguous values', function(test_261)
    local fn__16750;
    fn__16750 = function(v__1036)
      local params__1037, t_262, t_263, cs__1038, t_264, fn__16738;
      params__1037 = temper.map_constructor(temper.listof(temper.pair_constructor('active', v__1036)));
      t_262 = userTable__704();
      t_263 = csid__703('active');
      cs__1038 = changeset(t_262, params__1037):cast(temper.listof(t_263)):validateBool(csid__703('active'));
      t_264 = not cs__1038.isValid;
      fn__16738 = function()
        return temper.concat('should reject ambiguous: ', v__1036);
      end;
      temper.test_assert(test_261, t_264, fn__16738);
      return nil;
    end;
    temper.list_foreach(temper.listof('TRUE', 'Yes', 'maybe', '2', 'enabled'), fn__16750);
    return nil;
  end);
end;
Test_.test_toInsertSqlEscapesBobbyTables__2288 = function()
  temper.test('toInsertSql escapes Bobby Tables', function(test_265)
    local t_266, params__1040, t_267, t_268, t_269, cs__1041, sqlFrag__1042, local_270, local_271, local_272, s__1043, t_274, fn__16722;
    params__1040 = temper.map_constructor(temper.listof(temper.pair_constructor('name', "Robert'); DROP TABLE users;--"), temper.pair_constructor('email', 'bobby@evil.com')));
    t_267 = userTable__704();
    t_268 = csid__703('name');
    t_269 = csid__703('email');
    cs__1041 = changeset(t_267, params__1040):cast(temper.listof(t_268, t_269)):validateRequired(temper.listof(csid__703('name'), csid__703('email')));
    local_270, local_271, local_272 = temper.pcall(function()
      t_266 = cs__1041:toInsertSql();
      sqlFrag__1042 = t_266;
    end);
    if local_270 then
    else
      sqlFrag__1042 = temper.bubble();
    end
    s__1043 = sqlFrag__1042:toString();
    t_274 = temper.is_string_index(temper.string_indexof(s__1043, "''"));
    fn__16722 = function()
      return temper.concat('single quote must be doubled: ', s__1043);
    end;
    temper.test_assert(test_265, t_274, fn__16722);
    return nil;
  end);
end;
Test_.test_toInsertSqlProducesCorrectSqlForStringField__2289 = function()
  temper.test('toInsertSql produces correct SQL for string field', function(test_275)
    local t_276, params__1045, t_277, t_278, t_279, cs__1046, sqlFrag__1047, local_280, local_281, local_282, s__1048, t_284, fn__16702, t_285, fn__16701;
    params__1045 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice'), temper.pair_constructor('email', 'a@example.com')));
    t_277 = userTable__704();
    t_278 = csid__703('name');
    t_279 = csid__703('email');
    cs__1046 = changeset(t_277, params__1045):cast(temper.listof(t_278, t_279)):validateRequired(temper.listof(csid__703('name'), csid__703('email')));
    local_280, local_281, local_282 = temper.pcall(function()
      t_276 = cs__1046:toInsertSql();
      sqlFrag__1047 = t_276;
    end);
    if local_280 then
    else
      sqlFrag__1047 = temper.bubble();
    end
    s__1048 = sqlFrag__1047:toString();
    t_284 = temper.is_string_index(temper.string_indexof(s__1048, 'INSERT INTO users'));
    fn__16702 = function()
      return temper.concat('has INSERT INTO: ', s__1048);
    end;
    temper.test_assert(test_275, t_284, fn__16702);
    t_285 = temper.is_string_index(temper.string_indexof(s__1048, "'Alice'"));
    fn__16701 = function()
      return temper.concat('has quoted name: ', s__1048);
    end;
    temper.test_assert(test_275, t_285, fn__16701);
    return nil;
  end);
end;
Test_.test_toInsertSqlProducesCorrectSqlForIntField__2290 = function()
  temper.test('toInsertSql produces correct SQL for int field', function(test_286)
    local t_287, params__1050, t_288, t_289, t_290, t_291, cs__1051, sqlFrag__1052, local_292, local_293, local_294, s__1053, t_296, fn__16683;
    params__1050 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Bob'), temper.pair_constructor('email', 'b@example.com'), temper.pair_constructor('age', '25')));
    t_288 = userTable__704();
    t_289 = csid__703('name');
    t_290 = csid__703('email');
    t_291 = csid__703('age');
    cs__1051 = changeset(t_288, params__1050):cast(temper.listof(t_289, t_290, t_291)):validateRequired(temper.listof(csid__703('name'), csid__703('email')));
    local_292, local_293, local_294 = temper.pcall(function()
      t_287 = cs__1051:toInsertSql();
      sqlFrag__1052 = t_287;
    end);
    if local_292 then
    else
      sqlFrag__1052 = temper.bubble();
    end
    s__1053 = sqlFrag__1052:toString();
    t_296 = temper.is_string_index(temper.string_indexof(s__1053, '25'));
    fn__16683 = function()
      return temper.concat('age rendered unquoted: ', s__1053);
    end;
    temper.test_assert(test_286, t_296, fn__16683);
    return nil;
  end);
end;
Test_.test_toInsertSqlBubblesOnInvalidChangeset__2291 = function()
  temper.test('toInsertSql bubbles on invalid changeset', function(test_297)
    local params__1055, t_298, t_299, cs__1056, didBubble__1057, local_300, local_301, local_302, fn__16674;
    params__1055 = temper.map_constructor(temper.listof());
    t_298 = userTable__704();
    t_299 = csid__703('name');
    cs__1056 = changeset(t_298, params__1055):cast(temper.listof(t_299)):validateRequired(temper.listof(csid__703('name')));
    local_300, local_301, local_302 = temper.pcall(function()
      cs__1056:toInsertSql();
      didBubble__1057 = false;
    end);
    if local_300 then
    else
      didBubble__1057 = true;
    end
    fn__16674 = function()
      return 'invalid changeset should bubble';
    end;
    temper.test_assert(test_297, didBubble__1057, fn__16674);
    return nil;
  end);
end;
Test_.test_toInsertSqlEnforcesNonNullableFieldsIndependentlyOfIsValid__2292 = function()
  temper.test('toInsertSql enforces non-nullable fields independently of isValid', function(test_304)
    local strictTable__1059, params__1060, t_305, cs__1061, t_306, fn__16656, didBubble__1062, local_307, local_308, local_309, fn__16655;
    strictTable__1059 = TableDef(csid__703('posts'), temper.listof(FieldDef(csid__703('title'), StringField(), false, temper.null, false), FieldDef(csid__703('body'), StringField(), true, temper.null, false)), temper.null);
    params__1060 = temper.map_constructor(temper.listof(temper.pair_constructor('body', 'hello')));
    t_305 = csid__703('body');
    cs__1061 = changeset(strictTable__1059, params__1060):cast(temper.listof(t_305));
    t_306 = cs__1061.isValid;
    fn__16656 = function()
      return 'changeset should appear valid (no explicit validation run)';
    end;
    temper.test_assert(test_304, t_306, fn__16656);
    local_307, local_308, local_309 = temper.pcall(function()
      cs__1061:toInsertSql();
      didBubble__1062 = false;
    end);
    if local_307 then
    else
      didBubble__1062 = true;
    end
    fn__16655 = function()
      return 'toInsertSql should enforce nullable regardless of isValid';
    end;
    temper.test_assert(test_304, didBubble__1062, fn__16655);
    return nil;
  end);
end;
Test_.test_toUpdateSqlProducesCorrectSql__2293 = function()
  temper.test('toUpdateSql produces correct SQL', function(test_311)
    local t_312, params__1064, t_313, t_314, cs__1065, sqlFrag__1066, local_315, local_316, local_317, s__1067, t_319, fn__16643;
    params__1064 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Bob')));
    t_313 = userTable__704();
    t_314 = csid__703('name');
    cs__1065 = changeset(t_313, params__1064):cast(temper.listof(t_314)):validateRequired(temper.listof(csid__703('name')));
    local_315, local_316, local_317 = temper.pcall(function()
      t_312 = cs__1065:toUpdateSql(42);
      sqlFrag__1066 = t_312;
    end);
    if local_315 then
    else
      sqlFrag__1066 = temper.bubble();
    end
    s__1067 = sqlFrag__1066:toString();
    t_319 = temper.str_eq(s__1067, "UPDATE users SET name = 'Bob' WHERE id = 42");
    fn__16643 = function()
      return temper.concat('got: ', s__1067);
    end;
    temper.test_assert(test_311, t_319, fn__16643);
    return nil;
  end);
end;
Test_.test_toUpdateSqlBubblesOnInvalidChangeset__2294 = function()
  temper.test('toUpdateSql bubbles on invalid changeset', function(test_320)
    local params__1069, t_321, t_322, cs__1070, didBubble__1071, local_323, local_324, local_325, fn__16634;
    params__1069 = temper.map_constructor(temper.listof());
    t_321 = userTable__704();
    t_322 = csid__703('name');
    cs__1070 = changeset(t_321, params__1069):cast(temper.listof(t_322)):validateRequired(temper.listof(csid__703('name')));
    local_323, local_324, local_325 = temper.pcall(function()
      cs__1070:toUpdateSql(1);
      didBubble__1071 = false;
    end);
    if local_323 then
    else
      didBubble__1071 = true;
    end
    fn__16634 = function()
      return 'invalid changeset should bubble';
    end;
    temper.test_assert(test_320, didBubble__1071, fn__16634);
    return nil;
  end);
end;
Test_.test_putChangeAddsANewField__2295 = function()
  temper.test('putChange adds a new field', function(test_327)
    local params__1073, t_328, t_329, cs__1074, t_330, fn__16617, t_331, fn__16616;
    params__1073 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice')));
    t_328 = userTable__704();
    t_329 = csid__703('name');
    cs__1074 = changeset(t_328, params__1073):cast(temper.listof(t_329)):putChange(csid__703('email'), 'alice@example.com');
    t_330 = temper.mapped_has(cs__1074.changes, 'email');
    fn__16617 = function()
      return 'email should be in changes';
    end;
    temper.test_assert(test_327, t_330, fn__16617);
    t_331 = temper.str_eq(temper.mapped_getor(cs__1074.changes, 'email', ''), 'alice@example.com');
    fn__16616 = function()
      return 'email value';
    end;
    temper.test_assert(test_327, t_331, fn__16616);
    return nil;
  end);
end;
Test_.test_putChangeOverwritesExistingField__2296 = function()
  temper.test('putChange overwrites existing field', function(test_332)
    local params__1076, t_333, t_334, cs__1077, t_335, fn__16603;
    params__1076 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice')));
    t_333 = userTable__704();
    t_334 = csid__703('name');
    cs__1077 = changeset(t_333, params__1076):cast(temper.listof(t_334)):putChange(csid__703('name'), 'Bob');
    t_335 = temper.str_eq(temper.mapped_getor(cs__1077.changes, 'name', ''), 'Bob');
    fn__16603 = function()
      return 'name should be overwritten';
    end;
    temper.test_assert(test_332, t_335, fn__16603);
    return nil;
  end);
end;
Test_.test_putChangeValueAppearsInToInsertSql__2297 = function()
  temper.test('putChange value appears in toInsertSql', function(test_336)
    local t_337, t_338, params__1079, t_339, t_340, t_341, cs__1080, local_342, local_343, local_344, s__1081, t_346, fn__16588;
    params__1079 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice'), temper.pair_constructor('email', 'a@example.com')));
    t_339 = userTable__704();
    t_340 = csid__703('name');
    t_341 = csid__703('email');
    cs__1080 = changeset(t_339, params__1079):cast(temper.listof(t_340, t_341)):putChange(csid__703('name'), 'Bob');
    local_342, local_343, local_344 = temper.pcall(function()
      t_337 = cs__1080:toInsertSql();
      t_338 = t_337;
    end);
    if local_342 then
    else
      t_338 = temper.bubble();
    end
    s__1081 = t_338:toString();
    t_346 = temper.is_string_index(temper.string_indexof(s__1081, "'Bob'"));
    fn__16588 = function()
      return temper.concat('should use putChange value: ', s__1081);
    end;
    temper.test_assert(test_336, t_346, fn__16588);
    return nil;
  end);
end;
Test_.test_getChangeReturnsValueForExistingField__2298 = function()
  temper.test('getChange returns value for existing field', function(test_347)
    local t_348, params__1083, t_349, t_350, cs__1084, val__1085, local_351, local_352, local_353, t_355, fn__16578;
    params__1083 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice')));
    t_349 = userTable__704();
    t_350 = csid__703('name');
    cs__1084 = changeset(t_349, params__1083):cast(temper.listof(t_350));
    local_351, local_352, local_353 = temper.pcall(function()
      t_348 = cs__1084:getChange(csid__703('name'));
      val__1085 = t_348;
    end);
    if local_351 then
    else
      val__1085 = temper.bubble();
    end
    t_355 = temper.str_eq(val__1085, 'Alice');
    fn__16578 = function()
      return 'should return Alice';
    end;
    temper.test_assert(test_347, t_355, fn__16578);
    return nil;
  end);
end;
Test_.test_getChangeBubblesOnMissingField__2299 = function()
  temper.test('getChange bubbles on missing field', function(test_356)
    local params__1087, t_357, t_358, cs__1088, didBubble__1089, local_359, local_360, local_361, fn__16569;
    params__1087 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice')));
    t_357 = userTable__704();
    t_358 = csid__703('name');
    cs__1088 = changeset(t_357, params__1087):cast(temper.listof(t_358));
    local_359, local_360, local_361 = temper.pcall(function()
      cs__1088:getChange(csid__703('email'));
      didBubble__1089 = false;
    end);
    if local_359 then
    else
      didBubble__1089 = true;
    end
    fn__16569 = function()
      return 'should bubble for missing field';
    end;
    temper.test_assert(test_356, didBubble__1089, fn__16569);
    return nil;
  end);
end;
Test_.test_deleteChangeRemovesField__2300 = function()
  temper.test('deleteChange removes field', function(test_363)
    local params__1091, t_364, t_365, t_366, cs__1092, t_367, fn__16550, t_368, fn__16549;
    params__1091 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice'), temper.pair_constructor('email', 'a@example.com')));
    t_364 = userTable__704();
    t_365 = csid__703('name');
    t_366 = csid__703('email');
    cs__1092 = changeset(t_364, params__1091):cast(temper.listof(t_365, t_366)):deleteChange(csid__703('email'));
    t_367 = not temper.mapped_has(cs__1092.changes, 'email');
    fn__16550 = function()
      return 'email should be removed';
    end;
    temper.test_assert(test_363, t_367, fn__16550);
    t_368 = temper.mapped_has(cs__1092.changes, 'name');
    fn__16549 = function()
      return 'name should remain';
    end;
    temper.test_assert(test_363, t_368, fn__16549);
    return nil;
  end);
end;
Test_.test_deleteChangeOnNonexistentFieldIsNoOp__2301 = function()
  temper.test('deleteChange on nonexistent field is no-op', function(test_369)
    local params__1094, t_370, t_371, cs__1095, t_372, fn__16534, t_373, fn__16533;
    params__1094 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice')));
    t_370 = userTable__704();
    t_371 = csid__703('name');
    cs__1095 = changeset(t_370, params__1094):cast(temper.listof(t_371)):deleteChange(csid__703('email'));
    t_372 = temper.mapped_has(cs__1095.changes, 'name');
    fn__16534 = function()
      return 'name should still be present';
    end;
    temper.test_assert(test_369, t_372, fn__16534);
    t_373 = cs__1095.isValid;
    fn__16533 = function()
      return 'should still be valid';
    end;
    temper.test_assert(test_369, t_373, fn__16533);
    return nil;
  end);
end;
Test_.test_validateInclusionPassesWhenValueInList__2302 = function()
  temper.test('validateInclusion passes when value in list', function(test_374)
    local params__1097, t_375, t_376, cs__1098, t_377, fn__16522;
    params__1097 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'admin')));
    t_375 = userTable__704();
    t_376 = csid__703('name');
    cs__1098 = changeset(t_375, params__1097):cast(temper.listof(t_376)):validateInclusion(csid__703('name'), temper.listof('admin', 'user', 'guest'));
    t_377 = cs__1098.isValid;
    fn__16522 = function()
      return 'should be valid';
    end;
    temper.test_assert(test_374, t_377, fn__16522);
    return nil;
  end);
end;
Test_.test_validateInclusionFailsWhenValueNotInList__2303 = function()
  temper.test('validateInclusion fails when value not in list', function(test_378)
    local params__1100, t_379, t_380, cs__1101, t_381, fn__16504, t_382, fn__16503;
    params__1100 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'hacker')));
    t_379 = userTable__704();
    t_380 = csid__703('name');
    cs__1101 = changeset(t_379, params__1100):cast(temper.listof(t_380)):validateInclusion(csid__703('name'), temper.listof('admin', 'user', 'guest'));
    t_381 = not cs__1101.isValid;
    fn__16504 = function()
      return 'should be invalid';
    end;
    temper.test_assert(test_378, t_381, fn__16504);
    t_382 = temper.str_eq((temper.list_get(cs__1101.errors, 0)).field, 'name');
    fn__16503 = function()
      return 'error on name';
    end;
    temper.test_assert(test_378, t_382, fn__16503);
    return nil;
  end);
end;
Test_.test_validateInclusionSkipsWhenFieldNotInChanges__2304 = function()
  temper.test('validateInclusion skips when field not in changes', function(test_383)
    local params__1103, t_384, t_385, cs__1104, t_386, fn__16493;
    params__1103 = temper.map_constructor(temper.listof());
    t_384 = userTable__704();
    t_385 = csid__703('name');
    cs__1104 = changeset(t_384, params__1103):cast(temper.listof(t_385)):validateInclusion(csid__703('name'), temper.listof('admin', 'user'));
    t_386 = cs__1104.isValid;
    fn__16493 = function()
      return 'should be valid when field absent';
    end;
    temper.test_assert(test_383, t_386, fn__16493);
    return nil;
  end);
end;
Test_.test_validateExclusionPassesWhenValueNotInList__2305 = function()
  temper.test('validateExclusion passes when value not in list', function(test_387)
    local params__1106, t_388, t_389, cs__1107, t_390, fn__16482;
    params__1106 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice')));
    t_388 = userTable__704();
    t_389 = csid__703('name');
    cs__1107 = changeset(t_388, params__1106):cast(temper.listof(t_389)):validateExclusion(csid__703('name'), temper.listof('root', 'admin', 'superuser'));
    t_390 = cs__1107.isValid;
    fn__16482 = function()
      return 'should be valid';
    end;
    temper.test_assert(test_387, t_390, fn__16482);
    return nil;
  end);
end;
Test_.test_validateExclusionFailsWhenValueInList__2306 = function()
  temper.test('validateExclusion fails when value in list', function(test_391)
    local params__1109, t_392, t_393, cs__1110, t_394, fn__16464, t_395, fn__16463;
    params__1109 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'admin')));
    t_392 = userTable__704();
    t_393 = csid__703('name');
    cs__1110 = changeset(t_392, params__1109):cast(temper.listof(t_393)):validateExclusion(csid__703('name'), temper.listof('root', 'admin', 'superuser'));
    t_394 = not cs__1110.isValid;
    fn__16464 = function()
      return 'should be invalid';
    end;
    temper.test_assert(test_391, t_394, fn__16464);
    t_395 = temper.str_eq((temper.list_get(cs__1110.errors, 0)).field, 'name');
    fn__16463 = function()
      return 'error on name';
    end;
    temper.test_assert(test_391, t_395, fn__16463);
    return nil;
  end);
end;
Test_.test_validateExclusionSkipsWhenFieldNotInChanges__2307 = function()
  temper.test('validateExclusion skips when field not in changes', function(test_396)
    local params__1112, t_397, t_398, cs__1113, t_399, fn__16453;
    params__1112 = temper.map_constructor(temper.listof());
    t_397 = userTable__704();
    t_398 = csid__703('name');
    cs__1113 = changeset(t_397, params__1112):cast(temper.listof(t_398)):validateExclusion(csid__703('name'), temper.listof('root', 'admin'));
    t_399 = cs__1113.isValid;
    fn__16453 = function()
      return 'should be valid when field absent';
    end;
    temper.test_assert(test_396, t_399, fn__16453);
    return nil;
  end);
end;
Test_.test_validateNumberGreaterThanPasses__2308 = function()
  temper.test('validateNumber greaterThan passes', function(test_400)
    local params__1115, t_401, t_402, cs__1116, t_403, fn__16441;
    params__1115 = temper.map_constructor(temper.listof(temper.pair_constructor('age', '25')));
    t_401 = userTable__704();
    t_402 = csid__703('age');
    cs__1116 = changeset(t_401, params__1115):cast(temper.listof(t_402)):validateNumber(csid__703('age'), NumberValidationOpts(18.0, temper.null, temper.null, temper.null, temper.null));
    t_403 = cs__1116.isValid;
    fn__16441 = function()
      return '25 > 18 should pass';
    end;
    temper.test_assert(test_400, t_403, fn__16441);
    return nil;
  end);
end;
Test_.test_validateNumberGreaterThanFails__2309 = function()
  temper.test('validateNumber greaterThan fails', function(test_404)
    local params__1118, t_405, t_406, cs__1119, t_407, fn__16428;
    params__1118 = temper.map_constructor(temper.listof(temper.pair_constructor('age', '15')));
    t_405 = userTable__704();
    t_406 = csid__703('age');
    cs__1119 = changeset(t_405, params__1118):cast(temper.listof(t_406)):validateNumber(csid__703('age'), NumberValidationOpts(18.0, temper.null, temper.null, temper.null, temper.null));
    t_407 = not cs__1119.isValid;
    fn__16428 = function()
      return '15 > 18 should fail';
    end;
    temper.test_assert(test_404, t_407, fn__16428);
    return nil;
  end);
end;
Test_.test_validateNumberLessThanPasses__2310 = function()
  temper.test('validateNumber lessThan passes', function(test_408)
    local params__1121, t_409, t_410, cs__1122, t_411, fn__16416;
    params__1121 = temper.map_constructor(temper.listof(temper.pair_constructor('score', '8.5')));
    t_409 = userTable__704();
    t_410 = csid__703('score');
    cs__1122 = changeset(t_409, params__1121):cast(temper.listof(t_410)):validateNumber(csid__703('score'), NumberValidationOpts(temper.null, 10.0, temper.null, temper.null, temper.null));
    t_411 = cs__1122.isValid;
    fn__16416 = function()
      return '8.5 < 10 should pass';
    end;
    temper.test_assert(test_408, t_411, fn__16416);
    return nil;
  end);
end;
Test_.test_validateNumberLessThanFails__2311 = function()
  temper.test('validateNumber lessThan fails', function(test_412)
    local params__1124, t_413, t_414, cs__1125, t_415, fn__16403;
    params__1124 = temper.map_constructor(temper.listof(temper.pair_constructor('score', '12.0')));
    t_413 = userTable__704();
    t_414 = csid__703('score');
    cs__1125 = changeset(t_413, params__1124):cast(temper.listof(t_414)):validateNumber(csid__703('score'), NumberValidationOpts(temper.null, 10.0, temper.null, temper.null, temper.null));
    t_415 = not cs__1125.isValid;
    fn__16403 = function()
      return '12 < 10 should fail';
    end;
    temper.test_assert(test_412, t_415, fn__16403);
    return nil;
  end);
end;
Test_.test_validateNumberGreaterThanOrEqualBoundary__2312 = function()
  temper.test('validateNumber greaterThanOrEqual boundary', function(test_416)
    local params__1127, t_417, t_418, cs__1128, t_419, fn__16391;
    params__1127 = temper.map_constructor(temper.listof(temper.pair_constructor('age', '18')));
    t_417 = userTable__704();
    t_418 = csid__703('age');
    cs__1128 = changeset(t_417, params__1127):cast(temper.listof(t_418)):validateNumber(csid__703('age'), NumberValidationOpts(temper.null, temper.null, 18.0, temper.null, temper.null));
    t_419 = cs__1128.isValid;
    fn__16391 = function()
      return '18 >= 18 should pass';
    end;
    temper.test_assert(test_416, t_419, fn__16391);
    return nil;
  end);
end;
Test_.test_validateNumberCombinedOptions__2313 = function()
  temper.test('validateNumber combined options', function(test_420)
    local params__1130, t_421, t_422, cs__1131, t_423, fn__16379;
    params__1130 = temper.map_constructor(temper.listof(temper.pair_constructor('score', '5.0')));
    t_421 = userTable__704();
    t_422 = csid__703('score');
    cs__1131 = changeset(t_421, params__1130):cast(temper.listof(t_422)):validateNumber(csid__703('score'), NumberValidationOpts(0.0, 10.0, temper.null, temper.null, temper.null));
    t_423 = cs__1131.isValid;
    fn__16379 = function()
      return '5 > 0 and < 10 should pass';
    end;
    temper.test_assert(test_420, t_423, fn__16379);
    return nil;
  end);
end;
Test_.test_validateNumberNonNumericValue__2314 = function()
  temper.test('validateNumber non-numeric value', function(test_424)
    local params__1133, t_425, t_426, cs__1134, t_427, fn__16360, t_428, fn__16359;
    params__1133 = temper.map_constructor(temper.listof(temper.pair_constructor('age', 'abc')));
    t_425 = userTable__704();
    t_426 = csid__703('age');
    cs__1134 = changeset(t_425, params__1133):cast(temper.listof(t_426)):validateNumber(csid__703('age'), NumberValidationOpts(0.0, temper.null, temper.null, temper.null, temper.null));
    t_427 = not cs__1134.isValid;
    fn__16360 = function()
      return 'non-numeric should fail';
    end;
    temper.test_assert(test_424, t_427, fn__16360);
    t_428 = temper.str_eq((temper.list_get(cs__1134.errors, 0)).message, 'must be a number');
    fn__16359 = function()
      return 'correct error message';
    end;
    temper.test_assert(test_424, t_428, fn__16359);
    return nil;
  end);
end;
Test_.test_validateNumberSkipsWhenFieldNotInChanges__2315 = function()
  temper.test('validateNumber skips when field not in changes', function(test_429)
    local params__1136, t_430, t_431, cs__1137, t_432, fn__16348;
    params__1136 = temper.map_constructor(temper.listof());
    t_430 = userTable__704();
    t_431 = csid__703('age');
    cs__1137 = changeset(t_430, params__1136):cast(temper.listof(t_431)):validateNumber(csid__703('age'), NumberValidationOpts(0.0, temper.null, temper.null, temper.null, temper.null));
    t_432 = cs__1137.isValid;
    fn__16348 = function()
      return 'should be valid when field absent';
    end;
    temper.test_assert(test_429, t_432, fn__16348);
    return nil;
  end);
end;
Test_.test_validateAcceptancePassesForTrueValues__2316 = function()
  temper.test('validateAcceptance passes for true values', function(test_433)
    local fn__16345;
    fn__16345 = function(v__1139)
      local params__1140, t_434, t_435, cs__1141, t_436, fn__16334;
      params__1140 = temper.map_constructor(temper.listof(temper.pair_constructor('active', v__1139)));
      t_434 = userTable__704();
      t_435 = csid__703('active');
      cs__1141 = changeset(t_434, params__1140):cast(temper.listof(t_435)):validateAcceptance(csid__703('active'));
      t_436 = cs__1141.isValid;
      fn__16334 = function()
        return temper.concat('should accept: ', v__1139);
      end;
      temper.test_assert(test_433, t_436, fn__16334);
      return nil;
    end;
    temper.list_foreach(temper.listof('true', '1', 'yes', 'on'), fn__16345);
    return nil;
  end);
end;
Test_.test_validateAcceptanceFailsForNonTrueValues__2317 = function()
  temper.test('validateAcceptance fails for non-true values', function(test_437)
    local params__1143, t_438, t_439, cs__1144, t_440, fn__16316, t_441, fn__16315;
    params__1143 = temper.map_constructor(temper.listof(temper.pair_constructor('active', 'false')));
    t_438 = userTable__704();
    t_439 = csid__703('active');
    cs__1144 = changeset(t_438, params__1143):cast(temper.listof(t_439)):validateAcceptance(csid__703('active'));
    t_440 = not cs__1144.isValid;
    fn__16316 = function()
      return 'false should not be accepted';
    end;
    temper.test_assert(test_437, t_440, fn__16316);
    t_441 = temper.str_eq((temper.list_get(cs__1144.errors, 0)).message, 'must be accepted');
    fn__16315 = function()
      return 'correct message';
    end;
    temper.test_assert(test_437, t_441, fn__16315);
    return nil;
  end);
end;
Test_.test_validateConfirmationPassesWhenFieldsMatch__2318 = function()
  temper.test('validateConfirmation passes when fields match', function(test_442)
    local tbl__1146, params__1147, t_443, t_444, cs__1148, t_445, fn__16294;
    tbl__1146 = TableDef(csid__703('users'), temper.listof(FieldDef(csid__703('password'), StringField(), false, temper.null, false), FieldDef(csid__703('password_confirmation'), StringField(), true, temper.null, false)), temper.null);
    params__1147 = temper.map_constructor(temper.listof(temper.pair_constructor('password', 'secret123'), temper.pair_constructor('password_confirmation', 'secret123')));
    t_443 = csid__703('password');
    t_444 = csid__703('password_confirmation');
    cs__1148 = changeset(tbl__1146, params__1147):cast(temper.listof(t_443, t_444)):validateConfirmation(csid__703('password'), csid__703('password_confirmation'));
    t_445 = cs__1148.isValid;
    fn__16294 = function()
      return 'matching fields should pass';
    end;
    temper.test_assert(test_442, t_445, fn__16294);
    return nil;
  end);
end;
Test_.test_validateConfirmationFailsWhenFieldsDiffer__2319 = function()
  temper.test('validateConfirmation fails when fields differ', function(test_446)
    local tbl__1150, params__1151, t_447, t_448, cs__1152, t_449, fn__16266, t_450, fn__16265;
    tbl__1150 = TableDef(csid__703('users'), temper.listof(FieldDef(csid__703('password'), StringField(), false, temper.null, false), FieldDef(csid__703('password_confirmation'), StringField(), true, temper.null, false)), temper.null);
    params__1151 = temper.map_constructor(temper.listof(temper.pair_constructor('password', 'secret123'), temper.pair_constructor('password_confirmation', 'wrong456')));
    t_447 = csid__703('password');
    t_448 = csid__703('password_confirmation');
    cs__1152 = changeset(tbl__1150, params__1151):cast(temper.listof(t_447, t_448)):validateConfirmation(csid__703('password'), csid__703('password_confirmation'));
    t_449 = not cs__1152.isValid;
    fn__16266 = function()
      return 'mismatched fields should fail';
    end;
    temper.test_assert(test_446, t_449, fn__16266);
    t_450 = temper.str_eq((temper.list_get(cs__1152.errors, 0)).field, 'password_confirmation');
    fn__16265 = function()
      return 'error on confirmation field';
    end;
    temper.test_assert(test_446, t_450, fn__16265);
    return nil;
  end);
end;
Test_.test_validateConfirmationFailsWhenConfirmationMissing__2320 = function()
  temper.test('validateConfirmation fails when confirmation missing', function(test_451)
    local tbl__1154, params__1155, t_452, cs__1156, t_453, fn__16245;
    tbl__1154 = TableDef(csid__703('users'), temper.listof(FieldDef(csid__703('password'), StringField(), false, temper.null, false), FieldDef(csid__703('password_confirmation'), StringField(), true, temper.null, false)), temper.null);
    params__1155 = temper.map_constructor(temper.listof(temper.pair_constructor('password', 'secret123')));
    t_452 = csid__703('password');
    cs__1156 = changeset(tbl__1154, params__1155):cast(temper.listof(t_452)):validateConfirmation(csid__703('password'), csid__703('password_confirmation'));
    t_453 = not cs__1156.isValid;
    fn__16245 = function()
      return 'missing confirmation should fail';
    end;
    temper.test_assert(test_451, t_453, fn__16245);
    return nil;
  end);
end;
Test_.test_validateContainsPassesWhenSubstringFound__2321 = function()
  temper.test('validateContains passes when substring found', function(test_454)
    local params__1158, t_455, t_456, cs__1159, t_457, fn__16234;
    params__1158 = temper.map_constructor(temper.listof(temper.pair_constructor('email', 'alice@example.com')));
    t_455 = userTable__704();
    t_456 = csid__703('email');
    cs__1159 = changeset(t_455, params__1158):cast(temper.listof(t_456)):validateContains(csid__703('email'), '@');
    t_457 = cs__1159.isValid;
    fn__16234 = function()
      return 'should pass when @ present';
    end;
    temper.test_assert(test_454, t_457, fn__16234);
    return nil;
  end);
end;
Test_.test_validateContainsFailsWhenSubstringNotFound__2322 = function()
  temper.test('validateContains fails when substring not found', function(test_458)
    local params__1161, t_459, t_460, cs__1162, t_461, fn__16222;
    params__1161 = temper.map_constructor(temper.listof(temper.pair_constructor('email', 'alice-example.com')));
    t_459 = userTable__704();
    t_460 = csid__703('email');
    cs__1162 = changeset(t_459, params__1161):cast(temper.listof(t_460)):validateContains(csid__703('email'), '@');
    t_461 = not cs__1162.isValid;
    fn__16222 = function()
      return 'should fail when @ absent';
    end;
    temper.test_assert(test_458, t_461, fn__16222);
    return nil;
  end);
end;
Test_.test_validateContainsSkipsWhenFieldNotInChanges__2323 = function()
  temper.test('validateContains skips when field not in changes', function(test_462)
    local params__1164, t_463, t_464, cs__1165, t_465, fn__16212;
    params__1164 = temper.map_constructor(temper.listof());
    t_463 = userTable__704();
    t_464 = csid__703('email');
    cs__1165 = changeset(t_463, params__1164):cast(temper.listof(t_464)):validateContains(csid__703('email'), '@');
    t_465 = cs__1165.isValid;
    fn__16212 = function()
      return 'should be valid when field absent';
    end;
    temper.test_assert(test_462, t_465, fn__16212);
    return nil;
  end);
end;
Test_.test_validateStartsWithPasses__2324 = function()
  temper.test('validateStartsWith passes', function(test_466)
    local params__1167, t_467, t_468, cs__1168, t_469, fn__16201;
    params__1167 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Dr. Smith')));
    t_467 = userTable__704();
    t_468 = csid__703('name');
    cs__1168 = changeset(t_467, params__1167):cast(temper.listof(t_468)):validateStartsWith(csid__703('name'), 'Dr.');
    t_469 = cs__1168.isValid;
    fn__16201 = function()
      return 'should pass for Dr. prefix';
    end;
    temper.test_assert(test_466, t_469, fn__16201);
    return nil;
  end);
end;
Test_.test_validateStartsWithFails__2325 = function()
  temper.test('validateStartsWith fails', function(test_470)
    local params__1170, t_471, t_472, cs__1171, t_473, fn__16189;
    params__1170 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Mr. Smith')));
    t_471 = userTable__704();
    t_472 = csid__703('name');
    cs__1171 = changeset(t_471, params__1170):cast(temper.listof(t_472)):validateStartsWith(csid__703('name'), 'Dr.');
    t_473 = not cs__1171.isValid;
    fn__16189 = function()
      return 'should fail for Mr. prefix';
    end;
    temper.test_assert(test_470, t_473, fn__16189);
    return nil;
  end);
end;
Test_.test_validateEndsWithPasses__2326 = function()
  temper.test('validateEndsWith passes', function(test_474)
    local params__1173, t_475, t_476, cs__1174, t_477, fn__16178;
    params__1173 = temper.map_constructor(temper.listof(temper.pair_constructor('email', 'alice@example.com')));
    t_475 = userTable__704();
    t_476 = csid__703('email');
    cs__1174 = changeset(t_475, params__1173):cast(temper.listof(t_476)):validateEndsWith(csid__703('email'), '.com');
    t_477 = cs__1174.isValid;
    fn__16178 = function()
      return 'should pass for .com suffix';
    end;
    temper.test_assert(test_474, t_477, fn__16178);
    return nil;
  end);
end;
Test_.test_validateEndsWithFails__2327 = function()
  temper.test('validateEndsWith fails', function(test_478)
    local params__1176, t_479, t_480, cs__1177, t_481, fn__16166;
    params__1176 = temper.map_constructor(temper.listof(temper.pair_constructor('email', 'alice@example.org')));
    t_479 = userTable__704();
    t_480 = csid__703('email');
    cs__1177 = changeset(t_479, params__1176):cast(temper.listof(t_480)):validateEndsWith(csid__703('email'), '.com');
    t_481 = not cs__1177.isValid;
    fn__16166 = function()
      return 'should fail for .org when expecting .com';
    end;
    temper.test_assert(test_478, t_481, fn__16166);
    return nil;
  end);
end;
Test_.test_validateEndsWithHandlesRepeatedSuffixCorrectly__2328 = function()
  temper.test('validateEndsWith handles repeated suffix correctly', function(test_482)
    local params__1179, t_483, t_484, cs__1180, t_485, fn__16155;
    params__1179 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'abcabc')));
    t_483 = userTable__704();
    t_484 = csid__703('name');
    cs__1180 = changeset(t_483, params__1179):cast(temper.listof(t_484)):validateEndsWith(csid__703('name'), 'abc');
    t_485 = cs__1180.isValid;
    fn__16155 = function()
      return 'abcabc should end with abc';
    end;
    temper.test_assert(test_482, t_485, fn__16155);
    return nil;
  end);
end;
Test_.test_toInsertSqlUsesDefaultValueWhenFieldNotInChanges__2329 = function()
  temper.test('toInsertSql uses default value when field not in changes', function(test_486)
    local t_487, t_488, tbl__1182, params__1183, t_489, cs__1184, local_490, local_491, local_492, s__1185, t_494, fn__16127, t_495, fn__16126, t_496, fn__16125;
    tbl__1182 = TableDef(csid__703('posts'), temper.listof(FieldDef(csid__703('title'), StringField(), false, temper.null, false), FieldDef(csid__703('status'), StringField(), false, SqlDefault(), false)), temper.null);
    params__1183 = temper.map_constructor(temper.listof(temper.pair_constructor('title', 'Hello')));
    t_489 = csid__703('title');
    cs__1184 = changeset(tbl__1182, params__1183):cast(temper.listof(t_489));
    local_490, local_491, local_492 = temper.pcall(function()
      t_487 = cs__1184:toInsertSql();
      t_488 = t_487;
    end);
    if local_490 then
    else
      t_488 = temper.bubble();
    end
    s__1185 = t_488:toString();
    t_494 = temper.is_string_index(temper.string_indexof(s__1185, 'INSERT INTO posts'));
    fn__16127 = function()
      return temper.concat('has INSERT INTO: ', s__1185);
    end;
    temper.test_assert(test_486, t_494, fn__16127);
    t_495 = temper.is_string_index(temper.string_indexof(s__1185, "'Hello'"));
    fn__16126 = function()
      return temper.concat('has title value: ', s__1185);
    end;
    temper.test_assert(test_486, t_495, fn__16126);
    t_496 = temper.is_string_index(temper.string_indexof(s__1185, 'DEFAULT'));
    fn__16125 = function()
      return temper.concat('status should use DEFAULT: ', s__1185);
    end;
    temper.test_assert(test_486, t_496, fn__16125);
    return nil;
  end);
end;
Test_.test_toInsertSqlChangeOverridesDefaultValue__2330 = function()
  temper.test('toInsertSql change overrides default value', function(test_497)
    local t_498, t_499, tbl__1187, params__1188, t_500, t_501, cs__1189, local_502, local_503, local_504, s__1190, t_506, fn__16104;
    tbl__1187 = TableDef(csid__703('posts'), temper.listof(FieldDef(csid__703('title'), StringField(), false, temper.null, false), FieldDef(csid__703('status'), StringField(), false, SqlDefault(), false)), temper.null);
    params__1188 = temper.map_constructor(temper.listof(temper.pair_constructor('title', 'Hello'), temper.pair_constructor('status', 'published')));
    t_500 = csid__703('title');
    t_501 = csid__703('status');
    cs__1189 = changeset(tbl__1187, params__1188):cast(temper.listof(t_500, t_501));
    local_502, local_503, local_504 = temper.pcall(function()
      t_498 = cs__1189:toInsertSql();
      t_499 = t_498;
    end);
    if local_502 then
    else
      t_499 = temper.bubble();
    end
    s__1190 = t_499:toString();
    t_506 = temper.is_string_index(temper.string_indexof(s__1190, "'published'"));
    fn__16104 = function()
      return temper.concat('should use provided value: ', s__1190);
    end;
    temper.test_assert(test_497, t_506, fn__16104);
    return nil;
  end);
end;
Test_.test_toInsertSqlWithTimestampsUsesDefault__2331 = function()
  temper.test('toInsertSql with timestamps uses DEFAULT', function(test_510)
    local t_511, t_512, t_513, ts__1192, local_514, local_515, local_516, fields__1193, fn__16070, tbl__1195, params__1196, t_518, cs__1197, local_519, local_520, local_521, s__1198, t_523, fn__16069, t_524, fn__16068, t_525, fn__16067;
    local_514, local_515, local_516 = temper.pcall(function()
      t_511 = timestamps();
      ts__1192 = t_511;
    end);
    if local_514 then
    else
      ts__1192 = temper.bubble();
    end
    fields__1193 = temper.listbuilder_constructor();
    temper.listbuilder_add(fields__1193, FieldDef(csid__703('title'), StringField(), false, temper.null, false));
    fn__16070 = function(t__1194)
      temper.listbuilder_add(fields__1193, t__1194);
      return nil;
    end;
    temper.list_foreach(ts__1192, fn__16070);
    tbl__1195 = TableDef(csid__703('articles'), temper.listbuilder_tolist(fields__1193), temper.null);
    params__1196 = temper.map_constructor(temper.listof(temper.pair_constructor('title', 'News')));
    t_518 = csid__703('title');
    cs__1197 = changeset(tbl__1195, params__1196):cast(temper.listof(t_518));
    local_519, local_520, local_521 = temper.pcall(function()
      t_512 = cs__1197:toInsertSql();
      t_513 = t_512;
    end);
    if local_519 then
    else
      t_513 = temper.bubble();
    end
    s__1198 = t_513:toString();
    t_523 = temper.is_string_index(temper.string_indexof(s__1198, 'inserted_at'));
    fn__16069 = function()
      return temper.concat('should include inserted_at: ', s__1198);
    end;
    temper.test_assert(test_510, t_523, fn__16069);
    t_524 = temper.is_string_index(temper.string_indexof(s__1198, 'updated_at'));
    fn__16068 = function()
      return temper.concat('should include updated_at: ', s__1198);
    end;
    temper.test_assert(test_510, t_524, fn__16068);
    t_525 = temper.is_string_index(temper.string_indexof(s__1198, 'DEFAULT'));
    fn__16067 = function()
      return temper.concat('timestamps should use DEFAULT: ', s__1198);
    end;
    temper.test_assert(test_510, t_525, fn__16067);
    return nil;
  end);
end;
Test_.test_toInsertSqlSkipsVirtualFields__2332 = function()
  temper.test('toInsertSql skips virtual fields', function(test_526)
    local t_527, t_528, tbl__1200, params__1201, t_529, t_530, cs__1202, local_531, local_532, local_533, s__1203, t_535, fn__16041, t_536, fn__16040;
    tbl__1200 = TableDef(csid__703('users'), temper.listof(FieldDef(csid__703('name'), StringField(), false, temper.null, false), FieldDef(csid__703('full_name'), StringField(), true, temper.null, true)), temper.null);
    params__1201 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice'), temper.pair_constructor('full_name', 'Alice Smith')));
    t_529 = csid__703('name');
    t_530 = csid__703('full_name');
    cs__1202 = changeset(tbl__1200, params__1201):cast(temper.listof(t_529, t_530));
    local_531, local_532, local_533 = temper.pcall(function()
      t_527 = cs__1202:toInsertSql();
      t_528 = t_527;
    end);
    if local_531 then
    else
      t_528 = temper.bubble();
    end
    s__1203 = t_528:toString();
    t_535 = temper.is_string_index(temper.string_indexof(s__1203, "'Alice'"));
    fn__16041 = function()
      return temper.concat('name should be included: ', s__1203);
    end;
    temper.test_assert(test_526, t_535, fn__16041);
    t_536 = not temper.is_string_index(temper.string_indexof(s__1203, 'full_name'));
    fn__16040 = function()
      return temper.concat('virtual field should be excluded: ', s__1203);
    end;
    temper.test_assert(test_526, t_536, fn__16040);
    return nil;
  end);
end;
Test_.test_toInsertSqlAllowsMissingNonNullableVirtualField__2333 = function()
  temper.test('toInsertSql allows missing non-nullable virtual field', function(test_537)
    local t_538, t_539, tbl__1205, params__1206, t_540, cs__1207, local_541, local_542, local_543, s__1208, t_545, fn__16022;
    tbl__1205 = TableDef(csid__703('users'), temper.listof(FieldDef(csid__703('name'), StringField(), false, temper.null, false), FieldDef(csid__703('computed'), StringField(), false, temper.null, true)), temper.null);
    params__1206 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice')));
    t_540 = csid__703('name');
    cs__1207 = changeset(tbl__1205, params__1206):cast(temper.listof(t_540));
    local_541, local_542, local_543 = temper.pcall(function()
      t_538 = cs__1207:toInsertSql();
      t_539 = t_538;
    end);
    if local_541 then
    else
      t_539 = temper.bubble();
    end
    s__1208 = t_539:toString();
    t_545 = temper.is_string_index(temper.string_indexof(s__1208, "'Alice'"));
    fn__16022 = function()
      return temper.concat('should succeed: ', s__1208);
    end;
    temper.test_assert(test_537, t_545, fn__16022);
    return nil;
  end);
end;
Test_.test_toUpdateSqlSkipsVirtualFields__2334 = function()
  temper.test('toUpdateSql skips virtual fields', function(test_546)
    local t_547, t_548, tbl__1210, params__1211, t_549, t_550, cs__1212, local_551, local_552, local_553, s__1213, t_555, fn__15997, t_556, fn__15996;
    tbl__1210 = TableDef(csid__703('users'), temper.listof(FieldDef(csid__703('name'), StringField(), false, temper.null, false), FieldDef(csid__703('display'), StringField(), true, temper.null, true)), temper.null);
    params__1211 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Bob'), temper.pair_constructor('display', 'Bobby')));
    t_549 = csid__703('name');
    t_550 = csid__703('display');
    cs__1212 = changeset(tbl__1210, params__1211):cast(temper.listof(t_549, t_550));
    local_551, local_552, local_553 = temper.pcall(function()
      t_547 = cs__1212:toUpdateSql(1);
      t_548 = t_547;
    end);
    if local_551 then
    else
      t_548 = temper.bubble();
    end
    s__1213 = t_548:toString();
    t_555 = temper.is_string_index(temper.string_indexof(s__1213, "name = 'Bob'"));
    fn__15997 = function()
      return temper.concat('name should be in SET: ', s__1213);
    end;
    temper.test_assert(test_546, t_555, fn__15997);
    t_556 = not temper.is_string_index(temper.string_indexof(s__1213, 'display'));
    fn__15996 = function()
      return temper.concat('virtual field excluded from UPDATE: ', s__1213);
    end;
    temper.test_assert(test_546, t_556, fn__15996);
    return nil;
  end);
end;
Test_.test_toUpdateSqlUsesCustomPrimaryKey__2335 = function()
  temper.test('toUpdateSql uses custom primary key', function(test_557)
    local t_558, t_559, tbl__1215, params__1216, t_560, cs__1217, local_561, local_562, local_563, s__1218, t_565, fn__15980;
    tbl__1215 = TableDef(csid__703('posts'), temper.listof(FieldDef(csid__703('title'), StringField(), false, temper.null, false)), csid__703('post_id'));
    params__1216 = temper.map_constructor(temper.listof(temper.pair_constructor('title', 'Updated')));
    t_560 = csid__703('title');
    cs__1217 = changeset(tbl__1215, params__1216):cast(temper.listof(t_560));
    local_561, local_562, local_563 = temper.pcall(function()
      t_558 = cs__1217:toUpdateSql(99);
      t_559 = t_558;
    end);
    if local_561 then
    else
      t_559 = temper.bubble();
    end
    s__1218 = t_559:toString();
    t_565 = temper.str_eq(s__1218, "UPDATE posts SET title = 'Updated' WHERE post_id = 99");
    fn__15980 = function()
      return temper.concat('got: ', s__1218);
    end;
    temper.test_assert(test_557, t_565, fn__15980);
    return nil;
  end);
end;
Test_.test_deleteSqlUsesCustomPrimaryKey__2336 = function()
  temper.test('deleteSql uses custom primary key', function(test_566)
    local tbl__1220, s__1221, t_567, fn__15956;
    tbl__1220 = TableDef(csid__703('posts'), temper.listof(FieldDef(csid__703('title'), StringField(), false, temper.null, false)), csid__703('post_id'));
    s__1221 = deleteSql(tbl__1220, 42):toString();
    t_567 = temper.str_eq(s__1221, 'DELETE FROM posts WHERE post_id = 42');
    fn__15956 = function()
      return temper.concat('got: ', s__1221);
    end;
    temper.test_assert(test_566, t_567, fn__15956);
    return nil;
  end);
end;
Test_.test_deleteSqlUsesDefaultIdWhenPrimaryKeyNull__2337 = function()
  temper.test('deleteSql uses default id when primaryKey null', function(test_568)
    local tbl__1223, s__1224, t_569, fn__15945;
    tbl__1223 = TableDef(csid__703('users'), temper.listof(FieldDef(csid__703('name'), StringField(), false, temper.null, false)), temper.null);
    s__1224 = deleteSql(tbl__1223, 7):toString();
    t_569 = temper.str_eq(s__1224, 'DELETE FROM users WHERE id = 7');
    fn__15945 = function()
      return temper.concat('got: ', s__1224);
    end;
    temper.test_assert(test_568, t_569, fn__15945);
    return nil;
  end);
end;
Test_.test_alreadyInvalidChangesetSkipsSubsequentValidators__2338 = function()
  temper.test('already-invalid changeset skips subsequent validators', function(test_570)
    local params__1226, t_571, t_572, t_573, cs__1227, t_574, fn__15915, t_575, fn__15914, t_576, fn__15913;
    params__1226 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'A'), temper.pair_constructor('email', 'alice@example.com')));
    t_571 = userTable__704();
    t_572 = csid__703('name');
    t_573 = csid__703('email');
    cs__1227 = changeset(t_571, params__1226):cast(temper.listof(t_572, t_573)):validateLength(csid__703('name'), 3, 50):validateRequired(temper.listof(csid__703('name'), csid__703('email'))):validateContains(csid__703('email'), '@');
    t_574 = not cs__1227.isValid;
    fn__15915 = function()
      return 'should be invalid from validateLength';
    end;
    temper.test_assert(test_570, t_574, fn__15915);
    t_575 = (temper.list_length(cs__1227.errors) == 1);
    fn__15914 = function()
      return temper.concat('should have exactly 1 error, not accumulate: ', temper.int32_tostring(temper.list_length(cs__1227.errors)));
    end;
    temper.test_assert(test_570, t_575, fn__15914);
    t_576 = temper.str_eq((temper.list_get(cs__1227.errors, 0)).field, 'name');
    fn__15913 = function()
      return 'error should be on name';
    end;
    temper.test_assert(test_570, t_576, fn__15913);
    return nil;
  end);
end;
Test_.test_validateNumberLessThanOrEqualPassesAtBoundary__2339 = function()
  temper.test('validateNumber lessThanOrEqual passes at boundary', function(test_577)
    local params__1229, t_578, t_579, cs__1230, t_580, fn__15898;
    params__1229 = temper.map_constructor(temper.listof(temper.pair_constructor('score', '10.0')));
    t_578 = userTable__704();
    t_579 = csid__703('score');
    cs__1230 = changeset(t_578, params__1229):cast(temper.listof(t_579)):validateNumber(csid__703('score'), NumberValidationOpts(temper.null, temper.null, temper.null, 10.0, temper.null));
    t_580 = cs__1230.isValid;
    fn__15898 = function()
      return '10.0 <= 10.0 should pass';
    end;
    temper.test_assert(test_577, t_580, fn__15898);
    return nil;
  end);
end;
Test_.test_validateNumberLessThanOrEqualFailsAboveBoundary__2340 = function()
  temper.test('validateNumber lessThanOrEqual fails above boundary', function(test_581)
    local params__1232, t_582, t_583, cs__1233, t_584, fn__15879, t_585, fn__15878;
    params__1232 = temper.map_constructor(temper.listof(temper.pair_constructor('score', '10.1')));
    t_582 = userTable__704();
    t_583 = csid__703('score');
    cs__1233 = changeset(t_582, params__1232):cast(temper.listof(t_583)):validateNumber(csid__703('score'), NumberValidationOpts(temper.null, temper.null, temper.null, 10.0, temper.null));
    t_584 = not cs__1233.isValid;
    fn__15879 = function()
      return '10.1 <= 10.0 should fail';
    end;
    temper.test_assert(test_581, t_584, fn__15879);
    t_585 = temper.str_eq((temper.list_get(cs__1233.errors, 0)).message, 'must be less than or equal to 10.0');
    fn__15878 = function()
      return 'correct message';
    end;
    temper.test_assert(test_581, t_585, fn__15878);
    return nil;
  end);
end;
Test_.test_validateNumberEqualToPassesWhenEqual__2341 = function()
  temper.test('validateNumber equalTo passes when equal', function(test_586)
    local params__1235, t_587, t_588, cs__1236, t_589, fn__15866;
    params__1235 = temper.map_constructor(temper.listof(temper.pair_constructor('score', '42.0')));
    t_587 = userTable__704();
    t_588 = csid__703('score');
    cs__1236 = changeset(t_587, params__1235):cast(temper.listof(t_588)):validateNumber(csid__703('score'), NumberValidationOpts(temper.null, temper.null, temper.null, temper.null, 42.0));
    t_589 = cs__1236.isValid;
    fn__15866 = function()
      return '42.0 == 42.0 should pass';
    end;
    temper.test_assert(test_586, t_589, fn__15866);
    return nil;
  end);
end;
Test_.test_validateNumberEqualToFailsWhenNotEqual__2342 = function()
  temper.test('validateNumber equalTo fails when not equal', function(test_590)
    local params__1238, t_591, t_592, cs__1239, t_593, fn__15847, t_594, fn__15846;
    params__1238 = temper.map_constructor(temper.listof(temper.pair_constructor('score', '41.9')));
    t_591 = userTable__704();
    t_592 = csid__703('score');
    cs__1239 = changeset(t_591, params__1238):cast(temper.listof(t_592)):validateNumber(csid__703('score'), NumberValidationOpts(temper.null, temper.null, temper.null, temper.null, 42.0));
    t_593 = not cs__1239.isValid;
    fn__15847 = function()
      return '41.9 == 42.0 should fail';
    end;
    temper.test_assert(test_590, t_593, fn__15847);
    t_594 = temper.str_eq((temper.list_get(cs__1239.errors, 0)).message, 'must be equal to 42.0');
    fn__15846 = function()
      return 'correct message';
    end;
    temper.test_assert(test_590, t_594, fn__15846);
    return nil;
  end);
end;
Test_.test_validateNumberGreaterThanFailsAtExactThreshold__2343 = function()
  temper.test('validateNumber greaterThan fails at exact threshold', function(test_595)
    local params__1241, t_596, t_597, cs__1242, t_598, fn__15833;
    params__1241 = temper.map_constructor(temper.listof(temper.pair_constructor('age', '18')));
    t_596 = userTable__704();
    t_597 = csid__703('age');
    cs__1242 = changeset(t_596, params__1241):cast(temper.listof(t_597)):validateNumber(csid__703('age'), NumberValidationOpts(18.0, temper.null, temper.null, temper.null, temper.null));
    t_598 = not cs__1242.isValid;
    fn__15833 = function()
      return '18 > 18 should fail (strict greater than)';
    end;
    temper.test_assert(test_595, t_598, fn__15833);
    return nil;
  end);
end;
Test_.test_validateNumberLessThanFailsAtExactThreshold__2344 = function()
  temper.test('validateNumber lessThan fails at exact threshold', function(test_599)
    local params__1244, t_600, t_601, cs__1245, t_602, fn__15820;
    params__1244 = temper.map_constructor(temper.listof(temper.pair_constructor('score', '10.0')));
    t_600 = userTable__704();
    t_601 = csid__703('score');
    cs__1245 = changeset(t_600, params__1244):cast(temper.listof(t_601)):validateNumber(csid__703('score'), NumberValidationOpts(temper.null, 10.0, temper.null, temper.null, temper.null));
    t_602 = not cs__1245.isValid;
    fn__15820 = function()
      return '10.0 < 10.0 should fail (strict less than)';
    end;
    temper.test_assert(test_599, t_602, fn__15820);
    return nil;
  end);
end;
Test_.test_validateFloatFailsForNonFloatString__2345 = function()
  temper.test('validateFloat fails for non-float string', function(test_603)
    local params__1247, t_604, t_605, cs__1248, t_606, fn__15802, t_607, fn__15801;
    params__1247 = temper.map_constructor(temper.listof(temper.pair_constructor('score', 'abc')));
    t_604 = userTable__704();
    t_605 = csid__703('score');
    cs__1248 = changeset(t_604, params__1247):cast(temper.listof(t_605)):validateFloat(csid__703('score'));
    t_606 = not cs__1248.isValid;
    fn__15802 = function()
      return 'abc should not parse as float';
    end;
    temper.test_assert(test_603, t_606, fn__15802);
    t_607 = temper.str_eq((temper.list_get(cs__1248.errors, 0)).message, 'must be a number');
    fn__15801 = function()
      return 'correct message';
    end;
    temper.test_assert(test_603, t_607, fn__15801);
    return nil;
  end);
end;
Test_.test_toInsertSqlWithAllSixFieldTypes__2346 = function()
  temper.test('toInsertSql with all six field types', function(test_608)
    local t_609, t_610, tbl__1250, params__1251, t_611, t_612, t_613, t_614, t_615, t_616, cs__1252, local_617, local_618, local_619, s__1253, t_621, fn__15741, t_622, fn__15740, t_623, fn__15739, t_624, fn__15738, t_625, fn__15737, t_626, fn__15736;
    tbl__1250 = TableDef(csid__703('records'), temper.listof(FieldDef(csid__703('name'), StringField(), false, temper.null, false), FieldDef(csid__703('count'), IntField(), false, temper.null, false), FieldDef(csid__703('big_id'), Int64Field(), false, temper.null, false), FieldDef(csid__703('rating'), FloatField(), false, temper.null, false), FieldDef(csid__703('active'), BoolField(), false, temper.null, false), FieldDef(csid__703('birthday'), DateField(), false, temper.null, false)), temper.null);
    params__1251 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice'), temper.pair_constructor('count', '42'), temper.pair_constructor('big_id', '9999999999'), temper.pair_constructor('rating', '3.14'), temper.pair_constructor('active', 'true'), temper.pair_constructor('birthday', '2000-01-15')));
    t_611 = csid__703('name');
    t_612 = csid__703('count');
    t_613 = csid__703('big_id');
    t_614 = csid__703('rating');
    t_615 = csid__703('active');
    t_616 = csid__703('birthday');
    cs__1252 = changeset(tbl__1250, params__1251):cast(temper.listof(t_611, t_612, t_613, t_614, t_615, t_616));
    local_617, local_618, local_619 = temper.pcall(function()
      t_609 = cs__1252:toInsertSql();
      t_610 = t_609;
    end);
    if local_617 then
    else
      t_610 = temper.bubble();
    end
    s__1253 = t_610:toString();
    t_621 = temper.is_string_index(temper.string_indexof(s__1253, "'Alice'"));
    fn__15741 = function()
      return temper.concat('string field: ', s__1253);
    end;
    temper.test_assert(test_608, t_621, fn__15741);
    t_622 = temper.is_string_index(temper.string_indexof(s__1253, '42'));
    fn__15740 = function()
      return temper.concat('int field: ', s__1253);
    end;
    temper.test_assert(test_608, t_622, fn__15740);
    t_623 = temper.is_string_index(temper.string_indexof(s__1253, '9999999999'));
    fn__15739 = function()
      return temper.concat('int64 field: ', s__1253);
    end;
    temper.test_assert(test_608, t_623, fn__15739);
    t_624 = temper.is_string_index(temper.string_indexof(s__1253, '3.14'));
    fn__15738 = function()
      return temper.concat('float field: ', s__1253);
    end;
    temper.test_assert(test_608, t_624, fn__15738);
    t_625 = temper.is_string_index(temper.string_indexof(s__1253, 'TRUE'));
    fn__15737 = function()
      return temper.concat('bool field: ', s__1253);
    end;
    temper.test_assert(test_608, t_625, fn__15737);
    t_626 = temper.is_string_index(temper.string_indexof(s__1253, "'2000-01-15'"));
    fn__15736 = function()
      return temper.concat('date field: ', s__1253);
    end;
    temper.test_assert(test_608, t_626, fn__15736);
    return nil;
  end);
end;
Test_.test_deleteChangeOnNonNullableFieldCausesToInsertSqlToBubble__2347 = function()
  temper.test('deleteChange on non-nullable field causes toInsertSql to bubble', function(test_627)
    local tbl__1255, params__1256, t_628, t_629, cs__1257, didBubble__1258, local_630, local_631, local_632, fn__15717;
    tbl__1255 = TableDef(csid__703('users'), temper.listof(FieldDef(csid__703('name'), StringField(), false, temper.null, false), FieldDef(csid__703('email'), StringField(), false, temper.null, false)), temper.null);
    params__1256 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice'), temper.pair_constructor('email', 'a@b.com')));
    t_628 = csid__703('name');
    t_629 = csid__703('email');
    cs__1257 = changeset(tbl__1255, params__1256):cast(temper.listof(t_628, t_629)):deleteChange(csid__703('email'));
    local_630, local_631, local_632 = temper.pcall(function()
      cs__1257:toInsertSql();
      didBubble__1258 = false;
    end);
    if local_630 then
    else
      didBubble__1258 = true;
    end
    fn__15717 = function()
      return 'removing non-nullable field should make toInsertSql bubble';
    end;
    temper.test_assert(test_627, didBubble__1258, fn__15717);
    return nil;
  end);
end;
Test_.test_validateLengthPassesAtExactMin__2348 = function()
  temper.test('validateLength passes at exact min', function(test_634)
    local params__1260, t_635, t_636, cs__1261, t_637, fn__15706;
    params__1260 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'abc')));
    t_635 = userTable__704();
    t_636 = csid__703('name');
    cs__1261 = changeset(t_635, params__1260):cast(temper.listof(t_636)):validateLength(csid__703('name'), 3, 10);
    t_637 = cs__1261.isValid;
    fn__15706 = function()
      return 'length 3 should pass for min 3';
    end;
    temper.test_assert(test_634, t_637, fn__15706);
    return nil;
  end);
end;
Test_.test_validateLengthPassesAtExactMax__2349 = function()
  temper.test('validateLength passes at exact max', function(test_638)
    local params__1263, t_639, t_640, cs__1264, t_641, fn__15695;
    params__1263 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'abcdefghij')));
    t_639 = userTable__704();
    t_640 = csid__703('name');
    cs__1264 = changeset(t_639, params__1263):cast(temper.listof(t_640)):validateLength(csid__703('name'), 1, 10);
    t_641 = cs__1264.isValid;
    fn__15695 = function()
      return 'length 10 should pass for max 10';
    end;
    temper.test_assert(test_638, t_641, fn__15695);
    return nil;
  end);
end;
Test_.test_validateAcceptanceSkipsWhenFieldNotInChanges__2350 = function()
  temper.test('validateAcceptance skips when field not in changes', function(test_642)
    local params__1266, t_643, t_644, cs__1267, t_645, fn__15685;
    params__1266 = temper.map_constructor(temper.listof());
    t_643 = userTable__704();
    t_644 = csid__703('active');
    cs__1267 = changeset(t_643, params__1266):cast(temper.listof(t_644)):validateAcceptance(csid__703('active'));
    t_645 = cs__1267.isValid;
    fn__15685 = function()
      return 'should be valid when field absent';
    end;
    temper.test_assert(test_642, t_645, fn__15685);
    return nil;
  end);
end;
Test_.test_multipleValidatorsChainCorrectlyOnValidChangeset__2351 = function()
  temper.test('multiple validators chain correctly on valid changeset', function(test_646)
    local params__1269, t_647, t_648, t_649, t_650, cs__1270, t_651, fn__15655, t_652, fn__15654;
    params__1269 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice'), temper.pair_constructor('email', 'alice@example.com'), temper.pair_constructor('age', '25')));
    t_647 = userTable__704();
    t_648 = csid__703('name');
    t_649 = csid__703('email');
    t_650 = csid__703('age');
    cs__1270 = changeset(t_647, params__1269):cast(temper.listof(t_648, t_649, t_650)):validateRequired(temper.listof(csid__703('name'), csid__703('email'))):validateLength(csid__703('name'), 2, 50):validateContains(csid__703('email'), '@'):validateInt(csid__703('age')):validateNumber(csid__703('age'), NumberValidationOpts(0.0, 150.0, temper.null, temper.null, temper.null));
    t_651 = cs__1270.isValid;
    fn__15655 = function()
      return 'all validators should pass';
    end;
    temper.test_assert(test_646, t_651, fn__15655);
    t_652 = (temper.list_length(cs__1270.errors) == 0);
    fn__15654 = function()
      return 'no errors expected';
    end;
    temper.test_assert(test_646, t_652, fn__15654);
    return nil;
  end);
end;
Test_.test_toUpdateSqlWithMultipleNonVirtualFields__2352 = function()
  temper.test('toUpdateSql with multiple non-virtual fields', function(test_653)
    local t_654, t_655, tbl__1272, params__1273, t_656, t_657, cs__1274, local_658, local_659, local_660, s__1275, t_662, fn__15626, t_663, fn__15625, t_664, fn__15624;
    tbl__1272 = TableDef(csid__703('users'), temper.listof(FieldDef(csid__703('name'), StringField(), false, temper.null, false), FieldDef(csid__703('email'), StringField(), false, temper.null, false)), temper.null);
    params__1273 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Bob'), temper.pair_constructor('email', 'bob@example.com')));
    t_656 = csid__703('name');
    t_657 = csid__703('email');
    cs__1274 = changeset(tbl__1272, params__1273):cast(temper.listof(t_656, t_657));
    local_658, local_659, local_660 = temper.pcall(function()
      t_654 = cs__1274:toUpdateSql(5);
      t_655 = t_654;
    end);
    if local_658 then
    else
      t_655 = temper.bubble();
    end
    s__1275 = t_655:toString();
    t_662 = temper.is_string_index(temper.string_indexof(s__1275, "name = 'Bob'"));
    fn__15626 = function()
      return temper.concat('name in SET: ', s__1275);
    end;
    temper.test_assert(test_653, t_662, fn__15626);
    t_663 = temper.is_string_index(temper.string_indexof(s__1275, "email = 'bob@example.com'"));
    fn__15625 = function()
      return temper.concat('email in SET: ', s__1275);
    end;
    temper.test_assert(test_653, t_663, fn__15625);
    t_664 = temper.is_string_index(temper.string_indexof(s__1275, 'WHERE id = 5'));
    fn__15624 = function()
      return temper.concat('WHERE clause: ', s__1275);
    end;
    temper.test_assert(test_653, t_664, fn__15624);
    return nil;
  end);
end;
Test_.test_toUpdateSqlBubblesWhenAllChangesAreVirtualFields__2353 = function()
  temper.test('toUpdateSql bubbles when all changes are virtual fields', function(test_665)
    local tbl__1277, params__1278, t_666, cs__1279, didBubble__1280, local_667, local_668, local_669, fn__15608;
    tbl__1277 = TableDef(csid__703('users'), temper.listof(FieldDef(csid__703('name'), StringField(), false, temper.null, false), FieldDef(csid__703('computed'), StringField(), true, temper.null, true)), temper.null);
    params__1278 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice'), temper.pair_constructor('computed', 'derived')));
    t_666 = csid__703('computed');
    cs__1279 = changeset(tbl__1277, params__1278):cast(temper.listof(t_666));
    local_667, local_668, local_669 = temper.pcall(function()
      cs__1279:toUpdateSql(1);
      didBubble__1280 = false;
    end);
    if local_667 then
    else
      didBubble__1280 = true;
    end
    fn__15608 = function()
      return 'should bubble when all changes are virtual';
    end;
    temper.test_assert(test_665, didBubble__1280, fn__15608);
    return nil;
  end);
end;
Test_.test_putChangeSatisfiesSubsequentValidateRequired__2354 = function()
  temper.test('putChange satisfies subsequent validateRequired', function(test_671)
    local params__1282, t_672, t_673, cs__1283, t_674, fn__15596;
    params__1282 = temper.map_constructor(temper.listof());
    t_672 = userTable__704();
    t_673 = csid__703('name');
    cs__1283 = changeset(t_672, params__1282):cast(temper.listof(t_673)):putChange(csid__703('name'), 'Injected'):validateRequired(temper.listof(csid__703('name')));
    t_674 = cs__1283.isValid;
    fn__15596 = function()
      return 'putChange should satisfy required';
    end;
    temper.test_assert(test_671, t_674, fn__15596);
    return nil;
  end);
end;
Test_.test_validateStartsWithSkipsWhenFieldNotInChanges__2355 = function()
  temper.test('validateStartsWith skips when field not in changes', function(test_675)
    local params__1285, t_676, t_677, cs__1286, t_678, fn__15586;
    params__1285 = temper.map_constructor(temper.listof());
    t_676 = userTable__704();
    t_677 = csid__703('name');
    cs__1286 = changeset(t_676, params__1285):cast(temper.listof(t_677)):validateStartsWith(csid__703('name'), 'Dr.');
    t_678 = cs__1286.isValid;
    fn__15586 = function()
      return 'should be valid when field absent';
    end;
    temper.test_assert(test_675, t_678, fn__15586);
    return nil;
  end);
end;
Test_.test_validateEndsWithSkipsWhenFieldNotInChanges__2356 = function()
  temper.test('validateEndsWith skips when field not in changes', function(test_679)
    local params__1288, t_680, t_681, cs__1289, t_682, fn__15576;
    params__1288 = temper.map_constructor(temper.listof());
    t_680 = userTable__704();
    t_681 = csid__703('name');
    cs__1289 = changeset(t_680, params__1288):cast(temper.listof(t_681)):validateEndsWith(csid__703('name'), '.com');
    t_682 = cs__1289.isValid;
    fn__15576 = function()
      return 'should be valid when field absent';
    end;
    temper.test_assert(test_679, t_682, fn__15576);
    return nil;
  end);
end;
Test_.test_validateIntAcceptsZero__2357 = function()
  temper.test('validateInt accepts zero', function(test_683)
    local params__1291, t_684, t_685, cs__1292, t_686, fn__15565;
    params__1291 = temper.map_constructor(temper.listof(temper.pair_constructor('age', '0')));
    t_684 = userTable__704();
    t_685 = csid__703('age');
    cs__1292 = changeset(t_684, params__1291):cast(temper.listof(t_685)):validateInt(csid__703('age'));
    t_686 = cs__1292.isValid;
    fn__15565 = function()
      return '0 should be a valid int';
    end;
    temper.test_assert(test_683, t_686, fn__15565);
    return nil;
  end);
end;
Test_.test_validateIntAcceptsNegative__2358 = function()
  temper.test('validateInt accepts negative', function(test_687)
    local params__1294, t_688, t_689, cs__1295, t_690, fn__15554;
    params__1294 = temper.map_constructor(temper.listof(temper.pair_constructor('age', '-5')));
    t_688 = userTable__704();
    t_689 = csid__703('age');
    cs__1295 = changeset(t_688, params__1294):cast(temper.listof(t_689)):validateInt(csid__703('age'));
    t_690 = cs__1295.isValid;
    fn__15554 = function()
      return '-5 should be a valid int';
    end;
    temper.test_assert(test_687, t_690, fn__15554);
    return nil;
  end);
end;
Test_.test_changesetImmutabilityValidatorsDoNotMutateBase__2359 = function()
  temper.test('changeset immutability - validators do not mutate base', function(test_691)
    local params__1297, t_692, t_693, t_694, base__1298, failed__1299, passed__1300, t_695, fn__15534, t_696, fn__15533;
    params__1297 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'A'), temper.pair_constructor('email', 'alice@example.com')));
    t_692 = userTable__704();
    t_693 = csid__703('name');
    t_694 = csid__703('email');
    base__1298 = changeset(t_692, params__1297):cast(temper.listof(t_693, t_694));
    failed__1299 = base__1298:validateLength(csid__703('name'), 3, 50);
    passed__1300 = base__1298:validateRequired(temper.listof(csid__703('name'), csid__703('email')));
    t_695 = not failed__1299.isValid;
    fn__15534 = function()
      return 'failed branch should be invalid';
    end;
    temper.test_assert(test_691, t_695, fn__15534);
    t_696 = passed__1300.isValid;
    fn__15533 = function()
      return 'passed branch should still be valid';
    end;
    temper.test_assert(test_691, t_696, fn__15533);
    return nil;
  end);
end;
sid__709 = function(name__1650)
  local return__617, t_709, local_710, local_711, local_712;
  local_710, local_711, local_712 = temper.pcall(function()
    t_709 = safeIdentifier(name__1650);
    return__617 = t_709;
  end);
  if local_710 then
  else
    return__617 = temper.bubble();
  end
  return return__617;
end;
Test_.test_bareFromProducesSelect__2441 = function()
  temper.test('bare from produces SELECT *', function(test_714)
    local q__1653, t_715, fn__15086;
    q__1653 = from(sid__709('users'));
    t_715 = temper.str_eq(q__1653:toSql():toString(), 'SELECT * FROM users');
    fn__15086 = function()
      return 'bare query';
    end;
    temper.test_assert(test_714, t_715, fn__15086);
    return nil;
  end);
end;
Test_.test_selectRestrictsColumns__2442 = function()
  temper.test('select restricts columns', function(test_716)
    local t_717, t_718, t_719, q__1655, t_720, fn__15076;
    t_717 = sid__709('users');
    t_718 = sid__709('id');
    t_719 = sid__709('name');
    q__1655 = from(t_717):select(temper.listof(t_718, t_719));
    t_720 = temper.str_eq(q__1655:toSql():toString(), 'SELECT id, name FROM users');
    fn__15076 = function()
      return 'select columns';
    end;
    temper.test_assert(test_716, t_720, fn__15076);
    return nil;
  end);
end;
Test_.test_whereAddsConditionWithIntValue__2443 = function()
  temper.test('where adds condition with int value', function(test_721)
    local t_722, t_723, t_724, q__1657, t_725, fn__15064;
    t_722 = sid__709('users');
    t_723 = SqlBuilder();
    t_723:appendSafe('age > ');
    t_723:appendInt32(18);
    t_724 = t_723.accumulated;
    q__1657 = from(t_722):where(t_724);
    t_725 = temper.str_eq(q__1657:toSql():toString(), 'SELECT * FROM users WHERE age > 18');
    fn__15064 = function()
      return 'where int';
    end;
    temper.test_assert(test_721, t_725, fn__15064);
    return nil;
  end);
end;
Test_.test_whereAddsConditionWithBoolValue__2445 = function()
  temper.test('where adds condition with bool value', function(test_726)
    local t_727, t_728, t_729, q__1659, t_730, fn__15052;
    t_727 = sid__709('users');
    t_728 = SqlBuilder();
    t_728:appendSafe('active = ');
    t_728:appendBoolean(true);
    t_729 = t_728.accumulated;
    q__1659 = from(t_727):where(t_729);
    t_730 = temper.str_eq(q__1659:toSql():toString(), 'SELECT * FROM users WHERE active = TRUE');
    fn__15052 = function()
      return 'where bool';
    end;
    temper.test_assert(test_726, t_730, fn__15052);
    return nil;
  end);
end;
Test_.test_chainedWhereUsesAnd__2447 = function()
  temper.test('chained where uses AND', function(test_731)
    local t_732, t_733, t_734, t_735, t_736, q__1661, t_737, fn__15035;
    t_732 = sid__709('users');
    t_733 = SqlBuilder();
    t_733:appendSafe('age > ');
    t_733:appendInt32(18);
    t_734 = t_733.accumulated;
    t_735 = from(t_732):where(t_734);
    t_736 = SqlBuilder();
    t_736:appendSafe('active = ');
    t_736:appendBoolean(true);
    q__1661 = t_735:where(t_736.accumulated);
    t_737 = temper.str_eq(q__1661:toSql():toString(), 'SELECT * FROM users WHERE age > 18 AND active = TRUE');
    fn__15035 = function()
      return 'chained where';
    end;
    temper.test_assert(test_731, t_737, fn__15035);
    return nil;
  end);
end;
Test_.test_orderByAsc__2450 = function()
  temper.test('orderBy ASC', function(test_738)
    local t_739, t_740, q__1663, t_741, fn__15026;
    t_739 = sid__709('users');
    t_740 = sid__709('name');
    q__1663 = from(t_739):orderBy(t_740, true);
    t_741 = temper.str_eq(q__1663:toSql():toString(), 'SELECT * FROM users ORDER BY name ASC');
    fn__15026 = function()
      return 'order asc';
    end;
    temper.test_assert(test_738, t_741, fn__15026);
    return nil;
  end);
end;
Test_.test_orderByDesc__2451 = function()
  temper.test('orderBy DESC', function(test_742)
    local t_743, t_744, q__1665, t_745, fn__15017;
    t_743 = sid__709('users');
    t_744 = sid__709('created_at');
    q__1665 = from(t_743):orderBy(t_744, false);
    t_745 = temper.str_eq(q__1665:toSql():toString(), 'SELECT * FROM users ORDER BY created_at DESC');
    fn__15017 = function()
      return 'order desc';
    end;
    temper.test_assert(test_742, t_745, fn__15017);
    return nil;
  end);
end;
Test_.test_limitAndOffset__2452 = function()
  temper.test('limit and offset', function(test_746)
    local t_747, t_748, q__1667, local_749, local_750, local_751, t_753, fn__15010;
    local_749, local_750, local_751 = temper.pcall(function()
      t_747 = from(sid__709('users')):limit(10);
      t_748 = t_747:offset(20);
      q__1667 = t_748;
    end);
    if local_749 then
    else
      q__1667 = temper.bubble();
    end
    t_753 = temper.str_eq(q__1667:toSql():toString(), 'SELECT * FROM users LIMIT 10 OFFSET 20');
    fn__15010 = function()
      return 'limit/offset';
    end;
    temper.test_assert(test_746, t_753, fn__15010);
    return nil;
  end);
end;
Test_.test_limitBubblesOnNegative__2453 = function()
  temper.test('limit bubbles on negative', function(test_754)
    local didBubble__1669, local_755, local_756, local_757, fn__15006;
    local_755, local_756, local_757 = temper.pcall(function()
      from(sid__709('users')):limit(-1);
      didBubble__1669 = false;
    end);
    if local_755 then
    else
      didBubble__1669 = true;
    end
    fn__15006 = function()
      return 'negative limit should bubble';
    end;
    temper.test_assert(test_754, didBubble__1669, fn__15006);
    return nil;
  end);
end;
Test_.test_offsetBubblesOnNegative__2454 = function()
  temper.test('offset bubbles on negative', function(test_759)
    local didBubble__1671, local_760, local_761, local_762, fn__15002;
    local_760, local_761, local_762 = temper.pcall(function()
      from(sid__709('users')):offset(-1);
      didBubble__1671 = false;
    end);
    if local_760 then
    else
      didBubble__1671 = true;
    end
    fn__15002 = function()
      return 'negative offset should bubble';
    end;
    temper.test_assert(test_759, didBubble__1671, fn__15002);
    return nil;
  end);
end;
Test_.test_complexComposedQuery__2455 = function()
  temper.test('complex composed query', function(test_764)
    local t_765, t_766, t_767, t_768, t_769, t_770, t_771, t_772, t_773, t_774, minAge__1673, q__1674, local_775, local_776, local_777, t_779, fn__14979;
    minAge__1673 = 21;
    local_775, local_776, local_777 = temper.pcall(function()
      t_765 = sid__709('users');
      t_766 = sid__709('id');
      t_767 = sid__709('name');
      t_768 = sid__709('email');
      t_769 = from(t_765):select(temper.listof(t_766, t_767, t_768));
      t_770 = SqlBuilder();
      t_770:appendSafe('age >= ');
      t_770:appendInt32(21);
      t_771 = t_769:where(t_770.accumulated);
      t_772 = SqlBuilder();
      t_772:appendSafe('active = ');
      t_772:appendBoolean(true);
      t_773 = t_771:where(t_772.accumulated):orderBy(sid__709('name'), true):limit(25);
      t_774 = t_773:offset(0);
      q__1674 = t_774;
    end);
    if local_775 then
    else
      q__1674 = temper.bubble();
    end
    t_779 = temper.str_eq(q__1674:toSql():toString(), 'SELECT id, name, email FROM users WHERE age >= 21 AND active = TRUE ORDER BY name ASC LIMIT 25 OFFSET 0');
    fn__14979 = function()
      return 'complex query';
    end;
    temper.test_assert(test_764, t_779, fn__14979);
    return nil;
  end);
end;
Test_.test_safeToSqlAppliesDefaultLimitWhenNoneSet__2458 = function()
  temper.test('safeToSql applies default limit when none set', function(test_780)
    local t_781, t_782, q__1676, local_783, local_784, local_785, s__1677, t_787, fn__14973;
    q__1676 = from(sid__709('users'));
    local_783, local_784, local_785 = temper.pcall(function()
      t_781 = q__1676:safeToSql(100);
      t_782 = t_781;
    end);
    if local_783 then
    else
      t_782 = temper.bubble();
    end
    s__1677 = t_782:toString();
    t_787 = temper.str_eq(s__1677, 'SELECT * FROM users LIMIT 100');
    fn__14973 = function()
      return temper.concat('should have limit: ', s__1677);
    end;
    temper.test_assert(test_780, t_787, fn__14973);
    return nil;
  end);
end;
Test_.test_safeToSqlRespectsExplicitLimit__2459 = function()
  temper.test('safeToSql respects explicit limit', function(test_788)
    local t_789, t_790, t_791, q__1679, local_792, local_793, local_794, local_796, local_797, local_798, s__1680, t_800, fn__14967;
    local_792, local_793, local_794 = temper.pcall(function()
      t_789 = from(sid__709('users')):limit(5);
      q__1679 = t_789;
    end);
    if local_792 then
    else
      q__1679 = temper.bubble();
    end
    local_796, local_797, local_798 = temper.pcall(function()
      t_790 = q__1679:safeToSql(100);
      t_791 = t_790;
    end);
    if local_796 then
    else
      t_791 = temper.bubble();
    end
    s__1680 = t_791:toString();
    t_800 = temper.str_eq(s__1680, 'SELECT * FROM users LIMIT 5');
    fn__14967 = function()
      return temper.concat('explicit limit preserved: ', s__1680);
    end;
    temper.test_assert(test_788, t_800, fn__14967);
    return nil;
  end);
end;
Test_.test_safeToSqlBubblesOnNegativeDefaultLimit__2460 = function()
  temper.test('safeToSql bubbles on negative defaultLimit', function(test_801)
    local didBubble__1682, local_802, local_803, local_804, fn__14963;
    local_802, local_803, local_804 = temper.pcall(function()
      from(sid__709('users')):safeToSql(-1);
      didBubble__1682 = false;
    end);
    if local_802 then
    else
      didBubble__1682 = true;
    end
    fn__14963 = function()
      return 'negative defaultLimit should bubble';
    end;
    temper.test_assert(test_801, didBubble__1682, fn__14963);
    return nil;
  end);
end;
Test_.test_whereWithInjectionAttemptInStringValueIsEscaped__2461 = function()
  temper.test('where with injection attempt in string value is escaped', function(test_806)
    local evil__1684, t_807, t_808, t_809, q__1685, s__1686, t_810, fn__14946, t_811, fn__14945;
    evil__1684 = "'; DROP TABLE users; --";
    t_807 = sid__709('users');
    t_808 = SqlBuilder();
    t_808:appendSafe('name = ');
    t_808:appendString("'; DROP TABLE users; --");
    t_809 = t_808.accumulated;
    q__1685 = from(t_807):where(t_809);
    s__1686 = q__1685:toSql():toString();
    t_810 = temper.is_string_index(temper.string_indexof(s__1686, "''"));
    fn__14946 = function()
      return temper.concat('quotes must be doubled: ', s__1686);
    end;
    temper.test_assert(test_806, t_810, fn__14946);
    t_811 = temper.is_string_index(temper.string_indexof(s__1686, 'SELECT * FROM users WHERE name ='));
    fn__14945 = function()
      return temper.concat('structure intact: ', s__1686);
    end;
    temper.test_assert(test_806, t_811, fn__14945);
    return nil;
  end);
end;
Test_.test_safeIdentifierRejectsUserSuppliedTableNameWithMetacharacters__2463 = function()
  temper.test('safeIdentifier rejects user-supplied table name with metacharacters', function(test_812)
    local attack__1688, didBubble__1689, local_813, local_814, local_815, fn__14942;
    attack__1688 = 'users; DROP TABLE users; --';
    local_813, local_814, local_815 = temper.pcall(function()
      safeIdentifier('users; DROP TABLE users; --');
      didBubble__1689 = false;
    end);
    if local_813 then
    else
      didBubble__1689 = true;
    end
    fn__14942 = function()
      return 'metacharacter-containing name must be rejected at construction';
    end;
    temper.test_assert(test_812, didBubble__1689, fn__14942);
    return nil;
  end);
end;
Test_.test_innerJoinProducesInnerJoin__2464 = function()
  temper.test('innerJoin produces INNER JOIN', function(test_817)
    local t_818, t_819, t_820, t_821, q__1691, t_822, fn__14930;
    t_818 = sid__709('users');
    t_819 = sid__709('orders');
    t_820 = SqlBuilder();
    t_820:appendSafe('users.id = orders.user_id');
    t_821 = t_820.accumulated;
    q__1691 = from(t_818):innerJoin(t_819, t_821);
    t_822 = temper.str_eq(q__1691:toSql():toString(), 'SELECT * FROM users INNER JOIN orders ON users.id = orders.user_id');
    fn__14930 = function()
      return 'inner join';
    end;
    temper.test_assert(test_817, t_822, fn__14930);
    return nil;
  end);
end;
Test_.test_leftJoinProducesLeftJoin__2466 = function()
  temper.test('leftJoin produces LEFT JOIN', function(test_823)
    local t_824, t_825, t_826, t_827, q__1693, t_828, fn__14918;
    t_824 = sid__709('users');
    t_825 = sid__709('profiles');
    t_826 = SqlBuilder();
    t_826:appendSafe('users.id = profiles.user_id');
    t_827 = t_826.accumulated;
    q__1693 = from(t_824):leftJoin(t_825, t_827);
    t_828 = temper.str_eq(q__1693:toSql():toString(), 'SELECT * FROM users LEFT JOIN profiles ON users.id = profiles.user_id');
    fn__14918 = function()
      return 'left join';
    end;
    temper.test_assert(test_823, t_828, fn__14918);
    return nil;
  end);
end;
Test_.test_rightJoinProducesRightJoin__2468 = function()
  temper.test('rightJoin produces RIGHT JOIN', function(test_829)
    local t_830, t_831, t_832, t_833, q__1695, t_834, fn__14906;
    t_830 = sid__709('orders');
    t_831 = sid__709('users');
    t_832 = SqlBuilder();
    t_832:appendSafe('orders.user_id = users.id');
    t_833 = t_832.accumulated;
    q__1695 = from(t_830):rightJoin(t_831, t_833);
    t_834 = temper.str_eq(q__1695:toSql():toString(), 'SELECT * FROM orders RIGHT JOIN users ON orders.user_id = users.id');
    fn__14906 = function()
      return 'right join';
    end;
    temper.test_assert(test_829, t_834, fn__14906);
    return nil;
  end);
end;
Test_.test_fullJoinProducesFullOuterJoin__2470 = function()
  temper.test('fullJoin produces FULL OUTER JOIN', function(test_835)
    local t_836, t_837, t_838, t_839, q__1697, t_840, fn__14894;
    t_836 = sid__709('users');
    t_837 = sid__709('orders');
    t_838 = SqlBuilder();
    t_838:appendSafe('users.id = orders.user_id');
    t_839 = t_838.accumulated;
    q__1697 = from(t_836):fullJoin(t_837, t_839);
    t_840 = temper.str_eq(q__1697:toSql():toString(), 'SELECT * FROM users FULL OUTER JOIN orders ON users.id = orders.user_id');
    fn__14894 = function()
      return 'full join';
    end;
    temper.test_assert(test_835, t_840, fn__14894);
    return nil;
  end);
end;
Test_.test_chainedJoins__2472 = function()
  temper.test('chained joins', function(test_841)
    local t_842, t_843, t_844, t_845, t_846, t_847, t_848, q__1699, t_849, fn__14877;
    t_842 = sid__709('users');
    t_843 = sid__709('orders');
    t_844 = SqlBuilder();
    t_844:appendSafe('users.id = orders.user_id');
    t_845 = t_844.accumulated;
    t_846 = from(t_842):innerJoin(t_843, t_845);
    t_847 = sid__709('profiles');
    t_848 = SqlBuilder();
    t_848:appendSafe('users.id = profiles.user_id');
    q__1699 = t_846:leftJoin(t_847, t_848.accumulated);
    t_849 = temper.str_eq(q__1699:toSql():toString(), 'SELECT * FROM users INNER JOIN orders ON users.id = orders.user_id LEFT JOIN profiles ON users.id = profiles.user_id');
    fn__14877 = function()
      return 'chained joins';
    end;
    temper.test_assert(test_841, t_849, fn__14877);
    return nil;
  end);
end;
Test_.test_joinWithWhereAndOrderBy__2475 = function()
  temper.test('join with where and orderBy', function(test_850)
    local t_851, t_852, t_853, t_854, t_855, t_856, t_857, q__1701, local_858, local_859, local_860, t_862, fn__14858;
    local_858, local_859, local_860 = temper.pcall(function()
      t_851 = sid__709('users');
      t_852 = sid__709('orders');
      t_853 = SqlBuilder();
      t_853:appendSafe('users.id = orders.user_id');
      t_854 = t_853.accumulated;
      t_855 = from(t_851):innerJoin(t_852, t_854);
      t_856 = SqlBuilder();
      t_856:appendSafe('orders.total > ');
      t_856:appendInt32(100);
      t_857 = t_855:where(t_856.accumulated):orderBy(sid__709('name'), true):limit(10);
      q__1701 = t_857;
    end);
    if local_858 then
    else
      q__1701 = temper.bubble();
    end
    t_862 = temper.str_eq(q__1701:toSql():toString(), 'SELECT * FROM users INNER JOIN orders ON users.id = orders.user_id WHERE orders.total > 100 ORDER BY name ASC LIMIT 10');
    fn__14858 = function()
      return 'join with where/order/limit';
    end;
    temper.test_assert(test_850, t_862, fn__14858);
    return nil;
  end);
end;
Test_.test_colHelperProducesQualifiedReference__2478 = function()
  temper.test('col helper produces qualified reference', function(test_863)
    local c__1703, t_864, fn__14850;
    c__1703 = col(sid__709('users'), sid__709('id'));
    t_864 = temper.str_eq(c__1703:toString(), 'users.id');
    fn__14850 = function()
      return 'col helper';
    end;
    temper.test_assert(test_863, t_864, fn__14850);
    return nil;
  end);
end;
Test_.test_joinWithColHelper__2479 = function()
  temper.test('join with col helper', function(test_865)
    local onCond__1705, b__1706, t_866, t_867, t_868, q__1707, t_869, fn__14830;
    onCond__1705 = col(sid__709('users'), sid__709('id'));
    b__1706 = SqlBuilder();
    b__1706:appendFragment(onCond__1705);
    b__1706:appendSafe(' = ');
    b__1706:appendFragment(col(sid__709('orders'), sid__709('user_id')));
    t_866 = sid__709('users');
    t_867 = sid__709('orders');
    t_868 = b__1706.accumulated;
    q__1707 = from(t_866):innerJoin(t_867, t_868);
    t_869 = temper.str_eq(q__1707:toSql():toString(), 'SELECT * FROM users INNER JOIN orders ON users.id = orders.user_id');
    fn__14830 = function()
      return 'join with col';
    end;
    temper.test_assert(test_865, t_869, fn__14830);
    return nil;
  end);
end;
Test_.test_orWhereBasic__2480 = function()
  temper.test('orWhere basic', function(test_870)
    local t_871, t_872, t_873, q__1709, t_874, fn__14818;
    t_871 = sid__709('users');
    t_872 = SqlBuilder();
    t_872:appendSafe('status = ');
    t_872:appendString('active');
    t_873 = t_872.accumulated;
    q__1709 = from(t_871):orWhere(t_873);
    t_874 = temper.str_eq(q__1709:toSql():toString(), "SELECT * FROM users WHERE status = 'active'");
    fn__14818 = function()
      return 'orWhere basic';
    end;
    temper.test_assert(test_870, t_874, fn__14818);
    return nil;
  end);
end;
Test_.test_whereThenOrWhere__2482 = function()
  temper.test('where then orWhere', function(test_875)
    local t_876, t_877, t_878, t_879, t_880, q__1711, t_881, fn__14801;
    t_876 = sid__709('users');
    t_877 = SqlBuilder();
    t_877:appendSafe('age > ');
    t_877:appendInt32(18);
    t_878 = t_877.accumulated;
    t_879 = from(t_876):where(t_878);
    t_880 = SqlBuilder();
    t_880:appendSafe('vip = ');
    t_880:appendBoolean(true);
    q__1711 = t_879:orWhere(t_880.accumulated);
    t_881 = temper.str_eq(q__1711:toSql():toString(), 'SELECT * FROM users WHERE age > 18 OR vip = TRUE');
    fn__14801 = function()
      return 'where then orWhere';
    end;
    temper.test_assert(test_875, t_881, fn__14801);
    return nil;
  end);
end;
Test_.test_multipleOrWhere__2485 = function()
  temper.test('multiple orWhere', function(test_882)
    local t_883, t_884, t_885, t_886, t_887, t_888, t_889, q__1713, t_890, fn__14779;
    t_883 = sid__709('users');
    t_884 = SqlBuilder();
    t_884:appendSafe('active = ');
    t_884:appendBoolean(true);
    t_885 = t_884.accumulated;
    t_886 = from(t_883):where(t_885);
    t_887 = SqlBuilder();
    t_887:appendSafe('role = ');
    t_887:appendString('admin');
    t_888 = t_886:orWhere(t_887.accumulated);
    t_889 = SqlBuilder();
    t_889:appendSafe('role = ');
    t_889:appendString('moderator');
    q__1713 = t_888:orWhere(t_889.accumulated);
    t_890 = temper.str_eq(q__1713:toSql():toString(), "SELECT * FROM users WHERE active = TRUE OR role = 'admin' OR role = 'moderator'");
    fn__14779 = function()
      return 'multiple orWhere';
    end;
    temper.test_assert(test_882, t_890, fn__14779);
    return nil;
  end);
end;
Test_.test_mixedWhereAndOrWhere__2489 = function()
  temper.test('mixed where and orWhere', function(test_891)
    local t_892, t_893, t_894, t_895, t_896, t_897, t_898, q__1715, t_899, fn__14757;
    t_892 = sid__709('users');
    t_893 = SqlBuilder();
    t_893:appendSafe('age > ');
    t_893:appendInt32(18);
    t_894 = t_893.accumulated;
    t_895 = from(t_892):where(t_894);
    t_896 = SqlBuilder();
    t_896:appendSafe('active = ');
    t_896:appendBoolean(true);
    t_897 = t_895:where(t_896.accumulated);
    t_898 = SqlBuilder();
    t_898:appendSafe('vip = ');
    t_898:appendBoolean(true);
    q__1715 = t_897:orWhere(t_898.accumulated);
    t_899 = temper.str_eq(q__1715:toSql():toString(), 'SELECT * FROM users WHERE age > 18 AND active = TRUE OR vip = TRUE');
    fn__14757 = function()
      return 'mixed where and orWhere';
    end;
    temper.test_assert(test_891, t_899, fn__14757);
    return nil;
  end);
end;
Test_.test_whereNull__2493 = function()
  temper.test('whereNull', function(test_900)
    local t_901, t_902, q__1717, t_903, fn__14748;
    t_901 = sid__709('users');
    t_902 = sid__709('deleted_at');
    q__1717 = from(t_901):whereNull(t_902);
    t_903 = temper.str_eq(q__1717:toSql():toString(), 'SELECT * FROM users WHERE deleted_at IS NULL');
    fn__14748 = function()
      return 'whereNull';
    end;
    temper.test_assert(test_900, t_903, fn__14748);
    return nil;
  end);
end;
Test_.test_whereNotNull__2494 = function()
  temper.test('whereNotNull', function(test_904)
    local t_905, t_906, q__1719, t_907, fn__14739;
    t_905 = sid__709('users');
    t_906 = sid__709('email');
    q__1719 = from(t_905):whereNotNull(t_906);
    t_907 = temper.str_eq(q__1719:toSql():toString(), 'SELECT * FROM users WHERE email IS NOT NULL');
    fn__14739 = function()
      return 'whereNotNull';
    end;
    temper.test_assert(test_904, t_907, fn__14739);
    return nil;
  end);
end;
Test_.test_whereNullChainedWithWhere__2495 = function()
  temper.test('whereNull chained with where', function(test_908)
    local t_909, t_910, t_911, q__1721, t_912, fn__14725;
    t_909 = sid__709('users');
    t_910 = SqlBuilder();
    t_910:appendSafe('active = ');
    t_910:appendBoolean(true);
    t_911 = t_910.accumulated;
    q__1721 = from(t_909):where(t_911):whereNull(sid__709('deleted_at'));
    t_912 = temper.str_eq(q__1721:toSql():toString(), 'SELECT * FROM users WHERE active = TRUE AND deleted_at IS NULL');
    fn__14725 = function()
      return 'whereNull chained';
    end;
    temper.test_assert(test_908, t_912, fn__14725);
    return nil;
  end);
end;
Test_.test_whereNotNullChainedWithOrWhere__2497 = function()
  temper.test('whereNotNull chained with orWhere', function(test_913)
    local t_914, t_915, t_916, t_917, q__1723, t_918, fn__14711;
    t_914 = sid__709('users');
    t_915 = sid__709('deleted_at');
    t_916 = from(t_914):whereNull(t_915);
    t_917 = SqlBuilder();
    t_917:appendSafe('role = ');
    t_917:appendString('admin');
    q__1723 = t_916:orWhere(t_917.accumulated);
    t_918 = temper.str_eq(q__1723:toSql():toString(), "SELECT * FROM users WHERE deleted_at IS NULL OR role = 'admin'");
    fn__14711 = function()
      return 'whereNotNull with orWhere';
    end;
    temper.test_assert(test_913, t_918, fn__14711);
    return nil;
  end);
end;
Test_.test_whereInWithIntValues__2499 = function()
  temper.test('whereIn with int values', function(test_919)
    local t_920, t_921, t_922, t_923, t_924, q__1725, t_925, fn__14699;
    t_920 = sid__709('users');
    t_921 = sid__709('id');
    t_922 = SqlInt32(1);
    t_923 = SqlInt32(2);
    t_924 = SqlInt32(3);
    q__1725 = from(t_920):whereIn(t_921, temper.listof(t_922, t_923, t_924));
    t_925 = temper.str_eq(q__1725:toSql():toString(), 'SELECT * FROM users WHERE id IN (1, 2, 3)');
    fn__14699 = function()
      return 'whereIn ints';
    end;
    temper.test_assert(test_919, t_925, fn__14699);
    return nil;
  end);
end;
Test_.test_whereInWithStringValuesEscaping__2500 = function()
  temper.test('whereIn with string values escaping', function(test_926)
    local t_927, t_928, t_929, t_930, q__1727, t_931, fn__14688;
    t_927 = sid__709('users');
    t_928 = sid__709('name');
    t_929 = SqlString('Alice');
    t_930 = SqlString("Bob's");
    q__1727 = from(t_927):whereIn(t_928, temper.listof(t_929, t_930));
    t_931 = temper.str_eq(q__1727:toSql():toString(), "SELECT * FROM users WHERE name IN ('Alice', 'Bob''s')");
    fn__14688 = function()
      return 'whereIn strings';
    end;
    temper.test_assert(test_926, t_931, fn__14688);
    return nil;
  end);
end;
Test_.test_whereInWithEmptyListProduces1_0__2501 = function()
  temper.test('whereIn with empty list produces 1=0', function(test_932)
    local t_933, t_934, q__1729, t_935, fn__14679;
    t_933 = sid__709('users');
    t_934 = sid__709('id');
    q__1729 = from(t_933):whereIn(t_934, temper.listof());
    t_935 = temper.str_eq(q__1729:toSql():toString(), 'SELECT * FROM users WHERE 1 = 0');
    fn__14679 = function()
      return 'whereIn empty';
    end;
    temper.test_assert(test_932, t_935, fn__14679);
    return nil;
  end);
end;
Test_.test_whereInChained__2502 = function()
  temper.test('whereIn chained', function(test_936)
    local t_937, t_938, t_939, q__1731, t_940, fn__14663;
    t_937 = sid__709('users');
    t_938 = SqlBuilder();
    t_938:appendSafe('active = ');
    t_938:appendBoolean(true);
    t_939 = t_938.accumulated;
    q__1731 = from(t_937):where(t_939):whereIn(sid__709('role'), temper.listof(SqlString('admin'), SqlString('user')));
    t_940 = temper.str_eq(q__1731:toSql():toString(), "SELECT * FROM users WHERE active = TRUE AND role IN ('admin', 'user')");
    fn__14663 = function()
      return 'whereIn chained';
    end;
    temper.test_assert(test_936, t_940, fn__14663);
    return nil;
  end);
end;
Test_.test_whereInSingleElement__2504 = function()
  temper.test('whereIn single element', function(test_941)
    local t_942, t_943, t_944, q__1733, t_945, fn__14653;
    t_942 = sid__709('users');
    t_943 = sid__709('id');
    t_944 = SqlInt32(42);
    q__1733 = from(t_942):whereIn(t_943, temper.listof(t_944));
    t_945 = temper.str_eq(q__1733:toSql():toString(), 'SELECT * FROM users WHERE id IN (42)');
    fn__14653 = function()
      return 'whereIn single';
    end;
    temper.test_assert(test_941, t_945, fn__14653);
    return nil;
  end);
end;
Test_.test_whereNotBasic__2505 = function()
  temper.test('whereNot basic', function(test_946)
    local t_947, t_948, t_949, q__1735, t_950, fn__14641;
    t_947 = sid__709('users');
    t_948 = SqlBuilder();
    t_948:appendSafe('active = ');
    t_948:appendBoolean(true);
    t_949 = t_948.accumulated;
    q__1735 = from(t_947):whereNot(t_949);
    t_950 = temper.str_eq(q__1735:toSql():toString(), 'SELECT * FROM users WHERE NOT (active = TRUE)');
    fn__14641 = function()
      return 'whereNot';
    end;
    temper.test_assert(test_946, t_950, fn__14641);
    return nil;
  end);
end;
Test_.test_whereNotChained__2507 = function()
  temper.test('whereNot chained', function(test_951)
    local t_952, t_953, t_954, t_955, t_956, q__1737, t_957, fn__14624;
    t_952 = sid__709('users');
    t_953 = SqlBuilder();
    t_953:appendSafe('age > ');
    t_953:appendInt32(18);
    t_954 = t_953.accumulated;
    t_955 = from(t_952):where(t_954);
    t_956 = SqlBuilder();
    t_956:appendSafe('banned = ');
    t_956:appendBoolean(true);
    q__1737 = t_955:whereNot(t_956.accumulated);
    t_957 = temper.str_eq(q__1737:toSql():toString(), 'SELECT * FROM users WHERE age > 18 AND NOT (banned = TRUE)');
    fn__14624 = function()
      return 'whereNot chained';
    end;
    temper.test_assert(test_951, t_957, fn__14624);
    return nil;
  end);
end;
Test_.test_whereBetweenIntegers__2510 = function()
  temper.test('whereBetween integers', function(test_958)
    local t_959, t_960, t_961, t_962, q__1739, t_963, fn__14613;
    t_959 = sid__709('users');
    t_960 = sid__709('age');
    t_961 = SqlInt32(18);
    t_962 = SqlInt32(65);
    q__1739 = from(t_959):whereBetween(t_960, t_961, t_962);
    t_963 = temper.str_eq(q__1739:toSql():toString(), 'SELECT * FROM users WHERE age BETWEEN 18 AND 65');
    fn__14613 = function()
      return 'whereBetween ints';
    end;
    temper.test_assert(test_958, t_963, fn__14613);
    return nil;
  end);
end;
Test_.test_whereBetweenChained__2511 = function()
  temper.test('whereBetween chained', function(test_964)
    local t_965, t_966, t_967, q__1741, t_968, fn__14597;
    t_965 = sid__709('users');
    t_966 = SqlBuilder();
    t_966:appendSafe('active = ');
    t_966:appendBoolean(true);
    t_967 = t_966.accumulated;
    q__1741 = from(t_965):where(t_967):whereBetween(sid__709('age'), SqlInt32(21), SqlInt32(30));
    t_968 = temper.str_eq(q__1741:toSql():toString(), 'SELECT * FROM users WHERE active = TRUE AND age BETWEEN 21 AND 30');
    fn__14597 = function()
      return 'whereBetween chained';
    end;
    temper.test_assert(test_964, t_968, fn__14597);
    return nil;
  end);
end;
Test_.test_whereLikeBasic__2513 = function()
  temper.test('whereLike basic', function(test_969)
    local t_970, t_971, q__1743, t_972, fn__14588;
    t_970 = sid__709('users');
    t_971 = sid__709('name');
    q__1743 = from(t_970):whereLike(t_971, 'John%');
    t_972 = temper.str_eq(q__1743:toSql():toString(), "SELECT * FROM users WHERE name LIKE 'John%'");
    fn__14588 = function()
      return 'whereLike';
    end;
    temper.test_assert(test_969, t_972, fn__14588);
    return nil;
  end);
end;
Test_.test_whereIlikeBasic__2514 = function()
  temper.test('whereILike basic', function(test_973)
    local t_974, t_975, q__1745, t_976, fn__14579;
    t_974 = sid__709('users');
    t_975 = sid__709('email');
    q__1745 = from(t_974):whereILike(t_975, '%@gmail.com');
    t_976 = temper.str_eq(q__1745:toSql():toString(), "SELECT * FROM users WHERE email ILIKE '%@gmail.com'");
    fn__14579 = function()
      return 'whereILike';
    end;
    temper.test_assert(test_973, t_976, fn__14579);
    return nil;
  end);
end;
Test_.test_whereLikeWithInjectionAttempt__2515 = function()
  temper.test('whereLike with injection attempt', function(test_977)
    local t_978, t_979, q__1747, s__1748, t_980, fn__14565, t_981, fn__14564;
    t_978 = sid__709('users');
    t_979 = sid__709('name');
    q__1747 = from(t_978):whereLike(t_979, "'; DROP TABLE users; --");
    s__1748 = q__1747:toSql():toString();
    t_980 = temper.is_string_index(temper.string_indexof(s__1748, "''"));
    fn__14565 = function()
      return temper.concat('like injection escaped: ', s__1748);
    end;
    temper.test_assert(test_977, t_980, fn__14565);
    t_981 = temper.is_string_index(temper.string_indexof(s__1748, 'LIKE'));
    fn__14564 = function()
      return temper.concat('like structure intact: ', s__1748);
    end;
    temper.test_assert(test_977, t_981, fn__14564);
    return nil;
  end);
end;
Test_.test_whereLikeWildcardPatterns__2516 = function()
  temper.test('whereLike wildcard patterns', function(test_982)
    local t_983, t_984, q__1750, t_985, fn__14555;
    t_983 = sid__709('users');
    t_984 = sid__709('name');
    q__1750 = from(t_983):whereLike(t_984, '%son%');
    t_985 = temper.str_eq(q__1750:toSql():toString(), "SELECT * FROM users WHERE name LIKE '%son%'");
    fn__14555 = function()
      return 'whereLike wildcard';
    end;
    temper.test_assert(test_982, t_985, fn__14555);
    return nil;
  end);
end;
Test_.test_countAllProducesCount__2517 = function()
  temper.test('countAll produces COUNT(*)', function(test_986)
    local f__1752, t_987, fn__14549;
    f__1752 = countAll();
    t_987 = temper.str_eq(f__1752:toString(), 'COUNT(*)');
    fn__14549 = function()
      return 'countAll';
    end;
    temper.test_assert(test_986, t_987, fn__14549);
    return nil;
  end);
end;
Test_.test_countColProducesCountField__2518 = function()
  temper.test('countCol produces COUNT(field)', function(test_988)
    local f__1754, t_989, fn__14542;
    f__1754 = countCol(sid__709('id'));
    t_989 = temper.str_eq(f__1754:toString(), 'COUNT(id)');
    fn__14542 = function()
      return 'countCol';
    end;
    temper.test_assert(test_988, t_989, fn__14542);
    return nil;
  end);
end;
Test_.test_sumColProducesSumField__2519 = function()
  temper.test('sumCol produces SUM(field)', function(test_990)
    local f__1756, t_991, fn__14535;
    f__1756 = sumCol(sid__709('amount'));
    t_991 = temper.str_eq(f__1756:toString(), 'SUM(amount)');
    fn__14535 = function()
      return 'sumCol';
    end;
    temper.test_assert(test_990, t_991, fn__14535);
    return nil;
  end);
end;
Test_.test_avgColProducesAvgField__2520 = function()
  temper.test('avgCol produces AVG(field)', function(test_992)
    local f__1758, t_993, fn__14528;
    f__1758 = avgCol(sid__709('price'));
    t_993 = temper.str_eq(f__1758:toString(), 'AVG(price)');
    fn__14528 = function()
      return 'avgCol';
    end;
    temper.test_assert(test_992, t_993, fn__14528);
    return nil;
  end);
end;
Test_.test_minColProducesMinField__2521 = function()
  temper.test('minCol produces MIN(field)', function(test_994)
    local f__1760, t_995, fn__14521;
    f__1760 = minCol(sid__709('created_at'));
    t_995 = temper.str_eq(f__1760:toString(), 'MIN(created_at)');
    fn__14521 = function()
      return 'minCol';
    end;
    temper.test_assert(test_994, t_995, fn__14521);
    return nil;
  end);
end;
Test_.test_maxColProducesMaxField__2522 = function()
  temper.test('maxCol produces MAX(field)', function(test_996)
    local f__1762, t_997, fn__14514;
    f__1762 = maxCol(sid__709('score'));
    t_997 = temper.str_eq(f__1762:toString(), 'MAX(score)');
    fn__14514 = function()
      return 'maxCol';
    end;
    temper.test_assert(test_996, t_997, fn__14514);
    return nil;
  end);
end;
Test_.test_selectExprWithAggregate__2523 = function()
  temper.test('selectExpr with aggregate', function(test_998)
    local t_999, t_1000, q__1764, t_1001, fn__14505;
    t_999 = sid__709('orders');
    t_1000 = countAll();
    q__1764 = from(t_999):selectExpr(temper.listof(t_1000));
    t_1001 = temper.str_eq(q__1764:toSql():toString(), 'SELECT COUNT(*) FROM orders');
    fn__14505 = function()
      return 'selectExpr count';
    end;
    temper.test_assert(test_998, t_1001, fn__14505);
    return nil;
  end);
end;
Test_.test_selectExprWithMultipleExpressions__2524 = function()
  temper.test('selectExpr with multiple expressions', function(test_1002)
    local nameFrag__1766, t_1003, t_1004, q__1767, t_1005, fn__14493;
    nameFrag__1766 = col(sid__709('users'), sid__709('name'));
    t_1003 = sid__709('users');
    t_1004 = countAll();
    q__1767 = from(t_1003):selectExpr(temper.listof(nameFrag__1766, t_1004));
    t_1005 = temper.str_eq(q__1767:toSql():toString(), 'SELECT users.name, COUNT(*) FROM users');
    fn__14493 = function()
      return 'selectExpr multi';
    end;
    temper.test_assert(test_1002, t_1005, fn__14493);
    return nil;
  end);
end;
Test_.test_selectExprOverridesSelectedFields__2525 = function()
  temper.test('selectExpr overrides selectedFields', function(test_1006)
    local t_1007, t_1008, t_1009, q__1769, t_1010, fn__14481;
    t_1007 = sid__709('users');
    t_1008 = sid__709('id');
    t_1009 = sid__709('name');
    q__1769 = from(t_1007):select(temper.listof(t_1008, t_1009)):selectExpr(temper.listof(countAll()));
    t_1010 = temper.str_eq(q__1769:toSql():toString(), 'SELECT COUNT(*) FROM users');
    fn__14481 = function()
      return 'selectExpr overrides select';
    end;
    temper.test_assert(test_1006, t_1010, fn__14481);
    return nil;
  end);
end;
Test_.test_groupBySingleField__2526 = function()
  temper.test('groupBy single field', function(test_1011)
    local t_1012, t_1013, t_1014, q__1771, t_1015, fn__14467;
    t_1012 = sid__709('orders');
    t_1013 = col(sid__709('orders'), sid__709('status'));
    t_1014 = countAll();
    q__1771 = from(t_1012):selectExpr(temper.listof(t_1013, t_1014)):groupBy(sid__709('status'));
    t_1015 = temper.str_eq(q__1771:toSql():toString(), 'SELECT orders.status, COUNT(*) FROM orders GROUP BY status');
    fn__14467 = function()
      return 'groupBy single';
    end;
    temper.test_assert(test_1011, t_1015, fn__14467);
    return nil;
  end);
end;
Test_.test_groupByMultipleFields__2527 = function()
  temper.test('groupBy multiple fields', function(test_1016)
    local t_1017, t_1018, q__1773, t_1019, fn__14456;
    t_1017 = sid__709('orders');
    t_1018 = sid__709('status');
    q__1773 = from(t_1017):groupBy(t_1018):groupBy(sid__709('category'));
    t_1019 = temper.str_eq(q__1773:toSql():toString(), 'SELECT * FROM orders GROUP BY status, category');
    fn__14456 = function()
      return 'groupBy multiple';
    end;
    temper.test_assert(test_1016, t_1019, fn__14456);
    return nil;
  end);
end;
Test_.test_havingBasic__2528 = function()
  temper.test('having basic', function(test_1020)
    local t_1021, t_1022, t_1023, t_1024, t_1025, q__1775, t_1026, fn__14437;
    t_1021 = sid__709('orders');
    t_1022 = col(sid__709('orders'), sid__709('status'));
    t_1023 = countAll();
    t_1024 = from(t_1021):selectExpr(temper.listof(t_1022, t_1023)):groupBy(sid__709('status'));
    t_1025 = SqlBuilder();
    t_1025:appendSafe('COUNT(*) > ');
    t_1025:appendInt32(5);
    q__1775 = t_1024:having(t_1025.accumulated);
    t_1026 = temper.str_eq(q__1775:toSql():toString(), 'SELECT orders.status, COUNT(*) FROM orders GROUP BY status HAVING COUNT(*) > 5');
    fn__14437 = function()
      return 'having basic';
    end;
    temper.test_assert(test_1020, t_1026, fn__14437);
    return nil;
  end);
end;
Test_.test_orHaving__2530 = function()
  temper.test('orHaving', function(test_1027)
    local t_1028, t_1029, t_1030, t_1031, t_1032, t_1033, q__1777, t_1034, fn__14418;
    t_1028 = sid__709('orders');
    t_1029 = sid__709('status');
    t_1030 = from(t_1028):groupBy(t_1029);
    t_1031 = SqlBuilder();
    t_1031:appendSafe('COUNT(*) > ');
    t_1031:appendInt32(5);
    t_1032 = t_1030:having(t_1031.accumulated);
    t_1033 = SqlBuilder();
    t_1033:appendSafe('SUM(total) > ');
    t_1033:appendInt32(1000);
    q__1777 = t_1032:orHaving(t_1033.accumulated);
    t_1034 = temper.str_eq(q__1777:toSql():toString(), 'SELECT * FROM orders GROUP BY status HAVING COUNT(*) > 5 OR SUM(total) > 1000');
    fn__14418 = function()
      return 'orHaving';
    end;
    temper.test_assert(test_1027, t_1034, fn__14418);
    return nil;
  end);
end;
Test_.test_distinctBasic__2533 = function()
  temper.test('distinct basic', function(test_1035)
    local t_1036, t_1037, q__1779, t_1038, fn__14408;
    t_1036 = sid__709('users');
    t_1037 = sid__709('name');
    q__1779 = from(t_1036):select(temper.listof(t_1037)):distinct();
    t_1038 = temper.str_eq(q__1779:toSql():toString(), 'SELECT DISTINCT name FROM users');
    fn__14408 = function()
      return 'distinct';
    end;
    temper.test_assert(test_1035, t_1038, fn__14408);
    return nil;
  end);
end;
Test_.test_distinctWithWhere__2534 = function()
  temper.test('distinct with where', function(test_1039)
    local t_1040, t_1041, t_1042, t_1043, q__1781, t_1044, fn__14393;
    t_1040 = sid__709('users');
    t_1041 = sid__709('email');
    t_1042 = from(t_1040):select(temper.listof(t_1041));
    t_1043 = SqlBuilder();
    t_1043:appendSafe('active = ');
    t_1043:appendBoolean(true);
    q__1781 = t_1042:where(t_1043.accumulated):distinct();
    t_1044 = temper.str_eq(q__1781:toSql():toString(), 'SELECT DISTINCT email FROM users WHERE active = TRUE');
    fn__14393 = function()
      return 'distinct with where';
    end;
    temper.test_assert(test_1039, t_1044, fn__14393);
    return nil;
  end);
end;
Test_.test_countSqlBare__2536 = function()
  temper.test('countSql bare', function(test_1045)
    local q__1783, t_1046, fn__14386;
    q__1783 = from(sid__709('users'));
    t_1046 = temper.str_eq(q__1783:countSql():toString(), 'SELECT COUNT(*) FROM users');
    fn__14386 = function()
      return 'countSql bare';
    end;
    temper.test_assert(test_1045, t_1046, fn__14386);
    return nil;
  end);
end;
Test_.test_countSqlWithWhere__2537 = function()
  temper.test('countSql with WHERE', function(test_1047)
    local t_1048, t_1049, t_1050, q__1785, t_1051, fn__14374;
    t_1048 = sid__709('users');
    t_1049 = SqlBuilder();
    t_1049:appendSafe('active = ');
    t_1049:appendBoolean(true);
    t_1050 = t_1049.accumulated;
    q__1785 = from(t_1048):where(t_1050);
    t_1051 = temper.str_eq(q__1785:countSql():toString(), 'SELECT COUNT(*) FROM users WHERE active = TRUE');
    fn__14374 = function()
      return 'countSql with where';
    end;
    temper.test_assert(test_1047, t_1051, fn__14374);
    return nil;
  end);
end;
Test_.test_countSqlWithJoin__2539 = function()
  temper.test('countSql with JOIN', function(test_1052)
    local t_1053, t_1054, t_1055, t_1056, t_1057, t_1058, q__1787, t_1059, fn__14357;
    t_1053 = sid__709('users');
    t_1054 = sid__709('orders');
    t_1055 = SqlBuilder();
    t_1055:appendSafe('users.id = orders.user_id');
    t_1056 = t_1055.accumulated;
    t_1057 = from(t_1053):innerJoin(t_1054, t_1056);
    t_1058 = SqlBuilder();
    t_1058:appendSafe('orders.total > ');
    t_1058:appendInt32(100);
    q__1787 = t_1057:where(t_1058.accumulated);
    t_1059 = temper.str_eq(q__1787:countSql():toString(), 'SELECT COUNT(*) FROM users INNER JOIN orders ON users.id = orders.user_id WHERE orders.total > 100');
    fn__14357 = function()
      return 'countSql with join';
    end;
    temper.test_assert(test_1052, t_1059, fn__14357);
    return nil;
  end);
end;
Test_.test_countSqlDropsOrderByLimitOffset__2542 = function()
  temper.test('countSql drops orderBy/limit/offset', function(test_1060)
    local t_1061, t_1062, t_1063, t_1064, t_1065, q__1789, local_1066, local_1067, local_1068, s__1790, t_1070, fn__14343;
    local_1066, local_1067, local_1068 = temper.pcall(function()
      t_1061 = sid__709('users');
      t_1062 = SqlBuilder();
      t_1062:appendSafe('active = ');
      t_1062:appendBoolean(true);
      t_1063 = t_1062.accumulated;
      t_1064 = from(t_1061):where(t_1063):orderBy(sid__709('name'), true):limit(10);
      t_1065 = t_1064:offset(20);
      q__1789 = t_1065;
    end);
    if local_1066 then
    else
      q__1789 = temper.bubble();
    end
    s__1790 = q__1789:countSql():toString();
    t_1070 = temper.str_eq(s__1790, 'SELECT COUNT(*) FROM users WHERE active = TRUE');
    fn__14343 = function()
      return temper.concat('countSql drops extras: ', s__1790);
    end;
    temper.test_assert(test_1060, t_1070, fn__14343);
    return nil;
  end);
end;
Test_.test_fullAggregationQuery__2544 = function()
  temper.test('full aggregation query', function(test_1071)
    local t_1072, t_1073, t_1074, t_1075, t_1076, t_1077, t_1078, t_1079, t_1080, t_1081, t_1082, q__1792, expected__1793, t_1083, fn__14310;
    t_1072 = sid__709('orders');
    t_1073 = col(sid__709('orders'), sid__709('status'));
    t_1074 = countAll();
    t_1075 = sumCol(sid__709('total'));
    t_1076 = from(t_1072):selectExpr(temper.listof(t_1073, t_1074, t_1075));
    t_1077 = sid__709('users');
    t_1078 = SqlBuilder();
    t_1078:appendSafe('orders.user_id = users.id');
    t_1079 = t_1076:innerJoin(t_1077, t_1078.accumulated);
    t_1080 = SqlBuilder();
    t_1080:appendSafe('users.active = ');
    t_1080:appendBoolean(true);
    t_1081 = t_1079:where(t_1080.accumulated):groupBy(sid__709('status'));
    t_1082 = SqlBuilder();
    t_1082:appendSafe('COUNT(*) > ');
    t_1082:appendInt32(3);
    q__1792 = t_1081:having(t_1082.accumulated):orderBy(sid__709('status'), true);
    expected__1793 = 'SELECT orders.status, COUNT(*), SUM(total) FROM orders INNER JOIN users ON orders.user_id = users.id WHERE users.active = TRUE GROUP BY status HAVING COUNT(*) > 3 ORDER BY status ASC';
    t_1083 = temper.str_eq(q__1792:toSql():toString(), 'SELECT orders.status, COUNT(*), SUM(total) FROM orders INNER JOIN users ON orders.user_id = users.id WHERE users.active = TRUE GROUP BY status HAVING COUNT(*) > 3 ORDER BY status ASC');
    fn__14310 = function()
      return 'full aggregation';
    end;
    temper.test_assert(test_1071, t_1083, fn__14310);
    return nil;
  end);
end;
Test_.test_unionSql__2548 = function()
  temper.test('unionSql', function(test_1084)
    local t_1085, t_1086, t_1087, a__1795, t_1088, t_1089, t_1090, b__1796, s__1797, t_1091, fn__14292;
    t_1085 = sid__709('users');
    t_1086 = SqlBuilder();
    t_1086:appendSafe('role = ');
    t_1086:appendString('admin');
    t_1087 = t_1086.accumulated;
    a__1795 = from(t_1085):where(t_1087);
    t_1088 = sid__709('users');
    t_1089 = SqlBuilder();
    t_1089:appendSafe('role = ');
    t_1089:appendString('moderator');
    t_1090 = t_1089.accumulated;
    b__1796 = from(t_1088):where(t_1090);
    s__1797 = unionSql(a__1795, b__1796):toString();
    t_1091 = temper.str_eq(s__1797, "(SELECT * FROM users WHERE role = 'admin') UNION (SELECT * FROM users WHERE role = 'moderator')");
    fn__14292 = function()
      return temper.concat('unionSql: ', s__1797);
    end;
    temper.test_assert(test_1084, t_1091, fn__14292);
    return nil;
  end);
end;
Test_.test_unionAllSql__2551 = function()
  temper.test('unionAllSql', function(test_1092)
    local t_1093, t_1094, a__1799, t_1095, t_1096, b__1800, s__1801, t_1097, fn__14280;
    t_1093 = sid__709('users');
    t_1094 = sid__709('name');
    a__1799 = from(t_1093):select(temper.listof(t_1094));
    t_1095 = sid__709('contacts');
    t_1096 = sid__709('name');
    b__1800 = from(t_1095):select(temper.listof(t_1096));
    s__1801 = unionAllSql(a__1799, b__1800):toString();
    t_1097 = temper.str_eq(s__1801, '(SELECT name FROM users) UNION ALL (SELECT name FROM contacts)');
    fn__14280 = function()
      return temper.concat('unionAllSql: ', s__1801);
    end;
    temper.test_assert(test_1092, t_1097, fn__14280);
    return nil;
  end);
end;
Test_.test_intersectSql__2552 = function()
  temper.test('intersectSql', function(test_1098)
    local t_1099, t_1100, a__1803, t_1101, t_1102, b__1804, s__1805, t_1103, fn__14268;
    t_1099 = sid__709('users');
    t_1100 = sid__709('email');
    a__1803 = from(t_1099):select(temper.listof(t_1100));
    t_1101 = sid__709('subscribers');
    t_1102 = sid__709('email');
    b__1804 = from(t_1101):select(temper.listof(t_1102));
    s__1805 = intersectSql(a__1803, b__1804):toString();
    t_1103 = temper.str_eq(s__1805, '(SELECT email FROM users) INTERSECT (SELECT email FROM subscribers)');
    fn__14268 = function()
      return temper.concat('intersectSql: ', s__1805);
    end;
    temper.test_assert(test_1098, t_1103, fn__14268);
    return nil;
  end);
end;
Test_.test_exceptSql__2553 = function()
  temper.test('exceptSql', function(test_1104)
    local t_1105, t_1106, a__1807, t_1107, t_1108, b__1808, s__1809, t_1109, fn__14256;
    t_1105 = sid__709('users');
    t_1106 = sid__709('id');
    a__1807 = from(t_1105):select(temper.listof(t_1106));
    t_1107 = sid__709('banned');
    t_1108 = sid__709('id');
    b__1808 = from(t_1107):select(temper.listof(t_1108));
    s__1809 = exceptSql(a__1807, b__1808):toString();
    t_1109 = temper.str_eq(s__1809, '(SELECT id FROM users) EXCEPT (SELECT id FROM banned)');
    fn__14256 = function()
      return temper.concat('exceptSql: ', s__1809);
    end;
    temper.test_assert(test_1104, t_1109, fn__14256);
    return nil;
  end);
end;
Test_.test_subqueryWithAlias__2554 = function()
  temper.test('subquery with alias', function(test_1110)
    local t_1111, t_1112, t_1113, t_1114, inner__1811, s__1812, t_1115, fn__14241;
    t_1111 = sid__709('orders');
    t_1112 = sid__709('user_id');
    t_1113 = from(t_1111):select(temper.listof(t_1112));
    t_1114 = SqlBuilder();
    t_1114:appendSafe('total > ');
    t_1114:appendInt32(100);
    inner__1811 = t_1113:where(t_1114.accumulated);
    s__1812 = subquery(inner__1811, sid__709('big_orders')):toString();
    t_1115 = temper.str_eq(s__1812, '(SELECT user_id FROM orders WHERE total > 100) AS big_orders');
    fn__14241 = function()
      return temper.concat('subquery: ', s__1812);
    end;
    temper.test_assert(test_1110, t_1115, fn__14241);
    return nil;
  end);
end;
Test_.test_existsSql__2556 = function()
  temper.test('existsSql', function(test_1116)
    local t_1117, t_1118, t_1119, inner__1814, s__1815, t_1120, fn__14230;
    t_1117 = sid__709('orders');
    t_1118 = SqlBuilder();
    t_1118:appendSafe('orders.user_id = users.id');
    t_1119 = t_1118.accumulated;
    inner__1814 = from(t_1117):where(t_1119);
    s__1815 = existsSql(inner__1814):toString();
    t_1120 = temper.str_eq(s__1815, 'EXISTS (SELECT * FROM orders WHERE orders.user_id = users.id)');
    fn__14230 = function()
      return temper.concat('existsSql: ', s__1815);
    end;
    temper.test_assert(test_1116, t_1120, fn__14230);
    return nil;
  end);
end;
Test_.test_whereInSubquery__2558 = function()
  temper.test('whereInSubquery', function(test_1121)
    local t_1122, t_1123, t_1124, t_1125, sub__1817, t_1126, t_1127, q__1818, s__1819, t_1128, fn__14213;
    t_1122 = sid__709('orders');
    t_1123 = sid__709('user_id');
    t_1124 = from(t_1122):select(temper.listof(t_1123));
    t_1125 = SqlBuilder();
    t_1125:appendSafe('total > ');
    t_1125:appendInt32(1000);
    sub__1817 = t_1124:where(t_1125.accumulated);
    t_1126 = sid__709('users');
    t_1127 = sid__709('id');
    q__1818 = from(t_1126):whereInSubquery(t_1127, sub__1817);
    s__1819 = q__1818:toSql():toString();
    t_1128 = temper.str_eq(s__1819, 'SELECT * FROM users WHERE id IN (SELECT user_id FROM orders WHERE total > 1000)');
    fn__14213 = function()
      return temper.concat('whereInSubquery: ', s__1819);
    end;
    temper.test_assert(test_1121, t_1128, fn__14213);
    return nil;
  end);
end;
Test_.test_setOperationWithWhereOnEachSide__2560 = function()
  temper.test('set operation with WHERE on each side', function(test_1129)
    local t_1130, t_1131, t_1132, t_1133, t_1134, a__1821, t_1135, t_1136, t_1137, b__1822, s__1823, t_1138, fn__14190;
    t_1130 = sid__709('users');
    t_1131 = SqlBuilder();
    t_1131:appendSafe('age > ');
    t_1131:appendInt32(18);
    t_1132 = t_1131.accumulated;
    t_1133 = from(t_1130):where(t_1132);
    t_1134 = SqlBuilder();
    t_1134:appendSafe('active = ');
    t_1134:appendBoolean(true);
    a__1821 = t_1133:where(t_1134.accumulated);
    t_1135 = sid__709('users');
    t_1136 = SqlBuilder();
    t_1136:appendSafe('role = ');
    t_1136:appendString('vip');
    t_1137 = t_1136.accumulated;
    b__1822 = from(t_1135):where(t_1137);
    s__1823 = unionSql(a__1821, b__1822):toString();
    t_1138 = temper.str_eq(s__1823, "(SELECT * FROM users WHERE age > 18 AND active = TRUE) UNION (SELECT * FROM users WHERE role = 'vip')");
    fn__14190 = function()
      return temper.concat('union with where: ', s__1823);
    end;
    temper.test_assert(test_1129, t_1138, fn__14190);
    return nil;
  end);
end;
Test_.test_whereInSubqueryChainedWithWhere__2564 = function()
  temper.test('whereInSubquery chained with where', function(test_1139)
    local t_1140, t_1141, sub__1825, t_1142, t_1143, t_1144, q__1826, s__1827, t_1145, fn__14173;
    t_1140 = sid__709('orders');
    t_1141 = sid__709('user_id');
    sub__1825 = from(t_1140):select(temper.listof(t_1141));
    t_1142 = sid__709('users');
    t_1143 = SqlBuilder();
    t_1143:appendSafe('active = ');
    t_1143:appendBoolean(true);
    t_1144 = t_1143.accumulated;
    q__1826 = from(t_1142):where(t_1144):whereInSubquery(sid__709('id'), sub__1825);
    s__1827 = q__1826:toSql():toString();
    t_1145 = temper.str_eq(s__1827, 'SELECT * FROM users WHERE active = TRUE AND id IN (SELECT user_id FROM orders)');
    fn__14173 = function()
      return temper.concat('whereInSubquery chained: ', s__1827);
    end;
    temper.test_assert(test_1139, t_1145, fn__14173);
    return nil;
  end);
end;
Test_.test_existsSqlUsedInWhere__2566 = function()
  temper.test('existsSql used in where', function(test_1146)
    local t_1147, t_1148, t_1149, sub__1829, t_1150, t_1151, q__1830, s__1831, t_1152, fn__14159;
    t_1147 = sid__709('orders');
    t_1148 = SqlBuilder();
    t_1148:appendSafe('orders.user_id = users.id');
    t_1149 = t_1148.accumulated;
    sub__1829 = from(t_1147):where(t_1149);
    t_1150 = sid__709('users');
    t_1151 = existsSql(sub__1829);
    q__1830 = from(t_1150):where(t_1151);
    s__1831 = q__1830:toSql():toString();
    t_1152 = temper.str_eq(s__1831, 'SELECT * FROM users WHERE EXISTS (SELECT * FROM orders WHERE orders.user_id = users.id)');
    fn__14159 = function()
      return temper.concat('exists in where: ', s__1831);
    end;
    temper.test_assert(test_1146, t_1152, fn__14159);
    return nil;
  end);
end;
Test_.test_updateQueryBasic__2568 = function()
  temper.test('UpdateQuery basic', function(test_1153)
    local t_1154, t_1155, t_1156, t_1157, t_1158, t_1159, q__1833, local_1160, local_1161, local_1162, t_1164, fn__14145;
    local_1160, local_1161, local_1162 = temper.pcall(function()
      t_1154 = sid__709('users');
      t_1155 = sid__709('name');
      t_1156 = SqlString('Alice');
      t_1157 = update(t_1154):set(t_1155, t_1156);
      t_1158 = SqlBuilder();
      t_1158:appendSafe('id = ');
      t_1158:appendInt32(1);
      t_1159 = t_1157:where(t_1158.accumulated):toSql();
      q__1833 = t_1159;
    end);
    if local_1160 then
    else
      q__1833 = temper.bubble();
    end
    t_1164 = temper.str_eq(q__1833:toString(), "UPDATE users SET name = 'Alice' WHERE id = 1");
    fn__14145 = function()
      return 'update basic';
    end;
    temper.test_assert(test_1153, t_1164, fn__14145);
    return nil;
  end);
end;
Test_.test_updateQueryMultipleSet__2570 = function()
  temper.test('UpdateQuery multiple SET', function(test_1165)
    local t_1166, t_1167, t_1168, t_1169, t_1170, t_1171, q__1835, local_1172, local_1173, local_1174, t_1176, fn__14128;
    local_1172, local_1173, local_1174 = temper.pcall(function()
      t_1166 = sid__709('users');
      t_1167 = sid__709('name');
      t_1168 = SqlString('Bob');
      t_1169 = update(t_1166):set(t_1167, t_1168):set(sid__709('age'), SqlInt32(30));
      t_1170 = SqlBuilder();
      t_1170:appendSafe('id = ');
      t_1170:appendInt32(2);
      t_1171 = t_1169:where(t_1170.accumulated):toSql();
      q__1835 = t_1171;
    end);
    if local_1172 then
    else
      q__1835 = temper.bubble();
    end
    t_1176 = temper.str_eq(q__1835:toString(), "UPDATE users SET name = 'Bob', age = 30 WHERE id = 2");
    fn__14128 = function()
      return 'update multi set';
    end;
    temper.test_assert(test_1165, t_1176, fn__14128);
    return nil;
  end);
end;
Test_.test_updateQueryMultipleWhere__2572 = function()
  temper.test('UpdateQuery multiple WHERE', function(test_1177)
    local t_1178, t_1179, t_1180, t_1181, t_1182, t_1183, t_1184, t_1185, q__1837, local_1186, local_1187, local_1188, t_1190, fn__14109;
    local_1186, local_1187, local_1188 = temper.pcall(function()
      t_1178 = sid__709('users');
      t_1179 = sid__709('active');
      t_1180 = SqlBoolean(false);
      t_1181 = update(t_1178):set(t_1179, t_1180);
      t_1182 = SqlBuilder();
      t_1182:appendSafe('age < ');
      t_1182:appendInt32(18);
      t_1183 = t_1181:where(t_1182.accumulated);
      t_1184 = SqlBuilder();
      t_1184:appendSafe('role = ');
      t_1184:appendString('guest');
      t_1185 = t_1183:where(t_1184.accumulated):toSql();
      q__1837 = t_1185;
    end);
    if local_1186 then
    else
      q__1837 = temper.bubble();
    end
    t_1190 = temper.str_eq(q__1837:toString(), "UPDATE users SET active = FALSE WHERE age < 18 AND role = 'guest'");
    fn__14109 = function()
      return 'update multi where';
    end;
    temper.test_assert(test_1177, t_1190, fn__14109);
    return nil;
  end);
end;
Test_.test_updateQueryOrWhere__2575 = function()
  temper.test('UpdateQuery orWhere', function(test_1191)
    local t_1192, t_1193, t_1194, t_1195, t_1196, t_1197, t_1198, t_1199, q__1839, local_1200, local_1201, local_1202, t_1204, fn__14090;
    local_1200, local_1201, local_1202 = temper.pcall(function()
      t_1192 = sid__709('users');
      t_1193 = sid__709('status');
      t_1194 = SqlString('banned');
      t_1195 = update(t_1192):set(t_1193, t_1194);
      t_1196 = SqlBuilder();
      t_1196:appendSafe('spam_count > ');
      t_1196:appendInt32(10);
      t_1197 = t_1195:where(t_1196.accumulated);
      t_1198 = SqlBuilder();
      t_1198:appendSafe('reported = ');
      t_1198:appendBoolean(true);
      t_1199 = t_1197:orWhere(t_1198.accumulated):toSql();
      q__1839 = t_1199;
    end);
    if local_1200 then
    else
      q__1839 = temper.bubble();
    end
    t_1204 = temper.str_eq(q__1839:toString(), "UPDATE users SET status = 'banned' WHERE spam_count > 10 OR reported = TRUE");
    fn__14090 = function()
      return 'update orWhere';
    end;
    temper.test_assert(test_1191, t_1204, fn__14090);
    return nil;
  end);
end;
Test_.test_updateQueryBubblesWithoutWhere__2578 = function()
  temper.test('UpdateQuery bubbles without WHERE', function(test_1205)
    local t_1206, t_1207, t_1208, didBubble__1841, local_1209, local_1210, local_1211, fn__14083;
    local_1209, local_1210, local_1211 = temper.pcall(function()
      t_1206 = sid__709('users');
      t_1207 = sid__709('x');
      t_1208 = SqlInt32(1);
      update(t_1206):set(t_1207, t_1208):toSql();
      didBubble__1841 = false;
    end);
    if local_1209 then
    else
      didBubble__1841 = true;
    end
    fn__14083 = function()
      return 'update without WHERE should bubble';
    end;
    temper.test_assert(test_1205, didBubble__1841, fn__14083);
    return nil;
  end);
end;
Test_.test_updateQueryBubblesWithoutSet__2579 = function()
  temper.test('UpdateQuery bubbles without SET', function(test_1213)
    local t_1214, t_1215, t_1216, didBubble__1843, local_1217, local_1218, local_1219, fn__14074;
    local_1217, local_1218, local_1219 = temper.pcall(function()
      t_1214 = sid__709('users');
      t_1215 = SqlBuilder();
      t_1215:appendSafe('id = ');
      t_1215:appendInt32(1);
      t_1216 = t_1215.accumulated;
      update(t_1214):where(t_1216):toSql();
      didBubble__1843 = false;
    end);
    if local_1217 then
    else
      didBubble__1843 = true;
    end
    fn__14074 = function()
      return 'update without SET should bubble';
    end;
    temper.test_assert(test_1213, didBubble__1843, fn__14074);
    return nil;
  end);
end;
Test_.test_updateQueryWithLimit__2581 = function()
  temper.test('UpdateQuery with limit', function(test_1221)
    local t_1222, t_1223, t_1224, t_1225, t_1226, t_1227, t_1228, q__1845, local_1229, local_1230, local_1231, t_1233, fn__14060;
    local_1229, local_1230, local_1231 = temper.pcall(function()
      t_1222 = sid__709('users');
      t_1223 = sid__709('active');
      t_1224 = SqlBoolean(false);
      t_1225 = update(t_1222):set(t_1223, t_1224);
      t_1226 = SqlBuilder();
      t_1226:appendSafe('last_login < ');
      t_1226:appendString('2024-01-01');
      t_1227 = t_1225:where(t_1226.accumulated):limit(100);
      t_1228 = t_1227:toSql();
      q__1845 = t_1228;
    end);
    if local_1229 then
    else
      q__1845 = temper.bubble();
    end
    t_1233 = temper.str_eq(q__1845:toString(), "UPDATE users SET active = FALSE WHERE last_login < '2024-01-01' LIMIT 100");
    fn__14060 = function()
      return 'update limit';
    end;
    temper.test_assert(test_1221, t_1233, fn__14060);
    return nil;
  end);
end;
Test_.test_updateQueryEscaping__2583 = function()
  temper.test('UpdateQuery escaping', function(test_1234)
    local t_1235, t_1236, t_1237, t_1238, t_1239, t_1240, q__1847, local_1241, local_1242, local_1243, t_1245, fn__14046;
    local_1241, local_1242, local_1243 = temper.pcall(function()
      t_1235 = sid__709('users');
      t_1236 = sid__709('bio');
      t_1237 = SqlString("It's a test");
      t_1238 = update(t_1235):set(t_1236, t_1237);
      t_1239 = SqlBuilder();
      t_1239:appendSafe('id = ');
      t_1239:appendInt32(1);
      t_1240 = t_1238:where(t_1239.accumulated):toSql();
      q__1847 = t_1240;
    end);
    if local_1241 then
    else
      q__1847 = temper.bubble();
    end
    t_1245 = temper.str_eq(q__1847:toString(), "UPDATE users SET bio = 'It''s a test' WHERE id = 1");
    fn__14046 = function()
      return 'update escaping';
    end;
    temper.test_assert(test_1234, t_1245, fn__14046);
    return nil;
  end);
end;
Test_.test_deleteQueryBasic__2585 = function()
  temper.test('DeleteQuery basic', function(test_1246)
    local t_1247, t_1248, t_1249, t_1250, q__1849, local_1251, local_1252, local_1253, t_1255, fn__14035;
    local_1251, local_1252, local_1253 = temper.pcall(function()
      t_1247 = sid__709('users');
      t_1248 = SqlBuilder();
      t_1248:appendSafe('id = ');
      t_1248:appendInt32(1);
      t_1249 = t_1248.accumulated;
      t_1250 = deleteFrom(t_1247):where(t_1249):toSql();
      q__1849 = t_1250;
    end);
    if local_1251 then
    else
      q__1849 = temper.bubble();
    end
    t_1255 = temper.str_eq(q__1849:toString(), 'DELETE FROM users WHERE id = 1');
    fn__14035 = function()
      return 'delete basic';
    end;
    temper.test_assert(test_1246, t_1255, fn__14035);
    return nil;
  end);
end;
Test_.test_deleteQueryMultipleWhere__2587 = function()
  temper.test('DeleteQuery multiple WHERE', function(test_1256)
    local t_1257, t_1258, t_1259, t_1260, t_1261, t_1262, q__1851, local_1263, local_1264, local_1265, t_1267, fn__14019;
    local_1263, local_1264, local_1265 = temper.pcall(function()
      t_1257 = sid__709('logs');
      t_1258 = SqlBuilder();
      t_1258:appendSafe('created_at < ');
      t_1258:appendString('2024-01-01');
      t_1259 = t_1258.accumulated;
      t_1260 = deleteFrom(t_1257):where(t_1259);
      t_1261 = SqlBuilder();
      t_1261:appendSafe('level = ');
      t_1261:appendString('debug');
      t_1262 = t_1260:where(t_1261.accumulated):toSql();
      q__1851 = t_1262;
    end);
    if local_1263 then
    else
      q__1851 = temper.bubble();
    end
    t_1267 = temper.str_eq(q__1851:toString(), "DELETE FROM logs WHERE created_at < '2024-01-01' AND level = 'debug'");
    fn__14019 = function()
      return 'delete multi where';
    end;
    temper.test_assert(test_1256, t_1267, fn__14019);
    return nil;
  end);
end;
Test_.test_deleteQueryBubblesWithoutWhere__2590 = function()
  temper.test('DeleteQuery bubbles without WHERE', function(test_1268)
    local didBubble__1853, local_1269, local_1270, local_1271, fn__14015;
    local_1269, local_1270, local_1271 = temper.pcall(function()
      deleteFrom(sid__709('users')):toSql();
      didBubble__1853 = false;
    end);
    if local_1269 then
    else
      didBubble__1853 = true;
    end
    fn__14015 = function()
      return 'delete without WHERE should bubble';
    end;
    temper.test_assert(test_1268, didBubble__1853, fn__14015);
    return nil;
  end);
end;
Test_.test_deleteQueryOrWhere__2591 = function()
  temper.test('DeleteQuery orWhere', function(test_1273)
    local t_1274, t_1275, t_1276, t_1277, t_1278, t_1279, q__1855, local_1280, local_1281, local_1282, t_1284, fn__13999;
    local_1280, local_1281, local_1282 = temper.pcall(function()
      t_1274 = sid__709('sessions');
      t_1275 = SqlBuilder();
      t_1275:appendSafe('expired = ');
      t_1275:appendBoolean(true);
      t_1276 = t_1275.accumulated;
      t_1277 = deleteFrom(t_1274):where(t_1276);
      t_1278 = SqlBuilder();
      t_1278:appendSafe('created_at < ');
      t_1278:appendString('2023-01-01');
      t_1279 = t_1277:orWhere(t_1278.accumulated):toSql();
      q__1855 = t_1279;
    end);
    if local_1280 then
    else
      q__1855 = temper.bubble();
    end
    t_1284 = temper.str_eq(q__1855:toString(), "DELETE FROM sessions WHERE expired = TRUE OR created_at < '2023-01-01'");
    fn__13999 = function()
      return 'delete orWhere';
    end;
    temper.test_assert(test_1273, t_1284, fn__13999);
    return nil;
  end);
end;
Test_.test_deleteQueryWithLimit__2594 = function()
  temper.test('DeleteQuery with limit', function(test_1285)
    local t_1286, t_1287, t_1288, t_1289, t_1290, q__1857, local_1291, local_1292, local_1293, t_1295, fn__13988;
    local_1291, local_1292, local_1293 = temper.pcall(function()
      t_1286 = sid__709('logs');
      t_1287 = SqlBuilder();
      t_1287:appendSafe('level = ');
      t_1287:appendString('debug');
      t_1288 = t_1287.accumulated;
      t_1289 = deleteFrom(t_1286):where(t_1288):limit(1000);
      t_1290 = t_1289:toSql();
      q__1857 = t_1290;
    end);
    if local_1291 then
    else
      q__1857 = temper.bubble();
    end
    t_1295 = temper.str_eq(q__1857:toString(), "DELETE FROM logs WHERE level = 'debug' LIMIT 1000");
    fn__13988 = function()
      return 'delete limit';
    end;
    temper.test_assert(test_1285, t_1295, fn__13988);
    return nil;
  end);
end;
Test_.test_orderByNullsNullsFirst__2596 = function()
  temper.test('orderByNulls NULLS FIRST', function(test_1296)
    local t_1297, t_1298, t_1299, q__1859, t_1300, fn__13978;
    t_1297 = sid__709('users');
    t_1298 = sid__709('email');
    t_1299 = NullsFirst();
    q__1859 = from(t_1297):orderByNulls(t_1298, true, t_1299);
    t_1300 = temper.str_eq(q__1859:toSql():toString(), 'SELECT * FROM users ORDER BY email ASC NULLS FIRST');
    fn__13978 = function()
      return 'nulls first';
    end;
    temper.test_assert(test_1296, t_1300, fn__13978);
    return nil;
  end);
end;
Test_.test_orderByNullsNullsLast__2597 = function()
  temper.test('orderByNulls NULLS LAST', function(test_1301)
    local t_1302, t_1303, t_1304, q__1861, t_1305, fn__13968;
    t_1302 = sid__709('users');
    t_1303 = sid__709('score');
    t_1304 = NullsLast();
    q__1861 = from(t_1302):orderByNulls(t_1303, false, t_1304);
    t_1305 = temper.str_eq(q__1861:toSql():toString(), 'SELECT * FROM users ORDER BY score DESC NULLS LAST');
    fn__13968 = function()
      return 'nulls last';
    end;
    temper.test_assert(test_1301, t_1305, fn__13968);
    return nil;
  end);
end;
Test_.test_mixedOrderByAndOrderByNulls__2598 = function()
  temper.test('mixed orderBy and orderByNulls', function(test_1306)
    local t_1307, t_1308, q__1863, t_1309, fn__13956;
    t_1307 = sid__709('users');
    t_1308 = sid__709('name');
    q__1863 = from(t_1307):orderBy(t_1308, true):orderByNulls(sid__709('email'), true, NullsFirst());
    t_1309 = temper.str_eq(q__1863:toSql():toString(), 'SELECT * FROM users ORDER BY name ASC, email ASC NULLS FIRST');
    fn__13956 = function()
      return 'mixed order';
    end;
    temper.test_assert(test_1306, t_1309, fn__13956);
    return nil;
  end);
end;
Test_.test_crossJoin__2599 = function()
  temper.test('crossJoin', function(test_1310)
    local t_1311, t_1312, q__1865, t_1313, fn__13947;
    t_1311 = sid__709('users');
    t_1312 = sid__709('colors');
    q__1865 = from(t_1311):crossJoin(t_1312);
    t_1313 = temper.str_eq(q__1865:toSql():toString(), 'SELECT * FROM users CROSS JOIN colors');
    fn__13947 = function()
      return 'cross join';
    end;
    temper.test_assert(test_1310, t_1313, fn__13947);
    return nil;
  end);
end;
Test_.test_crossJoinCombinedWithOtherJoins__2600 = function()
  temper.test('crossJoin combined with other joins', function(test_1314)
    local t_1315, t_1316, t_1317, t_1318, q__1867, t_1319, fn__13933;
    t_1315 = sid__709('users');
    t_1316 = sid__709('orders');
    t_1317 = SqlBuilder();
    t_1317:appendSafe('users.id = orders.user_id');
    t_1318 = t_1317.accumulated;
    q__1867 = from(t_1315):innerJoin(t_1316, t_1318):crossJoin(sid__709('colors'));
    t_1319 = temper.str_eq(q__1867:toSql():toString(), 'SELECT * FROM users INNER JOIN orders ON users.id = orders.user_id CROSS JOIN colors');
    fn__13933 = function()
      return 'cross + inner join';
    end;
    temper.test_assert(test_1314, t_1319, fn__13933);
    return nil;
  end);
end;
Test_.test_lockForUpdate__2602 = function()
  temper.test('lock FOR UPDATE', function(test_1320)
    local t_1321, t_1322, t_1323, q__1869, t_1324, fn__13919;
    t_1321 = sid__709('users');
    t_1322 = SqlBuilder();
    t_1322:appendSafe('id = ');
    t_1322:appendInt32(1);
    t_1323 = t_1322.accumulated;
    q__1869 = from(t_1321):where(t_1323):lock(ForUpdate());
    t_1324 = temper.str_eq(q__1869:toSql():toString(), 'SELECT * FROM users WHERE id = 1 FOR UPDATE');
    fn__13919 = function()
      return 'for update';
    end;
    temper.test_assert(test_1320, t_1324, fn__13919);
    return nil;
  end);
end;
Test_.test_lockForShare__2604 = function()
  temper.test('lock FOR SHARE', function(test_1325)
    local t_1326, t_1327, q__1871, t_1328, fn__13908;
    t_1326 = sid__709('users');
    t_1327 = sid__709('name');
    q__1871 = from(t_1326):select(temper.listof(t_1327)):lock(ForShare());
    t_1328 = temper.str_eq(q__1871:toSql():toString(), 'SELECT name FROM users FOR SHARE');
    fn__13908 = function()
      return 'for share';
    end;
    temper.test_assert(test_1325, t_1328, fn__13908);
    return nil;
  end);
end;
Test_.test_lockWithFullQuery__2605 = function()
  temper.test('lock with full query', function(test_1329)
    local t_1330, t_1331, t_1332, t_1333, t_1334, q__1873, local_1335, local_1336, local_1337, t_1339, fn__13894;
    local_1335, local_1336, local_1337 = temper.pcall(function()
      t_1330 = sid__709('accounts');
      t_1331 = SqlBuilder();
      t_1331:appendSafe('id = ');
      t_1331:appendInt32(42);
      t_1332 = t_1331.accumulated;
      t_1334 = from(t_1330):where(t_1332):limit(1);
      t_1333 = t_1334:lock(ForUpdate());
      q__1873 = t_1333;
    end);
    if local_1335 then
    else
      q__1873 = temper.bubble();
    end
    t_1339 = temper.str_eq(q__1873:toSql():toString(), 'SELECT * FROM accounts WHERE id = 42 LIMIT 1 FOR UPDATE');
    fn__13894 = function()
      return 'lock full query';
    end;
    temper.test_assert(test_1329, t_1339, fn__13894);
    return nil;
  end);
end;
Test_.test_queryBuilderImmutabilityTwoQueriesFromSameBase__2607 = function()
  temper.test('query builder immutability - two queries from same base', function(test_1340)
    local t_1341, t_1342, t_1343, t_1344, t_1345, base__1875, q1__1876, local_1346, local_1347, local_1348, q2__1877, local_1350, local_1351, local_1352, t_1354, fn__13877, t_1355, fn__13876;
    t_1343 = sid__709('users');
    t_1344 = SqlBuilder();
    t_1344:appendSafe('active = ');
    t_1344:appendBoolean(true);
    t_1345 = t_1344.accumulated;
    base__1875 = from(t_1343):where(t_1345);
    local_1346, local_1347, local_1348 = temper.pcall(function()
      t_1341 = base__1875:limit(10);
      q1__1876 = t_1341;
    end);
    if local_1346 then
    else
      q1__1876 = temper.bubble();
    end
    local_1350, local_1351, local_1352 = temper.pcall(function()
      t_1342 = base__1875:limit(20);
      q2__1877 = t_1342;
    end);
    if local_1350 then
    else
      q2__1877 = temper.bubble();
    end
    t_1354 = temper.str_eq(q1__1876:toSql():toString(), 'SELECT * FROM users WHERE active = TRUE LIMIT 10');
    fn__13877 = function()
      return 'q1';
    end;
    temper.test_assert(test_1340, t_1354, fn__13877);
    t_1355 = temper.str_eq(q2__1877:toSql():toString(), 'SELECT * FROM users WHERE active = TRUE LIMIT 20');
    fn__13876 = function()
      return 'q2';
    end;
    temper.test_assert(test_1340, t_1355, fn__13876);
    return nil;
  end);
end;
Test_.test_limitZeroProducesLimit0__2609 = function()
  temper.test('limit zero produces LIMIT 0', function(test_1356)
    local t_1357, q__1879, local_1358, local_1359, local_1360, t_1362, fn__13869;
    local_1358, local_1359, local_1360 = temper.pcall(function()
      t_1357 = from(sid__709('users')):limit(0);
      q__1879 = t_1357;
    end);
    if local_1358 then
    else
      q__1879 = temper.bubble();
    end
    t_1362 = temper.str_eq(q__1879:toSql():toString(), 'SELECT * FROM users LIMIT 0');
    fn__13869 = function()
      return 'limit 0';
    end;
    temper.test_assert(test_1356, t_1362, fn__13869);
    return nil;
  end);
end;
Test_.test_safeToSqlWithZeroDefaultLimit__2610 = function()
  temper.test('safeToSql with zero defaultLimit', function(test_1363)
    local t_1364, q__1881, s__1882, local_1365, local_1366, local_1367, t_1369, fn__13863;
    q__1881 = from(sid__709('users'));
    local_1365, local_1366, local_1367 = temper.pcall(function()
      t_1364 = q__1881:safeToSql(0);
      s__1882 = t_1364;
    end);
    if local_1365 then
    else
      s__1882 = temper.bubble();
    end
    t_1369 = temper.str_eq(s__1882:toString(), 'SELECT * FROM users LIMIT 0');
    fn__13863 = function()
      return 'safeToSql 0';
    end;
    temper.test_assert(test_1363, t_1369, fn__13863);
    return nil;
  end);
end;
Test_.test_updateQueryLimitBubblesOnNegative__2611 = function()
  temper.test('UpdateQuery limit bubbles on negative', function(test_1370)
    local t_1371, t_1372, t_1373, t_1374, t_1375, didBubble__1884, local_1376, local_1377, local_1378, fn__13851;
    local_1376, local_1377, local_1378 = temper.pcall(function()
      t_1371 = sid__709('users');
      t_1372 = sid__709('name');
      t_1373 = SqlString('x');
      t_1374 = update(t_1371):set(t_1372, t_1373);
      t_1375 = SqlBuilder();
      t_1375:appendSafe('id = ');
      t_1375:appendInt32(1);
      t_1374:where(t_1375.accumulated):limit(-1);
      didBubble__1884 = false;
    end);
    if local_1376 then
    else
      didBubble__1884 = true;
    end
    fn__13851 = function()
      return 'UpdateQuery negative limit should bubble';
    end;
    temper.test_assert(test_1370, didBubble__1884, fn__13851);
    return nil;
  end);
end;
Test_.test_deleteQueryLimitBubblesOnNegative__2613 = function()
  temper.test('DeleteQuery limit bubbles on negative', function(test_1380)
    local t_1381, t_1382, t_1383, didBubble__1886, local_1384, local_1385, local_1386, fn__13842;
    local_1384, local_1385, local_1386 = temper.pcall(function()
      t_1381 = sid__709('users');
      t_1382 = SqlBuilder();
      t_1382:appendSafe('id = ');
      t_1382:appendInt32(1);
      t_1383 = t_1382.accumulated;
      deleteFrom(t_1381):where(t_1383):limit(-1);
      didBubble__1886 = false;
    end);
    if local_1384 then
    else
      didBubble__1886 = true;
    end
    fn__13842 = function()
      return 'DeleteQuery negative limit should bubble';
    end;
    temper.test_assert(test_1380, didBubble__1886, fn__13842);
    return nil;
  end);
end;
Test_.test_updateQueryImmutabilityTwoFromSameBase__2615 = function()
  temper.test('UpdateQuery immutability - two from same base', function(test_1388)
    local t_1389, t_1390, t_1391, t_1392, t_1393, t_1394, t_1395, t_1396, t_1397, base__1888, q1__1889, q2__1890, local_1398, local_1399, local_1400, s1__1891, local_1402, local_1403, local_1404, s2__1892, t_1406, fn__13811, t_1407, fn__13810, t_1408, fn__13809;
    t_1393 = sid__709('users');
    t_1394 = sid__709('name');
    t_1395 = SqlString('Alice');
    t_1396 = update(t_1393):set(t_1394, t_1395);
    t_1397 = SqlBuilder();
    t_1397:appendSafe('id = ');
    t_1397:appendInt32(1);
    base__1888 = t_1396:where(t_1397.accumulated);
    q1__1889 = base__1888:set(sid__709('age'), SqlInt32(25));
    q2__1890 = base__1888:set(sid__709('age'), SqlInt32(30));
    local_1398, local_1399, local_1400 = temper.pcall(function()
      t_1389 = q1__1889:toSql();
      t_1390 = t_1389;
    end);
    if local_1398 then
    else
      t_1390 = temper.bubble();
    end
    s1__1891 = t_1390:toString();
    local_1402, local_1403, local_1404 = temper.pcall(function()
      t_1391 = q2__1890:toSql();
      t_1392 = t_1391;
    end);
    if local_1402 then
    else
      t_1392 = temper.bubble();
    end
    s2__1892 = t_1392:toString();
    t_1406 = temper.is_string_index(temper.string_indexof(s1__1891, '25'));
    fn__13811 = function()
      return temper.concat('q1 should have 25: ', s1__1891);
    end;
    temper.test_assert(test_1388, t_1406, fn__13811);
    t_1407 = temper.is_string_index(temper.string_indexof(s2__1892, '30'));
    fn__13810 = function()
      return temper.concat('q2 should have 30: ', s2__1892);
    end;
    temper.test_assert(test_1388, t_1407, fn__13810);
    t_1408 = not temper.is_string_index(temper.string_indexof(s1__1891, '30'));
    fn__13809 = function()
      return temper.concat('q1 should NOT have 30: ', s1__1891);
    end;
    temper.test_assert(test_1388, t_1408, fn__13809);
    return nil;
  end);
end;
Test_.test_deleteQueryImmutability__2617 = function()
  temper.test('DeleteQuery immutability', function(test_1409)
    local t_1410, t_1411, t_1412, t_1413, t_1414, t_1415, t_1416, base__1894, t_1417, q1__1895, t_1418, q2__1896, local_1419, local_1420, local_1421, s1__1897, local_1423, local_1424, local_1425, s2__1898, t_1427, fn__13777, t_1428, fn__13776, t_1429, fn__13775;
    t_1414 = sid__709('users');
    t_1415 = SqlBuilder();
    t_1415:appendSafe('active = ');
    t_1415:appendBoolean(false);
    t_1416 = t_1415.accumulated;
    base__1894 = deleteFrom(t_1414):where(t_1416);
    t_1417 = SqlBuilder();
    t_1417:appendSafe('age < ');
    t_1417:appendInt32(18);
    q1__1895 = base__1894:where(t_1417.accumulated);
    t_1418 = SqlBuilder();
    t_1418:appendSafe('age > ');
    t_1418:appendInt32(65);
    q2__1896 = base__1894:where(t_1418.accumulated);
    local_1419, local_1420, local_1421 = temper.pcall(function()
      t_1410 = q1__1895:toSql();
      t_1411 = t_1410;
    end);
    if local_1419 then
    else
      t_1411 = temper.bubble();
    end
    s1__1897 = t_1411:toString();
    local_1423, local_1424, local_1425 = temper.pcall(function()
      t_1412 = q2__1896:toSql();
      t_1413 = t_1412;
    end);
    if local_1423 then
    else
      t_1413 = temper.bubble();
    end
    s2__1898 = t_1413:toString();
    t_1427 = temper.is_string_index(temper.string_indexof(s1__1897, 'age < 18'));
    fn__13777 = function()
      return temper.concat('q1: ', s1__1897);
    end;
    temper.test_assert(test_1409, t_1427, fn__13777);
    t_1428 = temper.is_string_index(temper.string_indexof(s2__1898, 'age > 65'));
    fn__13776 = function()
      return temper.concat('q2: ', s2__1898);
    end;
    temper.test_assert(test_1409, t_1428, fn__13776);
    t_1429 = not temper.is_string_index(temper.string_indexof(s1__1897, 'age > 65'));
    fn__13775 = function()
      return temper.concat('q1 should not have q2 condition: ', s1__1897);
    end;
    temper.test_assert(test_1409, t_1429, fn__13775);
    return nil;
  end);
end;
Test_.test_safeIdentifierAcceptsValidNames__2621 = function()
  temper.test('safeIdentifier accepts valid names', function(test_1430)
    local t_1431, id__1946, local_1432, local_1433, local_1434, t_1436, fn__13770;
    local_1432, local_1433, local_1434 = temper.pcall(function()
      t_1431 = safeIdentifier('user_name');
      id__1946 = t_1431;
    end);
    if local_1432 then
    else
      id__1946 = temper.bubble();
    end
    t_1436 = temper.str_eq(id__1946.sqlValue, 'user_name');
    fn__13770 = function()
      return 'value should round-trip';
    end;
    temper.test_assert(test_1430, t_1436, fn__13770);
    return nil;
  end);
end;
Test_.test_safeIdentifierRejectsEmptyString__2622 = function()
  temper.test('safeIdentifier rejects empty string', function(test_1437)
    local didBubble__1948, local_1438, local_1439, local_1440, fn__13767;
    local_1438, local_1439, local_1440 = temper.pcall(function()
      safeIdentifier('');
      didBubble__1948 = false;
    end);
    if local_1438 then
    else
      didBubble__1948 = true;
    end
    fn__13767 = function()
      return 'empty string should bubble';
    end;
    temper.test_assert(test_1437, didBubble__1948, fn__13767);
    return nil;
  end);
end;
Test_.test_safeIdentifierRejectsLeadingDigit__2623 = function()
  temper.test('safeIdentifier rejects leading digit', function(test_1442)
    local didBubble__1950, local_1443, local_1444, local_1445, fn__13764;
    local_1443, local_1444, local_1445 = temper.pcall(function()
      safeIdentifier('1col');
      didBubble__1950 = false;
    end);
    if local_1443 then
    else
      didBubble__1950 = true;
    end
    fn__13764 = function()
      return 'leading digit should bubble';
    end;
    temper.test_assert(test_1442, didBubble__1950, fn__13764);
    return nil;
  end);
end;
Test_.test_safeIdentifierRejectsSqlMetacharacters__2624 = function()
  temper.test('safeIdentifier rejects SQL metacharacters', function(test_1447)
    local cases__1952, fn__13761;
    cases__1952 = temper.listof('name); DROP TABLE', "col'", 'a b', 'a-b', 'a.b', 'a;b');
    fn__13761 = function(c__1953)
      local didBubble__1954, local_1448, local_1449, local_1450, fn__13758;
      local_1448, local_1449, local_1450 = temper.pcall(function()
        safeIdentifier(c__1953);
        didBubble__1954 = false;
      end);
      if local_1448 then
      else
        didBubble__1954 = true;
      end
      fn__13758 = function()
        return temper.concat('should reject: ', c__1953);
      end;
      temper.test_assert(test_1447, didBubble__1954, fn__13758);
      return nil;
    end;
    temper.list_foreach(cases__1952, fn__13761);
    return nil;
  end);
end;
Test_.test_tableDefFieldLookupFound__2625 = function()
  temper.test('TableDef field lookup - found', function(test_1452)
    local t_1453, t_1454, t_1455, t_1456, t_1457, t_1458, t_1459, local_1460, local_1461, local_1462, local_1464, local_1465, local_1466, t_1468, t_1469, local_1470, local_1471, local_1472, t_1474, t_1475, td__1956, f__1957, local_1476, local_1477, local_1478, t_1480, fn__13747;
    local_1460, local_1461, local_1462 = temper.pcall(function()
      t_1453 = safeIdentifier('users');
      t_1454 = t_1453;
    end);
    if local_1460 then
    else
      t_1454 = temper.bubble();
    end
    local_1464, local_1465, local_1466 = temper.pcall(function()
      t_1455 = safeIdentifier('name');
      t_1456 = t_1455;
    end);
    if local_1464 then
    else
      t_1456 = temper.bubble();
    end
    t_1468 = StringField();
    t_1469 = FieldDef(t_1456, t_1468, false, temper.null, false);
    local_1470, local_1471, local_1472 = temper.pcall(function()
      t_1457 = safeIdentifier('age');
      t_1458 = t_1457;
    end);
    if local_1470 then
    else
      t_1458 = temper.bubble();
    end
    t_1474 = IntField();
    t_1475 = FieldDef(t_1458, t_1474, false, temper.null, false);
    td__1956 = TableDef(t_1454, temper.listof(t_1469, t_1475), temper.null);
    local_1476, local_1477, local_1478 = temper.pcall(function()
      t_1459 = td__1956:field('age');
      f__1957 = t_1459;
    end);
    if local_1476 then
    else
      f__1957 = temper.bubble();
    end
    t_1480 = temper.str_eq(f__1957.name.sqlValue, 'age');
    fn__13747 = function()
      return 'should find age field';
    end;
    temper.test_assert(test_1452, t_1480, fn__13747);
    return nil;
  end);
end;
Test_.test_tableDefFieldLookupNotFoundBubbles__2626 = function()
  temper.test('TableDef field lookup - not found bubbles', function(test_1481)
    local t_1482, t_1483, t_1484, t_1485, local_1486, local_1487, local_1488, local_1490, local_1491, local_1492, t_1494, t_1495, td__1959, didBubble__1960, local_1496, local_1497, local_1498, fn__13741;
    local_1486, local_1487, local_1488 = temper.pcall(function()
      t_1482 = safeIdentifier('users');
      t_1483 = t_1482;
    end);
    if local_1486 then
    else
      t_1483 = temper.bubble();
    end
    local_1490, local_1491, local_1492 = temper.pcall(function()
      t_1484 = safeIdentifier('name');
      t_1485 = t_1484;
    end);
    if local_1490 then
    else
      t_1485 = temper.bubble();
    end
    t_1494 = StringField();
    t_1495 = FieldDef(t_1485, t_1494, false, temper.null, false);
    td__1959 = TableDef(t_1483, temper.listof(t_1495), temper.null);
    local_1496, local_1497, local_1498 = temper.pcall(function()
      td__1959:field('nonexistent');
      didBubble__1960 = false;
    end);
    if local_1496 then
    else
      didBubble__1960 = true;
    end
    fn__13741 = function()
      return 'unknown field should bubble';
    end;
    temper.test_assert(test_1481, didBubble__1960, fn__13741);
    return nil;
  end);
end;
Test_.test_fieldDefNullableFlag__2627 = function()
  temper.test('FieldDef nullable flag', function(test_1500)
    local t_1501, t_1502, t_1503, t_1504, local_1505, local_1506, local_1507, t_1509, required__1962, local_1510, local_1511, local_1512, t_1514, optional__1963, t_1515, fn__13729, t_1516, fn__13728;
    local_1505, local_1506, local_1507 = temper.pcall(function()
      t_1501 = safeIdentifier('email');
      t_1502 = t_1501;
    end);
    if local_1505 then
    else
      t_1502 = temper.bubble();
    end
    t_1509 = StringField();
    required__1962 = FieldDef(t_1502, t_1509, false, temper.null, false);
    local_1510, local_1511, local_1512 = temper.pcall(function()
      t_1503 = safeIdentifier('bio');
      t_1504 = t_1503;
    end);
    if local_1510 then
    else
      t_1504 = temper.bubble();
    end
    t_1514 = StringField();
    optional__1963 = FieldDef(t_1504, t_1514, true, temper.null, false);
    t_1515 = not required__1962.nullable;
    fn__13729 = function()
      return 'required field should not be nullable';
    end;
    temper.test_assert(test_1500, t_1515, fn__13729);
    t_1516 = optional__1963.nullable;
    fn__13728 = function()
      return 'optional field should be nullable';
    end;
    temper.test_assert(test_1500, t_1516, fn__13728);
    return nil;
  end);
end;
Test_.test_pkNameDefaultsToIdWhenPrimaryKeyIsNull__2628 = function()
  temper.test('pkName defaults to id when primaryKey is null', function(test_1517)
    local t_1518, t_1519, t_1520, t_1521, local_1522, local_1523, local_1524, local_1526, local_1527, local_1528, t_1530, t_1531, td__1965, t_1532, fn__13720;
    local_1522, local_1523, local_1524 = temper.pcall(function()
      t_1518 = safeIdentifier('users');
      t_1519 = t_1518;
    end);
    if local_1522 then
    else
      t_1519 = temper.bubble();
    end
    local_1526, local_1527, local_1528 = temper.pcall(function()
      t_1520 = safeIdentifier('name');
      t_1521 = t_1520;
    end);
    if local_1526 then
    else
      t_1521 = temper.bubble();
    end
    t_1530 = StringField();
    t_1531 = FieldDef(t_1521, t_1530, false, temper.null, false);
    td__1965 = TableDef(t_1519, temper.listof(t_1531), temper.null);
    t_1532 = temper.str_eq(td__1965:pkName(), 'id');
    fn__13720 = function()
      return 'default pk should be id';
    end;
    temper.test_assert(test_1517, t_1532, fn__13720);
    return nil;
  end);
end;
Test_.test_pkNameReturnsCustomPrimaryKey__2629 = function()
  temper.test('pkName returns custom primary key', function(test_1533)
    local t_1534, t_1535, t_1536, t_1537, t_1538, t_1539, local_1540, local_1541, local_1542, local_1544, local_1545, local_1546, t_1548, t_1549, local_1550, local_1551, local_1552, td__1967, t_1554, fn__13712;
    local_1540, local_1541, local_1542 = temper.pcall(function()
      t_1534 = safeIdentifier('users');
      t_1535 = t_1534;
    end);
    if local_1540 then
    else
      t_1535 = temper.bubble();
    end
    local_1544, local_1545, local_1546 = temper.pcall(function()
      t_1536 = safeIdentifier('user_id');
      t_1537 = t_1536;
    end);
    if local_1544 then
    else
      t_1537 = temper.bubble();
    end
    t_1548 = IntField();
    t_1549 = temper.listof(FieldDef(t_1537, t_1548, false, temper.null, false));
    local_1550, local_1551, local_1552 = temper.pcall(function()
      t_1538 = safeIdentifier('user_id');
      t_1539 = t_1538;
    end);
    if local_1550 then
    else
      t_1539 = temper.bubble();
    end
    td__1967 = TableDef(t_1535, t_1549, t_1539);
    t_1554 = temper.str_eq(td__1967:pkName(), 'user_id');
    fn__13712 = function()
      return 'custom pk should be user_id';
    end;
    temper.test_assert(test_1533, t_1554, fn__13712);
    return nil;
  end);
end;
Test_.test_timestampsReturnsTwoDateFieldDefs__2630 = function()
  temper.test('timestamps returns two DateField defs', function(test_1555)
    local t_1556, ts__1969, local_1557, local_1558, local_1559, t_1561, fn__13677, t_1562, fn__13676, t_1563, fn__13675, t_1564, fn__13674, t_1565, fn__13673, t_1566, fn__13672, t_1567, fn__13671;
    local_1557, local_1558, local_1559 = temper.pcall(function()
      t_1556 = timestamps();
      ts__1969 = t_1556;
    end);
    if local_1557 then
    else
      ts__1969 = temper.bubble();
    end
    t_1561 = (temper.list_length(ts__1969) == 2);
    fn__13677 = function()
      return 'should return 2 fields';
    end;
    temper.test_assert(test_1555, t_1561, fn__13677);
    t_1562 = temper.str_eq((temper.list_get(ts__1969, 0)).name.sqlValue, 'inserted_at');
    fn__13676 = function()
      return 'first should be inserted_at';
    end;
    temper.test_assert(test_1555, t_1562, fn__13676);
    t_1563 = temper.str_eq((temper.list_get(ts__1969, 1)).name.sqlValue, 'updated_at');
    fn__13675 = function()
      return 'second should be updated_at';
    end;
    temper.test_assert(test_1555, t_1563, fn__13675);
    t_1564 = (temper.list_get(ts__1969, 0)).nullable;
    fn__13674 = function()
      return 'inserted_at should be nullable';
    end;
    temper.test_assert(test_1555, t_1564, fn__13674);
    t_1565 = (temper.list_get(ts__1969, 1)).nullable;
    fn__13673 = function()
      return 'updated_at should be nullable';
    end;
    temper.test_assert(test_1555, t_1565, fn__13673);
    t_1566 = not temper.is_null((temper.list_get(ts__1969, 0)).defaultValue);
    fn__13672 = function()
      return 'inserted_at should have default';
    end;
    temper.test_assert(test_1555, t_1566, fn__13672);
    t_1567 = not temper.is_null((temper.list_get(ts__1969, 1)).defaultValue);
    fn__13671 = function()
      return 'updated_at should have default';
    end;
    temper.test_assert(test_1555, t_1567, fn__13671);
    return nil;
  end);
end;
Test_.test_fieldDefDefaultValueField__2631 = function()
  temper.test('FieldDef defaultValue field', function(test_1568)
    local t_1569, t_1570, t_1571, t_1572, local_1573, local_1574, local_1575, t_1577, t_1578, withDefault__1971, local_1579, local_1580, local_1581, t_1583, withoutDefault__1972, t_1584, fn__13657, t_1585, fn__13656;
    local_1573, local_1574, local_1575 = temper.pcall(function()
      t_1569 = safeIdentifier('status');
      t_1570 = t_1569;
    end);
    if local_1573 then
    else
      t_1570 = temper.bubble();
    end
    t_1577 = StringField();
    t_1578 = SqlDefault();
    withDefault__1971 = FieldDef(t_1570, t_1577, false, t_1578, false);
    local_1579, local_1580, local_1581 = temper.pcall(function()
      t_1571 = safeIdentifier('name');
      t_1572 = t_1571;
    end);
    if local_1579 then
    else
      t_1572 = temper.bubble();
    end
    t_1583 = StringField();
    withoutDefault__1972 = FieldDef(t_1572, t_1583, false, temper.null, false);
    t_1584 = not temper.is_null(withDefault__1971.defaultValue);
    fn__13657 = function()
      return 'should have default';
    end;
    temper.test_assert(test_1568, t_1584, fn__13657);
    t_1585 = temper.is_null(withoutDefault__1972.defaultValue);
    fn__13656 = function()
      return 'should not have default';
    end;
    temper.test_assert(test_1568, t_1585, fn__13656);
    return nil;
  end);
end;
Test_.test_fieldDefVirtualFlag__2632 = function()
  temper.test('FieldDef virtual flag', function(test_1586)
    local t_1587, t_1588, t_1589, t_1590, local_1591, local_1592, local_1593, t_1595, normal__1974, local_1596, local_1597, local_1598, t_1600, virt__1975, t_1601, fn__13644, t_1602, fn__13643;
    local_1591, local_1592, local_1593 = temper.pcall(function()
      t_1587 = safeIdentifier('name');
      t_1588 = t_1587;
    end);
    if local_1591 then
    else
      t_1588 = temper.bubble();
    end
    t_1595 = StringField();
    normal__1974 = FieldDef(t_1588, t_1595, false, temper.null, false);
    local_1596, local_1597, local_1598 = temper.pcall(function()
      t_1589 = safeIdentifier('full_name');
      t_1590 = t_1589;
    end);
    if local_1596 then
    else
      t_1590 = temper.bubble();
    end
    t_1600 = StringField();
    virt__1975 = FieldDef(t_1590, t_1600, true, temper.null, true);
    t_1601 = not normal__1974.virtual;
    fn__13644 = function()
      return 'normal field should not be virtual';
    end;
    temper.test_assert(test_1586, t_1601, fn__13644);
    t_1602 = virt__1975.virtual;
    fn__13643 = function()
      return 'virtual field should be virtual';
    end;
    temper.test_assert(test_1586, t_1602, fn__13643);
    return nil;
  end);
end;
Test_.test_safeIdentifierAcceptsSingleCharacterNames__2633 = function()
  temper.test('safeIdentifier accepts single character names', function(test_1603)
    local t_1604, t_1605, a__1977, local_1606, local_1607, local_1608, t_1610, fn__13634, u__1978, local_1611, local_1612, local_1613, t_1615, fn__13633;
    local_1606, local_1607, local_1608 = temper.pcall(function()
      t_1604 = safeIdentifier('a');
      a__1977 = t_1604;
    end);
    if local_1606 then
    else
      a__1977 = temper.bubble();
    end
    t_1610 = temper.str_eq(a__1977.sqlValue, 'a');
    fn__13634 = function()
      return 'single letter should work';
    end;
    temper.test_assert(test_1603, t_1610, fn__13634);
    local_1611, local_1612, local_1613 = temper.pcall(function()
      t_1605 = safeIdentifier('_');
      u__1978 = t_1605;
    end);
    if local_1611 then
    else
      u__1978 = temper.bubble();
    end
    t_1615 = temper.str_eq(u__1978.sqlValue, '_');
    fn__13633 = function()
      return 'single underscore should work';
    end;
    temper.test_assert(test_1603, t_1615, fn__13633);
    return nil;
  end);
end;
Test_.test_safeIdentifierAcceptsAllUnderscoreNames__2634 = function()
  temper.test('safeIdentifier accepts all-underscore names', function(test_1616)
    local t_1617, id__1980, local_1618, local_1619, local_1620, t_1622, fn__13628;
    local_1618, local_1619, local_1620 = temper.pcall(function()
      t_1617 = safeIdentifier('___');
      id__1980 = t_1617;
    end);
    if local_1618 then
    else
      id__1980 = temper.bubble();
    end
    t_1622 = temper.str_eq(id__1980.sqlValue, '___');
    fn__13628 = function()
      return 'all underscores should work';
    end;
    temper.test_assert(test_1616, t_1622, fn__13628);
    return nil;
  end);
end;
Test_.test_tableDefWithEmptyFieldList__2635 = function()
  temper.test('TableDef with empty field list', function(test_1623)
    local t_1624, t_1625, local_1626, local_1627, local_1628, tbl__1982, didBubble__1983, local_1630, local_1631, local_1632, fn__13624;
    local_1626, local_1627, local_1628 = temper.pcall(function()
      t_1624 = safeIdentifier('empty');
      t_1625 = t_1624;
    end);
    if local_1626 then
    else
      t_1625 = temper.bubble();
    end
    tbl__1982 = TableDef(t_1625, temper.listof(), temper.null);
    local_1630, local_1631, local_1632 = temper.pcall(function()
      tbl__1982:field('anything');
      didBubble__1983 = false;
    end);
    if local_1630 then
    else
      didBubble__1983 = true;
    end
    fn__13624 = function()
      return 'field lookup on empty table should bubble';
    end;
    temper.test_assert(test_1623, didBubble__1983, fn__13624);
    return nil;
  end);
end;
Test_.test_stringEscaping__2636 = function()
  temper.test('string escaping', function(test_1634)
    local build__2113, buildWrong__2114, actual_1636, t_1637, fn__13613, bobbyTables__2119, actual_1638, t_1639, fn__13612, fn__13611;
    build__2113 = function(name__2115)
      local t_1635;
      t_1635 = SqlBuilder();
      t_1635:appendSafe('select * from hi where name = ');
      t_1635:appendString(name__2115);
      return t_1635.accumulated:toString();
    end;
    buildWrong__2114 = function(name__2117)
      return temper.concat("select * from hi where name = '", name__2117, "'");
    end;
    actual_1636 = build__2113('world');
    t_1637 = temper.str_eq(actual_1636, "select * from hi where name = 'world'");
    fn__13613 = function()
      return temper.concat('expected build("world") == (', "select * from hi where name = 'world'", ') not (', actual_1636, ')');
    end;
    temper.test_assert(test_1634, t_1637, fn__13613);
    bobbyTables__2119 = "Robert'); drop table hi;--";
    actual_1638 = build__2113("Robert'); drop table hi;--");
    t_1639 = temper.str_eq(actual_1638, "select * from hi where name = 'Robert''); drop table hi;--'");
    fn__13612 = function()
      return temper.concat('expected build(bobbyTables) == (', "select * from hi where name = 'Robert''); drop table hi;--'", ') not (', actual_1638, ')');
    end;
    temper.test_assert(test_1634, t_1639, fn__13612);
    fn__13611 = function()
      return "expected buildWrong(bobbyTables) == (select * from hi where name = 'Robert'); drop table hi;--') not (select * from hi where name = 'Robert'); drop table hi;--')";
    end;
    temper.test_assert(test_1634, true, fn__13611);
    return nil;
  end);
end;
Test_.test_stringEdgeCases__2644 = function()
  temper.test('string edge cases', function(test_1640)
    local t_1641, actual_1642, t_1643, fn__13573, t_1644, actual_1645, t_1646, fn__13572, t_1647, actual_1648, t_1649, fn__13571, t_1650, actual_1651, t_1652, fn__13570;
    t_1641 = SqlBuilder();
    t_1641:appendSafe('v = ');
    t_1641:appendString('');
    actual_1642 = t_1641.accumulated:toString();
    t_1643 = temper.str_eq(actual_1642, "v = ''");
    fn__13573 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, "").toString() == (', "v = ''", ') not (', actual_1642, ')');
    end;
    temper.test_assert(test_1640, t_1643, fn__13573);
    t_1644 = SqlBuilder();
    t_1644:appendSafe('v = ');
    t_1644:appendString("a''b");
    actual_1645 = t_1644.accumulated:toString();
    t_1646 = temper.str_eq(actual_1645, "v = 'a''''b'");
    fn__13572 = function()
      return temper.concat("expected stringExpr(`-work//src/`.sql, true, \"v = \", \\interpolate, \"a''b\").toString() == (", "v = 'a''''b'", ') not (', actual_1645, ')');
    end;
    temper.test_assert(test_1640, t_1646, fn__13572);
    t_1647 = SqlBuilder();
    t_1647:appendSafe('v = ');
    t_1647:appendString('Hello \xe4\xb8\x96\xe7\x95\x8c');
    actual_1648 = t_1647.accumulated:toString();
    t_1649 = temper.str_eq(actual_1648, "v = 'Hello \xe4\xb8\x96\xe7\x95\x8c'");
    fn__13571 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, "Hello \xe4\xb8\x96\xe7\x95\x8c").toString() == (', "v = 'Hello \xe4\xb8\x96\xe7\x95\x8c'", ') not (', actual_1648, ')');
    end;
    temper.test_assert(test_1640, t_1649, fn__13571);
    t_1650 = SqlBuilder();
    t_1650:appendSafe('v = ');
    t_1650:appendString('Line1\nLine2');
    actual_1651 = t_1650.accumulated:toString();
    t_1652 = temper.str_eq(actual_1651, "v = 'Line1\nLine2'");
    fn__13570 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, "Line1\\nLine2").toString() == (', "v = 'Line1\nLine2'", ') not (', actual_1651, ')');
    end;
    temper.test_assert(test_1640, t_1652, fn__13570);
    return nil;
  end);
end;
Test_.test_numbersAndBooleans__2657 = function()
  temper.test('numbers and booleans', function(test_1653)
    local t_1654, t_1655, actual_1656, t_1657, fn__13544, date__2122, local_1658, local_1659, local_1660, t_1662, actual_1663, t_1664, fn__13543;
    t_1655 = SqlBuilder();
    t_1655:appendSafe('select ');
    t_1655:appendInt32(42);
    t_1655:appendSafe(', ');
    t_1655:appendInt64(temper.int64_constructor(43));
    t_1655:appendSafe(', ');
    t_1655:appendFloat64(19.99);
    t_1655:appendSafe(', ');
    t_1655:appendBoolean(true);
    t_1655:appendSafe(', ');
    t_1655:appendBoolean(false);
    actual_1656 = t_1655.accumulated:toString();
    t_1657 = temper.str_eq(actual_1656, 'select 42, 43, 19.99, TRUE, FALSE');
    fn__13544 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "select ", \\interpolate, 42, ", ", \\interpolate, 43, ", ", \\interpolate, 19.99, ", ", \\interpolate, true, ", ", \\interpolate, false).toString() == (', 'select 42, 43, 19.99, TRUE, FALSE', ') not (', actual_1656, ')');
    end;
    temper.test_assert(test_1653, t_1657, fn__13544);
    local_1658, local_1659, local_1660 = temper.pcall(function()
      t_1654 = temper.date_constructor(2024, 12, 25);
      date__2122 = t_1654;
    end);
    if local_1658 then
    else
      date__2122 = temper.bubble();
    end
    t_1662 = SqlBuilder();
    t_1662:appendSafe('insert into t values (');
    t_1662:appendDate(date__2122);
    t_1662:appendSafe(')');
    actual_1663 = t_1662.accumulated:toString();
    t_1664 = temper.str_eq(actual_1663, "insert into t values ('2024-12-25')");
    fn__13543 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "insert into t values (", \\interpolate, date, ")").toString() == (', "insert into t values ('2024-12-25')", ') not (', actual_1663, ')');
    end;
    temper.test_assert(test_1653, t_1664, fn__13543);
    return nil;
  end);
end;
Test_.test_lists__2664 = function()
  temper.test('lists', function(test_1665)
    local t_1666, t_1667, t_1668, t_1669, t_1670, actual_1671, t_1672, fn__13488, t_1673, actual_1674, t_1675, fn__13487, t_1676, actual_1677, t_1678, fn__13486, t_1679, actual_1680, t_1681, fn__13485, t_1682, actual_1683, t_1684, fn__13484, local_1685, local_1686, local_1687, local_1689, local_1690, local_1691, dates__2124, t_1693, actual_1694, t_1695, fn__13483;
    t_1670 = SqlBuilder();
    t_1670:appendSafe('v IN (');
    t_1670:appendStringList(temper.listof('a', 'b', "c'd"));
    t_1670:appendSafe(')');
    actual_1671 = t_1670.accumulated:toString();
    t_1672 = temper.str_eq(actual_1671, "v IN ('a', 'b', 'c''d')");
    fn__13488 = function()
      return temper.concat("expected stringExpr(`-work//src/`.sql, true, \"v IN (\", \\interpolate, list(\"a\", \"b\", \"c'd\"), \")\").toString() == (", "v IN ('a', 'b', 'c''d')", ') not (', actual_1671, ')');
    end;
    temper.test_assert(test_1665, t_1672, fn__13488);
    t_1673 = SqlBuilder();
    t_1673:appendSafe('v IN (');
    t_1673:appendInt32List(temper.listof(1, 2, 3));
    t_1673:appendSafe(')');
    actual_1674 = t_1673.accumulated:toString();
    t_1675 = temper.str_eq(actual_1674, 'v IN (1, 2, 3)');
    fn__13487 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v IN (", \\interpolate, list(1, 2, 3), ")").toString() == (', 'v IN (1, 2, 3)', ') not (', actual_1674, ')');
    end;
    temper.test_assert(test_1665, t_1675, fn__13487);
    t_1676 = SqlBuilder();
    t_1676:appendSafe('v IN (');
    t_1676:appendInt64List(temper.listof(temper.int64_constructor(1), temper.int64_constructor(2)));
    t_1676:appendSafe(')');
    actual_1677 = t_1676.accumulated:toString();
    t_1678 = temper.str_eq(actual_1677, 'v IN (1, 2)');
    fn__13486 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v IN (", \\interpolate, list(1, 2), ")").toString() == (', 'v IN (1, 2)', ') not (', actual_1677, ')');
    end;
    temper.test_assert(test_1665, t_1678, fn__13486);
    t_1679 = SqlBuilder();
    t_1679:appendSafe('v IN (');
    t_1679:appendFloat64List(temper.listof(1.0, 2.0));
    t_1679:appendSafe(')');
    actual_1680 = t_1679.accumulated:toString();
    t_1681 = temper.str_eq(actual_1680, 'v IN (1.0, 2.0)');
    fn__13485 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v IN (", \\interpolate, list(1.0, 2.0), ")").toString() == (', 'v IN (1.0, 2.0)', ') not (', actual_1680, ')');
    end;
    temper.test_assert(test_1665, t_1681, fn__13485);
    t_1682 = SqlBuilder();
    t_1682:appendSafe('v IN (');
    t_1682:appendBooleanList(temper.listof(true, false));
    t_1682:appendSafe(')');
    actual_1683 = t_1682.accumulated:toString();
    t_1684 = temper.str_eq(actual_1683, 'v IN (TRUE, FALSE)');
    fn__13484 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v IN (", \\interpolate, list(true, false), ")").toString() == (', 'v IN (TRUE, FALSE)', ') not (', actual_1683, ')');
    end;
    temper.test_assert(test_1665, t_1684, fn__13484);
    local_1685, local_1686, local_1687 = temper.pcall(function()
      t_1666 = temper.date_constructor(2024, 1, 1);
      t_1667 = t_1666;
    end);
    if local_1685 then
    else
      t_1667 = temper.bubble();
    end
    local_1689, local_1690, local_1691 = temper.pcall(function()
      t_1668 = temper.date_constructor(2024, 12, 25);
      t_1669 = t_1668;
    end);
    if local_1689 then
    else
      t_1669 = temper.bubble();
    end
    dates__2124 = temper.listof(t_1667, t_1669);
    t_1693 = SqlBuilder();
    t_1693:appendSafe('v IN (');
    t_1693:appendDateList(dates__2124);
    t_1693:appendSafe(')');
    actual_1694 = t_1693.accumulated:toString();
    t_1695 = temper.str_eq(actual_1694, "v IN ('2024-01-01', '2024-12-25')");
    fn__13483 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v IN (", \\interpolate, dates, ")").toString() == (', "v IN ('2024-01-01', '2024-12-25')", ') not (', actual_1694, ')');
    end;
    temper.test_assert(test_1665, t_1695, fn__13483);
    return nil;
  end);
end;
Test_.test_sqlFloat64_naNRendersAsNull__2683 = function()
  temper.test('SqlFloat64 NaN renders as NULL', function(test_1696)
    local nan__2126, t_1697, actual_1698, t_1699, fn__13474;
    nan__2126 = temper.fdiv(0.0, 0.0);
    t_1697 = SqlBuilder();
    t_1697:appendSafe('v = ');
    t_1697:appendFloat64(nan__2126);
    actual_1698 = t_1697.accumulated:toString();
    t_1699 = temper.str_eq(actual_1698, 'v = NULL');
    fn__13474 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, nan).toString() == (', 'v = NULL', ') not (', actual_1698, ')');
    end;
    temper.test_assert(test_1696, t_1699, fn__13474);
    return nil;
  end);
end;
Test_.test_sqlFloat64_infinityRendersAsNull__2687 = function()
  temper.test('SqlFloat64 Infinity renders as NULL', function(test_1700)
    local inf__2128, t_1701, actual_1702, t_1703, fn__13465;
    inf__2128 = temper.fdiv(1.0, 0.0);
    t_1701 = SqlBuilder();
    t_1701:appendSafe('v = ');
    t_1701:appendFloat64(inf__2128);
    actual_1702 = t_1701.accumulated:toString();
    t_1703 = temper.str_eq(actual_1702, 'v = NULL');
    fn__13465 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, inf).toString() == (', 'v = NULL', ') not (', actual_1702, ')');
    end;
    temper.test_assert(test_1700, t_1703, fn__13465);
    return nil;
  end);
end;
Test_.test_sqlFloat64_negativeInfinityRendersAsNull__2691 = function()
  temper.test('SqlFloat64 negative Infinity renders as NULL', function(test_1704)
    local ninf__2130, t_1705, actual_1706, t_1707, fn__13456;
    ninf__2130 = temper.fdiv(-1.0, 0.0);
    t_1705 = SqlBuilder();
    t_1705:appendSafe('v = ');
    t_1705:appendFloat64(ninf__2130);
    actual_1706 = t_1705.accumulated:toString();
    t_1707 = temper.str_eq(actual_1706, 'v = NULL');
    fn__13456 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, ninf).toString() == (', 'v = NULL', ') not (', actual_1706, ')');
    end;
    temper.test_assert(test_1704, t_1707, fn__13456);
    return nil;
  end);
end;
Test_.test_sqlFloat64_normalValuesStillWork__2695 = function()
  temper.test('SqlFloat64 normal values still work', function(test_1708)
    local t_1709, actual_1710, t_1711, fn__13431, t_1712, actual_1713, t_1714, fn__13430, t_1715, actual_1716, t_1717, fn__13429;
    t_1709 = SqlBuilder();
    t_1709:appendSafe('v = ');
    t_1709:appendFloat64(3.14);
    actual_1710 = t_1709.accumulated:toString();
    t_1711 = temper.str_eq(actual_1710, 'v = 3.14');
    fn__13431 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, 3.14).toString() == (', 'v = 3.14', ') not (', actual_1710, ')');
    end;
    temper.test_assert(test_1708, t_1711, fn__13431);
    t_1712 = SqlBuilder();
    t_1712:appendSafe('v = ');
    t_1712:appendFloat64(0.0);
    actual_1713 = t_1712.accumulated:toString();
    t_1714 = temper.str_eq(actual_1713, 'v = 0.0');
    fn__13430 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, 0.0).toString() == (', 'v = 0.0', ') not (', actual_1713, ')');
    end;
    temper.test_assert(test_1708, t_1714, fn__13430);
    t_1715 = SqlBuilder();
    t_1715:appendSafe('v = ');
    t_1715:appendFloat64(-42.5);
    actual_1716 = t_1715.accumulated:toString();
    t_1717 = temper.str_eq(actual_1716, 'v = -42.5');
    fn__13429 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, -42.5).toString() == (', 'v = -42.5', ') not (', actual_1716, ')');
    end;
    temper.test_assert(test_1708, t_1717, fn__13429);
    return nil;
  end);
end;
Test_.test_sqlDateRendersWithQuotes__2705 = function()
  temper.test('SqlDate renders with quotes', function(test_1718)
    local t_1719, d__2133, local_1720, local_1721, local_1722, t_1724, actual_1725, t_1726, fn__13420;
    local_1720, local_1721, local_1722 = temper.pcall(function()
      t_1719 = temper.date_constructor(2024, 6, 15);
      d__2133 = t_1719;
    end);
    if local_1720 then
    else
      d__2133 = temper.bubble();
    end
    t_1724 = SqlBuilder();
    t_1724:appendSafe('v = ');
    t_1724:appendDate(d__2133);
    actual_1725 = t_1724.accumulated:toString();
    t_1726 = temper.str_eq(actual_1725, "v = '2024-06-15'");
    fn__13420 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, d).toString() == (', "v = '2024-06-15'", ') not (', actual_1725, ')');
    end;
    temper.test_assert(test_1718, t_1726, fn__13420);
    return nil;
  end);
end;
Test_.test_nesting__2709 = function()
  temper.test('nesting', function(test_1727)
    local name__2135, t_1728, condition__2136, t_1729, actual_1730, t_1731, fn__13388, t_1732, actual_1733, t_1734, fn__13387, parts__2137, t_1735, actual_1736, t_1737, fn__13386;
    name__2135 = 'Someone';
    t_1728 = SqlBuilder();
    t_1728:appendSafe('where p.last_name = ');
    t_1728:appendString('Someone');
    condition__2136 = t_1728.accumulated;
    t_1729 = SqlBuilder();
    t_1729:appendSafe('select p.id from person p ');
    t_1729:appendFragment(condition__2136);
    actual_1730 = t_1729.accumulated:toString();
    t_1731 = temper.str_eq(actual_1730, "select p.id from person p where p.last_name = 'Someone'");
    fn__13388 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "select p.id from person p ", \\interpolate, condition).toString() == (', "select p.id from person p where p.last_name = 'Someone'", ') not (', actual_1730, ')');
    end;
    temper.test_assert(test_1727, t_1731, fn__13388);
    t_1732 = SqlBuilder();
    t_1732:appendSafe('select p.id from person p ');
    t_1732:appendPart(condition__2136:toSource());
    actual_1733 = t_1732.accumulated:toString();
    t_1734 = temper.str_eq(actual_1733, "select p.id from person p where p.last_name = 'Someone'");
    fn__13387 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "select p.id from person p ", \\interpolate, condition.toSource()).toString() == (', "select p.id from person p where p.last_name = 'Someone'", ') not (', actual_1733, ')');
    end;
    temper.test_assert(test_1727, t_1734, fn__13387);
    parts__2137 = temper.listof(SqlString("a'b"), SqlInt32(3));
    t_1735 = SqlBuilder();
    t_1735:appendSafe('select ');
    t_1735:appendPartList(parts__2137);
    actual_1736 = t_1735.accumulated:toString();
    t_1737 = temper.str_eq(actual_1736, "select 'a''b', 3");
    fn__13386 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "select ", \\interpolate, parts).toString() == (', "select 'a''b', 3", ') not (', actual_1736, ')');
    end;
    temper.test_assert(test_1727, t_1737, fn__13386);
    return nil;
  end);
end;
Test_.test_sqlInt32_negativeAndZeroValues__2720 = function()
  temper.test('SqlInt32 negative and zero values', function(test_1738)
    local t_1739, t_1740, fn__13369, t_1741, t_1742, fn__13368;
    t_1739 = SqlBuilder();
    t_1739:appendSafe('v = ');
    t_1739:appendInt32(-42);
    t_1740 = temper.str_eq(t_1739.accumulated:toString(), 'v = -42');
    fn__13369 = function()
      return 'negative int';
    end;
    temper.test_assert(test_1738, t_1740, fn__13369);
    t_1741 = SqlBuilder();
    t_1741:appendSafe('v = ');
    t_1741:appendInt32(0);
    t_1742 = temper.str_eq(t_1741.accumulated:toString(), 'v = 0');
    fn__13368 = function()
      return 'zero int';
    end;
    temper.test_assert(test_1738, t_1742, fn__13368);
    return nil;
  end);
end;
Test_.test_sqlInt64_negativeValue__2723 = function()
  temper.test('SqlInt64 negative value', function(test_1743)
    local t_1744, t_1745, fn__13359;
    t_1744 = SqlBuilder();
    t_1744:appendSafe('v = ');
    t_1744:appendInt64(temper.int64_constructor(-99));
    t_1745 = temper.str_eq(t_1744.accumulated:toString(), 'v = -99');
    fn__13359 = function()
      return 'negative int64';
    end;
    temper.test_assert(test_1743, t_1745, fn__13359);
    return nil;
  end);
end;
Test_.test_singleElementListRendering__2725 = function()
  temper.test('single element list rendering', function(test_1746)
    local t_1747, t_1748, fn__13340, t_1749, t_1750, fn__13339;
    t_1747 = SqlBuilder();
    t_1747:appendSafe('v IN (');
    t_1747:appendInt32List(temper.listof(42));
    t_1747:appendSafe(')');
    t_1748 = temper.str_eq(t_1747.accumulated:toString(), 'v IN (42)');
    fn__13340 = function()
      return 'single int';
    end;
    temper.test_assert(test_1746, t_1748, fn__13340);
    t_1749 = SqlBuilder();
    t_1749:appendSafe('v IN (');
    t_1749:appendStringList(temper.listof('only'));
    t_1749:appendSafe(')');
    t_1750 = temper.str_eq(t_1749.accumulated:toString(), "v IN ('only')");
    fn__13339 = function()
      return 'single string';
    end;
    temper.test_assert(test_1746, t_1750, fn__13339);
    return nil;
  end);
end;
Test_.test_sqlDefaultRendersDefaultKeyword__2728 = function()
  temper.test('SqlDefault renders DEFAULT keyword', function(test_1751)
    local b__2142, t_1752, fn__13329;
    b__2142 = SqlBuilder();
    b__2142:appendSafe('v = ');
    b__2142:appendPart(SqlDefault());
    t_1752 = temper.str_eq(b__2142.accumulated:toString(), 'v = DEFAULT');
    fn__13329 = function()
      return 'default keyword';
    end;
    temper.test_assert(test_1751, t_1752, fn__13329);
    return nil;
  end);
end;
Test_.test_sqlStringWithBackslash__2729 = function()
  temper.test('SqlString with backslash', function(test_1753)
    local t_1754, t_1755, fn__13320;
    t_1754 = SqlBuilder();
    t_1754:appendSafe('v = ');
    t_1754:appendString('a\\b');
    t_1755 = temper.str_eq(t_1754.accumulated:toString(), "v = 'a\\b'");
    fn__13320 = function()
      return 'backslash passthrough';
    end;
    temper.test_assert(test_1753, t_1755, fn__13320);
    return nil;
  end);
end;
exports = {};
local_1757.LuaUnit.run(local_1756({'--pattern', '^Test_%.', local_1756(arg)}));
return exports;
