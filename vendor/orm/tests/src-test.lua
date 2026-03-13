local temper = require('temper-core');
local safeIdentifier, TableDef, FieldDef, StringField, IntField, FloatField, BoolField, changeset, from, SqlBuilder, col, SqlInt32, SqlString, countAll, countCol, sumCol, avgCol, minCol, maxCol, unionSql, unionAllSql, intersectSql, exceptSql, subquery, existsSql, update, SqlBoolean, deleteFrom, local_1062, local_1063, csid__503, userTable__504, sid__505, exports;
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
local_1062 = (unpack or table.unpack);
local_1063 = require('luaunit');
local_1063.FAILURE_PREFIX = temper.test_failure_prefix;
Test_ = {};
csid__503 = function(name__648)
  local return__317, t_143, local_144, local_145, local_146;
  local_144, local_145, local_146 = temper.pcall(function()
    t_143 = safeIdentifier(name__648);
    return__317 = t_143;
  end);
  if local_144 then
  else
    return__317 = temper.bubble();
  end
  return return__317;
end;
userTable__504 = function()
  return TableDef(csid__503('users'), temper.listof(FieldDef(csid__503('name'), StringField(), false), FieldDef(csid__503('email'), StringField(), false), FieldDef(csid__503('age'), IntField(), true), FieldDef(csid__503('score'), FloatField(), true), FieldDef(csid__503('active'), BoolField(), true)));
end;
Test_.test_castWhitelistsAllowedFields__1546 = function()
  temper.test('cast whitelists allowed fields', function(test_148)
    local params__652, t_149, t_150, t_151, cs__653, t_152, fn__10646, t_153, fn__10645, t_154, fn__10644, t_155, fn__10643;
    params__652 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice'), temper.pair_constructor('email', 'alice@example.com'), temper.pair_constructor('admin', 'true')));
    t_149 = userTable__504();
    t_150 = csid__503('name');
    t_151 = csid__503('email');
    cs__653 = changeset(t_149, params__652):cast(temper.listof(t_150, t_151));
    t_152 = temper.mapped_has(cs__653.changes, 'name');
    fn__10646 = function()
      return 'name should be in changes';
    end;
    temper.test_assert(test_148, t_152, fn__10646);
    t_153 = temper.mapped_has(cs__653.changes, 'email');
    fn__10645 = function()
      return 'email should be in changes';
    end;
    temper.test_assert(test_148, t_153, fn__10645);
    t_154 = not temper.mapped_has(cs__653.changes, 'admin');
    fn__10644 = function()
      return 'admin must be dropped (not in whitelist)';
    end;
    temper.test_assert(test_148, t_154, fn__10644);
    t_155 = cs__653.isValid;
    fn__10643 = function()
      return 'should still be valid';
    end;
    temper.test_assert(test_148, t_155, fn__10643);
    return nil;
  end);
end;
Test_.test_castIsReplacingNotAdditiveSecondCallResetsWhitelist__1547 = function()
  temper.test('cast is replacing not additive \xe2\x80\x94 second call resets whitelist', function(test_156)
    local params__655, t_157, t_158, cs__656, t_159, fn__10625, t_160, fn__10624;
    params__655 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice'), temper.pair_constructor('email', 'alice@example.com')));
    t_157 = userTable__504();
    t_158 = csid__503('name');
    cs__656 = changeset(t_157, params__655):cast(temper.listof(t_158)):cast(temper.listof(csid__503('email')));
    t_159 = not temper.mapped_has(cs__656.changes, 'name');
    fn__10625 = function()
      return 'name must be excluded by second cast';
    end;
    temper.test_assert(test_156, t_159, fn__10625);
    t_160 = temper.mapped_has(cs__656.changes, 'email');
    fn__10624 = function()
      return 'email should be present';
    end;
    temper.test_assert(test_156, t_160, fn__10624);
    return nil;
  end);
end;
Test_.test_castIgnoresEmptyStringValues__1548 = function()
  temper.test('cast ignores empty string values', function(test_161)
    local params__658, t_162, t_163, t_164, cs__659, t_165, fn__10607, t_166, fn__10606;
    params__658 = temper.map_constructor(temper.listof(temper.pair_constructor('name', ''), temper.pair_constructor('email', 'bob@example.com')));
    t_162 = userTable__504();
    t_163 = csid__503('name');
    t_164 = csid__503('email');
    cs__659 = changeset(t_162, params__658):cast(temper.listof(t_163, t_164));
    t_165 = not temper.mapped_has(cs__659.changes, 'name');
    fn__10607 = function()
      return 'empty name should not be in changes';
    end;
    temper.test_assert(test_161, t_165, fn__10607);
    t_166 = temper.mapped_has(cs__659.changes, 'email');
    fn__10606 = function()
      return 'email should be in changes';
    end;
    temper.test_assert(test_161, t_166, fn__10606);
    return nil;
  end);
end;
Test_.test_validateRequiredPassesWhenFieldPresent__1549 = function()
  temper.test('validateRequired passes when field present', function(test_167)
    local params__661, t_168, t_169, cs__662, t_170, fn__10590, t_171, fn__10589;
    params__661 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice')));
    t_168 = userTable__504();
    t_169 = csid__503('name');
    cs__662 = changeset(t_168, params__661):cast(temper.listof(t_169)):validateRequired(temper.listof(csid__503('name')));
    t_170 = cs__662.isValid;
    fn__10590 = function()
      return 'should be valid';
    end;
    temper.test_assert(test_167, t_170, fn__10590);
    t_171 = (temper.list_length(cs__662.errors) == 0);
    fn__10589 = function()
      return 'no errors expected';
    end;
    temper.test_assert(test_167, t_171, fn__10589);
    return nil;
  end);
end;
Test_.test_validateRequiredFailsWhenFieldMissing__1550 = function()
  temper.test('validateRequired fails when field missing', function(test_172)
    local params__664, t_173, t_174, cs__665, t_175, fn__10567, t_176, fn__10566, t_177, fn__10565;
    params__664 = temper.map_constructor(temper.listof());
    t_173 = userTable__504();
    t_174 = csid__503('name');
    cs__665 = changeset(t_173, params__664):cast(temper.listof(t_174)):validateRequired(temper.listof(csid__503('name')));
    t_175 = not cs__665.isValid;
    fn__10567 = function()
      return 'should be invalid';
    end;
    temper.test_assert(test_172, t_175, fn__10567);
    t_176 = (temper.list_length(cs__665.errors) == 1);
    fn__10566 = function()
      return 'should have one error';
    end;
    temper.test_assert(test_172, t_176, fn__10566);
    t_177 = temper.str_eq((temper.list_get(cs__665.errors, 0)).field, 'name');
    fn__10565 = function()
      return 'error should name the field';
    end;
    temper.test_assert(test_172, t_177, fn__10565);
    return nil;
  end);
end;
Test_.test_validateLengthPassesWithinRange__1551 = function()
  temper.test('validateLength passes within range', function(test_178)
    local params__667, t_179, t_180, cs__668, t_181, fn__10554;
    params__667 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice')));
    t_179 = userTable__504();
    t_180 = csid__503('name');
    cs__668 = changeset(t_179, params__667):cast(temper.listof(t_180)):validateLength(csid__503('name'), 2, 50);
    t_181 = cs__668.isValid;
    fn__10554 = function()
      return 'should be valid';
    end;
    temper.test_assert(test_178, t_181, fn__10554);
    return nil;
  end);
end;
Test_.test_validateLengthFailsWhenTooShort__1552 = function()
  temper.test('validateLength fails when too short', function(test_182)
    local params__670, t_183, t_184, cs__671, t_185, fn__10542;
    params__670 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'A')));
    t_183 = userTable__504();
    t_184 = csid__503('name');
    cs__671 = changeset(t_183, params__670):cast(temper.listof(t_184)):validateLength(csid__503('name'), 2, 50);
    t_185 = not cs__671.isValid;
    fn__10542 = function()
      return 'should be invalid';
    end;
    temper.test_assert(test_182, t_185, fn__10542);
    return nil;
  end);
end;
Test_.test_validateLengthFailsWhenTooLong__1553 = function()
  temper.test('validateLength fails when too long', function(test_186)
    local params__673, t_187, t_188, cs__674, t_189, fn__10530;
    params__673 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')));
    t_187 = userTable__504();
    t_188 = csid__503('name');
    cs__674 = changeset(t_187, params__673):cast(temper.listof(t_188)):validateLength(csid__503('name'), 2, 10);
    t_189 = not cs__674.isValid;
    fn__10530 = function()
      return 'should be invalid';
    end;
    temper.test_assert(test_186, t_189, fn__10530);
    return nil;
  end);
end;
Test_.test_validateIntPassesForValidInteger__1554 = function()
  temper.test('validateInt passes for valid integer', function(test_190)
    local params__676, t_191, t_192, cs__677, t_193, fn__10519;
    params__676 = temper.map_constructor(temper.listof(temper.pair_constructor('age', '30')));
    t_191 = userTable__504();
    t_192 = csid__503('age');
    cs__677 = changeset(t_191, params__676):cast(temper.listof(t_192)):validateInt(csid__503('age'));
    t_193 = cs__677.isValid;
    fn__10519 = function()
      return 'should be valid';
    end;
    temper.test_assert(test_190, t_193, fn__10519);
    return nil;
  end);
end;
Test_.test_validateIntFailsForNonInteger__1555 = function()
  temper.test('validateInt fails for non-integer', function(test_194)
    local params__679, t_195, t_196, cs__680, t_197, fn__10507;
    params__679 = temper.map_constructor(temper.listof(temper.pair_constructor('age', 'not-a-number')));
    t_195 = userTable__504();
    t_196 = csid__503('age');
    cs__680 = changeset(t_195, params__679):cast(temper.listof(t_196)):validateInt(csid__503('age'));
    t_197 = not cs__680.isValid;
    fn__10507 = function()
      return 'should be invalid';
    end;
    temper.test_assert(test_194, t_197, fn__10507);
    return nil;
  end);
end;
Test_.test_validateFloatPassesForValidFloat__1556 = function()
  temper.test('validateFloat passes for valid float', function(test_198)
    local params__682, t_199, t_200, cs__683, t_201, fn__10496;
    params__682 = temper.map_constructor(temper.listof(temper.pair_constructor('score', '9.5')));
    t_199 = userTable__504();
    t_200 = csid__503('score');
    cs__683 = changeset(t_199, params__682):cast(temper.listof(t_200)):validateFloat(csid__503('score'));
    t_201 = cs__683.isValid;
    fn__10496 = function()
      return 'should be valid';
    end;
    temper.test_assert(test_198, t_201, fn__10496);
    return nil;
  end);
end;
Test_.test_validateInt64_passesForValid64_bitInteger__1557 = function()
  temper.test('validateInt64 passes for valid 64-bit integer', function(test_202)
    local params__685, t_203, t_204, cs__686, t_205, fn__10485;
    params__685 = temper.map_constructor(temper.listof(temper.pair_constructor('age', '9999999999')));
    t_203 = userTable__504();
    t_204 = csid__503('age');
    cs__686 = changeset(t_203, params__685):cast(temper.listof(t_204)):validateInt64(csid__503('age'));
    t_205 = cs__686.isValid;
    fn__10485 = function()
      return 'should be valid';
    end;
    temper.test_assert(test_202, t_205, fn__10485);
    return nil;
  end);
end;
Test_.test_validateInt64_failsForNonInteger__1558 = function()
  temper.test('validateInt64 fails for non-integer', function(test_206)
    local params__688, t_207, t_208, cs__689, t_209, fn__10473;
    params__688 = temper.map_constructor(temper.listof(temper.pair_constructor('age', 'not-a-number')));
    t_207 = userTable__504();
    t_208 = csid__503('age');
    cs__689 = changeset(t_207, params__688):cast(temper.listof(t_208)):validateInt64(csid__503('age'));
    t_209 = not cs__689.isValid;
    fn__10473 = function()
      return 'should be invalid';
    end;
    temper.test_assert(test_206, t_209, fn__10473);
    return nil;
  end);
end;
Test_.test_validateBoolAcceptsTrue1_yesOn__1559 = function()
  temper.test('validateBool accepts true/1/yes/on', function(test_210)
    local fn__10470;
    fn__10470 = function(v__691)
      local params__692, t_211, t_212, cs__693, t_213, fn__10459;
      params__692 = temper.map_constructor(temper.listof(temper.pair_constructor('active', v__691)));
      t_211 = userTable__504();
      t_212 = csid__503('active');
      cs__693 = changeset(t_211, params__692):cast(temper.listof(t_212)):validateBool(csid__503('active'));
      t_213 = cs__693.isValid;
      fn__10459 = function()
        return temper.concat('should accept: ', v__691);
      end;
      temper.test_assert(test_210, t_213, fn__10459);
      return nil;
    end;
    temper.list_foreach(temper.listof('true', '1', 'yes', 'on'), fn__10470);
    return nil;
  end);
end;
Test_.test_validateBoolAcceptsFalse0_noOff__1560 = function()
  temper.test('validateBool accepts false/0/no/off', function(test_214)
    local fn__10456;
    fn__10456 = function(v__695)
      local params__696, t_215, t_216, cs__697, t_217, fn__10445;
      params__696 = temper.map_constructor(temper.listof(temper.pair_constructor('active', v__695)));
      t_215 = userTable__504();
      t_216 = csid__503('active');
      cs__697 = changeset(t_215, params__696):cast(temper.listof(t_216)):validateBool(csid__503('active'));
      t_217 = cs__697.isValid;
      fn__10445 = function()
        return temper.concat('should accept: ', v__695);
      end;
      temper.test_assert(test_214, t_217, fn__10445);
      return nil;
    end;
    temper.list_foreach(temper.listof('false', '0', 'no', 'off'), fn__10456);
    return nil;
  end);
end;
Test_.test_validateBoolRejectsAmbiguousValues__1561 = function()
  temper.test('validateBool rejects ambiguous values', function(test_218)
    local fn__10442;
    fn__10442 = function(v__699)
      local params__700, t_219, t_220, cs__701, t_221, fn__10430;
      params__700 = temper.map_constructor(temper.listof(temper.pair_constructor('active', v__699)));
      t_219 = userTable__504();
      t_220 = csid__503('active');
      cs__701 = changeset(t_219, params__700):cast(temper.listof(t_220)):validateBool(csid__503('active'));
      t_221 = not cs__701.isValid;
      fn__10430 = function()
        return temper.concat('should reject ambiguous: ', v__699);
      end;
      temper.test_assert(test_218, t_221, fn__10430);
      return nil;
    end;
    temper.list_foreach(temper.listof('TRUE', 'Yes', 'maybe', '2', 'enabled'), fn__10442);
    return nil;
  end);
end;
Test_.test_toInsertSqlEscapesBobbyTables__1562 = function()
  temper.test('toInsertSql escapes Bobby Tables', function(test_222)
    local t_223, params__703, t_224, t_225, t_226, cs__704, sqlFrag__705, local_227, local_228, local_229, s__706, t_231, fn__10414;
    params__703 = temper.map_constructor(temper.listof(temper.pair_constructor('name', "Robert'); DROP TABLE users;--"), temper.pair_constructor('email', 'bobby@evil.com')));
    t_224 = userTable__504();
    t_225 = csid__503('name');
    t_226 = csid__503('email');
    cs__704 = changeset(t_224, params__703):cast(temper.listof(t_225, t_226)):validateRequired(temper.listof(csid__503('name'), csid__503('email')));
    local_227, local_228, local_229 = temper.pcall(function()
      t_223 = cs__704:toInsertSql();
      sqlFrag__705 = t_223;
    end);
    if local_227 then
    else
      sqlFrag__705 = temper.bubble();
    end
    s__706 = sqlFrag__705:toString();
    t_231 = temper.is_string_index(temper.string_indexof(s__706, "''"));
    fn__10414 = function()
      return temper.concat('single quote must be doubled: ', s__706);
    end;
    temper.test_assert(test_222, t_231, fn__10414);
    return nil;
  end);
end;
Test_.test_toInsertSqlProducesCorrectSqlForStringField__1563 = function()
  temper.test('toInsertSql produces correct SQL for string field', function(test_232)
    local t_233, params__708, t_234, t_235, t_236, cs__709, sqlFrag__710, local_237, local_238, local_239, s__711, t_241, fn__10394, t_242, fn__10393;
    params__708 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Alice'), temper.pair_constructor('email', 'a@example.com')));
    t_234 = userTable__504();
    t_235 = csid__503('name');
    t_236 = csid__503('email');
    cs__709 = changeset(t_234, params__708):cast(temper.listof(t_235, t_236)):validateRequired(temper.listof(csid__503('name'), csid__503('email')));
    local_237, local_238, local_239 = temper.pcall(function()
      t_233 = cs__709:toInsertSql();
      sqlFrag__710 = t_233;
    end);
    if local_237 then
    else
      sqlFrag__710 = temper.bubble();
    end
    s__711 = sqlFrag__710:toString();
    t_241 = temper.is_string_index(temper.string_indexof(s__711, 'INSERT INTO users'));
    fn__10394 = function()
      return temper.concat('has INSERT INTO: ', s__711);
    end;
    temper.test_assert(test_232, t_241, fn__10394);
    t_242 = temper.is_string_index(temper.string_indexof(s__711, "'Alice'"));
    fn__10393 = function()
      return temper.concat('has quoted name: ', s__711);
    end;
    temper.test_assert(test_232, t_242, fn__10393);
    return nil;
  end);
end;
Test_.test_toInsertSqlProducesCorrectSqlForIntField__1564 = function()
  temper.test('toInsertSql produces correct SQL for int field', function(test_243)
    local t_244, params__713, t_245, t_246, t_247, t_248, cs__714, sqlFrag__715, local_249, local_250, local_251, s__716, t_253, fn__10375;
    params__713 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Bob'), temper.pair_constructor('email', 'b@example.com'), temper.pair_constructor('age', '25')));
    t_245 = userTable__504();
    t_246 = csid__503('name');
    t_247 = csid__503('email');
    t_248 = csid__503('age');
    cs__714 = changeset(t_245, params__713):cast(temper.listof(t_246, t_247, t_248)):validateRequired(temper.listof(csid__503('name'), csid__503('email')));
    local_249, local_250, local_251 = temper.pcall(function()
      t_244 = cs__714:toInsertSql();
      sqlFrag__715 = t_244;
    end);
    if local_249 then
    else
      sqlFrag__715 = temper.bubble();
    end
    s__716 = sqlFrag__715:toString();
    t_253 = temper.is_string_index(temper.string_indexof(s__716, '25'));
    fn__10375 = function()
      return temper.concat('age rendered unquoted: ', s__716);
    end;
    temper.test_assert(test_243, t_253, fn__10375);
    return nil;
  end);
end;
Test_.test_toInsertSqlBubblesOnInvalidChangeset__1565 = function()
  temper.test('toInsertSql bubbles on invalid changeset', function(test_254)
    local params__718, t_255, t_256, cs__719, didBubble__720, local_257, local_258, local_259, fn__10366;
    params__718 = temper.map_constructor(temper.listof());
    t_255 = userTable__504();
    t_256 = csid__503('name');
    cs__719 = changeset(t_255, params__718):cast(temper.listof(t_256)):validateRequired(temper.listof(csid__503('name')));
    local_257, local_258, local_259 = temper.pcall(function()
      cs__719:toInsertSql();
      didBubble__720 = false;
    end);
    if local_257 then
    else
      didBubble__720 = true;
    end
    fn__10366 = function()
      return 'invalid changeset should bubble';
    end;
    temper.test_assert(test_254, didBubble__720, fn__10366);
    return nil;
  end);
end;
Test_.test_toInsertSqlEnforcesNonNullableFieldsIndependentlyOfIsValid__1566 = function()
  temper.test('toInsertSql enforces non-nullable fields independently of isValid', function(test_261)
    local strictTable__722, params__723, t_262, cs__724, t_263, fn__10348, didBubble__725, local_264, local_265, local_266, fn__10347;
    strictTable__722 = TableDef(csid__503('posts'), temper.listof(FieldDef(csid__503('title'), StringField(), false), FieldDef(csid__503('body'), StringField(), true)));
    params__723 = temper.map_constructor(temper.listof(temper.pair_constructor('body', 'hello')));
    t_262 = csid__503('body');
    cs__724 = changeset(strictTable__722, params__723):cast(temper.listof(t_262));
    t_263 = cs__724.isValid;
    fn__10348 = function()
      return 'changeset should appear valid (no explicit validation run)';
    end;
    temper.test_assert(test_261, t_263, fn__10348);
    local_264, local_265, local_266 = temper.pcall(function()
      cs__724:toInsertSql();
      didBubble__725 = false;
    end);
    if local_264 then
    else
      didBubble__725 = true;
    end
    fn__10347 = function()
      return 'toInsertSql should enforce nullable regardless of isValid';
    end;
    temper.test_assert(test_261, didBubble__725, fn__10347);
    return nil;
  end);
end;
Test_.test_toUpdateSqlProducesCorrectSql__1567 = function()
  temper.test('toUpdateSql produces correct SQL', function(test_268)
    local t_269, params__727, t_270, t_271, cs__728, sqlFrag__729, local_272, local_273, local_274, s__730, t_276, fn__10335;
    params__727 = temper.map_constructor(temper.listof(temper.pair_constructor('name', 'Bob')));
    t_270 = userTable__504();
    t_271 = csid__503('name');
    cs__728 = changeset(t_270, params__727):cast(temper.listof(t_271)):validateRequired(temper.listof(csid__503('name')));
    local_272, local_273, local_274 = temper.pcall(function()
      t_269 = cs__728:toUpdateSql(42);
      sqlFrag__729 = t_269;
    end);
    if local_272 then
    else
      sqlFrag__729 = temper.bubble();
    end
    s__730 = sqlFrag__729:toString();
    t_276 = temper.str_eq(s__730, "UPDATE users SET name = 'Bob' WHERE id = 42");
    fn__10335 = function()
      return temper.concat('got: ', s__730);
    end;
    temper.test_assert(test_268, t_276, fn__10335);
    return nil;
  end);
end;
Test_.test_toUpdateSqlBubblesOnInvalidChangeset__1568 = function()
  temper.test('toUpdateSql bubbles on invalid changeset', function(test_277)
    local params__732, t_278, t_279, cs__733, didBubble__734, local_280, local_281, local_282, fn__10326;
    params__732 = temper.map_constructor(temper.listof());
    t_278 = userTable__504();
    t_279 = csid__503('name');
    cs__733 = changeset(t_278, params__732):cast(temper.listof(t_279)):validateRequired(temper.listof(csid__503('name')));
    local_280, local_281, local_282 = temper.pcall(function()
      cs__733:toUpdateSql(1);
      didBubble__734 = false;
    end);
    if local_280 then
    else
      didBubble__734 = true;
    end
    fn__10326 = function()
      return 'invalid changeset should bubble';
    end;
    temper.test_assert(test_277, didBubble__734, fn__10326);
    return nil;
  end);
end;
sid__505 = function(name__1039)
  local return__424, t_284, local_285, local_286, local_287;
  local_285, local_286, local_287 = temper.pcall(function()
    t_284 = safeIdentifier(name__1039);
    return__424 = t_284;
  end);
  if local_285 then
  else
    return__424 = temper.bubble();
  end
  return return__424;
end;
Test_.test_bareFromProducesSelect__1644 = function()
  temper.test('bare from produces SELECT *', function(test_289)
    local q__1042, t_290, fn__9832;
    q__1042 = from(sid__505('users'));
    t_290 = temper.str_eq(q__1042:toSql():toString(), 'SELECT * FROM users');
    fn__9832 = function()
      return 'bare query';
    end;
    temper.test_assert(test_289, t_290, fn__9832);
    return nil;
  end);
end;
Test_.test_selectRestrictsColumns__1645 = function()
  temper.test('select restricts columns', function(test_291)
    local t_292, t_293, t_294, q__1044, t_295, fn__9822;
    t_292 = sid__505('users');
    t_293 = sid__505('id');
    t_294 = sid__505('name');
    q__1044 = from(t_292):select(temper.listof(t_293, t_294));
    t_295 = temper.str_eq(q__1044:toSql():toString(), 'SELECT id, name FROM users');
    fn__9822 = function()
      return 'select columns';
    end;
    temper.test_assert(test_291, t_295, fn__9822);
    return nil;
  end);
end;
Test_.test_whereAddsConditionWithIntValue__1646 = function()
  temper.test('where adds condition with int value', function(test_296)
    local t_297, t_298, t_299, q__1046, t_300, fn__9810;
    t_297 = sid__505('users');
    t_298 = SqlBuilder();
    t_298:appendSafe('age > ');
    t_298:appendInt32(18);
    t_299 = t_298.accumulated;
    q__1046 = from(t_297):where(t_299);
    t_300 = temper.str_eq(q__1046:toSql():toString(), 'SELECT * FROM users WHERE age > 18');
    fn__9810 = function()
      return 'where int';
    end;
    temper.test_assert(test_296, t_300, fn__9810);
    return nil;
  end);
end;
Test_.test_whereAddsConditionWithBoolValue__1648 = function()
  temper.test('where adds condition with bool value', function(test_301)
    local t_302, t_303, t_304, q__1048, t_305, fn__9798;
    t_302 = sid__505('users');
    t_303 = SqlBuilder();
    t_303:appendSafe('active = ');
    t_303:appendBoolean(true);
    t_304 = t_303.accumulated;
    q__1048 = from(t_302):where(t_304);
    t_305 = temper.str_eq(q__1048:toSql():toString(), 'SELECT * FROM users WHERE active = TRUE');
    fn__9798 = function()
      return 'where bool';
    end;
    temper.test_assert(test_301, t_305, fn__9798);
    return nil;
  end);
end;
Test_.test_chainedWhereUsesAnd__1650 = function()
  temper.test('chained where uses AND', function(test_306)
    local t_307, t_308, t_309, t_310, t_311, q__1050, t_312, fn__9781;
    t_307 = sid__505('users');
    t_308 = SqlBuilder();
    t_308:appendSafe('age > ');
    t_308:appendInt32(18);
    t_309 = t_308.accumulated;
    t_310 = from(t_307):where(t_309);
    t_311 = SqlBuilder();
    t_311:appendSafe('active = ');
    t_311:appendBoolean(true);
    q__1050 = t_310:where(t_311.accumulated);
    t_312 = temper.str_eq(q__1050:toSql():toString(), 'SELECT * FROM users WHERE age > 18 AND active = TRUE');
    fn__9781 = function()
      return 'chained where';
    end;
    temper.test_assert(test_306, t_312, fn__9781);
    return nil;
  end);
end;
Test_.test_orderByAsc__1653 = function()
  temper.test('orderBy ASC', function(test_313)
    local t_314, t_315, q__1052, t_316, fn__9772;
    t_314 = sid__505('users');
    t_315 = sid__505('name');
    q__1052 = from(t_314):orderBy(t_315, true);
    t_316 = temper.str_eq(q__1052:toSql():toString(), 'SELECT * FROM users ORDER BY name ASC');
    fn__9772 = function()
      return 'order asc';
    end;
    temper.test_assert(test_313, t_316, fn__9772);
    return nil;
  end);
end;
Test_.test_orderByDesc__1654 = function()
  temper.test('orderBy DESC', function(test_317)
    local t_318, t_319, q__1054, t_320, fn__9763;
    t_318 = sid__505('users');
    t_319 = sid__505('created_at');
    q__1054 = from(t_318):orderBy(t_319, false);
    t_320 = temper.str_eq(q__1054:toSql():toString(), 'SELECT * FROM users ORDER BY created_at DESC');
    fn__9763 = function()
      return 'order desc';
    end;
    temper.test_assert(test_317, t_320, fn__9763);
    return nil;
  end);
end;
Test_.test_limitAndOffset__1655 = function()
  temper.test('limit and offset', function(test_321)
    local t_322, t_323, q__1056, local_324, local_325, local_326, t_328, fn__9756;
    local_324, local_325, local_326 = temper.pcall(function()
      t_322 = from(sid__505('users')):limit(10);
      t_323 = t_322:offset(20);
      q__1056 = t_323;
    end);
    if local_324 then
    else
      q__1056 = temper.bubble();
    end
    t_328 = temper.str_eq(q__1056:toSql():toString(), 'SELECT * FROM users LIMIT 10 OFFSET 20');
    fn__9756 = function()
      return 'limit/offset';
    end;
    temper.test_assert(test_321, t_328, fn__9756);
    return nil;
  end);
end;
Test_.test_limitBubblesOnNegative__1656 = function()
  temper.test('limit bubbles on negative', function(test_329)
    local didBubble__1058, local_330, local_331, local_332, fn__9752;
    local_330, local_331, local_332 = temper.pcall(function()
      from(sid__505('users')):limit(-1);
      didBubble__1058 = false;
    end);
    if local_330 then
    else
      didBubble__1058 = true;
    end
    fn__9752 = function()
      return 'negative limit should bubble';
    end;
    temper.test_assert(test_329, didBubble__1058, fn__9752);
    return nil;
  end);
end;
Test_.test_offsetBubblesOnNegative__1657 = function()
  temper.test('offset bubbles on negative', function(test_334)
    local didBubble__1060, local_335, local_336, local_337, fn__9748;
    local_335, local_336, local_337 = temper.pcall(function()
      from(sid__505('users')):offset(-1);
      didBubble__1060 = false;
    end);
    if local_335 then
    else
      didBubble__1060 = true;
    end
    fn__9748 = function()
      return 'negative offset should bubble';
    end;
    temper.test_assert(test_334, didBubble__1060, fn__9748);
    return nil;
  end);
end;
Test_.test_complexComposedQuery__1658 = function()
  temper.test('complex composed query', function(test_339)
    local t_340, t_341, t_342, t_343, t_344, t_345, t_346, t_347, t_348, t_349, minAge__1062, q__1063, local_350, local_351, local_352, t_354, fn__9725;
    minAge__1062 = 21;
    local_350, local_351, local_352 = temper.pcall(function()
      t_340 = sid__505('users');
      t_341 = sid__505('id');
      t_342 = sid__505('name');
      t_343 = sid__505('email');
      t_344 = from(t_340):select(temper.listof(t_341, t_342, t_343));
      t_345 = SqlBuilder();
      t_345:appendSafe('age >= ');
      t_345:appendInt32(21);
      t_346 = t_344:where(t_345.accumulated);
      t_347 = SqlBuilder();
      t_347:appendSafe('active = ');
      t_347:appendBoolean(true);
      t_348 = t_346:where(t_347.accumulated):orderBy(sid__505('name'), true):limit(25);
      t_349 = t_348:offset(0);
      q__1063 = t_349;
    end);
    if local_350 then
    else
      q__1063 = temper.bubble();
    end
    t_354 = temper.str_eq(q__1063:toSql():toString(), 'SELECT id, name, email FROM users WHERE age >= 21 AND active = TRUE ORDER BY name ASC LIMIT 25 OFFSET 0');
    fn__9725 = function()
      return 'complex query';
    end;
    temper.test_assert(test_339, t_354, fn__9725);
    return nil;
  end);
end;
Test_.test_safeToSqlAppliesDefaultLimitWhenNoneSet__1661 = function()
  temper.test('safeToSql applies default limit when none set', function(test_355)
    local t_356, t_357, q__1065, local_358, local_359, local_360, s__1066, t_362, fn__9719;
    q__1065 = from(sid__505('users'));
    local_358, local_359, local_360 = temper.pcall(function()
      t_356 = q__1065:safeToSql(100);
      t_357 = t_356;
    end);
    if local_358 then
    else
      t_357 = temper.bubble();
    end
    s__1066 = t_357:toString();
    t_362 = temper.str_eq(s__1066, 'SELECT * FROM users LIMIT 100');
    fn__9719 = function()
      return temper.concat('should have limit: ', s__1066);
    end;
    temper.test_assert(test_355, t_362, fn__9719);
    return nil;
  end);
end;
Test_.test_safeToSqlRespectsExplicitLimit__1662 = function()
  temper.test('safeToSql respects explicit limit', function(test_363)
    local t_364, t_365, t_366, q__1068, local_367, local_368, local_369, local_371, local_372, local_373, s__1069, t_375, fn__9713;
    local_367, local_368, local_369 = temper.pcall(function()
      t_364 = from(sid__505('users')):limit(5);
      q__1068 = t_364;
    end);
    if local_367 then
    else
      q__1068 = temper.bubble();
    end
    local_371, local_372, local_373 = temper.pcall(function()
      t_365 = q__1068:safeToSql(100);
      t_366 = t_365;
    end);
    if local_371 then
    else
      t_366 = temper.bubble();
    end
    s__1069 = t_366:toString();
    t_375 = temper.str_eq(s__1069, 'SELECT * FROM users LIMIT 5');
    fn__9713 = function()
      return temper.concat('explicit limit preserved: ', s__1069);
    end;
    temper.test_assert(test_363, t_375, fn__9713);
    return nil;
  end);
end;
Test_.test_safeToSqlBubblesOnNegativeDefaultLimit__1663 = function()
  temper.test('safeToSql bubbles on negative defaultLimit', function(test_376)
    local didBubble__1071, local_377, local_378, local_379, fn__9709;
    local_377, local_378, local_379 = temper.pcall(function()
      from(sid__505('users')):safeToSql(-1);
      didBubble__1071 = false;
    end);
    if local_377 then
    else
      didBubble__1071 = true;
    end
    fn__9709 = function()
      return 'negative defaultLimit should bubble';
    end;
    temper.test_assert(test_376, didBubble__1071, fn__9709);
    return nil;
  end);
end;
Test_.test_whereWithInjectionAttemptInStringValueIsEscaped__1664 = function()
  temper.test('where with injection attempt in string value is escaped', function(test_381)
    local evil__1073, t_382, t_383, t_384, q__1074, s__1075, t_385, fn__9692, t_386, fn__9691;
    evil__1073 = "'; DROP TABLE users; --";
    t_382 = sid__505('users');
    t_383 = SqlBuilder();
    t_383:appendSafe('name = ');
    t_383:appendString("'; DROP TABLE users; --");
    t_384 = t_383.accumulated;
    q__1074 = from(t_382):where(t_384);
    s__1075 = q__1074:toSql():toString();
    t_385 = temper.is_string_index(temper.string_indexof(s__1075, "''"));
    fn__9692 = function()
      return temper.concat('quotes must be doubled: ', s__1075);
    end;
    temper.test_assert(test_381, t_385, fn__9692);
    t_386 = temper.is_string_index(temper.string_indexof(s__1075, 'SELECT * FROM users WHERE name ='));
    fn__9691 = function()
      return temper.concat('structure intact: ', s__1075);
    end;
    temper.test_assert(test_381, t_386, fn__9691);
    return nil;
  end);
end;
Test_.test_safeIdentifierRejectsUserSuppliedTableNameWithMetacharacters__1666 = function()
  temper.test('safeIdentifier rejects user-supplied table name with metacharacters', function(test_387)
    local attack__1077, didBubble__1078, local_388, local_389, local_390, fn__9688;
    attack__1077 = 'users; DROP TABLE users; --';
    local_388, local_389, local_390 = temper.pcall(function()
      safeIdentifier('users; DROP TABLE users; --');
      didBubble__1078 = false;
    end);
    if local_388 then
    else
      didBubble__1078 = true;
    end
    fn__9688 = function()
      return 'metacharacter-containing name must be rejected at construction';
    end;
    temper.test_assert(test_387, didBubble__1078, fn__9688);
    return nil;
  end);
end;
Test_.test_innerJoinProducesInnerJoin__1667 = function()
  temper.test('innerJoin produces INNER JOIN', function(test_392)
    local t_393, t_394, t_395, t_396, q__1080, t_397, fn__9676;
    t_393 = sid__505('users');
    t_394 = sid__505('orders');
    t_395 = SqlBuilder();
    t_395:appendSafe('users.id = orders.user_id');
    t_396 = t_395.accumulated;
    q__1080 = from(t_393):innerJoin(t_394, t_396);
    t_397 = temper.str_eq(q__1080:toSql():toString(), 'SELECT * FROM users INNER JOIN orders ON users.id = orders.user_id');
    fn__9676 = function()
      return 'inner join';
    end;
    temper.test_assert(test_392, t_397, fn__9676);
    return nil;
  end);
end;
Test_.test_leftJoinProducesLeftJoin__1669 = function()
  temper.test('leftJoin produces LEFT JOIN', function(test_398)
    local t_399, t_400, t_401, t_402, q__1082, t_403, fn__9664;
    t_399 = sid__505('users');
    t_400 = sid__505('profiles');
    t_401 = SqlBuilder();
    t_401:appendSafe('users.id = profiles.user_id');
    t_402 = t_401.accumulated;
    q__1082 = from(t_399):leftJoin(t_400, t_402);
    t_403 = temper.str_eq(q__1082:toSql():toString(), 'SELECT * FROM users LEFT JOIN profiles ON users.id = profiles.user_id');
    fn__9664 = function()
      return 'left join';
    end;
    temper.test_assert(test_398, t_403, fn__9664);
    return nil;
  end);
end;
Test_.test_rightJoinProducesRightJoin__1671 = function()
  temper.test('rightJoin produces RIGHT JOIN', function(test_404)
    local t_405, t_406, t_407, t_408, q__1084, t_409, fn__9652;
    t_405 = sid__505('orders');
    t_406 = sid__505('users');
    t_407 = SqlBuilder();
    t_407:appendSafe('orders.user_id = users.id');
    t_408 = t_407.accumulated;
    q__1084 = from(t_405):rightJoin(t_406, t_408);
    t_409 = temper.str_eq(q__1084:toSql():toString(), 'SELECT * FROM orders RIGHT JOIN users ON orders.user_id = users.id');
    fn__9652 = function()
      return 'right join';
    end;
    temper.test_assert(test_404, t_409, fn__9652);
    return nil;
  end);
end;
Test_.test_fullJoinProducesFullOuterJoin__1673 = function()
  temper.test('fullJoin produces FULL OUTER JOIN', function(test_410)
    local t_411, t_412, t_413, t_414, q__1086, t_415, fn__9640;
    t_411 = sid__505('users');
    t_412 = sid__505('orders');
    t_413 = SqlBuilder();
    t_413:appendSafe('users.id = orders.user_id');
    t_414 = t_413.accumulated;
    q__1086 = from(t_411):fullJoin(t_412, t_414);
    t_415 = temper.str_eq(q__1086:toSql():toString(), 'SELECT * FROM users FULL OUTER JOIN orders ON users.id = orders.user_id');
    fn__9640 = function()
      return 'full join';
    end;
    temper.test_assert(test_410, t_415, fn__9640);
    return nil;
  end);
end;
Test_.test_chainedJoins__1675 = function()
  temper.test('chained joins', function(test_416)
    local t_417, t_418, t_419, t_420, t_421, t_422, t_423, q__1088, t_424, fn__9623;
    t_417 = sid__505('users');
    t_418 = sid__505('orders');
    t_419 = SqlBuilder();
    t_419:appendSafe('users.id = orders.user_id');
    t_420 = t_419.accumulated;
    t_421 = from(t_417):innerJoin(t_418, t_420);
    t_422 = sid__505('profiles');
    t_423 = SqlBuilder();
    t_423:appendSafe('users.id = profiles.user_id');
    q__1088 = t_421:leftJoin(t_422, t_423.accumulated);
    t_424 = temper.str_eq(q__1088:toSql():toString(), 'SELECT * FROM users INNER JOIN orders ON users.id = orders.user_id LEFT JOIN profiles ON users.id = profiles.user_id');
    fn__9623 = function()
      return 'chained joins';
    end;
    temper.test_assert(test_416, t_424, fn__9623);
    return nil;
  end);
end;
Test_.test_joinWithWhereAndOrderBy__1678 = function()
  temper.test('join with where and orderBy', function(test_425)
    local t_426, t_427, t_428, t_429, t_430, t_431, t_432, q__1090, local_433, local_434, local_435, t_437, fn__9604;
    local_433, local_434, local_435 = temper.pcall(function()
      t_426 = sid__505('users');
      t_427 = sid__505('orders');
      t_428 = SqlBuilder();
      t_428:appendSafe('users.id = orders.user_id');
      t_429 = t_428.accumulated;
      t_430 = from(t_426):innerJoin(t_427, t_429);
      t_431 = SqlBuilder();
      t_431:appendSafe('orders.total > ');
      t_431:appendInt32(100);
      t_432 = t_430:where(t_431.accumulated):orderBy(sid__505('name'), true):limit(10);
      q__1090 = t_432;
    end);
    if local_433 then
    else
      q__1090 = temper.bubble();
    end
    t_437 = temper.str_eq(q__1090:toSql():toString(), 'SELECT * FROM users INNER JOIN orders ON users.id = orders.user_id WHERE orders.total > 100 ORDER BY name ASC LIMIT 10');
    fn__9604 = function()
      return 'join with where/order/limit';
    end;
    temper.test_assert(test_425, t_437, fn__9604);
    return nil;
  end);
end;
Test_.test_colHelperProducesQualifiedReference__1681 = function()
  temper.test('col helper produces qualified reference', function(test_438)
    local c__1092, t_439, fn__9596;
    c__1092 = col(sid__505('users'), sid__505('id'));
    t_439 = temper.str_eq(c__1092:toString(), 'users.id');
    fn__9596 = function()
      return 'col helper';
    end;
    temper.test_assert(test_438, t_439, fn__9596);
    return nil;
  end);
end;
Test_.test_joinWithColHelper__1682 = function()
  temper.test('join with col helper', function(test_440)
    local onCond__1094, b__1095, t_441, t_442, t_443, q__1096, t_444, fn__9576;
    onCond__1094 = col(sid__505('users'), sid__505('id'));
    b__1095 = SqlBuilder();
    b__1095:appendFragment(onCond__1094);
    b__1095:appendSafe(' = ');
    b__1095:appendFragment(col(sid__505('orders'), sid__505('user_id')));
    t_441 = sid__505('users');
    t_442 = sid__505('orders');
    t_443 = b__1095.accumulated;
    q__1096 = from(t_441):innerJoin(t_442, t_443);
    t_444 = temper.str_eq(q__1096:toSql():toString(), 'SELECT * FROM users INNER JOIN orders ON users.id = orders.user_id');
    fn__9576 = function()
      return 'join with col';
    end;
    temper.test_assert(test_440, t_444, fn__9576);
    return nil;
  end);
end;
Test_.test_orWhereBasic__1683 = function()
  temper.test('orWhere basic', function(test_445)
    local t_446, t_447, t_448, q__1098, t_449, fn__9564;
    t_446 = sid__505('users');
    t_447 = SqlBuilder();
    t_447:appendSafe('status = ');
    t_447:appendString('active');
    t_448 = t_447.accumulated;
    q__1098 = from(t_446):orWhere(t_448);
    t_449 = temper.str_eq(q__1098:toSql():toString(), "SELECT * FROM users WHERE status = 'active'");
    fn__9564 = function()
      return 'orWhere basic';
    end;
    temper.test_assert(test_445, t_449, fn__9564);
    return nil;
  end);
end;
Test_.test_whereThenOrWhere__1685 = function()
  temper.test('where then orWhere', function(test_450)
    local t_451, t_452, t_453, t_454, t_455, q__1100, t_456, fn__9547;
    t_451 = sid__505('users');
    t_452 = SqlBuilder();
    t_452:appendSafe('age > ');
    t_452:appendInt32(18);
    t_453 = t_452.accumulated;
    t_454 = from(t_451):where(t_453);
    t_455 = SqlBuilder();
    t_455:appendSafe('vip = ');
    t_455:appendBoolean(true);
    q__1100 = t_454:orWhere(t_455.accumulated);
    t_456 = temper.str_eq(q__1100:toSql():toString(), 'SELECT * FROM users WHERE age > 18 OR vip = TRUE');
    fn__9547 = function()
      return 'where then orWhere';
    end;
    temper.test_assert(test_450, t_456, fn__9547);
    return nil;
  end);
end;
Test_.test_multipleOrWhere__1688 = function()
  temper.test('multiple orWhere', function(test_457)
    local t_458, t_459, t_460, t_461, t_462, t_463, t_464, q__1102, t_465, fn__9525;
    t_458 = sid__505('users');
    t_459 = SqlBuilder();
    t_459:appendSafe('active = ');
    t_459:appendBoolean(true);
    t_460 = t_459.accumulated;
    t_461 = from(t_458):where(t_460);
    t_462 = SqlBuilder();
    t_462:appendSafe('role = ');
    t_462:appendString('admin');
    t_463 = t_461:orWhere(t_462.accumulated);
    t_464 = SqlBuilder();
    t_464:appendSafe('role = ');
    t_464:appendString('moderator');
    q__1102 = t_463:orWhere(t_464.accumulated);
    t_465 = temper.str_eq(q__1102:toSql():toString(), "SELECT * FROM users WHERE active = TRUE OR role = 'admin' OR role = 'moderator'");
    fn__9525 = function()
      return 'multiple orWhere';
    end;
    temper.test_assert(test_457, t_465, fn__9525);
    return nil;
  end);
end;
Test_.test_mixedWhereAndOrWhere__1692 = function()
  temper.test('mixed where and orWhere', function(test_466)
    local t_467, t_468, t_469, t_470, t_471, t_472, t_473, q__1104, t_474, fn__9503;
    t_467 = sid__505('users');
    t_468 = SqlBuilder();
    t_468:appendSafe('age > ');
    t_468:appendInt32(18);
    t_469 = t_468.accumulated;
    t_470 = from(t_467):where(t_469);
    t_471 = SqlBuilder();
    t_471:appendSafe('active = ');
    t_471:appendBoolean(true);
    t_472 = t_470:where(t_471.accumulated);
    t_473 = SqlBuilder();
    t_473:appendSafe('vip = ');
    t_473:appendBoolean(true);
    q__1104 = t_472:orWhere(t_473.accumulated);
    t_474 = temper.str_eq(q__1104:toSql():toString(), 'SELECT * FROM users WHERE age > 18 AND active = TRUE OR vip = TRUE');
    fn__9503 = function()
      return 'mixed where and orWhere';
    end;
    temper.test_assert(test_466, t_474, fn__9503);
    return nil;
  end);
end;
Test_.test_whereNull__1696 = function()
  temper.test('whereNull', function(test_475)
    local t_476, t_477, q__1106, t_478, fn__9494;
    t_476 = sid__505('users');
    t_477 = sid__505('deleted_at');
    q__1106 = from(t_476):whereNull(t_477);
    t_478 = temper.str_eq(q__1106:toSql():toString(), 'SELECT * FROM users WHERE deleted_at IS NULL');
    fn__9494 = function()
      return 'whereNull';
    end;
    temper.test_assert(test_475, t_478, fn__9494);
    return nil;
  end);
end;
Test_.test_whereNotNull__1697 = function()
  temper.test('whereNotNull', function(test_479)
    local t_480, t_481, q__1108, t_482, fn__9485;
    t_480 = sid__505('users');
    t_481 = sid__505('email');
    q__1108 = from(t_480):whereNotNull(t_481);
    t_482 = temper.str_eq(q__1108:toSql():toString(), 'SELECT * FROM users WHERE email IS NOT NULL');
    fn__9485 = function()
      return 'whereNotNull';
    end;
    temper.test_assert(test_479, t_482, fn__9485);
    return nil;
  end);
end;
Test_.test_whereNullChainedWithWhere__1698 = function()
  temper.test('whereNull chained with where', function(test_483)
    local t_484, t_485, t_486, q__1110, t_487, fn__9471;
    t_484 = sid__505('users');
    t_485 = SqlBuilder();
    t_485:appendSafe('active = ');
    t_485:appendBoolean(true);
    t_486 = t_485.accumulated;
    q__1110 = from(t_484):where(t_486):whereNull(sid__505('deleted_at'));
    t_487 = temper.str_eq(q__1110:toSql():toString(), 'SELECT * FROM users WHERE active = TRUE AND deleted_at IS NULL');
    fn__9471 = function()
      return 'whereNull chained';
    end;
    temper.test_assert(test_483, t_487, fn__9471);
    return nil;
  end);
end;
Test_.test_whereNotNullChainedWithOrWhere__1700 = function()
  temper.test('whereNotNull chained with orWhere', function(test_488)
    local t_489, t_490, t_491, t_492, q__1112, t_493, fn__9457;
    t_489 = sid__505('users');
    t_490 = sid__505('deleted_at');
    t_491 = from(t_489):whereNull(t_490);
    t_492 = SqlBuilder();
    t_492:appendSafe('role = ');
    t_492:appendString('admin');
    q__1112 = t_491:orWhere(t_492.accumulated);
    t_493 = temper.str_eq(q__1112:toSql():toString(), "SELECT * FROM users WHERE deleted_at IS NULL OR role = 'admin'");
    fn__9457 = function()
      return 'whereNotNull with orWhere';
    end;
    temper.test_assert(test_488, t_493, fn__9457);
    return nil;
  end);
end;
Test_.test_whereInWithIntValues__1702 = function()
  temper.test('whereIn with int values', function(test_494)
    local t_495, t_496, t_497, t_498, t_499, q__1114, t_500, fn__9445;
    t_495 = sid__505('users');
    t_496 = sid__505('id');
    t_497 = SqlInt32(1);
    t_498 = SqlInt32(2);
    t_499 = SqlInt32(3);
    q__1114 = from(t_495):whereIn(t_496, temper.listof(t_497, t_498, t_499));
    t_500 = temper.str_eq(q__1114:toSql():toString(), 'SELECT * FROM users WHERE id IN (1, 2, 3)');
    fn__9445 = function()
      return 'whereIn ints';
    end;
    temper.test_assert(test_494, t_500, fn__9445);
    return nil;
  end);
end;
Test_.test_whereInWithStringValuesEscaping__1703 = function()
  temper.test('whereIn with string values escaping', function(test_501)
    local t_502, t_503, t_504, t_505, q__1116, t_506, fn__9434;
    t_502 = sid__505('users');
    t_503 = sid__505('name');
    t_504 = SqlString('Alice');
    t_505 = SqlString("Bob's");
    q__1116 = from(t_502):whereIn(t_503, temper.listof(t_504, t_505));
    t_506 = temper.str_eq(q__1116:toSql():toString(), "SELECT * FROM users WHERE name IN ('Alice', 'Bob''s')");
    fn__9434 = function()
      return 'whereIn strings';
    end;
    temper.test_assert(test_501, t_506, fn__9434);
    return nil;
  end);
end;
Test_.test_whereInWithEmptyListProduces1_0__1704 = function()
  temper.test('whereIn with empty list produces 1=0', function(test_507)
    local t_508, t_509, q__1118, t_510, fn__9425;
    t_508 = sid__505('users');
    t_509 = sid__505('id');
    q__1118 = from(t_508):whereIn(t_509, temper.listof());
    t_510 = temper.str_eq(q__1118:toSql():toString(), 'SELECT * FROM users WHERE 1 = 0');
    fn__9425 = function()
      return 'whereIn empty';
    end;
    temper.test_assert(test_507, t_510, fn__9425);
    return nil;
  end);
end;
Test_.test_whereInChained__1705 = function()
  temper.test('whereIn chained', function(test_511)
    local t_512, t_513, t_514, q__1120, t_515, fn__9409;
    t_512 = sid__505('users');
    t_513 = SqlBuilder();
    t_513:appendSafe('active = ');
    t_513:appendBoolean(true);
    t_514 = t_513.accumulated;
    q__1120 = from(t_512):where(t_514):whereIn(sid__505('role'), temper.listof(SqlString('admin'), SqlString('user')));
    t_515 = temper.str_eq(q__1120:toSql():toString(), "SELECT * FROM users WHERE active = TRUE AND role IN ('admin', 'user')");
    fn__9409 = function()
      return 'whereIn chained';
    end;
    temper.test_assert(test_511, t_515, fn__9409);
    return nil;
  end);
end;
Test_.test_whereInSingleElement__1707 = function()
  temper.test('whereIn single element', function(test_516)
    local t_517, t_518, t_519, q__1122, t_520, fn__9399;
    t_517 = sid__505('users');
    t_518 = sid__505('id');
    t_519 = SqlInt32(42);
    q__1122 = from(t_517):whereIn(t_518, temper.listof(t_519));
    t_520 = temper.str_eq(q__1122:toSql():toString(), 'SELECT * FROM users WHERE id IN (42)');
    fn__9399 = function()
      return 'whereIn single';
    end;
    temper.test_assert(test_516, t_520, fn__9399);
    return nil;
  end);
end;
Test_.test_whereNotBasic__1708 = function()
  temper.test('whereNot basic', function(test_521)
    local t_522, t_523, t_524, q__1124, t_525, fn__9387;
    t_522 = sid__505('users');
    t_523 = SqlBuilder();
    t_523:appendSafe('active = ');
    t_523:appendBoolean(true);
    t_524 = t_523.accumulated;
    q__1124 = from(t_522):whereNot(t_524);
    t_525 = temper.str_eq(q__1124:toSql():toString(), 'SELECT * FROM users WHERE NOT (active = TRUE)');
    fn__9387 = function()
      return 'whereNot';
    end;
    temper.test_assert(test_521, t_525, fn__9387);
    return nil;
  end);
end;
Test_.test_whereNotChained__1710 = function()
  temper.test('whereNot chained', function(test_526)
    local t_527, t_528, t_529, t_530, t_531, q__1126, t_532, fn__9370;
    t_527 = sid__505('users');
    t_528 = SqlBuilder();
    t_528:appendSafe('age > ');
    t_528:appendInt32(18);
    t_529 = t_528.accumulated;
    t_530 = from(t_527):where(t_529);
    t_531 = SqlBuilder();
    t_531:appendSafe('banned = ');
    t_531:appendBoolean(true);
    q__1126 = t_530:whereNot(t_531.accumulated);
    t_532 = temper.str_eq(q__1126:toSql():toString(), 'SELECT * FROM users WHERE age > 18 AND NOT (banned = TRUE)');
    fn__9370 = function()
      return 'whereNot chained';
    end;
    temper.test_assert(test_526, t_532, fn__9370);
    return nil;
  end);
end;
Test_.test_whereBetweenIntegers__1713 = function()
  temper.test('whereBetween integers', function(test_533)
    local t_534, t_535, t_536, t_537, q__1128, t_538, fn__9359;
    t_534 = sid__505('users');
    t_535 = sid__505('age');
    t_536 = SqlInt32(18);
    t_537 = SqlInt32(65);
    q__1128 = from(t_534):whereBetween(t_535, t_536, t_537);
    t_538 = temper.str_eq(q__1128:toSql():toString(), 'SELECT * FROM users WHERE age BETWEEN 18 AND 65');
    fn__9359 = function()
      return 'whereBetween ints';
    end;
    temper.test_assert(test_533, t_538, fn__9359);
    return nil;
  end);
end;
Test_.test_whereBetweenChained__1714 = function()
  temper.test('whereBetween chained', function(test_539)
    local t_540, t_541, t_542, q__1130, t_543, fn__9343;
    t_540 = sid__505('users');
    t_541 = SqlBuilder();
    t_541:appendSafe('active = ');
    t_541:appendBoolean(true);
    t_542 = t_541.accumulated;
    q__1130 = from(t_540):where(t_542):whereBetween(sid__505('age'), SqlInt32(21), SqlInt32(30));
    t_543 = temper.str_eq(q__1130:toSql():toString(), 'SELECT * FROM users WHERE active = TRUE AND age BETWEEN 21 AND 30');
    fn__9343 = function()
      return 'whereBetween chained';
    end;
    temper.test_assert(test_539, t_543, fn__9343);
    return nil;
  end);
end;
Test_.test_whereLikeBasic__1716 = function()
  temper.test('whereLike basic', function(test_544)
    local t_545, t_546, q__1132, t_547, fn__9334;
    t_545 = sid__505('users');
    t_546 = sid__505('name');
    q__1132 = from(t_545):whereLike(t_546, 'John%');
    t_547 = temper.str_eq(q__1132:toSql():toString(), "SELECT * FROM users WHERE name LIKE 'John%'");
    fn__9334 = function()
      return 'whereLike';
    end;
    temper.test_assert(test_544, t_547, fn__9334);
    return nil;
  end);
end;
Test_.test_whereIlikeBasic__1717 = function()
  temper.test('whereILike basic', function(test_548)
    local t_549, t_550, q__1134, t_551, fn__9325;
    t_549 = sid__505('users');
    t_550 = sid__505('email');
    q__1134 = from(t_549):whereILike(t_550, '%@gmail.com');
    t_551 = temper.str_eq(q__1134:toSql():toString(), "SELECT * FROM users WHERE email ILIKE '%@gmail.com'");
    fn__9325 = function()
      return 'whereILike';
    end;
    temper.test_assert(test_548, t_551, fn__9325);
    return nil;
  end);
end;
Test_.test_whereLikeWithInjectionAttempt__1718 = function()
  temper.test('whereLike with injection attempt', function(test_552)
    local t_553, t_554, q__1136, s__1137, t_555, fn__9311, t_556, fn__9310;
    t_553 = sid__505('users');
    t_554 = sid__505('name');
    q__1136 = from(t_553):whereLike(t_554, "'; DROP TABLE users; --");
    s__1137 = q__1136:toSql():toString();
    t_555 = temper.is_string_index(temper.string_indexof(s__1137, "''"));
    fn__9311 = function()
      return temper.concat('like injection escaped: ', s__1137);
    end;
    temper.test_assert(test_552, t_555, fn__9311);
    t_556 = temper.is_string_index(temper.string_indexof(s__1137, 'LIKE'));
    fn__9310 = function()
      return temper.concat('like structure intact: ', s__1137);
    end;
    temper.test_assert(test_552, t_556, fn__9310);
    return nil;
  end);
end;
Test_.test_whereLikeWildcardPatterns__1719 = function()
  temper.test('whereLike wildcard patterns', function(test_557)
    local t_558, t_559, q__1139, t_560, fn__9301;
    t_558 = sid__505('users');
    t_559 = sid__505('name');
    q__1139 = from(t_558):whereLike(t_559, '%son%');
    t_560 = temper.str_eq(q__1139:toSql():toString(), "SELECT * FROM users WHERE name LIKE '%son%'");
    fn__9301 = function()
      return 'whereLike wildcard';
    end;
    temper.test_assert(test_557, t_560, fn__9301);
    return nil;
  end);
end;
Test_.test_countAllProducesCount__1720 = function()
  temper.test('countAll produces COUNT(*)', function(test_561)
    local f__1141, t_562, fn__9295;
    f__1141 = countAll();
    t_562 = temper.str_eq(f__1141:toString(), 'COUNT(*)');
    fn__9295 = function()
      return 'countAll';
    end;
    temper.test_assert(test_561, t_562, fn__9295);
    return nil;
  end);
end;
Test_.test_countColProducesCountField__1721 = function()
  temper.test('countCol produces COUNT(field)', function(test_563)
    local f__1143, t_564, fn__9288;
    f__1143 = countCol(sid__505('id'));
    t_564 = temper.str_eq(f__1143:toString(), 'COUNT(id)');
    fn__9288 = function()
      return 'countCol';
    end;
    temper.test_assert(test_563, t_564, fn__9288);
    return nil;
  end);
end;
Test_.test_sumColProducesSumField__1722 = function()
  temper.test('sumCol produces SUM(field)', function(test_565)
    local f__1145, t_566, fn__9281;
    f__1145 = sumCol(sid__505('amount'));
    t_566 = temper.str_eq(f__1145:toString(), 'SUM(amount)');
    fn__9281 = function()
      return 'sumCol';
    end;
    temper.test_assert(test_565, t_566, fn__9281);
    return nil;
  end);
end;
Test_.test_avgColProducesAvgField__1723 = function()
  temper.test('avgCol produces AVG(field)', function(test_567)
    local f__1147, t_568, fn__9274;
    f__1147 = avgCol(sid__505('price'));
    t_568 = temper.str_eq(f__1147:toString(), 'AVG(price)');
    fn__9274 = function()
      return 'avgCol';
    end;
    temper.test_assert(test_567, t_568, fn__9274);
    return nil;
  end);
end;
Test_.test_minColProducesMinField__1724 = function()
  temper.test('minCol produces MIN(field)', function(test_569)
    local f__1149, t_570, fn__9267;
    f__1149 = minCol(sid__505('created_at'));
    t_570 = temper.str_eq(f__1149:toString(), 'MIN(created_at)');
    fn__9267 = function()
      return 'minCol';
    end;
    temper.test_assert(test_569, t_570, fn__9267);
    return nil;
  end);
end;
Test_.test_maxColProducesMaxField__1725 = function()
  temper.test('maxCol produces MAX(field)', function(test_571)
    local f__1151, t_572, fn__9260;
    f__1151 = maxCol(sid__505('score'));
    t_572 = temper.str_eq(f__1151:toString(), 'MAX(score)');
    fn__9260 = function()
      return 'maxCol';
    end;
    temper.test_assert(test_571, t_572, fn__9260);
    return nil;
  end);
end;
Test_.test_selectExprWithAggregate__1726 = function()
  temper.test('selectExpr with aggregate', function(test_573)
    local t_574, t_575, q__1153, t_576, fn__9251;
    t_574 = sid__505('orders');
    t_575 = countAll();
    q__1153 = from(t_574):selectExpr(temper.listof(t_575));
    t_576 = temper.str_eq(q__1153:toSql():toString(), 'SELECT COUNT(*) FROM orders');
    fn__9251 = function()
      return 'selectExpr count';
    end;
    temper.test_assert(test_573, t_576, fn__9251);
    return nil;
  end);
end;
Test_.test_selectExprWithMultipleExpressions__1727 = function()
  temper.test('selectExpr with multiple expressions', function(test_577)
    local nameFrag__1155, t_578, t_579, q__1156, t_580, fn__9239;
    nameFrag__1155 = col(sid__505('users'), sid__505('name'));
    t_578 = sid__505('users');
    t_579 = countAll();
    q__1156 = from(t_578):selectExpr(temper.listof(nameFrag__1155, t_579));
    t_580 = temper.str_eq(q__1156:toSql():toString(), 'SELECT users.name, COUNT(*) FROM users');
    fn__9239 = function()
      return 'selectExpr multi';
    end;
    temper.test_assert(test_577, t_580, fn__9239);
    return nil;
  end);
end;
Test_.test_selectExprOverridesSelectedFields__1728 = function()
  temper.test('selectExpr overrides selectedFields', function(test_581)
    local t_582, t_583, t_584, q__1158, t_585, fn__9227;
    t_582 = sid__505('users');
    t_583 = sid__505('id');
    t_584 = sid__505('name');
    q__1158 = from(t_582):select(temper.listof(t_583, t_584)):selectExpr(temper.listof(countAll()));
    t_585 = temper.str_eq(q__1158:toSql():toString(), 'SELECT COUNT(*) FROM users');
    fn__9227 = function()
      return 'selectExpr overrides select';
    end;
    temper.test_assert(test_581, t_585, fn__9227);
    return nil;
  end);
end;
Test_.test_groupBySingleField__1729 = function()
  temper.test('groupBy single field', function(test_586)
    local t_587, t_588, t_589, q__1160, t_590, fn__9213;
    t_587 = sid__505('orders');
    t_588 = col(sid__505('orders'), sid__505('status'));
    t_589 = countAll();
    q__1160 = from(t_587):selectExpr(temper.listof(t_588, t_589)):groupBy(sid__505('status'));
    t_590 = temper.str_eq(q__1160:toSql():toString(), 'SELECT orders.status, COUNT(*) FROM orders GROUP BY status');
    fn__9213 = function()
      return 'groupBy single';
    end;
    temper.test_assert(test_586, t_590, fn__9213);
    return nil;
  end);
end;
Test_.test_groupByMultipleFields__1730 = function()
  temper.test('groupBy multiple fields', function(test_591)
    local t_592, t_593, q__1162, t_594, fn__9202;
    t_592 = sid__505('orders');
    t_593 = sid__505('status');
    q__1162 = from(t_592):groupBy(t_593):groupBy(sid__505('category'));
    t_594 = temper.str_eq(q__1162:toSql():toString(), 'SELECT * FROM orders GROUP BY status, category');
    fn__9202 = function()
      return 'groupBy multiple';
    end;
    temper.test_assert(test_591, t_594, fn__9202);
    return nil;
  end);
end;
Test_.test_havingBasic__1731 = function()
  temper.test('having basic', function(test_595)
    local t_596, t_597, t_598, t_599, t_600, q__1164, t_601, fn__9183;
    t_596 = sid__505('orders');
    t_597 = col(sid__505('orders'), sid__505('status'));
    t_598 = countAll();
    t_599 = from(t_596):selectExpr(temper.listof(t_597, t_598)):groupBy(sid__505('status'));
    t_600 = SqlBuilder();
    t_600:appendSafe('COUNT(*) > ');
    t_600:appendInt32(5);
    q__1164 = t_599:having(t_600.accumulated);
    t_601 = temper.str_eq(q__1164:toSql():toString(), 'SELECT orders.status, COUNT(*) FROM orders GROUP BY status HAVING COUNT(*) > 5');
    fn__9183 = function()
      return 'having basic';
    end;
    temper.test_assert(test_595, t_601, fn__9183);
    return nil;
  end);
end;
Test_.test_orHaving__1733 = function()
  temper.test('orHaving', function(test_602)
    local t_603, t_604, t_605, t_606, t_607, t_608, q__1166, t_609, fn__9164;
    t_603 = sid__505('orders');
    t_604 = sid__505('status');
    t_605 = from(t_603):groupBy(t_604);
    t_606 = SqlBuilder();
    t_606:appendSafe('COUNT(*) > ');
    t_606:appendInt32(5);
    t_607 = t_605:having(t_606.accumulated);
    t_608 = SqlBuilder();
    t_608:appendSafe('SUM(total) > ');
    t_608:appendInt32(1000);
    q__1166 = t_607:orHaving(t_608.accumulated);
    t_609 = temper.str_eq(q__1166:toSql():toString(), 'SELECT * FROM orders GROUP BY status HAVING COUNT(*) > 5 OR SUM(total) > 1000');
    fn__9164 = function()
      return 'orHaving';
    end;
    temper.test_assert(test_602, t_609, fn__9164);
    return nil;
  end);
end;
Test_.test_distinctBasic__1736 = function()
  temper.test('distinct basic', function(test_610)
    local t_611, t_612, q__1168, t_613, fn__9154;
    t_611 = sid__505('users');
    t_612 = sid__505('name');
    q__1168 = from(t_611):select(temper.listof(t_612)):distinct();
    t_613 = temper.str_eq(q__1168:toSql():toString(), 'SELECT DISTINCT name FROM users');
    fn__9154 = function()
      return 'distinct';
    end;
    temper.test_assert(test_610, t_613, fn__9154);
    return nil;
  end);
end;
Test_.test_distinctWithWhere__1737 = function()
  temper.test('distinct with where', function(test_614)
    local t_615, t_616, t_617, t_618, q__1170, t_619, fn__9139;
    t_615 = sid__505('users');
    t_616 = sid__505('email');
    t_617 = from(t_615):select(temper.listof(t_616));
    t_618 = SqlBuilder();
    t_618:appendSafe('active = ');
    t_618:appendBoolean(true);
    q__1170 = t_617:where(t_618.accumulated):distinct();
    t_619 = temper.str_eq(q__1170:toSql():toString(), 'SELECT DISTINCT email FROM users WHERE active = TRUE');
    fn__9139 = function()
      return 'distinct with where';
    end;
    temper.test_assert(test_614, t_619, fn__9139);
    return nil;
  end);
end;
Test_.test_countSqlBare__1739 = function()
  temper.test('countSql bare', function(test_620)
    local q__1172, t_621, fn__9132;
    q__1172 = from(sid__505('users'));
    t_621 = temper.str_eq(q__1172:countSql():toString(), 'SELECT COUNT(*) FROM users');
    fn__9132 = function()
      return 'countSql bare';
    end;
    temper.test_assert(test_620, t_621, fn__9132);
    return nil;
  end);
end;
Test_.test_countSqlWithWhere__1740 = function()
  temper.test('countSql with WHERE', function(test_622)
    local t_623, t_624, t_625, q__1174, t_626, fn__9120;
    t_623 = sid__505('users');
    t_624 = SqlBuilder();
    t_624:appendSafe('active = ');
    t_624:appendBoolean(true);
    t_625 = t_624.accumulated;
    q__1174 = from(t_623):where(t_625);
    t_626 = temper.str_eq(q__1174:countSql():toString(), 'SELECT COUNT(*) FROM users WHERE active = TRUE');
    fn__9120 = function()
      return 'countSql with where';
    end;
    temper.test_assert(test_622, t_626, fn__9120);
    return nil;
  end);
end;
Test_.test_countSqlWithJoin__1742 = function()
  temper.test('countSql with JOIN', function(test_627)
    local t_628, t_629, t_630, t_631, t_632, t_633, q__1176, t_634, fn__9103;
    t_628 = sid__505('users');
    t_629 = sid__505('orders');
    t_630 = SqlBuilder();
    t_630:appendSafe('users.id = orders.user_id');
    t_631 = t_630.accumulated;
    t_632 = from(t_628):innerJoin(t_629, t_631);
    t_633 = SqlBuilder();
    t_633:appendSafe('orders.total > ');
    t_633:appendInt32(100);
    q__1176 = t_632:where(t_633.accumulated);
    t_634 = temper.str_eq(q__1176:countSql():toString(), 'SELECT COUNT(*) FROM users INNER JOIN orders ON users.id = orders.user_id WHERE orders.total > 100');
    fn__9103 = function()
      return 'countSql with join';
    end;
    temper.test_assert(test_627, t_634, fn__9103);
    return nil;
  end);
end;
Test_.test_countSqlDropsOrderByLimitOffset__1745 = function()
  temper.test('countSql drops orderBy/limit/offset', function(test_635)
    local t_636, t_637, t_638, t_639, t_640, q__1178, local_641, local_642, local_643, s__1179, t_645, fn__9089;
    local_641, local_642, local_643 = temper.pcall(function()
      t_636 = sid__505('users');
      t_637 = SqlBuilder();
      t_637:appendSafe('active = ');
      t_637:appendBoolean(true);
      t_638 = t_637.accumulated;
      t_639 = from(t_636):where(t_638):orderBy(sid__505('name'), true):limit(10);
      t_640 = t_639:offset(20);
      q__1178 = t_640;
    end);
    if local_641 then
    else
      q__1178 = temper.bubble();
    end
    s__1179 = q__1178:countSql():toString();
    t_645 = temper.str_eq(s__1179, 'SELECT COUNT(*) FROM users WHERE active = TRUE');
    fn__9089 = function()
      return temper.concat('countSql drops extras: ', s__1179);
    end;
    temper.test_assert(test_635, t_645, fn__9089);
    return nil;
  end);
end;
Test_.test_fullAggregationQuery__1747 = function()
  temper.test('full aggregation query', function(test_646)
    local t_647, t_648, t_649, t_650, t_651, t_652, t_653, t_654, t_655, t_656, t_657, q__1181, expected__1182, t_658, fn__9056;
    t_647 = sid__505('orders');
    t_648 = col(sid__505('orders'), sid__505('status'));
    t_649 = countAll();
    t_650 = sumCol(sid__505('total'));
    t_651 = from(t_647):selectExpr(temper.listof(t_648, t_649, t_650));
    t_652 = sid__505('users');
    t_653 = SqlBuilder();
    t_653:appendSafe('orders.user_id = users.id');
    t_654 = t_651:innerJoin(t_652, t_653.accumulated);
    t_655 = SqlBuilder();
    t_655:appendSafe('users.active = ');
    t_655:appendBoolean(true);
    t_656 = t_654:where(t_655.accumulated):groupBy(sid__505('status'));
    t_657 = SqlBuilder();
    t_657:appendSafe('COUNT(*) > ');
    t_657:appendInt32(3);
    q__1181 = t_656:having(t_657.accumulated):orderBy(sid__505('status'), true);
    expected__1182 = 'SELECT orders.status, COUNT(*), SUM(total) FROM orders INNER JOIN users ON orders.user_id = users.id WHERE users.active = TRUE GROUP BY status HAVING COUNT(*) > 3 ORDER BY status ASC';
    t_658 = temper.str_eq(q__1181:toSql():toString(), 'SELECT orders.status, COUNT(*), SUM(total) FROM orders INNER JOIN users ON orders.user_id = users.id WHERE users.active = TRUE GROUP BY status HAVING COUNT(*) > 3 ORDER BY status ASC');
    fn__9056 = function()
      return 'full aggregation';
    end;
    temper.test_assert(test_646, t_658, fn__9056);
    return nil;
  end);
end;
Test_.test_unionSql__1751 = function()
  temper.test('unionSql', function(test_659)
    local t_660, t_661, t_662, a__1184, t_663, t_664, t_665, b__1185, s__1186, t_666, fn__9038;
    t_660 = sid__505('users');
    t_661 = SqlBuilder();
    t_661:appendSafe('role = ');
    t_661:appendString('admin');
    t_662 = t_661.accumulated;
    a__1184 = from(t_660):where(t_662);
    t_663 = sid__505('users');
    t_664 = SqlBuilder();
    t_664:appendSafe('role = ');
    t_664:appendString('moderator');
    t_665 = t_664.accumulated;
    b__1185 = from(t_663):where(t_665);
    s__1186 = unionSql(a__1184, b__1185):toString();
    t_666 = temper.str_eq(s__1186, "(SELECT * FROM users WHERE role = 'admin') UNION (SELECT * FROM users WHERE role = 'moderator')");
    fn__9038 = function()
      return temper.concat('unionSql: ', s__1186);
    end;
    temper.test_assert(test_659, t_666, fn__9038);
    return nil;
  end);
end;
Test_.test_unionAllSql__1754 = function()
  temper.test('unionAllSql', function(test_667)
    local t_668, t_669, a__1188, t_670, t_671, b__1189, s__1190, t_672, fn__9026;
    t_668 = sid__505('users');
    t_669 = sid__505('name');
    a__1188 = from(t_668):select(temper.listof(t_669));
    t_670 = sid__505('contacts');
    t_671 = sid__505('name');
    b__1189 = from(t_670):select(temper.listof(t_671));
    s__1190 = unionAllSql(a__1188, b__1189):toString();
    t_672 = temper.str_eq(s__1190, '(SELECT name FROM users) UNION ALL (SELECT name FROM contacts)');
    fn__9026 = function()
      return temper.concat('unionAllSql: ', s__1190);
    end;
    temper.test_assert(test_667, t_672, fn__9026);
    return nil;
  end);
end;
Test_.test_intersectSql__1755 = function()
  temper.test('intersectSql', function(test_673)
    local t_674, t_675, a__1192, t_676, t_677, b__1193, s__1194, t_678, fn__9014;
    t_674 = sid__505('users');
    t_675 = sid__505('email');
    a__1192 = from(t_674):select(temper.listof(t_675));
    t_676 = sid__505('subscribers');
    t_677 = sid__505('email');
    b__1193 = from(t_676):select(temper.listof(t_677));
    s__1194 = intersectSql(a__1192, b__1193):toString();
    t_678 = temper.str_eq(s__1194, '(SELECT email FROM users) INTERSECT (SELECT email FROM subscribers)');
    fn__9014 = function()
      return temper.concat('intersectSql: ', s__1194);
    end;
    temper.test_assert(test_673, t_678, fn__9014);
    return nil;
  end);
end;
Test_.test_exceptSql__1756 = function()
  temper.test('exceptSql', function(test_679)
    local t_680, t_681, a__1196, t_682, t_683, b__1197, s__1198, t_684, fn__9002;
    t_680 = sid__505('users');
    t_681 = sid__505('id');
    a__1196 = from(t_680):select(temper.listof(t_681));
    t_682 = sid__505('banned');
    t_683 = sid__505('id');
    b__1197 = from(t_682):select(temper.listof(t_683));
    s__1198 = exceptSql(a__1196, b__1197):toString();
    t_684 = temper.str_eq(s__1198, '(SELECT id FROM users) EXCEPT (SELECT id FROM banned)');
    fn__9002 = function()
      return temper.concat('exceptSql: ', s__1198);
    end;
    temper.test_assert(test_679, t_684, fn__9002);
    return nil;
  end);
end;
Test_.test_subqueryWithAlias__1757 = function()
  temper.test('subquery with alias', function(test_685)
    local t_686, t_687, t_688, t_689, inner__1200, s__1201, t_690, fn__8987;
    t_686 = sid__505('orders');
    t_687 = sid__505('user_id');
    t_688 = from(t_686):select(temper.listof(t_687));
    t_689 = SqlBuilder();
    t_689:appendSafe('total > ');
    t_689:appendInt32(100);
    inner__1200 = t_688:where(t_689.accumulated);
    s__1201 = subquery(inner__1200, sid__505('big_orders')):toString();
    t_690 = temper.str_eq(s__1201, '(SELECT user_id FROM orders WHERE total > 100) AS big_orders');
    fn__8987 = function()
      return temper.concat('subquery: ', s__1201);
    end;
    temper.test_assert(test_685, t_690, fn__8987);
    return nil;
  end);
end;
Test_.test_existsSql__1759 = function()
  temper.test('existsSql', function(test_691)
    local t_692, t_693, t_694, inner__1203, s__1204, t_695, fn__8976;
    t_692 = sid__505('orders');
    t_693 = SqlBuilder();
    t_693:appendSafe('orders.user_id = users.id');
    t_694 = t_693.accumulated;
    inner__1203 = from(t_692):where(t_694);
    s__1204 = existsSql(inner__1203):toString();
    t_695 = temper.str_eq(s__1204, 'EXISTS (SELECT * FROM orders WHERE orders.user_id = users.id)');
    fn__8976 = function()
      return temper.concat('existsSql: ', s__1204);
    end;
    temper.test_assert(test_691, t_695, fn__8976);
    return nil;
  end);
end;
Test_.test_whereInSubquery__1761 = function()
  temper.test('whereInSubquery', function(test_696)
    local t_697, t_698, t_699, t_700, sub__1206, t_701, t_702, q__1207, s__1208, t_703, fn__8959;
    t_697 = sid__505('orders');
    t_698 = sid__505('user_id');
    t_699 = from(t_697):select(temper.listof(t_698));
    t_700 = SqlBuilder();
    t_700:appendSafe('total > ');
    t_700:appendInt32(1000);
    sub__1206 = t_699:where(t_700.accumulated);
    t_701 = sid__505('users');
    t_702 = sid__505('id');
    q__1207 = from(t_701):whereInSubquery(t_702, sub__1206);
    s__1208 = q__1207:toSql():toString();
    t_703 = temper.str_eq(s__1208, 'SELECT * FROM users WHERE id IN (SELECT user_id FROM orders WHERE total > 1000)');
    fn__8959 = function()
      return temper.concat('whereInSubquery: ', s__1208);
    end;
    temper.test_assert(test_696, t_703, fn__8959);
    return nil;
  end);
end;
Test_.test_setOperationWithWhereOnEachSide__1763 = function()
  temper.test('set operation with WHERE on each side', function(test_704)
    local t_705, t_706, t_707, t_708, t_709, a__1210, t_710, t_711, t_712, b__1211, s__1212, t_713, fn__8936;
    t_705 = sid__505('users');
    t_706 = SqlBuilder();
    t_706:appendSafe('age > ');
    t_706:appendInt32(18);
    t_707 = t_706.accumulated;
    t_708 = from(t_705):where(t_707);
    t_709 = SqlBuilder();
    t_709:appendSafe('active = ');
    t_709:appendBoolean(true);
    a__1210 = t_708:where(t_709.accumulated);
    t_710 = sid__505('users');
    t_711 = SqlBuilder();
    t_711:appendSafe('role = ');
    t_711:appendString('vip');
    t_712 = t_711.accumulated;
    b__1211 = from(t_710):where(t_712);
    s__1212 = unionSql(a__1210, b__1211):toString();
    t_713 = temper.str_eq(s__1212, "(SELECT * FROM users WHERE age > 18 AND active = TRUE) UNION (SELECT * FROM users WHERE role = 'vip')");
    fn__8936 = function()
      return temper.concat('union with where: ', s__1212);
    end;
    temper.test_assert(test_704, t_713, fn__8936);
    return nil;
  end);
end;
Test_.test_whereInSubqueryChainedWithWhere__1767 = function()
  temper.test('whereInSubquery chained with where', function(test_714)
    local t_715, t_716, sub__1214, t_717, t_718, t_719, q__1215, s__1216, t_720, fn__8919;
    t_715 = sid__505('orders');
    t_716 = sid__505('user_id');
    sub__1214 = from(t_715):select(temper.listof(t_716));
    t_717 = sid__505('users');
    t_718 = SqlBuilder();
    t_718:appendSafe('active = ');
    t_718:appendBoolean(true);
    t_719 = t_718.accumulated;
    q__1215 = from(t_717):where(t_719):whereInSubquery(sid__505('id'), sub__1214);
    s__1216 = q__1215:toSql():toString();
    t_720 = temper.str_eq(s__1216, 'SELECT * FROM users WHERE active = TRUE AND id IN (SELECT user_id FROM orders)');
    fn__8919 = function()
      return temper.concat('whereInSubquery chained: ', s__1216);
    end;
    temper.test_assert(test_714, t_720, fn__8919);
    return nil;
  end);
end;
Test_.test_existsSqlUsedInWhere__1769 = function()
  temper.test('existsSql used in where', function(test_721)
    local t_722, t_723, t_724, sub__1218, t_725, t_726, q__1219, s__1220, t_727, fn__8905;
    t_722 = sid__505('orders');
    t_723 = SqlBuilder();
    t_723:appendSafe('orders.user_id = users.id');
    t_724 = t_723.accumulated;
    sub__1218 = from(t_722):where(t_724);
    t_725 = sid__505('users');
    t_726 = existsSql(sub__1218);
    q__1219 = from(t_725):where(t_726);
    s__1220 = q__1219:toSql():toString();
    t_727 = temper.str_eq(s__1220, 'SELECT * FROM users WHERE EXISTS (SELECT * FROM orders WHERE orders.user_id = users.id)');
    fn__8905 = function()
      return temper.concat('exists in where: ', s__1220);
    end;
    temper.test_assert(test_721, t_727, fn__8905);
    return nil;
  end);
end;
Test_.test_updateQueryBasic__1771 = function()
  temper.test('UpdateQuery basic', function(test_728)
    local t_729, t_730, t_731, t_732, t_733, t_734, q__1222, local_735, local_736, local_737, t_739, fn__8891;
    local_735, local_736, local_737 = temper.pcall(function()
      t_729 = sid__505('users');
      t_730 = sid__505('name');
      t_731 = SqlString('Alice');
      t_732 = update(t_729):set(t_730, t_731);
      t_733 = SqlBuilder();
      t_733:appendSafe('id = ');
      t_733:appendInt32(1);
      t_734 = t_732:where(t_733.accumulated):toSql();
      q__1222 = t_734;
    end);
    if local_735 then
    else
      q__1222 = temper.bubble();
    end
    t_739 = temper.str_eq(q__1222:toString(), "UPDATE users SET name = 'Alice' WHERE id = 1");
    fn__8891 = function()
      return 'update basic';
    end;
    temper.test_assert(test_728, t_739, fn__8891);
    return nil;
  end);
end;
Test_.test_updateQueryMultipleSet__1773 = function()
  temper.test('UpdateQuery multiple SET', function(test_740)
    local t_741, t_742, t_743, t_744, t_745, t_746, q__1224, local_747, local_748, local_749, t_751, fn__8874;
    local_747, local_748, local_749 = temper.pcall(function()
      t_741 = sid__505('users');
      t_742 = sid__505('name');
      t_743 = SqlString('Bob');
      t_744 = update(t_741):set(t_742, t_743):set(sid__505('age'), SqlInt32(30));
      t_745 = SqlBuilder();
      t_745:appendSafe('id = ');
      t_745:appendInt32(2);
      t_746 = t_744:where(t_745.accumulated):toSql();
      q__1224 = t_746;
    end);
    if local_747 then
    else
      q__1224 = temper.bubble();
    end
    t_751 = temper.str_eq(q__1224:toString(), "UPDATE users SET name = 'Bob', age = 30 WHERE id = 2");
    fn__8874 = function()
      return 'update multi set';
    end;
    temper.test_assert(test_740, t_751, fn__8874);
    return nil;
  end);
end;
Test_.test_updateQueryMultipleWhere__1775 = function()
  temper.test('UpdateQuery multiple WHERE', function(test_752)
    local t_753, t_754, t_755, t_756, t_757, t_758, t_759, t_760, q__1226, local_761, local_762, local_763, t_765, fn__8855;
    local_761, local_762, local_763 = temper.pcall(function()
      t_753 = sid__505('users');
      t_754 = sid__505('active');
      t_755 = SqlBoolean(false);
      t_756 = update(t_753):set(t_754, t_755);
      t_757 = SqlBuilder();
      t_757:appendSafe('age < ');
      t_757:appendInt32(18);
      t_758 = t_756:where(t_757.accumulated);
      t_759 = SqlBuilder();
      t_759:appendSafe('role = ');
      t_759:appendString('guest');
      t_760 = t_758:where(t_759.accumulated):toSql();
      q__1226 = t_760;
    end);
    if local_761 then
    else
      q__1226 = temper.bubble();
    end
    t_765 = temper.str_eq(q__1226:toString(), "UPDATE users SET active = FALSE WHERE age < 18 AND role = 'guest'");
    fn__8855 = function()
      return 'update multi where';
    end;
    temper.test_assert(test_752, t_765, fn__8855);
    return nil;
  end);
end;
Test_.test_updateQueryOrWhere__1778 = function()
  temper.test('UpdateQuery orWhere', function(test_766)
    local t_767, t_768, t_769, t_770, t_771, t_772, t_773, t_774, q__1228, local_775, local_776, local_777, t_779, fn__8836;
    local_775, local_776, local_777 = temper.pcall(function()
      t_767 = sid__505('users');
      t_768 = sid__505('status');
      t_769 = SqlString('banned');
      t_770 = update(t_767):set(t_768, t_769);
      t_771 = SqlBuilder();
      t_771:appendSafe('spam_count > ');
      t_771:appendInt32(10);
      t_772 = t_770:where(t_771.accumulated);
      t_773 = SqlBuilder();
      t_773:appendSafe('reported = ');
      t_773:appendBoolean(true);
      t_774 = t_772:orWhere(t_773.accumulated):toSql();
      q__1228 = t_774;
    end);
    if local_775 then
    else
      q__1228 = temper.bubble();
    end
    t_779 = temper.str_eq(q__1228:toString(), "UPDATE users SET status = 'banned' WHERE spam_count > 10 OR reported = TRUE");
    fn__8836 = function()
      return 'update orWhere';
    end;
    temper.test_assert(test_766, t_779, fn__8836);
    return nil;
  end);
end;
Test_.test_updateQueryBubblesWithoutWhere__1781 = function()
  temper.test('UpdateQuery bubbles without WHERE', function(test_780)
    local t_781, t_782, t_783, didBubble__1230, local_784, local_785, local_786, fn__8829;
    local_784, local_785, local_786 = temper.pcall(function()
      t_781 = sid__505('users');
      t_782 = sid__505('x');
      t_783 = SqlInt32(1);
      update(t_781):set(t_782, t_783):toSql();
      didBubble__1230 = false;
    end);
    if local_784 then
    else
      didBubble__1230 = true;
    end
    fn__8829 = function()
      return 'update without WHERE should bubble';
    end;
    temper.test_assert(test_780, didBubble__1230, fn__8829);
    return nil;
  end);
end;
Test_.test_updateQueryBubblesWithoutSet__1782 = function()
  temper.test('UpdateQuery bubbles without SET', function(test_788)
    local t_789, t_790, t_791, didBubble__1232, local_792, local_793, local_794, fn__8820;
    local_792, local_793, local_794 = temper.pcall(function()
      t_789 = sid__505('users');
      t_790 = SqlBuilder();
      t_790:appendSafe('id = ');
      t_790:appendInt32(1);
      t_791 = t_790.accumulated;
      update(t_789):where(t_791):toSql();
      didBubble__1232 = false;
    end);
    if local_792 then
    else
      didBubble__1232 = true;
    end
    fn__8820 = function()
      return 'update without SET should bubble';
    end;
    temper.test_assert(test_788, didBubble__1232, fn__8820);
    return nil;
  end);
end;
Test_.test_updateQueryWithLimit__1784 = function()
  temper.test('UpdateQuery with limit', function(test_796)
    local t_797, t_798, t_799, t_800, t_801, t_802, t_803, q__1234, local_804, local_805, local_806, t_808, fn__8806;
    local_804, local_805, local_806 = temper.pcall(function()
      t_797 = sid__505('users');
      t_798 = sid__505('active');
      t_799 = SqlBoolean(false);
      t_800 = update(t_797):set(t_798, t_799);
      t_801 = SqlBuilder();
      t_801:appendSafe('last_login < ');
      t_801:appendString('2024-01-01');
      t_802 = t_800:where(t_801.accumulated):limit(100);
      t_803 = t_802:toSql();
      q__1234 = t_803;
    end);
    if local_804 then
    else
      q__1234 = temper.bubble();
    end
    t_808 = temper.str_eq(q__1234:toString(), "UPDATE users SET active = FALSE WHERE last_login < '2024-01-01' LIMIT 100");
    fn__8806 = function()
      return 'update limit';
    end;
    temper.test_assert(test_796, t_808, fn__8806);
    return nil;
  end);
end;
Test_.test_updateQueryEscaping__1786 = function()
  temper.test('UpdateQuery escaping', function(test_809)
    local t_810, t_811, t_812, t_813, t_814, t_815, q__1236, local_816, local_817, local_818, t_820, fn__8792;
    local_816, local_817, local_818 = temper.pcall(function()
      t_810 = sid__505('users');
      t_811 = sid__505('bio');
      t_812 = SqlString("It's a test");
      t_813 = update(t_810):set(t_811, t_812);
      t_814 = SqlBuilder();
      t_814:appendSafe('id = ');
      t_814:appendInt32(1);
      t_815 = t_813:where(t_814.accumulated):toSql();
      q__1236 = t_815;
    end);
    if local_816 then
    else
      q__1236 = temper.bubble();
    end
    t_820 = temper.str_eq(q__1236:toString(), "UPDATE users SET bio = 'It''s a test' WHERE id = 1");
    fn__8792 = function()
      return 'update escaping';
    end;
    temper.test_assert(test_809, t_820, fn__8792);
    return nil;
  end);
end;
Test_.test_deleteQueryBasic__1788 = function()
  temper.test('DeleteQuery basic', function(test_821)
    local t_822, t_823, t_824, t_825, q__1238, local_826, local_827, local_828, t_830, fn__8781;
    local_826, local_827, local_828 = temper.pcall(function()
      t_822 = sid__505('users');
      t_823 = SqlBuilder();
      t_823:appendSafe('id = ');
      t_823:appendInt32(1);
      t_824 = t_823.accumulated;
      t_825 = deleteFrom(t_822):where(t_824):toSql();
      q__1238 = t_825;
    end);
    if local_826 then
    else
      q__1238 = temper.bubble();
    end
    t_830 = temper.str_eq(q__1238:toString(), 'DELETE FROM users WHERE id = 1');
    fn__8781 = function()
      return 'delete basic';
    end;
    temper.test_assert(test_821, t_830, fn__8781);
    return nil;
  end);
end;
Test_.test_deleteQueryMultipleWhere__1790 = function()
  temper.test('DeleteQuery multiple WHERE', function(test_831)
    local t_832, t_833, t_834, t_835, t_836, t_837, q__1240, local_838, local_839, local_840, t_842, fn__8765;
    local_838, local_839, local_840 = temper.pcall(function()
      t_832 = sid__505('logs');
      t_833 = SqlBuilder();
      t_833:appendSafe('created_at < ');
      t_833:appendString('2024-01-01');
      t_834 = t_833.accumulated;
      t_835 = deleteFrom(t_832):where(t_834);
      t_836 = SqlBuilder();
      t_836:appendSafe('level = ');
      t_836:appendString('debug');
      t_837 = t_835:where(t_836.accumulated):toSql();
      q__1240 = t_837;
    end);
    if local_838 then
    else
      q__1240 = temper.bubble();
    end
    t_842 = temper.str_eq(q__1240:toString(), "DELETE FROM logs WHERE created_at < '2024-01-01' AND level = 'debug'");
    fn__8765 = function()
      return 'delete multi where';
    end;
    temper.test_assert(test_831, t_842, fn__8765);
    return nil;
  end);
end;
Test_.test_deleteQueryBubblesWithoutWhere__1793 = function()
  temper.test('DeleteQuery bubbles without WHERE', function(test_843)
    local didBubble__1242, local_844, local_845, local_846, fn__8761;
    local_844, local_845, local_846 = temper.pcall(function()
      deleteFrom(sid__505('users')):toSql();
      didBubble__1242 = false;
    end);
    if local_844 then
    else
      didBubble__1242 = true;
    end
    fn__8761 = function()
      return 'delete without WHERE should bubble';
    end;
    temper.test_assert(test_843, didBubble__1242, fn__8761);
    return nil;
  end);
end;
Test_.test_deleteQueryOrWhere__1794 = function()
  temper.test('DeleteQuery orWhere', function(test_848)
    local t_849, t_850, t_851, t_852, t_853, t_854, q__1244, local_855, local_856, local_857, t_859, fn__8745;
    local_855, local_856, local_857 = temper.pcall(function()
      t_849 = sid__505('sessions');
      t_850 = SqlBuilder();
      t_850:appendSafe('expired = ');
      t_850:appendBoolean(true);
      t_851 = t_850.accumulated;
      t_852 = deleteFrom(t_849):where(t_851);
      t_853 = SqlBuilder();
      t_853:appendSafe('created_at < ');
      t_853:appendString('2023-01-01');
      t_854 = t_852:orWhere(t_853.accumulated):toSql();
      q__1244 = t_854;
    end);
    if local_855 then
    else
      q__1244 = temper.bubble();
    end
    t_859 = temper.str_eq(q__1244:toString(), "DELETE FROM sessions WHERE expired = TRUE OR created_at < '2023-01-01'");
    fn__8745 = function()
      return 'delete orWhere';
    end;
    temper.test_assert(test_848, t_859, fn__8745);
    return nil;
  end);
end;
Test_.test_deleteQueryWithLimit__1797 = function()
  temper.test('DeleteQuery with limit', function(test_860)
    local t_861, t_862, t_863, t_864, t_865, q__1246, local_866, local_867, local_868, t_870, fn__8734;
    local_866, local_867, local_868 = temper.pcall(function()
      t_861 = sid__505('logs');
      t_862 = SqlBuilder();
      t_862:appendSafe('level = ');
      t_862:appendString('debug');
      t_863 = t_862.accumulated;
      t_864 = deleteFrom(t_861):where(t_863):limit(1000);
      t_865 = t_864:toSql();
      q__1246 = t_865;
    end);
    if local_866 then
    else
      q__1246 = temper.bubble();
    end
    t_870 = temper.str_eq(q__1246:toString(), "DELETE FROM logs WHERE level = 'debug' LIMIT 1000");
    fn__8734 = function()
      return 'delete limit';
    end;
    temper.test_assert(test_860, t_870, fn__8734);
    return nil;
  end);
end;
Test_.test_safeIdentifierAcceptsValidNames__1799 = function()
  temper.test('safeIdentifier accepts valid names', function(test_871)
    local t_872, id__1284, local_873, local_874, local_875, t_877, fn__8729;
    local_873, local_874, local_875 = temper.pcall(function()
      t_872 = safeIdentifier('user_name');
      id__1284 = t_872;
    end);
    if local_873 then
    else
      id__1284 = temper.bubble();
    end
    t_877 = temper.str_eq(id__1284.sqlValue, 'user_name');
    fn__8729 = function()
      return 'value should round-trip';
    end;
    temper.test_assert(test_871, t_877, fn__8729);
    return nil;
  end);
end;
Test_.test_safeIdentifierRejectsEmptyString__1800 = function()
  temper.test('safeIdentifier rejects empty string', function(test_878)
    local didBubble__1286, local_879, local_880, local_881, fn__8726;
    local_879, local_880, local_881 = temper.pcall(function()
      safeIdentifier('');
      didBubble__1286 = false;
    end);
    if local_879 then
    else
      didBubble__1286 = true;
    end
    fn__8726 = function()
      return 'empty string should bubble';
    end;
    temper.test_assert(test_878, didBubble__1286, fn__8726);
    return nil;
  end);
end;
Test_.test_safeIdentifierRejectsLeadingDigit__1801 = function()
  temper.test('safeIdentifier rejects leading digit', function(test_883)
    local didBubble__1288, local_884, local_885, local_886, fn__8723;
    local_884, local_885, local_886 = temper.pcall(function()
      safeIdentifier('1col');
      didBubble__1288 = false;
    end);
    if local_884 then
    else
      didBubble__1288 = true;
    end
    fn__8723 = function()
      return 'leading digit should bubble';
    end;
    temper.test_assert(test_883, didBubble__1288, fn__8723);
    return nil;
  end);
end;
Test_.test_safeIdentifierRejectsSqlMetacharacters__1802 = function()
  temper.test('safeIdentifier rejects SQL metacharacters', function(test_888)
    local cases__1290, fn__8720;
    cases__1290 = temper.listof('name); DROP TABLE', "col'", 'a b', 'a-b', 'a.b', 'a;b');
    fn__8720 = function(c__1291)
      local didBubble__1292, local_889, local_890, local_891, fn__8717;
      local_889, local_890, local_891 = temper.pcall(function()
        safeIdentifier(c__1291);
        didBubble__1292 = false;
      end);
      if local_889 then
      else
        didBubble__1292 = true;
      end
      fn__8717 = function()
        return temper.concat('should reject: ', c__1291);
      end;
      temper.test_assert(test_888, didBubble__1292, fn__8717);
      return nil;
    end;
    temper.list_foreach(cases__1290, fn__8720);
    return nil;
  end);
end;
Test_.test_tableDefFieldLookupFound__1803 = function()
  temper.test('TableDef field lookup - found', function(test_893)
    local t_894, t_895, t_896, t_897, t_898, t_899, t_900, local_901, local_902, local_903, local_905, local_906, local_907, t_909, t_910, local_911, local_912, local_913, t_915, t_916, td__1294, f__1295, local_917, local_918, local_919, t_921, fn__8706;
    local_901, local_902, local_903 = temper.pcall(function()
      t_894 = safeIdentifier('users');
      t_895 = t_894;
    end);
    if local_901 then
    else
      t_895 = temper.bubble();
    end
    local_905, local_906, local_907 = temper.pcall(function()
      t_896 = safeIdentifier('name');
      t_897 = t_896;
    end);
    if local_905 then
    else
      t_897 = temper.bubble();
    end
    t_909 = StringField();
    t_910 = FieldDef(t_897, t_909, false);
    local_911, local_912, local_913 = temper.pcall(function()
      t_898 = safeIdentifier('age');
      t_899 = t_898;
    end);
    if local_911 then
    else
      t_899 = temper.bubble();
    end
    t_915 = IntField();
    t_916 = FieldDef(t_899, t_915, false);
    td__1294 = TableDef(t_895, temper.listof(t_910, t_916));
    local_917, local_918, local_919 = temper.pcall(function()
      t_900 = td__1294:field('age');
      f__1295 = t_900;
    end);
    if local_917 then
    else
      f__1295 = temper.bubble();
    end
    t_921 = temper.str_eq(f__1295.name.sqlValue, 'age');
    fn__8706 = function()
      return 'should find age field';
    end;
    temper.test_assert(test_893, t_921, fn__8706);
    return nil;
  end);
end;
Test_.test_tableDefFieldLookupNotFoundBubbles__1804 = function()
  temper.test('TableDef field lookup - not found bubbles', function(test_922)
    local t_923, t_924, t_925, t_926, local_927, local_928, local_929, local_931, local_932, local_933, t_935, t_936, td__1297, didBubble__1298, local_937, local_938, local_939, fn__8700;
    local_927, local_928, local_929 = temper.pcall(function()
      t_923 = safeIdentifier('users');
      t_924 = t_923;
    end);
    if local_927 then
    else
      t_924 = temper.bubble();
    end
    local_931, local_932, local_933 = temper.pcall(function()
      t_925 = safeIdentifier('name');
      t_926 = t_925;
    end);
    if local_931 then
    else
      t_926 = temper.bubble();
    end
    t_935 = StringField();
    t_936 = FieldDef(t_926, t_935, false);
    td__1297 = TableDef(t_924, temper.listof(t_936));
    local_937, local_938, local_939 = temper.pcall(function()
      td__1297:field('nonexistent');
      didBubble__1298 = false;
    end);
    if local_937 then
    else
      didBubble__1298 = true;
    end
    fn__8700 = function()
      return 'unknown field should bubble';
    end;
    temper.test_assert(test_922, didBubble__1298, fn__8700);
    return nil;
  end);
end;
Test_.test_fieldDefNullableFlag__1805 = function()
  temper.test('FieldDef nullable flag', function(test_941)
    local t_942, t_943, t_944, t_945, local_946, local_947, local_948, t_950, required__1300, local_951, local_952, local_953, t_955, optional__1301, t_956, fn__8688, t_957, fn__8687;
    local_946, local_947, local_948 = temper.pcall(function()
      t_942 = safeIdentifier('email');
      t_943 = t_942;
    end);
    if local_946 then
    else
      t_943 = temper.bubble();
    end
    t_950 = StringField();
    required__1300 = FieldDef(t_943, t_950, false);
    local_951, local_952, local_953 = temper.pcall(function()
      t_944 = safeIdentifier('bio');
      t_945 = t_944;
    end);
    if local_951 then
    else
      t_945 = temper.bubble();
    end
    t_955 = StringField();
    optional__1301 = FieldDef(t_945, t_955, true);
    t_956 = not required__1300.nullable;
    fn__8688 = function()
      return 'required field should not be nullable';
    end;
    temper.test_assert(test_941, t_956, fn__8688);
    t_957 = optional__1301.nullable;
    fn__8687 = function()
      return 'optional field should be nullable';
    end;
    temper.test_assert(test_941, t_957, fn__8687);
    return nil;
  end);
end;
Test_.test_stringEscaping__1806 = function()
  temper.test('string escaping', function(test_958)
    local build__1427, buildWrong__1428, actual_960, t_961, fn__8676, bobbyTables__1433, actual_962, t_963, fn__8675, fn__8674;
    build__1427 = function(name__1429)
      local t_959;
      t_959 = SqlBuilder();
      t_959:appendSafe('select * from hi where name = ');
      t_959:appendString(name__1429);
      return t_959.accumulated:toString();
    end;
    buildWrong__1428 = function(name__1431)
      return temper.concat("select * from hi where name = '", name__1431, "'");
    end;
    actual_960 = build__1427('world');
    t_961 = temper.str_eq(actual_960, "select * from hi where name = 'world'");
    fn__8676 = function()
      return temper.concat('expected build("world") == (', "select * from hi where name = 'world'", ') not (', actual_960, ')');
    end;
    temper.test_assert(test_958, t_961, fn__8676);
    bobbyTables__1433 = "Robert'); drop table hi;--";
    actual_962 = build__1427("Robert'); drop table hi;--");
    t_963 = temper.str_eq(actual_962, "select * from hi where name = 'Robert''); drop table hi;--'");
    fn__8675 = function()
      return temper.concat('expected build(bobbyTables) == (', "select * from hi where name = 'Robert''); drop table hi;--'", ') not (', actual_962, ')');
    end;
    temper.test_assert(test_958, t_963, fn__8675);
    fn__8674 = function()
      return "expected buildWrong(bobbyTables) == (select * from hi where name = 'Robert'); drop table hi;--') not (select * from hi where name = 'Robert'); drop table hi;--')";
    end;
    temper.test_assert(test_958, true, fn__8674);
    return nil;
  end);
end;
Test_.test_stringEdgeCases__1814 = function()
  temper.test('string edge cases', function(test_964)
    local t_965, actual_966, t_967, fn__8636, t_968, actual_969, t_970, fn__8635, t_971, actual_972, t_973, fn__8634, t_974, actual_975, t_976, fn__8633;
    t_965 = SqlBuilder();
    t_965:appendSafe('v = ');
    t_965:appendString('');
    actual_966 = t_965.accumulated:toString();
    t_967 = temper.str_eq(actual_966, "v = ''");
    fn__8636 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, "").toString() == (', "v = ''", ') not (', actual_966, ')');
    end;
    temper.test_assert(test_964, t_967, fn__8636);
    t_968 = SqlBuilder();
    t_968:appendSafe('v = ');
    t_968:appendString("a''b");
    actual_969 = t_968.accumulated:toString();
    t_970 = temper.str_eq(actual_969, "v = 'a''''b'");
    fn__8635 = function()
      return temper.concat("expected stringExpr(`-work//src/`.sql, true, \"v = \", \\interpolate, \"a''b\").toString() == (", "v = 'a''''b'", ') not (', actual_969, ')');
    end;
    temper.test_assert(test_964, t_970, fn__8635);
    t_971 = SqlBuilder();
    t_971:appendSafe('v = ');
    t_971:appendString('Hello \xe4\xb8\x96\xe7\x95\x8c');
    actual_972 = t_971.accumulated:toString();
    t_973 = temper.str_eq(actual_972, "v = 'Hello \xe4\xb8\x96\xe7\x95\x8c'");
    fn__8634 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, "Hello \xe4\xb8\x96\xe7\x95\x8c").toString() == (', "v = 'Hello \xe4\xb8\x96\xe7\x95\x8c'", ') not (', actual_972, ')');
    end;
    temper.test_assert(test_964, t_973, fn__8634);
    t_974 = SqlBuilder();
    t_974:appendSafe('v = ');
    t_974:appendString('Line1\nLine2');
    actual_975 = t_974.accumulated:toString();
    t_976 = temper.str_eq(actual_975, "v = 'Line1\nLine2'");
    fn__8633 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, "Line1\\nLine2").toString() == (', "v = 'Line1\nLine2'", ') not (', actual_975, ')');
    end;
    temper.test_assert(test_964, t_976, fn__8633);
    return nil;
  end);
end;
Test_.test_numbersAndBooleans__1827 = function()
  temper.test('numbers and booleans', function(test_977)
    local t_978, t_979, actual_980, t_981, fn__8607, date__1436, local_982, local_983, local_984, t_986, actual_987, t_988, fn__8606;
    t_979 = SqlBuilder();
    t_979:appendSafe('select ');
    t_979:appendInt32(42);
    t_979:appendSafe(', ');
    t_979:appendInt64(temper.int64_constructor(43));
    t_979:appendSafe(', ');
    t_979:appendFloat64(19.99);
    t_979:appendSafe(', ');
    t_979:appendBoolean(true);
    t_979:appendSafe(', ');
    t_979:appendBoolean(false);
    actual_980 = t_979.accumulated:toString();
    t_981 = temper.str_eq(actual_980, 'select 42, 43, 19.99, TRUE, FALSE');
    fn__8607 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "select ", \\interpolate, 42, ", ", \\interpolate, 43, ", ", \\interpolate, 19.99, ", ", \\interpolate, true, ", ", \\interpolate, false).toString() == (', 'select 42, 43, 19.99, TRUE, FALSE', ') not (', actual_980, ')');
    end;
    temper.test_assert(test_977, t_981, fn__8607);
    local_982, local_983, local_984 = temper.pcall(function()
      t_978 = temper.date_constructor(2024, 12, 25);
      date__1436 = t_978;
    end);
    if local_982 then
    else
      date__1436 = temper.bubble();
    end
    t_986 = SqlBuilder();
    t_986:appendSafe('insert into t values (');
    t_986:appendDate(date__1436);
    t_986:appendSafe(')');
    actual_987 = t_986.accumulated:toString();
    t_988 = temper.str_eq(actual_987, "insert into t values ('2024-12-25')");
    fn__8606 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "insert into t values (", \\interpolate, date, ")").toString() == (', "insert into t values ('2024-12-25')", ') not (', actual_987, ')');
    end;
    temper.test_assert(test_977, t_988, fn__8606);
    return nil;
  end);
end;
Test_.test_lists__1834 = function()
  temper.test('lists', function(test_989)
    local t_990, t_991, t_992, t_993, t_994, actual_995, t_996, fn__8551, t_997, actual_998, t_999, fn__8550, t_1000, actual_1001, t_1002, fn__8549, t_1003, actual_1004, t_1005, fn__8548, t_1006, actual_1007, t_1008, fn__8547, local_1009, local_1010, local_1011, local_1013, local_1014, local_1015, dates__1438, t_1017, actual_1018, t_1019, fn__8546;
    t_994 = SqlBuilder();
    t_994:appendSafe('v IN (');
    t_994:appendStringList(temper.listof('a', 'b', "c'd"));
    t_994:appendSafe(')');
    actual_995 = t_994.accumulated:toString();
    t_996 = temper.str_eq(actual_995, "v IN ('a', 'b', 'c''d')");
    fn__8551 = function()
      return temper.concat("expected stringExpr(`-work//src/`.sql, true, \"v IN (\", \\interpolate, list(\"a\", \"b\", \"c'd\"), \")\").toString() == (", "v IN ('a', 'b', 'c''d')", ') not (', actual_995, ')');
    end;
    temper.test_assert(test_989, t_996, fn__8551);
    t_997 = SqlBuilder();
    t_997:appendSafe('v IN (');
    t_997:appendInt32List(temper.listof(1, 2, 3));
    t_997:appendSafe(')');
    actual_998 = t_997.accumulated:toString();
    t_999 = temper.str_eq(actual_998, 'v IN (1, 2, 3)');
    fn__8550 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v IN (", \\interpolate, list(1, 2, 3), ")").toString() == (', 'v IN (1, 2, 3)', ') not (', actual_998, ')');
    end;
    temper.test_assert(test_989, t_999, fn__8550);
    t_1000 = SqlBuilder();
    t_1000:appendSafe('v IN (');
    t_1000:appendInt64List(temper.listof(temper.int64_constructor(1), temper.int64_constructor(2)));
    t_1000:appendSafe(')');
    actual_1001 = t_1000.accumulated:toString();
    t_1002 = temper.str_eq(actual_1001, 'v IN (1, 2)');
    fn__8549 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v IN (", \\interpolate, list(1, 2), ")").toString() == (', 'v IN (1, 2)', ') not (', actual_1001, ')');
    end;
    temper.test_assert(test_989, t_1002, fn__8549);
    t_1003 = SqlBuilder();
    t_1003:appendSafe('v IN (');
    t_1003:appendFloat64List(temper.listof(1.0, 2.0));
    t_1003:appendSafe(')');
    actual_1004 = t_1003.accumulated:toString();
    t_1005 = temper.str_eq(actual_1004, 'v IN (1.0, 2.0)');
    fn__8548 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v IN (", \\interpolate, list(1.0, 2.0), ")").toString() == (', 'v IN (1.0, 2.0)', ') not (', actual_1004, ')');
    end;
    temper.test_assert(test_989, t_1005, fn__8548);
    t_1006 = SqlBuilder();
    t_1006:appendSafe('v IN (');
    t_1006:appendBooleanList(temper.listof(true, false));
    t_1006:appendSafe(')');
    actual_1007 = t_1006.accumulated:toString();
    t_1008 = temper.str_eq(actual_1007, 'v IN (TRUE, FALSE)');
    fn__8547 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v IN (", \\interpolate, list(true, false), ")").toString() == (', 'v IN (TRUE, FALSE)', ') not (', actual_1007, ')');
    end;
    temper.test_assert(test_989, t_1008, fn__8547);
    local_1009, local_1010, local_1011 = temper.pcall(function()
      t_990 = temper.date_constructor(2024, 1, 1);
      t_991 = t_990;
    end);
    if local_1009 then
    else
      t_991 = temper.bubble();
    end
    local_1013, local_1014, local_1015 = temper.pcall(function()
      t_992 = temper.date_constructor(2024, 12, 25);
      t_993 = t_992;
    end);
    if local_1013 then
    else
      t_993 = temper.bubble();
    end
    dates__1438 = temper.listof(t_991, t_993);
    t_1017 = SqlBuilder();
    t_1017:appendSafe('v IN (');
    t_1017:appendDateList(dates__1438);
    t_1017:appendSafe(')');
    actual_1018 = t_1017.accumulated:toString();
    t_1019 = temper.str_eq(actual_1018, "v IN ('2024-01-01', '2024-12-25')");
    fn__8546 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v IN (", \\interpolate, dates, ")").toString() == (', "v IN ('2024-01-01', '2024-12-25')", ') not (', actual_1018, ')');
    end;
    temper.test_assert(test_989, t_1019, fn__8546);
    return nil;
  end);
end;
Test_.test_sqlFloat64_naNRendersAsNull__1853 = function()
  temper.test('SqlFloat64 NaN renders as NULL', function(test_1020)
    local nan__1440, t_1021, actual_1022, t_1023, fn__8537;
    nan__1440 = temper.fdiv(0.0, 0.0);
    t_1021 = SqlBuilder();
    t_1021:appendSafe('v = ');
    t_1021:appendFloat64(nan__1440);
    actual_1022 = t_1021.accumulated:toString();
    t_1023 = temper.str_eq(actual_1022, 'v = NULL');
    fn__8537 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, nan).toString() == (', 'v = NULL', ') not (', actual_1022, ')');
    end;
    temper.test_assert(test_1020, t_1023, fn__8537);
    return nil;
  end);
end;
Test_.test_sqlFloat64_infinityRendersAsNull__1857 = function()
  temper.test('SqlFloat64 Infinity renders as NULL', function(test_1024)
    local inf__1442, t_1025, actual_1026, t_1027, fn__8528;
    inf__1442 = temper.fdiv(1.0, 0.0);
    t_1025 = SqlBuilder();
    t_1025:appendSafe('v = ');
    t_1025:appendFloat64(inf__1442);
    actual_1026 = t_1025.accumulated:toString();
    t_1027 = temper.str_eq(actual_1026, 'v = NULL');
    fn__8528 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, inf).toString() == (', 'v = NULL', ') not (', actual_1026, ')');
    end;
    temper.test_assert(test_1024, t_1027, fn__8528);
    return nil;
  end);
end;
Test_.test_sqlFloat64_negativeInfinityRendersAsNull__1861 = function()
  temper.test('SqlFloat64 negative Infinity renders as NULL', function(test_1028)
    local ninf__1444, t_1029, actual_1030, t_1031, fn__8519;
    ninf__1444 = temper.fdiv(-1.0, 0.0);
    t_1029 = SqlBuilder();
    t_1029:appendSafe('v = ');
    t_1029:appendFloat64(ninf__1444);
    actual_1030 = t_1029.accumulated:toString();
    t_1031 = temper.str_eq(actual_1030, 'v = NULL');
    fn__8519 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, ninf).toString() == (', 'v = NULL', ') not (', actual_1030, ')');
    end;
    temper.test_assert(test_1028, t_1031, fn__8519);
    return nil;
  end);
end;
Test_.test_sqlFloat64_normalValuesStillWork__1865 = function()
  temper.test('SqlFloat64 normal values still work', function(test_1032)
    local t_1033, actual_1034, t_1035, fn__8494, t_1036, actual_1037, t_1038, fn__8493, t_1039, actual_1040, t_1041, fn__8492;
    t_1033 = SqlBuilder();
    t_1033:appendSafe('v = ');
    t_1033:appendFloat64(3.14);
    actual_1034 = t_1033.accumulated:toString();
    t_1035 = temper.str_eq(actual_1034, 'v = 3.14');
    fn__8494 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, 3.14).toString() == (', 'v = 3.14', ') not (', actual_1034, ')');
    end;
    temper.test_assert(test_1032, t_1035, fn__8494);
    t_1036 = SqlBuilder();
    t_1036:appendSafe('v = ');
    t_1036:appendFloat64(0.0);
    actual_1037 = t_1036.accumulated:toString();
    t_1038 = temper.str_eq(actual_1037, 'v = 0.0');
    fn__8493 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, 0.0).toString() == (', 'v = 0.0', ') not (', actual_1037, ')');
    end;
    temper.test_assert(test_1032, t_1038, fn__8493);
    t_1039 = SqlBuilder();
    t_1039:appendSafe('v = ');
    t_1039:appendFloat64(-42.5);
    actual_1040 = t_1039.accumulated:toString();
    t_1041 = temper.str_eq(actual_1040, 'v = -42.5');
    fn__8492 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, -42.5).toString() == (', 'v = -42.5', ') not (', actual_1040, ')');
    end;
    temper.test_assert(test_1032, t_1041, fn__8492);
    return nil;
  end);
end;
Test_.test_sqlDateRendersWithQuotes__1875 = function()
  temper.test('SqlDate renders with quotes', function(test_1042)
    local t_1043, d__1447, local_1044, local_1045, local_1046, t_1048, actual_1049, t_1050, fn__8483;
    local_1044, local_1045, local_1046 = temper.pcall(function()
      t_1043 = temper.date_constructor(2024, 6, 15);
      d__1447 = t_1043;
    end);
    if local_1044 then
    else
      d__1447 = temper.bubble();
    end
    t_1048 = SqlBuilder();
    t_1048:appendSafe('v = ');
    t_1048:appendDate(d__1447);
    actual_1049 = t_1048.accumulated:toString();
    t_1050 = temper.str_eq(actual_1049, "v = '2024-06-15'");
    fn__8483 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "v = ", \\interpolate, d).toString() == (', "v = '2024-06-15'", ') not (', actual_1049, ')');
    end;
    temper.test_assert(test_1042, t_1050, fn__8483);
    return nil;
  end);
end;
Test_.test_nesting__1879 = function()
  temper.test('nesting', function(test_1051)
    local name__1449, t_1052, condition__1450, t_1053, actual_1054, t_1055, fn__8451, t_1056, actual_1057, t_1058, fn__8450, parts__1451, t_1059, actual_1060, t_1061, fn__8449;
    name__1449 = 'Someone';
    t_1052 = SqlBuilder();
    t_1052:appendSafe('where p.last_name = ');
    t_1052:appendString('Someone');
    condition__1450 = t_1052.accumulated;
    t_1053 = SqlBuilder();
    t_1053:appendSafe('select p.id from person p ');
    t_1053:appendFragment(condition__1450);
    actual_1054 = t_1053.accumulated:toString();
    t_1055 = temper.str_eq(actual_1054, "select p.id from person p where p.last_name = 'Someone'");
    fn__8451 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "select p.id from person p ", \\interpolate, condition).toString() == (', "select p.id from person p where p.last_name = 'Someone'", ') not (', actual_1054, ')');
    end;
    temper.test_assert(test_1051, t_1055, fn__8451);
    t_1056 = SqlBuilder();
    t_1056:appendSafe('select p.id from person p ');
    t_1056:appendPart(condition__1450:toSource());
    actual_1057 = t_1056.accumulated:toString();
    t_1058 = temper.str_eq(actual_1057, "select p.id from person p where p.last_name = 'Someone'");
    fn__8450 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "select p.id from person p ", \\interpolate, condition.toSource()).toString() == (', "select p.id from person p where p.last_name = 'Someone'", ') not (', actual_1057, ')');
    end;
    temper.test_assert(test_1051, t_1058, fn__8450);
    parts__1451 = temper.listof(SqlString("a'b"), SqlInt32(3));
    t_1059 = SqlBuilder();
    t_1059:appendSafe('select ');
    t_1059:appendPartList(parts__1451);
    actual_1060 = t_1059.accumulated:toString();
    t_1061 = temper.str_eq(actual_1060, "select 'a''b', 3");
    fn__8449 = function()
      return temper.concat('expected stringExpr(`-work//src/`.sql, true, "select ", \\interpolate, parts).toString() == (', "select 'a''b', 3", ') not (', actual_1060, ')');
    end;
    temper.test_assert(test_1051, t_1061, fn__8449);
    return nil;
  end);
end;
exports = {};
local_1063.LuaUnit.run(local_1062({'--pattern', '^Test_%.', local_1062(arg)}));
return exports;
