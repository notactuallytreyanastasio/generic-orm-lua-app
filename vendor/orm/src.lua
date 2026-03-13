local temper = require('temper-core');
local ChangesetError, Changeset, ChangesetImpl__108, JoinType, InnerJoin, LeftJoin, RightJoin, FullJoin, JoinClause, OrderClause, Query, SafeIdentifier, ValidatedIdentifier__142, FieldType, StringField, IntField, Int64Field, FloatField, BoolField, DateField, FieldDef, TableDef, SqlBuilder, SqlFragment, SqlPart, SqlSource, SqlBoolean, SqlDate, SqlFloat64, SqlInt32, SqlInt64, SqlString, changeset, isIdentStart__345, isIdentPart__346, safeIdentifier, deleteSql, from, col, exports;
ChangesetError = temper.type('ChangesetError');
ChangesetError.constructor = function(this__177, field__352, message__353)
  this__177.field__349 = field__352;
  this__177.message__350 = message__353;
  return nil;
end;
ChangesetError.get.field = function(this__976)
  return this__976.field__349;
end;
ChangesetError.get.message = function(this__979)
  return this__979.message__350;
end;
Changeset = temper.type('Changeset');
Changeset.get.tableDef = function(this__95)
  temper.virtual();
end;
Changeset.get.changes = function(this__96)
  temper.virtual();
end;
Changeset.get.errors = function(this__97)
  temper.virtual();
end;
Changeset.get.isValid = function(this__98)
  temper.virtual();
end;
Changeset.methods.cast = function(this__99, allowedFields__363)
  temper.virtual();
end;
Changeset.methods.validateRequired = function(this__100, fields__366)
  temper.virtual();
end;
Changeset.methods.validateLength = function(this__101, field__369, min__370, max__371)
  temper.virtual();
end;
Changeset.methods.validateInt = function(this__102, field__374)
  temper.virtual();
end;
Changeset.methods.validateInt64 = function(this__103, field__377)
  temper.virtual();
end;
Changeset.methods.validateFloat = function(this__104, field__380)
  temper.virtual();
end;
Changeset.methods.validateBool = function(this__105, field__383)
  temper.virtual();
end;
Changeset.methods.toInsertSql = function(this__106)
  temper.virtual();
end;
Changeset.methods.toUpdateSql = function(this__107, id__388)
  temper.virtual();
end;
ChangesetImpl__108 = temper.type('ChangesetImpl__108', Changeset);
ChangesetImpl__108.get.tableDef = function(this__109)
  return this__109._tableDef__390;
end;
ChangesetImpl__108.get.changes = function(this__110)
  return this__110._changes__392;
end;
ChangesetImpl__108.get.errors = function(this__111)
  return this__111._errors__393;
end;
ChangesetImpl__108.get.isValid = function(this__112)
  return this__112._isValid__394;
end;
ChangesetImpl__108.methods.cast = function(this__113, allowedFields__404)
  local mb__406, fn__5700;
  mb__406 = temper.mapbuilder_constructor();
  fn__5700 = function(f__407)
    local t_0, t_1, val__408;
    t_1 = f__407.sqlValue;
    val__408 = temper.mapped_getor(this__113._params__391, t_1, '');
    if not temper.string_isempty(val__408) then
      t_0 = f__407.sqlValue;
      temper.mapbuilder_set(mb__406, t_0, val__408);
    end
    return nil;
  end;
  temper.list_foreach(allowedFields__404, fn__5700);
  return ChangesetImpl__108(this__113._tableDef__390, this__113._params__391, temper.mapped_tomap(mb__406), this__113._errors__393, this__113._isValid__394);
end;
ChangesetImpl__108.methods.validateRequired = function(this__114, fields__410)
  local return__210, t_2, t_3, t_4, t_5, eb__412, valid__413, fn__5689;
  ::continue_1::
  if not this__114._isValid__394 then
    return__210 = this__114;
    goto break_0;
  end
  eb__412 = temper.list_tolistbuilder(this__114._errors__393);
  valid__413 = true;
  fn__5689 = function(f__414)
    local t_6, t_7;
    t_7 = f__414.sqlValue;
    if not temper.mapped_has(this__114._changes__392, t_7) then
      t_6 = ChangesetError(f__414.sqlValue, 'is required');
      temper.listbuilder_add(eb__412, t_6);
      valid__413 = false;
    end
    return nil;
  end;
  temper.list_foreach(fields__410, fn__5689);
  t_3 = this__114._tableDef__390;
  t_4 = this__114._params__391;
  t_5 = this__114._changes__392;
  t_2 = temper.listbuilder_tolist(eb__412);
  return__210 = ChangesetImpl__108(t_3, t_4, t_5, t_2, valid__413);
  ::break_0::return return__210;
end;
ChangesetImpl__108.methods.validateLength = function(this__115, field__416, min__417, max__418)
  local return__211, t_8, t_9, t_10, t_11, t_12, t_13, val__420, len__421;
  ::continue_3::
  if not this__115._isValid__394 then
    return__211 = this__115;
    goto break_2;
  end
  t_8 = field__416.sqlValue;
  val__420 = temper.mapped_getor(this__115._changes__392, t_8, '');
  len__421 = temper.string_countbetween(val__420, 1.0, temper.string_end(val__420));
  if (len__421 < min__417) then
    t_10 = true;
  else
    t_10 = (len__421 > max__418);
  end
  if t_10 then
    local msg__422, eb__423;
    msg__422 = temper.concat('must be between ', temper.int32_tostring(min__417), ' and ', temper.int32_tostring(max__418), ' characters');
    eb__423 = temper.list_tolistbuilder(this__115._errors__393);
    temper.listbuilder_add(eb__423, ChangesetError(field__416.sqlValue, msg__422));
    t_11 = this__115._tableDef__390;
    t_12 = this__115._params__391;
    t_13 = this__115._changes__392;
    t_9 = temper.listbuilder_tolist(eb__423);
    return__211 = ChangesetImpl__108(t_11, t_12, t_13, t_9, false);
    goto break_2;
  end
  return__211 = this__115;
  ::break_2::return return__211;
end;
ChangesetImpl__108.methods.validateInt = function(this__116, field__425)
  local return__212, t_14, t_15, t_16, t_17, t_18, val__427, parseOk__428, local_19, local_20, local_21;
  ::continue_5::
  if not this__116._isValid__394 then
    return__212 = this__116;
    goto break_4;
  end
  t_14 = field__425.sqlValue;
  val__427 = temper.mapped_getor(this__116._changes__392, t_14, '');
  if temper.string_isempty(val__427) then
    return__212 = this__116;
    goto break_4;
  end
  local_19, local_20, local_21 = temper.pcall(function()
    temper.string_toint32(val__427);
    parseOk__428 = true;
  end);
  if local_19 then
  else
    parseOk__428 = false;
  end
  if not parseOk__428 then
    local eb__429;
    eb__429 = temper.list_tolistbuilder(this__116._errors__393);
    temper.listbuilder_add(eb__429, ChangesetError(field__425.sqlValue, 'must be an integer'));
    t_16 = this__116._tableDef__390;
    t_17 = this__116._params__391;
    t_18 = this__116._changes__392;
    t_15 = temper.listbuilder_tolist(eb__429);
    return__212 = ChangesetImpl__108(t_16, t_17, t_18, t_15, false);
    goto break_4;
  end
  return__212 = this__116;
  ::break_4::return return__212;
end;
ChangesetImpl__108.methods.validateInt64 = function(this__117, field__431)
  local return__213, t_23, t_24, t_25, t_26, t_27, val__433, parseOk__434, local_28, local_29, local_30;
  ::continue_7::
  if not this__117._isValid__394 then
    return__213 = this__117;
    goto break_6;
  end
  t_23 = field__431.sqlValue;
  val__433 = temper.mapped_getor(this__117._changes__392, t_23, '');
  if temper.string_isempty(val__433) then
    return__213 = this__117;
    goto break_6;
  end
  local_28, local_29, local_30 = temper.pcall(function()
    temper.string_toint64(val__433);
    parseOk__434 = true;
  end);
  if local_28 then
  else
    parseOk__434 = false;
  end
  if not parseOk__434 then
    local eb__435;
    eb__435 = temper.list_tolistbuilder(this__117._errors__393);
    temper.listbuilder_add(eb__435, ChangesetError(field__431.sqlValue, 'must be a 64-bit integer'));
    t_25 = this__117._tableDef__390;
    t_26 = this__117._params__391;
    t_27 = this__117._changes__392;
    t_24 = temper.listbuilder_tolist(eb__435);
    return__213 = ChangesetImpl__108(t_25, t_26, t_27, t_24, false);
    goto break_6;
  end
  return__213 = this__117;
  ::break_6::return return__213;
end;
ChangesetImpl__108.methods.validateFloat = function(this__118, field__437)
  local return__214, t_32, t_33, t_34, t_35, t_36, val__439, parseOk__440, local_37, local_38, local_39;
  ::continue_9::
  if not this__118._isValid__394 then
    return__214 = this__118;
    goto break_8;
  end
  t_32 = field__437.sqlValue;
  val__439 = temper.mapped_getor(this__118._changes__392, t_32, '');
  if temper.string_isempty(val__439) then
    return__214 = this__118;
    goto break_8;
  end
  local_37, local_38, local_39 = temper.pcall(function()
    temper.string_tofloat64(val__439);
    parseOk__440 = true;
  end);
  if local_37 then
  else
    parseOk__440 = false;
  end
  if not parseOk__440 then
    local eb__441;
    eb__441 = temper.list_tolistbuilder(this__118._errors__393);
    temper.listbuilder_add(eb__441, ChangesetError(field__437.sqlValue, 'must be a number'));
    t_34 = this__118._tableDef__390;
    t_35 = this__118._params__391;
    t_36 = this__118._changes__392;
    t_33 = temper.listbuilder_tolist(eb__441);
    return__214 = ChangesetImpl__108(t_34, t_35, t_36, t_33, false);
    goto break_8;
  end
  return__214 = this__118;
  ::break_8::return return__214;
end;
ChangesetImpl__108.methods.validateBool = function(this__119, field__443)
  local return__215, t_41, t_42, t_43, t_44, t_45, t_46, t_47, t_48, t_49, t_50, val__445, isTrue__446, isFalse__447;
  ::continue_11::
  if not this__119._isValid__394 then
    return__215 = this__119;
    goto break_10;
  end
  t_41 = field__443.sqlValue;
  val__445 = temper.mapped_getor(this__119._changes__392, t_41, '');
  if temper.string_isempty(val__445) then
    return__215 = this__119;
    goto break_10;
  end
  if temper.str_eq(val__445, 'true') then
    isTrue__446 = true;
  else
    if temper.str_eq(val__445, '1') then
      t_44 = true;
    else
      if temper.str_eq(val__445, 'yes') then
        t_43 = true;
      else
        t_43 = temper.str_eq(val__445, 'on');
      end
      t_44 = t_43;
    end
    isTrue__446 = t_44;
  end
  if temper.str_eq(val__445, 'false') then
    isFalse__447 = true;
  else
    if temper.str_eq(val__445, '0') then
      t_46 = true;
    else
      if temper.str_eq(val__445, 'no') then
        t_45 = true;
      else
        t_45 = temper.str_eq(val__445, 'off');
      end
      t_46 = t_45;
    end
    isFalse__447 = t_46;
  end
  if not isTrue__446 then
    t_47 = not isFalse__447;
  else
    t_47 = false;
  end
  if t_47 then
    local eb__448;
    eb__448 = temper.list_tolistbuilder(this__119._errors__393);
    temper.listbuilder_add(eb__448, ChangesetError(field__443.sqlValue, 'must be a boolean (true/false/1/0/yes/no/on/off)'));
    t_48 = this__119._tableDef__390;
    t_49 = this__119._params__391;
    t_50 = this__119._changes__392;
    t_42 = temper.listbuilder_tolist(eb__448);
    return__215 = ChangesetImpl__108(t_48, t_49, t_50, t_42, false);
    goto break_10;
  end
  return__215 = this__119;
  ::break_10::return return__215;
end;
ChangesetImpl__108.methods.parseBoolSqlPart = function(this__120, val__450)
  local return__216, t_51, t_52, t_53, t_54, t_55, t_56;
  ::continue_13::
  if temper.str_eq(val__450, 'true') then
    t_53 = true;
  else
    if temper.str_eq(val__450, '1') then
      t_52 = true;
    else
      if temper.str_eq(val__450, 'yes') then
        t_51 = true;
      else
        t_51 = temper.str_eq(val__450, 'on');
      end
      t_52 = t_51;
    end
    t_53 = t_52;
  end
  if t_53 then
    return__216 = SqlBoolean(true);
    goto break_12;
  end
  if temper.str_eq(val__450, 'false') then
    t_56 = true;
  else
    if temper.str_eq(val__450, '0') then
      t_55 = true;
    else
      if temper.str_eq(val__450, 'no') then
        t_54 = true;
      else
        t_54 = temper.str_eq(val__450, 'off');
      end
      t_55 = t_54;
    end
    t_56 = t_55;
  end
  if t_56 then
    return__216 = SqlBoolean(false);
    goto break_12;
  end
  temper.bubble();
  ::break_12::return return__216;
end;
ChangesetImpl__108.methods.valueToSqlPart = function(this__121, fieldDef__453, val__454)
  local return__217, t_57, t_58, t_59, t_60, ft__456;
  ::continue_15::ft__456 = fieldDef__453.fieldType;
  if temper.instance_of(ft__456, StringField) then
    return__217 = SqlString(val__454);
    goto break_14;
  end
  if temper.instance_of(ft__456, IntField) then
    t_57 = temper.string_toint32(val__454);
    return__217 = SqlInt32(t_57);
    goto break_14;
  end
  if temper.instance_of(ft__456, Int64Field) then
    t_58 = temper.string_toint64(val__454);
    return__217 = SqlInt64(t_58);
    goto break_14;
  end
  if temper.instance_of(ft__456, FloatField) then
    t_59 = temper.string_tofloat64(val__454);
    return__217 = SqlFloat64(t_59);
    goto break_14;
  end
  if temper.instance_of(ft__456, BoolField) then
    return__217 = this__121:parseBoolSqlPart(val__454);
    goto break_14;
  end
  if temper.instance_of(ft__456, DateField) then
    t_60 = temper.date_fromisostring(val__454);
    return__217 = SqlDate(t_60);
    goto break_14;
  end
  temper.bubble();
  ::break_14::return return__217;
end;
ChangesetImpl__108.methods.toInsertSql = function(this__122)
  local t_61, t_62, t_63, t_64, t_65, t_66, t_67, t_68, t_69, t_70, i__459, pairs__461, colNames__462, valParts__463, i__464, b__467, t_71, fn__5581, j__469;
  if not this__122._isValid__394 then
    temper.bubble();
  end
  i__459 = 0;
  while true do
    local f__460;
    t_61 = temper.list_length(this__122._tableDef__390.fields);
    if not (i__459 < t_61) then
      break;
    end
    f__460 = temper.list_get(this__122._tableDef__390.fields, i__459);
    if not f__460.nullable then
      t_62 = f__460.name.sqlValue;
      t_63 = temper.mapped_has(this__122._changes__392, t_62);
      t_68 = not t_63;
    else
      t_68 = false;
    end
    if t_68 then
      temper.bubble();
    end
    i__459 = temper.int32_add(i__459, 1);
  end
  pairs__461 = temper.mapped_tolist(this__122._changes__392);
  if (temper.list_length(pairs__461) == 0) then
    temper.bubble();
  end
  colNames__462 = temper.listbuilder_constructor();
  valParts__463 = temper.listbuilder_constructor();
  i__464 = 0;
  while true do
    local pair__465, fd__466;
    t_64 = temper.list_length(pairs__461);
    if not (i__464 < t_64) then
      break;
    end
    pair__465 = temper.list_get(pairs__461, i__464);
    t_65 = pair__465.key;
    t_69 = this__122._tableDef__390:field(t_65);
    fd__466 = t_69;
    temper.listbuilder_add(colNames__462, fd__466.name.sqlValue);
    t_66 = pair__465.value;
    t_70 = this__122:valueToSqlPart(fd__466, t_66);
    temper.listbuilder_add(valParts__463, t_70);
    i__464 = temper.int32_add(i__464, 1);
  end
  b__467 = SqlBuilder();
  b__467:appendSafe('INSERT INTO ');
  b__467:appendSafe(this__122._tableDef__390.tableName.sqlValue);
  b__467:appendSafe(' (');
  t_71 = temper.listbuilder_tolist(colNames__462);
  fn__5581 = function(c__468)
    return c__468;
  end;
  b__467:appendSafe(temper.listed_join(t_71, ', ', fn__5581));
  b__467:appendSafe(') VALUES (');
  b__467:appendPart(temper.listed_get(valParts__463, 0));
  j__469 = 1;
  while true do
    t_67 = temper.listbuilder_length(valParts__463);
    if not (j__469 < t_67) then
      break;
    end
    b__467:appendSafe(', ');
    b__467:appendPart(temper.listed_get(valParts__463, j__469));
    j__469 = temper.int32_add(j__469, 1);
  end
  b__467:appendSafe(')');
  return b__467.accumulated;
end;
ChangesetImpl__108.methods.toUpdateSql = function(this__123, id__471)
  local t_72, t_73, t_74, t_75, t_76, pairs__473, b__474, i__475;
  if not this__123._isValid__394 then
    temper.bubble();
  end
  pairs__473 = temper.mapped_tolist(this__123._changes__392);
  if (temper.list_length(pairs__473) == 0) then
    temper.bubble();
  end
  b__474 = SqlBuilder();
  b__474:appendSafe('UPDATE ');
  b__474:appendSafe(this__123._tableDef__390.tableName.sqlValue);
  b__474:appendSafe(' SET ');
  i__475 = 0;
  while true do
    local pair__476, fd__477;
    t_72 = temper.list_length(pairs__473);
    if not (i__475 < t_72) then
      break;
    end
    if (i__475 > 0) then
      b__474:appendSafe(', ');
    end
    pair__476 = temper.list_get(pairs__473, i__475);
    t_73 = pair__476.key;
    t_75 = this__123._tableDef__390:field(t_73);
    fd__477 = t_75;
    b__474:appendSafe(fd__477.name.sqlValue);
    b__474:appendSafe(' = ');
    t_74 = pair__476.value;
    t_76 = this__123:valueToSqlPart(fd__477, t_74);
    b__474:appendPart(t_76);
    i__475 = temper.int32_add(i__475, 1);
  end
  b__474:appendSafe(' WHERE id = ');
  b__474:appendInt32(id__471);
  return b__474.accumulated;
end;
ChangesetImpl__108.constructor = function(this__200, _tableDef__479, _params__480, _changes__481, _errors__482, _isValid__483)
  this__200._tableDef__390 = _tableDef__479;
  this__200._params__391 = _params__480;
  this__200._changes__392 = _changes__481;
  this__200._errors__393 = _errors__482;
  this__200._isValid__394 = _isValid__483;
  return nil;
end;
JoinType = temper.type('JoinType');
JoinType.methods.keyword = function(this__124)
  temper.virtual();
end;
InnerJoin = temper.type('InnerJoin', JoinType);
InnerJoin.methods.keyword = function(this__125)
  return 'INNER JOIN';
end;
InnerJoin.constructor = function(this__225)
  return nil;
end;
LeftJoin = temper.type('LeftJoin', JoinType);
LeftJoin.methods.keyword = function(this__126)
  return 'LEFT JOIN';
end;
LeftJoin.constructor = function(this__228)
  return nil;
end;
RightJoin = temper.type('RightJoin', JoinType);
RightJoin.methods.keyword = function(this__127)
  return 'RIGHT JOIN';
end;
RightJoin.constructor = function(this__231)
  return nil;
end;
FullJoin = temper.type('FullJoin', JoinType);
FullJoin.methods.keyword = function(this__128)
  return 'FULL OUTER JOIN';
end;
FullJoin.constructor = function(this__234)
  return nil;
end;
JoinClause = temper.type('JoinClause');
JoinClause.constructor = function(this__237, joinType__596, table__597, onCondition__598)
  this__237.joinType__592 = joinType__596;
  this__237.table__593 = table__597;
  this__237.onCondition__594 = onCondition__598;
  return nil;
end;
JoinClause.get.joinType = function(this__1044)
  return this__1044.joinType__592;
end;
JoinClause.get.table = function(this__1047)
  return this__1047.table__593;
end;
JoinClause.get.onCondition = function(this__1050)
  return this__1050.onCondition__594;
end;
OrderClause = temper.type('OrderClause');
OrderClause.constructor = function(this__239, field__602, ascending__603)
  this__239.field__599 = field__602;
  this__239.ascending__600 = ascending__603;
  return nil;
end;
OrderClause.get.field = function(this__1053)
  return this__1053.field__599;
end;
OrderClause.get.ascending = function(this__1056)
  return this__1056.ascending__600;
end;
Query = temper.type('Query');
Query.methods.where = function(this__129, condition__612)
  local nb__614;
  nb__614 = temper.list_tolistbuilder(this__129.conditions__605);
  temper.listbuilder_add(nb__614, condition__612);
  return Query(this__129.tableName__604, temper.listbuilder_tolist(nb__614), this__129.selectedFields__606, this__129.orderClauses__607, this__129.limitVal__608, this__129.offsetVal__609, this__129.joinClauses__610);
end;
Query.methods.select = function(this__130, fields__616)
  return Query(this__130.tableName__604, this__130.conditions__605, fields__616, this__130.orderClauses__607, this__130.limitVal__608, this__130.offsetVal__609, this__130.joinClauses__610);
end;
Query.methods.orderBy = function(this__131, field__619, ascending__620)
  local nb__622;
  nb__622 = temper.list_tolistbuilder(this__131.orderClauses__607);
  temper.listbuilder_add(nb__622, OrderClause(field__619, ascending__620));
  return Query(this__131.tableName__604, this__131.conditions__605, this__131.selectedFields__606, temper.listbuilder_tolist(nb__622), this__131.limitVal__608, this__131.offsetVal__609, this__131.joinClauses__610);
end;
Query.methods.limit = function(this__132, n__624)
  if (n__624 < 0) then
    temper.bubble();
  end
  return Query(this__132.tableName__604, this__132.conditions__605, this__132.selectedFields__606, this__132.orderClauses__607, n__624, this__132.offsetVal__609, this__132.joinClauses__610);
end;
Query.methods.offset = function(this__133, n__627)
  if (n__627 < 0) then
    temper.bubble();
  end
  return Query(this__133.tableName__604, this__133.conditions__605, this__133.selectedFields__606, this__133.orderClauses__607, this__133.limitVal__608, n__627, this__133.joinClauses__610);
end;
Query.methods.join = function(this__134, joinType__630, table__631, onCondition__632)
  local nb__634;
  nb__634 = temper.list_tolistbuilder(this__134.joinClauses__610);
  temper.listbuilder_add(nb__634, JoinClause(joinType__630, table__631, onCondition__632));
  return Query(this__134.tableName__604, this__134.conditions__605, this__134.selectedFields__606, this__134.orderClauses__607, this__134.limitVal__608, this__134.offsetVal__609, temper.listbuilder_tolist(nb__634));
end;
Query.methods.innerJoin = function(this__135, table__636, onCondition__637)
  local t_77;
  t_77 = InnerJoin();
  return this__135:join(t_77, table__636, onCondition__637);
end;
Query.methods.leftJoin = function(this__136, table__640, onCondition__641)
  local t_78;
  t_78 = LeftJoin();
  return this__136:join(t_78, table__640, onCondition__641);
end;
Query.methods.rightJoin = function(this__137, table__644, onCondition__645)
  local t_79;
  t_79 = RightJoin();
  return this__137:join(t_79, table__644, onCondition__645);
end;
Query.methods.fullJoin = function(this__138, table__648, onCondition__649)
  local t_80;
  t_80 = FullJoin();
  return this__138:join(t_80, table__648, onCondition__649);
end;
Query.methods.toSql = function(this__139)
  local t_81, b__653, fn__5115, lv__659, ov__660;
  b__653 = SqlBuilder();
  b__653:appendSafe('SELECT ');
  if temper.listed_isempty(this__139.selectedFields__606) then
    b__653:appendSafe('*');
  else
    local fn__5116;
    fn__5116 = function(f__654)
      return f__654.sqlValue;
    end;
    b__653:appendSafe(temper.listed_join(this__139.selectedFields__606, ', ', fn__5116));
  end
  b__653:appendSafe(' FROM ');
  b__653:appendSafe(this__139.tableName__604.sqlValue);
  fn__5115 = function(jc__655)
    local t_82, t_83, t_84;
    b__653:appendSafe(' ');
    t_82 = jc__655.joinType:keyword();
    b__653:appendSafe(t_82);
    b__653:appendSafe(' ');
    t_83 = jc__655.table.sqlValue;
    b__653:appendSafe(t_83);
    b__653:appendSafe(' ON ');
    t_84 = jc__655.onCondition;
    b__653:appendFragment(t_84);
    return nil;
  end;
  temper.list_foreach(this__139.joinClauses__610, fn__5115);
  if not temper.listed_isempty(this__139.conditions__605) then
    local i__656;
    b__653:appendSafe(' WHERE ');
    b__653:appendFragment(temper.list_get(this__139.conditions__605, 0));
    i__656 = 1;
    while true do
      t_81 = temper.list_length(this__139.conditions__605);
      if not (i__656 < t_81) then
        break;
      end
      b__653:appendSafe(' AND ');
      b__653:appendFragment(temper.list_get(this__139.conditions__605, i__656));
      i__656 = temper.int32_add(i__656, 1);
    end
  end
  if not temper.listed_isempty(this__139.orderClauses__607) then
    local first__657, fn__5114;
    b__653:appendSafe(' ORDER BY ');
    first__657 = true;
    fn__5114 = function(oc__658)
      local t_85, t_86;
      if not first__657 then
        b__653:appendSafe(', ');
      end
      first__657 = false;
      t_86 = oc__658.field.sqlValue;
      b__653:appendSafe(t_86);
      if oc__658.ascending then
        t_85 = ' ASC';
      else
        t_85 = ' DESC';
      end
      b__653:appendSafe(t_85);
      return nil;
    end;
    temper.list_foreach(this__139.orderClauses__607, fn__5114);
  end
  lv__659 = this__139.limitVal__608;
  if not temper.is_null(lv__659) then
    local lv_87;
    lv_87 = lv__659;
    b__653:appendSafe(' LIMIT ');
    b__653:appendInt32(lv_87);
  end
  ov__660 = this__139.offsetVal__609;
  if not temper.is_null(ov__660) then
    local ov_88;
    ov_88 = ov__660;
    b__653:appendSafe(' OFFSET ');
    b__653:appendInt32(ov_88);
  end
  return b__653.accumulated;
end;
Query.methods.safeToSql = function(this__140, defaultLimit__662)
  local return__260, t_89;
  if (defaultLimit__662 < 0) then
    temper.bubble();
  end
  if not temper.is_null(this__140.limitVal__608) then
    return__260 = this__140:toSql();
  else
    t_89 = this__140:limit(defaultLimit__662);
    return__260 = t_89:toSql();
  end
  return return__260;
end;
Query.constructor = function(this__241, tableName__665, conditions__666, selectedFields__667, orderClauses__668, limitVal__669, offsetVal__670, joinClauses__671)
  if (limitVal__669 == nil) then
    limitVal__669 = temper.null;
  end
  if (offsetVal__670 == nil) then
    offsetVal__670 = temper.null;
  end
  this__241.tableName__604 = tableName__665;
  this__241.conditions__605 = conditions__666;
  this__241.selectedFields__606 = selectedFields__667;
  this__241.orderClauses__607 = orderClauses__668;
  this__241.limitVal__608 = limitVal__669;
  this__241.offsetVal__609 = offsetVal__670;
  this__241.joinClauses__610 = joinClauses__671;
  return nil;
end;
Query.get.tableName = function(this__1059)
  return this__1059.tableName__604;
end;
Query.get.conditions = function(this__1062)
  return this__1062.conditions__605;
end;
Query.get.selectedFields = function(this__1065)
  return this__1065.selectedFields__606;
end;
Query.get.orderClauses = function(this__1068)
  return this__1068.orderClauses__607;
end;
Query.get.limitVal = function(this__1071)
  return this__1071.limitVal__608;
end;
Query.get.offsetVal = function(this__1074)
  return this__1074.offsetVal__609;
end;
Query.get.joinClauses = function(this__1077)
  return this__1077.joinClauses__610;
end;
SafeIdentifier = temper.type('SafeIdentifier');
SafeIdentifier.get.sqlValue = function(this__141)
  temper.virtual();
end;
ValidatedIdentifier__142 = temper.type('ValidatedIdentifier__142', SafeIdentifier);
ValidatedIdentifier__142.get.sqlValue = function(this__143)
  return this__143._value__738;
end;
ValidatedIdentifier__142.constructor = function(this__267, _value__742)
  this__267._value__738 = _value__742;
  return nil;
end;
FieldType = temper.type('FieldType');
StringField = temper.type('StringField', FieldType);
StringField.constructor = function(this__273)
  return nil;
end;
IntField = temper.type('IntField', FieldType);
IntField.constructor = function(this__275)
  return nil;
end;
Int64Field = temper.type('Int64Field', FieldType);
Int64Field.constructor = function(this__277)
  return nil;
end;
FloatField = temper.type('FloatField', FieldType);
FloatField.constructor = function(this__279)
  return nil;
end;
BoolField = temper.type('BoolField', FieldType);
BoolField.constructor = function(this__281)
  return nil;
end;
DateField = temper.type('DateField', FieldType);
DateField.constructor = function(this__283)
  return nil;
end;
FieldDef = temper.type('FieldDef');
FieldDef.constructor = function(this__285, name__760, fieldType__761, nullable__762)
  this__285.name__756 = name__760;
  this__285.fieldType__757 = fieldType__761;
  this__285.nullable__758 = nullable__762;
  return nil;
end;
FieldDef.get.name = function(this__982)
  return this__982.name__756;
end;
FieldDef.get.fieldType = function(this__985)
  return this__985.fieldType__757;
end;
FieldDef.get.nullable = function(this__988)
  return this__988.nullable__758;
end;
TableDef = temper.type('TableDef');
TableDef.methods.field = function(this__144, name__766)
  local return__290, this__3570, n__3571, i__3572;
  ::continue_17::this__3570 = this__144.fields__764;
  n__3571 = temper.list_length(this__3570);
  i__3572 = 0;
  while (i__3572 < n__3571) do
    local el__3573, f__768;
    el__3573 = temper.list_get(this__3570, i__3572);
    i__3572 = temper.int32_add(i__3572, 1);
    f__768 = el__3573;
    if temper.str_eq(f__768.name.sqlValue, name__766) then
      return__290 = f__768;
      goto break_16;
    end
  end
  temper.bubble();
  ::break_16::return return__290;
end;
TableDef.constructor = function(this__287, tableName__770, fields__771)
  this__287.tableName__763 = tableName__770;
  this__287.fields__764 = fields__771;
  return nil;
end;
TableDef.get.tableName = function(this__991)
  return this__991.tableName__763;
end;
TableDef.get.fields = function(this__994)
  return this__994.fields__764;
end;
SqlBuilder = temper.type('SqlBuilder');
SqlBuilder.methods.appendSafe = function(this__145, sqlSource__793)
  local t_90;
  t_90 = SqlSource(sqlSource__793);
  temper.listbuilder_add(this__145.buffer__791, t_90);
  return nil;
end;
SqlBuilder.methods.appendFragment = function(this__146, fragment__796)
  local t_91;
  t_91 = fragment__796.parts;
  temper.listbuilder_addall(this__146.buffer__791, t_91);
  return nil;
end;
SqlBuilder.methods.appendPart = function(this__147, part__799)
  temper.listbuilder_add(this__147.buffer__791, part__799);
  return nil;
end;
SqlBuilder.methods.appendPartList = function(this__148, values__802)
  local fn__5752;
  fn__5752 = function(x__804)
    this__148:appendPart(x__804);
    return nil;
  end;
  this__148:appendList(values__802, fn__5752);
  return nil;
end;
SqlBuilder.methods.appendBoolean = function(this__149, value__806)
  local t_92;
  t_92 = SqlBoolean(value__806);
  temper.listbuilder_add(this__149.buffer__791, t_92);
  return nil;
end;
SqlBuilder.methods.appendBooleanList = function(this__150, values__809)
  local fn__5746;
  fn__5746 = function(x__811)
    this__150:appendBoolean(x__811);
    return nil;
  end;
  this__150:appendList(values__809, fn__5746);
  return nil;
end;
SqlBuilder.methods.appendDate = function(this__151, value__813)
  local t_93;
  t_93 = SqlDate(value__813);
  temper.listbuilder_add(this__151.buffer__791, t_93);
  return nil;
end;
SqlBuilder.methods.appendDateList = function(this__152, values__816)
  local fn__5740;
  fn__5740 = function(x__818)
    this__152:appendDate(x__818);
    return nil;
  end;
  this__152:appendList(values__816, fn__5740);
  return nil;
end;
SqlBuilder.methods.appendFloat64 = function(this__153, value__820)
  local t_94;
  t_94 = SqlFloat64(value__820);
  temper.listbuilder_add(this__153.buffer__791, t_94);
  return nil;
end;
SqlBuilder.methods.appendFloat64List = function(this__154, values__823)
  local fn__5734;
  fn__5734 = function(x__825)
    this__154:appendFloat64(x__825);
    return nil;
  end;
  this__154:appendList(values__823, fn__5734);
  return nil;
end;
SqlBuilder.methods.appendInt32 = function(this__155, value__827)
  local t_95;
  t_95 = SqlInt32(value__827);
  temper.listbuilder_add(this__155.buffer__791, t_95);
  return nil;
end;
SqlBuilder.methods.appendInt32List = function(this__156, values__830)
  local fn__5728;
  fn__5728 = function(x__832)
    this__156:appendInt32(x__832);
    return nil;
  end;
  this__156:appendList(values__830, fn__5728);
  return nil;
end;
SqlBuilder.methods.appendInt64 = function(this__157, value__834)
  local t_96;
  t_96 = SqlInt64(value__834);
  temper.listbuilder_add(this__157.buffer__791, t_96);
  return nil;
end;
SqlBuilder.methods.appendInt64List = function(this__158, values__837)
  local fn__5722;
  fn__5722 = function(x__839)
    this__158:appendInt64(x__839);
    return nil;
  end;
  this__158:appendList(values__837, fn__5722);
  return nil;
end;
SqlBuilder.methods.appendString = function(this__159, value__841)
  local t_97;
  t_97 = SqlString(value__841);
  temper.listbuilder_add(this__159.buffer__791, t_97);
  return nil;
end;
SqlBuilder.methods.appendStringList = function(this__160, values__844)
  local fn__5716;
  fn__5716 = function(x__846)
    this__160:appendString(x__846);
    return nil;
  end;
  this__160:appendList(values__844, fn__5716);
  return nil;
end;
SqlBuilder.methods.appendList = function(this__161, values__848, appendValue__849)
  local t_98, t_99, i__851;
  i__851 = 0;
  while true do
    t_98 = temper.listed_length(values__848);
    if not (i__851 < t_98) then
      break;
    end
    if (i__851 > 0) then
      this__161:appendSafe(', ');
    end
    t_99 = temper.listed_get(values__848, i__851);
    appendValue__849(t_99);
    i__851 = temper.int32_add(i__851, 1);
  end
  return nil;
end;
SqlBuilder.get.accumulated = function(this__162)
  return SqlFragment(temper.listbuilder_tolist(this__162.buffer__791));
end;
SqlBuilder.constructor = function(this__292)
  local t_100;
  t_100 = temper.listbuilder_constructor();
  this__292.buffer__791 = t_100;
  return nil;
end;
SqlFragment = temper.type('SqlFragment');
SqlFragment.methods.toSource = function(this__167)
  return SqlSource(this__167:toString());
end;
SqlFragment.methods.toString = function(this__168)
  local t_101, builder__863, i__864;
  builder__863 = temper.stringbuilder_constructor();
  i__864 = 0;
  while true do
    t_101 = temper.list_length(this__168.parts__858);
    if not (i__864 < t_101) then
      break;
    end
    temper.list_get(this__168.parts__858, i__864):formatTo(builder__863);
    i__864 = temper.int32_add(i__864, 1);
  end
  return temper.stringbuilder_tostring(builder__863);
end;
SqlFragment.constructor = function(this__313, parts__866)
  this__313.parts__858 = parts__866;
  return nil;
end;
SqlFragment.get.parts = function(this__1000)
  return this__1000.parts__858;
end;
SqlPart = temper.type('SqlPart');
SqlPart.methods.formatTo = function(this__169, builder__868)
  temper.virtual();
end;
SqlSource = temper.type('SqlSource', SqlPart);
SqlSource.methods.formatTo = function(this__170, builder__872)
  temper.stringbuilder_append(builder__872, this__170.source__870);
  return nil;
end;
SqlSource.constructor = function(this__319, source__875)
  this__319.source__870 = source__875;
  return nil;
end;
SqlSource.get.source = function(this__997)
  return this__997.source__870;
end;
SqlBoolean = temper.type('SqlBoolean', SqlPart);
SqlBoolean.methods.formatTo = function(this__171, builder__878)
  local t_102;
  if this__171.value__876 then
    t_102 = 'TRUE';
  else
    t_102 = 'FALSE';
  end
  temper.stringbuilder_append(builder__878, t_102);
  return nil;
end;
SqlBoolean.constructor = function(this__322, value__881)
  this__322.value__876 = value__881;
  return nil;
end;
SqlBoolean.get.value = function(this__1003)
  return this__1003.value__876;
end;
SqlDate = temper.type('SqlDate', SqlPart);
SqlDate.methods.formatTo = function(this__172, builder__884)
  local t_103, fn__5761;
  temper.stringbuilder_append(builder__884, "'");
  t_103 = temper.date_tostring(this__172.value__882);
  fn__5761 = function(c__886)
    if (c__886 == 39) then
      temper.stringbuilder_append(builder__884, "''");
    else
      local local_104, local_105, local_106;
      local_104, local_105, local_106 = temper.pcall(function()
        temper.stringbuilder_appendcodepoint(builder__884, c__886);
      end);
      if local_104 then
      else
        temper.bubble();
      end
    end
    return nil;
  end;
  temper.string_foreach(t_103, fn__5761);
  temper.stringbuilder_append(builder__884, "'");
  return nil;
end;
SqlDate.constructor = function(this__325, value__888)
  this__325.value__882 = value__888;
  return nil;
end;
SqlDate.get.value = function(this__1018)
  return this__1018.value__882;
end;
SqlFloat64 = temper.type('SqlFloat64', SqlPart);
SqlFloat64.methods.formatTo = function(this__173, builder__891)
  local t_108, t_109, s__893;
  s__893 = temper.float64_tostring(this__173.value__889);
  if temper.str_eq(s__893, 'NaN') then
    t_109 = true;
  else
    if temper.str_eq(s__893, 'Infinity') then
      t_108 = true;
    else
      t_108 = temper.str_eq(s__893, '-Infinity');
    end
    t_109 = t_108;
  end
  if t_109 then
    temper.stringbuilder_append(builder__891, 'NULL');
  else
    temper.stringbuilder_append(builder__891, s__893);
  end
  return nil;
end;
SqlFloat64.constructor = function(this__328, value__895)
  this__328.value__889 = value__895;
  return nil;
end;
SqlFloat64.get.value = function(this__1015)
  return this__1015.value__889;
end;
SqlInt32 = temper.type('SqlInt32', SqlPart);
SqlInt32.methods.formatTo = function(this__174, builder__898)
  local t_110;
  t_110 = temper.int32_tostring(this__174.value__896);
  temper.stringbuilder_append(builder__898, t_110);
  return nil;
end;
SqlInt32.constructor = function(this__331, value__901)
  this__331.value__896 = value__901;
  return nil;
end;
SqlInt32.get.value = function(this__1009)
  return this__1009.value__896;
end;
SqlInt64 = temper.type('SqlInt64', SqlPart);
SqlInt64.methods.formatTo = function(this__175, builder__904)
  local t_111;
  t_111 = temper.int64_tostring(this__175.value__902);
  temper.stringbuilder_append(builder__904, t_111);
  return nil;
end;
SqlInt64.constructor = function(this__334, value__907)
  this__334.value__902 = value__907;
  return nil;
end;
SqlInt64.get.value = function(this__1012)
  return this__1012.value__902;
end;
SqlString = temper.type('SqlString', SqlPart);
SqlString.methods.formatTo = function(this__176, builder__910)
  local fn__5775;
  temper.stringbuilder_append(builder__910, "'");
  fn__5775 = function(c__912)
    if (c__912 == 39) then
      temper.stringbuilder_append(builder__910, "''");
    else
      local local_112, local_113, local_114;
      local_112, local_113, local_114 = temper.pcall(function()
        temper.stringbuilder_appendcodepoint(builder__910, c__912);
      end);
      if local_112 then
      else
        temper.bubble();
      end
    end
    return nil;
  end;
  temper.string_foreach(this__176.value__908, fn__5775);
  temper.stringbuilder_append(builder__910, "'");
  return nil;
end;
SqlString.constructor = function(this__337, value__914)
  this__337.value__908 = value__914;
  return nil;
end;
SqlString.get.value = function(this__1006)
  return this__1006.value__908;
end;
changeset = function(tableDef__484, params__485)
  local t_116;
  t_116 = temper.map_constructor(temper.listof());
  return ChangesetImpl__108(tableDef__484, params__485, t_116, temper.listof(), true);
end;
isIdentStart__345 = function(c__743)
  local return__270, t_117, t_118;
  if (c__743 >= 97) then
    t_117 = (c__743 <= 122);
  else
    t_117 = false;
  end
  if t_117 then
    return__270 = true;
  else
    if (c__743 >= 65) then
      t_118 = (c__743 <= 90);
    else
      t_118 = false;
    end
    if t_118 then
      return__270 = true;
    else
      return__270 = (c__743 == 95);
    end
  end
  return return__270;
end;
isIdentPart__346 = function(c__745)
  local return__271;
  if isIdentStart__345(c__745) then
    return__271 = true;
  elseif (c__745 >= 48) then
    return__271 = (c__745 <= 57);
  else
    return__271 = false;
  end
  return return__271;
end;
safeIdentifier = function(name__747)
  local t_119, idx__749, t_120;
  if temper.string_isempty(name__747) then
    temper.bubble();
  end
  idx__749 = 1.0;
  if not isIdentStart__345(temper.string_get(name__747, idx__749)) then
    temper.bubble();
  end
  t_120 = temper.string_next(name__747, idx__749);
  idx__749 = t_120;
  while true do
    if not temper.string_hasindex(name__747, idx__749) then
      break;
    end
    if not isIdentPart__346(temper.string_get(name__747, idx__749)) then
      temper.bubble();
    end
    t_119 = temper.string_next(name__747, idx__749);
    idx__749 = t_119;
  end
  return ValidatedIdentifier__142(name__747);
end;
deleteSql = function(tableDef__574, id__575)
  local b__577;
  b__577 = SqlBuilder();
  b__577:appendSafe('DELETE FROM ');
  b__577:appendSafe(tableDef__574.tableName.sqlValue);
  b__577:appendSafe(' WHERE id = ');
  b__577:appendInt32(id__575);
  return b__577.accumulated;
end;
from = function(tableName__672)
  return Query(tableName__672, temper.listof(), temper.listof(), temper.listof(), temper.null, temper.null, temper.listof());
end;
col = function(table__674, column__675)
  local b__677;
  b__677 = SqlBuilder();
  b__677:appendSafe(table__674.sqlValue);
  b__677:appendSafe('.');
  b__677:appendSafe(column__675.sqlValue);
  return b__677.accumulated;
end;
exports = {};
exports.ChangesetError = ChangesetError;
exports.Changeset = Changeset;
exports.JoinType = JoinType;
exports.InnerJoin = InnerJoin;
exports.LeftJoin = LeftJoin;
exports.RightJoin = RightJoin;
exports.FullJoin = FullJoin;
exports.JoinClause = JoinClause;
exports.OrderClause = OrderClause;
exports.Query = Query;
exports.SafeIdentifier = SafeIdentifier;
exports.FieldType = FieldType;
exports.StringField = StringField;
exports.IntField = IntField;
exports.Int64Field = Int64Field;
exports.FloatField = FloatField;
exports.BoolField = BoolField;
exports.DateField = DateField;
exports.FieldDef = FieldDef;
exports.TableDef = TableDef;
exports.SqlBuilder = SqlBuilder;
exports.SqlFragment = SqlFragment;
exports.SqlPart = SqlPart;
exports.SqlSource = SqlSource;
exports.SqlBoolean = SqlBoolean;
exports.SqlDate = SqlDate;
exports.SqlFloat64 = SqlFloat64;
exports.SqlInt32 = SqlInt32;
exports.SqlInt64 = SqlInt64;
exports.SqlString = SqlString;
exports.changeset = changeset;
exports.safeIdentifier = safeIdentifier;
exports.deleteSql = deleteSql;
exports.from = from;
exports.col = col;
return exports;
