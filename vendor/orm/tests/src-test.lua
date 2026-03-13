local temper = require('temper-core');
local safeIdentifier, TableDef, FieldDef, StringField, IntField, FloatField, BoolField, changeset, NumberValidationOpts, from, SqlBuilder, col, SqlInt32, SqlString, countAll, countCol, sumCol, avgCol, minCol, maxCol, unionSql, unionAllSql, intersectSql, exceptSql, subquery, existsSql, update, SqlBoolean, deleteFrom, NullsFirst, NullsLast, ForUpdate, ForShare, local_1366, local_1367, csid__636, userTable__637, sid__638, exports;
safeIdentifier = temper.import('orm/src', 'safeIdentifier');
TableDef = temper.import('orm/src', 'TableDef');
FieldDef = temper.import('orm/src', 'FieldDef');
StringField = temper.import('orm/src', 'StringField');
IntField = temper.import('orm/src', 'IntField');
FloatField = temper.import('orm/src', 'FloatField');
BoolField = temper.import('orm/src', 'BoolField');
changeset = temper.import('orm/src', 'changeset');
NumberValidationOpts = temper.import('orm/src', 'NumberValidationOpts');
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
local_1366 = (unpack or table.unpack);
local_1367 = require('luaunit');
local_1367.FAILURE_PREFIX = temper.test_failure_prefix;
Test_ = {};
csid__636 = function(name__924)
  local return__427, t_244, local_245, local_246, local_247;
  local_245, local_246, local_247 = temper.pcall(function()
    t_244 = safeIdentifier(name__924);
    return__427 = t_244;
  end);
  if local_245 then
  else
    return__427 = temper.bubble();
  end
  return return__427;
end;
userTable__637 = function()
  return TableDef(csid__636('users'), temper.listof(FieldDef(csid__636('name'), StringField(), false), FieldDef(csid__636('email'), StringField(), false), FieldDef(csid__636('age'), IntField(), true), FieldDef(csid__636('score'), FloatField(), true), FieldDef(csid__636('active'), BoolField(), true)));
end;
Test_.test_castWhitelistsAllowedFields__2009 = function()
  temper.test('cast whitelists allowed fields', function(test_249)
    local params__928, t_250, t_251, t_252, cs__929, t_253, fn__13818, t_254, fn__13817, t_255, fn__13816, t_256, fn__13815;
    params__928 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice'), temper.pair_constructor('email', 'alice@example.com'), temper.pair_constructor('admin', 'true')));
    t_250 = userTable__637();
    t_251 = csid__636('name');
    t_252 = csid__636('email');
    cs__929 = changeset(t_250, params__928):cast(temper.listof(t_251, t_252));
    t_253 = temper.mapped_has(cs__929.changes, 'name');
    fn__13818 = function()
      return 'name should be in changes';
    end;
    temper.test_assert(test_249, t_253, fn__13818);
    t_254 = temper.mapped_has(cs__929.changes, 'email');
    fn__13817 = function()
      return 'email should be in changes';
    end;
    temper.test_assert(test_249, t_254, fn__13817);
    t_255 = not temper.mapped_has(cs__929.changes, 'admin');
    fn__13816 = function()
      return 'admin must be dropped (not in whitelist)';
    end;
    temper.test_assert(test_249, t_255, fn__13816);
    t_256 = cs__929.isValid;
    fn__13815 = function()
      return 'should still be valid';
    end;
    temper.test_assert(test_249, t_256, fn__13815);
    return nil;
  end);
end;
Test_.test_castIsReplacingNotAdditiveSecondCallResetsWhitelist__2010 = function()
  temper.test('cast is replacing not additive \xe2\x80\x94 second call resets whitelist', function(test_257)
    local params__931, t_258, t_259, cs__932, t_260, fn__13797, t_261, fn__13796;
    params__931 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice'), temper.pair_constructor('email', 'alice@example.com')));
    t_258 = userTable__637();
    t_259 = csid__636('name');
    cs__932 = changeset(t_258, params__931):cast(temper.listof(t_259)):cast(temper.listof(csid__636('email')));
    t_260 = not temper.mapped_has(cs__932.changes, 'name');
    fn__13797 = function()
      return 'name must be excluded by second cast';
    end;
    temper.test_assert(test_257, t_260, fn__13797);
    t_261 = temper.mapped_has(cs__932.changes, 'email');
    fn__13796 = function()
      return 'email should be present';
    end;
    temper.test_assert(test_257, t_261, fn__13796);
    return nil;
  end);
end;
Test_.test_castIgnoresEmptyStringValues__2011 = function()
  temper.test('cast ignores empty string values', function(test_262)
    local params__934, t_263, t_264, t_265, cs__935, t_266, fn__13779, t_267, fn__13778;
    params__934 = temper.map_constructor(temper.listof(temper.pair_constructor('name', ''), temper.pair_constructor('email', 'bob@example.com')));
    t_263 = userTable__637();
    t_264 = csid__636('name');
    t_265 = csid__636('email');
    cs__935 = changeset(t_263, params__934):cast(temper.listof(t_264, t_265));
    t_266 = not temper.mapped_has(cs__935.changes, 'name');
    fn__13779 = function()
      return 'empty name should not be in changes';
    end;
    temper.test_assert(test_262, t_266, fn__13779);
    t_267 = temper.mapped_has(cs__935.changes, 'email');
    fn__13778 = function()
      return 'email should be in changes';
    end;
    temper.test_assert(test_262, t_267, fn__13778);
    return nil;
  end);
end;
Test_.test_validateRequiredPassesWhenFieldPresent__2012 = function()
  temper.test('validateRequired passes when field present', function(test_268)
    local params__937, t_269, t_270, cs__938, t_271, fn__13762, t_272, fn__13761;
    params__937 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice')));
    t_269 = userTable__637();
    t_270 = csid__636('name');
    cs__938 = changeset(t_269, params__937):cast(temper.listof(t_270)):validateRequired(temper.listof(csid__636('name')));
    t_271 = cs__938.isValid;
    fn__13762 = function()
      return 'should be valid';
    end;
    temper.test_assert(test_268, t_271, fn__13762);
    t_272 = (temper.list_length(cs__938.errors) == 0);
    fn__13761 = function()
      return 'no errors expected';
    end;
    temper.test_assert(test_268, t_272, fn__13761);
    return nil;
  end);
end;
Test_.test_validateRequiredFailsWhenFieldMissing__2013 = function()
  temper.test('validateRequired fails when field missing', function(test_273)
    local params__940, t_274, t_275, cs__941, t_276, fn__13739, t_277, fn__13738, t_278, fn__13737;
    params__940 = temper.map_constructor(temper.listof());
    t_274 = userTable__637();
    t_275 = csid__636('name');
    cs__941 = changeset(t_274, params__940):cast(temper.listof(t_275)):validateRequired(temper.listof(csid__636('name')));
    t_276 = not cs__941.isValid;
    fn__13739 = function()
      return 'should be invalid';
    end;
    temper.test_assert(test_273, t_276, fn__13739);
    t_277 = (temper.list_length(cs__941.errors) == 1);
    fn__13738 = function()
      return 'should have one error';
    end;
    temper.test_assert(test_273, t_277, fn__13738);
    t_278 = temper.str_eq((temper.list_get(cs__941.errors, 0)).field, 'name');
    fn__13737 = function()
      return 'error should name the field';
    end;
    temper.test_assert(test_273, t_278, fn__13737);
    return nil;
  end);
end;
Test_.test_validateLengthPassesWithinRange__2014 = function()
  temper.test('validateLength passes within range', function(test_279)
    local params__943, t_280, t_281, cs__944, t_282, fn__13726;
    params__943 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice')));
    t_280 = userTable__637();
    t_281 = csid__636('name');
    cs__944 = changeset(t_280, params__943):cast(temper.listof(t_281)):validateLength(csid__636('name'), 2, 50);
    t_282 = cs__944.isValid;
    fn__13726 = function()
      return 'should be valid';
    end;
    temper.test_assert(test_279, t_282, fn__13726);
    return nil;
  end);
end;
Test_.test_validateLengthFailsWhenTooShort__2015 = function()
  temper.test('validateLength fails when too short', function(test_283)
    local params__946, t_284, t_285, cs__947, t_286, fn__13714;
    params__946 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'A')));
    t_284 = userTable__637();
    t_285 = csid__636('name');
    cs__947 = changeset(t_284, params__946):cast(temper.listof(t_285)):validateLength(csid__636('name'), 2, 50);
    t_286 = not cs__947.isValid;
    fn__13714 = function()
      return 'should be invalid';
    end;
    temper.test_assert(test_283, t_286, fn__13714);
    return nil;
  end);
end;
Test_.test_validateLengthFailsWhenTooLong__2016 = function()
  temper.test('validateLength fails when too long', function(test_287)
    local params__949, t_288, t_289, cs__950, t_290, fn__13702;
    params__949 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')));
    t_288 = userTable__637();
    t_289 = csid__636('name');
    cs__950 = changeset(t_288, params__949):cast(temper.listof(t_289)):validateLength(csid__636('name'), 2, 10);
    t_290 = not cs__950.isValid;
    fn__13702 = function()
      return 'should be invalid';
    end;
    temper.test_assert(test_287, t_290, fn__13702);
    return nil;
  end);
end;
Test_.test_validateIntPassesForValidInteger__2017 = function()
  temper.test('validateInt passes for valid integer', function(test_291)
    local params__952, t_292, t_293, cs__953, t_294, fn__13691;
    params__952 = temper.map_constructor(temper.listof(temper.pair_constructor('age', '30')));
    t_292 = userTable__637();
    t_293 = csid__636('age');
    cs__953 = changeset(t_292, params__952):cast(temper.listof(t_293)):validateInt(csid__636('age'));
    t_294 = cs__953.isValid;
    fn__13691 = function()
      return 'should be valid';
    end;
    temper.test_assert(test_291, t_294, fn__13691);
    return nil;
  end);
end;
Test_.test_validateIntFailsForNonInteger__2018 = function()
  temper.test('validateInt fails for non-integer', function(test_295)
    local params__955, t_296, t_297, cs__956, t_298, fn__13679;
    params__955 = temper.map_constructor(temper.listof(temper.pair_constructor('age', 'not-a-number')));
    t_296 = userTable__637();
    t_297 = csid__636('age');
    cs__956 = changeset(t_296, params__955):cast(temper.listof(t_297)):validateInt(csid__636('age'));
    t_298 = not cs__956.isValid;
    fn__13679 = function()
      return 'should be invalid';
    end;
    temper.test_assert(test_295, t_298, fn__13679);
    return nil;
  end);
end;
Test_.test_validateFloatPassesForValidFloat__2019 = function()
  temper.test('validateFloat passes for valid float', function(test_299)
    local params__958, t_300, t_301, cs__959, t_302, fn__13668;
    params__958 = temper.map_constructor(temper.listof(temper.pair_constructor('score', '9.5')));
    t_300 = userTable__637();
    t_301 = csid__636('score');
    cs__959 = changeset(t_300, params__958):cast(temper.listof(t_301)):validateFloat(csid__636('score'));
    t_302 = cs__959.isValid;
    fn__13668 = function()
      return 'should be valid';
    end;
    temper.test_assert(test_299, t_302, fn__13668);
    return nil;
  end);
end;
Test_.test_validateInt64_passesForValid64_bitInteger__2020 = function()
  temper.test('validateInt64 passes for valid 64-bit integer', function(test_303)
    local params__961, t_304, t_305, cs__962, t_306, fn__13657;
    params__961 = temper.map_constructor(temper.listof(temper.pair_constructor('age', '9999999999')));
    t_304 = userTable__637();
    t_305 = csid__636('age');
    cs__962 = changeset(t_304, params__961):cast(temper.listof(t_305)):validateInt64(csid__636('age'));
    t_306 = cs__962.isValid;
    fn__13657 = function()
      return 'should be valid';
    end;
    temper.test_assert(test_303, t_306, fn__13657);
    return nil;
  end);
end;
Test_.test_validateInt64_failsForNonInteger__2021 = function()
  temper.test('validateInt64 fails for non-integer', function(test_307)
    local params__964, t_308, t_309, cs__965, t_310, fn__13645;
    params__964 = temper.map_constructor(temper.listof(temper.pair_constructor('age', 'not-a-number')));
    t_308 = userTable__637();
    t_309 = csid__636('age');
    cs__965 = changeset(t_308, params__964):cast(temper.listof(t_309)):validateInt64(csid__636('age'));
    t_310 = not cs__965.isValid;
    fn__13645 = function()
      return 'should be invalid';
    end;
    temper.test_assert(test_307, t_310, fn__13645);
    return nil;
  end);
end;
Test_.test_validateBoolAcceptsTrue1_yesOn__2022 = function()
  temper.test('validateBool accepts true/1/yes/on', function(test_311)
    local fn__13642;
    fn__13642 = function(v__967)
      local params__968, t_312, t_313, cs__969, t_314, fn__13631;
      params__968 = temper.map_constructor(temper.listof(temper.pair_constructor('active', v__967)));
      t_312 = userTable__637();
      t_313 = csid__636('active');
      cs__969 = changeset(t_312, params__968):cast(temper.listof(t_313)):validateBool(csid__636('active'));
      t_314 = cs__969.isValid;
      fn__13631 = function()
        return temper.concat('should accept: ', v__967);
      end;
      temper.test_assert(test_311, t_314, fn__13631);
      return nil;
    end;
    temper.list_foreach(temper.listof('true', '1', 'yes', 'on'), fn__13642);
    return nil;
  end);
end;
Test_.test_validateBoolAcceptsFalse0_noOff__2023 = function()
  temper.test('validateBool accepts false/0/no/off', function(test_315)
    local fn__13628;
    fn__13628 = function(v__971)
      local params__972, t_316, t_317, cs__973, t_318, fn__13617;
      params__972 = temper.map_constructor(temper.listof(temper.pair_constructor('active', v__971)));
      t_316 = userTable__637();
      t_317 = csid__636('active');
      cs__973 = changeset(t_316, params__972):cast(temper.listof(t_317)):validateBool(csid__636('active'));
      t_318 = cs__973.isValid;
      fn__13617 = function()
        return temper.concat('should accept: ', v__971);
      end;
      temper.test_assert(test_315, t_318, fn__13617);
      return nil;
    end;
    temper.list_foreach(temper.listof('false', '0', 'no', 'off'), fn__13628);
    return nil;
  end);
end;
Test_.test_validateBoolRejectsAmbiguousValues__2024 = function()
  temper.test('validateBool rejects ambiguous values', function(test_319)
    local fn__13614;
    fn__13614 = function(v__975)
      local params__976, t_320, t_321, cs__977, t_322, fn__13602;
      params__976 = temper.map_constructor(temper.listof(temper.pair_constructor('active', v__975)));
      t_320 = userTable__637();
      t_321 = csid__636('active');
      cs__977 = changeset(t_320, params__976):cast(temper.listof(t_321)):validateBool(csid__636('active'));
      t_322 = not cs__977.isValid;
      fn__13602 = function()
        return temper.concat('should reject ambiguous: ', v__975);
      end;
      temper.test_assert(test_319, t_322, fn__13602);
      return nil;
    end;
    temper.list_foreach(temper.listof('TRUE', 'Yes', 'maybe', '2', 'enabled'), fn__13614);
    return nil;
  end);
end;
Test_.test_toInsertSqlEscapesBobbyTables__2025 = function()
  temper.test('toInsertSql escapes Bobby Tables', function(test_323)
    local t_324, params__979, t_325, t_326, t_327, cs__980, sqlFrag__981, local_328, local_329, local_330, s__982, t_332, fn__13586;
    params__979 = temper.map_constructor(temper.listof(temper.pair_constructor('name', "Robert'); DROP TABLE users;--"), temper.pair_constructor('email', 'bobby@evil.com')));
    t_325 = userTable__637();
    t_326 = csid__636('name');
    t_327 = csid__636('email');
    cs__980 = changeset(t_325, params__979):cast(temper.listof(t_326, t_327)):validateRequired(temper.listof(csid__636('name'), csid__636('email')));
    local_328, local_329, local_330 = temper.pcall(function()
      t_324 = cs__980:toInsertSql();
      sqlFrag__981 = t_324;
    end);
    if local_328 then
    else
      sqlFrag__981 = temper.bubble();
    end
    s__982 = sqlFrag__981:toString();
    t_332 = temper.is_string_index(temper.string_indexof(s__982, "''"));
    fn__13586 = function()
      return temper.concat('single quote must be doubled: ', s__982);
    end;
    temper.test_assert(test_323, t_332, fn__13586);
    return nil;
  end);
end;
Test_.test_toInsertSqlProducesCorrectSqlForStringField__2026 = function()
  temper.test('toInsertSql produces correct SQL for string field', function(test_333)
    local t_334, params__984, t_335, t_336, t_337, cs__985, sqlFrag__986, local_338, local_339, local_340, s__987, t_342, fn__13566, t_343, fn__13565;
    params__984 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice'), temper.pair_constructor('email', 'a@example.com')));
    t_335 = userTable__637();
    t_336 = csid__636('name');
    t_337 = csid__636('email');
    cs__985 = changeset(t_335, params__984):cast(temper.listof(t_336, t_337)):validateRequired(temper.listof(csid__636('name'), csid__636('email')));
    local_338, local_339, local_340 = temper.pcall(function()
      t_334 = cs__985:toInsertSql();
      sqlFrag__986 = t_334;
    end);
    if local_338 then
    else
      sqlFrag__986 = temper.bubble();
    end
    s__987 = sqlFrag__986:toString();
    t_342 = temper.is_string_index(temper.string_indexof(s__987, 'INSERT INTO users'));
    fn__13566 = function()
      return temper.concat('has INSERT INTO: ', s__987);
    end;
    temper.test_assert(test_333, t_342, fn__13566);
    t_343 = temper.is_string_index(temper.string_indexof(s__987, "'Alice'"));
    fn__13565 = function()
      return temper.concat('has quoted name: ', s__987);
    end;
    temper.test_assert(test_333, t_343, fn__13565);
    return nil;
  end);
end;
Test_.test_toInsertSqlProducesCorrectSqlForIntField__2027 = function()
  temper.test('toInsertSql produces correct SQL for int field', function(test_344)
    local t_345, params__989, t_346, t_347, t_348, t_349, cs__990, sqlFrag__991, local_350, local_351, local_352, s__992, t_354, fn__13547;
    params__989 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Bob'), temper.pair_constructor('email', 'b@example.com'), temper.pair_constructor('age', '25')));
    t_346 = userTable__637();
    t_347 = csid__636('name');
    t_348 = csid__636('email');
    t_349 = csid__636('age');
    cs__990 = changeset(t_346, params__989):cast(temper.listof(t_347, t_348, t_349)):validateRequired(temper.listof(csid__636('name'), csid__636('email')));
    local_350, local_351, local_352 = temper.pcall(function()
      t_345 = cs__990:toInsertSql();
      sqlFrag__991 = t_345;
    end);
    if local_350 then
    else
      sqlFrag__991 = temper.bubble();
    end
    s__992 = sqlFrag__991:toString();
    t_354 = temper.is_string_index(temper.string_indexof(s__992, '25'));
    fn__13547 = function()
      return temper.concat('age rendered unquoted: ', s__992);
    end;
    temper.test_assert(test_344, t_354, fn__13547);
    return nil;
  end);
end;
Test_.test_toInsertSqlBubblesOnInvalidChangeset__2028 = function()
  temper.test('toInsertSql bubbles on invalid changeset', function(test_355)
    local params__994, t_356, t_357, cs__995, didBubble__996, local_358, local_359, local_360, fn__13538;
    params__994 = temper.map_constructor(temper.listof());
    t_356 = userTable__637();
    t_357 = csid__636('name');
    cs__995 = changeset(t_356, params__994):cast(temper.listof(t_357)):validateRequired(temper.listof(csid__636('name')));
    local_358, local_359, local_360 = temper.pcall(function()
      cs__995:toInsertSql();
      didBubble__996 = false;
    end);
    if local_358 then
    else
      didBubble__996 = true;
    end
    fn__13538 = function()
      return 'invalid changeset should bubble';
    end;
    temper.test_assert(test_355, didBubble__996, fn__13538);
    return nil;
  end);
end;
Test_.test_toInsertSqlEnforcesNonNullableFieldsIndependentlyOfIsValid__2029 = function()
  temper.test('toInsertSql enforces non-nullable fields independently of isValid', function(test_362)
    local strictTable__998, params__999, t_363, cs__1000, t_364, fn__13520, didBubble__1001, local_365, local_366, local_367, fn__13519;
    strictTable__998 = TableDef(csid__636('posts'), temper.listof(FieldDef(csid__636('title'), StringField(), false), FieldDef(csid__636('body'), StringField(), true)));
    params__999 = temper.map_constructor(temper.listof(temper.pair_constructor('body', 'hello')));
    t_363 = csid__636('body');
    cs__1000 = changeset(strictTable__998, params__999):cast(temper.listof(t_363));
    t_364 = cs__1000.isValid;
    fn__13520 = function()
      return 'changeset should appear valid (no explicit validation run)';
    end;
    temper.test_assert(test_362, t_364, fn__13520);
    local_365, local_366, local_367 = temper.pcall(function()
      cs__1000:toInsertSql();
      didBubble__1001 = false;
    end);
    if local_365 then
    else
      didBubble__1001 = true;
    end
    fn__13519 = function()
      return 'toInsertSql should enforce nullable regardless of isValid';
    end;
    temper.test_assert(test_362, didBubble__1001, fn__13519);
    return nil;
  end);
end;
Test_.test_toUpdateSqlProducesCorrectSql__2030 = function()
  temper.test('toUpdateSql produces correct SQL', function(test_369)
    local t_370, params__1003, t_371, t_372, cs__1004, sqlFrag__1005, local_373, local_374, local_375, s__1006, t_377, fn__13507;
    params__1003 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Bob')));
    t_371 = userTable__637();
    t_372 = csid__636('name');
    cs__1004 = changeset(t_371, params__1003):cast(temper.listof(t_372)):validateRequired(temper.listof(csid__636('name')));
    local_373, local_374, local_375 = temper.pcall(function()
      t_370 = cs__1004:toUpdateSql(42);
      sqlFrag__1005 = t_370;
    end);
    if local_373 then
    else
      sqlFrag__1005 = temper.bubble();
    end
    s__1006 = sqlFrag__1005:toString();
    t_377 = temper.str_eq(s__1006, "UPDATE users SET name = 'Bob' WHERE id = 42");
    fn__13507 = function()
      return temper.concat('got: ', s__1006);
    end;
    temper.test_assert(test_369, t_377, fn__13507);
    return nil;
  end);
end;
Test_.test_toUpdateSqlBubblesOnInvalidChangeset__2031 = function()
  temper.test('toUpdateSql bubbles on invalid changeset', function(test_378)
    local params__1008, t_379, t_380, cs__1009, didBubble__1010, local_381, local_382, local_383, fn__13498;
    params__1008 = temper.map_constructor(temper.listof());
    t_379 = userTable__637();
    t_380 = csid__636('name');
    cs__1009 = changeset(t_379, params__1008):cast(temper.listof(t_380)):validateRequired(temper.listof(csid__636('name')));
    local_381, local_382, local_383 = temper.pcall(function()
      cs__1009:toUpdateSql(1);
      didBubble__1010 = false;
    end);
    if local_381 then
    else
      didBubble__1010 = true;
    end
    fn__13498 = function()
      return 'invalid changeset should bubble';
    end;
    temper.test_assert(test_378, didBubble__1010, fn__13498);
    return nil;
  end);
end;
Test_.test_putChangeAddsANewField__2032 = function()
  temper.test('putChange adds a new field', function(test_385)
    local params__1012, t_386, t_387, cs__1013, t_388, fn__13481, t_389, fn__13480;
    params__1012 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice')));
    t_386 = userTable__637();
    t_387 = csid__636('name');
    cs__1013 = changeset(t_386, params__1012):cast(temper.listof(t_387)):putChange(csid__636('email'), 'alice@example.com');
    t_388 = temper.mapped_has(cs__1013.changes, 'email');
    fn__13481 = function()
      return 'email should be in changes';
    end;
    temper.test_assert(test_385, t_388, fn__13481);
    t_389 = temper.str_eq(temper.mapped_getor(cs__1013.changes, 'email', ''), 'alice@example.com');
    fn__13480 = function()
      return 'email value';
    end;
    temper.test_assert(test_385, t_389, fn__13480);
    return nil;
  end);
end;
Test_.test_putChangeOverwritesExistingField__2033 = function()
  temper.test('putChange overwrites existing field', function(test_390)
    local params__1015, t_391, t_392, cs__1016, t_393, fn__13467;
    params__1015 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice')));
    t_391 = userTable__637();
    t_392 = csid__636('name');
    cs__1016 = changeset(t_391, params__1015):cast(temper.listof(t_392)):putChange(csid__636('name'), 'Bob');
    t_393 = temper.str_eq(temper.mapped_getor(cs__1016.changes, 'name', ''), 'Bob');
    fn__13467 = function()
      return 'name should be overwritten';
    end;
    temper.test_assert(test_390, t_393, fn__13467);
    return nil;
  end);
end;
Test_.test_putChangeValueAppearsInToInsertSql__2034 = function()
  temper.test('putChange value appears in toInsertSql', function(test_394)
    local t_395, t_396, params__1018, t_397, t_398, t_399, cs__1019, local_400, local_401, local_402, s__1020, t_404, fn__13452;
    params__1018 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice'), temper.pair_constructor('email', 'a@example.com')));
    t_397 = userTable__637();
    t_398 = csid__636('name');
    t_399 = csid__636('email');
    cs__1019 = changeset(t_397, params__1018):cast(temper.listof(t_398, t_399)):putChange(csid__636('name'), 'Bob');
    local_400, local_401, local_402 = temper.pcall(function()
      t_395 = cs__1019:toInsertSql();
      t_396 = t_395;
    end);
    if local_400 then
    else
      t_396 = temper.bubble();
    end
    s__1020 = t_396:toString();
    t_404 = temper.is_string_index(temper.string_indexof(s__1020, "'Bob'"));
    fn__13452 = function()
      return temper.concat('should use putChange value: ', s__1020);
    end;
    temper.test_assert(test_394, t_404, fn__13452);
    return nil;
  end);
end;
Test_.test_getChangeReturnsValueForExistingField__2035 = function()
  temper.test('getChange returns value for existing field', function(test_405)
    local t_406, params__1022, t_407, t_408, cs__1023, val__1024, local_409, local_410, local_411, t_413, fn__13442;
    params__1022 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice')));
    t_407 = userTable__637();
    t_408 = csid__636('name');
    cs__1023 = changeset(t_407, params__1022):cast(temper.listof(t_408));
    local_409, local_410, local_411 = temper.pcall(function()
      t_406 = cs__1023:getChange(csid__636('name'));
      val__1024 = t_406;
    end);
    if local_409 then
    else
      val__1024 = temper.bubble();
    end
    t_413 = temper.str_eq(val__1024, 'Alice');
    fn__13442 = function()
      return 'should return Alice';
    end;
    temper.test_assert(test_405, t_413, fn__13442);
    return nil;
  end);
end;
Test_.test_getChangeBubblesOnMissingField__2036 = function()
  temper.test('getChange bubbles on missing field', function(test_414)
    local params__1026, t_415, t_416, cs__1027, didBubble__1028, local_417, local_418, local_419, fn__13433;
    params__1026 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice')));
    t_415 = userTable__637();
    t_416 = csid__636('name');
    cs__1027 = changeset(t_415, params__1026):cast(temper.listof(t_416));
    local_417, local_418, local_419 = temper.pcall(function()
      cs__1027:getChange(csid__636('email'));
      didBubble__1028 = false;
    end);
    if local_417 then
    else
      didBubble__1028 = true;
    end
    fn__13433 = function()
      return 'should bubble for missing field';
    end;
    temper.test_assert(test_414, didBubble__1028, fn__13433);
    return nil;
  end);
end;
Test_.test_deleteChangeRemovesField__2037 = function()
  temper.test('deleteChange removes field', function(test_421)
    local params__1030, t_422, t_423, t_424, cs__1031, t_425, fn__13414, t_426, fn__13413;
    params__1030 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice'), temper.pair_constructor('email', 'a@example.com')));
    t_422 = userTable__637();
    t_423 = csid__636('name');
    t_424 = csid__636('email');
    cs__1031 = changeset(t_422, params__1030):cast(temper.listof(t_423, t_424)):deleteChange(csid__636('email'));
    t_425 = not temper.mapped_has(cs__1031.changes, 'email');
    fn__13414 = function()
      return 'email should be removed';
    end;
    temper.test_assert(test_421, t_425, fn__13414);
    t_426 = temper.mapped_has(cs__1031.changes, 'name');
    fn__13413 = function()
      return 'name should remain';
    end;
    temper.test_assert(test_421, t_426, fn__13413);
    return nil;
  end);
end;
Test_.test_deleteChangeOnNonexistentFieldIsNoOp__2038 = function()
  temper.test('deleteChange on nonexistent field is no-op', function(test_427)
    local params__1033, t_428, t_429, cs__1034, t_430, fn__13398, t_431, fn__13397;
    params__1033 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice')));
    t_428 = userTable__637();
    t_429 = csid__636('name');
    cs__1034 = changeset(t_428, params__1033):cast(temper.listof(t_429)):deleteChange(csid__636('email'));
    t_430 = temper.mapped_has(cs__1034.changes, 'name');
    fn__13398 = function()
      return 'name should still be present';
    end;
    temper.test_assert(test_427, t_430, fn__13398);
    t_431 = cs__1034.isValid;
    fn__13397 = function()
      return 'should still be valid';
    end;
    temper.test_assert(test_427, t_431, fn__13397);
    return nil;
  end);
end;
Test_.test_validateInclusionPassesWhenValueInList__2039 = function()
  temper.test('validateInclusion passes when value in list', function(test_432)
    local params__1036, t_433, t_434, cs__1037, t_435, fn__13386;
    params__1036 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'admin')));
    t_433 = userTable__637();
    t_434 = csid__636('name');
    cs__1037 = changeset(t_433, params__1036):cast(temper.listof(t_434)):validateInclusion(csid__636('name'), temper.listof('admin', 'user', 'guest'));
    t_435 = cs__1037.isValid;
    fn__13386 = function()
      return 'should be valid';
    end;
    temper.test_assert(test_432, t_435, fn__13386);
    return nil;
  end);
end;
Test_.test_validateInclusionFailsWhenValueNotInList__2040 = function()
  temper.test('validateInclusion fails when value not in list', function(test_436)
    local params__1039, t_437, t_438, cs__1040, t_439, fn__13368, t_440, fn__13367;
    params__1039 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'hacker')));
    t_437 = userTable__637();
    t_438 = csid__636('name');
    cs__1040 = changeset(t_437, params__1039):cast(temper.listof(t_438)):validateInclusion(csid__636('name'), temper.listof('admin', 'user', 'guest'));
    t_439 = not cs__1040.isValid;
    fn__13368 = function()
      return 'should be invalid';
    end;
    temper.test_assert(test_436, t_439, fn__13368);
    t_440 = temper.str_eq((temper.list_get(cs__1040.errors, 0)).field, 'name');
    fn__13367 = function()
      return 'error on name';
    end;
    temper.test_assert(test_436, t_440, fn__13367);
    return nil;
  end);
end;
Test_.test_validateInclusionSkipsWhenFieldNotInChanges__2041 = function()
  temper.test('validateInclusion skips when field not in changes', function(test_441)
    local params__1042, t_442, t_443, cs__1043, t_444, fn__13357;
    params__1042 = temper.map_constructor(temper.listof());
    t_442 = userTable__637();
    t_443 = csid__636('name');
    cs__1043 = changeset(t_442, params__1042):cast(temper.listof(t_443)):validateInclusion(csid__636('name'), temper.listof('admin', 'user'));
    t_444 = cs__1043.isValid;
    fn__13357 = function()
      return 'should be valid when field absent';
    end;
    temper.test_assert(test_441, t_444, fn__13357);
    return nil;
  end);
end;
Test_.test_validateExclusionPassesWhenValueNotInList__2042 = function()
  temper.test('validateExclusion passes when value not in list', function(test_445)
    local params__1045, t_446, t_447, cs__1046, t_448, fn__13346;
    params__1045 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice')));
    t_446 = userTable__637();
    t_447 = csid__636('name');
    cs__1046 = changeset(t_446, params__1045):cast(temper.listof(t_447)):validateExclusion(csid__636('name'), temper.listof('root', 'admin', 'superuser'));
    t_448 = cs__1046.isValid;
    fn__13346 = function()
      return 'should be valid';
    end;
    temper.test_assert(test_445, t_448, fn__13346);
    return nil;
  end);
end;
Test_.test_validateExclusionFailsWhenValueInList__2043 = function()
  temper.test('validateExclusion fails when value in list', function(test_449)
    local params__1048, t_450, t_451, cs__1049, t_452, fn__13328, t_453, fn__13327;
    params__1048 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'admin')));
    t_450 = userTable__637();
    t_451 = csid__636('name');
    cs__1049 = changeset(t_450, params__1048):cast(temper.listof(t_451)):validateExclusion(csid__636('name'), temper.listof('root', 'admin', 'superuser'));
    t_452 = not cs__1049.isValid;
    fn__13328 = function()
      return 'should be invalid';
    end;
    temper.test_assert(test_449, t_452, fn__13328);
    t_453 = temper.str_eq((temper.list_get(cs__1049.errors, 0)).field, 'name');
    fn__13327 = function()
      return 'error on name';
    end;
    temper.test_assert(test_449, t_453, fn__13327);
    return nil;
  end);
end;
Test_.test_validateExclusionSkipsWhenFieldNotInChanges__2044 = function()
  temper.test('validateExclusion skips when field not in changes', function(test_454)
    local params__1051, t_455, t_456, cs__1052, t_457, fn__13317;
    params__1051 = temper.map_constructor(temper.listof());
    t_455 = userTable__637();
    t_456 = csid__636('name');
    cs__1052 = changeset(t_455, params__1051):cast(temper.listof(t_456)):validateExclusion(csid__636('name'), temper.listof('root', 'admin'));
    t_457 = cs__1052.isValid;
    fn__13317 = function()
      return 'should be valid when field absent';
    end;
    temper.test_assert(test_454, t_457, fn__13317);
    return nil;
  end);
end;
Test_.test_validateNumberGreaterThanPasses__2045 = function()
  temper.test('validateNumber greaterThan passes', function(test_458)
    local params__1054, t_459, t_460, cs__1055, t_461, fn__13305;
    params__1054 = temper.map_constructor(temper.listof(temper.pair_constructor('age', '25')));
    t_459 = userTable__637();
    t_460 = csid__636('age');
    cs__1055 = changeset(t_459, params__1054):cast(temper.listof(t_460)):validateNumber(csid__636('age'), NumberValidationOpts(18.0, temper.null, temper.null, temper.null, temper.null));
    t_461 = cs__1055.isValid;
    fn__13305 = function()
      return '25 > 18 should pass';
    end;
    temper.test_assert(test_458, t_461, fn__13305);
    return nil;
  end);
end;
Test_.test_validateNumberGreaterThanFails__2046 = function()
  temper.test('validateNumber greaterThan fails', function(test_462)
    local params__1057, t_463, t_464, cs__1058, t_465, fn__13292;
    params__1057 = temper.map_constructor(temper.listof(temper.pair_constructor('age', '15')));
    t_463 = userTable__637();
    t_464 = csid__636('age');
    cs__1058 = changeset(t_463, params__1057):cast(temper.listof(t_464)):validateNumber(csid__636('age'), NumberValidationOpts(18.0, temper.null, temper.null, temper.null, temper.null));
    t_465 = not cs__1058.isValid;
    fn__13292 = function()
      return '15 > 18 should fail';
    end;
    temper.test_assert(test_462, t_465, fn__13292);
    return nil;
  end);
end;
Test_.test_validateNumberLessThanPasses__2047 = function()
  temper.test('validateNumber lessThan passes', function(test_466)
    local params__1060, t_467, t_468, cs__1061, t_469, fn__13280;
    params__1060 = temper.map_constructor(temper.listof(temper.pair_constructor('score', '8.5')));
    t_467 = userTable__637();
    t_468 = csid__636('score');
    cs__1061 = changeset(t_467, params__1060):cast(temper.listof(t_468)):validateNumber(csid__636('score'), NumberValidationOpts(temper.null, 10.0, temper.null, temper.null, temper.null));
    t_469 = cs__1061.isValid;
    fn__13280 = function()
      return '8.5 < 10 should pass';
    end;
    temper.test_assert(test_466, t_469, fn__13280);
    return nil;
  end);
end;
Test_.test_validateNumberLessThanFails__2048 = function()
  temper.test('validateNumber lessThan fails', function(test_470)
    local params__1063, t_471, t_472, cs__1064, t_473, fn__13267;
    params__1063 = temper.map_constructor(temper.listof(temper.pair_constructor('score', '12.0')));
    t_471 = userTable__637();
    t_472 = csid__636('score');
    cs__1064 = changeset(t_471, params__1063):cast(temper.listof(t_472)):validateNumber(csid__636('score'), NumberValidationOpts(temper.null, 10.0, temper.null, temper.null, temper.null));
    t_473 = not cs__1064.isValid;
    fn__13267 = function()
      return '12 < 10 should fail';
    end;
    temper.test_assert(test_470, t_473, fn__13267);
    return nil;
  end);
end;
Test_.test_validateNumberGreaterThanOrEqualBoundary__2049 = function()
  temper.test('validateNumber greaterThanOrEqual boundary', function(test_474)
    local params__1066, t_475, t_476, cs__1067, t_477, fn__13255;
    params__1066 = temper.map_constructor(temper.listof(temper.pair_constructor('age', '18')));
    t_475 = userTable__637();
    t_476 = csid__636('age');
    cs__1067 = changeset(t_475, params__1066):cast(temper.listof(t_476)):validateNumber(csid__636('age'), NumberValidationOpts(temper.null, temper.null, 18.0, temper.null, temper.null));
    t_477 = cs__1067.isValid;
    fn__13255 = function()
      return '18 >= 18 should pass';
    end;
    temper.test_assert(test_474, t_477, fn__13255);
    return nil;
  end);
end;
Test_.test_validateNumberCombinedOptions__2050 = function()
  temper.test('validateNumber combined options', function(test_478)
    local params__1069, t_479, t_480, cs__1070, t_481, fn__13243;
    params__1069 = temper.map_constructor(temper.listof(temper.pair_constructor('score', '5.0')));
    t_479 = userTable__637();
    t_480 = csid__636('score');
    cs__1070 = changeset(t_479, params__1069):cast(temper.listof(t_480)):validateNumber(csid__636('score'), NumberValidationOpts(0.0, 10.0, temper.null, temper.null, temper.null));
    t_481 = cs__1070.isValid;
    fn__13243 = function()
      return '5 > 0 and < 10 should pass';
    end;
    temper.test_assert(test_478, t_481, fn__13243);
    return nil;
  end);
end;
Test_.test_validateNumberNonNumericValue__2051 = function()
  temper.test('validateNumber non-numeric value', function(test_482)
    local params__1072, t_483, t_484, cs__1073, t_485, fn__13224, t_486, fn__13223;
    params__1072 = temper.map_constructor(temper.listof(temper.pair_constructor('age', 'abc')));
    t_483 = userTable__637();
    t_484 = csid__636('age');
    cs__1073 = changeset(t_483, params__1072):cast(temper.listof(t_484)):validateNumber(csid__636('age'), NumberValidationOpts(0.0, temper.null, temper.null, temper.null, temper.null));
    t_485 = not cs__1073.isValid;
    fn__13224 = function()
      return 'non-numeric should fail';
    end;
    temper.test_assert(test_482, t_485, fn__13224);
    t_486 = temper.str_eq((temper.list_get(cs__1073.errors, 0)).message, 'must be a number');
    fn__13223 = function()
      return 'correct error message';
    end;
    temper.test_assert(test_482, t_486, fn__13223);
    return nil;
  end);
end;
Test_.test_validateNumberSkipsWhenFieldNotInChanges__2052 = function()
  temper.test('validateNumber skips when field not in changes', function(test_487)
    local params__1075, t_488, t_489, cs__1076, t_490, fn__13212;
    params__1075 = temper.map_constructor(temper.listof());
    t_488 = userTable__637();
    t_489 = csid__636('age');
    cs__1076 = changeset(t_488, params__1075):cast(temper.listof(t_489)):validateNumber(csid__636('age'), NumberValidationOpts(0.0, temper.null, temper.null, temper.null, temper.null));
    t_490 = cs__1076.isValid;
    fn__13212 = function()
      return 'should be valid when field absent';
    end;
    temper.test_assert(test_487, t_490, fn__13212);
    return nil;
  end);
end;
Test_.test_validateAcceptancePassesForTrueValues__2053 = function()
  temper.test('validateAcceptance passes for true values', function(test_491)
    local fn__13209;
    fn__13209 = function(v__1078)
      local params__1079, t_492, t_493, cs__1080, t_494, fn__13198;
      params__1079 = temper.map_constructor(temper.listof(temper.pair_constructor('active', v__1078)));
      t_492 = userTable__637();
      t_493 = csid__636('active');
      cs__1080 = changeset(t_492, params__1079):cast(temper.listof(t_493)):validateAcceptance(csid__636('active'));
      t_494 = cs__1080.isValid;
      fn__13198 = function()
        return temper.concat('should accept: ', v__1078);
      end;
      temper.test_assert(test_491, t_494, fn__13198);
      return nil;
    end;
    temper.list_foreach(temper.listof('true', '1', 'yes', 'on'), fn__13209);
    return nil;
  end);
end;
Test_.test_validateAcceptanceFailsForNonTrueValues__2054 = function()
  temper.test('validateAcceptance fails for non-true values', function(test_495)
    local params__1082, t_496, t_497, cs__1083, t_498, fn__13180, t_499, fn__13179;
    params__1082 = temper.map_constructor(temper.listof(temper.pair_constructor('active', 'false')));
    t_496 = userTable__637();
    t_497 = csid__636('active');
    cs__1083 = changeset(t_496, params__1082):cast(temper.listof(t_497)):validateAcceptance(csid__636('active'));
    t_498 = not cs__1083.isValid;
    fn__13180 = function()
      return 'false should not be accepted';
    end;
    temper.test_assert(test_495, t_498, fn__13180);
    t_499 = temper.str_eq((temper.list_get(cs__1083.errors, 0)).message, 'must be accepted');
    fn__13179 = function()
      return 'correct message';
    end;
    temper.test_assert(test_495, t_499, fn__13179);
    return nil;
  end);
end;
Test_.test_validateConfirmationPassesWhenFieldsMatch__2055 = function()
  temper.test('validateConfirmation passes when fields match', function(test_500)
    local tbl__1085, params__1086, t_501, t_502, cs__1087, t_503, fn__13158;
    tbl__1085 = TableDef(csid__636('users'), temper.listof(FieldDef(csid__636('password'), StringField(), false), FieldDef(csid__636('password_confirmation'), StringField(), true)));
    params__1086 = temper.map_constructor(temper.listof(temper.pair_constructor('password', 'secret123'), temper.pair_constructor('password_confirmation', 'secret123')));
    t_501 = csid__636('password');
    t_502 = csid__636('password_confirmation');
    cs__1087 = changeset(tbl__1085, params__1086):cast(temper.listof(t_501, t_502)):validateConfirmation(csid__636('password'), csid__636('password_confirmation'));
    t_503 = cs__1087.isValid;
    fn__13158 = function()
      return 'matching fields should pass';
    end;
    temper.test_assert(test_500, t_503, fn__13158);
    return nil;
  end);
end;
Test_.test_validateConfirmationFailsWhenFieldsDiffer__2056 = function()
  temper.test('validateConfirmation fails when fields differ', function(test_504)
    local tbl__1089, params__1090, t_505, t_506, cs__1091, t_507, fn__13130, t_508, fn__13129;
    tbl__1089 = TableDef(csid__636('users'), temper.listof(FieldDef(csid__636('password'), StringField(), false), FieldDef(csid__636('password_confirmation'), StringField(), true)));
    params__1090 = temper.map_constructor(temper.listof(temper.pair_constructor('password', 'secret123'), temper.pair_constructor('password_confirmation', 'wrong456')));
    t_505 = csid__636('password');
    t_506 = csid__636('password_confirmation');
    cs__1091 = changeset(tbl__1089, params__1090):cast(temper.listof(t_505, t_506)):validateConfirmation(csid__636('password'), csid__636('password_confirmation'));
    t_507 = not cs__1091.isValid;
    fn__13130 = function()
      return 'mismatched fields should fail';
    end;
    temper.test_assert(test_504, t_507, fn__13130);
    t_508 = temper.str_eq((temper.list_get(cs__1091.errors, 0)).field, 'password_confirmation');
    fn__13129 = function()
      return 'error on confirmation field';
    end;
    temper.test_assert(test_504, t_508, fn__13129);
    return nil;
  end);
end;
Test_.test_validateConfirmationFailsWhenConfirmationMissing__2057 = function()
  temper.test('validateConfirmation fails when confirmation missing', function(test_509)
    local tbl__1093, params__1094, t_510, cs__1095, t_511, fn__13109;
    tbl__1093 = TableDef(csid__636('users'), temper.listof(FieldDef(csid__636('password'), StringField(), false), FieldDef(csid__636('password_confirmation'), StringField(), true)));
    params__1094 = temper.map_constructor(temper.listof(temper.pair_constructor('password', 'secret123')));
    t_510 = csid__636('password');
    cs__1095 = changeset(tbl__1093, params__1094):cast(temper.listof(t_510)):validateConfirmation(csid__636('password'), csid__636('password_confirmation'));
    t_511 = not cs__1095.isValid;
    fn__13109 = function()
      return 'missing confirmation should fail';
    end;
    temper.test_assert(test_509, t_511, fn__13109);
    return nil;
  end);
end;
Test_.test_validateContainsPassesWhenSubstringFound__2058 = function()
  temper.test('validateContains passes when substring found', function(test_512)
    local params__1097, t_513, t_514, cs__1098, t_515, fn__13098;
    params__1097 = temper.map_constructor(temper.listof(temper.pair_constructor('email', 'alice@example.com')));
    t_513 = userTable__637();
    t_514 = csid__636('email');
    cs__1098 = changeset(t_513, params__1097):cast(temper.listof(t_514)):validateContains(csid__636('email'), '@');
    t_515 = cs__1098.isValid;
    fn__13098 = function()
      return 'should pass when @ present';
    end;
    temper.test_assert(test_512, t_515, fn__13098);
    return nil;
  end);
end;
Test_.test_validateContainsFailsWhenSubstringNotFound__2059 = function()
  temper.test('validateContains fails when substring not found', function(test_516)
    local params__1100, t_517, t_518, cs__1101, t_519, fn__13086;
    params__1100 = temper.map_constructor(temper.listof(temper.pair_constructor('email', 'alice-example.com')));
    t_517 = userTable__637();
    t_518 = csid__636('email');
    cs__1101 = changeset(t_517, params__1100):cast(temper.listof(t_518)):validateContains(csid__636('email'), '@');
    t_519 = not cs__1101.isValid;
    fn__13086 = function()
      return 'should fail when @ absent';
    end;
    temper.test_assert(test_516, t_519, fn__13086);
    return nil;
  end);
end;
Test_.test_validateContainsSkipsWhenFieldNotInChanges__2060 = function()
  temper.test('validateContains skips when field not in changes', function(test_520)
    local params__1103, t_521, t_522, cs__1104, t_523, fn__13076;
    params__1103 = temper.map_constructor(temper.listof());
    t_521 = userTable__637();
    t_522 = csid__636('email');
    cs__1104 = changeset(t_521, params__1103):cast(temper.listof(t_522)):validateContains(csid__636('email'), '@');
    t_523 = cs__1104.isValid;
    fn__13076 = function()
      return 'should be valid when field absent';
    end;
    temper.test_assert(test_520, t_523, fn__13076);
    return nil;
  end);
end;
Test_.test_validateStartsWithPasses__2061 = function()
  temper.test('validateStartsWith passes', function(test_524)
    local params__1106, t_525, t_526, cs__1107, t_527, fn__13065;
    params__1106 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Dr. Smith')));
    t_525 = userTable__637();
    t_526 = csid__636('name');
    cs__1107 = changeset(t_525, params__1106):cast(temper.listof(t_526)):validateStartsWith(csid__636('name'), 'Dr.');
    t_527 = cs__1107.isValid;
    fn__13065 = function()
      return 'should pass for Dr. prefix';
    end;
    temper.test_assert(test_524, t_527, fn__13065);
    return nil;
  end);
end;
Test_.test_validateStartsWithFails__2062 = function()
  temper.test('validateStartsWith fails', function(test_528)
    local params__1109, t_529, t_530, cs__1110, t_531, fn__13053;
    params__1109 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Mr. Smith')));
    t_529 = userTable__637();
    t_530 = csid__636('name');
    cs__1110 = changeset(t_529, params__1109):cast(temper.listof(t_530)):validateStartsWith(csid__636('name'), 'Dr.');
    t_531 = not cs__1110.isValid;
    fn__13053 = function()
      return 'should fail for Mr. prefix';
    end;
    temper.test_assert(test_528, t_531, fn__13053);
    return nil;
  end);
end;
Test_.test_validateEndsWithPasses__2063 = function()
  temper.test('validateEndsWith passes', function(test_532)
    local params__1112, t_533, t_534, cs__1113, t_535, fn__13042;
    params__1112 = temper.map_constructor(temper.listof(temper.pair_constructor('email', 'alice@example.com')));
    t_533 = userTable__637();
    t_534 = csid__636('email');
    cs__1113 = changeset(t_533, params__1112):cast(temper.listof(t_534)):validateEndsWith(csid__636('email'), '.com');
    t_535 = cs__1113.isValid;
    fn__13042 = function()
      return 'should pass for .com suffix';
    end;
    temper.test_assert(test_532, t_535, fn__13042);
    return nil;
  end);
end;
Test_.test_validateEndsWithFails__2064 = function()
  temper.test('validateEndsWith fails', function(test_536)
    local params__1115, t_537, t_538, cs__1116, t_539, fn__13030;
    params__1115 = temper.map_constructor(temper.listof(temper.pair_constructor('email', 'alice@example.org')));
    t_537 = userTable__637();
    t_538 = csid__636('email');
    cs__1116 = changeset(t_537, params__1115):cast(temper.listof(t_538)):validateEndsWith(csid__636('email'), '.com');
    t_539 = not cs__1116.isValid;
    fn__13030 = function()
      return 'should fail for .org when expecting .com';
    end;
    temper.test_assert(test_536, t_539, fn__13030);
    return nil;
  end);
end;
Test_.test_validateEndsWithHandlesRepeatedSuffixCorrectly__2065 = function()
  temper.test('validateEndsWith handles repeated suffix correctly', function(test_540)
    local params__1118, t_541, t_542, cs__1119, t_543, fn__13019;
    params__1118 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'abcabc')));
    t_541 = userTable__637();
    t_542 = csid__636('name');
    cs__1119 = changeset(t_541, params__1118):cast(temper.listof(t_542)):validateEndsWith(csid__636('name'), 'abc');
    t_543 = cs__1119.isValid;
    fn__13019 = function()
      return 'abcabc should end with abc';
    end;
    temper.test_assert(test_540, t_543, fn__13019);
    return nil;
  end);
end;
sid__638 = function(name__1464)
  local return__557, t_544, local_545, local_546, local_547;
  local_545, local_546, local_547 = temper.pcall(function()
    t_544 = safeIdentifier(name__1464);
    return__557 = t_544;
  end);
  if local_545 then
  else
    return__557 = temper.bubble();
  end
  return return__557;
end;
Test_.test_bareFromProducesSelect__2147 = function()
  temper.test('bare from produces SELECT *', function(test_549)
    local q__1467, t_550, fn__12499;
    q__1467 = from(sid__638('users'));
    t_550 = temper.str_eq(q__1467:toSql():toString(), 'SELECT * FROM users');
    fn__12499 = function()
      return 'bare query';
    end;
    temper.test_assert(test_549, t_550, fn__12499);
    return nil;
  end);
end;
Test_.test_selectRestrictsColumns__2148 = function()
  temper.test('select restricts columns', function(test_551)
    local t_552, t_553, t_554, q__1469, t_555, fn__12489;
    t_552 = sid__638('users');
    t_553 = sid__638('id');
    t_554 = sid__638('name');
    q__1469 = from(t_552):select(temper.listof(t_553, t_554));
    t_555 = temper.str_eq(q__1469:toSql():toString(), 'SELECT id, name FROM users');
    fn__12489 = function()
      return 'select columns';
    end;
    temper.test_assert(test_551, t_555, fn__12489);
    return nil;
  end);
end;
Test_.test_whereAddsConditionWithIntValue__2149 = function()
  temper.test('where adds condition with int value', function(test_556)
    local t_557, t_558, t_559, q__1471, t_560, fn__12477;
    t_557 = sid__638('users');
    t_558 = SqlBuilder();
    t_558:appendSafe('age > ');
    t_558:appendInt32(18);
    t_559 = t_558.accumulated;
    q__1471 = from(t_557):where(t_559);
    t_560 = temper.str_eq(q__1471:toSql():toString(), 'SELECT * FROM users WHERE age > 18');
    fn__12477 = function()
      return 'where int';
    end;
    temper.test_assert(test_556, t_560, fn__12477);
    return nil;
  end);
end;
Test_.test_whereAddsConditionWithBoolValue__2151 = function()
  temper.test('where adds condition with bool value', function(test_561)
    local t_562, t_563, t_564, q__1473, t_565, fn__12465;
    t_562 = sid__638('users');
    t_563 = SqlBuilder();
    t_563:appendSafe('active = ');
    t_563:appendBoolean(true);
    t_564 = t_563.accumulated;
    q__1473 = from(t_562):where(t_564);
    t_565 = temper.str_eq(q__1473:toSql():toString(), 'SELECT * FROM users WHERE active = TRUE');
    fn__12465 = function()
      return 'where bool';
    end;
    temper.test_assert(test_561, t_565, fn__12465);
    return nil;
  end);
end;
Test_.test_chainedWhereUsesAnd__2153 = function()
  temper.test('chained where uses AND', function(test_566)
    local t_567, t_568, t_569, t_570, t_571, q__1475, t_572, fn__12448;
    t_567 = sid__638('users');
    t_568 = SqlBuilder();
    t_568:appendSafe('age > ');
    t_568:appendInt32(18);
    t_569 = t_568.accumulated;
    t_570 = from(t_567):where(t_569);
    t_571 = SqlBuilder();
    t_571:appendSafe('active = ');
    t_571:appendBoolean(true);
    q__1475 = t_570:where(t_571.accumulated);
    t_572 = temper.str_eq(q__1475:toSql():toString(), 'SELECT * FROM users WHERE age > 18 AND active = TRUE');
    fn__12448 = function()
      return 'chained where';
    end;
    temper.test_assert(test_566, t_572, fn__12448);
    return nil;
  end);
end;
Test_.test_orderByAsc__2156 = function()
  temper.test('orderBy ASC', function(test_573)
    local t_574, t_575, q__1477, t_576, fn__12439;
    t_574 = sid__638('users');
    t_575 = sid__638('name');
    q__1477 = from(t_574):orderBy(t_575, true);
    t_576 = temper.str_eq(q__1477:toSql():toString(), 'SELECT * FROM users ORDER BY name ASC');
    fn__12439 = function()
      return 'order asc';
    end;
    temper.test_assert(test_573, t_576, fn__12439);
    return nil;
  end);
end;
Test_.test_orderByDesc__2157 = function()
  temper.test('orderBy DESC', function(test_577)
    local t_578, t_579, q__1479, t_580, fn__12430;
    t_578 = sid__638('users');
    t_579 = sid__638('created_at');
    q__1479 = from(t_578):orderBy(t_579, false);
    t_580 = temper.str_eq(q__1479:toSql():toString(), 'SELECT * FROM users ORDER BY created_at DESC');
    fn__12430 = function()
      return 'order desc';
    end;
    temper.test_assert(test_577, t_580, fn__12430);
    return nil;
  end);
end;
Test_.test_limitAndOffset__2158 = function()
  temper.test('limit and offset', function(test_581)
    local t_582, t_583, q__1481, local_584, local_585, local_586, t_588, fn__12423;
    local_584, local_585, local_586 = temper.pcall(function()
      t_582 = from(sid__638('users')):limit(10);
      t_583 = t_582:offset(20);
      q__1481 = t_583;
    end);
    if local_584 then
    else
      q__1481 = temper.bubble();
    end
    t_588 = temper.str_eq(q__1481:toSql():toString(), 'SELECT * FROM users LIMIT 10 OFFSET 20');
    fn__12423 = function()
      return 'limit/offset';
    end;
    temper.test_assert(test_581, t_588, fn__12423);
    return nil;
  end);
end;
Test_.test_limitBubblesOnNegative__2159 = function()
  temper.test('limit bubbles on negative', function(test_589)
    local didBubble__1483, local_590, local_591, local_592, fn__12419;
    local_590, local_591, local_592 = temper.pcall(function()
      from(sid__638('users')):limit(-1);
      didBubble__1483 = false;
    end);
    if local_590 then
    else
      didBubble__1483 = true;
    end
    fn__12419 = function()
      return 'negative limit should bubble';
    end;
    temper.test_assert(test_589, didBubble__1483, fn__12419);
    return nil;
  end);
end;
Test_.test_offsetBubblesOnNegative__2160 = function()
  temper.test('offset bubbles on negative', function(test_594)
    local didBubble__1485, local_595, local_596, local_597, fn__12415;
    local_595, local_596, local_597 = temper.pcall(function()
      from(sid__638('users')):offset(-1);
      didBubble__1485 = false;
    end);
    if local_595 then
    else
      didBubble__1485 = true;
    end
    fn__12415 = function()
      return 'negative offset should bubble';
    end;
    temper.test_assert(test_594, didBubble__1485, fn__12415);
    return nil;
  end);
end;
Test_.test_complexComposedQuery__2161 = function()
  temper.test('complex composed query', function(test_599)
    local t_600, t_601, t_602, t_603, t_604, t_605, t_606, t_607, t_608, t_609, minAge__1487, q__1488, local_610, local_611, local_612, t_614, fn__12392;
    minAge__1487 = 21;
    local_610, local_611, local_612 = temper.pcall(function()
      t_600 = sid__638('users');
      t_601 = sid__638('id');
      t_602 = sid__638('name');
      t_603 = sid__638('email');
      t_604 = from(t_600):select(temper.listof(t_601, t_602, t_603));
      t_605 = SqlBuilder();
      t_605:appendSafe('age >= ');
      t_605:appendInt32(21);
      t_606 = t_604:where(t_605.accumulated);
      t_607 = SqlBuilder();
      t_607:appendSafe('active = ');
      t_607:appendBoolean(true);
      t_608 = t_606:where(t_607.accumulated):orderBy(sid__638('name'), true):limit(25);
      t_609 = t_608:offset(0);
      q__1488 = t_609;
    end);
    if local_610 then
    else
      q__1488 = temper.bubble();
    end
    t_614 = temper.str_eq(q__1488:toSql():toString(), 'SELECT id, name, email FROM users WHERE age >= 21 AND active = TRUE ORDER BY name ASC LIMIT 25 OFFSET 0');
    fn__12392 = function()
      return 'complex query';
    end;
    temper.test_assert(test_599, t_614, fn__12392);
    return nil;
  end);
end;
Test_.test_safeToSqlAppliesDefaultLimitWhenNoneSet__2164 = function()
  temper.test('safeToSql applies default limit when none set', function(test_615)
    local t_616, t_617, q__1490, local_618, local_619, local_620, s__1491, t_622, fn__12386;
    q__1490 = from(sid__638('users'));
    local_618, local_619, local_620 = temper.pcall(function()
      t_616 = q__1490:safeToSql(100);
      t_617 = t_616;
    end);
    if local_618 then
    else
      t_617 = temper.bubble();
    end
    s__1491 = t_617:toString();
    t_622 = temper.str_eq(s__1491, 'SELECT * FROM users LIMIT 100');
    fn__12386 = function()
      return temper.concat('should have limit: ', s__1491);
    end;
    temper.test_assert(test_615, t_622, fn__12386);
    return nil;
  end);
end;
Test_.test_safeToSqlRespectsExplicitLimit__2165 = function()
  temper.test('safeToSql respects explicit limit', function(test_623)
    local t_624, t_625, t_626, q__1493, local_627, local_628, local_629, local_631, local_632, local_633, s__1494, t_635, fn__12380;
    local_627, local_628, local_629 = temper.pcall(function()
      t_624 = from(sid__638('users')):limit(5);
      q__1493 = t_624;
    end);
    if local_627 then
    else
      q__1493 = temper.bubble();
    end
    local_631, local_632, local_633 = temper.pcall(function()
      t_625 = q__1493:safeToSql(100);
      t_626 = t_625;
    end);
    if local_631 then
    else
      t_626 = temper.bubble();
    end
    s__1494 = t_626:toString();
    t_635 = temper.str_eq(s__1494, 'SELECT * FROM users LIMIT 5');
    fn__12380 = function()
      return temper.concat('explicit limit preserved: ', s__1494);
    end;
    temper.test_assert(test_623, t_635, fn__12380);
    return nil;
  end);
end;
Test_.test_safeToSqlBubblesOnNegativeDefaultLimit__2166 = function()
  temper.test('safeToSql bubbles on negative defaultLimit', function(test_636)
    local didBubble__1496, local_637, local_638, local_639, fn__12376;
    local_637, local_638, local_639 = temper.pcall(function()
      from(sid__638('users')):safeToSql(-1);
      didBubble__1496 = false;
    end);
    if local_637 then
    else
      didBubble__1496 = true;
    end
    fn__12376 = function()
      return 'negative defaultLimit should bubble';
    end;
    temper.test_assert(test_636, didBubble__1496, fn__12376);
    return nil;
  end);
end;
Test_.test_whereWithInjectionAttemptInStringValueIsEscaped__2167 = function()
  temper.test('where with injection attempt in string value is escaped', function(test_641)
    local evil__1498, t_642, t_643, t_644, q__1499, s__1500, t_645, fn__12359, t_646, fn__12358;
    evil__1498 = "'; DROP TABLE users; --";
    t_642 = sid__638('users');
    t_643 = SqlBuilder();
    t_643:appendSafe('name = ');
    t_643:appendString("'; DROP TABLE users; --");
    t_644 = t_643.accumulated;
    q__1499 = from(t_642):where(t_644);
    s__1500 = q__1499:toSql():toString();
    t_645 = temper.is_string_index(temper.string_indexof(s__1500, "''"));
    fn__12359 = function()
      return temper.concat('quotes must be doubled: ', s__1500);
    end;
    temper.test_assert(test_641, t_645, fn__12359);
    t_646 = temper.is_string_index(temper.string_indexof(s__1500, 'SELECT * FROM users WHERE name ='));
    fn__12358 = function()
      return temper.concat('structure intact: ', s__1500);
    end;
    temper.test_assert(test_641, t_646, fn__12358);
    return nil;
  end);
end;
Test_.test_safeIdentifierRejectsUserSuppliedTableNameWithMetacharacters__2169 = function()
  temper.test('safeIdentifier rejects user-supplied table name with metacharacters', function(test_647)
    local attack__1502, didBubble__1503, local_648, local_649, local_650, fn__12355;
    attack__1502 = 'users; DROP TABLE users; --';
    local_648, local_649, local_650 = temper.pcall(function()
      safeIdentifier('users; DROP TABLE users; --');
      didBubble__1503 = false;
    end);
    if local_648 then
    else
      didBubble__1503 = true;
    end
    fn__12355 = function()
      return 'metacharacter-containing name must be rejected at construction';
    end;
    temper.test_assert(test_647, didBubble__1503, fn__12355);
    return nil;
  end);
end;
Test_.test_innerJoinProducesInnerJoin__2170 = function()
  temper.test('innerJoin produces INNER JOIN', function(test_652)
    local t_653, t_654, t_655, t_656, q__1505, t_657, fn__12343;
    t_653 = sid__638('users');
    t_654 = sid__638('orders');
    t_655 = SqlBuilder();
    t_655:appendSafe('users.id = orders.user_id');
    t_656 = t_655.accumulated;
    q__1505 = from(t_653):innerJoin(t_654, t_656);
    t_657 = temper.str_eq(q__1505:toSql():toString(), 'SELECT * FROM users INNER JOIN orders ON users.id = orders.user_id');
    fn__12343 = function()
      return 'inner join';
    end;
    temper.test_assert(test_652, t_657, fn__12343);
    return nil;
  end);
end;
Test_.test_leftJoinProducesLeftJoin__2172 = function()
  temper.test('leftJoin produces LEFT JOIN', function(test_658)
    local t_659, t_660, t_661, t_662, q__1507, t_663, fn__12331;
    t_659 = sid__638('users');
    t_660 = sid__638('profiles');
    t_661 = SqlBuilder();
    t_661:appendSafe('users.id = profiles.user_id');
    t_662 = t_661.accumulated;
    q__1507 = from(t_659):leftJoin(t_660, t_662);
    t_663 = temper.str_eq(q__1507:toSql():toString(), 'SELECT * FROM users LEFT JOIN profiles ON users.id = profiles.user_id');
    fn__12331 = function()
      return 'left join';
    end;
    temper.test_assert(test_658, t_663, fn__12331);
    return nil;
  end);
end;
Test_.test_rightJoinProducesRightJoin__2174 = function()
  temper.test('rightJoin produces RIGHT JOIN', function(test_664)
    local t_665, t_666, t_667, t_668, q__1509, t_669, fn__12319;
    t_665 = sid__638('orders');
    t_666 = sid__638('users');
    t_667 = SqlBuilder();
    t_667:appendSafe('orders.user_id = users.id');
    t_668 = t_667.accumulated;
    q__1509 = from(t_665):rightJoin(t_666, t_668);
    t_669 = temper.str_eq(q__1509:toSql():toString(), 'SELECT * FROM orders RIGHT JOIN users ON orders.user_id = users.id');
    fn__12319 = function()
      return 'right join';
    end;
    temper.test_assert(test_664, t_669, fn__12319);
    return nil;
  end);
end;
Test_.test_fullJoinProducesFullOuterJoin__2176 = function()
  temper.test('fullJoin produces FULL OUTER JOIN', function(test_670)
    local t_671, t_672, t_673, t_674, q__1511, t_675, fn__12307;
    t_671 = sid__638('users');
    t_672 = sid__638('orders');
    t_673 = SqlBuilder();
    t_673:appendSafe('users.id = orders.user_id');
    t_674 = t_673.accumulated;
    q__1511 = from(t_671):fullJoin(t_672, t_674);
    t_675 = temper.str_eq(q__1511:toSql():toString(), 'SELECT * FROM users FULL OUTER JOIN orders ON users.id = orders.user_id');
    fn__12307 = function()
      return 'full join';
    end;
    temper.test_assert(test_670, t_675, fn__12307);
    return nil;
  end);
end;
Test_.test_chainedJoins__2178 = function()
  temper.test('chained joins', function(test_676)
    local t_677, t_678, t_679, t_680, t_681, t_682, t_683, q__1513, t_684, fn__12290;
    t_677 = sid__638('users');
    t_678 = sid__638('orders');
    t_679 = SqlBuilder();
    t_679:appendSafe('users.id = orders.user_id');
    t_680 = t_679.accumulated;
    t_681 = from(t_677):innerJoin(t_678, t_680);
    t_682 = sid__638('profiles');
    t_683 = SqlBuilder();
    t_683:appendSafe('users.id = profiles.user_id');
    q__1513 = t_681:leftJoin(t_682, t_683.accumulated);
    t_684 = temper.str_eq(q__1513:toSql():toString(), 'SELECT * FROM users INNER JOIN orders ON users.id = orders.user_id LEFT JOIN profiles ON users.id = profiles.user_id');
    fn__12290 = function()
      return 'chained joins';
    end;
    temper.test_assert(test_676, t_684, fn__12290);
    return nil;
  end);
end;
Test_.test_joinWithWhereAndOrderBy__2181 = function()
  temper.test('join with where and orderBy', function(test_685)
    local t_686, t_687, t_688, t_689, t_690, t_691, t_692, q__1515, local_693, local_694, local_695, t_697, fn__12271;
    local_693, local_694, local_695 = temper.pcall(function()
      t_686 = sid__638('users');
      t_687 = sid__638('orders');
      t_688 = SqlBuilder();
      t_688:appendSafe('users.id = orders.user_id');
      t_689 = t_688.accumulated;
      t_690 = from(t_686):innerJoin(t_687, t_689);
      t_691 = SqlBuilder();
      t_691:appendSafe('orders.total > ');
      t_691:appendInt32(100);
      t_692 = t_690:where(t_691.accumulated):orderBy(sid__638('name'), true):limit(10);
      q__1515 = t_692;
    end);
    if local_693 then
    else
      q__1515 = temper.bubble();
    end
    t_697 = temper.str_eq(q__1515:toSql():toString(), 'SELECT * FROM users INNER JOIN orders ON users.id = orders.user_id WHERE orders.total > 100 ORDER BY name ASC LIMIT 10');
    fn__12271 = function()
      return 'join with where/order/limit';
    end;
    temper.test_assert(test_685, t_697, fn__12271);
    return nil;
  end);
end;
Test_.test_colHelperProducesQualifiedReference__2184 = function()
  temper.test('col helper produces qualified reference', function(test_698)
    local c__1517, t_699, fn__12263;
    c__1517 = col(sid__638('users'), sid__638('id'));
    t_699 = temper.str_eq(c__1517:toString(), 'users.id');
    fn__12263 = function()
      return 'col helper';
    end;
    temper.test_assert(test_698, t_699, fn__12263);
    return nil;
  end);
end;
Test_.test_joinWithColHelper__2185 = function()
  temper.test('join with col helper', function(test_700)
    local onCond__1519, b__1520, t_701, t_702, t_703, q__1521, t_704, fn__12243;
    onCond__1519 = col(sid__638('users'), sid__638('id'));
    b__1520 = SqlBuilder();
    b__1520:appendFragment(onCond__1519);
    b__1520:appendSafe(' = ');
    b__1520:appendFragment(col(sid__638('orders'), sid__638('user_id')));
    t_701 = sid__638('users');
    t_702 = sid__638('orders');
    t_703 = b__1520.accumulated;
    q__1521 = from(t_701):innerJoin(t_702, t_703);
    t_704 = temper.str_eq(q__1521:toSql():toString(), 'SELECT * FROM users INNER JOIN orders ON users.id = orders.user_id');
    fn__12243 = function()
      return 'join with col';
    end;
    temper.test_assert(test_700, t_704, fn__12243);
    return nil;
  end);
end;
Test_.test_orWhereBasic__2186 = function()
  temper.test('orWhere basic', function(test_705)
    local t_706, t_707, t_708, q__1523, t_709, fn__12231;
    t_706 = sid__638('users');
    t_707 = SqlBuilder();
    t_707:appendSafe('status = ');
    t_707:appendString('active');
    t_708 = t_707.accumulated;
    q__1523 = from(t_706):orWhere(t_708);
    t_709 = temper.str_eq(q__1523:toSql():toString(), "SELECT * FROM users WHERE status = 'active'");
    fn__12231 = function()
      return 'orWhere basic';
    end;
    temper.test_assert(test_705, t_709, fn__12231);
    return nil;
  end);
end;
Test_.test_whereThenOrWhere__2188 = function()
  temper.test('where then orWhere', function(test_710)
    local t_711, t_712, t_713, t_714, t_715, q__1525, t_716, fn__12214;
    t_711 = sid__638('users');
    t_712 = SqlBuilder();
    t_712:appendSafe('age > ');
    t_712:appendInt32(18);
    t_713 = t_712.accumulated;
    t_714 = from(t_711):where(t_713);
    t_715 = SqlBuilder();
    t_715:appendSafe('vip = ');
    t_715:appendBoolean(true);
    q__1525 = t_714:orWhere(t_715.accumulated);
    t_716 = temper.str_eq(q__1525:toSql():toString(), 'SELECT * FROM users WHERE age > 18 OR vip = TRUE');
    fn__12214 = function()
      return 'where then orWhere';
    end;
    temper.test_assert(test_710, t_716, fn__12214);
    return nil;
  end);
end;
Test_.test_multipleOrWhere__2191 = function()
  temper.test('multiple orWhere', function(test_717)
    local t_718, t_719, t_720, t_721, t_722, t_723, t_724, q__1527, t_725, fn__12192;
    t_718 = sid__638('users');
    t_719 = SqlBuilder();
    t_719:appendSafe('active = ');
    t_719:appendBoolean(true);
    t_720 = t_719.accumulated;
    t_721 = from(t_718):where(t_720);
    t_722 = SqlBuilder();
    t_722:appendSafe('role = ');
    t_722:appendString('admin');
    t_723 = t_721:orWhere(t_722.accumulated);
    t_724 = SqlBuilder();
    t_724:appendSafe('role = ');
    t_724:appendString('moderator');
    q__1527 = t_723:orWhere(t_724.accumulated);
    t_725 = temper.str_eq(q__1527:toSql():toString(), "SELECT * FROM users WHERE active = TRUE OR role = 'admin' OR role = 'moderator'");
    fn__12192 = function()
      return 'multiple orWhere';
    end;
    temper.test_assert(test_717, t_725, fn__12192);
    return nil;
  end);
end;
Test_.test_mixedWhereAndOrWhere__2195 = function()
  temper.test('mixed where and orWhere', function(test_726)
    local t_727, t_728, t_729, t_730, t_731, t_732, t_733, q__1529, t_734, fn__12170;
    t_727 = sid__638('users');
    t_728 = SqlBuilder();
    t_728:appendSafe('age > ');
    t_728:appendInt32(18);
    t_729 = t_728.accumulated;
    t_730 = from(t_727):where(t_729);
    t_731 = SqlBuilder();
    t_731:appendSafe('active = ');
    t_731:appendBoolean(true);
    t_732 = t_730:where(t_731.accumulated);
    t_733 = SqlBuilder();
    t_733:appendSafe('vip = ');
    t_733:appendBoolean(true);
    q__1529 = t_732:orWhere(t_733.accumulated);
    t_734 = temper.str_eq(q__1529:toSql():toString(), 'SELECT * FROM users WHERE age > 18 AND active = TRUE OR vip = TRUE');
    fn__12170 = function()
      return 'mixed where and orWhere';
    end;
    temper.test_assert(test_726, t_734, fn__12170);
    return nil;
  end);
end;
Test_.test_whereNull__2199 = function()
  temper.test('whereNull', function(test_735)
    local t_736, t_737, q__1531, t_738, fn__12161;
    t_736 = sid__638('users');
    t_737 = sid__638('deleted_at');
    q__1531 = from(t_736):whereNull(t_737);
    t_738 = temper.str_eq(q__1531:toSql():toString(), 'SELECT * FROM users WHERE deleted_at IS NULL');
    fn__12161 = function()
      return 'whereNull';
    end;
    temper.test_assert(test_735, t_738, fn__12161);
    return nil;
  end);
end;
Test_.test_whereNotNull__2200 = function()
  temper.test('whereNotNull', function(test_739)
    local t_740, t_741, q__1533, t_742, fn__12152;
    t_740 = sid__638('users');
    t_741 = sid__638('email');
    q__1533 = from(t_740):whereNotNull(t_741);
    t_742 = temper.str_eq(q__1533:toSql():toString(), 'SELECT * FROM users WHERE email IS NOT NULL');
    fn__12152 = function()
      return 'whereNotNull';
    end;
    temper.test_assert(test_739, t_742, fn__12152);
    return nil;
  end);
end;
Test_.test_whereNullChainedWithWhere__2201 = function()
  temper.test('whereNull chained with where', function(test_743)
    local t_744, t_745, t_746, q__1535, t_747, fn__12138;
    t_744 = sid__638('users');
    t_745 = SqlBuilder();
    t_745:appendSafe('active = ');
    t_745:appendBoolean(true);
    t_746 = t_745.accumulated;
    q__1535 = from(t_744):where(t_746):whereNull(sid__638('deleted_at'));
    t_747 = temper.str_eq(q__1535:toSql():toString(), 'SELECT * FROM users WHERE active = TRUE AND deleted_at IS NULL');
    fn__12138 = function()
      return 'whereNull chained';
    end;
    temper.test_assert(test_743, t_747, fn__12138);
    return nil;
  end);
end;
Test_.test_whereNotNullChainedWithOrWhere__2203 = function()
  temper.test('whereNotNull chained with orWhere', function(test_748)
    local t_749, t_750, t_751, t_752, q__1537, t_753, fn__12124;
    t_749 = sid__638('users');
    t_750 = sid__638('deleted_at');
    t_751 = from(t_749):whereNull(t_750);
    t_752 = SqlBuilder();
    t_752:appendSafe('role = ');
    t_752:appendString('admin');
    q__1537 = t_751:orWhere(t_752.accumulated);
    t_753 = temper.str_eq(q__1537:toSql():toString(), "SELECT * FROM users WHERE deleted_at IS NULL OR role = 'admin'");
    fn__12124 = function()
      return 'whereNotNull with orWhere';
    end;
    temper.test_assert(test_748, t_753, fn__12124);
    return nil;
  end);
end;
Test_.test_whereInWithIntValues__2205 = function()
  temper.test('whereIn with int values', function(test_754)
    local t_755, t_756, t_757, t_758, t_759, q__1539, t_760, fn__12112;
    t_755 = sid__638('users');
    t_756 = sid__638('id');
    t_757 = SqlInt32(1);
    t_758 = SqlInt32(2);
    t_759 = SqlInt32(3);
    q__1539 = from(t_755):whereIn(t_756, temper.listof(t_757, t_758, t_759));
    t_760 = temper.str_eq(q__1539:toSql():toString(), 'SELECT * FROM users WHERE id IN (1, 2, 3)');
    fn__12112 = function()
      return 'whereIn ints';
    end;
    temper.test_assert(test_754, t_760, fn__12112);
    return nil;
  end);
end;
Test_.test_whereInWithStringValuesEscaping__2206 = function()
  temper.test('whereIn with string values escaping', function(test_761)
    local t_762, t_763, t_764, t_765, q__1541, t_766, fn__12101;
    t_762 = sid__638('users');
    t_763 = sid__638('name');
    t_764 = SqlString('Alice');
    t_765 = SqlString("Bob's");
    q__1541 = from(t_762):whereIn(t_763, temper.listof(t_764, t_765));
    t_766 = temper.str_eq(q__1541:toSql():toString(), "SELECT * FROM users WHERE name IN ('Alice', 'Bob''s')");
    fn__12101 = function()
      return 'whereIn strings';
    end;
    temper.test_assert(test_761, t_766, fn__12101);
    return nil;
  end);
end;
Test_.test_whereInWithEmptyListProduces1_0__2207 = function()
  temper.test('whereIn with empty list produces 1=0', function(test_767)
    local t_768, t_769, q__1543, t_770, fn__12092;
    t_768 = sid__638('users');
    t_769 = sid__638('id');
    q__1543 = from(t_768):whereIn(t_769, temper.listof());
    t_770 = temper.str_eq(q__1543:toSql():toString(), 'SELECT * FROM users WHERE 1 = 0');
    fn__12092 = function()
      return 'whereIn empty';
    end;
    temper.test_assert(test_767, t_770, fn__12092);
    return nil;
  end);
end;
Test_.test_whereInChained__2208 = function()
  temper.test('whereIn chained', function(test_771)
    local t_772, t_773, t_774, q__1545, t_775, fn__12076;
    t_772 = sid__638('users');
    t_773 = SqlBuilder();
    t_773:appendSafe('active = ');
    t_773:appendBoolean(true);
    t_774 = t_773.accumulated;
    q__1545 = from(t_772):where(t_774):whereIn(sid__638('role'), temper.listof(SqlString('admin'), SqlString('user')));
    t_775 = temper.str_eq(q__1545:toSql():toString(), "SELECT * FROM users WHERE active = TRUE AND role IN ('admin', 'user')");
    fn__12076 = function()
      return 'whereIn chained';
    end;
    temper.test_assert(test_771, t_775, fn__12076);
    return nil;
  end);
end;
Test_.test_whereInSingleElement__2210 = function()
  temper.test('whereIn single element', function(test_776)
    local t_777, t_778, t_779, q__1547, t_780, fn__12066;
    t_777 = sid__638('users');
    t_778 = sid__638('id');
    t_779 = SqlInt32(42);
    q__1547 = from(t_777):whereIn(t_778, temper.listof(t_779));
    t_780 = temper.str_eq(q__1547:toSql():toString(), 'SELECT * FROM users WHERE id IN (42)');
    fn__12066 = function()
      return 'whereIn single';
    end;
    temper.test_assert(test_776, t_780, fn__12066);
    return nil;
  end);
end;
Test_.test_whereNotBasic__2211 = function()
  temper.test('whereNot basic', function(test_781)
    local t_782, t_783, t_784, q__1549, t_785, fn__12054;
    t_782 = sid__638('users');
    t_783 = SqlBuilder();
    t_783:appendSafe('active = ');
    t_783:appendBoolean(true);
    t_784 = t_783.accumulated;
    q__1549 = from(t_782):whereNot(t_784);
    t_785 = temper.str_eq(q__1549:toSql():toString(), 'SELECT * FROM users WHERE NOT (active = TRUE)');
    fn__12054 = function()
      return 'whereNot';
    end;
    temper.test_assert(test_781, t_785, fn__12054);
    return nil;
  end);
end;
Test_.test_whereNotChained__2213 = function()
  temper.test('whereNot chained', function(test_786)
    local t_787, t_788, t_789, t_790, t_791, q__1551, t_792, fn__12037;
    t_787 = sid__638('users');
    t_788 = SqlBuilder();
    t_788:appendSafe('age > ');
    t_788:appendInt32(18);
    t_789 = t_788.accumulated;
    t_790 = from(t_787):where(t_789);
    t_791 = SqlBuilder();
    t_791:appendSafe('banned = ');
    t_791:appendBoolean(true);
    q__1551 = t_790:whereNot(t_791.accumulated);
    t_792 = temper.str_eq(q__1551:toSql():toString(), 'SELECT * FROM users WHERE age > 18 AND NOT (banned = TRUE)');
    fn__12037 = function()
      return 'whereNot chained';
    end;
    temper.test_assert(test_786, t_792, fn__12037);
    return nil;
  end);
end;
Test_.test_whereBetweenIntegers__2216 = function()
  temper.test('whereBetween integers', function(test_793)
    local t_794, t_795, t_796, t_797, q__1553, t_798, fn__12026;
    t_794 = sid__638('users');
    t_795 = sid__638('age');
    t_796 = SqlInt32(18);
    t_797 = SqlInt32(65);
    q__1553 = from(t_794):whereBetween(t_795, t_796, t_797);
    t_798 = temper.str_eq(q__1553:toSql():toString(), 'SELECT * FROM users WHERE age BETWEEN 18 AND 65');
    fn__12026 = function()
      return 'whereBetween ints';
    end;
    temper.test_assert(test_793, t_798, fn__12026);
    return nil;
  end);
end;
Test_.test_whereBetweenChained__2217 = function()
  temper.test('whereBetween chained', function(test_799)
    local t_800, t_801, t_802, q__1555, t_803, fn__12010;
    t_800 = sid__638('users');
    t_801 = SqlBuilder();
    t_801:appendSafe('active = ');
    t_801:appendBoolean(true);
    t_802 = t_801.accumulated;
    q__1555 = from(t_800):where(t_802):whereBetween(sid__638('age'), SqlInt32(21), SqlInt32(30));
    t_803 = temper.str_eq(q__1555:toSql():toString(), 'SELECT * FROM users WHERE active = TRUE AND age BETWEEN 21 AND 30');
    fn__12010 = function()
      return 'whereBetween chained';
    end;
    temper.test_assert(test_799, t_803, fn__12010);
    return nil;
  end);
end;
Test_.test_whereLikeBasic__2219 = function()
  temper.test('whereLike basic', function(test_804)
    local t_805, t_806, q__1557, t_807, fn__12001;
    t_805 = sid__638('users');
    t_806 = sid__638('name');
    q__1557 = from(t_805):whereLike(t_806, 'John%');
    t_807 = temper.str_eq(q__1557:toSql():toString(), "SELECT * FROM users WHERE name LIKE 'John%'");
    fn__12001 = function()
      return 'whereLike';
    end;
    temper.test_assert(test_804, t_807, fn__12001);
    return nil;
  end);
end;
Test_.test_whereIlikeBasic__2220 = function()
  temper.test('whereILike basic', function(test_808)
    local t_809, t_810, q__1559, t_811, fn__11992;
    t_809 = sid__638('users');
    t_810 = sid__638('email');
    q__1559 = from(t_809):whereILike(t_810, '%@gmail.com');
    t_811 = temper.str_eq(q__1559:toSql():toString(), "SELECT * FROM users WHERE email ILIKE '%@gmail.com'");
    fn__11992 = function()
      return 'whereILike';
    end;
    temper.test_assert(test_808, t_811, fn__11992);
    return nil;
  end);
end;
Test_.test_whereLikeWithInjectionAttempt__2221 = function()
  temper.test('whereLike with injection attempt', function(test_812)
    local t_813, t_814, q__1561, s__1562, t_815, fn__11978, t_816, fn__11977;
    t_813 = sid__638('users');
    t_814 = sid__638('name');
    q__1561 = from(t_813):whereLike(t_814, "'; DROP TABLE users; --");
    s__1562 = q__1561:toSql():toString();
    t_815 = temper.is_string_index(temper.string_indexof(s__1562, "''"));
    fn__11978 = function()
      return temper.concat('like injection escaped: ', s__1562);
    end;
    temper.test_assert(test_812, t_815, fn__11978);
    t_816 = temper.is_string_index(temper.string_indexof(s__1562, 'LIKE'));
    fn__11977 = function()
      return temper.concat('like structure intact: ', s__1562);
    end;
    temper.test_assert(test_812, t_816, fn__11977);
    return nil;
  end);
end;
Test_.test_whereLikeWildcardPatterns__2222 = function()
  temper.test('whereLike wildcard patterns', function(test_817)
    local t_818, t_819, q__1564, t_820, fn__11968;
    t_818 = sid__638('users');
    t_819 = sid__638('name');
    q__1564 = from(t_818):whereLike(t_819, '%son%');
    t_820 = temper.str_eq(q__1564:toSql():toString(), "SELECT * FROM users WHERE name LIKE '%son%'");
    fn__11968 = function()
      return 'whereLike wildcard';
    end;
    temper.test_assert(test_817, t_820, fn__11968);
    return nil;
  end);
end;
Test_.test_countAllProducesCount__2223 = function()
  temper.test('countAll produces COUNT(*)', function(test_821)
    local f__1566, t_822, fn__11962;
    f__1566 = countAll();
    t_822 = temper.str_eq(f__1566:toString(), 'COUNT(*)');
    fn__11962 = function()
      return 'countAll';
    end;
    temper.test_assert(test_821, t_822, fn__11962);
    return nil;
  end);
end;
Test_.test_countColProducesCountField__2224 = function()
  temper.test('countCol produces COUNT(field)', function(test_823)
    local f__1568, t_824, fn__11955;
    f__1568 = countCol(sid__638('id'));
    t_824 = temper.str_eq(f__1568:toString(), 'COUNT(id)');
    fn__11955 = function()
      return 'countCol';
    end;
    temper.test_assert(test_823, t_824, fn__11955);
    return nil;
  end);
end;
Test_.test_sumColProducesSumField__2225 = function()
  temper.test('sumCol produces SUM(field)', function(test_825)
    local f__1570, t_826, fn__11948;
    f__1570 = sumCol(sid__638('amount'));
    t_826 = temper.str_eq(f__1570:toString(), 'SUM(amount)');
    fn__11948 = function()
      return 'sumCol';
    end;
    temper.test_assert(test_825, t_826, fn__11948);
    return nil;
  end);
end;
Test_.test_avgColProducesAvgField__2226 = function()
  temper.test('avgCol produces AVG(field)', function(test_827)
    local f__1572, t_828, fn__11941;
    f__1572 = avgCol(sid__638('price'));
    t_828 = temper.str_eq(f__1572:toString(), 'AVG(price)');
    fn__11941 = function()
      return 'avgCol';
    end;
    temper.test_assert(test_827, t_828, fn__11941);
    return nil;
  end);
end;
Test_.test_minColProducesMinField__2227 = function()
  temper.test('minCol produces MIN(field)', function(test_829)
    local f__1574, t_830, fn__11934;
    f__1574 = minCol(sid__638('created_at'));
    t_830 = temper.str_eq(f__1574:toString(), 'MIN(created_at)');
    fn__11934 = function()
      return 'minCol';
    end;
    temper.test_assert(test_829, t_830, fn__11934);
    return nil;
  end);
end;
Test_.test_maxColProducesMaxField__2228 = function()
  temper.test('maxCol produces MAX(field)', function(test_831)
    local f__1576, t_832, fn__11927;
    f__1576 = maxCol(sid__638('score'));
    t_832 = temper.str_eq(f__1576:toString(), 'MAX(score)');
    fn__11927 = function()
      return 'maxCol';
    end;
    temper.test_assert(test_831, t_832, fn__11927);
    return nil;
  end);
end;
Test_.test_selectExprWithAggregate__2229 = function()
  temper.test('selectExpr with aggregate', function(test_833)
    local t_834, t_835, q__1578, t_836, fn__11918;
    t_834 = sid__638('orders');
    t_835 = countAll();
    q__1578 = from(t_834):selectExpr(temper.listof(t_835));
    t_836 = temper.str_eq(q__1578:toSql():toString(), 'SELECT COUNT(*) FROM orders');
    fn__11918 = function()
      return 'selectExpr count';
    end;
    temper.test_assert(test_833, t_836, fn__11918);
    return nil;
  end);
end;
Test_.test_selectExprWithMultipleExpressions__2230 = function()
  temper.test('selectExpr with multiple expressions', function(test_837)
    local nameFrag__1580, t_838, t_839, q__1581, t_840, fn__11906;
    nameFrag__1580 = col(sid__638('users'), sid__638('name'));
    t_838 = sid__638('users');
    t_839 = countAll();
    q__1581 = from(t_838):selectExpr(temper.listof(nameFrag__1580, t_839));
    t_840 = temper.str_eq(q__1581:toSql():toString(), 'SELECT users.name, COUNT(*) FROM users');
    fn__11906 = function()
      return 'selectExpr multi';
    end;
    temper.test_assert(test_837, t_840, fn__11906);
    return nil;
  end);
end;
Test_.test_selectExprOverridesSelectedFields__2231 = function()
  temper.test('selectExpr overrides selectedFields', function(test_841)
    local t_842, t_843, t_844, q__1583, t_845, fn__11894;
    t_842 = sid__638('users');
    t_843 = sid__638('id');
    t_844 = sid__638('name');
    q__1583 = from(t_842):select(temper.listof(t_843, t_844)):selectExpr(temper.listof(countAll()));
    t_845 = temper.str_eq(q__1583:toSql():toString(), 'SELECT COUNT(*) FROM users');
    fn__11894 = function()
      return 'selectExpr overrides select';
    end;
    temper.test_assert(test_841, t_845, fn__11894);
    return nil;
  end);
end;
Test_.test_groupBySingleField__2232 = function()
  temper.test('groupBy single field', function(test_846)
    local t_847, t_848, t_849, q__1585, t_850, fn__11880;
    t_847 = sid__638('orders');
    t_848 = col(sid__638('orders'), sid__638('status'));
    t_849 = countAll();
    q__1585 = from(t_847):selectExpr(temper.listof(t_848, t_849)):groupBy(sid__638('status'));
    t_850 = temper.str_eq(q__1585:toSql():toString(), 'SELECT orders.status, COUNT(*) FROM orders GROUP BY status');
    fn__11880 = function()
      return 'groupBy single';
    end;
    temper.test_assert(test_846, t_850, fn__11880);
    return nil;
  end);
end;
Test_.test_groupByMultipleFields__2233 = function()
  temper.test('groupBy multiple fields', function(test_851)
    local t_852, t_853, q__1587, t_854, fn__11869;
    t_852 = sid__638('orders');
    t_853 = sid__638('status');
    q__1587 = from(t_852):groupBy(t_853):groupBy(sid__638('category'));
    t_854 = temper.str_eq(q__1587:toSql():toString(), 'SELECT * FROM orders GROUP BY status, category');
    fn__11869 = function()
      return 'groupBy multiple';
    end;
    temper.test_assert(test_851, t_854, fn__11869);
    return nil;
  end);
end;
Test_.test_havingBasic__2234 = function()
  temper.test('having basic', function(test_855)
    local t_856, t_857, t_858, t_859, t_860, q__1589, t_861, fn__11850;
    t_856 = sid__638('orders');
    t_857 = col(sid__638('orders'), sid__638('status'));
    t_858 = countAll();
    t_859 = from(t_856):selectExpr(temper.listof(t_857, t_858)):groupBy(sid__638('status'));
    t_860 = SqlBuilder();
    t_860:appendSafe('COUNT(*) > ');
    t_860:appendInt32(5);
    q__1589 = t_859:having(t_860.accumulated);
    t_861 = temper.str_eq(q__1589:toSql():toString(), 'SELECT orders.status, COUNT(*) FROM orders GROUP BY status HAVING COUNT(*) > 5');
    fn__11850 = function()
      return 'having basic';
    end;
    temper.test_assert(test_855, t_861, fn__11850);
    return nil;
  end);
end;
Test_.test_orHaving__2236 = function()
  temper.test('orHaving', function(test_862)
    local t_863, t_864, t_865, t_866, t_867, t_868, q__1591, t_869, fn__11831;
    t_863 = sid__638('orders');
    t_864 = sid__638('status');
    t_865 = from(t_863):groupBy(t_864);
    t_866 = SqlBuilder();
    t_866:appendSafe('COUNT(*) > ');
    t_866:appendInt32(5);
    t_867 = t_865:having(t_866.accumulated);
    t_868 = SqlBuilder();
    t_868:appendSafe('SUM(total) > ');
    t_868:appendInt32(1000);
    q__1591 = t_867:orHaving(t_868.accumulated);
    t_869 = temper.str_eq(q__1591:toSql():toString(), 'SELECT * FROM orders GROUP BY status HAVING COUNT(*) > 5 OR SUM(total) > 1000');
    fn__11831 = function()
      return 'orHaving';
    end;
    temper.test_assert(test_862, t_869, fn__11831);
    return nil;
  end);
end;
Test_.test_distinctBasic__2239 = function()
  temper.test('distinct basic', function(test_870)
    local t_871, t_872, q__1593, t_873, fn__11821;
    t_871 = sid__638('users');
    t_872 = sid__638('name');
    q__1593 = from(t_871):select(temper.listof(t_872)):distinct();
    t_873 = temper.str_eq(q__1593:toSql():toString(), 'SELECT DISTINCT name FROM users');
    fn__11821 = function()
      return 'distinct';
    end;
    temper.test_assert(test_870, t_873, fn__11821);
    return nil;
  end);
end;
Test_.test_distinctWithWhere__2240 = function()
  temper.test('distinct with where', function(test_874)
    local t_875, t_876, t_877, t_878, q__1595, t_879, fn__11806;
    t_875 = sid__638('users');
    t_876 = sid__638('email');
    t_877 = from(t_875):select(temper.listof(t_876));
    t_878 = SqlBuilder();
    t_878:appendSafe('active = ');
    t_878:appendBoolean(true);
    q__1595 = t_877:where(t_878.accumulated):distinct();
    t_879 = temper.str_eq(q__1595:toSql():toString(), 'SELECT DISTINCT email FROM users WHERE active = TRUE');
    fn__11806 = function()
      return 'distinct with where';
    end;
    temper.test_assert(test_874, t_879, fn__11806);
    return nil;
  end);
end;
Test_.test_countSqlBare__2242 = function()
  temper.test('countSql bare', function(test_880)
    local q__1597, t_881, fn__11799;
    q__1597 = from(sid__638('users'));
    t_881 = temper.str_eq(q__1597:countSql():toString(), 'SELECT COUNT(*) FROM users');
    fn__11799 = function()
      return 'countSql bare';
    end;
    temper.test_assert(test_880, t_881, fn__11799);
    return nil;
  end);
end;
Test_.test_countSqlWithWhere__2243 = function()
  temper.test('countSql with WHERE', function(test_882)
    local t_883, t_884, t_885, q__1599, t_886, fn__11787;
    t_883 = sid__638('users');
    t_884 = SqlBuilder();
    t_884:appendSafe('active = ');
    t_884:appendBoolean(true);
    t_885 = t_884.accumulated;
    q__1599 = from(t_883):where(t_885);
    t_886 = temper.str_eq(q__1599:countSql():toString(), 'SELECT COUNT(*) FROM users WHERE active = TRUE');
    fn__11787 = function()
      return 'countSql with where';
    end;
    temper.test_assert(test_882, t_886, fn__11787);
    return nil;
  end);
end;
Test_.test_countSqlWithJoin__2245 = function()
  temper.test('countSql with JOIN', function(test_887)
    local t_888, t_889, t_890, t_891, t_892, t_893, q__1601, t_894, fn__11770;
    t_888 = sid__638('users');
    t_889 = sid__638('orders');
    t_890 = SqlBuilder();
    t_890:appendSafe('users.id = orders.user_id');
    t_891 = t_890.accumulated;
    t_892 = from(t_888):innerJoin(t_889, t_891);
    t_893 = SqlBuilder();
    t_893:appendSafe('orders.total > ');
    t_893:appendInt32(100);
    q__1601 = t_892:where(t_893.accumulated);
    t_894 = temper.str_eq(q__1601:countSql():toString(), 'SELECT COUNT(*) FROM users INNER JOIN orders ON users.id = orders.user_id WHERE orders.total > 100');
    fn__11770 = function()
      return 'countSql with join';
    end;
    temper.test_assert(test_887, t_894, fn__11770);
    return nil;
  end);
end;
Test_.test_countSqlDropsOrderByLimitOffset__2248 = function()
  temper.test('countSql drops orderBy/limit/offset', function(test_895)
    local t_896, t_897, t_898, t_899, t_900, q__1603, local_901, local_902, local_903, s__1604, t_905, fn__11756;
    local_901, local_902, local_903 = temper.pcall(function()
      t_896 = sid__638('users');
      t_897 = SqlBuilder();
      t_897:appendSafe('active = ');
      t_897:appendBoolean(true);
      t_898 = t_897.accumulated;
      t_899 = from(t_896):where(t_898):orderBy(sid__638('name'), true):limit(10);
      t_900 = t_899:offset(20);
      q__1603 = t_900;
    end);
    if local_901 then
    else
      q__1603 = temper.bubble();
    end
    s__1604 = q__1603:countSql():toString();
    t_905 = temper.str_eq(s__1604, 'SELECT COUNT(*) FROM users WHERE active = TRUE');
    fn__11756 = function()
      return temper.concat('countSql drops extras: ', s__1604);
    end;
    temper.test_assert(test_895, t_905, fn__11756);
    return nil;
  end);
end;
Test_.test_fullAggregationQuery__2250 = function()
  temper.test('full aggregation query', function(test_906)
    local t_907, t_908, t_909, t_910, t_911, t_912, t_913, t_914, t_915, t_916, t_917, q__1606, expected__1607, t_918, fn__11723;
    t_907 = sid__638('orders');
    t_908 = col(sid__638('orders'), sid__638('status'));
    t_909 = countAll();
    t_910 = sumCol(sid__638('total'));
    t_911 = from(t_907):selectExpr(temper.listof(t_908, t_909, t_910));
    t_912 = sid__638('users');
    t_913 = SqlBuilder();
    t_913:appendSafe('orders.user_id = users.id');
    t_914 = t_911:innerJoin(t_912, t_913.accumulated);
    t_915 = SqlBuilder();
    t_915:appendSafe('users.active = ');
    t_915:appendBoolean(true);
    t_916 = t_914:where(t_915.accumulated):groupBy(sid__638('status'));
    t_917 = SqlBuilder();
    t_917:appendSafe('COUNT(*) > ');
    t_917:appendInt32(3);
    q__1606 = t_916:having(t_917.accumulated):orderBy(sid__638('status'), true);
    expected__1607 = 'SELECT orders.status, COUNT(*), SUM(total) FROM orders INNER JOIN users ON orders.user_id = users.id WHERE users.active = TRUE GROUP BY status HAVING COUNT(*) > 3 ORDER BY status ASC';
    t_918 = temper.str_eq(q__1606:toSql():toString(), 'SELECT orders.status, COUNT(*), SUM(total) FROM orders INNER JOIN users ON orders.user_id = users.id WHERE users.active = TRUE GROUP BY status HAVING COUNT(*) > 3 ORDER BY status ASC');
    fn__11723 = function()
      return 'full aggregation';
    end;
    temper.test_assert(test_906, t_918, fn__11723);
    return nil;
  end);
end;
Test_.test_unionSql__2254 = function()
  temper.test('unionSql', function(test_919)
    local t_920, t_921, t_922, a__1609, t_923, t_924, t_925, b__1610, s__1611, t_926, fn__11705;
    t_920 = sid__638('users');
    t_921 = SqlBuilder();
    t_921:appendSafe('role = ');
    t_921:appendString('admin');
    t_922 = t_921.accumulated;
    a__1609 = from(t_920):where(t_922);
    t_923 = sid__638('users');
    t_924 = SqlBuilder();
    t_924:appendSafe('role = ');
    t_924:appendString('moderator');
    t_925 = t_924.accumulated;
    b__1610 = from(t_923):where(t_925);
    s__1611 = unionSql(a__1609, b__1610):toString();
    t_926 = temper.str_eq(s__1611, "(SELECT * FROM users WHERE role = 'admin') UNION (SELECT * FROM users WHERE role = 'moderator')");
    fn__11705 = function()
      return temper.concat('unionSql: ', s__1611);
    end;
    temper.test_assert(test_919, t_926, fn__11705);
    return nil;
  end);
end;
Test_.test_unionAllSql__2257 = function()
  temper.test('unionAllSql', function(test_927)
    local t_928, t_929, a__1613, t_930, t_931, b__1614, s__1615, t_932, fn__11693;
    t_928 = sid__638('users');
    t_929 = sid__638('name');
    a__1613 = from(t_928):select(temper.listof(t_929));
    t_930 = sid__638('contacts');
    t_931 = sid__638('name');
    b__1614 = from(t_930):select(temper.listof(t_931));
    s__1615 = unionAllSql(a__1613, b__1614):toString();
    t_932 = temper.str_eq(s__1615, '(SELECT name FROM users) UNION ALL (SELECT name FROM contacts)');
    fn__11693 = function()
      return temper.concat('unionAllSql: ', s__1615);
    end;
    temper.test_assert(test_927, t_932, fn__11693);
    return nil;
  end);
end;
Test_.test_intersectSql__2258 = function()
  temper.test('intersectSql', function(test_933)
    local t_934, t_935, a__1617, t_936, t_937, b__1618, s__1619, t_938, fn__11681;
    t_934 = sid__638('users');
    t_935 = sid__638('email');
    a__1617 = from(t_934):select(temper.listof(t_935));
    t_936 = sid__638('subscribers');
    t_937 = sid__638('email');
    b__1618 = from(t_936):select(temper.listof(t_937));
    s__1619 = intersectSql(a__1617, b__1618):toString();
    t_938 = temper.str_eq(s__1619, '(SELECT email FROM users) INTERSECT (SELECT email FROM subscribers)');
    fn__11681 = function()
      return temper.concat('intersectSql: ', s__1619);
    end;
    temper.test_assert(test_933, t_938, fn__11681);
    return nil;
  end);
end;
Test_.test_exceptSql__2259 = function()
  temper.test('exceptSql', function(test_939)
    local t_940, t_941, a__1621, t_942, t_943, b__1622, s__1623, t_944, fn__11669;
    t_940 = sid__638('users');
    t_941 = sid__638('id');
    a__1621 = from(t_940):select(temper.listof(t_941));
    t_942 = sid__638('banned');
    t_943 = sid__638('id');
    b__1622 = from(t_942):select(temper.listof(t_943));
    s__1623 = exceptSql(a__1621, b__1622):toString();
    t_944 = temper.str_eq(s__1623, '(SELECT id FROM users) EXCEPT (SELECT id FROM banned)');
    fn__11669 = function()
      return temper.concat('exceptSql: ', s__1623);
    end;
    temper.test_assert(test_939, t_944, fn__11669);
    return nil;
  end);
end;
Test_.test_subqueryWithAlias__2260 = function()
  temper.test('subquery with alias', function(test_945)
    local t_946, t_947, t_948, t_949, inner__1625, s__1626, t_950, fn__11654;
    t_946 = sid__638('orders');
    t_947 = sid__638('user_id');
    t_948 = from(t_946):select(temper.listof(t_947));
    t_949 = SqlBuilder();
    t_949:appendSafe('total > ');
    t_949:appendInt32(100);
    inner__1625 = t_948:where(t_949.accumulated);
    s__1626 = subquery(inner__1625, sid__638('big_orders')):toString();
    t_950 = temper.str_eq(s__1626, '(SELECT user_id FROM orders WHERE total > 100) AS big_orders');
    fn__11654 = function()
      return temper.concat('subquery: ', s__1626);
    end;
    temper.test_assert(test_945, t_950, fn__11654);
    return nil;
  end);
end;
Test_.test_existsSql__2262 = function()
  temper.test('existsSql', function(test_951)
    local t_952, t_953, t_954, inner__1628, s__1629, t_955, fn__11643;
    t_952 = sid__638('orders');
    t_953 = SqlBuilder();
    t_953:appendSafe('orders.user_id = users.id');
    t_954 = t_953.accumulated;
    inner__1628 = from(t_952):where(t_954);
    s__1629 = existsSql(inner__1628):toString();
    t_955 = temper.str_eq(s__1629, 'EXISTS (SELECT * FROM orders WHERE orders.user_id = users.id)');
    fn__11643 = function()
      return temper.concat('existsSql: ', s__1629);
    end;
    temper.test_assert(test_951, t_955, fn__11643);
    return nil;
  end);
end;
Test_.test_whereInSubquery__2264 = function()
  temper.test('whereInSubquery', function(test_956)
    local t_957, t_958, t_959, t_960, sub__1631, t_961, t_962, q__1632, s__1633, t_963, fn__11626;
    t_957 = sid__638('orders');
    t_958 = sid__638('user_id');
    t_959 = from(t_957):select(temper.listof(t_958));
    t_960 = SqlBuilder();
    t_960:appendSafe('total > ');
    t_960:appendInt32(1000);
    sub__1631 = t_959:where(t_960.accumulated);
    t_961 = sid__638('users');
    t_962 = sid__638('id');
    q__1632 = from(t_961):whereInSubquery(t_962, sub__1631);
    s__1633 = q__1632:toSql():toString();
    t_963 = temper.str_eq(s__1633, 'SELECT * FROM users WHERE id IN (SELECT user_id FROM orders WHERE total > 1000)');
    fn__11626 = function()
      return temper.concat('whereInSubquery: ', s__1633);
    end;
    temper.test_assert(test_956, t_963, fn__11626);
    return nil;
  end);
end;
Test_.test_setOperationWithWhereOnEachSide__2266 = function()
  temper.test('set operation with WHERE on each side', function(test_964)
    local t_965, t_966, t_967, t_968, t_969, a__1635, t_970, t_971, t_972, b__1636, s__1637, t_973, fn__11603;
    t_965 = sid__638('users');
    t_966 = SqlBuilder();
    t_966:appendSafe('age > ');
    t_966:appendInt32(18);
    t_967 = t_966.accumulated;
    t_968 = from(t_965):where(t_967);
    t_969 = SqlBuilder();
    t_969:appendSafe('active = ');
    t_969:appendBoolean(true);
    a__1635 = t_968:where(t_969.accumulated);
    t_970 = sid__638('users');
    t_971 = SqlBuilder();
    t_971:appendSafe('role = ');
    t_971:appendString('vip');
    t_972 = t_971.accumulated;
    b__1636 = from(t_970):where(t_972);
    s__1637 = unionSql(a__1635, b__1636):toString();
    t_973 = temper.str_eq(s__1637, "(SELECT * FROM users WHERE age > 18 AND active = TRUE) UNION (SELECT * FROM users WHERE role = 'vip')");
    fn__11603 = function()
      return temper.concat('union with where: ', s__1637);
    end;
    temper.test_assert(test_964, t_973, fn__11603);
    return nil;
  end);
end;
Test_.test_whereInSubqueryChainedWithWhere__2270 = function()
  temper.test('whereInSubquery chained with where', function(test_974)
    local t_975, t_976, sub__1639, t_977, t_978, t_979, q__1640, s__1641, t_980, fn__11586;
    t_975 = sid__638('orders');
    t_976 = sid__638('user_id');
    sub__1639 = from(t_975):select(temper.listof(t_976));
    t_977 = sid__638('users');
    t_978 = SqlBuilder();
    t_978:appendSafe('active = ');
    t_978:appendBoolean(true);
    t_979 = t_978.accumulated;
    q__1640 = from(t_977):where(t_979):whereInSubquery(sid__638('id'), sub__1639);
    s__1641 = q__1640:toSql():toString();
    t_980 = temper.str_eq(s__1641, 'SELECT * FROM users WHERE active = TRUE AND id IN (SELECT user_id FROM orders)');
    fn__11586 = function()
      return temper.concat('whereInSubquery chained: ', s__1641);
    end;
    temper.test_assert(test_974, t_980, fn__11586);
    return nil;
  end);
end;
Test_.test_existsSqlUsedInWhere__2272 = function()
  temper.test('existsSql used in where', function(test_981)
    local t_982, t_983, t_984, sub__1643, t_985, t_986, q__1644, s__1645, t_987, fn__11572;
    t_982 = sid__638('orders');
    t_983 = SqlBuilder();
    t_983:appendSafe('orders.user_id = users.id');
    t_984 = t_983.accumulated;
    sub__1643 = from(t_982):where(t_984);
    t_985 = sid__638('users');
    t_986 = existsSql(sub__1643);
    q__1644 = from(t_985):where(t_986);
    s__1645 = q__1644:toSql():toString();
    t_987 = temper.str_eq(s__1645, 'SELECT * FROM users WHERE EXISTS (SELECT * FROM orders WHERE orders.user_id = users.id)');
    fn__11572 = function()
      return temper.concat('exists in where: ', s__1645);
    end;
    temper.test_assert(test_981, t_987, fn__11572);
    return nil;
  end);
end;
Test_.test_updateQueryBasic__2274 = function()
  temper.test('UpdateQuery basic', function(test_988)
    local t_989, t_990, t_991, t_992, t_993, t_994, q__1647, local_995, local_996, local_997, t_999, fn__11558;
    local_995, local_996, local_997 = temper.pcall(function()
      t_989 = sid__638('users');
      t_990 = sid__638('name');
      t_991 = SqlString('Alice');
      t_992 = update(t_989):set(t_990, t_991);
      t_993 = SqlBuilder();
      t_993:appendSafe('id = ');
      t_993:appendInt32(1);
      t_994 = t_992:where(t_993.accumulated):toSql();
      q__1647 = t_994;
    end);
    if local_995 then
    else
      q__1647 = temper.bubble();
    end
    t_999 = temper.str_eq(q__1647:toString(), "UPDATE users SET name = 'Alice' WHERE id = 1");
    fn__11558 = function()
      return 'update basic';
    end;
    temper.test_assert(test_988, t_999, fn__11558);
    return nil;
  end);
end;
Test_.test_updateQueryMultipleSet__2276 = function()
  temper.test('UpdateQuery multiple SET', function(test_1000)
    local t_1001, t_1002, t_1003, t_1004, t_1005, t_1006, q__1649, local_1007, local_1008, local_1009, t_1011, fn__11541;
    local_1007, local_1008, local_1009 = temper.pcall(function()
      t_1001 = sid__638('users');
      t_1002 = sid__638('name');
      t_1003 = SqlString('Bob');
      t_1004 = update(t_1001):set(t_1002, t_1003):set(sid__638('age'), SqlInt32(30));
      t_1005 = SqlBuilder();
      t_1005:appendSafe('id = ');
      t_1005:appendInt32(2);
      t_1006 = t_1004:where(t_1005.accumulated):toSql();
      q__1649 = t_1006;
    end);
    if local_1007 then
    else
      q__1649 = temper.bubble();
    end
    t_1011 = temper.str_eq(q__1649:toString(), "UPDATE users SET name = 'Bob', age = 30 WHERE id = 2");
    fn__11541 = function()
      return 'update multi set';
    end;
    temper.test_assert(test_1000, t_1011, fn__11541);
    return nil;
  end);
end;
Test_.test_updateQueryMultipleWhere__2278 = function()
  temper.test('UpdateQuery multiple WHERE', function(test_1012)
    local t_1013, t_1014, t_1015, t_1016, t_1017, t_1018, t_1019, t_1020, q__1651, local_1021, local_1022, local_1023, t_1025, fn__11522;
    local_1021, local_1022, local_1023 = temper.pcall(function()
      t_1013 = sid__638('users');
      t_1014 = sid__638('active');
      t_1015 = SqlBoolean(false);
      t_1016 = update(t_1013):set(t_1014, t_1015);
      t_1017 = SqlBuilder();
      t_1017:appendSafe('age < ');
      t_1017:appendInt32(18);
      t_1018 = t_1016:where(t_1017.accumulated);
      t_1019 = SqlBuilder();
      t_1019:appendSafe('role = ');
      t_1019:appendString('guest');
      t_1020 = t_1018:where(t_1019.accumulated):toSql();
      q__1651 = t_1020;
    end);
    if local_1021 then
    else
      q__1651 = temper.bubble();
    end
    t_1025 = temper.str_eq(q__1651:toString(), "UPDATE users SET active = FALSE WHERE age < 18 AND role = 'guest'");
    fn__11522 = function()
      return 'update multi where';
    end;
    temper.test_assert(test_1012, t_1025, fn__11522);
    return nil;
  end);
end;
Test_.test_updateQueryOrWhere__2281 = function()
  temper.test('UpdateQuery orWhere', function(test_1026)
    local t_1027, t_1028, t_1029, t_1030, t_1031, t_1032, t_1033, t_1034, q__1653, local_1035, local_1036, local_1037, t_1039, fn__11503;
    local_1035, local_1036, local_1037 = temper.pcall(function()
      t_1027 = sid__638('users');
      t_1028 = sid__638('status');
      t_1029 = SqlString('banned');
      t_1030 = update(t_1027):set(t_1028, t_1029);
      t_1031 = SqlBuilder();
      t_1031:appendSafe('spam_count > ');
      t_1031:appendInt32(10);
      t_1032 = t_1030:where(t_1031.accumulated);
      t_1033 = SqlBuilder();
      t_1033:appendSafe('reported = ');
      t_1033:appendBoolean(true);
      t_1034 = t_1032:orWhere(t_1033.accumulated):toSql();
      q__1653 = t_1034;
    end);
    if local_1035 then
    else
      q__1653 = temper.bubble();
    end
    t_1039 = temper.str_eq(q__1653:toString(), "UPDATE users SET status = 'banned' WHERE spam_count > 10 OR reported = TRUE");
    fn__11503 = function()
      return 'update orWhere';
    end;
    temper.test_assert(test_1026, t_1039, fn__11503);
    return nil;
  end);
end;
Test_.test_updateQueryBubblesWithoutWhere__2284 = function()
  temper.test('UpdateQuery bubbles without WHERE', function(test_1040)
    local t_1041, t_1042, t_1043, didBubble__1655, local_1044, local_1045, local_1046, fn__11496;
    local_1044, local_1045, local_1046 = temper.pcall(function()
      t_1041 = sid__638('users');
      t_1042 = sid__638('x');
      t_1043 = SqlInt32(1);
      update(t_1041):set(t_1042, t_1043):toSql();
      didBubble__1655 = false;
    end);
    if local_1044 then
    else
      didBubble__1655 = true;
    end
    fn__11496 = function()
      return 'update without WHERE should bubble';
    end;
    temper.test_assert(test_1040, didBubble__1655, fn__11496);
    return nil;
  end);
end;
Test_.test_updateQueryBubblesWithoutSet__2285 = function()
  temper.test('UpdateQuery bubbles without SET', function(test_1048)
    local t_1049, t_1050, t_1051, didBubble__1657, local_1052, local_1053, local_1054, fn__11487;
    local_1052, local_1053, local_1054 = temper.pcall(function()
      t_1049 = sid__638('users');
      t_1050 = SqlBuilder();
      t_1050:appendSafe('id = ');
      t_1050:appendInt32(1);
      t_1051 = t_1050.accumulated;
      update(t_1049):where(t_1051):toSql();
      didBubble__1657 = false;
    end);
    if local_1052 then
    else
      didBubble__1657 = true;
    end
    fn__11487 = function()
      return 'update without SET should bubble';
    end;
    temper.test_assert(test_1048, didBubble__1657, fn__11487);
    return nil;
  end);
end;
Test_.test_updateQueryWithLimit__2287 = function()
  temper.test('UpdateQuery with limit', function(test_1056)
    local t_1057, t_1058, t_1059, t_1060, t_1061, t_1062, t_1063, q__1659, local_1064, local_1065, local_1066, t_1068, fn__11473;
    local_1064, local_1065, local_1066 = temper.pcall(function()
      t_1057 = sid__638('users');
      t_1058 = sid__638('active');
      t_1059 = SqlBoolean(false);
      t_1060 = update(t_1057):set(t_1058, t_1059);
      t_1061 = SqlBuilder();
      t_1061:appendSafe('last_login < ');
      t_1061:appendString('2024-01-01');
      t_1062 = t_1060:where(t_1061.accumulated):limit(100);
      t_1063 = t_1062:toSql();
      q__1659 = t_1063;
    end);
    if local_1064 then
    else
      q__1659 = temper.bubble();
    end
    t_1068 = temper.str_eq(q__1659:toString(), "UPDATE users SET active = FALSE WHERE last_login < '2024-01-01' LIMIT 100");
    fn__11473 = function()
      return 'update limit';
    end;
    temper.test_assert(test_1056, t_1068, fn__11473);
    return nil;
  end);
end;
Test_.test_updateQueryEscaping__2289 = function()
  temper.test('UpdateQuery escaping', function(test_1069)
    local t_1070, t_1071, t_1072, t_1073, t_1074, t_1075, q__1661, local_1076, local_1077, local_1078, t_1080, fn__11459;
    local_1076, local_1077, local_1078 = temper.pcall(function()
      t_1070 = sid__638('users');
      t_1071 = sid__638('bio');
      t_1072 = SqlString("It's a test");
      t_1073 = update(t_1070):set(t_1071, t_1072);
      t_1074 = SqlBuilder();
      t_1074:appendSafe('id = ');
      t_1074:appendInt32(1);
      t_1075 = t_1073:where(t_1074.accumulated):toSql();
      q__1661 = t_1075;
    end);
    if local_1076 then
    else
      q__1661 = temper.bubble();
    end
    t_1080 = temper.str_eq(q__1661:toString(), "UPDATE users SET bio = 'It''s a test' WHERE id = 1");
    fn__11459 = function()
      return 'update escaping';
    end;
    temper.test_assert(test_1069, t_1080, fn__11459);
    return nil;
  end);
end;
Test_.test_deleteQueryBasic__2291 = function()
  temper.test('DeleteQuery basic', function(test_1081)
    local t_1082, t_1083, t_1084, t_1085, q__1663, local_1086, local_1087, local_1088, t_1090, fn__11448;
    local_1086, local_1087, local_1088 = temper.pcall(function()
      t_1082 = sid__638('users');
      t_1083 = SqlBuilder();
      t_1083:appendSafe('id = ');
      t_1083:appendInt32(1);
      t_1084 = t_1083.accumulated;
      t_1085 = deleteFrom(t_1082):where(t_1084):toSql();
      q__1663 = t_1085;
    end);
    if local_1086 then
    else
      q__1663 = temper.bubble();
    end
    t_1090 = temper.str_eq(q__1663:toString(), 'DELETE FROM users WHERE id = 1');
    fn__11448 = function()
      return 'delete basic';
    end;
    temper.test_assert(test_1081, t_1090, fn__11448);
    return nil;
  end);
end;
Test_.test_deleteQueryMultipleWhere__2293 = function()
  temper.test('DeleteQuery multiple WHERE', function(test_1091)
    local t_1092, t_1093, t_1094, t_1095, t_1096, t_1097, q__1665, local_1098, local_1099, local_1100, t_1102, fn__11432;
    local_1098, local_1099, local_1100 = temper.pcall(function()
      t_1092 = sid__638('logs');
      t_1093 = SqlBuilder();
      t_1093:appendSafe('created_at < ');
      t_1093:appendString('2024-01-01');
      t_1094 = t_1093.accumulated;
      t_1095 = deleteFrom(t_1092):where(t_1094);
      t_1096 = SqlBuilder();
      t_1096:appendSafe('level = ');
      t_1096:appendString('debug');
      t_1097 = t_1095:where(t_1096.accumulated):toSql();
      q__1665 = t_1097;
    end);
    if local_1098 then
    else
      q__1665 = temper.bubble();
    end
    t_1102 = temper.str_eq(q__1665:toString(), "DELETE FROM logs WHERE created_at < '2024-01-01' AND level = 'debug'");
    fn__11432 = function()
      return 'delete multi where';
    end;
    temper.test_assert(test_1091, t_1102, fn__11432);
    return nil;
  end);
end;
Test_.test_deleteQueryBubblesWithoutWhere__2296 = function()
  temper.test('DeleteQuery bubbles without WHERE', function(test_1103)
    local didBubble__1667, local_1104, local_1105, local_1106, fn__11428;
    local_1104, local_1105, local_1106 = temper.pcall(function()
      deleteFrom(sid__638('users')):toSql();
      didBubble__1667 = false;
    end);
    if local_1104 then
    else
      didBubble__1667 = true;
    end
    fn__11428 = function()
      return 'delete without WHERE should bubble';
    end;
    temper.test_assert(test_1103, didBubble__1667, fn__11428);
    return nil;
  end);
end;
Test_.test_deleteQueryOrWhere__2297 = function()
  temper.test('DeleteQuery orWhere', function(test_1108)
    local t_1109, t_1110, t_1111, t_1112, t_1113, t_1114, q__1669, local_1115, local_1116, local_1117, t_1119, fn__11412;
    local_1115, local_1116, local_1117 = temper.pcall(function()
      t_1109 = sid__638('sessions');
      t_1110 = SqlBuilder();
      t_1110:appendSafe('expired = ');
      t_1110:appendBoolean(true);
      t_1111 = t_1110.accumulated;
      t_1112 = deleteFrom(t_1109):where(t_1111);
      t_1113 = SqlBuilder();
      t_1113:appendSafe('created_at < ');
      t_1113:appendString('2023-01-01');
      t_1114 = t_1112:orWhere(t_1113.accumulated):toSql();
      q__1669 = t_1114;
    end);
    if local_1115 then
    else
      q__1669 = temper.bubble();
    end
    t_1119 = temper.str_eq(q__1669:toString(), "DELETE FROM sessions WHERE expired = TRUE OR created_at < '2023-01-01'");
    fn__11412 = function()
      return 'delete orWhere';
    end;
    temper.test_assert(test_1108, t_1119, fn__11412);
    return nil;
  end);
end;
Test_.test_deleteQueryWithLimit__2300 = function()
  temper.test('DeleteQuery with limit', function(test_1120)
    local t_1121, t_1122, t_1123, t_1124, t_1125, q__1671, local_1126, local_1127, local_1128, t_1130, fn__11401;
    local_1126, local_1127, local_1128 = temper.pcall(function()
      t_1121 = sid__638('logs');
      t_1122 = SqlBuilder();
      t_1122:appendSafe('level = ');
      t_1122:appendString('debug');
      t_1123 = t_1122.accumulated;
      t_1124 = deleteFrom(t_1121):where(t_1123):limit(1000);
      t_1125 = t_1124:toSql();
      q__1671 = t_1125;
    end);
    if local_1126 then
    else
      q__1671 = temper.bubble();
    end
    t_1130 = temper.str_eq(q__1671:toString(), "DELETE FROM logs WHERE level = 'debug' LIMIT 1000");
    fn__11401 = function()
      return 'delete limit';
    end;
    temper.test_assert(test_1120, t_1130, fn__11401);
    return nil;
  end);
end;
Test_.test_orderByNullsNullsFirst__2302 = function()
  temper.test('orderByNulls NULLS FIRST', function(test_1131)
    local t_1132, t_1133, t_1134, q__1673, t_1135, fn__11391;
    t_1132 = sid__638('users');
    t_1133 = sid__638('email');
    t_1134 = NullsFirst();
    q__1673 = from(t_1132):orderByNulls(t_1133, true, t_1134);
    t_1135 = temper.str_eq(q__1673:toSql():toString(), 'SELECT * FROM users ORDER BY email ASC NULLS FIRST');
    fn__11391 = function()
      return 'nulls first';
    end;
    temper.test_assert(test_1131, t_1135, fn__11391);
    return nil;
  end);
end;
Test_.test_orderByNullsNullsLast__2303 = function()
  temper.test('orderByNulls NULLS LAST', function(test_1136)
    local t_1137, t_1138, t_1139, q__1675, t_1140, fn__11381;
    t_1137 = sid__638('users');
    t_1138 = sid__638('score');
    t_1139 = NullsLast();
    q__1675 = from(t_1137):orderByNulls(t_1138, false, t_1139);
    t_1140 = temper.str_eq(q__1675:toSql():toString(), 'SELECT * FROM users ORDER BY score DESC NULLS LAST');
    fn__11381 = function()
      return 'nulls last';
    end;
    temper.test_assert(test_1136, t_1140, fn__11381);
    return nil;
  end);
end;
Test_.test_mixedOrderByAndOrderByNulls__2304 = function()
  temper.test('mixed orderBy and orderByNulls', function(test_1141)
    local t_1142, t_1143, q__1677, t_1144, fn__11369;
    t_1142 = sid__638('users');
    t_1143 = sid__638('name');
    q__1677 = from(t_1142):orderBy(t_1143, true):orderByNulls(sid__638('email'), true, NullsFirst());
    t_1144 = temper.str_eq(q__1677:toSql():toString(), 'SELECT * FROM users ORDER BY name ASC, email ASC NULLS FIRST');
    fn__11369 = function()
      return 'mixed order';
    end;
    temper.test_assert(test_1141, t_1144, fn__11369);
    return nil;
  end);
end;
Test_.test_crossJoin__2305 = function()
  temper.test('crossJoin', function(test_1145)
    local t_1146, t_1147, q__1679, t_1148, fn__11360;
    t_1146 = sid__638('users');
    t_1147 = sid__638('colors');
    q__1679 = from(t_1146):crossJoin(t_1147);
    t_1148 = temper.str_eq(q__1679:toSql():toString(), 'SELECT * FROM users CROSS JOIN colors');
    fn__11360 = function()
      return 'cross join';
    end;
    temper.test_assert(test_1145, t_1148, fn__11360);
    return nil;
  end);
end;
Test_.test_crossJoinCombinedWithOtherJoins__2306 = function()
  temper.test('crossJoin combined with other joins', function(test_1149)
    local t_1150, t_1151, t_1152, t_1153, q__1681, t_1154, fn__11346;
    t_1150 = sid__638('users');
    t_1151 = sid__638('orders');
    t_1152 = SqlBuilder();
    t_1152:appendSafe('users.id = orders.user_id');
    t_1153 = t_1152.accumulated;
    q__1681 = from(t_1150):innerJoin(t_1151, t_1153):crossJoin(sid__638('colors'));
    t_1154 = temper.str_eq(q__1681:toSql():toString(), 'SELECT * FROM users INNER JOIN orders ON users.id = orders.user_id CROSS JOIN colors');
    fn__11346 = function()
      return 'cross + inner join';
    end;
    temper.test_assert(test_1149, t_1154, fn__11346);
    return nil;
  end);
end;
Test_.test_lockForUpdate__2308 = function()
  temper.test('lock FOR UPDATE', function(test_1155)
    local t_1156, t_1157, t_1158, q__1683, t_1159, fn__11332;
    t_1156 = sid__638('users');
    t_1157 = SqlBuilder();
    t_1157:appendSafe('id = ');
    t_1157:appendInt32(1);
    t_1158 = t_1157.accumulated;
    q__1683 = from(t_1156):where(t_1158):lock(ForUpdate());
    t_1159 = temper.str_eq(q__1683:toSql():toString(), 'SELECT * FROM users WHERE id = 1 FOR UPDATE');
    fn__11332 = function()
      return 'for update';
    end;
    temper.test_assert(test_1155, t_1159, fn__11332);
    return nil;
  end);
end;
Test_.test_lockForShare__2310 = function()
  temper.test('lock FOR SHARE', function(test_1160)
    local t_1161, t_1162, q__1685, t_1163, fn__11321;
    t_1161 = sid__638('users');
    t_1162 = sid__638('name');
    q__1685 = from(t_1161):select(temper.listof(t_1162)):lock(ForShare());
    t_1163 = temper.str_eq(q__1685:toSql():toString(), 'SELECT name FROM users FOR SHARE');
    fn__11321 = function()
      return 'for share';
    end;
    temper.test_assert(test_1160, t_1163, fn__11321);
    return nil;
  end);
end;
Test_.test_lockWithFullQuery__2311 = function()
  temper.test('lock with full query', function(test_1164)
    local t_1165, t_1166, t_1167, t_1168, t_1169, q__1687, local_1170, local_1171, local_1172, t_1174, fn__11307;
    local_1170, local_1171, local_1172 = temper.pcall(function()
      t_1165 = sid__638('accounts');
      t_1166 = SqlBuilder();
      t_1166:appendSafe('id = ');
      t_1166:appendInt32(42);
      t_1167 = t_1166.accumulated;
      t_1169 = from(t_1165):where(t_1167):limit(1);
      t_1168 = t_1169:lock(ForUpdate());
      q__1687 = t_1168;
    end);
    if local_1170 then
    else
      q__1687 = temper.bubble();
    end
    t_1174 = temper.str_eq(q__1687:toSql():toString(), 'SELECT * FROM accounts WHERE id = 42 LIMIT 1 FOR UPDATE');
    fn__11307 = function()
      return 'lock full query';
    end;
    temper.test_assert(test_1164, t_1174, fn__11307);
    return nil;
  end);
end;
Test_.test_safeIdentifierAcceptsValidNames__2313 = function()
  temper.test('safeIdentifier accepts valid names', function(test_1175)
    local t_1176, id__1725, local_1177, local_1178, local_1179, t_1181, fn__11302;
    local_1177, local_1178, local_1179 = temper.pcall(function()
      t_1176 = safeIdentifier('user_name');
      id__1725 = t_1176;
    end);
    if local_1177 then
    else
      id__1725 = temper.bubble();
    end
    t_1181 = temper.str_eq(id__1725.sqlValue, 'user_name');
    fn__11302 = function()
      return 'value should round-trip';
    end;
    temper.test_assert(test_1175, t_1181, fn__11302);
    return nil;
  end);
end;
Test_.test_safeIdentifierRejectsEmptyString__2314 = function()
  temper.test('safeIdentifier rejects empty string', function(test_1182)
    local didBubble__1727, local_1183, local_1184, local_1185, fn__11299;
    local_1183, local_1184, local_1185 = temper.pcall(function()
      safeIdentifier('');
      didBubble__1727 = false;
    end);
    if local_1183 then
    else
      didBubble__1727 = true;
    end
    fn__11299 = function()
      return 'empty string should bubble';
    end;
    temper.test_assert(test_1182, didBubble__1727, fn__11299);
    return nil;
  end);
end;
Test_.test_safeIdentifierRejectsLeadingDigit__2315 = function()
  temper.test('safeIdentifier rejects leading digit', function(test_1187)
    local didBubble__1729, local_1188, local_1189, local_1190, fn__11296;
    local_1188, local_1189, local_1190 = temper.pcall(function()
      safeIdentifier('1col');
      didBubble__1729 = false;
    end);
    if local_1188 then
    else
      didBubble__1729 = true;
    end
    fn__11296 = function()
      return 'leading digit should bubble';
    end;
    temper.test_assert(test_1187, didBubble__1729, fn__11296);
    return nil;
  end);
end;
Test_.test_safeIdentifierRejectsSqlMetacharacters__2316 = function()
  temper.test('safeIdentifier rejects SQL metacharacters', function(test_1192)
    local cases__1731, fn__11293;
    cases__1731 = temper.listof('name); DROP TABLE', "col'", 'a b', 'a-b', 'a.b', 'a;b');
    fn__11293 = function(c__1732)
      local didBubble__1733, local_1193, local_1194, local_1195, fn__11290;
      local_1193, local_1194, local_1195 = temper.pcall(function()
        safeIdentifier(c__1732);
        didBubble__1733 = false;
      end);
      if local_1193 then
      else
        didBubble__1733 = true;
      end
      fn__11290 = function()
        return temper.concat('should reject: ', c__1732);
      end;
      temper.test_assert(test_1192, didBubble__1733, fn__11290);
      return nil;
    end;
    temper.list_foreach(cases__1731, fn__11293);
    return nil;
  end);
end;
Test_.test_tableDefFieldLookupFound__2317 = function()
  temper.test('TableDef field lookup - found', function(test_1197)
    local t_1198, t_1199, t_1200, t_1201, t_1202, t_1203, t_1204, local_1205, local_1206, local_1207, local_1209, local_1210, local_1211, t_1213, t_1214, local_1215, local_1216, local_1217, t_1219, t_1220, td__1735, f__1736, local_1221, local_1222, local_1223, t_1225, fn__11279;
    local_1205, local_1206, local_1207 = temper.pcall(function()
      t_1198 = safeIdentifier('users');
      t_1199 = t_1198;
    end);
    if local_1205 then
    else
      t_1199 = temper.bubble();
    end
    local_1209, local_1210, local_1211 = temper.pcall(function()
      t_1200 = safeIdentifier('name');
      t_1201 = t_1200;
    end);
    if local_1209 then
    else
      t_1201 = temper.bubble();
    end
    t_1213 = StringField();
    t_1214 = FieldDef(t_1201, t_1213, false);
    local_1215, local_1216, local_1217 = temper.pcall(function()
      t_1202 = safeIdentifier('age');
      t_1203 = t_1202;
    end);
    if local_1215 then
    else
      t_1203 = temper.bubble();
    end
    t_1219 = IntField();
    t_1220 = FieldDef(t_1203, t_1219, false);
    td__1735 = TableDef(t_1199, temper.listof(t_1214, t_1220));
    local_1221, local_1222, local_1223 = temper.pcall(function()
      t_1204 = td__1735:field('age');
      f__1736 = t_1204;
    end);
    if local_1221 then
    else
      f__1736 = temper.bubble();
    end
    t_1225 = temper.str_eq(f__1736.name.sqlValue, 'age');
    fn__11279 = function()
      return 'should find age field';
    end;
    temper.test_assert(test_1197, t_1225, fn__11279);
    return nil;
  end);
end;
Test_.test_tableDefFieldLookupNotFoundBubbles__2318 = function()
  temper.test('TableDef field lookup - not found bubbles', function(test_1226)
    local t_1227, t_1228, t_1229, t_1230, local_1231, local_1232, local_1233, local_1235, local_1236, local_1237, t_1239, t_1240, td__1738, didBubble__1739, local_1241, local_1242, local_1243, fn__11273;
    local_1231, local_1232, local_1233 = temper.pcall(function()
      t_1227 = safeIdentifier('users');
      t_1228 = t_1227;
    end);
    if local_1231 then
    else
      t_1228 = temper.bubble();
    end
    local_1235, local_1236, local_1237 = temper.pcall(function()
      t_1229 = safeIdentifier('name');
      t_1230 = t_1229;
    end);
    if local_1235 then
    else
      t_1230 = temper.bubble();
    end
    t_1239 = StringField();
    t_1240 = FieldDef(t_1230, t_1239, false);
    td__1738 = TableDef(t_1228, temper.listof(t_1240));
    local_1241, local_1242, local_1243 = temper.pcall(function()
      td__1738:field('nonexistent');
      didBubble__1739 = false;
    end);
    if local_1241 then
    else
      didBubble__1739 = true;
    end
    fn__11273 = function()
      return 'unknown field should bubble';
    end;
    temper.test_assert(test_1226, didBubble__1739, fn__11273);
    return nil;
  end);
end;
Test_.test_fieldDefNullableFlag__2319 = function()
  temper.test('FieldDef nullable flag', function(test_1245)
    local t_1246, t_1247, t_1248, t_1249, local_1250, local_1251, local_1252, t_1254, required__1741, local_1255, local_1256, local_1257, t_1259, optional__1742, t_1260, fn__11261, t_1261, fn__11260;
    local_1250, local_1251, local_1252 = temper.pcall(function()
      t_1246 = safeIdentifier('email');
      t_1247 = t_1246;
    end);
    if local_1250 then
    else
      t_1247 = temper.bubble();
    end
    t_1254 = StringField();
    required__1741 = FieldDef(t_1247, t_1254, false);
    local_1255, local_1256, local_1257 = temper.pcall(function()
      t_1248 = safeIdentifier('bio');
      t_1249 = t_1248;
    end);
    if local_1255 then
    else
      t_1249 = temper.bubble();
    end
    t_1259 = StringField();
    optional__1742 = FieldDef(t_1249, t_1259, true);
    t_1260 = not required__1741.nullable;
    fn__11261 = function()
      return 'required field should not be nullable';
    end;
    temper.test_assert(test_1245, t_1260, fn__11261);
    t_1261 = optional__1742.nullable;
    fn__11260 = function()
      return 'optional field should be nullable';
    end;
    temper.test_assert(test_1245, t_1261, fn__11260);
    return nil;
  end);
end;
Test_.test_stringEscaping__2320 = function()
  temper.test('string escaping', function(test_1262)
    local build__1868, buildWrong__1869, actual_1264, t_1265, fn__11249, bobbyTables__1874, actual_1266, t_1267, fn__11248, fn__11247;
    build__1868 = function(name__1870)
      local t_1263;
      t_1263 = SqlBuilder();
      t_1263:appendSafe('select * from hi where name = ');
      t_1263:appendString(name__1870);
      return t_1263.accumulated:toString();
    end;
    buildWrong__1869 = function(name__1872)
      return temper.concat("select * from hi where name = '", name__1872, "'");
    end;
    actual_1264 = build__1868('world');
    t_1265 = temper.str_eq(actual_1264, "select * from hi where name = 'world'");
    fn__11249 = function()
      return temper.concat('expected build("world") == (', "select * from hi where name = 'world'", ') not (', actual_1264, ')');
    end;
    temper.test_assert(test_1262, t_1265, fn__11249);
    bobbyTables__1874 = "Robert'); drop table hi;--";
    actual_1266 = build__1868("Robert'); drop table hi;--");
    t_1267 = temper.str_eq(actual_1266, "select * from hi where name = 'Robert''); drop table hi;--'");
    fn__11248 = function()
      return temper.concat('expected build(bobbyTables) == (', "select * from hi where name = 'Robert''); drop table hi;--'", ') not (', actual_1266, ')');
    end;
    temper.test_assert(test_1262, t_1267, fn__11248);
    fn__11247 = function()
      return "expected buildWrong(bobbyTables) == (select * from hi where name = 'Robert'); drop table hi;--') not (select * from hi where name = 'Robert'); drop table hi;--')";
    end;
    temper.test_assert(test_1262, true, fn__11247);
    return nil;
  end);
end;
Test_.test_stringEdgeCases__2328 = function()
  temper.test('string edge cases', function(test_1268)
    local t_1269, actual_1270, t_1271, fn__11209, t_1272, actual_1273, t_1274, fn__11208, t_1275, actual_1276, t_1277, fn__11207, t_1278, actual_1279, t_1280, fn__11206;
    t_1269 = SqlBuilder();
    t_1269:appendSafe('v = ');
    t_1269:appendString('');
    actual_1270 = t_1269.accumulated:toString();
    t_1271 = temper.str_eq(actual_1270, "v = ''");
    fn__11209 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, "").toString() == (', "v = ''", ') not (', actual_1270, ')');
    end;
    temper.test_assert(test_1268, t_1271, fn__11209);
    t_1272 = SqlBuilder();
    t_1272:appendSafe('v = ');
    t_1272:appendString("a''b");
    actual_1273 = t_1272.accumulated:toString();
    t_1274 = temper.str_eq(actual_1273, "v = 'a''''b'");
    fn__11208 = function()
      return temper.concat("expected stringExpr(`-work//src/`.sql, true, \"v = \", \\interpolate, \"a''b\").toString() == (", "v = 'a''''b'", ') not (', actual_1273, ')');
    end;
    temper.test_assert(test_1268, t_1274, fn__11208);
    t_1275 = SqlBuilder();
    t_1275:appendSafe('v = ');
    t_1275:appendString('Hello \xe4\xb8\x96\xe7\x95\x8c');
    actual_1276 = t_1275.accumulated:toString();
    t_1277 = temper.str_eq(actual_1276, "v = 'Hello \xe4\xb8\x96\xe7\x95\x8c'");
    fn__11207 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, "Hello \xe4\xb8\x96\xe7\x95\x8c").toString() == (', "v = 'Hello \xe4\xb8\x96\xe7\x95\x8c'", ') not (', actual_1276, ')');
    end;
    temper.test_assert(test_1268, t_1277, fn__11207);
    t_1278 = SqlBuilder();
    t_1278:appendSafe('v = ');
    t_1278:appendString('Line1\nLine2');
    actual_1279 = t_1278.accumulated:toString();
    t_1280 = temper.str_eq(actual_1279, "v = 'Line1\nLine2'");
    fn__11206 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, "Line1\\nLine2").toString() == (', "v = 'Line1\nLine2'", ') not (', actual_1279, ')');
    end;
    temper.test_assert(test_1268, t_1280, fn__11206);
    return nil;
  end);
end;
Test_.test_numbersAndBooleans__2341 = function()
  temper.test('numbers and booleans', function(test_1281)
    local t_1282, t_1283, actual_1284, t_1285, fn__11180, date__1877, local_1286, local_1287, local_1288, t_1290, actual_1291, t_1292, fn__11179;
    t_1283 = SqlBuilder();
    t_1283:appendSafe('select ');
    t_1283:appendInt32(42);
    t_1283:appendSafe(', ');
    t_1283:appendInt64(temper.int64_constructor(43));
    t_1283:appendSafe(', ');
    t_1283:appendFloat64(19.99);
    t_1283:appendSafe(', ');
    t_1283:appendBoolean(true);
    t_1283:appendSafe(', ');
    t_1283:appendBoolean(false);
    actual_1284 = t_1283.accumulated:toString();
    t_1285 = temper.str_eq(actual_1284, 'select 42, 43, 19.99, TRUE, FALSE');
    fn__11180 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "select ", \\interpolate, 42, ", ", \\interpolate, 43, ", ", \\interpolate, 19.99, ", ", \\interpolate, true, ", ", \\interpolate, false).toString() == (', 'select 42, 43, 19.99, TRUE, FALSE', ') not (', actual_1284, ')');
    end;
    temper.test_assert(test_1281, t_1285, fn__11180);
    local_1286, local_1287, local_1288 = temper.pcall(function()
      t_1282 = temper.date_constructor(2024, 12, 25);
      date__1877 = t_1282;
    end);
    if local_1286 then
    else
      date__1877 = temper.bubble();
    end
    t_1290 = SqlBuilder();
    t_1290:appendSafe('insert into t values (');
    t_1290:appendDate(date__1877);
    t_1290:appendSafe(')');
    actual_1291 = t_1290.accumulated:toString();
    t_1292 = temper.str_eq(actual_1291, "insert into t values ('2024-12-25')");
    fn__11179 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "insert into t values (", \\interpolate, date, ")").toString() == (', "insert into t values ('2024-12-25')", ') not (', actual_1291, ')');
    end;
    temper.test_assert(test_1281, t_1292, fn__11179);
    return nil;
  end);
end;
Test_.test_lists__2348 = function()
  temper.test('lists', function(test_1293)
    local t_1294, t_1295, t_1296, t_1297, t_1298, actual_1299, t_1300, fn__11124, t_1301, actual_1302, t_1303, fn__11123, t_1304, actual_1305, t_1306, fn__11122, t_1307, actual_1308, t_1309, fn__11121, t_1310, actual_1311, t_1312, fn__11120, local_1313, local_1314, local_1315, local_1317, local_1318, local_1319, dates__1879, t_1321, actual_1322, t_1323, fn__11119;
    t_1298 = SqlBuilder();
    t_1298:appendSafe('v IN (');
    t_1298:appendStringList(temper.listof('a', 'b', "c'd"));
    t_1298:appendSafe(')');
    actual_1299 = t_1298.accumulated:toString();
    t_1300 = temper.str_eq(actual_1299, "v IN ('a', 'b', 'c''d')");
    fn__11124 = function()
      return temper.concat("expected stringExpr(`-work//src/`.sql, true, \"v IN (\", \\interpolate, list(\"a\", \"b\", \"c'd\"), \")\").toString() == (", "v IN ('a', 'b', 'c''d')", ') not (', actual_1299, ')');
    end;
    temper.test_assert(test_1293, t_1300, fn__11124);
    t_1301 = SqlBuilder();
    t_1301:appendSafe('v IN (');
    t_1301:appendInt32List(temper.listof(1, 2, 3));
    t_1301:appendSafe(')');
    actual_1302 = t_1301.accumulated:toString();
    t_1303 = temper.str_eq(actual_1302, 'v IN (1, 2, 3)');
    fn__11123 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v IN (", \\interpolate, list(1, 2, 3), ")").toString() == (', 'v IN (1, 2, 3)', ') not (', actual_1302, ')');
    end;
    temper.test_assert(test_1293, t_1303, fn__11123);
    t_1304 = SqlBuilder();
    t_1304:appendSafe('v IN (');
    t_1304:appendInt64List(temper.listof(temper.int64_constructor(1), temper.int64_constructor(2)));
    t_1304:appendSafe(')');
    actual_1305 = t_1304.accumulated:toString();
    t_1306 = temper.str_eq(actual_1305, 'v IN (1, 2)');
    fn__11122 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v IN (", \\interpolate, list(1, 2), ")").toString() == (', 'v IN (1, 2)', ') not (', actual_1305, ')');
    end;
    temper.test_assert(test_1293, t_1306, fn__11122);
    t_1307 = SqlBuilder();
    t_1307:appendSafe('v IN (');
    t_1307:appendFloat64List(temper.listof(1.0, 2.0));
    t_1307:appendSafe(')');
    actual_1308 = t_1307.accumulated:toString();
    t_1309 = temper.str_eq(actual_1308, 'v IN (1.0, 2.0)');
    fn__11121 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v IN (", \\interpolate, list(1.0, 2.0), ")").toString() == (', 'v IN (1.0, 2.0)', ') not (', actual_1308, ')');
    end;
    temper.test_assert(test_1293, t_1309, fn__11121);
    t_1310 = SqlBuilder();
    t_1310:appendSafe('v IN (');
    t_1310:appendBooleanList(temper.listof(true, false));
    t_1310:appendSafe(')');
    actual_1311 = t_1310.accumulated:toString();
    t_1312 = temper.str_eq(actual_1311, 'v IN (TRUE, FALSE)');
    fn__11120 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v IN (", \\interpolate, list(true, false), ")").toString() == (', 'v IN (TRUE, FALSE)', ') not (', actual_1311, ')');
    end;
    temper.test_assert(test_1293, t_1312, fn__11120);
    local_1313, local_1314, local_1315 = temper.pcall(function()
      t_1294 = temper.date_constructor(2024, 1, 1);
      t_1295 = t_1294;
    end);
    if local_1313 then
    else
      t_1295 = temper.bubble();
    end
    local_1317, local_1318, local_1319 = temper.pcall(function()
      t_1296 = temper.date_constructor(2024, 12, 25);
      t_1297 = t_1296;
    end);
    if local_1317 then
    else
      t_1297 = temper.bubble();
    end
    dates__1879 = temper.listof(t_1295, t_1297);
    t_1321 = SqlBuilder();
    t_1321:appendSafe('v IN (');
    t_1321:appendDateList(dates__1879);
    t_1321:appendSafe(')');
    actual_1322 = t_1321.accumulated:toString();
    t_1323 = temper.str_eq(actual_1322, "v IN ('2024-01-01', '2024-12-25')");
    fn__11119 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v IN (", \\interpolate, dates, ")").toString() == (', "v IN ('2024-01-01', '2024-12-25')", ') not (', actual_1322, ')');
    end;
    temper.test_assert(test_1293, t_1323, fn__11119);
    return nil;
  end);
end;
Test_.test_sqlFloat64_naNRendersAsNull__2367 = function()
  temper.test('SqlFloat64 NaN renders as NULL', function(test_1324)
    local nan__1881, t_1325, actual_1326, t_1327, fn__11110;
    nan__1881 = temper.fdiv(0.0, 0.0);
    t_1325 = SqlBuilder();
    t_1325:appendSafe('v = ');
    t_1325:appendFloat64(nan__1881);
    actual_1326 = t_1325.accumulated:toString();
    t_1327 = temper.str_eq(actual_1326, 'v = NULL');
    fn__11110 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, nan).toString() == (', 'v = NULL', ') not (', actual_1326, ')');
    end;
    temper.test_assert(test_1324, t_1327, fn__11110);
    return nil;
  end);
end;
Test_.test_sqlFloat64_infinityRendersAsNull__2371 = function()
  temper.test('SqlFloat64 Infinity renders as NULL', function(test_1328)
    local inf__1883, t_1329, actual_1330, t_1331, fn__11101;
    inf__1883 = temper.fdiv(1.0, 0.0);
    t_1329 = SqlBuilder();
    t_1329:appendSafe('v = ');
    t_1329:appendFloat64(inf__1883);
    actual_1330 = t_1329.accumulated:toString();
    t_1331 = temper.str_eq(actual_1330, 'v = NULL');
    fn__11101 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, inf).toString() == (', 'v = NULL', ') not (', actual_1330, ')');
    end;
    temper.test_assert(test_1328, t_1331, fn__11101);
    return nil;
  end);
end;
Test_.test_sqlFloat64_negativeInfinityRendersAsNull__2375 = function()
  temper.test('SqlFloat64 negative Infinity renders as NULL', function(test_1332)
    local ninf__1885, t_1333, actual_1334, t_1335, fn__11092;
    ninf__1885 = temper.fdiv(-1.0, 0.0);
    t_1333 = SqlBuilder();
    t_1333:appendSafe('v = ');
    t_1333:appendFloat64(ninf__1885);
    actual_1334 = t_1333.accumulated:toString();
    t_1335 = temper.str_eq(actual_1334, 'v = NULL');
    fn__11092 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, ninf).toString() == (', 'v = NULL', ') not (', actual_1334, ')');
    end;
    temper.test_assert(test_1332, t_1335, fn__11092);
    return nil;
  end);
end;
Test_.test_sqlFloat64_normalValuesStillWork__2379 = function()
  temper.test('SqlFloat64 normal values still work', function(test_1336)
    local t_1337, actual_1338, t_1339, fn__11067, t_1340, actual_1341, t_1342, fn__11066, t_1343, actual_1344, t_1345, fn__11065;
    t_1337 = SqlBuilder();
    t_1337:appendSafe('v = ');
    t_1337:appendFloat64(3.14);
    actual_1338 = t_1337.accumulated:toString();
    t_1339 = temper.str_eq(actual_1338, 'v = 3.14');
    fn__11067 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, 3.14).toString() == (', 'v = 3.14', ') not (', actual_1338, ')');
    end;
    temper.test_assert(test_1336, t_1339, fn__11067);
    t_1340 = SqlBuilder();
    t_1340:appendSafe('v = ');
    t_1340:appendFloat64(0.0);
    actual_1341 = t_1340.accumulated:toString();
    t_1342 = temper.str_eq(actual_1341, 'v = 0.0');
    fn__11066 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, 0.0).toString() == (', 'v = 0.0', ') not (', actual_1341, ')');
    end;
    temper.test_assert(test_1336, t_1342, fn__11066);
    t_1343 = SqlBuilder();
    t_1343:appendSafe('v = ');
    t_1343:appendFloat64(-42.5);
    actual_1344 = t_1343.accumulated:toString();
    t_1345 = temper.str_eq(actual_1344, 'v = -42.5');
    fn__11065 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, -42.5).toString() == (', 'v = -42.5', ') not (', actual_1344, ')');
    end;
    temper.test_assert(test_1336, t_1345, fn__11065);
    return nil;
  end);
end;
Test_.test_sqlDateRendersWithQuotes__2389 = function()
  temper.test('SqlDate renders with quotes', function(test_1346)
    local t_1347, d__1888, local_1348, local_1349, local_1350, t_1352, actual_1353, t_1354, fn__11056;
    local_1348, local_1349, local_1350 = temper.pcall(function()
      t_1347 = temper.date_constructor(2024, 6, 15);
      d__1888 = t_1347;
    end);
    if local_1348 then
    else
      d__1888 = temper.bubble();
    end
    t_1352 = SqlBuilder();
    t_1352:appendSafe('v = ');
    t_1352:appendDate(d__1888);
    actual_1353 = t_1352.accumulated:toString();
    t_1354 = temper.str_eq(actual_1353, "v = '2024-06-15'");
    fn__11056 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, d).toString() == (', "v = '2024-06-15'", ') not (', actual_1353, ')');
    end;
    temper.test_assert(test_1346, t_1354, fn__11056);
    return nil;
  end);
end;
Test_.test_nesting__2393 = function()
  temper.test('nesting', function(test_1355)
    local name__1890, t_1356, condition__1891, t_1357, actual_1358, t_1359, fn__11024, t_1360, actual_1361, t_1362, fn__11023, parts__1892, t_1363, actual_1364, t_1365, fn__11022;
    name__1890 = 'Someone';
    t_1356 = SqlBuilder();
    t_1356:appendSafe('where p.last_name = ');
    t_1356:appendString('Someone');
    condition__1891 = t_1356.accumulated;
    t_1357 = SqlBuilder();
    t_1357:appendSafe('select p.id from person p ');
    t_1357:appendFragment(condition__1891);
    actual_1358 = t_1357.accumulated:toString();
    t_1359 = temper.str_eq(actual_1358, "select p.id from person p where p.last_name = 'Someone'");
    fn__11024 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "select p.id from person p ", \\interpolate, condition).toString() == (', "select p.id from person p where p.last_name = 'Someone'", ') not (', actual_1358, ')');
    end;
    temper.test_assert(test_1355, t_1359, fn__11024);
    t_1360 = SqlBuilder();
    t_1360:appendSafe('select p.id from person p ');
    t_1360:appendPart(condition__1891:toSource());
    actual_1361 = t_1360.accumulated:toString();
    t_1362 = temper.str_eq(actual_1361, "select p.id from person p where p.last_name = 'Someone'");
    fn__11023 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "select p.id from person p ", \\interpolate, condition.toSource()).toString() == (', "select p.id from person p where p.last_name = 'Someone'", ') not (', actual_1361, ')');
    end;
    temper.test_assert(test_1355, t_1362, fn__11023);
    parts__1892 = temper.listof(SqlString("a'b"), SqlInt32(3));
    t_1363 = SqlBuilder();
    t_1363:appendSafe('select ');
    t_1363:appendPartList(parts__1892);
    actual_1364 = t_1363.accumulated:toString();
    t_1365 = temper.str_eq(actual_1364, "select 'a''b', 3");
    fn__11022 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "select ", \\interpolate, parts).toString() == (', "select 'a''b', 3", ') not (', actual_1364, ')');
    end;
    temper.test_assert(test_1355, t_1365, fn__11022);
    return nil;
  end);
end;
exports = {};
local_1367.LuaUnit.run(local_1366({'--pattern', '^Test_%.', local_1366(arg)}));
return exports;
