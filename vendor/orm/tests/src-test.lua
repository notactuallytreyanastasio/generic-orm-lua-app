local temper = require('temper-core');
local safeIdentifier, TableDef, FieldDef, StringField, IntField, FloatField, BoolField, changeset, from, SqlBuilder, col, SqlString, SqlInt32, local_614, local_615, csid__342, userTable__343, sid__344, exports;
safeIdentifier = temper.import('orm/src', 'safeIdentifier');
TableDef = temper.import('orm/src', 'TableDef');
FieldDef = temper.import('orm/src', 'FieldDef');
StringField = temper.import('orm/src', 'StringField');
IntField = temper.import('orm/src', 'IntField');
FloatField = temper.import('orm/src', 'FloatField');
BoolField = temper.import('orm/src', 'BoolField');
changeset = temper.import('orm/src', 'changeset');
from = temper.import('orm/src', 'from');
SqlBuilder = temper.import('orm/src', 'SqlBuilder');
col = temper.import('orm/src', 'col');
SqlString = temper.import('orm/src', 'SqlString');
SqlInt32 = temper.import('orm/src', 'SqlInt32');
local_614 = (unpack or table.unpack);
local_615 = require('luaunit');
local_615.FAILURE_PREFIX = temper.test_failure_prefix;
Test_ = {};
csid__342 = function(name__487)
  local return__221, t_121, local_122, local_123, local_124;
  local_122, local_123, local_124 = temper.pcall(function()
    t_121 = safeIdentifier(name__487);
    return__221 = t_121;
  end);
  if local_122 then
  else
    return__221 = temper.bubble();
  end
  return return__221;
end;
userTable__343 = function()
  return TableDef(csid__342('users'), temper.listof(FieldDef(csid__342('name'), StringField(), false), FieldDef(csid__342('email'), StringField(), false), FieldDef(csid__342('age'), IntField(), true), FieldDef(csid__342('score'), FloatField(), true), FieldDef(csid__342('active'), BoolField(), true)));
end;
Test_.test_castWhitelistsAllowedFields__1020 = function()
  temper.test('cast whitelists allowed fields', function(test_126)
    local params__491, t_127, t_128, t_129, cs__492, t_130, fn__5509, t_131, fn__5508, t_132, fn__5507, t_133, fn__5506;
    params__491 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice'), temper.pair_constructor('email', 'alice@example.com'), temper.pair_constructor('admin', 'true')));
    t_127 = userTable__343();
    t_128 = csid__342('name');
    t_129 = csid__342('email');
    cs__492 = changeset(t_127, params__491):cast(temper.listof(t_128, t_129));
    t_130 = temper.mapped_has(cs__492.changes, 'name');
    fn__5509 = function()
      return 'name should be in changes';
    end;
    temper.test_assert(test_126, t_130, fn__5509);
    t_131 = temper.mapped_has(cs__492.changes, 'email');
    fn__5508 = function()
      return 'email should be in changes';
    end;
    temper.test_assert(test_126, t_131, fn__5508);
    t_132 = not temper.mapped_has(cs__492.changes, 'admin');
    fn__5507 = function()
      return 'admin must be dropped (not in whitelist)';
    end;
    temper.test_assert(test_126, t_132, fn__5507);
    t_133 = cs__492.isValid;
    fn__5506 = function()
      return 'should still be valid';
    end;
    temper.test_assert(test_126, t_133, fn__5506);
    return nil;
  end);
end;
Test_.test_castIsReplacingNotAdditiveSecondCallResetsWhitelist__1021 = function()
  temper.test('cast is replacing not additive \xe2\x80\x94 second call resets whitelist', function(test_134)
    local params__494, t_135, t_136, cs__495, t_137, fn__5488, t_138, fn__5487;
    params__494 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice'), temper.pair_constructor('email', 'alice@example.com')));
    t_135 = userTable__343();
    t_136 = csid__342('name');
    cs__495 = changeset(t_135, params__494):cast(temper.listof(t_136)):cast(temper.listof(csid__342('email')));
    t_137 = not temper.mapped_has(cs__495.changes, 'name');
    fn__5488 = function()
      return 'name must be excluded by second cast';
    end;
    temper.test_assert(test_134, t_137, fn__5488);
    t_138 = temper.mapped_has(cs__495.changes, 'email');
    fn__5487 = function()
      return 'email should be present';
    end;
    temper.test_assert(test_134, t_138, fn__5487);
    return nil;
  end);
end;
Test_.test_castIgnoresEmptyStringValues__1022 = function()
  temper.test('cast ignores empty string values', function(test_139)
    local params__497, t_140, t_141, t_142, cs__498, t_143, fn__5470, t_144, fn__5469;
    params__497 = temper.map_constructor(temper.listof(temper.pair_constructor('name', ''), temper.pair_constructor('email', 'bob@example.com')));
    t_140 = userTable__343();
    t_141 = csid__342('name');
    t_142 = csid__342('email');
    cs__498 = changeset(t_140, params__497):cast(temper.listof(t_141, t_142));
    t_143 = not temper.mapped_has(cs__498.changes, 'name');
    fn__5470 = function()
      return 'empty name should not be in changes';
    end;
    temper.test_assert(test_139, t_143, fn__5470);
    t_144 = temper.mapped_has(cs__498.changes, 'email');
    fn__5469 = function()
      return 'email should be in changes';
    end;
    temper.test_assert(test_139, t_144, fn__5469);
    return nil;
  end);
end;
Test_.test_validateRequiredPassesWhenFieldPresent__1023 = function()
  temper.test('validateRequired passes when field present', function(test_145)
    local params__500, t_146, t_147, cs__501, t_148, fn__5453, t_149, fn__5452;
    params__500 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice')));
    t_146 = userTable__343();
    t_147 = csid__342('name');
    cs__501 = changeset(t_146, params__500):cast(temper.listof(t_147)):validateRequired(temper.listof(csid__342('name')));
    t_148 = cs__501.isValid;
    fn__5453 = function()
      return 'should be valid';
    end;
    temper.test_assert(test_145, t_148, fn__5453);
    t_149 = (temper.list_length(cs__501.errors) == 0);
    fn__5452 = function()
      return 'no errors expected';
    end;
    temper.test_assert(test_145, t_149, fn__5452);
    return nil;
  end);
end;
Test_.test_validateRequiredFailsWhenFieldMissing__1024 = function()
  temper.test('validateRequired fails when field missing', function(test_150)
    local params__503, t_151, t_152, cs__504, t_153, fn__5430, t_154, fn__5429, t_155, fn__5428;
    params__503 = temper.map_constructor(temper.listof());
    t_151 = userTable__343();
    t_152 = csid__342('name');
    cs__504 = changeset(t_151, params__503):cast(temper.listof(t_152)):validateRequired(temper.listof(csid__342('name')));
    t_153 = not cs__504.isValid;
    fn__5430 = function()
      return 'should be invalid';
    end;
    temper.test_assert(test_150, t_153, fn__5430);
    t_154 = (temper.list_length(cs__504.errors) == 1);
    fn__5429 = function()
      return 'should have one error';
    end;
    temper.test_assert(test_150, t_154, fn__5429);
    t_155 = temper.str_eq((temper.list_get(cs__504.errors, 0)).field, 'name');
    fn__5428 = function()
      return 'error should name the field';
    end;
    temper.test_assert(test_150, t_155, fn__5428);
    return nil;
  end);
end;
Test_.test_validateLengthPassesWithinRange__1025 = function()
  temper.test('validateLength passes within range', function(test_156)
    local params__506, t_157, t_158, cs__507, t_159, fn__5417;
    params__506 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice')));
    t_157 = userTable__343();
    t_158 = csid__342('name');
    cs__507 = changeset(t_157, params__506):cast(temper.listof(t_158)):validateLength(csid__342('name'), 2, 50);
    t_159 = cs__507.isValid;
    fn__5417 = function()
      return 'should be valid';
    end;
    temper.test_assert(test_156, t_159, fn__5417);
    return nil;
  end);
end;
Test_.test_validateLengthFailsWhenTooShort__1026 = function()
  temper.test('validateLength fails when too short', function(test_160)
    local params__509, t_161, t_162, cs__510, t_163, fn__5405;
    params__509 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'A')));
    t_161 = userTable__343();
    t_162 = csid__342('name');
    cs__510 = changeset(t_161, params__509):cast(temper.listof(t_162)):validateLength(csid__342('name'), 2, 50);
    t_163 = not cs__510.isValid;
    fn__5405 = function()
      return 'should be invalid';
    end;
    temper.test_assert(test_160, t_163, fn__5405);
    return nil;
  end);
end;
Test_.test_validateLengthFailsWhenTooLong__1027 = function()
  temper.test('validateLength fails when too long', function(test_164)
    local params__512, t_165, t_166, cs__513, t_167, fn__5393;
    params__512 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')));
    t_165 = userTable__343();
    t_166 = csid__342('name');
    cs__513 = changeset(t_165, params__512):cast(temper.listof(t_166)):validateLength(csid__342('name'), 2, 10);
    t_167 = not cs__513.isValid;
    fn__5393 = function()
      return 'should be invalid';
    end;
    temper.test_assert(test_164, t_167, fn__5393);
    return nil;
  end);
end;
Test_.test_validateIntPassesForValidInteger__1028 = function()
  temper.test('validateInt passes for valid integer', function(test_168)
    local params__515, t_169, t_170, cs__516, t_171, fn__5382;
    params__515 = temper.map_constructor(temper.listof(temper.pair_constructor('age', '30')));
    t_169 = userTable__343();
    t_170 = csid__342('age');
    cs__516 = changeset(t_169, params__515):cast(temper.listof(t_170)):validateInt(csid__342('age'));
    t_171 = cs__516.isValid;
    fn__5382 = function()
      return 'should be valid';
    end;
    temper.test_assert(test_168, t_171, fn__5382);
    return nil;
  end);
end;
Test_.test_validateIntFailsForNonInteger__1029 = function()
  temper.test('validateInt fails for non-integer', function(test_172)
    local params__518, t_173, t_174, cs__519, t_175, fn__5370;
    params__518 = temper.map_constructor(temper.listof(temper.pair_constructor('age', 'not-a-number')));
    t_173 = userTable__343();
    t_174 = csid__342('age');
    cs__519 = changeset(t_173, params__518):cast(temper.listof(t_174)):validateInt(csid__342('age'));
    t_175 = not cs__519.isValid;
    fn__5370 = function()
      return 'should be invalid';
    end;
    temper.test_assert(test_172, t_175, fn__5370);
    return nil;
  end);
end;
Test_.test_validateFloatPassesForValidFloat__1030 = function()
  temper.test('validateFloat passes for valid float', function(test_176)
    local params__521, t_177, t_178, cs__522, t_179, fn__5359;
    params__521 = temper.map_constructor(temper.listof(temper.pair_constructor('score', '9.5')));
    t_177 = userTable__343();
    t_178 = csid__342('score');
    cs__522 = changeset(t_177, params__521):cast(temper.listof(t_178)):validateFloat(csid__342('score'));
    t_179 = cs__522.isValid;
    fn__5359 = function()
      return 'should be valid';
    end;
    temper.test_assert(test_176, t_179, fn__5359);
    return nil;
  end);
end;
Test_.test_validateInt64_passesForValid64_bitInteger__1031 = function()
  temper.test('validateInt64 passes for valid 64-bit integer', function(test_180)
    local params__524, t_181, t_182, cs__525, t_183, fn__5348;
    params__524 = temper.map_constructor(temper.listof(temper.pair_constructor('age', '9999999999')));
    t_181 = userTable__343();
    t_182 = csid__342('age');
    cs__525 = changeset(t_181, params__524):cast(temper.listof(t_182)):validateInt64(csid__342('age'));
    t_183 = cs__525.isValid;
    fn__5348 = function()
      return 'should be valid';
    end;
    temper.test_assert(test_180, t_183, fn__5348);
    return nil;
  end);
end;
Test_.test_validateInt64_failsForNonInteger__1032 = function()
  temper.test('validateInt64 fails for non-integer', function(test_184)
    local params__527, t_185, t_186, cs__528, t_187, fn__5336;
    params__527 = temper.map_constructor(temper.listof(temper.pair_constructor('age', 'not-a-number')));
    t_185 = userTable__343();
    t_186 = csid__342('age');
    cs__528 = changeset(t_185, params__527):cast(temper.listof(t_186)):validateInt64(csid__342('age'));
    t_187 = not cs__528.isValid;
    fn__5336 = function()
      return 'should be invalid';
    end;
    temper.test_assert(test_184, t_187, fn__5336);
    return nil;
  end);
end;
Test_.test_validateBoolAcceptsTrue1_yesOn__1033 = function()
  temper.test('validateBool accepts true/1/yes/on', function(test_188)
    local fn__5333;
    fn__5333 = function(v__530)
      local params__531, t_189, t_190, cs__532, t_191, fn__5322;
      params__531 = temper.map_constructor(temper.listof(temper.pair_constructor('active', v__530)));
      t_189 = userTable__343();
      t_190 = csid__342('active');
      cs__532 = changeset(t_189, params__531):cast(temper.listof(t_190)):validateBool(csid__342('active'));
      t_191 = cs__532.isValid;
      fn__5322 = function()
        return temper.concat('should accept: ', v__530);
      end;
      temper.test_assert(test_188, t_191, fn__5322);
      return nil;
    end;
    temper.list_foreach(temper.listof('true', '1', 'yes', 'on'), fn__5333);
    return nil;
  end);
end;
Test_.test_validateBoolAcceptsFalse0_noOff__1034 = function()
  temper.test('validateBool accepts false/0/no/off', function(test_192)
    local fn__5319;
    fn__5319 = function(v__534)
      local params__535, t_193, t_194, cs__536, t_195, fn__5308;
      params__535 = temper.map_constructor(temper.listof(temper.pair_constructor('active', v__534)));
      t_193 = userTable__343();
      t_194 = csid__342('active');
      cs__536 = changeset(t_193, params__535):cast(temper.listof(t_194)):validateBool(csid__342('active'));
      t_195 = cs__536.isValid;
      fn__5308 = function()
        return temper.concat('should accept: ', v__534);
      end;
      temper.test_assert(test_192, t_195, fn__5308);
      return nil;
    end;
    temper.list_foreach(temper.listof('false', '0', 'no', 'off'), fn__5319);
    return nil;
  end);
end;
Test_.test_validateBoolRejectsAmbiguousValues__1035 = function()
  temper.test('validateBool rejects ambiguous values', function(test_196)
    local fn__5305;
    fn__5305 = function(v__538)
      local params__539, t_197, t_198, cs__540, t_199, fn__5293;
      params__539 = temper.map_constructor(temper.listof(temper.pair_constructor('active', v__538)));
      t_197 = userTable__343();
      t_198 = csid__342('active');
      cs__540 = changeset(t_197, params__539):cast(temper.listof(t_198)):validateBool(csid__342('active'));
      t_199 = not cs__540.isValid;
      fn__5293 = function()
        return temper.concat('should reject ambiguous: ', v__538);
      end;
      temper.test_assert(test_196, t_199, fn__5293);
      return nil;
    end;
    temper.list_foreach(temper.listof('TRUE', 'Yes', 'maybe', '2', 'enabled'), fn__5305);
    return nil;
  end);
end;
Test_.test_toInsertSqlEscapesBobbyTables__1036 = function()
  temper.test('toInsertSql escapes Bobby Tables', function(test_200)
    local t_201, params__542, t_202, t_203, t_204, cs__543, sqlFrag__544, local_205, local_206, local_207, s__545, t_209, fn__5277;
    params__542 = temper.map_constructor(temper.listof(temper.pair_constructor('name', "Robert'); DROP TABLE users;--"), temper.pair_constructor('email', 'bobby@evil.com')));
    t_202 = userTable__343();
    t_203 = csid__342('name');
    t_204 = csid__342('email');
    cs__543 = changeset(t_202, params__542):cast(temper.listof(t_203, t_204)):validateRequired(temper.listof(csid__342('name'), csid__342('email')));
    local_205, local_206, local_207 = temper.pcall(function()
      t_201 = cs__543:toInsertSql();
      sqlFrag__544 = t_201;
    end);
    if local_205 then
    else
      sqlFrag__544 = temper.bubble();
    end
    s__545 = sqlFrag__544:toString();
    t_209 = temper.is_string_index(temper.string_indexof(s__545, "''"));
    fn__5277 = function()
      return temper.concat('single quote must be doubled: ', s__545);
    end;
    temper.test_assert(test_200, t_209, fn__5277);
    return nil;
  end);
end;
Test_.test_toInsertSqlProducesCorrectSqlForStringField__1037 = function()
  temper.test('toInsertSql produces correct SQL for string field', function(test_210)
    local t_211, params__547, t_212, t_213, t_214, cs__548, sqlFrag__549, local_215, local_216, local_217, s__550, t_219, fn__5257, t_220, fn__5256;
    params__547 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice'), temper.pair_constructor('email', 'a@example.com')));
    t_212 = userTable__343();
    t_213 = csid__342('name');
    t_214 = csid__342('email');
    cs__548 = changeset(t_212, params__547):cast(temper.listof(t_213, t_214)):validateRequired(temper.listof(csid__342('name'), csid__342('email')));
    local_215, local_216, local_217 = temper.pcall(function()
      t_211 = cs__548:toInsertSql();
      sqlFrag__549 = t_211;
    end);
    if local_215 then
    else
      sqlFrag__549 = temper.bubble();
    end
    s__550 = sqlFrag__549:toString();
    t_219 = temper.is_string_index(temper.string_indexof(s__550, 'INSERT INTO users'));
    fn__5257 = function()
      return temper.concat('has INSERT INTO: ', s__550);
    end;
    temper.test_assert(test_210, t_219, fn__5257);
    t_220 = temper.is_string_index(temper.string_indexof(s__550, "'Alice'"));
    fn__5256 = function()
      return temper.concat('has quoted name: ', s__550);
    end;
    temper.test_assert(test_210, t_220, fn__5256);
    return nil;
  end);
end;
Test_.test_toInsertSqlProducesCorrectSqlForIntField__1038 = function()
  temper.test('toInsertSql produces correct SQL for int field', function(test_221)
    local t_222, params__552, t_223, t_224, t_225, t_226, cs__553, sqlFrag__554, local_227, local_228, local_229, s__555, t_231, fn__5238;
    params__552 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Bob'), temper.pair_constructor('email', 'b@example.com'), temper.pair_constructor('age', '25')));
    t_223 = userTable__343();
    t_224 = csid__342('name');
    t_225 = csid__342('email');
    t_226 = csid__342('age');
    cs__553 = changeset(t_223, params__552):cast(temper.listof(t_224, t_225, t_226)):validateRequired(temper.listof(csid__342('name'), csid__342('email')));
    local_227, local_228, local_229 = temper.pcall(function()
      t_222 = cs__553:toInsertSql();
      sqlFrag__554 = t_222;
    end);
    if local_227 then
    else
      sqlFrag__554 = temper.bubble();
    end
    s__555 = sqlFrag__554:toString();
    t_231 = temper.is_string_index(temper.string_indexof(s__555, '25'));
    fn__5238 = function()
      return temper.concat('age rendered unquoted: ', s__555);
    end;
    temper.test_assert(test_221, t_231, fn__5238);
    return nil;
  end);
end;
Test_.test_toInsertSqlBubblesOnInvalidChangeset__1039 = function()
  temper.test('toInsertSql bubbles on invalid changeset', function(test_232)
    local params__557, t_233, t_234, cs__558, didBubble__559, local_235, local_236, local_237, fn__5229;
    params__557 = temper.map_constructor(temper.listof());
    t_233 = userTable__343();
    t_234 = csid__342('name');
    cs__558 = changeset(t_233, params__557):cast(temper.listof(t_234)):validateRequired(temper.listof(csid__342('name')));
    local_235, local_236, local_237 = temper.pcall(function()
      cs__558:toInsertSql();
      didBubble__559 = false;
    end);
    if local_235 then
    else
      didBubble__559 = true;
    end
    fn__5229 = function()
      return 'invalid changeset should bubble';
    end;
    temper.test_assert(test_232, didBubble__559, fn__5229);
    return nil;
  end);
end;
Test_.test_toInsertSqlEnforcesNonNullableFieldsIndependentlyOfIsValid__1040 = function()
  temper.test('toInsertSql enforces non-nullable fields independently of isValid', function(test_239)
    local strictTable__561, params__562, t_240, cs__563, t_241, fn__5211, didBubble__564, local_242, local_243, local_244, fn__5210;
    strictTable__561 = TableDef(csid__342('posts'), temper.listof(FieldDef(csid__342('title'), StringField(), false), FieldDef(csid__342('body'), StringField(), true)));
    params__562 = temper.map_constructor(temper.listof(temper.pair_constructor('body', 'hello')));
    t_240 = csid__342('body');
    cs__563 = changeset(strictTable__561, params__562):cast(temper.listof(t_240));
    t_241 = cs__563.isValid;
    fn__5211 = function()
      return 'changeset should appear valid (no explicit validation run)';
    end;
    temper.test_assert(test_239, t_241, fn__5211);
    local_242, local_243, local_244 = temper.pcall(function()
      cs__563:toInsertSql();
      didBubble__564 = false;
    end);
    if local_242 then
    else
      didBubble__564 = true;
    end
    fn__5210 = function()
      return 'toInsertSql should enforce nullable regardless of isValid';
    end;
    temper.test_assert(test_239, didBubble__564, fn__5210);
    return nil;
  end);
end;
Test_.test_toUpdateSqlProducesCorrectSql__1041 = function()
  temper.test('toUpdateSql produces correct SQL', function(test_246)
    local t_247, params__566, t_248, t_249, cs__567, sqlFrag__568, local_250, local_251, local_252, s__569, t_254, fn__5198;
    params__566 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Bob')));
    t_248 = userTable__343();
    t_249 = csid__342('name');
    cs__567 = changeset(t_248, params__566):cast(temper.listof(t_249)):validateRequired(temper.listof(csid__342('name')));
    local_250, local_251, local_252 = temper.pcall(function()
      t_247 = cs__567:toUpdateSql(42);
      sqlFrag__568 = t_247;
    end);
    if local_250 then
    else
      sqlFrag__568 = temper.bubble();
    end
    s__569 = sqlFrag__568:toString();
    t_254 = temper.str_eq(s__569, "UPDATE users SET name = 'Bob' WHERE id = 42");
    fn__5198 = function()
      return temper.concat('got: ', s__569);
    end;
    temper.test_assert(test_246, t_254, fn__5198);
    return nil;
  end);
end;
Test_.test_toUpdateSqlBubblesOnInvalidChangeset__1042 = function()
  temper.test('toUpdateSql bubbles on invalid changeset', function(test_255)
    local params__571, t_256, t_257, cs__572, didBubble__573, local_258, local_259, local_260, fn__5189;
    params__571 = temper.map_constructor(temper.listof());
    t_256 = userTable__343();
    t_257 = csid__342('name');
    cs__572 = changeset(t_256, params__571):cast(temper.listof(t_257)):validateRequired(temper.listof(csid__342('name')));
    local_258, local_259, local_260 = temper.pcall(function()
      cs__572:toUpdateSql(1);
      didBubble__573 = false;
    end);
    if local_258 then
    else
      didBubble__573 = true;
    end
    fn__5189 = function()
      return 'invalid changeset should bubble';
    end;
    temper.test_assert(test_255, didBubble__573, fn__5189);
    return nil;
  end);
end;
sid__344 = function(name__678)
  local return__263, t_262, local_263, local_264, local_265;
  local_263, local_264, local_265 = temper.pcall(function()
    t_262 = safeIdentifier(name__678);
    return__263 = t_262;
  end);
  if local_263 then
  else
    return__263 = temper.bubble();
  end
  return return__263;
end;
Test_.test_bareFromProducesSelect__1079 = function()
  temper.test('bare from produces SELECT *', function(test_267)
    local q__681, t_268, fn__5079;
    q__681 = from(sid__344('users'));
    t_268 = temper.str_eq(q__681:toSql():toString(), 'SELECT * FROM users');
    fn__5079 = function()
      return 'bare query';
    end;
    temper.test_assert(test_267, t_268, fn__5079);
    return nil;
  end);
end;
Test_.test_selectRestrictsColumns__1080 = function()
  temper.test('select restricts columns', function(test_269)
    local t_270, t_271, t_272, q__683, t_273, fn__5069;
    t_270 = sid__344('users');
    t_271 = sid__344('id');
    t_272 = sid__344('name');
    q__683 = from(t_270):select(temper.listof(t_271, t_272));
    t_273 = temper.str_eq(q__683:toSql():toString(), 'SELECT id, name FROM users');
    fn__5069 = function()
      return 'select columns';
    end;
    temper.test_assert(test_269, t_273, fn__5069);
    return nil;
  end);
end;
Test_.test_whereAddsConditionWithIntValue__1081 = function()
  temper.test('where adds condition with int value', function(test_274)
    local t_275, t_276, t_277, q__685, t_278, fn__5057;
    t_275 = sid__344('users');
    t_276 = SqlBuilder();
    t_276:appendSafe('age > ');
    t_276:appendInt32(18);
    t_277 = t_276.accumulated;
    q__685 = from(t_275):where(t_277);
    t_278 = temper.str_eq(q__685:toSql():toString(), 'SELECT * FROM users WHERE age > 18');
    fn__5057 = function()
      return 'where int';
    end;
    temper.test_assert(test_274, t_278, fn__5057);
    return nil;
  end);
end;
Test_.test_whereAddsConditionWithBoolValue__1083 = function()
  temper.test('where adds condition with bool value', function(test_279)
    local t_280, t_281, t_282, q__687, t_283, fn__5045;
    t_280 = sid__344('users');
    t_281 = SqlBuilder();
    t_281:appendSafe('active = ');
    t_281:appendBoolean(true);
    t_282 = t_281.accumulated;
    q__687 = from(t_280):where(t_282);
    t_283 = temper.str_eq(q__687:toSql():toString(), 'SELECT * FROM users WHERE active = TRUE');
    fn__5045 = function()
      return 'where bool';
    end;
    temper.test_assert(test_279, t_283, fn__5045);
    return nil;
  end);
end;
Test_.test_chainedWhereUsesAnd__1085 = function()
  temper.test('chained where uses AND', function(test_284)
    local t_285, t_286, t_287, t_288, t_289, q__689, t_290, fn__5028;
    t_285 = sid__344('users');
    t_286 = SqlBuilder();
    t_286:appendSafe('age > ');
    t_286:appendInt32(18);
    t_287 = t_286.accumulated;
    t_288 = from(t_285):where(t_287);
    t_289 = SqlBuilder();
    t_289:appendSafe('active = ');
    t_289:appendBoolean(true);
    q__689 = t_288:where(t_289.accumulated);
    t_290 = temper.str_eq(q__689:toSql():toString(), 'SELECT * FROM users WHERE age > 18 AND active = TRUE');
    fn__5028 = function()
      return 'chained where';
    end;
    temper.test_assert(test_284, t_290, fn__5028);
    return nil;
  end);
end;
Test_.test_orderByAsc__1088 = function()
  temper.test('orderBy ASC', function(test_291)
    local t_292, t_293, q__691, t_294, fn__5019;
    t_292 = sid__344('users');
    t_293 = sid__344('name');
    q__691 = from(t_292):orderBy(t_293, true);
    t_294 = temper.str_eq(q__691:toSql():toString(), 'SELECT * FROM users ORDER BY name ASC');
    fn__5019 = function()
      return 'order asc';
    end;
    temper.test_assert(test_291, t_294, fn__5019);
    return nil;
  end);
end;
Test_.test_orderByDesc__1089 = function()
  temper.test('orderBy DESC', function(test_295)
    local t_296, t_297, q__693, t_298, fn__5010;
    t_296 = sid__344('users');
    t_297 = sid__344('created_at');
    q__693 = from(t_296):orderBy(t_297, false);
    t_298 = temper.str_eq(q__693:toSql():toString(), 'SELECT * FROM users ORDER BY created_at DESC');
    fn__5010 = function()
      return 'order desc';
    end;
    temper.test_assert(test_295, t_298, fn__5010);
    return nil;
  end);
end;
Test_.test_limitAndOffset__1090 = function()
  temper.test('limit and offset', function(test_299)
    local t_300, t_301, q__695, local_302, local_303, local_304, t_306, fn__5003;
    local_302, local_303, local_304 = temper.pcall(function()
      t_300 = from(sid__344('users')):limit(10);
      t_301 = t_300:offset(20);
      q__695 = t_301;
    end);
    if local_302 then
    else
      q__695 = temper.bubble();
    end
    t_306 = temper.str_eq(q__695:toSql():toString(), 'SELECT * FROM users LIMIT 10 OFFSET 20');
    fn__5003 = function()
      return 'limit/offset';
    end;
    temper.test_assert(test_299, t_306, fn__5003);
    return nil;
  end);
end;
Test_.test_limitBubblesOnNegative__1091 = function()
  temper.test('limit bubbles on negative', function(test_307)
    local didBubble__697, local_308, local_309, local_310, fn__4999;
    local_308, local_309, local_310 = temper.pcall(function()
      from(sid__344('users')):limit(-1);
      didBubble__697 = false;
    end);
    if local_308 then
    else
      didBubble__697 = true;
    end
    fn__4999 = function()
      return 'negative limit should bubble';
    end;
    temper.test_assert(test_307, didBubble__697, fn__4999);
    return nil;
  end);
end;
Test_.test_offsetBubblesOnNegative__1092 = function()
  temper.test('offset bubbles on negative', function(test_312)
    local didBubble__699, local_313, local_314, local_315, fn__4995;
    local_313, local_314, local_315 = temper.pcall(function()
      from(sid__344('users')):offset(-1);
      didBubble__699 = false;
    end);
    if local_313 then
    else
      didBubble__699 = true;
    end
    fn__4995 = function()
      return 'negative offset should bubble';
    end;
    temper.test_assert(test_312, didBubble__699, fn__4995);
    return nil;
  end);
end;
Test_.test_complexComposedQuery__1093 = function()
  temper.test('complex composed query', function(test_317)
    local t_318, t_319, t_320, t_321, t_322, t_323, t_324, t_325, t_326, t_327, minAge__701, q__702, local_328, local_329, local_330, t_332, fn__4972;
    minAge__701 = 21;
    local_328, local_329, local_330 = temper.pcall(function()
      t_318 = sid__344('users');
      t_319 = sid__344('id');
      t_320 = sid__344('name');
      t_321 = sid__344('email');
      t_322 = from(t_318):select(temper.listof(t_319, t_320, t_321));
      t_323 = SqlBuilder();
      t_323:appendSafe('age >= ');
      t_323:appendInt32(21);
      t_324 = t_322:where(t_323.accumulated);
      t_325 = SqlBuilder();
      t_325:appendSafe('active = ');
      t_325:appendBoolean(true);
      t_326 = t_324:where(t_325.accumulated):orderBy(sid__344('name'), true):limit(25);
      t_327 = t_326:offset(0);
      q__702 = t_327;
    end);
    if local_328 then
    else
      q__702 = temper.bubble();
    end
    t_332 = temper.str_eq(q__702:toSql():toString(), 'SELECT id, name, email FROM users WHERE age >= 21 AND active = TRUE ORDER BY name ASC LIMIT 25 OFFSET 0');
    fn__4972 = function()
      return 'complex query';
    end;
    temper.test_assert(test_317, t_332, fn__4972);
    return nil;
  end);
end;
Test_.test_safeToSqlAppliesDefaultLimitWhenNoneSet__1096 = function()
  temper.test('safeToSql applies default limit when none set', function(test_333)
    local t_334, t_335, q__704, local_336, local_337, local_338, s__705, t_340, fn__4966;
    q__704 = from(sid__344('users'));
    local_336, local_337, local_338 = temper.pcall(function()
      t_334 = q__704:safeToSql(100);
      t_335 = t_334;
    end);
    if local_336 then
    else
      t_335 = temper.bubble();
    end
    s__705 = t_335:toString();
    t_340 = temper.str_eq(s__705, 'SELECT * FROM users LIMIT 100');
    fn__4966 = function()
      return temper.concat('should have limit: ', s__705);
    end;
    temper.test_assert(test_333, t_340, fn__4966);
    return nil;
  end);
end;
Test_.test_safeToSqlRespectsExplicitLimit__1097 = function()
  temper.test('safeToSql respects explicit limit', function(test_341)
    local t_342, t_343, t_344, q__707, local_345, local_346, local_347, local_349, local_350, local_351, s__708, t_353, fn__4960;
    local_345, local_346, local_347 = temper.pcall(function()
      t_342 = from(sid__344('users')):limit(5);
      q__707 = t_342;
    end);
    if local_345 then
    else
      q__707 = temper.bubble();
    end
    local_349, local_350, local_351 = temper.pcall(function()
      t_343 = q__707:safeToSql(100);
      t_344 = t_343;
    end);
    if local_349 then
    else
      t_344 = temper.bubble();
    end
    s__708 = t_344:toString();
    t_353 = temper.str_eq(s__708, 'SELECT * FROM users LIMIT 5');
    fn__4960 = function()
      return temper.concat('explicit limit preserved: ', s__708);
    end;
    temper.test_assert(test_341, t_353, fn__4960);
    return nil;
  end);
end;
Test_.test_safeToSqlBubblesOnNegativeDefaultLimit__1098 = function()
  temper.test('safeToSql bubbles on negative defaultLimit', function(test_354)
    local didBubble__710, local_355, local_356, local_357, fn__4956;
    local_355, local_356, local_357 = temper.pcall(function()
      from(sid__344('users')):safeToSql(-1);
      didBubble__710 = false;
    end);
    if local_355 then
    else
      didBubble__710 = true;
    end
    fn__4956 = function()
      return 'negative defaultLimit should bubble';
    end;
    temper.test_assert(test_354, didBubble__710, fn__4956);
    return nil;
  end);
end;
Test_.test_whereWithInjectionAttemptInStringValueIsEscaped__1099 = function()
  temper.test('where with injection attempt in string value is escaped', function(test_359)
    local evil__712, t_360, t_361, t_362, q__713, s__714, t_363, fn__4939, t_364, fn__4938;
    evil__712 = "'; DROP TABLE users; --";
    t_360 = sid__344('users');
    t_361 = SqlBuilder();
    t_361:appendSafe('name = ');
    t_361:appendString("'; DROP TABLE users; --");
    t_362 = t_361.accumulated;
    q__713 = from(t_360):where(t_362);
    s__714 = q__713:toSql():toString();
    t_363 = temper.is_string_index(temper.string_indexof(s__714, "''"));
    fn__4939 = function()
      return temper.concat('quotes must be doubled: ', s__714);
    end;
    temper.test_assert(test_359, t_363, fn__4939);
    t_364 = temper.is_string_index(temper.string_indexof(s__714, 'SELECT * FROM users WHERE name ='));
    fn__4938 = function()
      return temper.concat('structure intact: ', s__714);
    end;
    temper.test_assert(test_359, t_364, fn__4938);
    return nil;
  end);
end;
Test_.test_safeIdentifierRejectsUserSuppliedTableNameWithMetacharacters__1101 = function()
  temper.test('safeIdentifier rejects user-supplied table name with metacharacters', function(test_365)
    local attack__716, didBubble__717, local_366, local_367, local_368, fn__4935;
    attack__716 = 'users; DROP TABLE users; --';
    local_366, local_367, local_368 = temper.pcall(function()
      safeIdentifier('users; DROP TABLE users; --');
      didBubble__717 = false;
    end);
    if local_366 then
    else
      didBubble__717 = true;
    end
    fn__4935 = function()
      return 'metacharacter-containing name must be rejected at construction';
    end;
    temper.test_assert(test_365, didBubble__717, fn__4935);
    return nil;
  end);
end;
Test_.test_innerJoinProducesInnerJoin__1102 = function()
  temper.test('innerJoin produces INNER JOIN', function(test_370)
    local t_371, t_372, t_373, t_374, q__719, t_375, fn__4923;
    t_371 = sid__344('users');
    t_372 = sid__344('orders');
    t_373 = SqlBuilder();
    t_373:appendSafe('users.id = orders.user_id');
    t_374 = t_373.accumulated;
    q__719 = from(t_371):innerJoin(t_372, t_374);
    t_375 = temper.str_eq(q__719:toSql():toString(), 'SELECT * FROM users INNER JOIN orders ON users.id = orders.user_id');
    fn__4923 = function()
      return 'inner join';
    end;
    temper.test_assert(test_370, t_375, fn__4923);
    return nil;
  end);
end;
Test_.test_leftJoinProducesLeftJoin__1104 = function()
  temper.test('leftJoin produces LEFT JOIN', function(test_376)
    local t_377, t_378, t_379, t_380, q__721, t_381, fn__4911;
    t_377 = sid__344('users');
    t_378 = sid__344('profiles');
    t_379 = SqlBuilder();
    t_379:appendSafe('users.id = profiles.user_id');
    t_380 = t_379.accumulated;
    q__721 = from(t_377):leftJoin(t_378, t_380);
    t_381 = temper.str_eq(q__721:toSql():toString(), 'SELECT * FROM users LEFT JOIN profiles ON users.id = profiles.user_id');
    fn__4911 = function()
      return 'left join';
    end;
    temper.test_assert(test_376, t_381, fn__4911);
    return nil;
  end);
end;
Test_.test_rightJoinProducesRightJoin__1106 = function()
  temper.test('rightJoin produces RIGHT JOIN', function(test_382)
    local t_383, t_384, t_385, t_386, q__723, t_387, fn__4899;
    t_383 = sid__344('orders');
    t_384 = sid__344('users');
    t_385 = SqlBuilder();
    t_385:appendSafe('orders.user_id = users.id');
    t_386 = t_385.accumulated;
    q__723 = from(t_383):rightJoin(t_384, t_386);
    t_387 = temper.str_eq(q__723:toSql():toString(), 'SELECT * FROM orders RIGHT JOIN users ON orders.user_id = users.id');
    fn__4899 = function()
      return 'right join';
    end;
    temper.test_assert(test_382, t_387, fn__4899);
    return nil;
  end);
end;
Test_.test_fullJoinProducesFullOuterJoin__1108 = function()
  temper.test('fullJoin produces FULL OUTER JOIN', function(test_388)
    local t_389, t_390, t_391, t_392, q__725, t_393, fn__4887;
    t_389 = sid__344('users');
    t_390 = sid__344('orders');
    t_391 = SqlBuilder();
    t_391:appendSafe('users.id = orders.user_id');
    t_392 = t_391.accumulated;
    q__725 = from(t_389):fullJoin(t_390, t_392);
    t_393 = temper.str_eq(q__725:toSql():toString(), 'SELECT * FROM users FULL OUTER JOIN orders ON users.id = orders.user_id');
    fn__4887 = function()
      return 'full join';
    end;
    temper.test_assert(test_388, t_393, fn__4887);
    return nil;
  end);
end;
Test_.test_chainedJoins__1110 = function()
  temper.test('chained joins', function(test_394)
    local t_395, t_396, t_397, t_398, t_399, t_400, t_401, q__727, t_402, fn__4870;
    t_395 = sid__344('users');
    t_396 = sid__344('orders');
    t_397 = SqlBuilder();
    t_397:appendSafe('users.id = orders.user_id');
    t_398 = t_397.accumulated;
    t_399 = from(t_395):innerJoin(t_396, t_398);
    t_400 = sid__344('profiles');
    t_401 = SqlBuilder();
    t_401:appendSafe('users.id = profiles.user_id');
    q__727 = t_399:leftJoin(t_400, t_401.accumulated);
    t_402 = temper.str_eq(q__727:toSql():toString(), 'SELECT * FROM users INNER JOIN orders ON users.id = orders.user_id LEFT JOIN profiles ON users.id = profiles.user_id');
    fn__4870 = function()
      return 'chained joins';
    end;
    temper.test_assert(test_394, t_402, fn__4870);
    return nil;
  end);
end;
Test_.test_joinWithWhereAndOrderBy__1113 = function()
  temper.test('join with where and orderBy', function(test_403)
    local t_404, t_405, t_406, t_407, t_408, t_409, t_410, q__729, local_411, local_412, local_413, t_415, fn__4851;
    local_411, local_412, local_413 = temper.pcall(function()
      t_404 = sid__344('users');
      t_405 = sid__344('orders');
      t_406 = SqlBuilder();
      t_406:appendSafe('users.id = orders.user_id');
      t_407 = t_406.accumulated;
      t_408 = from(t_404):innerJoin(t_405, t_407);
      t_409 = SqlBuilder();
      t_409:appendSafe('orders.total > ');
      t_409:appendInt32(100);
      t_410 = t_408:where(t_409.accumulated):orderBy(sid__344('name'), true):limit(10);
      q__729 = t_410;
    end);
    if local_411 then
    else
      q__729 = temper.bubble();
    end
    t_415 = temper.str_eq(q__729:toSql():toString(), 'SELECT * FROM users INNER JOIN orders ON users.id = orders.user_id WHERE orders.total > 100 ORDER BY name ASC LIMIT 10');
    fn__4851 = function()
      return 'join with where/order/limit';
    end;
    temper.test_assert(test_403, t_415, fn__4851);
    return nil;
  end);
end;
Test_.test_colHelperProducesQualifiedReference__1116 = function()
  temper.test('col helper produces qualified reference', function(test_416)
    local c__731, t_417, fn__4843;
    c__731 = col(sid__344('users'), sid__344('id'));
    t_417 = temper.str_eq(c__731:toString(), 'users.id');
    fn__4843 = function()
      return 'col helper';
    end;
    temper.test_assert(test_416, t_417, fn__4843);
    return nil;
  end);
end;
Test_.test_joinWithColHelper__1117 = function()
  temper.test('join with col helper', function(test_418)
    local onCond__733, b__734, t_419, t_420, t_421, q__735, t_422, fn__4823;
    onCond__733 = col(sid__344('users'), sid__344('id'));
    b__734 = SqlBuilder();
    b__734:appendFragment(onCond__733);
    b__734:appendSafe(' = ');
    b__734:appendFragment(col(sid__344('orders'), sid__344('user_id')));
    t_419 = sid__344('users');
    t_420 = sid__344('orders');
    t_421 = b__734.accumulated;
    q__735 = from(t_419):innerJoin(t_420, t_421);
    t_422 = temper.str_eq(q__735:toSql():toString(), 'SELECT * FROM users INNER JOIN orders ON users.id = orders.user_id');
    fn__4823 = function()
      return 'join with col';
    end;
    temper.test_assert(test_418, t_422, fn__4823);
    return nil;
  end);
end;
Test_.test_safeIdentifierAcceptsValidNames__1118 = function()
  temper.test('safeIdentifier accepts valid names', function(test_423)
    local t_424, id__773, local_425, local_426, local_427, t_429, fn__4818;
    local_425, local_426, local_427 = temper.pcall(function()
      t_424 = safeIdentifier('user_name');
      id__773 = t_424;
    end);
    if local_425 then
    else
      id__773 = temper.bubble();
    end
    t_429 = temper.str_eq(id__773.sqlValue, 'user_name');
    fn__4818 = function()
      return 'value should round-trip';
    end;
    temper.test_assert(test_423, t_429, fn__4818);
    return nil;
  end);
end;
Test_.test_safeIdentifierRejectsEmptyString__1119 = function()
  temper.test('safeIdentifier rejects empty string', function(test_430)
    local didBubble__775, local_431, local_432, local_433, fn__4815;
    local_431, local_432, local_433 = temper.pcall(function()
      safeIdentifier('');
      didBubble__775 = false;
    end);
    if local_431 then
    else
      didBubble__775 = true;
    end
    fn__4815 = function()
      return 'empty string should bubble';
    end;
    temper.test_assert(test_430, didBubble__775, fn__4815);
    return nil;
  end);
end;
Test_.test_safeIdentifierRejectsLeadingDigit__1120 = function()
  temper.test('safeIdentifier rejects leading digit', function(test_435)
    local didBubble__777, local_436, local_437, local_438, fn__4812;
    local_436, local_437, local_438 = temper.pcall(function()
      safeIdentifier('1col');
      didBubble__777 = false;
    end);
    if local_436 then
    else
      didBubble__777 = true;
    end
    fn__4812 = function()
      return 'leading digit should bubble';
    end;
    temper.test_assert(test_435, didBubble__777, fn__4812);
    return nil;
  end);
end;
Test_.test_safeIdentifierRejectsSqlMetacharacters__1121 = function()
  temper.test('safeIdentifier rejects SQL metacharacters', function(test_440)
    local cases__779, fn__4809;
    cases__779 = temper.listof('name); DROP TABLE', "col'", 'a b', 'a-b', 'a.b', 'a;b');
    fn__4809 = function(c__780)
      local didBubble__781, local_441, local_442, local_443, fn__4806;
      local_441, local_442, local_443 = temper.pcall(function()
        safeIdentifier(c__780);
        didBubble__781 = false;
      end);
      if local_441 then
      else
        didBubble__781 = true;
      end
      fn__4806 = function()
        return temper.concat('should reject: ', c__780);
      end;
      temper.test_assert(test_440, didBubble__781, fn__4806);
      return nil;
    end;
    temper.list_foreach(cases__779, fn__4809);
    return nil;
  end);
end;
Test_.test_tableDefFieldLookupFound__1122 = function()
  temper.test('TableDef field lookup - found', function(test_445)
    local t_446, t_447, t_448, t_449, t_450, t_451, t_452, local_453, local_454, local_455, local_457, local_458, local_459, t_461, t_462, local_463, local_464, local_465, t_467, t_468, td__783, f__784, local_469, local_470, local_471, t_473, fn__4795;
    local_453, local_454, local_455 = temper.pcall(function()
      t_446 = safeIdentifier('users');
      t_447 = t_446;
    end);
    if local_453 then
    else
      t_447 = temper.bubble();
    end
    local_457, local_458, local_459 = temper.pcall(function()
      t_448 = safeIdentifier('name');
      t_449 = t_448;
    end);
    if local_457 then
    else
      t_449 = temper.bubble();
    end
    t_461 = StringField();
    t_462 = FieldDef(t_449, t_461, false);
    local_463, local_464, local_465 = temper.pcall(function()
      t_450 = safeIdentifier('age');
      t_451 = t_450;
    end);
    if local_463 then
    else
      t_451 = temper.bubble();
    end
    t_467 = IntField();
    t_468 = FieldDef(t_451, t_467, false);
    td__783 = TableDef(t_447, temper.listof(t_462, t_468));
    local_469, local_470, local_471 = temper.pcall(function()
      t_452 = td__783:field('age');
      f__784 = t_452;
    end);
    if local_469 then
    else
      f__784 = temper.bubble();
    end
    t_473 = temper.str_eq(f__784.name.sqlValue, 'age');
    fn__4795 = function()
      return 'should find age field';
    end;
    temper.test_assert(test_445, t_473, fn__4795);
    return nil;
  end);
end;
Test_.test_tableDefFieldLookupNotFoundBubbles__1123 = function()
  temper.test('TableDef field lookup - not found bubbles', function(test_474)
    local t_475, t_476, t_477, t_478, local_479, local_480, local_481, local_483, local_484, local_485, t_487, t_488, td__786, didBubble__787, local_489, local_490, local_491, fn__4789;
    local_479, local_480, local_481 = temper.pcall(function()
      t_475 = safeIdentifier('users');
      t_476 = t_475;
    end);
    if local_479 then
    else
      t_476 = temper.bubble();
    end
    local_483, local_484, local_485 = temper.pcall(function()
      t_477 = safeIdentifier('name');
      t_478 = t_477;
    end);
    if local_483 then
    else
      t_478 = temper.bubble();
    end
    t_487 = StringField();
    t_488 = FieldDef(t_478, t_487, false);
    td__786 = TableDef(t_476, temper.listof(t_488));
    local_489, local_490, local_491 = temper.pcall(function()
      td__786:field('nonexistent');
      didBubble__787 = false;
    end);
    if local_489 then
    else
      didBubble__787 = true;
    end
    fn__4789 = function()
      return 'unknown field should bubble';
    end;
    temper.test_assert(test_474, didBubble__787, fn__4789);
    return nil;
  end);
end;
Test_.test_fieldDefNullableFlag__1124 = function()
  temper.test('FieldDef nullable flag', function(test_493)
    local t_494, t_495, t_496, t_497, local_498, local_499, local_500, t_502, required__789, local_503, local_504, local_505, t_507, optional__790, t_508, fn__4777, t_509, fn__4776;
    local_498, local_499, local_500 = temper.pcall(function()
      t_494 = safeIdentifier('email');
      t_495 = t_494;
    end);
    if local_498 then
    else
      t_495 = temper.bubble();
    end
    t_502 = StringField();
    required__789 = FieldDef(t_495, t_502, false);
    local_503, local_504, local_505 = temper.pcall(function()
      t_496 = safeIdentifier('bio');
      t_497 = t_496;
    end);
    if local_503 then
    else
      t_497 = temper.bubble();
    end
    t_507 = StringField();
    optional__790 = FieldDef(t_497, t_507, true);
    t_508 = not required__789.nullable;
    fn__4777 = function()
      return 'required field should not be nullable';
    end;
    temper.test_assert(test_493, t_508, fn__4777);
    t_509 = optional__790.nullable;
    fn__4776 = function()
      return 'optional field should be nullable';
    end;
    temper.test_assert(test_493, t_509, fn__4776);
    return nil;
  end);
end;
Test_.test_stringEscaping__1125 = function()
  temper.test('string escaping', function(test_510)
    local build__916, buildWrong__917, actual_512, t_513, fn__4765, bobbyTables__922, actual_514, t_515, fn__4764, fn__4763;
    build__916 = function(name__918)
      local t_511;
      t_511 = SqlBuilder();
      t_511:appendSafe('select * from hi where name = ');
      t_511:appendString(name__918);
      return t_511.accumulated:toString();
    end;
    buildWrong__917 = function(name__920)
      return temper.concat("select * from hi where name = '", name__920, "'");
    end;
    actual_512 = build__916('world');
    t_513 = temper.str_eq(actual_512, "select * from hi where name = 'world'");
    fn__4765 = function()
      return temper.concat('expected build("world") == (', "select * from hi where name = 'world'", ') not (', actual_512, ')');
    end;
    temper.test_assert(test_510, t_513, fn__4765);
    bobbyTables__922 = "Robert'); drop table hi;--";
    actual_514 = build__916("Robert'); drop table hi;--");
    t_515 = temper.str_eq(actual_514, "select * from hi where name = 'Robert''); drop table hi;--'");
    fn__4764 = function()
      return temper.concat('expected build(bobbyTables) == (', "select * from hi where name = 'Robert''); drop table hi;--'", ') not (', actual_514, ')');
    end;
    temper.test_assert(test_510, t_515, fn__4764);
    fn__4763 = function()
      return "expected buildWrong(bobbyTables) == (select * from hi where name = 'Robert'); drop table hi;--') not (select * from hi where name = 'Robert'); drop table hi;--')";
    end;
    temper.test_assert(test_510, true, fn__4763);
    return nil;
  end);
end;
Test_.test_stringEdgeCases__1133 = function()
  temper.test('string edge cases', function(test_516)
    local t_517, actual_518, t_519, fn__4725, t_520, actual_521, t_522, fn__4724, t_523, actual_524, t_525, fn__4723, t_526, actual_527, t_528, fn__4722;
    t_517 = SqlBuilder();
    t_517:appendSafe('v = ');
    t_517:appendString('');
    actual_518 = t_517.accumulated:toString();
    t_519 = temper.str_eq(actual_518, "v = ''");
    fn__4725 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, "").toString() == (', "v = ''", ') not (', actual_518, ')');
    end;
    temper.test_assert(test_516, t_519, fn__4725);
    t_520 = SqlBuilder();
    t_520:appendSafe('v = ');
    t_520:appendString("a''b");
    actual_521 = t_520.accumulated:toString();
    t_522 = temper.str_eq(actual_521, "v = 'a''''b'");
    fn__4724 = function()
      return temper.concat("expected stringExpr(`-work//src/`.sql, true, \"v = \", \\interpolate, \"a''b\").toString() == (", "v = 'a''''b'", ') not (', actual_521, ')');
    end;
    temper.test_assert(test_516, t_522, fn__4724);
    t_523 = SqlBuilder();
    t_523:appendSafe('v = ');
    t_523:appendString('Hello \xe4\xb8\x96\xe7\x95\x8c');
    actual_524 = t_523.accumulated:toString();
    t_525 = temper.str_eq(actual_524, "v = 'Hello \xe4\xb8\x96\xe7\x95\x8c'");
    fn__4723 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, "Hello \xe4\xb8\x96\xe7\x95\x8c").toString() == (', "v = 'Hello \xe4\xb8\x96\xe7\x95\x8c'", ') not (', actual_524, ')');
    end;
    temper.test_assert(test_516, t_525, fn__4723);
    t_526 = SqlBuilder();
    t_526:appendSafe('v = ');
    t_526:appendString('Line1\nLine2');
    actual_527 = t_526.accumulated:toString();
    t_528 = temper.str_eq(actual_527, "v = 'Line1\nLine2'");
    fn__4722 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, "Line1\\nLine2").toString() == (', "v = 'Line1\nLine2'", ') not (', actual_527, ')');
    end;
    temper.test_assert(test_516, t_528, fn__4722);
    return nil;
  end);
end;
Test_.test_numbersAndBooleans__1146 = function()
  temper.test('numbers and booleans', function(test_529)
    local t_530, t_531, actual_532, t_533, fn__4696, date__925, local_534, local_535, local_536, t_538, actual_539, t_540, fn__4695;
    t_531 = SqlBuilder();
    t_531:appendSafe('select ');
    t_531:appendInt32(42);
    t_531:appendSafe(', ');
    t_531:appendInt64(temper.int64_constructor(43));
    t_531:appendSafe(', ');
    t_531:appendFloat64(19.99);
    t_531:appendSafe(', ');
    t_531:appendBoolean(true);
    t_531:appendSafe(', ');
    t_531:appendBoolean(false);
    actual_532 = t_531.accumulated:toString();
    t_533 = temper.str_eq(actual_532, 'select 42, 43, 19.99, TRUE, FALSE');
    fn__4696 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "select ", \\interpolate, 42, ", ", \\interpolate, 43, ", ", \\interpolate, 19.99, ", ", \\interpolate, true, ", ", \\interpolate, false).toString() == (', 'select 42, 43, 19.99, TRUE, FALSE', ') not (', actual_532, ')');
    end;
    temper.test_assert(test_529, t_533, fn__4696);
    local_534, local_535, local_536 = temper.pcall(function()
      t_530 = temper.date_constructor(2024, 12, 25);
      date__925 = t_530;
    end);
    if local_534 then
    else
      date__925 = temper.bubble();
    end
    t_538 = SqlBuilder();
    t_538:appendSafe('insert into t values (');
    t_538:appendDate(date__925);
    t_538:appendSafe(')');
    actual_539 = t_538.accumulated:toString();
    t_540 = temper.str_eq(actual_539, "insert into t values ('2024-12-25')");
    fn__4695 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "insert into t values (", \\interpolate, date, ")").toString() == (', "insert into t values ('2024-12-25')", ') not (', actual_539, ')');
    end;
    temper.test_assert(test_529, t_540, fn__4695);
    return nil;
  end);
end;
Test_.test_lists__1153 = function()
  temper.test('lists', function(test_541)
    local t_542, t_543, t_544, t_545, t_546, actual_547, t_548, fn__4640, t_549, actual_550, t_551, fn__4639, t_552, actual_553, t_554, fn__4638, t_555, actual_556, t_557, fn__4637, t_558, actual_559, t_560, fn__4636, local_561, local_562, local_563, local_565, local_566, local_567, dates__927, t_569, actual_570, t_571, fn__4635;
    t_546 = SqlBuilder();
    t_546:appendSafe('v IN (');
    t_546:appendStringList(temper.listof('a', 'b', "c'd"));
    t_546:appendSafe(')');
    actual_547 = t_546.accumulated:toString();
    t_548 = temper.str_eq(actual_547, "v IN ('a', 'b', 'c''d')");
    fn__4640 = function()
      return temper.concat("expected stringExpr(`-work//src/`.sql, true, \"v IN (\", \\interpolate, list(\"a\", \"b\", \"c'd\"), \")\").toString() == (", "v IN ('a', 'b', 'c''d')", ') not (', actual_547, ')');
    end;
    temper.test_assert(test_541, t_548, fn__4640);
    t_549 = SqlBuilder();
    t_549:appendSafe('v IN (');
    t_549:appendInt32List(temper.listof(1, 2, 3));
    t_549:appendSafe(')');
    actual_550 = t_549.accumulated:toString();
    t_551 = temper.str_eq(actual_550, 'v IN (1, 2, 3)');
    fn__4639 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v IN (", \\interpolate, list(1, 2, 3), ")").toString() == (', 'v IN (1, 2, 3)', ') not (', actual_550, ')');
    end;
    temper.test_assert(test_541, t_551, fn__4639);
    t_552 = SqlBuilder();
    t_552:appendSafe('v IN (');
    t_552:appendInt64List(temper.listof(temper.int64_constructor(1), temper.int64_constructor(2)));
    t_552:appendSafe(')');
    actual_553 = t_552.accumulated:toString();
    t_554 = temper.str_eq(actual_553, 'v IN (1, 2)');
    fn__4638 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v IN (", \\interpolate, list(1, 2), ")").toString() == (', 'v IN (1, 2)', ') not (', actual_553, ')');
    end;
    temper.test_assert(test_541, t_554, fn__4638);
    t_555 = SqlBuilder();
    t_555:appendSafe('v IN (');
    t_555:appendFloat64List(temper.listof(1.0, 2.0));
    t_555:appendSafe(')');
    actual_556 = t_555.accumulated:toString();
    t_557 = temper.str_eq(actual_556, 'v IN (1.0, 2.0)');
    fn__4637 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v IN (", \\interpolate, list(1.0, 2.0), ")").toString() == (', 'v IN (1.0, 2.0)', ') not (', actual_556, ')');
    end;
    temper.test_assert(test_541, t_557, fn__4637);
    t_558 = SqlBuilder();
    t_558:appendSafe('v IN (');
    t_558:appendBooleanList(temper.listof(true, false));
    t_558:appendSafe(')');
    actual_559 = t_558.accumulated:toString();
    t_560 = temper.str_eq(actual_559, 'v IN (TRUE, FALSE)');
    fn__4636 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v IN (", \\interpolate, list(true, false), ")").toString() == (', 'v IN (TRUE, FALSE)', ') not (', actual_559, ')');
    end;
    temper.test_assert(test_541, t_560, fn__4636);
    local_561, local_562, local_563 = temper.pcall(function()
      t_542 = temper.date_constructor(2024, 1, 1);
      t_543 = t_542;
    end);
    if local_561 then
    else
      t_543 = temper.bubble();
    end
    local_565, local_566, local_567 = temper.pcall(function()
      t_544 = temper.date_constructor(2024, 12, 25);
      t_545 = t_544;
    end);
    if local_565 then
    else
      t_545 = temper.bubble();
    end
    dates__927 = temper.listof(t_543, t_545);
    t_569 = SqlBuilder();
    t_569:appendSafe('v IN (');
    t_569:appendDateList(dates__927);
    t_569:appendSafe(')');
    actual_570 = t_569.accumulated:toString();
    t_571 = temper.str_eq(actual_570, "v IN ('2024-01-01', '2024-12-25')");
    fn__4635 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v IN (", \\interpolate, dates, ")").toString() == (', "v IN ('2024-01-01', '2024-12-25')", ') not (', actual_570, ')');
    end;
    temper.test_assert(test_541, t_571, fn__4635);
    return nil;
  end);
end;
Test_.test_sqlFloat64_naNRendersAsNull__1172 = function()
  temper.test('SqlFloat64 NaN renders as NULL', function(test_572)
    local nan__929, t_573, actual_574, t_575, fn__4626;
    nan__929 = temper.fdiv(0.0, 0.0);
    t_573 = SqlBuilder();
    t_573:appendSafe('v = ');
    t_573:appendFloat64(nan__929);
    actual_574 = t_573.accumulated:toString();
    t_575 = temper.str_eq(actual_574, 'v = NULL');
    fn__4626 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, nan).toString() == (', 'v = NULL', ') not (', actual_574, ')');
    end;
    temper.test_assert(test_572, t_575, fn__4626);
    return nil;
  end);
end;
Test_.test_sqlFloat64_infinityRendersAsNull__1176 = function()
  temper.test('SqlFloat64 Infinity renders as NULL', function(test_576)
    local inf__931, t_577, actual_578, t_579, fn__4617;
    inf__931 = temper.fdiv(1.0, 0.0);
    t_577 = SqlBuilder();
    t_577:appendSafe('v = ');
    t_577:appendFloat64(inf__931);
    actual_578 = t_577.accumulated:toString();
    t_579 = temper.str_eq(actual_578, 'v = NULL');
    fn__4617 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, inf).toString() == (', 'v = NULL', ') not (', actual_578, ')');
    end;
    temper.test_assert(test_576, t_579, fn__4617);
    return nil;
  end);
end;
Test_.test_sqlFloat64_negativeInfinityRendersAsNull__1180 = function()
  temper.test('SqlFloat64 negative Infinity renders as NULL', function(test_580)
    local ninf__933, t_581, actual_582, t_583, fn__4608;
    ninf__933 = temper.fdiv(-1.0, 0.0);
    t_581 = SqlBuilder();
    t_581:appendSafe('v = ');
    t_581:appendFloat64(ninf__933);
    actual_582 = t_581.accumulated:toString();
    t_583 = temper.str_eq(actual_582, 'v = NULL');
    fn__4608 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, ninf).toString() == (', 'v = NULL', ') not (', actual_582, ')');
    end;
    temper.test_assert(test_580, t_583, fn__4608);
    return nil;
  end);
end;
Test_.test_sqlFloat64_normalValuesStillWork__1184 = function()
  temper.test('SqlFloat64 normal values still work', function(test_584)
    local t_585, actual_586, t_587, fn__4583, t_588, actual_589, t_590, fn__4582, t_591, actual_592, t_593, fn__4581;
    t_585 = SqlBuilder();
    t_585:appendSafe('v = ');
    t_585:appendFloat64(3.14);
    actual_586 = t_585.accumulated:toString();
    t_587 = temper.str_eq(actual_586, 'v = 3.14');
    fn__4583 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, 3.14).toString() == (', 'v = 3.14', ') not (', actual_586, ')');
    end;
    temper.test_assert(test_584, t_587, fn__4583);
    t_588 = SqlBuilder();
    t_588:appendSafe('v = ');
    t_588:appendFloat64(0.0);
    actual_589 = t_588.accumulated:toString();
    t_590 = temper.str_eq(actual_589, 'v = 0.0');
    fn__4582 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, 0.0).toString() == (', 'v = 0.0', ') not (', actual_589, ')');
    end;
    temper.test_assert(test_584, t_590, fn__4582);
    t_591 = SqlBuilder();
    t_591:appendSafe('v = ');
    t_591:appendFloat64(-42.5);
    actual_592 = t_591.accumulated:toString();
    t_593 = temper.str_eq(actual_592, 'v = -42.5');
    fn__4581 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, -42.5).toString() == (', 'v = -42.5', ') not (', actual_592, ')');
    end;
    temper.test_assert(test_584, t_593, fn__4581);
    return nil;
  end);
end;
Test_.test_sqlDateRendersWithQuotes__1194 = function()
  temper.test('SqlDate renders with quotes', function(test_594)
    local t_595, d__936, local_596, local_597, local_598, t_600, actual_601, t_602, fn__4572;
    local_596, local_597, local_598 = temper.pcall(function()
      t_595 = temper.date_constructor(2024, 6, 15);
      d__936 = t_595;
    end);
    if local_596 then
    else
      d__936 = temper.bubble();
    end
    t_600 = SqlBuilder();
    t_600:appendSafe('v = ');
    t_600:appendDate(d__936);
    actual_601 = t_600.accumulated:toString();
    t_602 = temper.str_eq(actual_601, "v = '2024-06-15'");
    fn__4572 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, d).toString() == (', "v = '2024-06-15'", ') not (', actual_601, ')');
    end;
    temper.test_assert(test_594, t_602, fn__4572);
    return nil;
  end);
end;
Test_.test_nesting__1198 = function()
  temper.test('nesting', function(test_603)
    local name__938, t_604, condition__939, t_605, actual_606, t_607, fn__4540, t_608, actual_609, t_610, fn__4539, parts__940, t_611, actual_612, t_613, fn__4538;
    name__938 = 'Someone';
    t_604 = SqlBuilder();
    t_604:appendSafe('where p.last_name = ');
    t_604:appendString('Someone');
    condition__939 = t_604.accumulated;
    t_605 = SqlBuilder();
    t_605:appendSafe('select p.id from person p ');
    t_605:appendFragment(condition__939);
    actual_606 = t_605.accumulated:toString();
    t_607 = temper.str_eq(actual_606, "select p.id from person p where p.last_name = 'Someone'");
    fn__4540 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "select p.id from person p ", \\interpolate, condition).toString() == (', "select p.id from person p where p.last_name = 'Someone'", ') not (', actual_606, ')');
    end;
    temper.test_assert(test_603, t_607, fn__4540);
    t_608 = SqlBuilder();
    t_608:appendSafe('select p.id from person p ');
    t_608:appendPart(condition__939:toSource());
    actual_609 = t_608.accumulated:toString();
    t_610 = temper.str_eq(actual_609, "select p.id from person p where p.last_name = 'Someone'");
    fn__4539 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "select p.id from person p ", \\interpolate, condition.toSource()).toString() == (', "select p.id from person p where p.last_name = 'Someone'", ') not (', actual_609, ')');
    end;
    temper.test_assert(test_603, t_610, fn__4539);
    parts__940 = temper.listof(SqlString("a'b"), SqlInt32(3));
    t_611 = SqlBuilder();
    t_611:appendSafe('select ');
    t_611:appendPartList(parts__940);
    actual_612 = t_611.accumulated:toString();
    t_613 = temper.str_eq(actual_612, "select 'a''b', 3");
    fn__4538 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "select ", \\interpolate, parts).toString() == (', "select 'a''b', 3", ') not (', actual_612, ')');
    end;
    temper.test_assert(test_603, t_613, fn__4538);
    return nil;
  end);
end;
exports = {};
local_615.LuaUnit.run(local_614({'--pattern', '^Test_%.', local_614(arg)}));
return exports;
