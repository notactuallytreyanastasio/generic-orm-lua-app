local temper = require('temper-core');
local safeIdentifier, TableDef, FieldDef, StringField, IntField, FloatField, BoolField, changeset, NumberValidationOpts, SqlDefault, timestamps, deleteSql, from, SqlBuilder, col, SqlInt32, SqlString, countAll, countCol, sumCol, avgCol, minCol, maxCol, unionSql, unionAllSql, intersectSql, exceptSql, subquery, existsSql, update, SqlBoolean, deleteFrom, NullsFirst, NullsLast, ForUpdate, ForShare, local_1540, local_1541, csid__660, userTable__661, sid__662, exports;
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
local_1540 = (unpack or table.unpack);
local_1541 = require('luaunit');
local_1541.FAILURE_PREFIX = temper.test_failure_prefix;
Test_ = {};
csid__660 = function(name__953)
  local return__444, t_248, local_249, local_250, local_251;
  local_249, local_250, local_251 = temper.pcall(function()
    t_248 = safeIdentifier(name__953);
    return__444 = t_248;
  end);
  if local_249 then
  else
    return__444 = temper.bubble();
  end
  return return__444;
end;
userTable__661 = function()
  return TableDef(csid__660('users'), temper.listof(FieldDef(csid__660('name'), StringField(), false, temper.null, false), FieldDef(csid__660('email'), StringField(), false, temper.null, false), FieldDef(csid__660('age'), IntField(), true, temper.null, false), FieldDef(csid__660('score'), FloatField(), true, temper.null, false), FieldDef(csid__660('active'), BoolField(), true, temper.null, false)), temper.null);
end;
Test_.test_castWhitelistsAllowedFields__2120 = function()
  temper.test('cast whitelists allowed fields', function(test_253)
    local params__957, t_254, t_255, t_256, cs__958, t_257, fn__15067, t_258, fn__15066, t_259, fn__15065, t_260, fn__15064;
    params__957 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice'), temper.pair_constructor('email', 'alice@example.com'), temper.pair_constructor('admin', 'true')));
    t_254 = userTable__661();
    t_255 = csid__660('name');
    t_256 = csid__660('email');
    cs__958 = changeset(t_254, params__957):cast(temper.listof(t_255, t_256));
    t_257 = temper.mapped_has(cs__958.changes, 'name');
    fn__15067 = function()
      return 'name should be in changes';
    end;
    temper.test_assert(test_253, t_257, fn__15067);
    t_258 = temper.mapped_has(cs__958.changes, 'email');
    fn__15066 = function()
      return 'email should be in changes';
    end;
    temper.test_assert(test_253, t_258, fn__15066);
    t_259 = not temper.mapped_has(cs__958.changes, 'admin');
    fn__15065 = function()
      return 'admin must be dropped (not in whitelist)';
    end;
    temper.test_assert(test_253, t_259, fn__15065);
    t_260 = cs__958.isValid;
    fn__15064 = function()
      return 'should still be valid';
    end;
    temper.test_assert(test_253, t_260, fn__15064);
    return nil;
  end);
end;
Test_.test_castIsReplacingNotAdditiveSecondCallResetsWhitelist__2121 = function()
  temper.test('cast is replacing not additive \xe2\x80\x94 second call resets whitelist', function(test_261)
    local params__960, t_262, t_263, cs__961, t_264, fn__15046, t_265, fn__15045;
    params__960 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice'), temper.pair_constructor('email', 'alice@example.com')));
    t_262 = userTable__661();
    t_263 = csid__660('name');
    cs__961 = changeset(t_262, params__960):cast(temper.listof(t_263)):cast(temper.listof(csid__660('email')));
    t_264 = not temper.mapped_has(cs__961.changes, 'name');
    fn__15046 = function()
      return 'name must be excluded by second cast';
    end;
    temper.test_assert(test_261, t_264, fn__15046);
    t_265 = temper.mapped_has(cs__961.changes, 'email');
    fn__15045 = function()
      return 'email should be present';
    end;
    temper.test_assert(test_261, t_265, fn__15045);
    return nil;
  end);
end;
Test_.test_castIgnoresEmptyStringValues__2122 = function()
  temper.test('cast ignores empty string values', function(test_266)
    local params__963, t_267, t_268, t_269, cs__964, t_270, fn__15028, t_271, fn__15027;
    params__963 = temper.map_constructor(temper.listof(temper.pair_constructor('name', ''), temper.pair_constructor('email', 'bob@example.com')));
    t_267 = userTable__661();
    t_268 = csid__660('name');
    t_269 = csid__660('email');
    cs__964 = changeset(t_267, params__963):cast(temper.listof(t_268, t_269));
    t_270 = not temper.mapped_has(cs__964.changes, 'name');
    fn__15028 = function()
      return 'empty name should not be in changes';
    end;
    temper.test_assert(test_266, t_270, fn__15028);
    t_271 = temper.mapped_has(cs__964.changes, 'email');
    fn__15027 = function()
      return 'email should be in changes';
    end;
    temper.test_assert(test_266, t_271, fn__15027);
    return nil;
  end);
end;
Test_.test_validateRequiredPassesWhenFieldPresent__2123 = function()
  temper.test('validateRequired passes when field present', function(test_272)
    local params__966, t_273, t_274, cs__967, t_275, fn__15011, t_276, fn__15010;
    params__966 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice')));
    t_273 = userTable__661();
    t_274 = csid__660('name');
    cs__967 = changeset(t_273, params__966):cast(temper.listof(t_274)):validateRequired(temper.listof(csid__660('name')));
    t_275 = cs__967.isValid;
    fn__15011 = function()
      return 'should be valid';
    end;
    temper.test_assert(test_272, t_275, fn__15011);
    t_276 = (temper.list_length(cs__967.errors) == 0);
    fn__15010 = function()
      return 'no errors expected';
    end;
    temper.test_assert(test_272, t_276, fn__15010);
    return nil;
  end);
end;
Test_.test_validateRequiredFailsWhenFieldMissing__2124 = function()
  temper.test('validateRequired fails when field missing', function(test_277)
    local params__969, t_278, t_279, cs__970, t_280, fn__14988, t_281, fn__14987, t_282, fn__14986;
    params__969 = temper.map_constructor(temper.listof());
    t_278 = userTable__661();
    t_279 = csid__660('name');
    cs__970 = changeset(t_278, params__969):cast(temper.listof(t_279)):validateRequired(temper.listof(csid__660('name')));
    t_280 = not cs__970.isValid;
    fn__14988 = function()
      return 'should be invalid';
    end;
    temper.test_assert(test_277, t_280, fn__14988);
    t_281 = (temper.list_length(cs__970.errors) == 1);
    fn__14987 = function()
      return 'should have one error';
    end;
    temper.test_assert(test_277, t_281, fn__14987);
    t_282 = temper.str_eq((temper.list_get(cs__970.errors, 0)).field, 'name');
    fn__14986 = function()
      return 'error should name the field';
    end;
    temper.test_assert(test_277, t_282, fn__14986);
    return nil;
  end);
end;
Test_.test_validateLengthPassesWithinRange__2125 = function()
  temper.test('validateLength passes within range', function(test_283)
    local params__972, t_284, t_285, cs__973, t_286, fn__14975;
    params__972 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice')));
    t_284 = userTable__661();
    t_285 = csid__660('name');
    cs__973 = changeset(t_284, params__972):cast(temper.listof(t_285)):validateLength(csid__660('name'), 2, 50);
    t_286 = cs__973.isValid;
    fn__14975 = function()
      return 'should be valid';
    end;
    temper.test_assert(test_283, t_286, fn__14975);
    return nil;
  end);
end;
Test_.test_validateLengthFailsWhenTooShort__2126 = function()
  temper.test('validateLength fails when too short', function(test_287)
    local params__975, t_288, t_289, cs__976, t_290, fn__14963;
    params__975 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'A')));
    t_288 = userTable__661();
    t_289 = csid__660('name');
    cs__976 = changeset(t_288, params__975):cast(temper.listof(t_289)):validateLength(csid__660('name'), 2, 50);
    t_290 = not cs__976.isValid;
    fn__14963 = function()
      return 'should be invalid';
    end;
    temper.test_assert(test_287, t_290, fn__14963);
    return nil;
  end);
end;
Test_.test_validateLengthFailsWhenTooLong__2127 = function()
  temper.test('validateLength fails when too long', function(test_291)
    local params__978, t_292, t_293, cs__979, t_294, fn__14951;
    params__978 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')));
    t_292 = userTable__661();
    t_293 = csid__660('name');
    cs__979 = changeset(t_292, params__978):cast(temper.listof(t_293)):validateLength(csid__660('name'), 2, 10);
    t_294 = not cs__979.isValid;
    fn__14951 = function()
      return 'should be invalid';
    end;
    temper.test_assert(test_291, t_294, fn__14951);
    return nil;
  end);
end;
Test_.test_validateIntPassesForValidInteger__2128 = function()
  temper.test('validateInt passes for valid integer', function(test_295)
    local params__981, t_296, t_297, cs__982, t_298, fn__14940;
    params__981 = temper.map_constructor(temper.listof(temper.pair_constructor('age', '30')));
    t_296 = userTable__661();
    t_297 = csid__660('age');
    cs__982 = changeset(t_296, params__981):cast(temper.listof(t_297)):validateInt(csid__660('age'));
    t_298 = cs__982.isValid;
    fn__14940 = function()
      return 'should be valid';
    end;
    temper.test_assert(test_295, t_298, fn__14940);
    return nil;
  end);
end;
Test_.test_validateIntFailsForNonInteger__2129 = function()
  temper.test('validateInt fails for non-integer', function(test_299)
    local params__984, t_300, t_301, cs__985, t_302, fn__14928;
    params__984 = temper.map_constructor(temper.listof(temper.pair_constructor('age', 'not-a-number')));
    t_300 = userTable__661();
    t_301 = csid__660('age');
    cs__985 = changeset(t_300, params__984):cast(temper.listof(t_301)):validateInt(csid__660('age'));
    t_302 = not cs__985.isValid;
    fn__14928 = function()
      return 'should be invalid';
    end;
    temper.test_assert(test_299, t_302, fn__14928);
    return nil;
  end);
end;
Test_.test_validateFloatPassesForValidFloat__2130 = function()
  temper.test('validateFloat passes for valid float', function(test_303)
    local params__987, t_304, t_305, cs__988, t_306, fn__14917;
    params__987 = temper.map_constructor(temper.listof(temper.pair_constructor('score', '9.5')));
    t_304 = userTable__661();
    t_305 = csid__660('score');
    cs__988 = changeset(t_304, params__987):cast(temper.listof(t_305)):validateFloat(csid__660('score'));
    t_306 = cs__988.isValid;
    fn__14917 = function()
      return 'should be valid';
    end;
    temper.test_assert(test_303, t_306, fn__14917);
    return nil;
  end);
end;
Test_.test_validateInt64_passesForValid64_bitInteger__2131 = function()
  temper.test('validateInt64 passes for valid 64-bit integer', function(test_307)
    local params__990, t_308, t_309, cs__991, t_310, fn__14906;
    params__990 = temper.map_constructor(temper.listof(temper.pair_constructor('age', '9999999999')));
    t_308 = userTable__661();
    t_309 = csid__660('age');
    cs__991 = changeset(t_308, params__990):cast(temper.listof(t_309)):validateInt64(csid__660('age'));
    t_310 = cs__991.isValid;
    fn__14906 = function()
      return 'should be valid';
    end;
    temper.test_assert(test_307, t_310, fn__14906);
    return nil;
  end);
end;
Test_.test_validateInt64_failsForNonInteger__2132 = function()
  temper.test('validateInt64 fails for non-integer', function(test_311)
    local params__993, t_312, t_313, cs__994, t_314, fn__14894;
    params__993 = temper.map_constructor(temper.listof(temper.pair_constructor('age', 'not-a-number')));
    t_312 = userTable__661();
    t_313 = csid__660('age');
    cs__994 = changeset(t_312, params__993):cast(temper.listof(t_313)):validateInt64(csid__660('age'));
    t_314 = not cs__994.isValid;
    fn__14894 = function()
      return 'should be invalid';
    end;
    temper.test_assert(test_311, t_314, fn__14894);
    return nil;
  end);
end;
Test_.test_validateBoolAcceptsTrue1_yesOn__2133 = function()
  temper.test('validateBool accepts true/1/yes/on', function(test_315)
    local fn__14891;
    fn__14891 = function(v__996)
      local params__997, t_316, t_317, cs__998, t_318, fn__14880;
      params__997 = temper.map_constructor(temper.listof(temper.pair_constructor('active', v__996)));
      t_316 = userTable__661();
      t_317 = csid__660('active');
      cs__998 = changeset(t_316, params__997):cast(temper.listof(t_317)):validateBool(csid__660('active'));
      t_318 = cs__998.isValid;
      fn__14880 = function()
        return temper.concat('should accept: ', v__996);
      end;
      temper.test_assert(test_315, t_318, fn__14880);
      return nil;
    end;
    temper.list_foreach(temper.listof('true', '1', 'yes', 'on'), fn__14891);
    return nil;
  end);
end;
Test_.test_validateBoolAcceptsFalse0_noOff__2134 = function()
  temper.test('validateBool accepts false/0/no/off', function(test_319)
    local fn__14877;
    fn__14877 = function(v__1000)
      local params__1001, t_320, t_321, cs__1002, t_322, fn__14866;
      params__1001 = temper.map_constructor(temper.listof(temper.pair_constructor('active', v__1000)));
      t_320 = userTable__661();
      t_321 = csid__660('active');
      cs__1002 = changeset(t_320, params__1001):cast(temper.listof(t_321)):validateBool(csid__660('active'));
      t_322 = cs__1002.isValid;
      fn__14866 = function()
        return temper.concat('should accept: ', v__1000);
      end;
      temper.test_assert(test_319, t_322, fn__14866);
      return nil;
    end;
    temper.list_foreach(temper.listof('false', '0', 'no', 'off'), fn__14877);
    return nil;
  end);
end;
Test_.test_validateBoolRejectsAmbiguousValues__2135 = function()
  temper.test('validateBool rejects ambiguous values', function(test_323)
    local fn__14863;
    fn__14863 = function(v__1004)
      local params__1005, t_324, t_325, cs__1006, t_326, fn__14851;
      params__1005 = temper.map_constructor(temper.listof(temper.pair_constructor('active', v__1004)));
      t_324 = userTable__661();
      t_325 = csid__660('active');
      cs__1006 = changeset(t_324, params__1005):cast(temper.listof(t_325)):validateBool(csid__660('active'));
      t_326 = not cs__1006.isValid;
      fn__14851 = function()
        return temper.concat('should reject ambiguous: ', v__1004);
      end;
      temper.test_assert(test_323, t_326, fn__14851);
      return nil;
    end;
    temper.list_foreach(temper.listof('TRUE', 'Yes', 'maybe', '2', 'enabled'), fn__14863);
    return nil;
  end);
end;
Test_.test_toInsertSqlEscapesBobbyTables__2136 = function()
  temper.test('toInsertSql escapes Bobby Tables', function(test_327)
    local t_328, params__1008, t_329, t_330, t_331, cs__1009, sqlFrag__1010, local_332, local_333, local_334, s__1011, t_336, fn__14835;
    params__1008 = temper.map_constructor(temper.listof(temper.pair_constructor('name', "Robert'); DROP TABLE users;--"), temper.pair_constructor('email', 'bobby@evil.com')));
    t_329 = userTable__661();
    t_330 = csid__660('name');
    t_331 = csid__660('email');
    cs__1009 = changeset(t_329, params__1008):cast(temper.listof(t_330, t_331)):validateRequired(temper.listof(csid__660('name'), csid__660('email')));
    local_332, local_333, local_334 = temper.pcall(function()
      t_328 = cs__1009:toInsertSql();
      sqlFrag__1010 = t_328;
    end);
    if local_332 then
    else
      sqlFrag__1010 = temper.bubble();
    end
    s__1011 = sqlFrag__1010:toString();
    t_336 = temper.is_string_index(temper.string_indexof(s__1011, "''"));
    fn__14835 = function()
      return temper.concat('single quote must be doubled: ', s__1011);
    end;
    temper.test_assert(test_327, t_336, fn__14835);
    return nil;
  end);
end;
Test_.test_toInsertSqlProducesCorrectSqlForStringField__2137 = function()
  temper.test('toInsertSql produces correct SQL for string field', function(test_337)
    local t_338, params__1013, t_339, t_340, t_341, cs__1014, sqlFrag__1015, local_342, local_343, local_344, s__1016, t_346, fn__14815, t_347, fn__14814;
    params__1013 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice'), temper.pair_constructor('email', 'a@example.com')));
    t_339 = userTable__661();
    t_340 = csid__660('name');
    t_341 = csid__660('email');
    cs__1014 = changeset(t_339, params__1013):cast(temper.listof(t_340, t_341)):validateRequired(temper.listof(csid__660('name'), csid__660('email')));
    local_342, local_343, local_344 = temper.pcall(function()
      t_338 = cs__1014:toInsertSql();
      sqlFrag__1015 = t_338;
    end);
    if local_342 then
    else
      sqlFrag__1015 = temper.bubble();
    end
    s__1016 = sqlFrag__1015:toString();
    t_346 = temper.is_string_index(temper.string_indexof(s__1016, 'INSERT INTO users'));
    fn__14815 = function()
      return temper.concat('has INSERT INTO: ', s__1016);
    end;
    temper.test_assert(test_337, t_346, fn__14815);
    t_347 = temper.is_string_index(temper.string_indexof(s__1016, "'Alice'"));
    fn__14814 = function()
      return temper.concat('has quoted name: ', s__1016);
    end;
    temper.test_assert(test_337, t_347, fn__14814);
    return nil;
  end);
end;
Test_.test_toInsertSqlProducesCorrectSqlForIntField__2138 = function()
  temper.test('toInsertSql produces correct SQL for int field', function(test_348)
    local t_349, params__1018, t_350, t_351, t_352, t_353, cs__1019, sqlFrag__1020, local_354, local_355, local_356, s__1021, t_358, fn__14796;
    params__1018 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Bob'), temper.pair_constructor('email', 'b@example.com'), temper.pair_constructor('age', '25')));
    t_350 = userTable__661();
    t_351 = csid__660('name');
    t_352 = csid__660('email');
    t_353 = csid__660('age');
    cs__1019 = changeset(t_350, params__1018):cast(temper.listof(t_351, t_352, t_353)):validateRequired(temper.listof(csid__660('name'), csid__660('email')));
    local_354, local_355, local_356 = temper.pcall(function()
      t_349 = cs__1019:toInsertSql();
      sqlFrag__1020 = t_349;
    end);
    if local_354 then
    else
      sqlFrag__1020 = temper.bubble();
    end
    s__1021 = sqlFrag__1020:toString();
    t_358 = temper.is_string_index(temper.string_indexof(s__1021, '25'));
    fn__14796 = function()
      return temper.concat('age rendered unquoted: ', s__1021);
    end;
    temper.test_assert(test_348, t_358, fn__14796);
    return nil;
  end);
end;
Test_.test_toInsertSqlBubblesOnInvalidChangeset__2139 = function()
  temper.test('toInsertSql bubbles on invalid changeset', function(test_359)
    local params__1023, t_360, t_361, cs__1024, didBubble__1025, local_362, local_363, local_364, fn__14787;
    params__1023 = temper.map_constructor(temper.listof());
    t_360 = userTable__661();
    t_361 = csid__660('name');
    cs__1024 = changeset(t_360, params__1023):cast(temper.listof(t_361)):validateRequired(temper.listof(csid__660('name')));
    local_362, local_363, local_364 = temper.pcall(function()
      cs__1024:toInsertSql();
      didBubble__1025 = false;
    end);
    if local_362 then
    else
      didBubble__1025 = true;
    end
    fn__14787 = function()
      return 'invalid changeset should bubble';
    end;
    temper.test_assert(test_359, didBubble__1025, fn__14787);
    return nil;
  end);
end;
Test_.test_toInsertSqlEnforcesNonNullableFieldsIndependentlyOfIsValid__2140 = function()
  temper.test('toInsertSql enforces non-nullable fields independently of isValid', function(test_366)
    local strictTable__1027, params__1028, t_367, cs__1029, t_368, fn__14769, didBubble__1030, local_369, local_370, local_371, fn__14768;
    strictTable__1027 = TableDef(csid__660('posts'), temper.listof(FieldDef(csid__660('title'), StringField(), false, temper.null, false), FieldDef(csid__660('body'), StringField(), true, temper.null, false)), temper.null);
    params__1028 = temper.map_constructor(temper.listof(temper.pair_constructor('body', 'hello')));
    t_367 = csid__660('body');
    cs__1029 = changeset(strictTable__1027, params__1028):cast(temper.listof(t_367));
    t_368 = cs__1029.isValid;
    fn__14769 = function()
      return 'changeset should appear valid (no explicit validation run)';
    end;
    temper.test_assert(test_366, t_368, fn__14769);
    local_369, local_370, local_371 = temper.pcall(function()
      cs__1029:toInsertSql();
      didBubble__1030 = false;
    end);
    if local_369 then
    else
      didBubble__1030 = true;
    end
    fn__14768 = function()
      return 'toInsertSql should enforce nullable regardless of isValid';
    end;
    temper.test_assert(test_366, didBubble__1030, fn__14768);
    return nil;
  end);
end;
Test_.test_toUpdateSqlProducesCorrectSql__2141 = function()
  temper.test('toUpdateSql produces correct SQL', function(test_373)
    local t_374, params__1032, t_375, t_376, cs__1033, sqlFrag__1034, local_377, local_378, local_379, s__1035, t_381, fn__14756;
    params__1032 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Bob')));
    t_375 = userTable__661();
    t_376 = csid__660('name');
    cs__1033 = changeset(t_375, params__1032):cast(temper.listof(t_376)):validateRequired(temper.listof(csid__660('name')));
    local_377, local_378, local_379 = temper.pcall(function()
      t_374 = cs__1033:toUpdateSql(42);
      sqlFrag__1034 = t_374;
    end);
    if local_377 then
    else
      sqlFrag__1034 = temper.bubble();
    end
    s__1035 = sqlFrag__1034:toString();
    t_381 = temper.str_eq(s__1035, "UPDATE users SET name = 'Bob' WHERE id = 42");
    fn__14756 = function()
      return temper.concat('got: ', s__1035);
    end;
    temper.test_assert(test_373, t_381, fn__14756);
    return nil;
  end);
end;
Test_.test_toUpdateSqlBubblesOnInvalidChangeset__2142 = function()
  temper.test('toUpdateSql bubbles on invalid changeset', function(test_382)
    local params__1037, t_383, t_384, cs__1038, didBubble__1039, local_385, local_386, local_387, fn__14747;
    params__1037 = temper.map_constructor(temper.listof());
    t_383 = userTable__661();
    t_384 = csid__660('name');
    cs__1038 = changeset(t_383, params__1037):cast(temper.listof(t_384)):validateRequired(temper.listof(csid__660('name')));
    local_385, local_386, local_387 = temper.pcall(function()
      cs__1038:toUpdateSql(1);
      didBubble__1039 = false;
    end);
    if local_385 then
    else
      didBubble__1039 = true;
    end
    fn__14747 = function()
      return 'invalid changeset should bubble';
    end;
    temper.test_assert(test_382, didBubble__1039, fn__14747);
    return nil;
  end);
end;
Test_.test_putChangeAddsANewField__2143 = function()
  temper.test('putChange adds a new field', function(test_389)
    local params__1041, t_390, t_391, cs__1042, t_392, fn__14730, t_393, fn__14729;
    params__1041 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice')));
    t_390 = userTable__661();
    t_391 = csid__660('name');
    cs__1042 = changeset(t_390, params__1041):cast(temper.listof(t_391)):putChange(csid__660('email'), 'alice@example.com');
    t_392 = temper.mapped_has(cs__1042.changes, 'email');
    fn__14730 = function()
      return 'email should be in changes';
    end;
    temper.test_assert(test_389, t_392, fn__14730);
    t_393 = temper.str_eq(temper.mapped_getor(cs__1042.changes, 'email', ''), 'alice@example.com');
    fn__14729 = function()
      return 'email value';
    end;
    temper.test_assert(test_389, t_393, fn__14729);
    return nil;
  end);
end;
Test_.test_putChangeOverwritesExistingField__2144 = function()
  temper.test('putChange overwrites existing field', function(test_394)
    local params__1044, t_395, t_396, cs__1045, t_397, fn__14716;
    params__1044 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice')));
    t_395 = userTable__661();
    t_396 = csid__660('name');
    cs__1045 = changeset(t_395, params__1044):cast(temper.listof(t_396)):putChange(csid__660('name'), 'Bob');
    t_397 = temper.str_eq(temper.mapped_getor(cs__1045.changes, 'name', ''), 'Bob');
    fn__14716 = function()
      return 'name should be overwritten';
    end;
    temper.test_assert(test_394, t_397, fn__14716);
    return nil;
  end);
end;
Test_.test_putChangeValueAppearsInToInsertSql__2145 = function()
  temper.test('putChange value appears in toInsertSql', function(test_398)
    local t_399, t_400, params__1047, t_401, t_402, t_403, cs__1048, local_404, local_405, local_406, s__1049, t_408, fn__14701;
    params__1047 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice'), temper.pair_constructor('email', 'a@example.com')));
    t_401 = userTable__661();
    t_402 = csid__660('name');
    t_403 = csid__660('email');
    cs__1048 = changeset(t_401, params__1047):cast(temper.listof(t_402, t_403)):putChange(csid__660('name'), 'Bob');
    local_404, local_405, local_406 = temper.pcall(function()
      t_399 = cs__1048:toInsertSql();
      t_400 = t_399;
    end);
    if local_404 then
    else
      t_400 = temper.bubble();
    end
    s__1049 = t_400:toString();
    t_408 = temper.is_string_index(temper.string_indexof(s__1049, "'Bob'"));
    fn__14701 = function()
      return temper.concat('should use putChange value: ', s__1049);
    end;
    temper.test_assert(test_398, t_408, fn__14701);
    return nil;
  end);
end;
Test_.test_getChangeReturnsValueForExistingField__2146 = function()
  temper.test('getChange returns value for existing field', function(test_409)
    local t_410, params__1051, t_411, t_412, cs__1052, val__1053, local_413, local_414, local_415, t_417, fn__14691;
    params__1051 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice')));
    t_411 = userTable__661();
    t_412 = csid__660('name');
    cs__1052 = changeset(t_411, params__1051):cast(temper.listof(t_412));
    local_413, local_414, local_415 = temper.pcall(function()
      t_410 = cs__1052:getChange(csid__660('name'));
      val__1053 = t_410;
    end);
    if local_413 then
    else
      val__1053 = temper.bubble();
    end
    t_417 = temper.str_eq(val__1053, 'Alice');
    fn__14691 = function()
      return 'should return Alice';
    end;
    temper.test_assert(test_409, t_417, fn__14691);
    return nil;
  end);
end;
Test_.test_getChangeBubblesOnMissingField__2147 = function()
  temper.test('getChange bubbles on missing field', function(test_418)
    local params__1055, t_419, t_420, cs__1056, didBubble__1057, local_421, local_422, local_423, fn__14682;
    params__1055 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice')));
    t_419 = userTable__661();
    t_420 = csid__660('name');
    cs__1056 = changeset(t_419, params__1055):cast(temper.listof(t_420));
    local_421, local_422, local_423 = temper.pcall(function()
      cs__1056:getChange(csid__660('email'));
      didBubble__1057 = false;
    end);
    if local_421 then
    else
      didBubble__1057 = true;
    end
    fn__14682 = function()
      return 'should bubble for missing field';
    end;
    temper.test_assert(test_418, didBubble__1057, fn__14682);
    return nil;
  end);
end;
Test_.test_deleteChangeRemovesField__2148 = function()
  temper.test('deleteChange removes field', function(test_425)
    local params__1059, t_426, t_427, t_428, cs__1060, t_429, fn__14663, t_430, fn__14662;
    params__1059 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice'), temper.pair_constructor('email', 'a@example.com')));
    t_426 = userTable__661();
    t_427 = csid__660('name');
    t_428 = csid__660('email');
    cs__1060 = changeset(t_426, params__1059):cast(temper.listof(t_427, t_428)):deleteChange(csid__660('email'));
    t_429 = not temper.mapped_has(cs__1060.changes, 'email');
    fn__14663 = function()
      return 'email should be removed';
    end;
    temper.test_assert(test_425, t_429, fn__14663);
    t_430 = temper.mapped_has(cs__1060.changes, 'name');
    fn__14662 = function()
      return 'name should remain';
    end;
    temper.test_assert(test_425, t_430, fn__14662);
    return nil;
  end);
end;
Test_.test_deleteChangeOnNonexistentFieldIsNoOp__2149 = function()
  temper.test('deleteChange on nonexistent field is no-op', function(test_431)
    local params__1062, t_432, t_433, cs__1063, t_434, fn__14647, t_435, fn__14646;
    params__1062 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice')));
    t_432 = userTable__661();
    t_433 = csid__660('name');
    cs__1063 = changeset(t_432, params__1062):cast(temper.listof(t_433)):deleteChange(csid__660('email'));
    t_434 = temper.mapped_has(cs__1063.changes, 'name');
    fn__14647 = function()
      return 'name should still be present';
    end;
    temper.test_assert(test_431, t_434, fn__14647);
    t_435 = cs__1063.isValid;
    fn__14646 = function()
      return 'should still be valid';
    end;
    temper.test_assert(test_431, t_435, fn__14646);
    return nil;
  end);
end;
Test_.test_validateInclusionPassesWhenValueInList__2150 = function()
  temper.test('validateInclusion passes when value in list', function(test_436)
    local params__1065, t_437, t_438, cs__1066, t_439, fn__14635;
    params__1065 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'admin')));
    t_437 = userTable__661();
    t_438 = csid__660('name');
    cs__1066 = changeset(t_437, params__1065):cast(temper.listof(t_438)):validateInclusion(csid__660('name'), temper.listof('admin', 'user', 'guest'));
    t_439 = cs__1066.isValid;
    fn__14635 = function()
      return 'should be valid';
    end;
    temper.test_assert(test_436, t_439, fn__14635);
    return nil;
  end);
end;
Test_.test_validateInclusionFailsWhenValueNotInList__2151 = function()
  temper.test('validateInclusion fails when value not in list', function(test_440)
    local params__1068, t_441, t_442, cs__1069, t_443, fn__14617, t_444, fn__14616;
    params__1068 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'hacker')));
    t_441 = userTable__661();
    t_442 = csid__660('name');
    cs__1069 = changeset(t_441, params__1068):cast(temper.listof(t_442)):validateInclusion(csid__660('name'), temper.listof('admin', 'user', 'guest'));
    t_443 = not cs__1069.isValid;
    fn__14617 = function()
      return 'should be invalid';
    end;
    temper.test_assert(test_440, t_443, fn__14617);
    t_444 = temper.str_eq((temper.list_get(cs__1069.errors, 0)).field, 'name');
    fn__14616 = function()
      return 'error on name';
    end;
    temper.test_assert(test_440, t_444, fn__14616);
    return nil;
  end);
end;
Test_.test_validateInclusionSkipsWhenFieldNotInChanges__2152 = function()
  temper.test('validateInclusion skips when field not in changes', function(test_445)
    local params__1071, t_446, t_447, cs__1072, t_448, fn__14606;
    params__1071 = temper.map_constructor(temper.listof());
    t_446 = userTable__661();
    t_447 = csid__660('name');
    cs__1072 = changeset(t_446, params__1071):cast(temper.listof(t_447)):validateInclusion(csid__660('name'), temper.listof('admin', 'user'));
    t_448 = cs__1072.isValid;
    fn__14606 = function()
      return 'should be valid when field absent';
    end;
    temper.test_assert(test_445, t_448, fn__14606);
    return nil;
  end);
end;
Test_.test_validateExclusionPassesWhenValueNotInList__2153 = function()
  temper.test('validateExclusion passes when value not in list', function(test_449)
    local params__1074, t_450, t_451, cs__1075, t_452, fn__14595;
    params__1074 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice')));
    t_450 = userTable__661();
    t_451 = csid__660('name');
    cs__1075 = changeset(t_450, params__1074):cast(temper.listof(t_451)):validateExclusion(csid__660('name'), temper.listof('root', 'admin', 'superuser'));
    t_452 = cs__1075.isValid;
    fn__14595 = function()
      return 'should be valid';
    end;
    temper.test_assert(test_449, t_452, fn__14595);
    return nil;
  end);
end;
Test_.test_validateExclusionFailsWhenValueInList__2154 = function()
  temper.test('validateExclusion fails when value in list', function(test_453)
    local params__1077, t_454, t_455, cs__1078, t_456, fn__14577, t_457, fn__14576;
    params__1077 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'admin')));
    t_454 = userTable__661();
    t_455 = csid__660('name');
    cs__1078 = changeset(t_454, params__1077):cast(temper.listof(t_455)):validateExclusion(csid__660('name'), temper.listof('root', 'admin', 'superuser'));
    t_456 = not cs__1078.isValid;
    fn__14577 = function()
      return 'should be invalid';
    end;
    temper.test_assert(test_453, t_456, fn__14577);
    t_457 = temper.str_eq((temper.list_get(cs__1078.errors, 0)).field, 'name');
    fn__14576 = function()
      return 'error on name';
    end;
    temper.test_assert(test_453, t_457, fn__14576);
    return nil;
  end);
end;
Test_.test_validateExclusionSkipsWhenFieldNotInChanges__2155 = function()
  temper.test('validateExclusion skips when field not in changes', function(test_458)
    local params__1080, t_459, t_460, cs__1081, t_461, fn__14566;
    params__1080 = temper.map_constructor(temper.listof());
    t_459 = userTable__661();
    t_460 = csid__660('name');
    cs__1081 = changeset(t_459, params__1080):cast(temper.listof(t_460)):validateExclusion(csid__660('name'), temper.listof('root', 'admin'));
    t_461 = cs__1081.isValid;
    fn__14566 = function()
      return 'should be valid when field absent';
    end;
    temper.test_assert(test_458, t_461, fn__14566);
    return nil;
  end);
end;
Test_.test_validateNumberGreaterThanPasses__2156 = function()
  temper.test('validateNumber greaterThan passes', function(test_462)
    local params__1083, t_463, t_464, cs__1084, t_465, fn__14554;
    params__1083 = temper.map_constructor(temper.listof(temper.pair_constructor('age', '25')));
    t_463 = userTable__661();
    t_464 = csid__660('age');
    cs__1084 = changeset(t_463, params__1083):cast(temper.listof(t_464)):validateNumber(csid__660('age'), NumberValidationOpts(18.0, temper.null, temper.null, temper.null, temper.null));
    t_465 = cs__1084.isValid;
    fn__14554 = function()
      return '25 > 18 should pass';
    end;
    temper.test_assert(test_462, t_465, fn__14554);
    return nil;
  end);
end;
Test_.test_validateNumberGreaterThanFails__2157 = function()
  temper.test('validateNumber greaterThan fails', function(test_466)
    local params__1086, t_467, t_468, cs__1087, t_469, fn__14541;
    params__1086 = temper.map_constructor(temper.listof(temper.pair_constructor('age', '15')));
    t_467 = userTable__661();
    t_468 = csid__660('age');
    cs__1087 = changeset(t_467, params__1086):cast(temper.listof(t_468)):validateNumber(csid__660('age'), NumberValidationOpts(18.0, temper.null, temper.null, temper.null, temper.null));
    t_469 = not cs__1087.isValid;
    fn__14541 = function()
      return '15 > 18 should fail';
    end;
    temper.test_assert(test_466, t_469, fn__14541);
    return nil;
  end);
end;
Test_.test_validateNumberLessThanPasses__2158 = function()
  temper.test('validateNumber lessThan passes', function(test_470)
    local params__1089, t_471, t_472, cs__1090, t_473, fn__14529;
    params__1089 = temper.map_constructor(temper.listof(temper.pair_constructor('score', '8.5')));
    t_471 = userTable__661();
    t_472 = csid__660('score');
    cs__1090 = changeset(t_471, params__1089):cast(temper.listof(t_472)):validateNumber(csid__660('score'), NumberValidationOpts(temper.null, 10.0, temper.null, temper.null, temper.null));
    t_473 = cs__1090.isValid;
    fn__14529 = function()
      return '8.5 < 10 should pass';
    end;
    temper.test_assert(test_470, t_473, fn__14529);
    return nil;
  end);
end;
Test_.test_validateNumberLessThanFails__2159 = function()
  temper.test('validateNumber lessThan fails', function(test_474)
    local params__1092, t_475, t_476, cs__1093, t_477, fn__14516;
    params__1092 = temper.map_constructor(temper.listof(temper.pair_constructor('score', '12.0')));
    t_475 = userTable__661();
    t_476 = csid__660('score');
    cs__1093 = changeset(t_475, params__1092):cast(temper.listof(t_476)):validateNumber(csid__660('score'), NumberValidationOpts(temper.null, 10.0, temper.null, temper.null, temper.null));
    t_477 = not cs__1093.isValid;
    fn__14516 = function()
      return '12 < 10 should fail';
    end;
    temper.test_assert(test_474, t_477, fn__14516);
    return nil;
  end);
end;
Test_.test_validateNumberGreaterThanOrEqualBoundary__2160 = function()
  temper.test('validateNumber greaterThanOrEqual boundary', function(test_478)
    local params__1095, t_479, t_480, cs__1096, t_481, fn__14504;
    params__1095 = temper.map_constructor(temper.listof(temper.pair_constructor('age', '18')));
    t_479 = userTable__661();
    t_480 = csid__660('age');
    cs__1096 = changeset(t_479, params__1095):cast(temper.listof(t_480)):validateNumber(csid__660('age'), NumberValidationOpts(temper.null, temper.null, 18.0, temper.null, temper.null));
    t_481 = cs__1096.isValid;
    fn__14504 = function()
      return '18 >= 18 should pass';
    end;
    temper.test_assert(test_478, t_481, fn__14504);
    return nil;
  end);
end;
Test_.test_validateNumberCombinedOptions__2161 = function()
  temper.test('validateNumber combined options', function(test_482)
    local params__1098, t_483, t_484, cs__1099, t_485, fn__14492;
    params__1098 = temper.map_constructor(temper.listof(temper.pair_constructor('score', '5.0')));
    t_483 = userTable__661();
    t_484 = csid__660('score');
    cs__1099 = changeset(t_483, params__1098):cast(temper.listof(t_484)):validateNumber(csid__660('score'), NumberValidationOpts(0.0, 10.0, temper.null, temper.null, temper.null));
    t_485 = cs__1099.isValid;
    fn__14492 = function()
      return '5 > 0 and < 10 should pass';
    end;
    temper.test_assert(test_482, t_485, fn__14492);
    return nil;
  end);
end;
Test_.test_validateNumberNonNumericValue__2162 = function()
  temper.test('validateNumber non-numeric value', function(test_486)
    local params__1101, t_487, t_488, cs__1102, t_489, fn__14473, t_490, fn__14472;
    params__1101 = temper.map_constructor(temper.listof(temper.pair_constructor('age', 'abc')));
    t_487 = userTable__661();
    t_488 = csid__660('age');
    cs__1102 = changeset(t_487, params__1101):cast(temper.listof(t_488)):validateNumber(csid__660('age'), NumberValidationOpts(0.0, temper.null, temper.null, temper.null, temper.null));
    t_489 = not cs__1102.isValid;
    fn__14473 = function()
      return 'non-numeric should fail';
    end;
    temper.test_assert(test_486, t_489, fn__14473);
    t_490 = temper.str_eq((temper.list_get(cs__1102.errors, 0)).message, 'must be a number');
    fn__14472 = function()
      return 'correct error message';
    end;
    temper.test_assert(test_486, t_490, fn__14472);
    return nil;
  end);
end;
Test_.test_validateNumberSkipsWhenFieldNotInChanges__2163 = function()
  temper.test('validateNumber skips when field not in changes', function(test_491)
    local params__1104, t_492, t_493, cs__1105, t_494, fn__14461;
    params__1104 = temper.map_constructor(temper.listof());
    t_492 = userTable__661();
    t_493 = csid__660('age');
    cs__1105 = changeset(t_492, params__1104):cast(temper.listof(t_493)):validateNumber(csid__660('age'), NumberValidationOpts(0.0, temper.null, temper.null, temper.null, temper.null));
    t_494 = cs__1105.isValid;
    fn__14461 = function()
      return 'should be valid when field absent';
    end;
    temper.test_assert(test_491, t_494, fn__14461);
    return nil;
  end);
end;
Test_.test_validateAcceptancePassesForTrueValues__2164 = function()
  temper.test('validateAcceptance passes for true values', function(test_495)
    local fn__14458;
    fn__14458 = function(v__1107)
      local params__1108, t_496, t_497, cs__1109, t_498, fn__14447;
      params__1108 = temper.map_constructor(temper.listof(temper.pair_constructor('active', v__1107)));
      t_496 = userTable__661();
      t_497 = csid__660('active');
      cs__1109 = changeset(t_496, params__1108):cast(temper.listof(t_497)):validateAcceptance(csid__660('active'));
      t_498 = cs__1109.isValid;
      fn__14447 = function()
        return temper.concat('should accept: ', v__1107);
      end;
      temper.test_assert(test_495, t_498, fn__14447);
      return nil;
    end;
    temper.list_foreach(temper.listof('true', '1', 'yes', 'on'), fn__14458);
    return nil;
  end);
end;
Test_.test_validateAcceptanceFailsForNonTrueValues__2165 = function()
  temper.test('validateAcceptance fails for non-true values', function(test_499)
    local params__1111, t_500, t_501, cs__1112, t_502, fn__14429, t_503, fn__14428;
    params__1111 = temper.map_constructor(temper.listof(temper.pair_constructor('active', 'false')));
    t_500 = userTable__661();
    t_501 = csid__660('active');
    cs__1112 = changeset(t_500, params__1111):cast(temper.listof(t_501)):validateAcceptance(csid__660('active'));
    t_502 = not cs__1112.isValid;
    fn__14429 = function()
      return 'false should not be accepted';
    end;
    temper.test_assert(test_499, t_502, fn__14429);
    t_503 = temper.str_eq((temper.list_get(cs__1112.errors, 0)).message, 'must be accepted');
    fn__14428 = function()
      return 'correct message';
    end;
    temper.test_assert(test_499, t_503, fn__14428);
    return nil;
  end);
end;
Test_.test_validateConfirmationPassesWhenFieldsMatch__2166 = function()
  temper.test('validateConfirmation passes when fields match', function(test_504)
    local tbl__1114, params__1115, t_505, t_506, cs__1116, t_507, fn__14407;
    tbl__1114 = TableDef(csid__660('users'), temper.listof(FieldDef(csid__660('password'), StringField(), false, temper.null, false), FieldDef(csid__660('password_confirmation'), StringField(), true, temper.null, false)), temper.null);
    params__1115 = temper.map_constructor(temper.listof(temper.pair_constructor('password', 'secret123'), temper.pair_constructor('password_confirmation', 'secret123')));
    t_505 = csid__660('password');
    t_506 = csid__660('password_confirmation');
    cs__1116 = changeset(tbl__1114, params__1115):cast(temper.listof(t_505, t_506)):validateConfirmation(csid__660('password'), csid__660('password_confirmation'));
    t_507 = cs__1116.isValid;
    fn__14407 = function()
      return 'matching fields should pass';
    end;
    temper.test_assert(test_504, t_507, fn__14407);
    return nil;
  end);
end;
Test_.test_validateConfirmationFailsWhenFieldsDiffer__2167 = function()
  temper.test('validateConfirmation fails when fields differ', function(test_508)
    local tbl__1118, params__1119, t_509, t_510, cs__1120, t_511, fn__14379, t_512, fn__14378;
    tbl__1118 = TableDef(csid__660('users'), temper.listof(FieldDef(csid__660('password'), StringField(), false, temper.null, false), FieldDef(csid__660('password_confirmation'), StringField(), true, temper.null, false)), temper.null);
    params__1119 = temper.map_constructor(temper.listof(temper.pair_constructor('password', 'secret123'), temper.pair_constructor('password_confirmation', 'wrong456')));
    t_509 = csid__660('password');
    t_510 = csid__660('password_confirmation');
    cs__1120 = changeset(tbl__1118, params__1119):cast(temper.listof(t_509, t_510)):validateConfirmation(csid__660('password'), csid__660('password_confirmation'));
    t_511 = not cs__1120.isValid;
    fn__14379 = function()
      return 'mismatched fields should fail';
    end;
    temper.test_assert(test_508, t_511, fn__14379);
    t_512 = temper.str_eq((temper.list_get(cs__1120.errors, 0)).field, 'password_confirmation');
    fn__14378 = function()
      return 'error on confirmation field';
    end;
    temper.test_assert(test_508, t_512, fn__14378);
    return nil;
  end);
end;
Test_.test_validateConfirmationFailsWhenConfirmationMissing__2168 = function()
  temper.test('validateConfirmation fails when confirmation missing', function(test_513)
    local tbl__1122, params__1123, t_514, cs__1124, t_515, fn__14358;
    tbl__1122 = TableDef(csid__660('users'), temper.listof(FieldDef(csid__660('password'), StringField(), false, temper.null, false), FieldDef(csid__660('password_confirmation'), StringField(), true, temper.null, false)), temper.null);
    params__1123 = temper.map_constructor(temper.listof(temper.pair_constructor('password', 'secret123')));
    t_514 = csid__660('password');
    cs__1124 = changeset(tbl__1122, params__1123):cast(temper.listof(t_514)):validateConfirmation(csid__660('password'), csid__660('password_confirmation'));
    t_515 = not cs__1124.isValid;
    fn__14358 = function()
      return 'missing confirmation should fail';
    end;
    temper.test_assert(test_513, t_515, fn__14358);
    return nil;
  end);
end;
Test_.test_validateContainsPassesWhenSubstringFound__2169 = function()
  temper.test('validateContains passes when substring found', function(test_516)
    local params__1126, t_517, t_518, cs__1127, t_519, fn__14347;
    params__1126 = temper.map_constructor(temper.listof(temper.pair_constructor('email', 'alice@example.com')));
    t_517 = userTable__661();
    t_518 = csid__660('email');
    cs__1127 = changeset(t_517, params__1126):cast(temper.listof(t_518)):validateContains(csid__660('email'), '@');
    t_519 = cs__1127.isValid;
    fn__14347 = function()
      return 'should pass when @ present';
    end;
    temper.test_assert(test_516, t_519, fn__14347);
    return nil;
  end);
end;
Test_.test_validateContainsFailsWhenSubstringNotFound__2170 = function()
  temper.test('validateContains fails when substring not found', function(test_520)
    local params__1129, t_521, t_522, cs__1130, t_523, fn__14335;
    params__1129 = temper.map_constructor(temper.listof(temper.pair_constructor('email', 'alice-example.com')));
    t_521 = userTable__661();
    t_522 = csid__660('email');
    cs__1130 = changeset(t_521, params__1129):cast(temper.listof(t_522)):validateContains(csid__660('email'), '@');
    t_523 = not cs__1130.isValid;
    fn__14335 = function()
      return 'should fail when @ absent';
    end;
    temper.test_assert(test_520, t_523, fn__14335);
    return nil;
  end);
end;
Test_.test_validateContainsSkipsWhenFieldNotInChanges__2171 = function()
  temper.test('validateContains skips when field not in changes', function(test_524)
    local params__1132, t_525, t_526, cs__1133, t_527, fn__14325;
    params__1132 = temper.map_constructor(temper.listof());
    t_525 = userTable__661();
    t_526 = csid__660('email');
    cs__1133 = changeset(t_525, params__1132):cast(temper.listof(t_526)):validateContains(csid__660('email'), '@');
    t_527 = cs__1133.isValid;
    fn__14325 = function()
      return 'should be valid when field absent';
    end;
    temper.test_assert(test_524, t_527, fn__14325);
    return nil;
  end);
end;
Test_.test_validateStartsWithPasses__2172 = function()
  temper.test('validateStartsWith passes', function(test_528)
    local params__1135, t_529, t_530, cs__1136, t_531, fn__14314;
    params__1135 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Dr. Smith')));
    t_529 = userTable__661();
    t_530 = csid__660('name');
    cs__1136 = changeset(t_529, params__1135):cast(temper.listof(t_530)):validateStartsWith(csid__660('name'), 'Dr.');
    t_531 = cs__1136.isValid;
    fn__14314 = function()
      return 'should pass for Dr. prefix';
    end;
    temper.test_assert(test_528, t_531, fn__14314);
    return nil;
  end);
end;
Test_.test_validateStartsWithFails__2173 = function()
  temper.test('validateStartsWith fails', function(test_532)
    local params__1138, t_533, t_534, cs__1139, t_535, fn__14302;
    params__1138 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Mr. Smith')));
    t_533 = userTable__661();
    t_534 = csid__660('name');
    cs__1139 = changeset(t_533, params__1138):cast(temper.listof(t_534)):validateStartsWith(csid__660('name'), 'Dr.');
    t_535 = not cs__1139.isValid;
    fn__14302 = function()
      return 'should fail for Mr. prefix';
    end;
    temper.test_assert(test_532, t_535, fn__14302);
    return nil;
  end);
end;
Test_.test_validateEndsWithPasses__2174 = function()
  temper.test('validateEndsWith passes', function(test_536)
    local params__1141, t_537, t_538, cs__1142, t_539, fn__14291;
    params__1141 = temper.map_constructor(temper.listof(temper.pair_constructor('email', 'alice@example.com')));
    t_537 = userTable__661();
    t_538 = csid__660('email');
    cs__1142 = changeset(t_537, params__1141):cast(temper.listof(t_538)):validateEndsWith(csid__660('email'), '.com');
    t_539 = cs__1142.isValid;
    fn__14291 = function()
      return 'should pass for .com suffix';
    end;
    temper.test_assert(test_536, t_539, fn__14291);
    return nil;
  end);
end;
Test_.test_validateEndsWithFails__2175 = function()
  temper.test('validateEndsWith fails', function(test_540)
    local params__1144, t_541, t_542, cs__1145, t_543, fn__14279;
    params__1144 = temper.map_constructor(temper.listof(temper.pair_constructor('email', 'alice@example.org')));
    t_541 = userTable__661();
    t_542 = csid__660('email');
    cs__1145 = changeset(t_541, params__1144):cast(temper.listof(t_542)):validateEndsWith(csid__660('email'), '.com');
    t_543 = not cs__1145.isValid;
    fn__14279 = function()
      return 'should fail for .org when expecting .com';
    end;
    temper.test_assert(test_540, t_543, fn__14279);
    return nil;
  end);
end;
Test_.test_validateEndsWithHandlesRepeatedSuffixCorrectly__2176 = function()
  temper.test('validateEndsWith handles repeated suffix correctly', function(test_544)
    local params__1147, t_545, t_546, cs__1148, t_547, fn__14268;
    params__1147 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'abcabc')));
    t_545 = userTable__661();
    t_546 = csid__660('name');
    cs__1148 = changeset(t_545, params__1147):cast(temper.listof(t_546)):validateEndsWith(csid__660('name'), 'abc');
    t_547 = cs__1148.isValid;
    fn__14268 = function()
      return 'abcabc should end with abc';
    end;
    temper.test_assert(test_544, t_547, fn__14268);
    return nil;
  end);
end;
Test_.test_toInsertSqlUsesDefaultValueWhenFieldNotInChanges__2177 = function()
  temper.test('toInsertSql uses default value when field not in changes', function(test_548)
    local t_549, t_550, tbl__1150, params__1151, t_551, cs__1152, local_552, local_553, local_554, s__1153, t_556, fn__14240, t_557, fn__14239, t_558, fn__14238;
    tbl__1150 = TableDef(csid__660('posts'), temper.listof(FieldDef(csid__660('title'), StringField(), false, temper.null, false), FieldDef(csid__660('status'), StringField(), false, SqlDefault(), false)), temper.null);
    params__1151 = temper.map_constructor(temper.listof(temper.pair_constructor('title', 'Hello')));
    t_551 = csid__660('title');
    cs__1152 = changeset(tbl__1150, params__1151):cast(temper.listof(t_551));
    local_552, local_553, local_554 = temper.pcall(function()
      t_549 = cs__1152:toInsertSql();
      t_550 = t_549;
    end);
    if local_552 then
    else
      t_550 = temper.bubble();
    end
    s__1153 = t_550:toString();
    t_556 = temper.is_string_index(temper.string_indexof(s__1153, 'INSERT INTO posts'));
    fn__14240 = function()
      return temper.concat('has INSERT INTO: ', s__1153);
    end;
    temper.test_assert(test_548, t_556, fn__14240);
    t_557 = temper.is_string_index(temper.string_indexof(s__1153, "'Hello'"));
    fn__14239 = function()
      return temper.concat('has title value: ', s__1153);
    end;
    temper.test_assert(test_548, t_557, fn__14239);
    t_558 = temper.is_string_index(temper.string_indexof(s__1153, 'DEFAULT'));
    fn__14238 = function()
      return temper.concat('status should use DEFAULT: ', s__1153);
    end;
    temper.test_assert(test_548, t_558, fn__14238);
    return nil;
  end);
end;
Test_.test_toInsertSqlChangeOverridesDefaultValue__2178 = function()
  temper.test('toInsertSql change overrides default value', function(test_559)
    local t_560, t_561, tbl__1155, params__1156, t_562, t_563, cs__1157, local_564, local_565, local_566, s__1158, t_568, fn__14217;
    tbl__1155 = TableDef(csid__660('posts'), temper.listof(FieldDef(csid__660('title'), StringField(), false, temper.null, false), FieldDef(csid__660('status'), StringField(), false, SqlDefault(), false)), temper.null);
    params__1156 = temper.map_constructor(temper.listof(temper.pair_constructor('title', 'Hello'), temper.pair_constructor('status', 'published')));
    t_562 = csid__660('title');
    t_563 = csid__660('status');
    cs__1157 = changeset(tbl__1155, params__1156):cast(temper.listof(t_562, t_563));
    local_564, local_565, local_566 = temper.pcall(function()
      t_560 = cs__1157:toInsertSql();
      t_561 = t_560;
    end);
    if local_564 then
    else
      t_561 = temper.bubble();
    end
    s__1158 = t_561:toString();
    t_568 = temper.is_string_index(temper.string_indexof(s__1158, "'published'"));
    fn__14217 = function()
      return temper.concat('should use provided value: ', s__1158);
    end;
    temper.test_assert(test_559, t_568, fn__14217);
    return nil;
  end);
end;
Test_.test_toInsertSqlWithTimestampsUsesDefault__2179 = function()
  temper.test('toInsertSql with timestamps uses DEFAULT', function(test_572)
    local t_573, t_574, t_575, ts__1160, local_576, local_577, local_578, fields__1161, fn__14183, tbl__1163, params__1164, t_580, cs__1165, local_581, local_582, local_583, s__1166, t_585, fn__14182, t_586, fn__14181, t_587, fn__14180;
    local_576, local_577, local_578 = temper.pcall(function()
      t_573 = timestamps();
      ts__1160 = t_573;
    end);
    if local_576 then
    else
      ts__1160 = temper.bubble();
    end
    fields__1161 = temper.listbuilder_constructor();
    temper.listbuilder_add(fields__1161, FieldDef(csid__660('title'), StringField(), false, temper.null, false));
    fn__14183 = function(t__1162)
      temper.listbuilder_add(fields__1161, t__1162);
      return nil;
    end;
    temper.list_foreach(ts__1160, fn__14183);
    tbl__1163 = TableDef(csid__660('articles'), temper.listbuilder_tolist(fields__1161), temper.null);
    params__1164 = temper.map_constructor(temper.listof(temper.pair_constructor('title', 'News')));
    t_580 = csid__660('title');
    cs__1165 = changeset(tbl__1163, params__1164):cast(temper.listof(t_580));
    local_581, local_582, local_583 = temper.pcall(function()
      t_574 = cs__1165:toInsertSql();
      t_575 = t_574;
    end);
    if local_581 then
    else
      t_575 = temper.bubble();
    end
    s__1166 = t_575:toString();
    t_585 = temper.is_string_index(temper.string_indexof(s__1166, 'inserted_at'));
    fn__14182 = function()
      return temper.concat('should include inserted_at: ', s__1166);
    end;
    temper.test_assert(test_572, t_585, fn__14182);
    t_586 = temper.is_string_index(temper.string_indexof(s__1166, 'updated_at'));
    fn__14181 = function()
      return temper.concat('should include updated_at: ', s__1166);
    end;
    temper.test_assert(test_572, t_586, fn__14181);
    t_587 = temper.is_string_index(temper.string_indexof(s__1166, 'DEFAULT'));
    fn__14180 = function()
      return temper.concat('timestamps should use DEFAULT: ', s__1166);
    end;
    temper.test_assert(test_572, t_587, fn__14180);
    return nil;
  end);
end;
Test_.test_toInsertSqlSkipsVirtualFields__2180 = function()
  temper.test('toInsertSql skips virtual fields', function(test_588)
    local t_589, t_590, tbl__1168, params__1169, t_591, t_592, cs__1170, local_593, local_594, local_595, s__1171, t_597, fn__14154, t_598, fn__14153;
    tbl__1168 = TableDef(csid__660('users'), temper.listof(FieldDef(csid__660('name'), StringField(), false, temper.null, false), FieldDef(csid__660('full_name'), StringField(), true, temper.null, true)), temper.null);
    params__1169 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice'), temper.pair_constructor('full_name', 'Alice Smith')));
    t_591 = csid__660('name');
    t_592 = csid__660('full_name');
    cs__1170 = changeset(tbl__1168, params__1169):cast(temper.listof(t_591, t_592));
    local_593, local_594, local_595 = temper.pcall(function()
      t_589 = cs__1170:toInsertSql();
      t_590 = t_589;
    end);
    if local_593 then
    else
      t_590 = temper.bubble();
    end
    s__1171 = t_590:toString();
    t_597 = temper.is_string_index(temper.string_indexof(s__1171, "'Alice'"));
    fn__14154 = function()
      return temper.concat('name should be included: ', s__1171);
    end;
    temper.test_assert(test_588, t_597, fn__14154);
    t_598 = not temper.is_string_index(temper.string_indexof(s__1171, 'full_name'));
    fn__14153 = function()
      return temper.concat('virtual field should be excluded: ', s__1171);
    end;
    temper.test_assert(test_588, t_598, fn__14153);
    return nil;
  end);
end;
Test_.test_toInsertSqlAllowsMissingNonNullableVirtualField__2181 = function()
  temper.test('toInsertSql allows missing non-nullable virtual field', function(test_599)
    local t_600, t_601, tbl__1173, params__1174, t_602, cs__1175, local_603, local_604, local_605, s__1176, t_607, fn__14135;
    tbl__1173 = TableDef(csid__660('users'), temper.listof(FieldDef(csid__660('name'), StringField(), false, temper.null, false), FieldDef(csid__660('computed'), StringField(), false, temper.null, true)), temper.null);
    params__1174 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice')));
    t_602 = csid__660('name');
    cs__1175 = changeset(tbl__1173, params__1174):cast(temper.listof(t_602));
    local_603, local_604, local_605 = temper.pcall(function()
      t_600 = cs__1175:toInsertSql();
      t_601 = t_600;
    end);
    if local_603 then
    else
      t_601 = temper.bubble();
    end
    s__1176 = t_601:toString();
    t_607 = temper.is_string_index(temper.string_indexof(s__1176, "'Alice'"));
    fn__14135 = function()
      return temper.concat('should succeed: ', s__1176);
    end;
    temper.test_assert(test_599, t_607, fn__14135);
    return nil;
  end);
end;
Test_.test_toUpdateSqlSkipsVirtualFields__2182 = function()
  temper.test('toUpdateSql skips virtual fields', function(test_608)
    local t_609, t_610, tbl__1178, params__1179, t_611, t_612, cs__1180, local_613, local_614, local_615, s__1181, t_617, fn__14110, t_618, fn__14109;
    tbl__1178 = TableDef(csid__660('users'), temper.listof(FieldDef(csid__660('name'), StringField(), false, temper.null, false), FieldDef(csid__660('display'), StringField(), true, temper.null, true)), temper.null);
    params__1179 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Bob'), temper.pair_constructor('display', 'Bobby')));
    t_611 = csid__660('name');
    t_612 = csid__660('display');
    cs__1180 = changeset(tbl__1178, params__1179):cast(temper.listof(t_611, t_612));
    local_613, local_614, local_615 = temper.pcall(function()
      t_609 = cs__1180:toUpdateSql(1);
      t_610 = t_609;
    end);
    if local_613 then
    else
      t_610 = temper.bubble();
    end
    s__1181 = t_610:toString();
    t_617 = temper.is_string_index(temper.string_indexof(s__1181, "name = 'Bob'"));
    fn__14110 = function()
      return temper.concat('name should be in SET: ', s__1181);
    end;
    temper.test_assert(test_608, t_617, fn__14110);
    t_618 = not temper.is_string_index(temper.string_indexof(s__1181, 'display'));
    fn__14109 = function()
      return temper.concat('virtual field excluded from UPDATE: ', s__1181);
    end;
    temper.test_assert(test_608, t_618, fn__14109);
    return nil;
  end);
end;
Test_.test_toUpdateSqlUsesCustomPrimaryKey__2183 = function()
  temper.test('toUpdateSql uses custom primary key', function(test_619)
    local t_620, t_621, tbl__1183, params__1184, t_622, cs__1185, local_623, local_624, local_625, s__1186, t_627, fn__14093;
    tbl__1183 = TableDef(csid__660('posts'), temper.listof(FieldDef(csid__660('title'), StringField(), false, temper.null, false)), csid__660('post_id'));
    params__1184 = temper.map_constructor(temper.listof(temper.pair_constructor('title', 'Updated')));
    t_622 = csid__660('title');
    cs__1185 = changeset(tbl__1183, params__1184):cast(temper.listof(t_622));
    local_623, local_624, local_625 = temper.pcall(function()
      t_620 = cs__1185:toUpdateSql(99);
      t_621 = t_620;
    end);
    if local_623 then
    else
      t_621 = temper.bubble();
    end
    s__1186 = t_621:toString();
    t_627 = temper.str_eq(s__1186, "UPDATE posts SET title = 'Updated' WHERE post_id = 99");
    fn__14093 = function()
      return temper.concat('got: ', s__1186);
    end;
    temper.test_assert(test_619, t_627, fn__14093);
    return nil;
  end);
end;
Test_.test_deleteSqlUsesCustomPrimaryKey__2184 = function()
  temper.test('deleteSql uses custom primary key', function(test_628)
    local tbl__1188, s__1189, t_629, fn__14069;
    tbl__1188 = TableDef(csid__660('posts'), temper.listof(FieldDef(csid__660('title'), StringField(), false, temper.null, false)), csid__660('post_id'));
    s__1189 = deleteSql(tbl__1188, 42):toString();
    t_629 = temper.str_eq(s__1189, 'DELETE FROM posts WHERE post_id = 42');
    fn__14069 = function()
      return temper.concat('got: ', s__1189);
    end;
    temper.test_assert(test_628, t_629, fn__14069);
    return nil;
  end);
end;
Test_.test_deleteSqlUsesDefaultIdWhenPrimaryKeyNull__2185 = function()
  temper.test('deleteSql uses default id when primaryKey null', function(test_630)
    local tbl__1191, s__1192, t_631, fn__14058;
    tbl__1191 = TableDef(csid__660('users'), temper.listof(FieldDef(csid__660('name'), StringField(), false, temper.null, false)), temper.null);
    s__1192 = deleteSql(tbl__1191, 7):toString();
    t_631 = temper.str_eq(s__1192, 'DELETE FROM users WHERE id = 7');
    fn__14058 = function()
      return temper.concat('got: ', s__1192);
    end;
    temper.test_assert(test_630, t_631, fn__14058);
    return nil;
  end);
end;
sid__662 = function(name__1537)
  local return__574, t_632, local_633, local_634, local_635;
  local_633, local_634, local_635 = temper.pcall(function()
    t_632 = safeIdentifier(name__1537);
    return__574 = t_632;
  end);
  if local_633 then
  else
    return__574 = temper.bubble();
  end
  return return__574;
end;
Test_.test_bareFromProducesSelect__2267 = function()
  temper.test('bare from produces SELECT *', function(test_637)
    local q__1540, t_638, fn__13546;
    q__1540 = from(sid__662('users'));
    t_638 = temper.str_eq(q__1540:toSql():toString(), 'SELECT * FROM users');
    fn__13546 = function()
      return 'bare query';
    end;
    temper.test_assert(test_637, t_638, fn__13546);
    return nil;
  end);
end;
Test_.test_selectRestrictsColumns__2268 = function()
  temper.test('select restricts columns', function(test_639)
    local t_640, t_641, t_642, q__1542, t_643, fn__13536;
    t_640 = sid__662('users');
    t_641 = sid__662('id');
    t_642 = sid__662('name');
    q__1542 = from(t_640):select(temper.listof(t_641, t_642));
    t_643 = temper.str_eq(q__1542:toSql():toString(), 'SELECT id, name FROM users');
    fn__13536 = function()
      return 'select columns';
    end;
    temper.test_assert(test_639, t_643, fn__13536);
    return nil;
  end);
end;
Test_.test_whereAddsConditionWithIntValue__2269 = function()
  temper.test('where adds condition with int value', function(test_644)
    local t_645, t_646, t_647, q__1544, t_648, fn__13524;
    t_645 = sid__662('users');
    t_646 = SqlBuilder();
    t_646:appendSafe('age > ');
    t_646:appendInt32(18);
    t_647 = t_646.accumulated;
    q__1544 = from(t_645):where(t_647);
    t_648 = temper.str_eq(q__1544:toSql():toString(), 'SELECT * FROM users WHERE age > 18');
    fn__13524 = function()
      return 'where int';
    end;
    temper.test_assert(test_644, t_648, fn__13524);
    return nil;
  end);
end;
Test_.test_whereAddsConditionWithBoolValue__2271 = function()
  temper.test('where adds condition with bool value', function(test_649)
    local t_650, t_651, t_652, q__1546, t_653, fn__13512;
    t_650 = sid__662('users');
    t_651 = SqlBuilder();
    t_651:appendSafe('active = ');
    t_651:appendBoolean(true);
    t_652 = t_651.accumulated;
    q__1546 = from(t_650):where(t_652);
    t_653 = temper.str_eq(q__1546:toSql():toString(), 'SELECT * FROM users WHERE active = TRUE');
    fn__13512 = function()
      return 'where bool';
    end;
    temper.test_assert(test_649, t_653, fn__13512);
    return nil;
  end);
end;
Test_.test_chainedWhereUsesAnd__2273 = function()
  temper.test('chained where uses AND', function(test_654)
    local t_655, t_656, t_657, t_658, t_659, q__1548, t_660, fn__13495;
    t_655 = sid__662('users');
    t_656 = SqlBuilder();
    t_656:appendSafe('age > ');
    t_656:appendInt32(18);
    t_657 = t_656.accumulated;
    t_658 = from(t_655):where(t_657);
    t_659 = SqlBuilder();
    t_659:appendSafe('active = ');
    t_659:appendBoolean(true);
    q__1548 = t_658:where(t_659.accumulated);
    t_660 = temper.str_eq(q__1548:toSql():toString(), 'SELECT * FROM users WHERE age > 18 AND active = TRUE');
    fn__13495 = function()
      return 'chained where';
    end;
    temper.test_assert(test_654, t_660, fn__13495);
    return nil;
  end);
end;
Test_.test_orderByAsc__2276 = function()
  temper.test('orderBy ASC', function(test_661)
    local t_662, t_663, q__1550, t_664, fn__13486;
    t_662 = sid__662('users');
    t_663 = sid__662('name');
    q__1550 = from(t_662):orderBy(t_663, true);
    t_664 = temper.str_eq(q__1550:toSql():toString(), 'SELECT * FROM users ORDER BY name ASC');
    fn__13486 = function()
      return 'order asc';
    end;
    temper.test_assert(test_661, t_664, fn__13486);
    return nil;
  end);
end;
Test_.test_orderByDesc__2277 = function()
  temper.test('orderBy DESC', function(test_665)
    local t_666, t_667, q__1552, t_668, fn__13477;
    t_666 = sid__662('users');
    t_667 = sid__662('created_at');
    q__1552 = from(t_666):orderBy(t_667, false);
    t_668 = temper.str_eq(q__1552:toSql():toString(), 'SELECT * FROM users ORDER BY created_at DESC');
    fn__13477 = function()
      return 'order desc';
    end;
    temper.test_assert(test_665, t_668, fn__13477);
    return nil;
  end);
end;
Test_.test_limitAndOffset__2278 = function()
  temper.test('limit and offset', function(test_669)
    local t_670, t_671, q__1554, local_672, local_673, local_674, t_676, fn__13470;
    local_672, local_673, local_674 = temper.pcall(function()
      t_670 = from(sid__662('users')):limit(10);
      t_671 = t_670:offset(20);
      q__1554 = t_671;
    end);
    if local_672 then
    else
      q__1554 = temper.bubble();
    end
    t_676 = temper.str_eq(q__1554:toSql():toString(), 'SELECT * FROM users LIMIT 10 OFFSET 20');
    fn__13470 = function()
      return 'limit/offset';
    end;
    temper.test_assert(test_669, t_676, fn__13470);
    return nil;
  end);
end;
Test_.test_limitBubblesOnNegative__2279 = function()
  temper.test('limit bubbles on negative', function(test_677)
    local didBubble__1556, local_678, local_679, local_680, fn__13466;
    local_678, local_679, local_680 = temper.pcall(function()
      from(sid__662('users')):limit(-1);
      didBubble__1556 = false;
    end);
    if local_678 then
    else
      didBubble__1556 = true;
    end
    fn__13466 = function()
      return 'negative limit should bubble';
    end;
    temper.test_assert(test_677, didBubble__1556, fn__13466);
    return nil;
  end);
end;
Test_.test_offsetBubblesOnNegative__2280 = function()
  temper.test('offset bubbles on negative', function(test_682)
    local didBubble__1558, local_683, local_684, local_685, fn__13462;
    local_683, local_684, local_685 = temper.pcall(function()
      from(sid__662('users')):offset(-1);
      didBubble__1558 = false;
    end);
    if local_683 then
    else
      didBubble__1558 = true;
    end
    fn__13462 = function()
      return 'negative offset should bubble';
    end;
    temper.test_assert(test_682, didBubble__1558, fn__13462);
    return nil;
  end);
end;
Test_.test_complexComposedQuery__2281 = function()
  temper.test('complex composed query', function(test_687)
    local t_688, t_689, t_690, t_691, t_692, t_693, t_694, t_695, t_696, t_697, minAge__1560, q__1561, local_698, local_699, local_700, t_702, fn__13439;
    minAge__1560 = 21;
    local_698, local_699, local_700 = temper.pcall(function()
      t_688 = sid__662('users');
      t_689 = sid__662('id');
      t_690 = sid__662('name');
      t_691 = sid__662('email');
      t_692 = from(t_688):select(temper.listof(t_689, t_690, t_691));
      t_693 = SqlBuilder();
      t_693:appendSafe('age >= ');
      t_693:appendInt32(21);
      t_694 = t_692:where(t_693.accumulated);
      t_695 = SqlBuilder();
      t_695:appendSafe('active = ');
      t_695:appendBoolean(true);
      t_696 = t_694:where(t_695.accumulated):orderBy(sid__662('name'), true):limit(25);
      t_697 = t_696:offset(0);
      q__1561 = t_697;
    end);
    if local_698 then
    else
      q__1561 = temper.bubble();
    end
    t_702 = temper.str_eq(q__1561:toSql():toString(), 'SELECT id, name, email FROM users WHERE age >= 21 AND active = TRUE ORDER BY name ASC LIMIT 25 OFFSET 0');
    fn__13439 = function()
      return 'complex query';
    end;
    temper.test_assert(test_687, t_702, fn__13439);
    return nil;
  end);
end;
Test_.test_safeToSqlAppliesDefaultLimitWhenNoneSet__2284 = function()
  temper.test('safeToSql applies default limit when none set', function(test_703)
    local t_704, t_705, q__1563, local_706, local_707, local_708, s__1564, t_710, fn__13433;
    q__1563 = from(sid__662('users'));
    local_706, local_707, local_708 = temper.pcall(function()
      t_704 = q__1563:safeToSql(100);
      t_705 = t_704;
    end);
    if local_706 then
    else
      t_705 = temper.bubble();
    end
    s__1564 = t_705:toString();
    t_710 = temper.str_eq(s__1564, 'SELECT * FROM users LIMIT 100');
    fn__13433 = function()
      return temper.concat('should have limit: ', s__1564);
    end;
    temper.test_assert(test_703, t_710, fn__13433);
    return nil;
  end);
end;
Test_.test_safeToSqlRespectsExplicitLimit__2285 = function()
  temper.test('safeToSql respects explicit limit', function(test_711)
    local t_712, t_713, t_714, q__1566, local_715, local_716, local_717, local_719, local_720, local_721, s__1567, t_723, fn__13427;
    local_715, local_716, local_717 = temper.pcall(function()
      t_712 = from(sid__662('users')):limit(5);
      q__1566 = t_712;
    end);
    if local_715 then
    else
      q__1566 = temper.bubble();
    end
    local_719, local_720, local_721 = temper.pcall(function()
      t_713 = q__1566:safeToSql(100);
      t_714 = t_713;
    end);
    if local_719 then
    else
      t_714 = temper.bubble();
    end
    s__1567 = t_714:toString();
    t_723 = temper.str_eq(s__1567, 'SELECT * FROM users LIMIT 5');
    fn__13427 = function()
      return temper.concat('explicit limit preserved: ', s__1567);
    end;
    temper.test_assert(test_711, t_723, fn__13427);
    return nil;
  end);
end;
Test_.test_safeToSqlBubblesOnNegativeDefaultLimit__2286 = function()
  temper.test('safeToSql bubbles on negative defaultLimit', function(test_724)
    local didBubble__1569, local_725, local_726, local_727, fn__13423;
    local_725, local_726, local_727 = temper.pcall(function()
      from(sid__662('users')):safeToSql(-1);
      didBubble__1569 = false;
    end);
    if local_725 then
    else
      didBubble__1569 = true;
    end
    fn__13423 = function()
      return 'negative defaultLimit should bubble';
    end;
    temper.test_assert(test_724, didBubble__1569, fn__13423);
    return nil;
  end);
end;
Test_.test_whereWithInjectionAttemptInStringValueIsEscaped__2287 = function()
  temper.test('where with injection attempt in string value is escaped', function(test_729)
    local evil__1571, t_730, t_731, t_732, q__1572, s__1573, t_733, fn__13406, t_734, fn__13405;
    evil__1571 = "'; DROP TABLE users; --";
    t_730 = sid__662('users');
    t_731 = SqlBuilder();
    t_731:appendSafe('name = ');
    t_731:appendString("'; DROP TABLE users; --");
    t_732 = t_731.accumulated;
    q__1572 = from(t_730):where(t_732);
    s__1573 = q__1572:toSql():toString();
    t_733 = temper.is_string_index(temper.string_indexof(s__1573, "''"));
    fn__13406 = function()
      return temper.concat('quotes must be doubled: ', s__1573);
    end;
    temper.test_assert(test_729, t_733, fn__13406);
    t_734 = temper.is_string_index(temper.string_indexof(s__1573, 'SELECT * FROM users WHERE name ='));
    fn__13405 = function()
      return temper.concat('structure intact: ', s__1573);
    end;
    temper.test_assert(test_729, t_734, fn__13405);
    return nil;
  end);
end;
Test_.test_safeIdentifierRejectsUserSuppliedTableNameWithMetacharacters__2289 = function()
  temper.test('safeIdentifier rejects user-supplied table name with metacharacters', function(test_735)
    local attack__1575, didBubble__1576, local_736, local_737, local_738, fn__13402;
    attack__1575 = 'users; DROP TABLE users; --';
    local_736, local_737, local_738 = temper.pcall(function()
      safeIdentifier('users; DROP TABLE users; --');
      didBubble__1576 = false;
    end);
    if local_736 then
    else
      didBubble__1576 = true;
    end
    fn__13402 = function()
      return 'metacharacter-containing name must be rejected at construction';
    end;
    temper.test_assert(test_735, didBubble__1576, fn__13402);
    return nil;
  end);
end;
Test_.test_innerJoinProducesInnerJoin__2290 = function()
  temper.test('innerJoin produces INNER JOIN', function(test_740)
    local t_741, t_742, t_743, t_744, q__1578, t_745, fn__13390;
    t_741 = sid__662('users');
    t_742 = sid__662('orders');
    t_743 = SqlBuilder();
    t_743:appendSafe('users.id = orders.user_id');
    t_744 = t_743.accumulated;
    q__1578 = from(t_741):innerJoin(t_742, t_744);
    t_745 = temper.str_eq(q__1578:toSql():toString(), 'SELECT * FROM users INNER JOIN orders ON users.id = orders.user_id');
    fn__13390 = function()
      return 'inner join';
    end;
    temper.test_assert(test_740, t_745, fn__13390);
    return nil;
  end);
end;
Test_.test_leftJoinProducesLeftJoin__2292 = function()
  temper.test('leftJoin produces LEFT JOIN', function(test_746)
    local t_747, t_748, t_749, t_750, q__1580, t_751, fn__13378;
    t_747 = sid__662('users');
    t_748 = sid__662('profiles');
    t_749 = SqlBuilder();
    t_749:appendSafe('users.id = profiles.user_id');
    t_750 = t_749.accumulated;
    q__1580 = from(t_747):leftJoin(t_748, t_750);
    t_751 = temper.str_eq(q__1580:toSql():toString(), 'SELECT * FROM users LEFT JOIN profiles ON users.id = profiles.user_id');
    fn__13378 = function()
      return 'left join';
    end;
    temper.test_assert(test_746, t_751, fn__13378);
    return nil;
  end);
end;
Test_.test_rightJoinProducesRightJoin__2294 = function()
  temper.test('rightJoin produces RIGHT JOIN', function(test_752)
    local t_753, t_754, t_755, t_756, q__1582, t_757, fn__13366;
    t_753 = sid__662('orders');
    t_754 = sid__662('users');
    t_755 = SqlBuilder();
    t_755:appendSafe('orders.user_id = users.id');
    t_756 = t_755.accumulated;
    q__1582 = from(t_753):rightJoin(t_754, t_756);
    t_757 = temper.str_eq(q__1582:toSql():toString(), 'SELECT * FROM orders RIGHT JOIN users ON orders.user_id = users.id');
    fn__13366 = function()
      return 'right join';
    end;
    temper.test_assert(test_752, t_757, fn__13366);
    return nil;
  end);
end;
Test_.test_fullJoinProducesFullOuterJoin__2296 = function()
  temper.test('fullJoin produces FULL OUTER JOIN', function(test_758)
    local t_759, t_760, t_761, t_762, q__1584, t_763, fn__13354;
    t_759 = sid__662('users');
    t_760 = sid__662('orders');
    t_761 = SqlBuilder();
    t_761:appendSafe('users.id = orders.user_id');
    t_762 = t_761.accumulated;
    q__1584 = from(t_759):fullJoin(t_760, t_762);
    t_763 = temper.str_eq(q__1584:toSql():toString(), 'SELECT * FROM users FULL OUTER JOIN orders ON users.id = orders.user_id');
    fn__13354 = function()
      return 'full join';
    end;
    temper.test_assert(test_758, t_763, fn__13354);
    return nil;
  end);
end;
Test_.test_chainedJoins__2298 = function()
  temper.test('chained joins', function(test_764)
    local t_765, t_766, t_767, t_768, t_769, t_770, t_771, q__1586, t_772, fn__13337;
    t_765 = sid__662('users');
    t_766 = sid__662('orders');
    t_767 = SqlBuilder();
    t_767:appendSafe('users.id = orders.user_id');
    t_768 = t_767.accumulated;
    t_769 = from(t_765):innerJoin(t_766, t_768);
    t_770 = sid__662('profiles');
    t_771 = SqlBuilder();
    t_771:appendSafe('users.id = profiles.user_id');
    q__1586 = t_769:leftJoin(t_770, t_771.accumulated);
    t_772 = temper.str_eq(q__1586:toSql():toString(), 'SELECT * FROM users INNER JOIN orders ON users.id = orders.user_id LEFT JOIN profiles ON users.id = profiles.user_id');
    fn__13337 = function()
      return 'chained joins';
    end;
    temper.test_assert(test_764, t_772, fn__13337);
    return nil;
  end);
end;
Test_.test_joinWithWhereAndOrderBy__2301 = function()
  temper.test('join with where and orderBy', function(test_773)
    local t_774, t_775, t_776, t_777, t_778, t_779, t_780, q__1588, local_781, local_782, local_783, t_785, fn__13318;
    local_781, local_782, local_783 = temper.pcall(function()
      t_774 = sid__662('users');
      t_775 = sid__662('orders');
      t_776 = SqlBuilder();
      t_776:appendSafe('users.id = orders.user_id');
      t_777 = t_776.accumulated;
      t_778 = from(t_774):innerJoin(t_775, t_777);
      t_779 = SqlBuilder();
      t_779:appendSafe('orders.total > ');
      t_779:appendInt32(100);
      t_780 = t_778:where(t_779.accumulated):orderBy(sid__662('name'), true):limit(10);
      q__1588 = t_780;
    end);
    if local_781 then
    else
      q__1588 = temper.bubble();
    end
    t_785 = temper.str_eq(q__1588:toSql():toString(), 'SELECT * FROM users INNER JOIN orders ON users.id = orders.user_id WHERE orders.total > 100 ORDER BY name ASC LIMIT 10');
    fn__13318 = function()
      return 'join with where/order/limit';
    end;
    temper.test_assert(test_773, t_785, fn__13318);
    return nil;
  end);
end;
Test_.test_colHelperProducesQualifiedReference__2304 = function()
  temper.test('col helper produces qualified reference', function(test_786)
    local c__1590, t_787, fn__13310;
    c__1590 = col(sid__662('users'), sid__662('id'));
    t_787 = temper.str_eq(c__1590:toString(), 'users.id');
    fn__13310 = function()
      return 'col helper';
    end;
    temper.test_assert(test_786, t_787, fn__13310);
    return nil;
  end);
end;
Test_.test_joinWithColHelper__2305 = function()
  temper.test('join with col helper', function(test_788)
    local onCond__1592, b__1593, t_789, t_790, t_791, q__1594, t_792, fn__13290;
    onCond__1592 = col(sid__662('users'), sid__662('id'));
    b__1593 = SqlBuilder();
    b__1593:appendFragment(onCond__1592);
    b__1593:appendSafe(' = ');
    b__1593:appendFragment(col(sid__662('orders'), sid__662('user_id')));
    t_789 = sid__662('users');
    t_790 = sid__662('orders');
    t_791 = b__1593.accumulated;
    q__1594 = from(t_789):innerJoin(t_790, t_791);
    t_792 = temper.str_eq(q__1594:toSql():toString(), 'SELECT * FROM users INNER JOIN orders ON users.id = orders.user_id');
    fn__13290 = function()
      return 'join with col';
    end;
    temper.test_assert(test_788, t_792, fn__13290);
    return nil;
  end);
end;
Test_.test_orWhereBasic__2306 = function()
  temper.test('orWhere basic', function(test_793)
    local t_794, t_795, t_796, q__1596, t_797, fn__13278;
    t_794 = sid__662('users');
    t_795 = SqlBuilder();
    t_795:appendSafe('status = ');
    t_795:appendString('active');
    t_796 = t_795.accumulated;
    q__1596 = from(t_794):orWhere(t_796);
    t_797 = temper.str_eq(q__1596:toSql():toString(), "SELECT * FROM users WHERE status = 'active'");
    fn__13278 = function()
      return 'orWhere basic';
    end;
    temper.test_assert(test_793, t_797, fn__13278);
    return nil;
  end);
end;
Test_.test_whereThenOrWhere__2308 = function()
  temper.test('where then orWhere', function(test_798)
    local t_799, t_800, t_801, t_802, t_803, q__1598, t_804, fn__13261;
    t_799 = sid__662('users');
    t_800 = SqlBuilder();
    t_800:appendSafe('age > ');
    t_800:appendInt32(18);
    t_801 = t_800.accumulated;
    t_802 = from(t_799):where(t_801);
    t_803 = SqlBuilder();
    t_803:appendSafe('vip = ');
    t_803:appendBoolean(true);
    q__1598 = t_802:orWhere(t_803.accumulated);
    t_804 = temper.str_eq(q__1598:toSql():toString(), 'SELECT * FROM users WHERE age > 18 OR vip = TRUE');
    fn__13261 = function()
      return 'where then orWhere';
    end;
    temper.test_assert(test_798, t_804, fn__13261);
    return nil;
  end);
end;
Test_.test_multipleOrWhere__2311 = function()
  temper.test('multiple orWhere', function(test_805)
    local t_806, t_807, t_808, t_809, t_810, t_811, t_812, q__1600, t_813, fn__13239;
    t_806 = sid__662('users');
    t_807 = SqlBuilder();
    t_807:appendSafe('active = ');
    t_807:appendBoolean(true);
    t_808 = t_807.accumulated;
    t_809 = from(t_806):where(t_808);
    t_810 = SqlBuilder();
    t_810:appendSafe('role = ');
    t_810:appendString('admin');
    t_811 = t_809:orWhere(t_810.accumulated);
    t_812 = SqlBuilder();
    t_812:appendSafe('role = ');
    t_812:appendString('moderator');
    q__1600 = t_811:orWhere(t_812.accumulated);
    t_813 = temper.str_eq(q__1600:toSql():toString(), "SELECT * FROM users WHERE active = TRUE OR role = 'admin' OR role = 'moderator'");
    fn__13239 = function()
      return 'multiple orWhere';
    end;
    temper.test_assert(test_805, t_813, fn__13239);
    return nil;
  end);
end;
Test_.test_mixedWhereAndOrWhere__2315 = function()
  temper.test('mixed where and orWhere', function(test_814)
    local t_815, t_816, t_817, t_818, t_819, t_820, t_821, q__1602, t_822, fn__13217;
    t_815 = sid__662('users');
    t_816 = SqlBuilder();
    t_816:appendSafe('age > ');
    t_816:appendInt32(18);
    t_817 = t_816.accumulated;
    t_818 = from(t_815):where(t_817);
    t_819 = SqlBuilder();
    t_819:appendSafe('active = ');
    t_819:appendBoolean(true);
    t_820 = t_818:where(t_819.accumulated);
    t_821 = SqlBuilder();
    t_821:appendSafe('vip = ');
    t_821:appendBoolean(true);
    q__1602 = t_820:orWhere(t_821.accumulated);
    t_822 = temper.str_eq(q__1602:toSql():toString(), 'SELECT * FROM users WHERE age > 18 AND active = TRUE OR vip = TRUE');
    fn__13217 = function()
      return 'mixed where and orWhere';
    end;
    temper.test_assert(test_814, t_822, fn__13217);
    return nil;
  end);
end;
Test_.test_whereNull__2319 = function()
  temper.test('whereNull', function(test_823)
    local t_824, t_825, q__1604, t_826, fn__13208;
    t_824 = sid__662('users');
    t_825 = sid__662('deleted_at');
    q__1604 = from(t_824):whereNull(t_825);
    t_826 = temper.str_eq(q__1604:toSql():toString(), 'SELECT * FROM users WHERE deleted_at IS NULL');
    fn__13208 = function()
      return 'whereNull';
    end;
    temper.test_assert(test_823, t_826, fn__13208);
    return nil;
  end);
end;
Test_.test_whereNotNull__2320 = function()
  temper.test('whereNotNull', function(test_827)
    local t_828, t_829, q__1606, t_830, fn__13199;
    t_828 = sid__662('users');
    t_829 = sid__662('email');
    q__1606 = from(t_828):whereNotNull(t_829);
    t_830 = temper.str_eq(q__1606:toSql():toString(), 'SELECT * FROM users WHERE email IS NOT NULL');
    fn__13199 = function()
      return 'whereNotNull';
    end;
    temper.test_assert(test_827, t_830, fn__13199);
    return nil;
  end);
end;
Test_.test_whereNullChainedWithWhere__2321 = function()
  temper.test('whereNull chained with where', function(test_831)
    local t_832, t_833, t_834, q__1608, t_835, fn__13185;
    t_832 = sid__662('users');
    t_833 = SqlBuilder();
    t_833:appendSafe('active = ');
    t_833:appendBoolean(true);
    t_834 = t_833.accumulated;
    q__1608 = from(t_832):where(t_834):whereNull(sid__662('deleted_at'));
    t_835 = temper.str_eq(q__1608:toSql():toString(), 'SELECT * FROM users WHERE active = TRUE AND deleted_at IS NULL');
    fn__13185 = function()
      return 'whereNull chained';
    end;
    temper.test_assert(test_831, t_835, fn__13185);
    return nil;
  end);
end;
Test_.test_whereNotNullChainedWithOrWhere__2323 = function()
  temper.test('whereNotNull chained with orWhere', function(test_836)
    local t_837, t_838, t_839, t_840, q__1610, t_841, fn__13171;
    t_837 = sid__662('users');
    t_838 = sid__662('deleted_at');
    t_839 = from(t_837):whereNull(t_838);
    t_840 = SqlBuilder();
    t_840:appendSafe('role = ');
    t_840:appendString('admin');
    q__1610 = t_839:orWhere(t_840.accumulated);
    t_841 = temper.str_eq(q__1610:toSql():toString(), "SELECT * FROM users WHERE deleted_at IS NULL OR role = 'admin'");
    fn__13171 = function()
      return 'whereNotNull with orWhere';
    end;
    temper.test_assert(test_836, t_841, fn__13171);
    return nil;
  end);
end;
Test_.test_whereInWithIntValues__2325 = function()
  temper.test('whereIn with int values', function(test_842)
    local t_843, t_844, t_845, t_846, t_847, q__1612, t_848, fn__13159;
    t_843 = sid__662('users');
    t_844 = sid__662('id');
    t_845 = SqlInt32(1);
    t_846 = SqlInt32(2);
    t_847 = SqlInt32(3);
    q__1612 = from(t_843):whereIn(t_844, temper.listof(t_845, t_846, t_847));
    t_848 = temper.str_eq(q__1612:toSql():toString(), 'SELECT * FROM users WHERE id IN (1, 2, 3)');
    fn__13159 = function()
      return 'whereIn ints';
    end;
    temper.test_assert(test_842, t_848, fn__13159);
    return nil;
  end);
end;
Test_.test_whereInWithStringValuesEscaping__2326 = function()
  temper.test('whereIn with string values escaping', function(test_849)
    local t_850, t_851, t_852, t_853, q__1614, t_854, fn__13148;
    t_850 = sid__662('users');
    t_851 = sid__662('name');
    t_852 = SqlString('Alice');
    t_853 = SqlString("Bob's");
    q__1614 = from(t_850):whereIn(t_851, temper.listof(t_852, t_853));
    t_854 = temper.str_eq(q__1614:toSql():toString(), "SELECT * FROM users WHERE name IN ('Alice', 'Bob''s')");
    fn__13148 = function()
      return 'whereIn strings';
    end;
    temper.test_assert(test_849, t_854, fn__13148);
    return nil;
  end);
end;
Test_.test_whereInWithEmptyListProduces1_0__2327 = function()
  temper.test('whereIn with empty list produces 1=0', function(test_855)
    local t_856, t_857, q__1616, t_858, fn__13139;
    t_856 = sid__662('users');
    t_857 = sid__662('id');
    q__1616 = from(t_856):whereIn(t_857, temper.listof());
    t_858 = temper.str_eq(q__1616:toSql():toString(), 'SELECT * FROM users WHERE 1 = 0');
    fn__13139 = function()
      return 'whereIn empty';
    end;
    temper.test_assert(test_855, t_858, fn__13139);
    return nil;
  end);
end;
Test_.test_whereInChained__2328 = function()
  temper.test('whereIn chained', function(test_859)
    local t_860, t_861, t_862, q__1618, t_863, fn__13123;
    t_860 = sid__662('users');
    t_861 = SqlBuilder();
    t_861:appendSafe('active = ');
    t_861:appendBoolean(true);
    t_862 = t_861.accumulated;
    q__1618 = from(t_860):where(t_862):whereIn(sid__662('role'), temper.listof(SqlString('admin'), SqlString('user')));
    t_863 = temper.str_eq(q__1618:toSql():toString(), "SELECT * FROM users WHERE active = TRUE AND role IN ('admin', 'user')");
    fn__13123 = function()
      return 'whereIn chained';
    end;
    temper.test_assert(test_859, t_863, fn__13123);
    return nil;
  end);
end;
Test_.test_whereInSingleElement__2330 = function()
  temper.test('whereIn single element', function(test_864)
    local t_865, t_866, t_867, q__1620, t_868, fn__13113;
    t_865 = sid__662('users');
    t_866 = sid__662('id');
    t_867 = SqlInt32(42);
    q__1620 = from(t_865):whereIn(t_866, temper.listof(t_867));
    t_868 = temper.str_eq(q__1620:toSql():toString(), 'SELECT * FROM users WHERE id IN (42)');
    fn__13113 = function()
      return 'whereIn single';
    end;
    temper.test_assert(test_864, t_868, fn__13113);
    return nil;
  end);
end;
Test_.test_whereNotBasic__2331 = function()
  temper.test('whereNot basic', function(test_869)
    local t_870, t_871, t_872, q__1622, t_873, fn__13101;
    t_870 = sid__662('users');
    t_871 = SqlBuilder();
    t_871:appendSafe('active = ');
    t_871:appendBoolean(true);
    t_872 = t_871.accumulated;
    q__1622 = from(t_870):whereNot(t_872);
    t_873 = temper.str_eq(q__1622:toSql():toString(), 'SELECT * FROM users WHERE NOT (active = TRUE)');
    fn__13101 = function()
      return 'whereNot';
    end;
    temper.test_assert(test_869, t_873, fn__13101);
    return nil;
  end);
end;
Test_.test_whereNotChained__2333 = function()
  temper.test('whereNot chained', function(test_874)
    local t_875, t_876, t_877, t_878, t_879, q__1624, t_880, fn__13084;
    t_875 = sid__662('users');
    t_876 = SqlBuilder();
    t_876:appendSafe('age > ');
    t_876:appendInt32(18);
    t_877 = t_876.accumulated;
    t_878 = from(t_875):where(t_877);
    t_879 = SqlBuilder();
    t_879:appendSafe('banned = ');
    t_879:appendBoolean(true);
    q__1624 = t_878:whereNot(t_879.accumulated);
    t_880 = temper.str_eq(q__1624:toSql():toString(), 'SELECT * FROM users WHERE age > 18 AND NOT (banned = TRUE)');
    fn__13084 = function()
      return 'whereNot chained';
    end;
    temper.test_assert(test_874, t_880, fn__13084);
    return nil;
  end);
end;
Test_.test_whereBetweenIntegers__2336 = function()
  temper.test('whereBetween integers', function(test_881)
    local t_882, t_883, t_884, t_885, q__1626, t_886, fn__13073;
    t_882 = sid__662('users');
    t_883 = sid__662('age');
    t_884 = SqlInt32(18);
    t_885 = SqlInt32(65);
    q__1626 = from(t_882):whereBetween(t_883, t_884, t_885);
    t_886 = temper.str_eq(q__1626:toSql():toString(), 'SELECT * FROM users WHERE age BETWEEN 18 AND 65');
    fn__13073 = function()
      return 'whereBetween ints';
    end;
    temper.test_assert(test_881, t_886, fn__13073);
    return nil;
  end);
end;
Test_.test_whereBetweenChained__2337 = function()
  temper.test('whereBetween chained', function(test_887)
    local t_888, t_889, t_890, q__1628, t_891, fn__13057;
    t_888 = sid__662('users');
    t_889 = SqlBuilder();
    t_889:appendSafe('active = ');
    t_889:appendBoolean(true);
    t_890 = t_889.accumulated;
    q__1628 = from(t_888):where(t_890):whereBetween(sid__662('age'), SqlInt32(21), SqlInt32(30));
    t_891 = temper.str_eq(q__1628:toSql():toString(), 'SELECT * FROM users WHERE active = TRUE AND age BETWEEN 21 AND 30');
    fn__13057 = function()
      return 'whereBetween chained';
    end;
    temper.test_assert(test_887, t_891, fn__13057);
    return nil;
  end);
end;
Test_.test_whereLikeBasic__2339 = function()
  temper.test('whereLike basic', function(test_892)
    local t_893, t_894, q__1630, t_895, fn__13048;
    t_893 = sid__662('users');
    t_894 = sid__662('name');
    q__1630 = from(t_893):whereLike(t_894, 'John%');
    t_895 = temper.str_eq(q__1630:toSql():toString(), "SELECT * FROM users WHERE name LIKE 'John%'");
    fn__13048 = function()
      return 'whereLike';
    end;
    temper.test_assert(test_892, t_895, fn__13048);
    return nil;
  end);
end;
Test_.test_whereIlikeBasic__2340 = function()
  temper.test('whereILike basic', function(test_896)
    local t_897, t_898, q__1632, t_899, fn__13039;
    t_897 = sid__662('users');
    t_898 = sid__662('email');
    q__1632 = from(t_897):whereILike(t_898, '%@gmail.com');
    t_899 = temper.str_eq(q__1632:toSql():toString(), "SELECT * FROM users WHERE email ILIKE '%@gmail.com'");
    fn__13039 = function()
      return 'whereILike';
    end;
    temper.test_assert(test_896, t_899, fn__13039);
    return nil;
  end);
end;
Test_.test_whereLikeWithInjectionAttempt__2341 = function()
  temper.test('whereLike with injection attempt', function(test_900)
    local t_901, t_902, q__1634, s__1635, t_903, fn__13025, t_904, fn__13024;
    t_901 = sid__662('users');
    t_902 = sid__662('name');
    q__1634 = from(t_901):whereLike(t_902, "'; DROP TABLE users; --");
    s__1635 = q__1634:toSql():toString();
    t_903 = temper.is_string_index(temper.string_indexof(s__1635, "''"));
    fn__13025 = function()
      return temper.concat('like injection escaped: ', s__1635);
    end;
    temper.test_assert(test_900, t_903, fn__13025);
    t_904 = temper.is_string_index(temper.string_indexof(s__1635, 'LIKE'));
    fn__13024 = function()
      return temper.concat('like structure intact: ', s__1635);
    end;
    temper.test_assert(test_900, t_904, fn__13024);
    return nil;
  end);
end;
Test_.test_whereLikeWildcardPatterns__2342 = function()
  temper.test('whereLike wildcard patterns', function(test_905)
    local t_906, t_907, q__1637, t_908, fn__13015;
    t_906 = sid__662('users');
    t_907 = sid__662('name');
    q__1637 = from(t_906):whereLike(t_907, '%son%');
    t_908 = temper.str_eq(q__1637:toSql():toString(), "SELECT * FROM users WHERE name LIKE '%son%'");
    fn__13015 = function()
      return 'whereLike wildcard';
    end;
    temper.test_assert(test_905, t_908, fn__13015);
    return nil;
  end);
end;
Test_.test_countAllProducesCount__2343 = function()
  temper.test('countAll produces COUNT(*)', function(test_909)
    local f__1639, t_910, fn__13009;
    f__1639 = countAll();
    t_910 = temper.str_eq(f__1639:toString(), 'COUNT(*)');
    fn__13009 = function()
      return 'countAll';
    end;
    temper.test_assert(test_909, t_910, fn__13009);
    return nil;
  end);
end;
Test_.test_countColProducesCountField__2344 = function()
  temper.test('countCol produces COUNT(field)', function(test_911)
    local f__1641, t_912, fn__13002;
    f__1641 = countCol(sid__662('id'));
    t_912 = temper.str_eq(f__1641:toString(), 'COUNT(id)');
    fn__13002 = function()
      return 'countCol';
    end;
    temper.test_assert(test_911, t_912, fn__13002);
    return nil;
  end);
end;
Test_.test_sumColProducesSumField__2345 = function()
  temper.test('sumCol produces SUM(field)', function(test_913)
    local f__1643, t_914, fn__12995;
    f__1643 = sumCol(sid__662('amount'));
    t_914 = temper.str_eq(f__1643:toString(), 'SUM(amount)');
    fn__12995 = function()
      return 'sumCol';
    end;
    temper.test_assert(test_913, t_914, fn__12995);
    return nil;
  end);
end;
Test_.test_avgColProducesAvgField__2346 = function()
  temper.test('avgCol produces AVG(field)', function(test_915)
    local f__1645, t_916, fn__12988;
    f__1645 = avgCol(sid__662('price'));
    t_916 = temper.str_eq(f__1645:toString(), 'AVG(price)');
    fn__12988 = function()
      return 'avgCol';
    end;
    temper.test_assert(test_915, t_916, fn__12988);
    return nil;
  end);
end;
Test_.test_minColProducesMinField__2347 = function()
  temper.test('minCol produces MIN(field)', function(test_917)
    local f__1647, t_918, fn__12981;
    f__1647 = minCol(sid__662('created_at'));
    t_918 = temper.str_eq(f__1647:toString(), 'MIN(created_at)');
    fn__12981 = function()
      return 'minCol';
    end;
    temper.test_assert(test_917, t_918, fn__12981);
    return nil;
  end);
end;
Test_.test_maxColProducesMaxField__2348 = function()
  temper.test('maxCol produces MAX(field)', function(test_919)
    local f__1649, t_920, fn__12974;
    f__1649 = maxCol(sid__662('score'));
    t_920 = temper.str_eq(f__1649:toString(), 'MAX(score)');
    fn__12974 = function()
      return 'maxCol';
    end;
    temper.test_assert(test_919, t_920, fn__12974);
    return nil;
  end);
end;
Test_.test_selectExprWithAggregate__2349 = function()
  temper.test('selectExpr with aggregate', function(test_921)
    local t_922, t_923, q__1651, t_924, fn__12965;
    t_922 = sid__662('orders');
    t_923 = countAll();
    q__1651 = from(t_922):selectExpr(temper.listof(t_923));
    t_924 = temper.str_eq(q__1651:toSql():toString(), 'SELECT COUNT(*) FROM orders');
    fn__12965 = function()
      return 'selectExpr count';
    end;
    temper.test_assert(test_921, t_924, fn__12965);
    return nil;
  end);
end;
Test_.test_selectExprWithMultipleExpressions__2350 = function()
  temper.test('selectExpr with multiple expressions', function(test_925)
    local nameFrag__1653, t_926, t_927, q__1654, t_928, fn__12953;
    nameFrag__1653 = col(sid__662('users'), sid__662('name'));
    t_926 = sid__662('users');
    t_927 = countAll();
    q__1654 = from(t_926):selectExpr(temper.listof(nameFrag__1653, t_927));
    t_928 = temper.str_eq(q__1654:toSql():toString(), 'SELECT users.name, COUNT(*) FROM users');
    fn__12953 = function()
      return 'selectExpr multi';
    end;
    temper.test_assert(test_925, t_928, fn__12953);
    return nil;
  end);
end;
Test_.test_selectExprOverridesSelectedFields__2351 = function()
  temper.test('selectExpr overrides selectedFields', function(test_929)
    local t_930, t_931, t_932, q__1656, t_933, fn__12941;
    t_930 = sid__662('users');
    t_931 = sid__662('id');
    t_932 = sid__662('name');
    q__1656 = from(t_930):select(temper.listof(t_931, t_932)):selectExpr(temper.listof(countAll()));
    t_933 = temper.str_eq(q__1656:toSql():toString(), 'SELECT COUNT(*) FROM users');
    fn__12941 = function()
      return 'selectExpr overrides select';
    end;
    temper.test_assert(test_929, t_933, fn__12941);
    return nil;
  end);
end;
Test_.test_groupBySingleField__2352 = function()
  temper.test('groupBy single field', function(test_934)
    local t_935, t_936, t_937, q__1658, t_938, fn__12927;
    t_935 = sid__662('orders');
    t_936 = col(sid__662('orders'), sid__662('status'));
    t_937 = countAll();
    q__1658 = from(t_935):selectExpr(temper.listof(t_936, t_937)):groupBy(sid__662('status'));
    t_938 = temper.str_eq(q__1658:toSql():toString(), 'SELECT orders.status, COUNT(*) FROM orders GROUP BY status');
    fn__12927 = function()
      return 'groupBy single';
    end;
    temper.test_assert(test_934, t_938, fn__12927);
    return nil;
  end);
end;
Test_.test_groupByMultipleFields__2353 = function()
  temper.test('groupBy multiple fields', function(test_939)
    local t_940, t_941, q__1660, t_942, fn__12916;
    t_940 = sid__662('orders');
    t_941 = sid__662('status');
    q__1660 = from(t_940):groupBy(t_941):groupBy(sid__662('category'));
    t_942 = temper.str_eq(q__1660:toSql():toString(), 'SELECT * FROM orders GROUP BY status, category');
    fn__12916 = function()
      return 'groupBy multiple';
    end;
    temper.test_assert(test_939, t_942, fn__12916);
    return nil;
  end);
end;
Test_.test_havingBasic__2354 = function()
  temper.test('having basic', function(test_943)
    local t_944, t_945, t_946, t_947, t_948, q__1662, t_949, fn__12897;
    t_944 = sid__662('orders');
    t_945 = col(sid__662('orders'), sid__662('status'));
    t_946 = countAll();
    t_947 = from(t_944):selectExpr(temper.listof(t_945, t_946)):groupBy(sid__662('status'));
    t_948 = SqlBuilder();
    t_948:appendSafe('COUNT(*) > ');
    t_948:appendInt32(5);
    q__1662 = t_947:having(t_948.accumulated);
    t_949 = temper.str_eq(q__1662:toSql():toString(), 'SELECT orders.status, COUNT(*) FROM orders GROUP BY status HAVING COUNT(*) > 5');
    fn__12897 = function()
      return 'having basic';
    end;
    temper.test_assert(test_943, t_949, fn__12897);
    return nil;
  end);
end;
Test_.test_orHaving__2356 = function()
  temper.test('orHaving', function(test_950)
    local t_951, t_952, t_953, t_954, t_955, t_956, q__1664, t_957, fn__12878;
    t_951 = sid__662('orders');
    t_952 = sid__662('status');
    t_953 = from(t_951):groupBy(t_952);
    t_954 = SqlBuilder();
    t_954:appendSafe('COUNT(*) > ');
    t_954:appendInt32(5);
    t_955 = t_953:having(t_954.accumulated);
    t_956 = SqlBuilder();
    t_956:appendSafe('SUM(total) > ');
    t_956:appendInt32(1000);
    q__1664 = t_955:orHaving(t_956.accumulated);
    t_957 = temper.str_eq(q__1664:toSql():toString(), 'SELECT * FROM orders GROUP BY status HAVING COUNT(*) > 5 OR SUM(total) > 1000');
    fn__12878 = function()
      return 'orHaving';
    end;
    temper.test_assert(test_950, t_957, fn__12878);
    return nil;
  end);
end;
Test_.test_distinctBasic__2359 = function()
  temper.test('distinct basic', function(test_958)
    local t_959, t_960, q__1666, t_961, fn__12868;
    t_959 = sid__662('users');
    t_960 = sid__662('name');
    q__1666 = from(t_959):select(temper.listof(t_960)):distinct();
    t_961 = temper.str_eq(q__1666:toSql():toString(), 'SELECT DISTINCT name FROM users');
    fn__12868 = function()
      return 'distinct';
    end;
    temper.test_assert(test_958, t_961, fn__12868);
    return nil;
  end);
end;
Test_.test_distinctWithWhere__2360 = function()
  temper.test('distinct with where', function(test_962)
    local t_963, t_964, t_965, t_966, q__1668, t_967, fn__12853;
    t_963 = sid__662('users');
    t_964 = sid__662('email');
    t_965 = from(t_963):select(temper.listof(t_964));
    t_966 = SqlBuilder();
    t_966:appendSafe('active = ');
    t_966:appendBoolean(true);
    q__1668 = t_965:where(t_966.accumulated):distinct();
    t_967 = temper.str_eq(q__1668:toSql():toString(), 'SELECT DISTINCT email FROM users WHERE active = TRUE');
    fn__12853 = function()
      return 'distinct with where';
    end;
    temper.test_assert(test_962, t_967, fn__12853);
    return nil;
  end);
end;
Test_.test_countSqlBare__2362 = function()
  temper.test('countSql bare', function(test_968)
    local q__1670, t_969, fn__12846;
    q__1670 = from(sid__662('users'));
    t_969 = temper.str_eq(q__1670:countSql():toString(), 'SELECT COUNT(*) FROM users');
    fn__12846 = function()
      return 'countSql bare';
    end;
    temper.test_assert(test_968, t_969, fn__12846);
    return nil;
  end);
end;
Test_.test_countSqlWithWhere__2363 = function()
  temper.test('countSql with WHERE', function(test_970)
    local t_971, t_972, t_973, q__1672, t_974, fn__12834;
    t_971 = sid__662('users');
    t_972 = SqlBuilder();
    t_972:appendSafe('active = ');
    t_972:appendBoolean(true);
    t_973 = t_972.accumulated;
    q__1672 = from(t_971):where(t_973);
    t_974 = temper.str_eq(q__1672:countSql():toString(), 'SELECT COUNT(*) FROM users WHERE active = TRUE');
    fn__12834 = function()
      return 'countSql with where';
    end;
    temper.test_assert(test_970, t_974, fn__12834);
    return nil;
  end);
end;
Test_.test_countSqlWithJoin__2365 = function()
  temper.test('countSql with JOIN', function(test_975)
    local t_976, t_977, t_978, t_979, t_980, t_981, q__1674, t_982, fn__12817;
    t_976 = sid__662('users');
    t_977 = sid__662('orders');
    t_978 = SqlBuilder();
    t_978:appendSafe('users.id = orders.user_id');
    t_979 = t_978.accumulated;
    t_980 = from(t_976):innerJoin(t_977, t_979);
    t_981 = SqlBuilder();
    t_981:appendSafe('orders.total > ');
    t_981:appendInt32(100);
    q__1674 = t_980:where(t_981.accumulated);
    t_982 = temper.str_eq(q__1674:countSql():toString(), 'SELECT COUNT(*) FROM users INNER JOIN orders ON users.id = orders.user_id WHERE orders.total > 100');
    fn__12817 = function()
      return 'countSql with join';
    end;
    temper.test_assert(test_975, t_982, fn__12817);
    return nil;
  end);
end;
Test_.test_countSqlDropsOrderByLimitOffset__2368 = function()
  temper.test('countSql drops orderBy/limit/offset', function(test_983)
    local t_984, t_985, t_986, t_987, t_988, q__1676, local_989, local_990, local_991, s__1677, t_993, fn__12803;
    local_989, local_990, local_991 = temper.pcall(function()
      t_984 = sid__662('users');
      t_985 = SqlBuilder();
      t_985:appendSafe('active = ');
      t_985:appendBoolean(true);
      t_986 = t_985.accumulated;
      t_987 = from(t_984):where(t_986):orderBy(sid__662('name'), true):limit(10);
      t_988 = t_987:offset(20);
      q__1676 = t_988;
    end);
    if local_989 then
    else
      q__1676 = temper.bubble();
    end
    s__1677 = q__1676:countSql():toString();
    t_993 = temper.str_eq(s__1677, 'SELECT COUNT(*) FROM users WHERE active = TRUE');
    fn__12803 = function()
      return temper.concat('countSql drops extras: ', s__1677);
    end;
    temper.test_assert(test_983, t_993, fn__12803);
    return nil;
  end);
end;
Test_.test_fullAggregationQuery__2370 = function()
  temper.test('full aggregation query', function(test_994)
    local t_995, t_996, t_997, t_998, t_999, t_1000, t_1001, t_1002, t_1003, t_1004, t_1005, q__1679, expected__1680, t_1006, fn__12770;
    t_995 = sid__662('orders');
    t_996 = col(sid__662('orders'), sid__662('status'));
    t_997 = countAll();
    t_998 = sumCol(sid__662('total'));
    t_999 = from(t_995):selectExpr(temper.listof(t_996, t_997, t_998));
    t_1000 = sid__662('users');
    t_1001 = SqlBuilder();
    t_1001:appendSafe('orders.user_id = users.id');
    t_1002 = t_999:innerJoin(t_1000, t_1001.accumulated);
    t_1003 = SqlBuilder();
    t_1003:appendSafe('users.active = ');
    t_1003:appendBoolean(true);
    t_1004 = t_1002:where(t_1003.accumulated):groupBy(sid__662('status'));
    t_1005 = SqlBuilder();
    t_1005:appendSafe('COUNT(*) > ');
    t_1005:appendInt32(3);
    q__1679 = t_1004:having(t_1005.accumulated):orderBy(sid__662('status'), true);
    expected__1680 = 'SELECT orders.status, COUNT(*), SUM(total) FROM orders INNER JOIN users ON orders.user_id = users.id WHERE users.active = TRUE GROUP BY status HAVING COUNT(*) > 3 ORDER BY status ASC';
    t_1006 = temper.str_eq(q__1679:toSql():toString(), 'SELECT orders.status, COUNT(*), SUM(total) FROM orders INNER JOIN users ON orders.user_id = users.id WHERE users.active = TRUE GROUP BY status HAVING COUNT(*) > 3 ORDER BY status ASC');
    fn__12770 = function()
      return 'full aggregation';
    end;
    temper.test_assert(test_994, t_1006, fn__12770);
    return nil;
  end);
end;
Test_.test_unionSql__2374 = function()
  temper.test('unionSql', function(test_1007)
    local t_1008, t_1009, t_1010, a__1682, t_1011, t_1012, t_1013, b__1683, s__1684, t_1014, fn__12752;
    t_1008 = sid__662('users');
    t_1009 = SqlBuilder();
    t_1009:appendSafe('role = ');
    t_1009:appendString('admin');
    t_1010 = t_1009.accumulated;
    a__1682 = from(t_1008):where(t_1010);
    t_1011 = sid__662('users');
    t_1012 = SqlBuilder();
    t_1012:appendSafe('role = ');
    t_1012:appendString('moderator');
    t_1013 = t_1012.accumulated;
    b__1683 = from(t_1011):where(t_1013);
    s__1684 = unionSql(a__1682, b__1683):toString();
    t_1014 = temper.str_eq(s__1684, "(SELECT * FROM users WHERE role = 'admin') UNION (SELECT * FROM users WHERE role = 'moderator')");
    fn__12752 = function()
      return temper.concat('unionSql: ', s__1684);
    end;
    temper.test_assert(test_1007, t_1014, fn__12752);
    return nil;
  end);
end;
Test_.test_unionAllSql__2377 = function()
  temper.test('unionAllSql', function(test_1015)
    local t_1016, t_1017, a__1686, t_1018, t_1019, b__1687, s__1688, t_1020, fn__12740;
    t_1016 = sid__662('users');
    t_1017 = sid__662('name');
    a__1686 = from(t_1016):select(temper.listof(t_1017));
    t_1018 = sid__662('contacts');
    t_1019 = sid__662('name');
    b__1687 = from(t_1018):select(temper.listof(t_1019));
    s__1688 = unionAllSql(a__1686, b__1687):toString();
    t_1020 = temper.str_eq(s__1688, '(SELECT name FROM users) UNION ALL (SELECT name FROM contacts)');
    fn__12740 = function()
      return temper.concat('unionAllSql: ', s__1688);
    end;
    temper.test_assert(test_1015, t_1020, fn__12740);
    return nil;
  end);
end;
Test_.test_intersectSql__2378 = function()
  temper.test('intersectSql', function(test_1021)
    local t_1022, t_1023, a__1690, t_1024, t_1025, b__1691, s__1692, t_1026, fn__12728;
    t_1022 = sid__662('users');
    t_1023 = sid__662('email');
    a__1690 = from(t_1022):select(temper.listof(t_1023));
    t_1024 = sid__662('subscribers');
    t_1025 = sid__662('email');
    b__1691 = from(t_1024):select(temper.listof(t_1025));
    s__1692 = intersectSql(a__1690, b__1691):toString();
    t_1026 = temper.str_eq(s__1692, '(SELECT email FROM users) INTERSECT (SELECT email FROM subscribers)');
    fn__12728 = function()
      return temper.concat('intersectSql: ', s__1692);
    end;
    temper.test_assert(test_1021, t_1026, fn__12728);
    return nil;
  end);
end;
Test_.test_exceptSql__2379 = function()
  temper.test('exceptSql', function(test_1027)
    local t_1028, t_1029, a__1694, t_1030, t_1031, b__1695, s__1696, t_1032, fn__12716;
    t_1028 = sid__662('users');
    t_1029 = sid__662('id');
    a__1694 = from(t_1028):select(temper.listof(t_1029));
    t_1030 = sid__662('banned');
    t_1031 = sid__662('id');
    b__1695 = from(t_1030):select(temper.listof(t_1031));
    s__1696 = exceptSql(a__1694, b__1695):toString();
    t_1032 = temper.str_eq(s__1696, '(SELECT id FROM users) EXCEPT (SELECT id FROM banned)');
    fn__12716 = function()
      return temper.concat('exceptSql: ', s__1696);
    end;
    temper.test_assert(test_1027, t_1032, fn__12716);
    return nil;
  end);
end;
Test_.test_subqueryWithAlias__2380 = function()
  temper.test('subquery with alias', function(test_1033)
    local t_1034, t_1035, t_1036, t_1037, inner__1698, s__1699, t_1038, fn__12701;
    t_1034 = sid__662('orders');
    t_1035 = sid__662('user_id');
    t_1036 = from(t_1034):select(temper.listof(t_1035));
    t_1037 = SqlBuilder();
    t_1037:appendSafe('total > ');
    t_1037:appendInt32(100);
    inner__1698 = t_1036:where(t_1037.accumulated);
    s__1699 = subquery(inner__1698, sid__662('big_orders')):toString();
    t_1038 = temper.str_eq(s__1699, '(SELECT user_id FROM orders WHERE total > 100) AS big_orders');
    fn__12701 = function()
      return temper.concat('subquery: ', s__1699);
    end;
    temper.test_assert(test_1033, t_1038, fn__12701);
    return nil;
  end);
end;
Test_.test_existsSql__2382 = function()
  temper.test('existsSql', function(test_1039)
    local t_1040, t_1041, t_1042, inner__1701, s__1702, t_1043, fn__12690;
    t_1040 = sid__662('orders');
    t_1041 = SqlBuilder();
    t_1041:appendSafe('orders.user_id = users.id');
    t_1042 = t_1041.accumulated;
    inner__1701 = from(t_1040):where(t_1042);
    s__1702 = existsSql(inner__1701):toString();
    t_1043 = temper.str_eq(s__1702, 'EXISTS (SELECT * FROM orders WHERE orders.user_id = users.id)');
    fn__12690 = function()
      return temper.concat('existsSql: ', s__1702);
    end;
    temper.test_assert(test_1039, t_1043, fn__12690);
    return nil;
  end);
end;
Test_.test_whereInSubquery__2384 = function()
  temper.test('whereInSubquery', function(test_1044)
    local t_1045, t_1046, t_1047, t_1048, sub__1704, t_1049, t_1050, q__1705, s__1706, t_1051, fn__12673;
    t_1045 = sid__662('orders');
    t_1046 = sid__662('user_id');
    t_1047 = from(t_1045):select(temper.listof(t_1046));
    t_1048 = SqlBuilder();
    t_1048:appendSafe('total > ');
    t_1048:appendInt32(1000);
    sub__1704 = t_1047:where(t_1048.accumulated);
    t_1049 = sid__662('users');
    t_1050 = sid__662('id');
    q__1705 = from(t_1049):whereInSubquery(t_1050, sub__1704);
    s__1706 = q__1705:toSql():toString();
    t_1051 = temper.str_eq(s__1706, 'SELECT * FROM users WHERE id IN (SELECT user_id FROM orders WHERE total > 1000)');
    fn__12673 = function()
      return temper.concat('whereInSubquery: ', s__1706);
    end;
    temper.test_assert(test_1044, t_1051, fn__12673);
    return nil;
  end);
end;
Test_.test_setOperationWithWhereOnEachSide__2386 = function()
  temper.test('set operation with WHERE on each side', function(test_1052)
    local t_1053, t_1054, t_1055, t_1056, t_1057, a__1708, t_1058, t_1059, t_1060, b__1709, s__1710, t_1061, fn__12650;
    t_1053 = sid__662('users');
    t_1054 = SqlBuilder();
    t_1054:appendSafe('age > ');
    t_1054:appendInt32(18);
    t_1055 = t_1054.accumulated;
    t_1056 = from(t_1053):where(t_1055);
    t_1057 = SqlBuilder();
    t_1057:appendSafe('active = ');
    t_1057:appendBoolean(true);
    a__1708 = t_1056:where(t_1057.accumulated);
    t_1058 = sid__662('users');
    t_1059 = SqlBuilder();
    t_1059:appendSafe('role = ');
    t_1059:appendString('vip');
    t_1060 = t_1059.accumulated;
    b__1709 = from(t_1058):where(t_1060);
    s__1710 = unionSql(a__1708, b__1709):toString();
    t_1061 = temper.str_eq(s__1710, "(SELECT * FROM users WHERE age > 18 AND active = TRUE) UNION (SELECT * FROM users WHERE role = 'vip')");
    fn__12650 = function()
      return temper.concat('union with where: ', s__1710);
    end;
    temper.test_assert(test_1052, t_1061, fn__12650);
    return nil;
  end);
end;
Test_.test_whereInSubqueryChainedWithWhere__2390 = function()
  temper.test('whereInSubquery chained with where', function(test_1062)
    local t_1063, t_1064, sub__1712, t_1065, t_1066, t_1067, q__1713, s__1714, t_1068, fn__12633;
    t_1063 = sid__662('orders');
    t_1064 = sid__662('user_id');
    sub__1712 = from(t_1063):select(temper.listof(t_1064));
    t_1065 = sid__662('users');
    t_1066 = SqlBuilder();
    t_1066:appendSafe('active = ');
    t_1066:appendBoolean(true);
    t_1067 = t_1066.accumulated;
    q__1713 = from(t_1065):where(t_1067):whereInSubquery(sid__662('id'), sub__1712);
    s__1714 = q__1713:toSql():toString();
    t_1068 = temper.str_eq(s__1714, 'SELECT * FROM users WHERE active = TRUE AND id IN (SELECT user_id FROM orders)');
    fn__12633 = function()
      return temper.concat('whereInSubquery chained: ', s__1714);
    end;
    temper.test_assert(test_1062, t_1068, fn__12633);
    return nil;
  end);
end;
Test_.test_existsSqlUsedInWhere__2392 = function()
  temper.test('existsSql used in where', function(test_1069)
    local t_1070, t_1071, t_1072, sub__1716, t_1073, t_1074, q__1717, s__1718, t_1075, fn__12619;
    t_1070 = sid__662('orders');
    t_1071 = SqlBuilder();
    t_1071:appendSafe('orders.user_id = users.id');
    t_1072 = t_1071.accumulated;
    sub__1716 = from(t_1070):where(t_1072);
    t_1073 = sid__662('users');
    t_1074 = existsSql(sub__1716);
    q__1717 = from(t_1073):where(t_1074);
    s__1718 = q__1717:toSql():toString();
    t_1075 = temper.str_eq(s__1718, 'SELECT * FROM users WHERE EXISTS (SELECT * FROM orders WHERE orders.user_id = users.id)');
    fn__12619 = function()
      return temper.concat('exists in where: ', s__1718);
    end;
    temper.test_assert(test_1069, t_1075, fn__12619);
    return nil;
  end);
end;
Test_.test_updateQueryBasic__2394 = function()
  temper.test('UpdateQuery basic', function(test_1076)
    local t_1077, t_1078, t_1079, t_1080, t_1081, t_1082, q__1720, local_1083, local_1084, local_1085, t_1087, fn__12605;
    local_1083, local_1084, local_1085 = temper.pcall(function()
      t_1077 = sid__662('users');
      t_1078 = sid__662('name');
      t_1079 = SqlString('Alice');
      t_1080 = update(t_1077):set(t_1078, t_1079);
      t_1081 = SqlBuilder();
      t_1081:appendSafe('id = ');
      t_1081:appendInt32(1);
      t_1082 = t_1080:where(t_1081.accumulated):toSql();
      q__1720 = t_1082;
    end);
    if local_1083 then
    else
      q__1720 = temper.bubble();
    end
    t_1087 = temper.str_eq(q__1720:toString(), "UPDATE users SET name = 'Alice' WHERE id = 1");
    fn__12605 = function()
      return 'update basic';
    end;
    temper.test_assert(test_1076, t_1087, fn__12605);
    return nil;
  end);
end;
Test_.test_updateQueryMultipleSet__2396 = function()
  temper.test('UpdateQuery multiple SET', function(test_1088)
    local t_1089, t_1090, t_1091, t_1092, t_1093, t_1094, q__1722, local_1095, local_1096, local_1097, t_1099, fn__12588;
    local_1095, local_1096, local_1097 = temper.pcall(function()
      t_1089 = sid__662('users');
      t_1090 = sid__662('name');
      t_1091 = SqlString('Bob');
      t_1092 = update(t_1089):set(t_1090, t_1091):set(sid__662('age'), SqlInt32(30));
      t_1093 = SqlBuilder();
      t_1093:appendSafe('id = ');
      t_1093:appendInt32(2);
      t_1094 = t_1092:where(t_1093.accumulated):toSql();
      q__1722 = t_1094;
    end);
    if local_1095 then
    else
      q__1722 = temper.bubble();
    end
    t_1099 = temper.str_eq(q__1722:toString(), "UPDATE users SET name = 'Bob', age = 30 WHERE id = 2");
    fn__12588 = function()
      return 'update multi set';
    end;
    temper.test_assert(test_1088, t_1099, fn__12588);
    return nil;
  end);
end;
Test_.test_updateQueryMultipleWhere__2398 = function()
  temper.test('UpdateQuery multiple WHERE', function(test_1100)
    local t_1101, t_1102, t_1103, t_1104, t_1105, t_1106, t_1107, t_1108, q__1724, local_1109, local_1110, local_1111, t_1113, fn__12569;
    local_1109, local_1110, local_1111 = temper.pcall(function()
      t_1101 = sid__662('users');
      t_1102 = sid__662('active');
      t_1103 = SqlBoolean(false);
      t_1104 = update(t_1101):set(t_1102, t_1103);
      t_1105 = SqlBuilder();
      t_1105:appendSafe('age < ');
      t_1105:appendInt32(18);
      t_1106 = t_1104:where(t_1105.accumulated);
      t_1107 = SqlBuilder();
      t_1107:appendSafe('role = ');
      t_1107:appendString('guest');
      t_1108 = t_1106:where(t_1107.accumulated):toSql();
      q__1724 = t_1108;
    end);
    if local_1109 then
    else
      q__1724 = temper.bubble();
    end
    t_1113 = temper.str_eq(q__1724:toString(), "UPDATE users SET active = FALSE WHERE age < 18 AND role = 'guest'");
    fn__12569 = function()
      return 'update multi where';
    end;
    temper.test_assert(test_1100, t_1113, fn__12569);
    return nil;
  end);
end;
Test_.test_updateQueryOrWhere__2401 = function()
  temper.test('UpdateQuery orWhere', function(test_1114)
    local t_1115, t_1116, t_1117, t_1118, t_1119, t_1120, t_1121, t_1122, q__1726, local_1123, local_1124, local_1125, t_1127, fn__12550;
    local_1123, local_1124, local_1125 = temper.pcall(function()
      t_1115 = sid__662('users');
      t_1116 = sid__662('status');
      t_1117 = SqlString('banned');
      t_1118 = update(t_1115):set(t_1116, t_1117);
      t_1119 = SqlBuilder();
      t_1119:appendSafe('spam_count > ');
      t_1119:appendInt32(10);
      t_1120 = t_1118:where(t_1119.accumulated);
      t_1121 = SqlBuilder();
      t_1121:appendSafe('reported = ');
      t_1121:appendBoolean(true);
      t_1122 = t_1120:orWhere(t_1121.accumulated):toSql();
      q__1726 = t_1122;
    end);
    if local_1123 then
    else
      q__1726 = temper.bubble();
    end
    t_1127 = temper.str_eq(q__1726:toString(), "UPDATE users SET status = 'banned' WHERE spam_count > 10 OR reported = TRUE");
    fn__12550 = function()
      return 'update orWhere';
    end;
    temper.test_assert(test_1114, t_1127, fn__12550);
    return nil;
  end);
end;
Test_.test_updateQueryBubblesWithoutWhere__2404 = function()
  temper.test('UpdateQuery bubbles without WHERE', function(test_1128)
    local t_1129, t_1130, t_1131, didBubble__1728, local_1132, local_1133, local_1134, fn__12543;
    local_1132, local_1133, local_1134 = temper.pcall(function()
      t_1129 = sid__662('users');
      t_1130 = sid__662('x');
      t_1131 = SqlInt32(1);
      update(t_1129):set(t_1130, t_1131):toSql();
      didBubble__1728 = false;
    end);
    if local_1132 then
    else
      didBubble__1728 = true;
    end
    fn__12543 = function()
      return 'update without WHERE should bubble';
    end;
    temper.test_assert(test_1128, didBubble__1728, fn__12543);
    return nil;
  end);
end;
Test_.test_updateQueryBubblesWithoutSet__2405 = function()
  temper.test('UpdateQuery bubbles without SET', function(test_1136)
    local t_1137, t_1138, t_1139, didBubble__1730, local_1140, local_1141, local_1142, fn__12534;
    local_1140, local_1141, local_1142 = temper.pcall(function()
      t_1137 = sid__662('users');
      t_1138 = SqlBuilder();
      t_1138:appendSafe('id = ');
      t_1138:appendInt32(1);
      t_1139 = t_1138.accumulated;
      update(t_1137):where(t_1139):toSql();
      didBubble__1730 = false;
    end);
    if local_1140 then
    else
      didBubble__1730 = true;
    end
    fn__12534 = function()
      return 'update without SET should bubble';
    end;
    temper.test_assert(test_1136, didBubble__1730, fn__12534);
    return nil;
  end);
end;
Test_.test_updateQueryWithLimit__2407 = function()
  temper.test('UpdateQuery with limit', function(test_1144)
    local t_1145, t_1146, t_1147, t_1148, t_1149, t_1150, t_1151, q__1732, local_1152, local_1153, local_1154, t_1156, fn__12520;
    local_1152, local_1153, local_1154 = temper.pcall(function()
      t_1145 = sid__662('users');
      t_1146 = sid__662('active');
      t_1147 = SqlBoolean(false);
      t_1148 = update(t_1145):set(t_1146, t_1147);
      t_1149 = SqlBuilder();
      t_1149:appendSafe('last_login < ');
      t_1149:appendString('2024-01-01');
      t_1150 = t_1148:where(t_1149.accumulated):limit(100);
      t_1151 = t_1150:toSql();
      q__1732 = t_1151;
    end);
    if local_1152 then
    else
      q__1732 = temper.bubble();
    end
    t_1156 = temper.str_eq(q__1732:toString(), "UPDATE users SET active = FALSE WHERE last_login < '2024-01-01' LIMIT 100");
    fn__12520 = function()
      return 'update limit';
    end;
    temper.test_assert(test_1144, t_1156, fn__12520);
    return nil;
  end);
end;
Test_.test_updateQueryEscaping__2409 = function()
  temper.test('UpdateQuery escaping', function(test_1157)
    local t_1158, t_1159, t_1160, t_1161, t_1162, t_1163, q__1734, local_1164, local_1165, local_1166, t_1168, fn__12506;
    local_1164, local_1165, local_1166 = temper.pcall(function()
      t_1158 = sid__662('users');
      t_1159 = sid__662('bio');
      t_1160 = SqlString("It's a test");
      t_1161 = update(t_1158):set(t_1159, t_1160);
      t_1162 = SqlBuilder();
      t_1162:appendSafe('id = ');
      t_1162:appendInt32(1);
      t_1163 = t_1161:where(t_1162.accumulated):toSql();
      q__1734 = t_1163;
    end);
    if local_1164 then
    else
      q__1734 = temper.bubble();
    end
    t_1168 = temper.str_eq(q__1734:toString(), "UPDATE users SET bio = 'It''s a test' WHERE id = 1");
    fn__12506 = function()
      return 'update escaping';
    end;
    temper.test_assert(test_1157, t_1168, fn__12506);
    return nil;
  end);
end;
Test_.test_deleteQueryBasic__2411 = function()
  temper.test('DeleteQuery basic', function(test_1169)
    local t_1170, t_1171, t_1172, t_1173, q__1736, local_1174, local_1175, local_1176, t_1178, fn__12495;
    local_1174, local_1175, local_1176 = temper.pcall(function()
      t_1170 = sid__662('users');
      t_1171 = SqlBuilder();
      t_1171:appendSafe('id = ');
      t_1171:appendInt32(1);
      t_1172 = t_1171.accumulated;
      t_1173 = deleteFrom(t_1170):where(t_1172):toSql();
      q__1736 = t_1173;
    end);
    if local_1174 then
    else
      q__1736 = temper.bubble();
    end
    t_1178 = temper.str_eq(q__1736:toString(), 'DELETE FROM users WHERE id = 1');
    fn__12495 = function()
      return 'delete basic';
    end;
    temper.test_assert(test_1169, t_1178, fn__12495);
    return nil;
  end);
end;
Test_.test_deleteQueryMultipleWhere__2413 = function()
  temper.test('DeleteQuery multiple WHERE', function(test_1179)
    local t_1180, t_1181, t_1182, t_1183, t_1184, t_1185, q__1738, local_1186, local_1187, local_1188, t_1190, fn__12479;
    local_1186, local_1187, local_1188 = temper.pcall(function()
      t_1180 = sid__662('logs');
      t_1181 = SqlBuilder();
      t_1181:appendSafe('created_at < ');
      t_1181:appendString('2024-01-01');
      t_1182 = t_1181.accumulated;
      t_1183 = deleteFrom(t_1180):where(t_1182);
      t_1184 = SqlBuilder();
      t_1184:appendSafe('level = ');
      t_1184:appendString('debug');
      t_1185 = t_1183:where(t_1184.accumulated):toSql();
      q__1738 = t_1185;
    end);
    if local_1186 then
    else
      q__1738 = temper.bubble();
    end
    t_1190 = temper.str_eq(q__1738:toString(), "DELETE FROM logs WHERE created_at < '2024-01-01' AND level = 'debug'");
    fn__12479 = function()
      return 'delete multi where';
    end;
    temper.test_assert(test_1179, t_1190, fn__12479);
    return nil;
  end);
end;
Test_.test_deleteQueryBubblesWithoutWhere__2416 = function()
  temper.test('DeleteQuery bubbles without WHERE', function(test_1191)
    local didBubble__1740, local_1192, local_1193, local_1194, fn__12475;
    local_1192, local_1193, local_1194 = temper.pcall(function()
      deleteFrom(sid__662('users')):toSql();
      didBubble__1740 = false;
    end);
    if local_1192 then
    else
      didBubble__1740 = true;
    end
    fn__12475 = function()
      return 'delete without WHERE should bubble';
    end;
    temper.test_assert(test_1191, didBubble__1740, fn__12475);
    return nil;
  end);
end;
Test_.test_deleteQueryOrWhere__2417 = function()
  temper.test('DeleteQuery orWhere', function(test_1196)
    local t_1197, t_1198, t_1199, t_1200, t_1201, t_1202, q__1742, local_1203, local_1204, local_1205, t_1207, fn__12459;
    local_1203, local_1204, local_1205 = temper.pcall(function()
      t_1197 = sid__662('sessions');
      t_1198 = SqlBuilder();
      t_1198:appendSafe('expired = ');
      t_1198:appendBoolean(true);
      t_1199 = t_1198.accumulated;
      t_1200 = deleteFrom(t_1197):where(t_1199);
      t_1201 = SqlBuilder();
      t_1201:appendSafe('created_at < ');
      t_1201:appendString('2023-01-01');
      t_1202 = t_1200:orWhere(t_1201.accumulated):toSql();
      q__1742 = t_1202;
    end);
    if local_1203 then
    else
      q__1742 = temper.bubble();
    end
    t_1207 = temper.str_eq(q__1742:toString(), "DELETE FROM sessions WHERE expired = TRUE OR created_at < '2023-01-01'");
    fn__12459 = function()
      return 'delete orWhere';
    end;
    temper.test_assert(test_1196, t_1207, fn__12459);
    return nil;
  end);
end;
Test_.test_deleteQueryWithLimit__2420 = function()
  temper.test('DeleteQuery with limit', function(test_1208)
    local t_1209, t_1210, t_1211, t_1212, t_1213, q__1744, local_1214, local_1215, local_1216, t_1218, fn__12448;
    local_1214, local_1215, local_1216 = temper.pcall(function()
      t_1209 = sid__662('logs');
      t_1210 = SqlBuilder();
      t_1210:appendSafe('level = ');
      t_1210:appendString('debug');
      t_1211 = t_1210.accumulated;
      t_1212 = deleteFrom(t_1209):where(t_1211):limit(1000);
      t_1213 = t_1212:toSql();
      q__1744 = t_1213;
    end);
    if local_1214 then
    else
      q__1744 = temper.bubble();
    end
    t_1218 = temper.str_eq(q__1744:toString(), "DELETE FROM logs WHERE level = 'debug' LIMIT 1000");
    fn__12448 = function()
      return 'delete limit';
    end;
    temper.test_assert(test_1208, t_1218, fn__12448);
    return nil;
  end);
end;
Test_.test_orderByNullsNullsFirst__2422 = function()
  temper.test('orderByNulls NULLS FIRST', function(test_1219)
    local t_1220, t_1221, t_1222, q__1746, t_1223, fn__12438;
    t_1220 = sid__662('users');
    t_1221 = sid__662('email');
    t_1222 = NullsFirst();
    q__1746 = from(t_1220):orderByNulls(t_1221, true, t_1222);
    t_1223 = temper.str_eq(q__1746:toSql():toString(), 'SELECT * FROM users ORDER BY email ASC NULLS FIRST');
    fn__12438 = function()
      return 'nulls first';
    end;
    temper.test_assert(test_1219, t_1223, fn__12438);
    return nil;
  end);
end;
Test_.test_orderByNullsNullsLast__2423 = function()
  temper.test('orderByNulls NULLS LAST', function(test_1224)
    local t_1225, t_1226, t_1227, q__1748, t_1228, fn__12428;
    t_1225 = sid__662('users');
    t_1226 = sid__662('score');
    t_1227 = NullsLast();
    q__1748 = from(t_1225):orderByNulls(t_1226, false, t_1227);
    t_1228 = temper.str_eq(q__1748:toSql():toString(), 'SELECT * FROM users ORDER BY score DESC NULLS LAST');
    fn__12428 = function()
      return 'nulls last';
    end;
    temper.test_assert(test_1224, t_1228, fn__12428);
    return nil;
  end);
end;
Test_.test_mixedOrderByAndOrderByNulls__2424 = function()
  temper.test('mixed orderBy and orderByNulls', function(test_1229)
    local t_1230, t_1231, q__1750, t_1232, fn__12416;
    t_1230 = sid__662('users');
    t_1231 = sid__662('name');
    q__1750 = from(t_1230):orderBy(t_1231, true):orderByNulls(sid__662('email'), true, NullsFirst());
    t_1232 = temper.str_eq(q__1750:toSql():toString(), 'SELECT * FROM users ORDER BY name ASC, email ASC NULLS FIRST');
    fn__12416 = function()
      return 'mixed order';
    end;
    temper.test_assert(test_1229, t_1232, fn__12416);
    return nil;
  end);
end;
Test_.test_crossJoin__2425 = function()
  temper.test('crossJoin', function(test_1233)
    local t_1234, t_1235, q__1752, t_1236, fn__12407;
    t_1234 = sid__662('users');
    t_1235 = sid__662('colors');
    q__1752 = from(t_1234):crossJoin(t_1235);
    t_1236 = temper.str_eq(q__1752:toSql():toString(), 'SELECT * FROM users CROSS JOIN colors');
    fn__12407 = function()
      return 'cross join';
    end;
    temper.test_assert(test_1233, t_1236, fn__12407);
    return nil;
  end);
end;
Test_.test_crossJoinCombinedWithOtherJoins__2426 = function()
  temper.test('crossJoin combined with other joins', function(test_1237)
    local t_1238, t_1239, t_1240, t_1241, q__1754, t_1242, fn__12393;
    t_1238 = sid__662('users');
    t_1239 = sid__662('orders');
    t_1240 = SqlBuilder();
    t_1240:appendSafe('users.id = orders.user_id');
    t_1241 = t_1240.accumulated;
    q__1754 = from(t_1238):innerJoin(t_1239, t_1241):crossJoin(sid__662('colors'));
    t_1242 = temper.str_eq(q__1754:toSql():toString(), 'SELECT * FROM users INNER JOIN orders ON users.id = orders.user_id CROSS JOIN colors');
    fn__12393 = function()
      return 'cross + inner join';
    end;
    temper.test_assert(test_1237, t_1242, fn__12393);
    return nil;
  end);
end;
Test_.test_lockForUpdate__2428 = function()
  temper.test('lock FOR UPDATE', function(test_1243)
    local t_1244, t_1245, t_1246, q__1756, t_1247, fn__12379;
    t_1244 = sid__662('users');
    t_1245 = SqlBuilder();
    t_1245:appendSafe('id = ');
    t_1245:appendInt32(1);
    t_1246 = t_1245.accumulated;
    q__1756 = from(t_1244):where(t_1246):lock(ForUpdate());
    t_1247 = temper.str_eq(q__1756:toSql():toString(), 'SELECT * FROM users WHERE id = 1 FOR UPDATE');
    fn__12379 = function()
      return 'for update';
    end;
    temper.test_assert(test_1243, t_1247, fn__12379);
    return nil;
  end);
end;
Test_.test_lockForShare__2430 = function()
  temper.test('lock FOR SHARE', function(test_1248)
    local t_1249, t_1250, q__1758, t_1251, fn__12368;
    t_1249 = sid__662('users');
    t_1250 = sid__662('name');
    q__1758 = from(t_1249):select(temper.listof(t_1250)):lock(ForShare());
    t_1251 = temper.str_eq(q__1758:toSql():toString(), 'SELECT name FROM users FOR SHARE');
    fn__12368 = function()
      return 'for share';
    end;
    temper.test_assert(test_1248, t_1251, fn__12368);
    return nil;
  end);
end;
Test_.test_lockWithFullQuery__2431 = function()
  temper.test('lock with full query', function(test_1252)
    local t_1253, t_1254, t_1255, t_1256, t_1257, q__1760, local_1258, local_1259, local_1260, t_1262, fn__12354;
    local_1258, local_1259, local_1260 = temper.pcall(function()
      t_1253 = sid__662('accounts');
      t_1254 = SqlBuilder();
      t_1254:appendSafe('id = ');
      t_1254:appendInt32(42);
      t_1255 = t_1254.accumulated;
      t_1257 = from(t_1253):where(t_1255):limit(1);
      t_1256 = t_1257:lock(ForUpdate());
      q__1760 = t_1256;
    end);
    if local_1258 then
    else
      q__1760 = temper.bubble();
    end
    t_1262 = temper.str_eq(q__1760:toSql():toString(), 'SELECT * FROM accounts WHERE id = 42 LIMIT 1 FOR UPDATE');
    fn__12354 = function()
      return 'lock full query';
    end;
    temper.test_assert(test_1252, t_1262, fn__12354);
    return nil;
  end);
end;
Test_.test_safeIdentifierAcceptsValidNames__2433 = function()
  temper.test('safeIdentifier accepts valid names', function(test_1263)
    local t_1264, id__1808, local_1265, local_1266, local_1267, t_1269, fn__12349;
    local_1265, local_1266, local_1267 = temper.pcall(function()
      t_1264 = safeIdentifier('user_name');
      id__1808 = t_1264;
    end);
    if local_1265 then
    else
      id__1808 = temper.bubble();
    end
    t_1269 = temper.str_eq(id__1808.sqlValue, 'user_name');
    fn__12349 = function()
      return 'value should round-trip';
    end;
    temper.test_assert(test_1263, t_1269, fn__12349);
    return nil;
  end);
end;
Test_.test_safeIdentifierRejectsEmptyString__2434 = function()
  temper.test('safeIdentifier rejects empty string', function(test_1270)
    local didBubble__1810, local_1271, local_1272, local_1273, fn__12346;
    local_1271, local_1272, local_1273 = temper.pcall(function()
      safeIdentifier('');
      didBubble__1810 = false;
    end);
    if local_1271 then
    else
      didBubble__1810 = true;
    end
    fn__12346 = function()
      return 'empty string should bubble';
    end;
    temper.test_assert(test_1270, didBubble__1810, fn__12346);
    return nil;
  end);
end;
Test_.test_safeIdentifierRejectsLeadingDigit__2435 = function()
  temper.test('safeIdentifier rejects leading digit', function(test_1275)
    local didBubble__1812, local_1276, local_1277, local_1278, fn__12343;
    local_1276, local_1277, local_1278 = temper.pcall(function()
      safeIdentifier('1col');
      didBubble__1812 = false;
    end);
    if local_1276 then
    else
      didBubble__1812 = true;
    end
    fn__12343 = function()
      return 'leading digit should bubble';
    end;
    temper.test_assert(test_1275, didBubble__1812, fn__12343);
    return nil;
  end);
end;
Test_.test_safeIdentifierRejectsSqlMetacharacters__2436 = function()
  temper.test('safeIdentifier rejects SQL metacharacters', function(test_1280)
    local cases__1814, fn__12340;
    cases__1814 = temper.listof('name); DROP TABLE', "col'", 'a b', 'a-b', 'a.b', 'a;b');
    fn__12340 = function(c__1815)
      local didBubble__1816, local_1281, local_1282, local_1283, fn__12337;
      local_1281, local_1282, local_1283 = temper.pcall(function()
        safeIdentifier(c__1815);
        didBubble__1816 = false;
      end);
      if local_1281 then
      else
        didBubble__1816 = true;
      end
      fn__12337 = function()
        return temper.concat('should reject: ', c__1815);
      end;
      temper.test_assert(test_1280, didBubble__1816, fn__12337);
      return nil;
    end;
    temper.list_foreach(cases__1814, fn__12340);
    return nil;
  end);
end;
Test_.test_tableDefFieldLookupFound__2437 = function()
  temper.test('TableDef field lookup - found', function(test_1285)
    local t_1286, t_1287, t_1288, t_1289, t_1290, t_1291, t_1292, local_1293, local_1294, local_1295, local_1297, local_1298, local_1299, t_1301, t_1302, local_1303, local_1304, local_1305, t_1307, t_1308, td__1818, f__1819, local_1309, local_1310, local_1311, t_1313, fn__12326;
    local_1293, local_1294, local_1295 = temper.pcall(function()
      t_1286 = safeIdentifier('users');
      t_1287 = t_1286;
    end);
    if local_1293 then
    else
      t_1287 = temper.bubble();
    end
    local_1297, local_1298, local_1299 = temper.pcall(function()
      t_1288 = safeIdentifier('name');
      t_1289 = t_1288;
    end);
    if local_1297 then
    else
      t_1289 = temper.bubble();
    end
    t_1301 = StringField();
    t_1302 = FieldDef(t_1289, t_1301, false, temper.null, false);
    local_1303, local_1304, local_1305 = temper.pcall(function()
      t_1290 = safeIdentifier('age');
      t_1291 = t_1290;
    end);
    if local_1303 then
    else
      t_1291 = temper.bubble();
    end
    t_1307 = IntField();
    t_1308 = FieldDef(t_1291, t_1307, false, temper.null, false);
    td__1818 = TableDef(t_1287, temper.listof(t_1302, t_1308), temper.null);
    local_1309, local_1310, local_1311 = temper.pcall(function()
      t_1292 = td__1818:field('age');
      f__1819 = t_1292;
    end);
    if local_1309 then
    else
      f__1819 = temper.bubble();
    end
    t_1313 = temper.str_eq(f__1819.name.sqlValue, 'age');
    fn__12326 = function()
      return 'should find age field';
    end;
    temper.test_assert(test_1285, t_1313, fn__12326);
    return nil;
  end);
end;
Test_.test_tableDefFieldLookupNotFoundBubbles__2438 = function()
  temper.test('TableDef field lookup - not found bubbles', function(test_1314)
    local t_1315, t_1316, t_1317, t_1318, local_1319, local_1320, local_1321, local_1323, local_1324, local_1325, t_1327, t_1328, td__1821, didBubble__1822, local_1329, local_1330, local_1331, fn__12320;
    local_1319, local_1320, local_1321 = temper.pcall(function()
      t_1315 = safeIdentifier('users');
      t_1316 = t_1315;
    end);
    if local_1319 then
    else
      t_1316 = temper.bubble();
    end
    local_1323, local_1324, local_1325 = temper.pcall(function()
      t_1317 = safeIdentifier('name');
      t_1318 = t_1317;
    end);
    if local_1323 then
    else
      t_1318 = temper.bubble();
    end
    t_1327 = StringField();
    t_1328 = FieldDef(t_1318, t_1327, false, temper.null, false);
    td__1821 = TableDef(t_1316, temper.listof(t_1328), temper.null);
    local_1329, local_1330, local_1331 = temper.pcall(function()
      td__1821:field('nonexistent');
      didBubble__1822 = false;
    end);
    if local_1329 then
    else
      didBubble__1822 = true;
    end
    fn__12320 = function()
      return 'unknown field should bubble';
    end;
    temper.test_assert(test_1314, didBubble__1822, fn__12320);
    return nil;
  end);
end;
Test_.test_fieldDefNullableFlag__2439 = function()
  temper.test('FieldDef nullable flag', function(test_1333)
    local t_1334, t_1335, t_1336, t_1337, local_1338, local_1339, local_1340, t_1342, required__1824, local_1343, local_1344, local_1345, t_1347, optional__1825, t_1348, fn__12308, t_1349, fn__12307;
    local_1338, local_1339, local_1340 = temper.pcall(function()
      t_1334 = safeIdentifier('email');
      t_1335 = t_1334;
    end);
    if local_1338 then
    else
      t_1335 = temper.bubble();
    end
    t_1342 = StringField();
    required__1824 = FieldDef(t_1335, t_1342, false, temper.null, false);
    local_1343, local_1344, local_1345 = temper.pcall(function()
      t_1336 = safeIdentifier('bio');
      t_1337 = t_1336;
    end);
    if local_1343 then
    else
      t_1337 = temper.bubble();
    end
    t_1347 = StringField();
    optional__1825 = FieldDef(t_1337, t_1347, true, temper.null, false);
    t_1348 = not required__1824.nullable;
    fn__12308 = function()
      return 'required field should not be nullable';
    end;
    temper.test_assert(test_1333, t_1348, fn__12308);
    t_1349 = optional__1825.nullable;
    fn__12307 = function()
      return 'optional field should be nullable';
    end;
    temper.test_assert(test_1333, t_1349, fn__12307);
    return nil;
  end);
end;
Test_.test_pkNameDefaultsToIdWhenPrimaryKeyIsNull__2440 = function()
  temper.test('pkName defaults to id when primaryKey is null', function(test_1350)
    local t_1351, t_1352, t_1353, t_1354, local_1355, local_1356, local_1357, local_1359, local_1360, local_1361, t_1363, t_1364, td__1827, t_1365, fn__12299;
    local_1355, local_1356, local_1357 = temper.pcall(function()
      t_1351 = safeIdentifier('users');
      t_1352 = t_1351;
    end);
    if local_1355 then
    else
      t_1352 = temper.bubble();
    end
    local_1359, local_1360, local_1361 = temper.pcall(function()
      t_1353 = safeIdentifier('name');
      t_1354 = t_1353;
    end);
    if local_1359 then
    else
      t_1354 = temper.bubble();
    end
    t_1363 = StringField();
    t_1364 = FieldDef(t_1354, t_1363, false, temper.null, false);
    td__1827 = TableDef(t_1352, temper.listof(t_1364), temper.null);
    t_1365 = temper.str_eq(td__1827:pkName(), 'id');
    fn__12299 = function()
      return 'default pk should be id';
    end;
    temper.test_assert(test_1350, t_1365, fn__12299);
    return nil;
  end);
end;
Test_.test_pkNameReturnsCustomPrimaryKey__2441 = function()
  temper.test('pkName returns custom primary key', function(test_1366)
    local t_1367, t_1368, t_1369, t_1370, t_1371, t_1372, local_1373, local_1374, local_1375, local_1377, local_1378, local_1379, t_1381, t_1382, local_1383, local_1384, local_1385, td__1829, t_1387, fn__12291;
    local_1373, local_1374, local_1375 = temper.pcall(function()
      t_1367 = safeIdentifier('users');
      t_1368 = t_1367;
    end);
    if local_1373 then
    else
      t_1368 = temper.bubble();
    end
    local_1377, local_1378, local_1379 = temper.pcall(function()
      t_1369 = safeIdentifier('user_id');
      t_1370 = t_1369;
    end);
    if local_1377 then
    else
      t_1370 = temper.bubble();
    end
    t_1381 = IntField();
    t_1382 = temper.listof(FieldDef(t_1370, t_1381, false, temper.null, false));
    local_1383, local_1384, local_1385 = temper.pcall(function()
      t_1371 = safeIdentifier('user_id');
      t_1372 = t_1371;
    end);
    if local_1383 then
    else
      t_1372 = temper.bubble();
    end
    td__1829 = TableDef(t_1368, t_1382, t_1372);
    t_1387 = temper.str_eq(td__1829:pkName(), 'user_id');
    fn__12291 = function()
      return 'custom pk should be user_id';
    end;
    temper.test_assert(test_1366, t_1387, fn__12291);
    return nil;
  end);
end;
Test_.test_timestampsReturnsTwoDateFieldDefs__2442 = function()
  temper.test('timestamps returns two DateField defs', function(test_1388)
    local t_1389, ts__1831, local_1390, local_1391, local_1392, t_1394, fn__12256, t_1395, fn__12255, t_1396, fn__12254, t_1397, fn__12253, t_1398, fn__12252, t_1399, fn__12251, t_1400, fn__12250;
    local_1390, local_1391, local_1392 = temper.pcall(function()
      t_1389 = timestamps();
      ts__1831 = t_1389;
    end);
    if local_1390 then
    else
      ts__1831 = temper.bubble();
    end
    t_1394 = (temper.list_length(ts__1831) == 2);
    fn__12256 = function()
      return 'should return 2 fields';
    end;
    temper.test_assert(test_1388, t_1394, fn__12256);
    t_1395 = temper.str_eq((temper.list_get(ts__1831, 0)).name.sqlValue, 'inserted_at');
    fn__12255 = function()
      return 'first should be inserted_at';
    end;
    temper.test_assert(test_1388, t_1395, fn__12255);
    t_1396 = temper.str_eq((temper.list_get(ts__1831, 1)).name.sqlValue, 'updated_at');
    fn__12254 = function()
      return 'second should be updated_at';
    end;
    temper.test_assert(test_1388, t_1396, fn__12254);
    t_1397 = (temper.list_get(ts__1831, 0)).nullable;
    fn__12253 = function()
      return 'inserted_at should be nullable';
    end;
    temper.test_assert(test_1388, t_1397, fn__12253);
    t_1398 = (temper.list_get(ts__1831, 1)).nullable;
    fn__12252 = function()
      return 'updated_at should be nullable';
    end;
    temper.test_assert(test_1388, t_1398, fn__12252);
    t_1399 = not temper.is_null((temper.list_get(ts__1831, 0)).defaultValue);
    fn__12251 = function()
      return 'inserted_at should have default';
    end;
    temper.test_assert(test_1388, t_1399, fn__12251);
    t_1400 = not temper.is_null((temper.list_get(ts__1831, 1)).defaultValue);
    fn__12250 = function()
      return 'updated_at should have default';
    end;
    temper.test_assert(test_1388, t_1400, fn__12250);
    return nil;
  end);
end;
Test_.test_fieldDefDefaultValueField__2443 = function()
  temper.test('FieldDef defaultValue field', function(test_1401)
    local t_1402, t_1403, t_1404, t_1405, local_1406, local_1407, local_1408, t_1410, t_1411, withDefault__1833, local_1412, local_1413, local_1414, t_1416, withoutDefault__1834, t_1417, fn__12236, t_1418, fn__12235;
    local_1406, local_1407, local_1408 = temper.pcall(function()
      t_1402 = safeIdentifier('status');
      t_1403 = t_1402;
    end);
    if local_1406 then
    else
      t_1403 = temper.bubble();
    end
    t_1410 = StringField();
    t_1411 = SqlDefault();
    withDefault__1833 = FieldDef(t_1403, t_1410, false, t_1411, false);
    local_1412, local_1413, local_1414 = temper.pcall(function()
      t_1404 = safeIdentifier('name');
      t_1405 = t_1404;
    end);
    if local_1412 then
    else
      t_1405 = temper.bubble();
    end
    t_1416 = StringField();
    withoutDefault__1834 = FieldDef(t_1405, t_1416, false, temper.null, false);
    t_1417 = not temper.is_null(withDefault__1833.defaultValue);
    fn__12236 = function()
      return 'should have default';
    end;
    temper.test_assert(test_1401, t_1417, fn__12236);
    t_1418 = temper.is_null(withoutDefault__1834.defaultValue);
    fn__12235 = function()
      return 'should not have default';
    end;
    temper.test_assert(test_1401, t_1418, fn__12235);
    return nil;
  end);
end;
Test_.test_fieldDefVirtualFlag__2444 = function()
  temper.test('FieldDef virtual flag', function(test_1419)
    local t_1420, t_1421, t_1422, t_1423, local_1424, local_1425, local_1426, t_1428, normal__1836, local_1429, local_1430, local_1431, t_1433, virt__1837, t_1434, fn__12223, t_1435, fn__12222;
    local_1424, local_1425, local_1426 = temper.pcall(function()
      t_1420 = safeIdentifier('name');
      t_1421 = t_1420;
    end);
    if local_1424 then
    else
      t_1421 = temper.bubble();
    end
    t_1428 = StringField();
    normal__1836 = FieldDef(t_1421, t_1428, false, temper.null, false);
    local_1429, local_1430, local_1431 = temper.pcall(function()
      t_1422 = safeIdentifier('full_name');
      t_1423 = t_1422;
    end);
    if local_1429 then
    else
      t_1423 = temper.bubble();
    end
    t_1433 = StringField();
    virt__1837 = FieldDef(t_1423, t_1433, true, temper.null, true);
    t_1434 = not normal__1836.virtual;
    fn__12223 = function()
      return 'normal field should not be virtual';
    end;
    temper.test_assert(test_1419, t_1434, fn__12223);
    t_1435 = virt__1837.virtual;
    fn__12222 = function()
      return 'virtual field should be virtual';
    end;
    temper.test_assert(test_1419, t_1435, fn__12222);
    return nil;
  end);
end;
Test_.test_stringEscaping__2445 = function()
  temper.test('string escaping', function(test_1436)
    local build__1967, buildWrong__1968, actual_1438, t_1439, fn__12211, bobbyTables__1973, actual_1440, t_1441, fn__12210, fn__12209;
    build__1967 = function(name__1969)
      local t_1437;
      t_1437 = SqlBuilder();
      t_1437:appendSafe('select * from hi where name = ');
      t_1437:appendString(name__1969);
      return t_1437.accumulated:toString();
    end;
    buildWrong__1968 = function(name__1971)
      return temper.concat("select * from hi where name = '", name__1971, "'");
    end;
    actual_1438 = build__1967('world');
    t_1439 = temper.str_eq(actual_1438, "select * from hi where name = 'world'");
    fn__12211 = function()
      return temper.concat('expected build("world") == (', "select * from hi where name = 'world'", ') not (', actual_1438, ')');
    end;
    temper.test_assert(test_1436, t_1439, fn__12211);
    bobbyTables__1973 = "Robert'); drop table hi;--";
    actual_1440 = build__1967("Robert'); drop table hi;--");
    t_1441 = temper.str_eq(actual_1440, "select * from hi where name = 'Robert''); drop table hi;--'");
    fn__12210 = function()
      return temper.concat('expected build(bobbyTables) == (', "select * from hi where name = 'Robert''); drop table hi;--'", ') not (', actual_1440, ')');
    end;
    temper.test_assert(test_1436, t_1441, fn__12210);
    fn__12209 = function()
      return "expected buildWrong(bobbyTables) == (select * from hi where name = 'Robert'); drop table hi;--') not (select * from hi where name = 'Robert'); drop table hi;--')";
    end;
    temper.test_assert(test_1436, true, fn__12209);
    return nil;
  end);
end;
Test_.test_stringEdgeCases__2453 = function()
  temper.test('string edge cases', function(test_1442)
    local t_1443, actual_1444, t_1445, fn__12171, t_1446, actual_1447, t_1448, fn__12170, t_1449, actual_1450, t_1451, fn__12169, t_1452, actual_1453, t_1454, fn__12168;
    t_1443 = SqlBuilder();
    t_1443:appendSafe('v = ');
    t_1443:appendString('');
    actual_1444 = t_1443.accumulated:toString();
    t_1445 = temper.str_eq(actual_1444, "v = ''");
    fn__12171 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, "").toString() == (', "v = ''", ') not (', actual_1444, ')');
    end;
    temper.test_assert(test_1442, t_1445, fn__12171);
    t_1446 = SqlBuilder();
    t_1446:appendSafe('v = ');
    t_1446:appendString("a''b");
    actual_1447 = t_1446.accumulated:toString();
    t_1448 = temper.str_eq(actual_1447, "v = 'a''''b'");
    fn__12170 = function()
      return temper.concat("expected stringExpr(`-work//src/`.sql, true, \"v = \", \\interpolate, \"a''b\").toString() == (", "v = 'a''''b'", ') not (', actual_1447, ')');
    end;
    temper.test_assert(test_1442, t_1448, fn__12170);
    t_1449 = SqlBuilder();
    t_1449:appendSafe('v = ');
    t_1449:appendString('Hello \xe4\xb8\x96\xe7\x95\x8c');
    actual_1450 = t_1449.accumulated:toString();
    t_1451 = temper.str_eq(actual_1450, "v = 'Hello \xe4\xb8\x96\xe7\x95\x8c'");
    fn__12169 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, "Hello \xe4\xb8\x96\xe7\x95\x8c").toString() == (', "v = 'Hello \xe4\xb8\x96\xe7\x95\x8c'", ') not (', actual_1450, ')');
    end;
    temper.test_assert(test_1442, t_1451, fn__12169);
    t_1452 = SqlBuilder();
    t_1452:appendSafe('v = ');
    t_1452:appendString('Line1\nLine2');
    actual_1453 = t_1452.accumulated:toString();
    t_1454 = temper.str_eq(actual_1453, "v = 'Line1\nLine2'");
    fn__12168 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, "Line1\\nLine2").toString() == (', "v = 'Line1\nLine2'", ') not (', actual_1453, ')');
    end;
    temper.test_assert(test_1442, t_1454, fn__12168);
    return nil;
  end);
end;
Test_.test_numbersAndBooleans__2466 = function()
  temper.test('numbers and booleans', function(test_1455)
    local t_1456, t_1457, actual_1458, t_1459, fn__12142, date__1976, local_1460, local_1461, local_1462, t_1464, actual_1465, t_1466, fn__12141;
    t_1457 = SqlBuilder();
    t_1457:appendSafe('select ');
    t_1457:appendInt32(42);
    t_1457:appendSafe(', ');
    t_1457:appendInt64(temper.int64_constructor(43));
    t_1457:appendSafe(', ');
    t_1457:appendFloat64(19.99);
    t_1457:appendSafe(', ');
    t_1457:appendBoolean(true);
    t_1457:appendSafe(', ');
    t_1457:appendBoolean(false);
    actual_1458 = t_1457.accumulated:toString();
    t_1459 = temper.str_eq(actual_1458, 'select 42, 43, 19.99, TRUE, FALSE');
    fn__12142 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "select ", \\interpolate, 42, ", ", \\interpolate, 43, ", ", \\interpolate, 19.99, ", ", \\interpolate, true, ", ", \\interpolate, false).toString() == (', 'select 42, 43, 19.99, TRUE, FALSE', ') not (', actual_1458, ')');
    end;
    temper.test_assert(test_1455, t_1459, fn__12142);
    local_1460, local_1461, local_1462 = temper.pcall(function()
      t_1456 = temper.date_constructor(2024, 12, 25);
      date__1976 = t_1456;
    end);
    if local_1460 then
    else
      date__1976 = temper.bubble();
    end
    t_1464 = SqlBuilder();
    t_1464:appendSafe('insert into t values (');
    t_1464:appendDate(date__1976);
    t_1464:appendSafe(')');
    actual_1465 = t_1464.accumulated:toString();
    t_1466 = temper.str_eq(actual_1465, "insert into t values ('2024-12-25')");
    fn__12141 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "insert into t values (", \\interpolate, date, ")").toString() == (', "insert into t values ('2024-12-25')", ') not (', actual_1465, ')');
    end;
    temper.test_assert(test_1455, t_1466, fn__12141);
    return nil;
  end);
end;
Test_.test_lists__2473 = function()
  temper.test('lists', function(test_1467)
    local t_1468, t_1469, t_1470, t_1471, t_1472, actual_1473, t_1474, fn__12086, t_1475, actual_1476, t_1477, fn__12085, t_1478, actual_1479, t_1480, fn__12084, t_1481, actual_1482, t_1483, fn__12083, t_1484, actual_1485, t_1486, fn__12082, local_1487, local_1488, local_1489, local_1491, local_1492, local_1493, dates__1978, t_1495, actual_1496, t_1497, fn__12081;
    t_1472 = SqlBuilder();
    t_1472:appendSafe('v IN (');
    t_1472:appendStringList(temper.listof('a', 'b', "c'd"));
    t_1472:appendSafe(')');
    actual_1473 = t_1472.accumulated:toString();
    t_1474 = temper.str_eq(actual_1473, "v IN ('a', 'b', 'c''d')");
    fn__12086 = function()
      return temper.concat("expected stringExpr(`-work//src/`.sql, true, \"v IN (\", \\interpolate, list(\"a\", \"b\", \"c'd\"), \")\").toString() == (", "v IN ('a', 'b', 'c''d')", ') not (', actual_1473, ')');
    end;
    temper.test_assert(test_1467, t_1474, fn__12086);
    t_1475 = SqlBuilder();
    t_1475:appendSafe('v IN (');
    t_1475:appendInt32List(temper.listof(1, 2, 3));
    t_1475:appendSafe(')');
    actual_1476 = t_1475.accumulated:toString();
    t_1477 = temper.str_eq(actual_1476, 'v IN (1, 2, 3)');
    fn__12085 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v IN (", \\interpolate, list(1, 2, 3), ")").toString() == (', 'v IN (1, 2, 3)', ') not (', actual_1476, ')');
    end;
    temper.test_assert(test_1467, t_1477, fn__12085);
    t_1478 = SqlBuilder();
    t_1478:appendSafe('v IN (');
    t_1478:appendInt64List(temper.listof(temper.int64_constructor(1), temper.int64_constructor(2)));
    t_1478:appendSafe(')');
    actual_1479 = t_1478.accumulated:toString();
    t_1480 = temper.str_eq(actual_1479, 'v IN (1, 2)');
    fn__12084 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v IN (", \\interpolate, list(1, 2), ")").toString() == (', 'v IN (1, 2)', ') not (', actual_1479, ')');
    end;
    temper.test_assert(test_1467, t_1480, fn__12084);
    t_1481 = SqlBuilder();
    t_1481:appendSafe('v IN (');
    t_1481:appendFloat64List(temper.listof(1.0, 2.0));
    t_1481:appendSafe(')');
    actual_1482 = t_1481.accumulated:toString();
    t_1483 = temper.str_eq(actual_1482, 'v IN (1.0, 2.0)');
    fn__12083 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v IN (", \\interpolate, list(1.0, 2.0), ")").toString() == (', 'v IN (1.0, 2.0)', ') not (', actual_1482, ')');
    end;
    temper.test_assert(test_1467, t_1483, fn__12083);
    t_1484 = SqlBuilder();
    t_1484:appendSafe('v IN (');
    t_1484:appendBooleanList(temper.listof(true, false));
    t_1484:appendSafe(')');
    actual_1485 = t_1484.accumulated:toString();
    t_1486 = temper.str_eq(actual_1485, 'v IN (TRUE, FALSE)');
    fn__12082 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v IN (", \\interpolate, list(true, false), ")").toString() == (', 'v IN (TRUE, FALSE)', ') not (', actual_1485, ')');
    end;
    temper.test_assert(test_1467, t_1486, fn__12082);
    local_1487, local_1488, local_1489 = temper.pcall(function()
      t_1468 = temper.date_constructor(2024, 1, 1);
      t_1469 = t_1468;
    end);
    if local_1487 then
    else
      t_1469 = temper.bubble();
    end
    local_1491, local_1492, local_1493 = temper.pcall(function()
      t_1470 = temper.date_constructor(2024, 12, 25);
      t_1471 = t_1470;
    end);
    if local_1491 then
    else
      t_1471 = temper.bubble();
    end
    dates__1978 = temper.listof(t_1469, t_1471);
    t_1495 = SqlBuilder();
    t_1495:appendSafe('v IN (');
    t_1495:appendDateList(dates__1978);
    t_1495:appendSafe(')');
    actual_1496 = t_1495.accumulated:toString();
    t_1497 = temper.str_eq(actual_1496, "v IN ('2024-01-01', '2024-12-25')");
    fn__12081 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v IN (", \\interpolate, dates, ")").toString() == (', "v IN ('2024-01-01', '2024-12-25')", ') not (', actual_1496, ')');
    end;
    temper.test_assert(test_1467, t_1497, fn__12081);
    return nil;
  end);
end;
Test_.test_sqlFloat64_naNRendersAsNull__2492 = function()
  temper.test('SqlFloat64 NaN renders as NULL', function(test_1498)
    local nan__1980, t_1499, actual_1500, t_1501, fn__12072;
    nan__1980 = temper.fdiv(0.0, 0.0);
    t_1499 = SqlBuilder();
    t_1499:appendSafe('v = ');
    t_1499:appendFloat64(nan__1980);
    actual_1500 = t_1499.accumulated:toString();
    t_1501 = temper.str_eq(actual_1500, 'v = NULL');
    fn__12072 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, nan).toString() == (', 'v = NULL', ') not (', actual_1500, ')');
    end;
    temper.test_assert(test_1498, t_1501, fn__12072);
    return nil;
  end);
end;
Test_.test_sqlFloat64_infinityRendersAsNull__2496 = function()
  temper.test('SqlFloat64 Infinity renders as NULL', function(test_1502)
    local inf__1982, t_1503, actual_1504, t_1505, fn__12063;
    inf__1982 = temper.fdiv(1.0, 0.0);
    t_1503 = SqlBuilder();
    t_1503:appendSafe('v = ');
    t_1503:appendFloat64(inf__1982);
    actual_1504 = t_1503.accumulated:toString();
    t_1505 = temper.str_eq(actual_1504, 'v = NULL');
    fn__12063 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, inf).toString() == (', 'v = NULL', ') not (', actual_1504, ')');
    end;
    temper.test_assert(test_1502, t_1505, fn__12063);
    return nil;
  end);
end;
Test_.test_sqlFloat64_negativeInfinityRendersAsNull__2500 = function()
  temper.test('SqlFloat64 negative Infinity renders as NULL', function(test_1506)
    local ninf__1984, t_1507, actual_1508, t_1509, fn__12054;
    ninf__1984 = temper.fdiv(-1.0, 0.0);
    t_1507 = SqlBuilder();
    t_1507:appendSafe('v = ');
    t_1507:appendFloat64(ninf__1984);
    actual_1508 = t_1507.accumulated:toString();
    t_1509 = temper.str_eq(actual_1508, 'v = NULL');
    fn__12054 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, ninf).toString() == (', 'v = NULL', ') not (', actual_1508, ')');
    end;
    temper.test_assert(test_1506, t_1509, fn__12054);
    return nil;
  end);
end;
Test_.test_sqlFloat64_normalValuesStillWork__2504 = function()
  temper.test('SqlFloat64 normal values still work', function(test_1510)
    local t_1511, actual_1512, t_1513, fn__12029, t_1514, actual_1515, t_1516, fn__12028, t_1517, actual_1518, t_1519, fn__12027;
    t_1511 = SqlBuilder();
    t_1511:appendSafe('v = ');
    t_1511:appendFloat64(3.14);
    actual_1512 = t_1511.accumulated:toString();
    t_1513 = temper.str_eq(actual_1512, 'v = 3.14');
    fn__12029 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, 3.14).toString() == (', 'v = 3.14', ') not (', actual_1512, ')');
    end;
    temper.test_assert(test_1510, t_1513, fn__12029);
    t_1514 = SqlBuilder();
    t_1514:appendSafe('v = ');
    t_1514:appendFloat64(0.0);
    actual_1515 = t_1514.accumulated:toString();
    t_1516 = temper.str_eq(actual_1515, 'v = 0.0');
    fn__12028 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, 0.0).toString() == (', 'v = 0.0', ') not (', actual_1515, ')');
    end;
    temper.test_assert(test_1510, t_1516, fn__12028);
    t_1517 = SqlBuilder();
    t_1517:appendSafe('v = ');
    t_1517:appendFloat64(-42.5);
    actual_1518 = t_1517.accumulated:toString();
    t_1519 = temper.str_eq(actual_1518, 'v = -42.5');
    fn__12027 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, -42.5).toString() == (', 'v = -42.5', ') not (', actual_1518, ')');
    end;
    temper.test_assert(test_1510, t_1519, fn__12027);
    return nil;
  end);
end;
Test_.test_sqlDateRendersWithQuotes__2514 = function()
  temper.test('SqlDate renders with quotes', function(test_1520)
    local t_1521, d__1987, local_1522, local_1523, local_1524, t_1526, actual_1527, t_1528, fn__12018;
    local_1522, local_1523, local_1524 = temper.pcall(function()
      t_1521 = temper.date_constructor(2024, 6, 15);
      d__1987 = t_1521;
    end);
    if local_1522 then
    else
      d__1987 = temper.bubble();
    end
    t_1526 = SqlBuilder();
    t_1526:appendSafe('v = ');
    t_1526:appendDate(d__1987);
    actual_1527 = t_1526.accumulated:toString();
    t_1528 = temper.str_eq(actual_1527, "v = '2024-06-15'");
    fn__12018 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, d).toString() == (', "v = '2024-06-15'", ') not (', actual_1527, ')');
    end;
    temper.test_assert(test_1520, t_1528, fn__12018);
    return nil;
  end);
end;
Test_.test_nesting__2518 = function()
  temper.test('nesting', function(test_1529)
    local name__1989, t_1530, condition__1990, t_1531, actual_1532, t_1533, fn__11986, t_1534, actual_1535, t_1536, fn__11985, parts__1991, t_1537, actual_1538, t_1539, fn__11984;
    name__1989 = 'Someone';
    t_1530 = SqlBuilder();
    t_1530:appendSafe('where p.last_name = ');
    t_1530:appendString('Someone');
    condition__1990 = t_1530.accumulated;
    t_1531 = SqlBuilder();
    t_1531:appendSafe('select p.id from person p ');
    t_1531:appendFragment(condition__1990);
    actual_1532 = t_1531.accumulated:toString();
    t_1533 = temper.str_eq(actual_1532, "select p.id from person p where p.last_name = 'Someone'");
    fn__11986 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "select p.id from person p ", \\interpolate, condition).toString() == (', "select p.id from person p where p.last_name = 'Someone'", ') not (', actual_1532, ')');
    end;
    temper.test_assert(test_1529, t_1533, fn__11986);
    t_1534 = SqlBuilder();
    t_1534:appendSafe('select p.id from person p ');
    t_1534:appendPart(condition__1990:toSource());
    actual_1535 = t_1534.accumulated:toString();
    t_1536 = temper.str_eq(actual_1535, "select p.id from person p where p.last_name = 'Someone'");
    fn__11985 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "select p.id from person p ", \\interpolate, condition.toSource()).toString() == (', "select p.id from person p where p.last_name = 'Someone'", ') not (', actual_1535, ')');
    end;
    temper.test_assert(test_1529, t_1536, fn__11985);
    parts__1991 = temper.listof(SqlString("a'b"), SqlInt32(3));
    t_1537 = SqlBuilder();
    t_1537:appendSafe('select ');
    t_1537:appendPartList(parts__1991);
    actual_1538 = t_1537.accumulated:toString();
    t_1539 = temper.str_eq(actual_1538, "select 'a''b', 3");
    fn__11984 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "select ", \\interpolate, parts).toString() == (', "select 'a''b', 3", ') not (', actual_1538, ')');
    end;
    temper.test_assert(test_1529, t_1539, fn__11984);
    return nil;
  end);
end;
exports = {};
local_1541.LuaUnit.run(local_1540({'--pattern', '^Test_%.', local_1540(arg)}));
return exports;
