local temper = require('temper-core');
local ChangesetError, Changeset, ChangesetImpl__174, JoinType, InnerJoin, LeftJoin, RightJoin, FullJoin, JoinClause, OrderClause, WhereClause, AndCondition, OrCondition, Query, SetClause, UpdateQuery, DeleteQuery, SafeIdentifier, ValidatedIdentifier__238, FieldType, StringField, IntField, Int64Field, FloatField, BoolField, DateField, FieldDef, TableDef, SqlBuilder, SqlFragment, SqlPart, SqlSource, SqlBoolean, SqlDate, SqlFloat64, SqlInt32, SqlInt64, SqlString, changeset, isIdentStart__506, isIdentPart__507, safeIdentifier, deleteSql, from, col, countAll, countCol, sumCol, avgCol, minCol, maxCol, unionSql, unionAllSql, intersectSql, exceptSql, subquery, existsSql, update, deleteFrom, exports;
ChangesetError = temper.type('ChangesetError');
ChangesetError.constructor = function(this__273, field__513, message__514)
  this__273.field__510 = field__513;
  this__273.message__511 = message__514;
  return nil;
end;
ChangesetError.get.field = function(this__1502)
  return this__1502.field__510;
end;
ChangesetError.get.message = function(this__1505)
  return this__1505.message__511;
end;
Changeset = temper.type('Changeset');
Changeset.get.tableDef = function(this__161)
  temper.virtual();
end;
Changeset.get.changes = function(this__162)
  temper.virtual();
end;
Changeset.get.errors = function(this__163)
  temper.virtual();
end;
Changeset.get.isValid = function(this__164)
  temper.virtual();
end;
Changeset.methods.cast = function(this__165, allowedFields__524)
  temper.virtual();
end;
Changeset.methods.validateRequired = function(this__166, fields__527)
  temper.virtual();
end;
Changeset.methods.validateLength = function(this__167, field__530, min__531, max__532)
  temper.virtual();
end;
Changeset.methods.validateInt = function(this__168, field__535)
  temper.virtual();
end;
Changeset.methods.validateInt64 = function(this__169, field__538)
  temper.virtual();
end;
Changeset.methods.validateFloat = function(this__170, field__541)
  temper.virtual();
end;
Changeset.methods.validateBool = function(this__171, field__544)
  temper.virtual();
end;
Changeset.methods.toInsertSql = function(this__172)
  temper.virtual();
end;
Changeset.methods.toUpdateSql = function(this__173, id__549)
  temper.virtual();
end;
ChangesetImpl__174 = temper.type('ChangesetImpl__174', Changeset);
ChangesetImpl__174.get.tableDef = function(this__175)
  return this__175._tableDef__551;
end;
ChangesetImpl__174.get.changes = function(this__176)
  return this__176._changes__553;
end;
ChangesetImpl__174.get.errors = function(this__177)
  return this__177._errors__554;
end;
ChangesetImpl__174.get.isValid = function(this__178)
  return this__178._isValid__555;
end;
ChangesetImpl__174.methods.cast = function(this__179, allowedFields__565)
  local mb__567, fn__10837;
  mb__567 = temper.mapbuilder_constructor();
  fn__10837 = function(f__568)
    local t_0, t_1, val__569;
    t_1 = f__568.sqlValue;
    val__569 = temper.mapped_getor(this__179._params__552, t_1, '');
    if not temper.string_isempty(val__569) then
      t_0 = f__568.sqlValue;
      temper.mapbuilder_set(mb__567, t_0, val__569);
    end
    return nil;
  end;
  temper.list_foreach(allowedFields__565, fn__10837);
  return ChangesetImpl__174(this__179._tableDef__551, this__179._params__552, temper.mapped_tomap(mb__567), this__179._errors__554, this__179._isValid__555);
end;
ChangesetImpl__174.methods.validateRequired = function(this__180, fields__571)
  local return__306, t_2, t_3, t_4, t_5, eb__573, valid__574, fn__10826;
  ::continue_1::
  if not this__180._isValid__555 then
    return__306 = this__180;
    goto break_0;
  end
  eb__573 = temper.list_tolistbuilder(this__180._errors__554);
  valid__574 = true;
  fn__10826 = function(f__575)
    local t_6, t_7;
    t_7 = f__575.sqlValue;
    if not temper.mapped_has(this__180._changes__553, t_7) then
      t_6 = ChangesetError(f__575.sqlValue, 'is required');
      temper.listbuilder_add(eb__573, t_6);
      valid__574 = false;
    end
    return nil;
  end;
  temper.list_foreach(fields__571, fn__10826);
  t_3 = this__180._tableDef__551;
  t_4 = this__180._params__552;
  t_5 = this__180._changes__553;
  t_2 = temper.listbuilder_tolist(eb__573);
  return__306 = ChangesetImpl__174(t_3, t_4, t_5, t_2, valid__574);
  ::break_0::return return__306;
end;
ChangesetImpl__174.methods.validateLength = function(this__181, field__577, min__578, max__579)
  local return__307, t_8, t_9, t_10, t_11, t_12, t_13, val__581, len__582;
  ::continue_3::
  if not this__181._isValid__555 then
    return__307 = this__181;
    goto break_2;
  end
  t_8 = field__577.sqlValue;
  val__581 = temper.mapped_getor(this__181._changes__553, t_8, '');
  len__582 = temper.string_countbetween(val__581, 1.0, temper.string_end(val__581));
  if (len__582 < min__578) then
    t_10 = true;
  else
    t_10 = (len__582 > max__579);
  end
  if t_10 then
    local msg__583, eb__584;
    msg__583 = temper.concat('must be between ', temper.int32_tostring(min__578), ' and ', temper.int32_tostring(max__579), ' characters');
    eb__584 = temper.list_tolistbuilder(this__181._errors__554);
    temper.listbuilder_add(eb__584, ChangesetError(field__577.sqlValue, msg__583));
    t_11 = this__181._tableDef__551;
    t_12 = this__181._params__552;
    t_13 = this__181._changes__553;
    t_9 = temper.listbuilder_tolist(eb__584);
    return__307 = ChangesetImpl__174(t_11, t_12, t_13, t_9, false);
    goto break_2;
  end
  return__307 = this__181;
  ::break_2::return return__307;
end;
ChangesetImpl__174.methods.validateInt = function(this__182, field__586)
  local return__308, t_14, t_15, t_16, t_17, t_18, val__588, parseOk__589, local_19, local_20, local_21;
  ::continue_5::
  if not this__182._isValid__555 then
    return__308 = this__182;
    goto break_4;
  end
  t_14 = field__586.sqlValue;
  val__588 = temper.mapped_getor(this__182._changes__553, t_14, '');
  if temper.string_isempty(val__588) then
    return__308 = this__182;
    goto break_4;
  end
  local_19, local_20, local_21 = temper.pcall(function()
    temper.string_toint32(val__588);
    parseOk__589 = true;
  end);
  if local_19 then
  else
    parseOk__589 = false;
  end
  if not parseOk__589 then
    local eb__590;
    eb__590 = temper.list_tolistbuilder(this__182._errors__554);
    temper.listbuilder_add(eb__590, ChangesetError(field__586.sqlValue, 'must be an integer'));
    t_16 = this__182._tableDef__551;
    t_17 = this__182._params__552;
    t_18 = this__182._changes__553;
    t_15 = temper.listbuilder_tolist(eb__590);
    return__308 = ChangesetImpl__174(t_16, t_17, t_18, t_15, false);
    goto break_4;
  end
  return__308 = this__182;
  ::break_4::return return__308;
end;
ChangesetImpl__174.methods.validateInt64 = function(this__183, field__592)
  local return__309, t_23, t_24, t_25, t_26, t_27, val__594, parseOk__595, local_28, local_29, local_30;
  ::continue_7::
  if not this__183._isValid__555 then
    return__309 = this__183;
    goto break_6;
  end
  t_23 = field__592.sqlValue;
  val__594 = temper.mapped_getor(this__183._changes__553, t_23, '');
  if temper.string_isempty(val__594) then
    return__309 = this__183;
    goto break_6;
  end
  local_28, local_29, local_30 = temper.pcall(function()
    temper.string_toint64(val__594);
    parseOk__595 = true;
  end);
  if local_28 then
  else
    parseOk__595 = false;
  end
  if not parseOk__595 then
    local eb__596;
    eb__596 = temper.list_tolistbuilder(this__183._errors__554);
    temper.listbuilder_add(eb__596, ChangesetError(field__592.sqlValue, 'must be a 64-bit integer'));
    t_25 = this__183._tableDef__551;
    t_26 = this__183._params__552;
    t_27 = this__183._changes__553;
    t_24 = temper.listbuilder_tolist(eb__596);
    return__309 = ChangesetImpl__174(t_25, t_26, t_27, t_24, false);
    goto break_6;
  end
  return__309 = this__183;
  ::break_6::return return__309;
end;
ChangesetImpl__174.methods.validateFloat = function(this__184, field__598)
  local return__310, t_32, t_33, t_34, t_35, t_36, val__600, parseOk__601, local_37, local_38, local_39;
  ::continue_9::
  if not this__184._isValid__555 then
    return__310 = this__184;
    goto break_8;
  end
  t_32 = field__598.sqlValue;
  val__600 = temper.mapped_getor(this__184._changes__553, t_32, '');
  if temper.string_isempty(val__600) then
    return__310 = this__184;
    goto break_8;
  end
  local_37, local_38, local_39 = temper.pcall(function()
    temper.string_tofloat64(val__600);
    parseOk__601 = true;
  end);
  if local_37 then
  else
    parseOk__601 = false;
  end
  if not parseOk__601 then
    local eb__602;
    eb__602 = temper.list_tolistbuilder(this__184._errors__554);
    temper.listbuilder_add(eb__602, ChangesetError(field__598.sqlValue, 'must be a number'));
    t_34 = this__184._tableDef__551;
    t_35 = this__184._params__552;
    t_36 = this__184._changes__553;
    t_33 = temper.listbuilder_tolist(eb__602);
    return__310 = ChangesetImpl__174(t_34, t_35, t_36, t_33, false);
    goto break_8;
  end
  return__310 = this__184;
  ::break_8::return return__310;
end;
ChangesetImpl__174.methods.validateBool = function(this__185, field__604)
  local return__311, t_41, t_42, t_43, t_44, t_45, t_46, t_47, t_48, t_49, t_50, val__606, isTrue__607, isFalse__608;
  ::continue_11::
  if not this__185._isValid__555 then
    return__311 = this__185;
    goto break_10;
  end
  t_41 = field__604.sqlValue;
  val__606 = temper.mapped_getor(this__185._changes__553, t_41, '');
  if temper.string_isempty(val__606) then
    return__311 = this__185;
    goto break_10;
  end
  if temper.str_eq(val__606, 'true') then
    isTrue__607 = true;
  else
    if temper.str_eq(val__606, '1') then
      t_44 = true;
    else
      if temper.str_eq(val__606, 'yes') then
        t_43 = true;
      else
        t_43 = temper.str_eq(val__606, 'on');
      end
      t_44 = t_43;
    end
    isTrue__607 = t_44;
  end
  if temper.str_eq(val__606, 'false') then
    isFalse__608 = true;
  else
    if temper.str_eq(val__606, '0') then
      t_46 = true;
    else
      if temper.str_eq(val__606, 'no') then
        t_45 = true;
      else
        t_45 = temper.str_eq(val__606, 'off');
      end
      t_46 = t_45;
    end
    isFalse__608 = t_46;
  end
  if not isTrue__607 then
    t_47 = not isFalse__608;
  else
    t_47 = false;
  end
  if t_47 then
    local eb__609;
    eb__609 = temper.list_tolistbuilder(this__185._errors__554);
    temper.listbuilder_add(eb__609, ChangesetError(field__604.sqlValue, 'must be a boolean (true/false/1/0/yes/no/on/off)'));
    t_48 = this__185._tableDef__551;
    t_49 = this__185._params__552;
    t_50 = this__185._changes__553;
    t_42 = temper.listbuilder_tolist(eb__609);
    return__311 = ChangesetImpl__174(t_48, t_49, t_50, t_42, false);
    goto break_10;
  end
  return__311 = this__185;
  ::break_10::return return__311;
end;
ChangesetImpl__174.methods.parseBoolSqlPart = function(this__186, val__611)
  local return__312, t_51, t_52, t_53, t_54, t_55, t_56;
  ::continue_13::
  if temper.str_eq(val__611, 'true') then
    t_53 = true;
  else
    if temper.str_eq(val__611, '1') then
      t_52 = true;
    else
      if temper.str_eq(val__611, 'yes') then
        t_51 = true;
      else
        t_51 = temper.str_eq(val__611, 'on');
      end
      t_52 = t_51;
    end
    t_53 = t_52;
  end
  if t_53 then
    return__312 = SqlBoolean(true);
    goto break_12;
  end
  if temper.str_eq(val__611, 'false') then
    t_56 = true;
  else
    if temper.str_eq(val__611, '0') then
      t_55 = true;
    else
      if temper.str_eq(val__611, 'no') then
        t_54 = true;
      else
        t_54 = temper.str_eq(val__611, 'off');
      end
      t_55 = t_54;
    end
    t_56 = t_55;
  end
  if t_56 then
    return__312 = SqlBoolean(false);
    goto break_12;
  end
  temper.bubble();
  ::break_12::return return__312;
end;
ChangesetImpl__174.methods.valueToSqlPart = function(this__187, fieldDef__614, val__615)
  local return__313, t_57, t_58, t_59, t_60, ft__617;
  ::continue_15::ft__617 = fieldDef__614.fieldType;
  if temper.instance_of(ft__617, StringField) then
    return__313 = SqlString(val__615);
    goto break_14;
  end
  if temper.instance_of(ft__617, IntField) then
    t_57 = temper.string_toint32(val__615);
    return__313 = SqlInt32(t_57);
    goto break_14;
  end
  if temper.instance_of(ft__617, Int64Field) then
    t_58 = temper.string_toint64(val__615);
    return__313 = SqlInt64(t_58);
    goto break_14;
  end
  if temper.instance_of(ft__617, FloatField) then
    t_59 = temper.string_tofloat64(val__615);
    return__313 = SqlFloat64(t_59);
    goto break_14;
  end
  if temper.instance_of(ft__617, BoolField) then
    return__313 = this__187:parseBoolSqlPart(val__615);
    goto break_14;
  end
  if temper.instance_of(ft__617, DateField) then
    t_60 = temper.date_fromisostring(val__615);
    return__313 = SqlDate(t_60);
    goto break_14;
  end
  temper.bubble();
  ::break_14::return return__313;
end;
ChangesetImpl__174.methods.toInsertSql = function(this__188)
  local t_61, t_62, t_63, t_64, t_65, t_66, t_67, t_68, t_69, t_70, i__620, pairs__622, colNames__623, valParts__624, i__625, b__628, t_71, fn__10718, j__630;
  if not this__188._isValid__555 then
    temper.bubble();
  end
  i__620 = 0;
  while true do
    local f__621;
    t_61 = temper.list_length(this__188._tableDef__551.fields);
    if not (i__620 < t_61) then
      break;
    end
    f__621 = temper.list_get(this__188._tableDef__551.fields, i__620);
    if not f__621.nullable then
      t_62 = f__621.name.sqlValue;
      t_63 = temper.mapped_has(this__188._changes__553, t_62);
      t_68 = not t_63;
    else
      t_68 = false;
    end
    if t_68 then
      temper.bubble();
    end
    i__620 = temper.int32_add(i__620, 1);
  end
  pairs__622 = temper.mapped_tolist(this__188._changes__553);
  if (temper.list_length(pairs__622) == 0) then
    temper.bubble();
  end
  colNames__623 = temper.listbuilder_constructor();
  valParts__624 = temper.listbuilder_constructor();
  i__625 = 0;
  while true do
    local pair__626, fd__627;
    t_64 = temper.list_length(pairs__622);
    if not (i__625 < t_64) then
      break;
    end
    pair__626 = temper.list_get(pairs__622, i__625);
    t_65 = pair__626.key;
    t_69 = this__188._tableDef__551:field(t_65);
    fd__627 = t_69;
    temper.listbuilder_add(colNames__623, fd__627.name.sqlValue);
    t_66 = pair__626.value;
    t_70 = this__188:valueToSqlPart(fd__627, t_66);
    temper.listbuilder_add(valParts__624, t_70);
    i__625 = temper.int32_add(i__625, 1);
  end
  b__628 = SqlBuilder();
  b__628:appendSafe('INSERT INTO ');
  b__628:appendSafe(this__188._tableDef__551.tableName.sqlValue);
  b__628:appendSafe(' (');
  t_71 = temper.listbuilder_tolist(colNames__623);
  fn__10718 = function(c__629)
    return c__629;
  end;
  b__628:appendSafe(temper.listed_join(t_71, ', ', fn__10718));
  b__628:appendSafe(') VALUES (');
  b__628:appendPart(temper.listed_get(valParts__624, 0));
  j__630 = 1;
  while true do
    t_67 = temper.listbuilder_length(valParts__624);
    if not (j__630 < t_67) then
      break;
    end
    b__628:appendSafe(', ');
    b__628:appendPart(temper.listed_get(valParts__624, j__630));
    j__630 = temper.int32_add(j__630, 1);
  end
  b__628:appendSafe(')');
  return b__628.accumulated;
end;
ChangesetImpl__174.methods.toUpdateSql = function(this__189, id__632)
  local t_72, t_73, t_74, t_75, t_76, pairs__634, b__635, i__636;
  if not this__189._isValid__555 then
    temper.bubble();
  end
  pairs__634 = temper.mapped_tolist(this__189._changes__553);
  if (temper.list_length(pairs__634) == 0) then
    temper.bubble();
  end
  b__635 = SqlBuilder();
  b__635:appendSafe('UPDATE ');
  b__635:appendSafe(this__189._tableDef__551.tableName.sqlValue);
  b__635:appendSafe(' SET ');
  i__636 = 0;
  while true do
    local pair__637, fd__638;
    t_72 = temper.list_length(pairs__634);
    if not (i__636 < t_72) then
      break;
    end
    if (i__636 > 0) then
      b__635:appendSafe(', ');
    end
    pair__637 = temper.list_get(pairs__634, i__636);
    t_73 = pair__637.key;
    t_75 = this__189._tableDef__551:field(t_73);
    fd__638 = t_75;
    b__635:appendSafe(fd__638.name.sqlValue);
    b__635:appendSafe(' = ');
    t_74 = pair__637.value;
    t_76 = this__189:valueToSqlPart(fd__638, t_74);
    b__635:appendPart(t_76);
    i__636 = temper.int32_add(i__636, 1);
  end
  b__635:appendSafe(' WHERE id = ');
  b__635:appendInt32(id__632);
  return b__635.accumulated;
end;
ChangesetImpl__174.constructor = function(this__296, _tableDef__640, _params__641, _changes__642, _errors__643, _isValid__644)
  this__296._tableDef__551 = _tableDef__640;
  this__296._params__552 = _params__641;
  this__296._changes__553 = _changes__642;
  this__296._errors__554 = _errors__643;
  this__296._isValid__555 = _isValid__644;
  return nil;
end;
JoinType = temper.type('JoinType');
JoinType.methods.keyword = function(this__190)
  temper.virtual();
end;
InnerJoin = temper.type('InnerJoin', JoinType);
InnerJoin.methods.keyword = function(this__191)
  return 'INNER JOIN';
end;
InnerJoin.constructor = function(this__321)
  return nil;
end;
LeftJoin = temper.type('LeftJoin', JoinType);
LeftJoin.methods.keyword = function(this__192)
  return 'LEFT JOIN';
end;
LeftJoin.constructor = function(this__324)
  return nil;
end;
RightJoin = temper.type('RightJoin', JoinType);
RightJoin.methods.keyword = function(this__193)
  return 'RIGHT JOIN';
end;
RightJoin.constructor = function(this__327)
  return nil;
end;
FullJoin = temper.type('FullJoin', JoinType);
FullJoin.methods.keyword = function(this__194)
  return 'FULL OUTER JOIN';
end;
FullJoin.constructor = function(this__330)
  return nil;
end;
JoinClause = temper.type('JoinClause');
JoinClause.constructor = function(this__333, joinType__757, table__758, onCondition__759)
  this__333.joinType__753 = joinType__757;
  this__333.table__754 = table__758;
  this__333.onCondition__755 = onCondition__759;
  return nil;
end;
JoinClause.get.joinType = function(this__1570)
  return this__1570.joinType__753;
end;
JoinClause.get.table = function(this__1573)
  return this__1573.table__754;
end;
JoinClause.get.onCondition = function(this__1576)
  return this__1576.onCondition__755;
end;
OrderClause = temper.type('OrderClause');
OrderClause.constructor = function(this__335, field__763, ascending__764)
  this__335.field__760 = field__763;
  this__335.ascending__761 = ascending__764;
  return nil;
end;
OrderClause.get.field = function(this__1579)
  return this__1579.field__760;
end;
OrderClause.get.ascending = function(this__1582)
  return this__1582.ascending__761;
end;
WhereClause = temper.type('WhereClause');
WhereClause.get.condition = function(this__195)
  temper.virtual();
end;
WhereClause.methods.keyword = function(this__196)
  temper.virtual();
end;
AndCondition = temper.type('AndCondition', WhereClause);
AndCondition.get.condition = function(this__197)
  return this__197._condition__769;
end;
AndCondition.methods.keyword = function(this__198)
  return 'AND';
end;
AndCondition.constructor = function(this__341, _condition__775)
  this__341._condition__769 = _condition__775;
  return nil;
end;
OrCondition = temper.type('OrCondition', WhereClause);
OrCondition.get.condition = function(this__199)
  return this__199._condition__776;
end;
OrCondition.methods.keyword = function(this__200)
  return 'OR';
end;
OrCondition.constructor = function(this__346, _condition__782)
  this__346._condition__776 = _condition__782;
  return nil;
end;
Query = temper.type('Query');
Query.methods.where = function(this__201, condition__795)
  local nb__797;
  nb__797 = temper.list_tolistbuilder(this__201.conditions__784);
  temper.listbuilder_add(nb__797, AndCondition(condition__795));
  return Query(this__201.tableName__783, temper.listbuilder_tolist(nb__797), this__201.selectedFields__785, this__201.orderClauses__786, this__201.limitVal__787, this__201.offsetVal__788, this__201.joinClauses__789, this__201.groupByFields__790, this__201.havingConditions__791, this__201.isDistinct__792, this__201.selectExprs__793);
end;
Query.methods.orWhere = function(this__202, condition__799)
  local nb__801;
  nb__801 = temper.list_tolistbuilder(this__202.conditions__784);
  temper.listbuilder_add(nb__801, OrCondition(condition__799));
  return Query(this__202.tableName__783, temper.listbuilder_tolist(nb__801), this__202.selectedFields__785, this__202.orderClauses__786, this__202.limitVal__787, this__202.offsetVal__788, this__202.joinClauses__789, this__202.groupByFields__790, this__202.havingConditions__791, this__202.isDistinct__792, this__202.selectExprs__793);
end;
Query.methods.whereNull = function(this__203, field__803)
  local b__805, t_77;
  b__805 = SqlBuilder();
  b__805:appendSafe(field__803.sqlValue);
  b__805:appendSafe(' IS NULL');
  t_77 = b__805.accumulated;
  return this__203:where(t_77);
end;
Query.methods.whereNotNull = function(this__204, field__807)
  local b__809, t_78;
  b__809 = SqlBuilder();
  b__809:appendSafe(field__807.sqlValue);
  b__809:appendSafe(' IS NOT NULL');
  t_78 = b__809.accumulated;
  return this__204:where(t_78);
end;
Query.methods.whereIn = function(this__205, field__811, values__812)
  local return__365, t_79, t_80, t_81, b__815, i__816;
  ::continue_17::
  if temper.listed_isempty(values__812) then
    local b__814;
    b__814 = SqlBuilder();
    b__814:appendSafe('1 = 0');
    t_79 = b__814.accumulated;
    return__365 = this__205:where(t_79);
    goto break_16;
  end
  b__815 = SqlBuilder();
  b__815:appendSafe(field__811.sqlValue);
  b__815:appendSafe(' IN (');
  b__815:appendPart(temper.list_get(values__812, 0));
  i__816 = 1;
  while true do
    t_80 = temper.list_length(values__812);
    if not (i__816 < t_80) then
      break;
    end
    b__815:appendSafe(', ');
    b__815:appendPart(temper.list_get(values__812, i__816));
    i__816 = temper.int32_add(i__816, 1);
  end
  b__815:appendSafe(')');
  t_81 = b__815.accumulated;
  return__365 = this__205:where(t_81);
  ::break_16::return return__365;
end;
Query.methods.whereInSubquery = function(this__206, field__818, sub__819)
  local b__821, t_82;
  b__821 = SqlBuilder();
  b__821:appendSafe(field__818.sqlValue);
  b__821:appendSafe(' IN (');
  b__821:appendFragment(sub__819:toSql());
  b__821:appendSafe(')');
  t_82 = b__821.accumulated;
  return this__206:where(t_82);
end;
Query.methods.whereNot = function(this__207, condition__823)
  local b__825, t_83;
  b__825 = SqlBuilder();
  b__825:appendSafe('NOT (');
  b__825:appendFragment(condition__823);
  b__825:appendSafe(')');
  t_83 = b__825.accumulated;
  return this__207:where(t_83);
end;
Query.methods.whereBetween = function(this__208, field__827, low__828, high__829)
  local b__831, t_84;
  b__831 = SqlBuilder();
  b__831:appendSafe(field__827.sqlValue);
  b__831:appendSafe(' BETWEEN ');
  b__831:appendPart(low__828);
  b__831:appendSafe(' AND ');
  b__831:appendPart(high__829);
  t_84 = b__831.accumulated;
  return this__208:where(t_84);
end;
Query.methods.whereLike = function(this__209, field__833, pattern__834)
  local b__836, t_85;
  b__836 = SqlBuilder();
  b__836:appendSafe(field__833.sqlValue);
  b__836:appendSafe(' LIKE ');
  b__836:appendString(pattern__834);
  t_85 = b__836.accumulated;
  return this__209:where(t_85);
end;
Query.methods.whereILike = function(this__210, field__838, pattern__839)
  local b__841, t_86;
  b__841 = SqlBuilder();
  b__841:appendSafe(field__838.sqlValue);
  b__841:appendSafe(' ILIKE ');
  b__841:appendString(pattern__839);
  t_86 = b__841.accumulated;
  return this__210:where(t_86);
end;
Query.methods.select = function(this__211, fields__843)
  return Query(this__211.tableName__783, this__211.conditions__784, fields__843, this__211.orderClauses__786, this__211.limitVal__787, this__211.offsetVal__788, this__211.joinClauses__789, this__211.groupByFields__790, this__211.havingConditions__791, this__211.isDistinct__792, this__211.selectExprs__793);
end;
Query.methods.selectExpr = function(this__212, exprs__846)
  return Query(this__212.tableName__783, this__212.conditions__784, this__212.selectedFields__785, this__212.orderClauses__786, this__212.limitVal__787, this__212.offsetVal__788, this__212.joinClauses__789, this__212.groupByFields__790, this__212.havingConditions__791, this__212.isDistinct__792, exprs__846);
end;
Query.methods.orderBy = function(this__213, field__849, ascending__850)
  local nb__852;
  nb__852 = temper.list_tolistbuilder(this__213.orderClauses__786);
  temper.listbuilder_add(nb__852, OrderClause(field__849, ascending__850));
  return Query(this__213.tableName__783, this__213.conditions__784, this__213.selectedFields__785, temper.listbuilder_tolist(nb__852), this__213.limitVal__787, this__213.offsetVal__788, this__213.joinClauses__789, this__213.groupByFields__790, this__213.havingConditions__791, this__213.isDistinct__792, this__213.selectExprs__793);
end;
Query.methods.limit = function(this__214, n__854)
  if (n__854 < 0) then
    temper.bubble();
  end
  return Query(this__214.tableName__783, this__214.conditions__784, this__214.selectedFields__785, this__214.orderClauses__786, n__854, this__214.offsetVal__788, this__214.joinClauses__789, this__214.groupByFields__790, this__214.havingConditions__791, this__214.isDistinct__792, this__214.selectExprs__793);
end;
Query.methods.offset = function(this__215, n__857)
  if (n__857 < 0) then
    temper.bubble();
  end
  return Query(this__215.tableName__783, this__215.conditions__784, this__215.selectedFields__785, this__215.orderClauses__786, this__215.limitVal__787, n__857, this__215.joinClauses__789, this__215.groupByFields__790, this__215.havingConditions__791, this__215.isDistinct__792, this__215.selectExprs__793);
end;
Query.methods.join = function(this__216, joinType__860, table__861, onCondition__862)
  local nb__864;
  nb__864 = temper.list_tolistbuilder(this__216.joinClauses__789);
  temper.listbuilder_add(nb__864, JoinClause(joinType__860, table__861, onCondition__862));
  return Query(this__216.tableName__783, this__216.conditions__784, this__216.selectedFields__785, this__216.orderClauses__786, this__216.limitVal__787, this__216.offsetVal__788, temper.listbuilder_tolist(nb__864), this__216.groupByFields__790, this__216.havingConditions__791, this__216.isDistinct__792, this__216.selectExprs__793);
end;
Query.methods.innerJoin = function(this__217, table__866, onCondition__867)
  local t_87;
  t_87 = InnerJoin();
  return this__217:join(t_87, table__866, onCondition__867);
end;
Query.methods.leftJoin = function(this__218, table__870, onCondition__871)
  local t_88;
  t_88 = LeftJoin();
  return this__218:join(t_88, table__870, onCondition__871);
end;
Query.methods.rightJoin = function(this__219, table__874, onCondition__875)
  local t_89;
  t_89 = RightJoin();
  return this__219:join(t_89, table__874, onCondition__875);
end;
Query.methods.fullJoin = function(this__220, table__878, onCondition__879)
  local t_90;
  t_90 = FullJoin();
  return this__220:join(t_90, table__878, onCondition__879);
end;
Query.methods.groupBy = function(this__221, field__882)
  local nb__884;
  nb__884 = temper.list_tolistbuilder(this__221.groupByFields__790);
  temper.listbuilder_add(nb__884, field__882);
  return Query(this__221.tableName__783, this__221.conditions__784, this__221.selectedFields__785, this__221.orderClauses__786, this__221.limitVal__787, this__221.offsetVal__788, this__221.joinClauses__789, temper.listbuilder_tolist(nb__884), this__221.havingConditions__791, this__221.isDistinct__792, this__221.selectExprs__793);
end;
Query.methods.having = function(this__222, condition__886)
  local nb__888;
  nb__888 = temper.list_tolistbuilder(this__222.havingConditions__791);
  temper.listbuilder_add(nb__888, AndCondition(condition__886));
  return Query(this__222.tableName__783, this__222.conditions__784, this__222.selectedFields__785, this__222.orderClauses__786, this__222.limitVal__787, this__222.offsetVal__788, this__222.joinClauses__789, this__222.groupByFields__790, temper.listbuilder_tolist(nb__888), this__222.isDistinct__792, this__222.selectExprs__793);
end;
Query.methods.orHaving = function(this__223, condition__890)
  local nb__892;
  nb__892 = temper.list_tolistbuilder(this__223.havingConditions__791);
  temper.listbuilder_add(nb__892, OrCondition(condition__890));
  return Query(this__223.tableName__783, this__223.conditions__784, this__223.selectedFields__785, this__223.orderClauses__786, this__223.limitVal__787, this__223.offsetVal__788, this__223.joinClauses__789, this__223.groupByFields__790, temper.listbuilder_tolist(nb__892), this__223.isDistinct__792, this__223.selectExprs__793);
end;
Query.methods.distinct = function(this__224)
  return Query(this__224.tableName__783, this__224.conditions__784, this__224.selectedFields__785, this__224.orderClauses__786, this__224.limitVal__787, this__224.offsetVal__788, this__224.joinClauses__789, this__224.groupByFields__790, this__224.havingConditions__791, true, this__224.selectExprs__793);
end;
Query.methods.toSql = function(this__225)
  local t_91, t_92, t_93, b__897, fn__10105, lv__906, ov__907;
  b__897 = SqlBuilder();
  if this__225.isDistinct__792 then
    b__897:appendSafe('SELECT DISTINCT ');
  else
    b__897:appendSafe('SELECT ');
  end
  if not temper.listed_isempty(this__225.selectExprs__793) then
    local i__898;
    b__897:appendFragment(temper.list_get(this__225.selectExprs__793, 0));
    i__898 = 1;
    while true do
      t_91 = temper.list_length(this__225.selectExprs__793);
      if not (i__898 < t_91) then
        break;
      end
      b__897:appendSafe(', ');
      b__897:appendFragment(temper.list_get(this__225.selectExprs__793, i__898));
      i__898 = temper.int32_add(i__898, 1);
    end
  elseif temper.listed_isempty(this__225.selectedFields__785) then
    b__897:appendSafe('*');
  else
    local fn__10106;
    fn__10106 = function(f__899)
      return f__899.sqlValue;
    end;
    b__897:appendSafe(temper.listed_join(this__225.selectedFields__785, ', ', fn__10106));
  end
  b__897:appendSafe(' FROM ');
  b__897:appendSafe(this__225.tableName__783.sqlValue);
  fn__10105 = function(jc__900)
    local t_94, t_95, t_96;
    b__897:appendSafe(' ');
    t_94 = jc__900.joinType:keyword();
    b__897:appendSafe(t_94);
    b__897:appendSafe(' ');
    t_95 = jc__900.table.sqlValue;
    b__897:appendSafe(t_95);
    b__897:appendSafe(' ON ');
    t_96 = jc__900.onCondition;
    b__897:appendFragment(t_96);
    return nil;
  end;
  temper.list_foreach(this__225.joinClauses__789, fn__10105);
  if not temper.listed_isempty(this__225.conditions__784) then
    local i__901;
    b__897:appendSafe(' WHERE ');
    b__897:appendFragment((temper.list_get(this__225.conditions__784, 0)).condition);
    i__901 = 1;
    while true do
      t_92 = temper.list_length(this__225.conditions__784);
      if not (i__901 < t_92) then
        break;
      end
      b__897:appendSafe(' ');
      b__897:appendSafe(temper.list_get(this__225.conditions__784, i__901):keyword());
      b__897:appendSafe(' ');
      b__897:appendFragment((temper.list_get(this__225.conditions__784, i__901)).condition);
      i__901 = temper.int32_add(i__901, 1);
    end
  end
  if not temper.listed_isempty(this__225.groupByFields__790) then
    local fn__10104;
    b__897:appendSafe(' GROUP BY ');
    fn__10104 = function(f__902)
      return f__902.sqlValue;
    end;
    b__897:appendSafe(temper.listed_join(this__225.groupByFields__790, ', ', fn__10104));
  end
  if not temper.listed_isempty(this__225.havingConditions__791) then
    local i__903;
    b__897:appendSafe(' HAVING ');
    b__897:appendFragment((temper.list_get(this__225.havingConditions__791, 0)).condition);
    i__903 = 1;
    while true do
      t_93 = temper.list_length(this__225.havingConditions__791);
      if not (i__903 < t_93) then
        break;
      end
      b__897:appendSafe(' ');
      b__897:appendSafe(temper.list_get(this__225.havingConditions__791, i__903):keyword());
      b__897:appendSafe(' ');
      b__897:appendFragment((temper.list_get(this__225.havingConditions__791, i__903)).condition);
      i__903 = temper.int32_add(i__903, 1);
    end
  end
  if not temper.listed_isempty(this__225.orderClauses__786) then
    local first__904, fn__10103;
    b__897:appendSafe(' ORDER BY ');
    first__904 = true;
    fn__10103 = function(oc__905)
      local t_97, t_98;
      if not first__904 then
        b__897:appendSafe(', ');
      end
      first__904 = false;
      t_98 = oc__905.field.sqlValue;
      b__897:appendSafe(t_98);
      if oc__905.ascending then
        t_97 = ' ASC';
      else
        t_97 = ' DESC';
      end
      b__897:appendSafe(t_97);
      return nil;
    end;
    temper.list_foreach(this__225.orderClauses__786, fn__10103);
  end
  lv__906 = this__225.limitVal__787;
  if not temper.is_null(lv__906) then
    local lv_99;
    lv_99 = lv__906;
    b__897:appendSafe(' LIMIT ');
    b__897:appendInt32(lv_99);
  end
  ov__907 = this__225.offsetVal__788;
  if not temper.is_null(ov__907) then
    local ov_100;
    ov_100 = ov__907;
    b__897:appendSafe(' OFFSET ');
    b__897:appendInt32(ov_100);
  end
  return b__897.accumulated;
end;
Query.methods.countSql = function(this__226)
  local t_101, t_102, b__910, fn__10043;
  b__910 = SqlBuilder();
  b__910:appendSafe('SELECT COUNT(*) FROM ');
  b__910:appendSafe(this__226.tableName__783.sqlValue);
  fn__10043 = function(jc__911)
    local t_103, t_104, t_105;
    b__910:appendSafe(' ');
    t_103 = jc__911.joinType:keyword();
    b__910:appendSafe(t_103);
    b__910:appendSafe(' ');
    t_104 = jc__911.table.sqlValue;
    b__910:appendSafe(t_104);
    b__910:appendSafe(' ON ');
    t_105 = jc__911.onCondition;
    b__910:appendFragment(t_105);
    return nil;
  end;
  temper.list_foreach(this__226.joinClauses__789, fn__10043);
  if not temper.listed_isempty(this__226.conditions__784) then
    local i__912;
    b__910:appendSafe(' WHERE ');
    b__910:appendFragment((temper.list_get(this__226.conditions__784, 0)).condition);
    i__912 = 1;
    while true do
      t_101 = temper.list_length(this__226.conditions__784);
      if not (i__912 < t_101) then
        break;
      end
      b__910:appendSafe(' ');
      b__910:appendSafe(temper.list_get(this__226.conditions__784, i__912):keyword());
      b__910:appendSafe(' ');
      b__910:appendFragment((temper.list_get(this__226.conditions__784, i__912)).condition);
      i__912 = temper.int32_add(i__912, 1);
    end
  end
  if not temper.listed_isempty(this__226.groupByFields__790) then
    local fn__10042;
    b__910:appendSafe(' GROUP BY ');
    fn__10042 = function(f__913)
      return f__913.sqlValue;
    end;
    b__910:appendSafe(temper.listed_join(this__226.groupByFields__790, ', ', fn__10042));
  end
  if not temper.listed_isempty(this__226.havingConditions__791) then
    local i__914;
    b__910:appendSafe(' HAVING ');
    b__910:appendFragment((temper.list_get(this__226.havingConditions__791, 0)).condition);
    i__914 = 1;
    while true do
      t_102 = temper.list_length(this__226.havingConditions__791);
      if not (i__914 < t_102) then
        break;
      end
      b__910:appendSafe(' ');
      b__910:appendSafe(temper.list_get(this__226.havingConditions__791, i__914):keyword());
      b__910:appendSafe(' ');
      b__910:appendFragment((temper.list_get(this__226.havingConditions__791, i__914)).condition);
      i__914 = temper.int32_add(i__914, 1);
    end
  end
  return b__910.accumulated;
end;
Query.methods.safeToSql = function(this__227, defaultLimit__916)
  local return__387, t_106;
  if (defaultLimit__916 < 0) then
    temper.bubble();
  end
  if not temper.is_null(this__227.limitVal__787) then
    return__387 = this__227:toSql();
  else
    t_106 = this__227:limit(defaultLimit__916);
    return__387 = t_106:toSql();
  end
  return return__387;
end;
Query.constructor = function(this__350, tableName__919, conditions__920, selectedFields__921, orderClauses__922, limitVal__923, offsetVal__924, joinClauses__925, groupByFields__926, havingConditions__927, isDistinct__928, selectExprs__929)
  if (limitVal__923 == nil) then
    limitVal__923 = temper.null;
  end
  if (offsetVal__924 == nil) then
    offsetVal__924 = temper.null;
  end
  this__350.tableName__783 = tableName__919;
  this__350.conditions__784 = conditions__920;
  this__350.selectedFields__785 = selectedFields__921;
  this__350.orderClauses__786 = orderClauses__922;
  this__350.limitVal__787 = limitVal__923;
  this__350.offsetVal__788 = offsetVal__924;
  this__350.joinClauses__789 = joinClauses__925;
  this__350.groupByFields__790 = groupByFields__926;
  this__350.havingConditions__791 = havingConditions__927;
  this__350.isDistinct__792 = isDistinct__928;
  this__350.selectExprs__793 = selectExprs__929;
  return nil;
end;
Query.get.tableName = function(this__1585)
  return this__1585.tableName__783;
end;
Query.get.conditions = function(this__1588)
  return this__1588.conditions__784;
end;
Query.get.selectedFields = function(this__1591)
  return this__1591.selectedFields__785;
end;
Query.get.orderClauses = function(this__1594)
  return this__1594.orderClauses__786;
end;
Query.get.limitVal = function(this__1597)
  return this__1597.limitVal__787;
end;
Query.get.offsetVal = function(this__1600)
  return this__1600.offsetVal__788;
end;
Query.get.joinClauses = function(this__1603)
  return this__1603.joinClauses__789;
end;
Query.get.groupByFields = function(this__1606)
  return this__1606.groupByFields__790;
end;
Query.get.havingConditions = function(this__1609)
  return this__1609.havingConditions__791;
end;
Query.get.isDistinct = function(this__1612)
  return this__1612.isDistinct__792;
end;
Query.get.selectExprs = function(this__1615)
  return this__1615.selectExprs__793;
end;
SetClause = temper.type('SetClause');
SetClause.constructor = function(this__402, field__979, value__980)
  this__402.field__976 = field__979;
  this__402.value__977 = value__980;
  return nil;
end;
SetClause.get.field = function(this__1618)
  return this__1618.field__976;
end;
SetClause.get.value = function(this__1621)
  return this__1621.value__977;
end;
UpdateQuery = temper.type('UpdateQuery');
UpdateQuery.methods.set = function(this__228, field__986, value__987)
  local nb__989;
  nb__989 = temper.list_tolistbuilder(this__228.setClauses__982);
  temper.listbuilder_add(nb__989, SetClause(field__986, value__987));
  return UpdateQuery(this__228.tableName__981, temper.listbuilder_tolist(nb__989), this__228.conditions__983, this__228.limitVal__984);
end;
UpdateQuery.methods.where = function(this__229, condition__991)
  local nb__993;
  nb__993 = temper.list_tolistbuilder(this__229.conditions__983);
  temper.listbuilder_add(nb__993, AndCondition(condition__991));
  return UpdateQuery(this__229.tableName__981, this__229.setClauses__982, temper.listbuilder_tolist(nb__993), this__229.limitVal__984);
end;
UpdateQuery.methods.orWhere = function(this__230, condition__995)
  local nb__997;
  nb__997 = temper.list_tolistbuilder(this__230.conditions__983);
  temper.listbuilder_add(nb__997, OrCondition(condition__995));
  return UpdateQuery(this__230.tableName__981, this__230.setClauses__982, temper.listbuilder_tolist(nb__997), this__230.limitVal__984);
end;
UpdateQuery.methods.limit = function(this__231, n__999)
  if (n__999 < 0) then
    temper.bubble();
  end
  return UpdateQuery(this__231.tableName__981, this__231.setClauses__982, this__231.conditions__983, n__999);
end;
UpdateQuery.methods.toSql = function(this__232)
  local t_107, t_108, b__1003, i__1004, i__1005, lv__1006;
  if temper.listed_isempty(this__232.conditions__983) then
    temper.bubble();
  end
  if temper.listed_isempty(this__232.setClauses__982) then
    temper.bubble();
  end
  b__1003 = SqlBuilder();
  b__1003:appendSafe('UPDATE ');
  b__1003:appendSafe(this__232.tableName__981.sqlValue);
  b__1003:appendSafe(' SET ');
  b__1003:appendSafe((temper.list_get(this__232.setClauses__982, 0)).field.sqlValue);
  b__1003:appendSafe(' = ');
  b__1003:appendPart((temper.list_get(this__232.setClauses__982, 0)).value);
  i__1004 = 1;
  while true do
    t_107 = temper.list_length(this__232.setClauses__982);
    if not (i__1004 < t_107) then
      break;
    end
    b__1003:appendSafe(', ');
    b__1003:appendSafe((temper.list_get(this__232.setClauses__982, i__1004)).field.sqlValue);
    b__1003:appendSafe(' = ');
    b__1003:appendPart((temper.list_get(this__232.setClauses__982, i__1004)).value);
    i__1004 = temper.int32_add(i__1004, 1);
  end
  b__1003:appendSafe(' WHERE ');
  b__1003:appendFragment((temper.list_get(this__232.conditions__983, 0)).condition);
  i__1005 = 1;
  while true do
    t_108 = temper.list_length(this__232.conditions__983);
    if not (i__1005 < t_108) then
      break;
    end
    b__1003:appendSafe(' ');
    b__1003:appendSafe(temper.list_get(this__232.conditions__983, i__1005):keyword());
    b__1003:appendSafe(' ');
    b__1003:appendFragment((temper.list_get(this__232.conditions__983, i__1005)).condition);
    i__1005 = temper.int32_add(i__1005, 1);
  end
  lv__1006 = this__232.limitVal__984;
  if not temper.is_null(lv__1006) then
    local lv_109;
    lv_109 = lv__1006;
    b__1003:appendSafe(' LIMIT ');
    b__1003:appendInt32(lv_109);
  end
  return b__1003.accumulated;
end;
UpdateQuery.constructor = function(this__404, tableName__1008, setClauses__1009, conditions__1010, limitVal__1011)
  if (limitVal__1011 == nil) then
    limitVal__1011 = temper.null;
  end
  this__404.tableName__981 = tableName__1008;
  this__404.setClauses__982 = setClauses__1009;
  this__404.conditions__983 = conditions__1010;
  this__404.limitVal__984 = limitVal__1011;
  return nil;
end;
UpdateQuery.get.tableName = function(this__1624)
  return this__1624.tableName__981;
end;
UpdateQuery.get.setClauses = function(this__1627)
  return this__1627.setClauses__982;
end;
UpdateQuery.get.conditions = function(this__1630)
  return this__1630.conditions__983;
end;
UpdateQuery.get.limitVal = function(this__1633)
  return this__1633.limitVal__984;
end;
DeleteQuery = temper.type('DeleteQuery');
DeleteQuery.methods.where = function(this__233, condition__1016)
  local nb__1018;
  nb__1018 = temper.list_tolistbuilder(this__233.conditions__1013);
  temper.listbuilder_add(nb__1018, AndCondition(condition__1016));
  return DeleteQuery(this__233.tableName__1012, temper.listbuilder_tolist(nb__1018), this__233.limitVal__1014);
end;
DeleteQuery.methods.orWhere = function(this__234, condition__1020)
  local nb__1022;
  nb__1022 = temper.list_tolistbuilder(this__234.conditions__1013);
  temper.listbuilder_add(nb__1022, OrCondition(condition__1020));
  return DeleteQuery(this__234.tableName__1012, temper.listbuilder_tolist(nb__1022), this__234.limitVal__1014);
end;
DeleteQuery.methods.limit = function(this__235, n__1024)
  if (n__1024 < 0) then
    temper.bubble();
  end
  return DeleteQuery(this__235.tableName__1012, this__235.conditions__1013, n__1024);
end;
DeleteQuery.methods.toSql = function(this__236)
  local t_110, b__1028, i__1029, lv__1030;
  if temper.listed_isempty(this__236.conditions__1013) then
    temper.bubble();
  end
  b__1028 = SqlBuilder();
  b__1028:appendSafe('DELETE FROM ');
  b__1028:appendSafe(this__236.tableName__1012.sqlValue);
  b__1028:appendSafe(' WHERE ');
  b__1028:appendFragment((temper.list_get(this__236.conditions__1013, 0)).condition);
  i__1029 = 1;
  while true do
    t_110 = temper.list_length(this__236.conditions__1013);
    if not (i__1029 < t_110) then
      break;
    end
    b__1028:appendSafe(' ');
    b__1028:appendSafe(temper.list_get(this__236.conditions__1013, i__1029):keyword());
    b__1028:appendSafe(' ');
    b__1028:appendFragment((temper.list_get(this__236.conditions__1013, i__1029)).condition);
    i__1029 = temper.int32_add(i__1029, 1);
  end
  lv__1030 = this__236.limitVal__1014;
  if not temper.is_null(lv__1030) then
    local lv_111;
    lv_111 = lv__1030;
    b__1028:appendSafe(' LIMIT ');
    b__1028:appendInt32(lv_111);
  end
  return b__1028.accumulated;
end;
DeleteQuery.constructor = function(this__414, tableName__1032, conditions__1033, limitVal__1034)
  if (limitVal__1034 == nil) then
    limitVal__1034 = temper.null;
  end
  this__414.tableName__1012 = tableName__1032;
  this__414.conditions__1013 = conditions__1033;
  this__414.limitVal__1014 = limitVal__1034;
  return nil;
end;
DeleteQuery.get.tableName = function(this__1636)
  return this__1636.tableName__1012;
end;
DeleteQuery.get.conditions = function(this__1639)
  return this__1639.conditions__1013;
end;
DeleteQuery.get.limitVal = function(this__1642)
  return this__1642.limitVal__1014;
end;
SafeIdentifier = temper.type('SafeIdentifier');
SafeIdentifier.get.sqlValue = function(this__237)
  temper.virtual();
end;
ValidatedIdentifier__238 = temper.type('ValidatedIdentifier__238', SafeIdentifier);
ValidatedIdentifier__238.get.sqlValue = function(this__239)
  return this__239._value__1249;
end;
ValidatedIdentifier__238.constructor = function(this__428, _value__1253)
  this__428._value__1249 = _value__1253;
  return nil;
end;
FieldType = temper.type('FieldType');
StringField = temper.type('StringField', FieldType);
StringField.constructor = function(this__434)
  return nil;
end;
IntField = temper.type('IntField', FieldType);
IntField.constructor = function(this__436)
  return nil;
end;
Int64Field = temper.type('Int64Field', FieldType);
Int64Field.constructor = function(this__438)
  return nil;
end;
FloatField = temper.type('FloatField', FieldType);
FloatField.constructor = function(this__440)
  return nil;
end;
BoolField = temper.type('BoolField', FieldType);
BoolField.constructor = function(this__442)
  return nil;
end;
DateField = temper.type('DateField', FieldType);
DateField.constructor = function(this__444)
  return nil;
end;
FieldDef = temper.type('FieldDef');
FieldDef.constructor = function(this__446, name__1271, fieldType__1272, nullable__1273)
  this__446.name__1267 = name__1271;
  this__446.fieldType__1268 = fieldType__1272;
  this__446.nullable__1269 = nullable__1273;
  return nil;
end;
FieldDef.get.name = function(this__1508)
  return this__1508.name__1267;
end;
FieldDef.get.fieldType = function(this__1511)
  return this__1511.fieldType__1268;
end;
FieldDef.get.nullable = function(this__1514)
  return this__1514.nullable__1269;
end;
TableDef = temper.type('TableDef');
TableDef.methods.field = function(this__240, name__1277)
  local return__451, this__6482, n__6483, i__6484;
  ::continue_19::this__6482 = this__240.fields__1275;
  n__6483 = temper.list_length(this__6482);
  i__6484 = 0;
  while (i__6484 < n__6483) do
    local el__6485, f__1279;
    el__6485 = temper.list_get(this__6482, i__6484);
    i__6484 = temper.int32_add(i__6484, 1);
    f__1279 = el__6485;
    if temper.str_eq(f__1279.name.sqlValue, name__1277) then
      return__451 = f__1279;
      goto break_18;
    end
  end
  temper.bubble();
  ::break_18::return return__451;
end;
TableDef.constructor = function(this__448, tableName__1281, fields__1282)
  this__448.tableName__1274 = tableName__1281;
  this__448.fields__1275 = fields__1282;
  return nil;
end;
TableDef.get.tableName = function(this__1517)
  return this__1517.tableName__1274;
end;
TableDef.get.fields = function(this__1520)
  return this__1520.fields__1275;
end;
SqlBuilder = temper.type('SqlBuilder');
SqlBuilder.methods.appendSafe = function(this__241, sqlSource__1304)
  local t_112;
  t_112 = SqlSource(sqlSource__1304);
  temper.listbuilder_add(this__241.buffer__1302, t_112);
  return nil;
end;
SqlBuilder.methods.appendFragment = function(this__242, fragment__1307)
  local t_113;
  t_113 = fragment__1307.parts;
  temper.listbuilder_addall(this__242.buffer__1302, t_113);
  return nil;
end;
SqlBuilder.methods.appendPart = function(this__243, part__1310)
  temper.listbuilder_add(this__243.buffer__1302, part__1310);
  return nil;
end;
SqlBuilder.methods.appendPartList = function(this__244, values__1313)
  local fn__10889;
  fn__10889 = function(x__1315)
    this__244:appendPart(x__1315);
    return nil;
  end;
  this__244:appendList(values__1313, fn__10889);
  return nil;
end;
SqlBuilder.methods.appendBoolean = function(this__245, value__1317)
  local t_114;
  t_114 = SqlBoolean(value__1317);
  temper.listbuilder_add(this__245.buffer__1302, t_114);
  return nil;
end;
SqlBuilder.methods.appendBooleanList = function(this__246, values__1320)
  local fn__10883;
  fn__10883 = function(x__1322)
    this__246:appendBoolean(x__1322);
    return nil;
  end;
  this__246:appendList(values__1320, fn__10883);
  return nil;
end;
SqlBuilder.methods.appendDate = function(this__247, value__1324)
  local t_115;
  t_115 = SqlDate(value__1324);
  temper.listbuilder_add(this__247.buffer__1302, t_115);
  return nil;
end;
SqlBuilder.methods.appendDateList = function(this__248, values__1327)
  local fn__10877;
  fn__10877 = function(x__1329)
    this__248:appendDate(x__1329);
    return nil;
  end;
  this__248:appendList(values__1327, fn__10877);
  return nil;
end;
SqlBuilder.methods.appendFloat64 = function(this__249, value__1331)
  local t_116;
  t_116 = SqlFloat64(value__1331);
  temper.listbuilder_add(this__249.buffer__1302, t_116);
  return nil;
end;
SqlBuilder.methods.appendFloat64List = function(this__250, values__1334)
  local fn__10871;
  fn__10871 = function(x__1336)
    this__250:appendFloat64(x__1336);
    return nil;
  end;
  this__250:appendList(values__1334, fn__10871);
  return nil;
end;
SqlBuilder.methods.appendInt32 = function(this__251, value__1338)
  local t_117;
  t_117 = SqlInt32(value__1338);
  temper.listbuilder_add(this__251.buffer__1302, t_117);
  return nil;
end;
SqlBuilder.methods.appendInt32List = function(this__252, values__1341)
  local fn__10865;
  fn__10865 = function(x__1343)
    this__252:appendInt32(x__1343);
    return nil;
  end;
  this__252:appendList(values__1341, fn__10865);
  return nil;
end;
SqlBuilder.methods.appendInt64 = function(this__253, value__1345)
  local t_118;
  t_118 = SqlInt64(value__1345);
  temper.listbuilder_add(this__253.buffer__1302, t_118);
  return nil;
end;
SqlBuilder.methods.appendInt64List = function(this__254, values__1348)
  local fn__10859;
  fn__10859 = function(x__1350)
    this__254:appendInt64(x__1350);
    return nil;
  end;
  this__254:appendList(values__1348, fn__10859);
  return nil;
end;
SqlBuilder.methods.appendString = function(this__255, value__1352)
  local t_119;
  t_119 = SqlString(value__1352);
  temper.listbuilder_add(this__255.buffer__1302, t_119);
  return nil;
end;
SqlBuilder.methods.appendStringList = function(this__256, values__1355)
  local fn__10853;
  fn__10853 = function(x__1357)
    this__256:appendString(x__1357);
    return nil;
  end;
  this__256:appendList(values__1355, fn__10853);
  return nil;
end;
SqlBuilder.methods.appendList = function(this__257, values__1359, appendValue__1360)
  local t_120, t_121, i__1362;
  i__1362 = 0;
  while true do
    t_120 = temper.listed_length(values__1359);
    if not (i__1362 < t_120) then
      break;
    end
    if (i__1362 > 0) then
      this__257:appendSafe(', ');
    end
    t_121 = temper.listed_get(values__1359, i__1362);
    appendValue__1360(t_121);
    i__1362 = temper.int32_add(i__1362, 1);
  end
  return nil;
end;
SqlBuilder.get.accumulated = function(this__258)
  return SqlFragment(temper.listbuilder_tolist(this__258.buffer__1302));
end;
SqlBuilder.constructor = function(this__453)
  local t_122;
  t_122 = temper.listbuilder_constructor();
  this__453.buffer__1302 = t_122;
  return nil;
end;
SqlFragment = temper.type('SqlFragment');
SqlFragment.methods.toSource = function(this__263)
  return SqlSource(this__263:toString());
end;
SqlFragment.methods.toString = function(this__264)
  local t_123, builder__1374, i__1375;
  builder__1374 = temper.stringbuilder_constructor();
  i__1375 = 0;
  while true do
    t_123 = temper.list_length(this__264.parts__1369);
    if not (i__1375 < t_123) then
      break;
    end
    temper.list_get(this__264.parts__1369, i__1375):formatTo(builder__1374);
    i__1375 = temper.int32_add(i__1375, 1);
  end
  return temper.stringbuilder_tostring(builder__1374);
end;
SqlFragment.constructor = function(this__474, parts__1377)
  this__474.parts__1369 = parts__1377;
  return nil;
end;
SqlFragment.get.parts = function(this__1526)
  return this__1526.parts__1369;
end;
SqlPart = temper.type('SqlPart');
SqlPart.methods.formatTo = function(this__265, builder__1379)
  temper.virtual();
end;
SqlSource = temper.type('SqlSource', SqlPart);
SqlSource.methods.formatTo = function(this__266, builder__1383)
  temper.stringbuilder_append(builder__1383, this__266.source__1381);
  return nil;
end;
SqlSource.constructor = function(this__480, source__1386)
  this__480.source__1381 = source__1386;
  return nil;
end;
SqlSource.get.source = function(this__1523)
  return this__1523.source__1381;
end;
SqlBoolean = temper.type('SqlBoolean', SqlPart);
SqlBoolean.methods.formatTo = function(this__267, builder__1389)
  local t_124;
  if this__267.value__1387 then
    t_124 = 'TRUE';
  else
    t_124 = 'FALSE';
  end
  temper.stringbuilder_append(builder__1389, t_124);
  return nil;
end;
SqlBoolean.constructor = function(this__483, value__1392)
  this__483.value__1387 = value__1392;
  return nil;
end;
SqlBoolean.get.value = function(this__1529)
  return this__1529.value__1387;
end;
SqlDate = temper.type('SqlDate', SqlPart);
SqlDate.methods.formatTo = function(this__268, builder__1395)
  local t_125, fn__10898;
  temper.stringbuilder_append(builder__1395, "'");
  t_125 = temper.date_tostring(this__268.value__1393);
  fn__10898 = function(c__1397)
    if (c__1397 == 39) then
      temper.stringbuilder_append(builder__1395, "''");
    else
      local local_126, local_127, local_128;
      local_126, local_127, local_128 = temper.pcall(function()
        temper.stringbuilder_appendcodepoint(builder__1395, c__1397);
      end);
      if local_126 then
      else
        temper.bubble();
      end
    end
    return nil;
  end;
  temper.string_foreach(t_125, fn__10898);
  temper.stringbuilder_append(builder__1395, "'");
  return nil;
end;
SqlDate.constructor = function(this__486, value__1399)
  this__486.value__1393 = value__1399;
  return nil;
end;
SqlDate.get.value = function(this__1544)
  return this__1544.value__1393;
end;
SqlFloat64 = temper.type('SqlFloat64', SqlPart);
SqlFloat64.methods.formatTo = function(this__269, builder__1402)
  local t_130, t_131, s__1404;
  s__1404 = temper.float64_tostring(this__269.value__1400);
  if temper.str_eq(s__1404, 'NaN') then
    t_131 = true;
  else
    if temper.str_eq(s__1404, 'Infinity') then
      t_130 = true;
    else
      t_130 = temper.str_eq(s__1404, '-Infinity');
    end
    t_131 = t_130;
  end
  if t_131 then
    temper.stringbuilder_append(builder__1402, 'NULL');
  else
    temper.stringbuilder_append(builder__1402, s__1404);
  end
  return nil;
end;
SqlFloat64.constructor = function(this__489, value__1406)
  this__489.value__1400 = value__1406;
  return nil;
end;
SqlFloat64.get.value = function(this__1541)
  return this__1541.value__1400;
end;
SqlInt32 = temper.type('SqlInt32', SqlPart);
SqlInt32.methods.formatTo = function(this__270, builder__1409)
  local t_132;
  t_132 = temper.int32_tostring(this__270.value__1407);
  temper.stringbuilder_append(builder__1409, t_132);
  return nil;
end;
SqlInt32.constructor = function(this__492, value__1412)
  this__492.value__1407 = value__1412;
  return nil;
end;
SqlInt32.get.value = function(this__1535)
  return this__1535.value__1407;
end;
SqlInt64 = temper.type('SqlInt64', SqlPart);
SqlInt64.methods.formatTo = function(this__271, builder__1415)
  local t_133;
  t_133 = temper.int64_tostring(this__271.value__1413);
  temper.stringbuilder_append(builder__1415, t_133);
  return nil;
end;
SqlInt64.constructor = function(this__495, value__1418)
  this__495.value__1413 = value__1418;
  return nil;
end;
SqlInt64.get.value = function(this__1538)
  return this__1538.value__1413;
end;
SqlString = temper.type('SqlString', SqlPart);
SqlString.methods.formatTo = function(this__272, builder__1421)
  local fn__10912;
  temper.stringbuilder_append(builder__1421, "'");
  fn__10912 = function(c__1423)
    if (c__1423 == 39) then
      temper.stringbuilder_append(builder__1421, "''");
    else
      local local_134, local_135, local_136;
      local_134, local_135, local_136 = temper.pcall(function()
        temper.stringbuilder_appendcodepoint(builder__1421, c__1423);
      end);
      if local_134 then
      else
        temper.bubble();
      end
    end
    return nil;
  end;
  temper.string_foreach(this__272.value__1419, fn__10912);
  temper.stringbuilder_append(builder__1421, "'");
  return nil;
end;
SqlString.constructor = function(this__498, value__1425)
  this__498.value__1419 = value__1425;
  return nil;
end;
SqlString.get.value = function(this__1532)
  return this__1532.value__1419;
end;
changeset = function(tableDef__645, params__646)
  local t_138;
  t_138 = temper.map_constructor(temper.listof());
  return ChangesetImpl__174(tableDef__645, params__646, t_138, temper.listof(), true);
end;
isIdentStart__506 = function(c__1254)
  local return__431, t_139, t_140;
  if (c__1254 >= 97) then
    t_139 = (c__1254 <= 122);
  else
    t_139 = false;
  end
  if t_139 then
    return__431 = true;
  else
    if (c__1254 >= 65) then
      t_140 = (c__1254 <= 90);
    else
      t_140 = false;
    end
    if t_140 then
      return__431 = true;
    else
      return__431 = (c__1254 == 95);
    end
  end
  return return__431;
end;
isIdentPart__507 = function(c__1256)
  local return__432;
  if isIdentStart__506(c__1256) then
    return__432 = true;
  elseif (c__1256 >= 48) then
    return__432 = (c__1256 <= 57);
  else
    return__432 = false;
  end
  return return__432;
end;
safeIdentifier = function(name__1258)
  local t_141, idx__1260, t_142;
  if temper.string_isempty(name__1258) then
    temper.bubble();
  end
  idx__1260 = 1.0;
  if not isIdentStart__506(temper.string_get(name__1258, idx__1260)) then
    temper.bubble();
  end
  t_142 = temper.string_next(name__1258, idx__1260);
  idx__1260 = t_142;
  while true do
    if not temper.string_hasindex(name__1258, idx__1260) then
      break;
    end
    if not isIdentPart__507(temper.string_get(name__1258, idx__1260)) then
      temper.bubble();
    end
    t_141 = temper.string_next(name__1258, idx__1260);
    idx__1260 = t_141;
  end
  return ValidatedIdentifier__238(name__1258);
end;
deleteSql = function(tableDef__735, id__736)
  local b__738;
  b__738 = SqlBuilder();
  b__738:appendSafe('DELETE FROM ');
  b__738:appendSafe(tableDef__735.tableName.sqlValue);
  b__738:appendSafe(' WHERE id = ');
  b__738:appendInt32(id__736);
  return b__738.accumulated;
end;
from = function(tableName__930)
  return Query(tableName__930, temper.listof(), temper.listof(), temper.listof(), temper.null, temper.null, temper.listof(), temper.listof(), temper.listof(), false, temper.listof());
end;
col = function(table__932, column__933)
  local b__935;
  b__935 = SqlBuilder();
  b__935:appendSafe(table__932.sqlValue);
  b__935:appendSafe('.');
  b__935:appendSafe(column__933.sqlValue);
  return b__935.accumulated;
end;
countAll = function()
  local b__937;
  b__937 = SqlBuilder();
  b__937:appendSafe('COUNT(*)');
  return b__937.accumulated;
end;
countCol = function(field__938)
  local b__940;
  b__940 = SqlBuilder();
  b__940:appendSafe('COUNT(');
  b__940:appendSafe(field__938.sqlValue);
  b__940:appendSafe(')');
  return b__940.accumulated;
end;
sumCol = function(field__941)
  local b__943;
  b__943 = SqlBuilder();
  b__943:appendSafe('SUM(');
  b__943:appendSafe(field__941.sqlValue);
  b__943:appendSafe(')');
  return b__943.accumulated;
end;
avgCol = function(field__944)
  local b__946;
  b__946 = SqlBuilder();
  b__946:appendSafe('AVG(');
  b__946:appendSafe(field__944.sqlValue);
  b__946:appendSafe(')');
  return b__946.accumulated;
end;
minCol = function(field__947)
  local b__949;
  b__949 = SqlBuilder();
  b__949:appendSafe('MIN(');
  b__949:appendSafe(field__947.sqlValue);
  b__949:appendSafe(')');
  return b__949.accumulated;
end;
maxCol = function(field__950)
  local b__952;
  b__952 = SqlBuilder();
  b__952:appendSafe('MAX(');
  b__952:appendSafe(field__950.sqlValue);
  b__952:appendSafe(')');
  return b__952.accumulated;
end;
unionSql = function(a__953, b__954)
  local sb__956;
  sb__956 = SqlBuilder();
  sb__956:appendSafe('(');
  sb__956:appendFragment(a__953:toSql());
  sb__956:appendSafe(') UNION (');
  sb__956:appendFragment(b__954:toSql());
  sb__956:appendSafe(')');
  return sb__956.accumulated;
end;
unionAllSql = function(a__957, b__958)
  local sb__960;
  sb__960 = SqlBuilder();
  sb__960:appendSafe('(');
  sb__960:appendFragment(a__957:toSql());
  sb__960:appendSafe(') UNION ALL (');
  sb__960:appendFragment(b__958:toSql());
  sb__960:appendSafe(')');
  return sb__960.accumulated;
end;
intersectSql = function(a__961, b__962)
  local sb__964;
  sb__964 = SqlBuilder();
  sb__964:appendSafe('(');
  sb__964:appendFragment(a__961:toSql());
  sb__964:appendSafe(') INTERSECT (');
  sb__964:appendFragment(b__962:toSql());
  sb__964:appendSafe(')');
  return sb__964.accumulated;
end;
exceptSql = function(a__965, b__966)
  local sb__968;
  sb__968 = SqlBuilder();
  sb__968:appendSafe('(');
  sb__968:appendFragment(a__965:toSql());
  sb__968:appendSafe(') EXCEPT (');
  sb__968:appendFragment(b__966:toSql());
  sb__968:appendSafe(')');
  return sb__968.accumulated;
end;
subquery = function(q__969, alias__970)
  local b__972;
  b__972 = SqlBuilder();
  b__972:appendSafe('(');
  b__972:appendFragment(q__969:toSql());
  b__972:appendSafe(') AS ');
  b__972:appendSafe(alias__970.sqlValue);
  return b__972.accumulated;
end;
existsSql = function(q__973)
  local b__975;
  b__975 = SqlBuilder();
  b__975:appendSafe('EXISTS (');
  b__975:appendFragment(q__973:toSql());
  b__975:appendSafe(')');
  return b__975.accumulated;
end;
update = function(tableName__1035)
  return UpdateQuery(tableName__1035, temper.listof(), temper.listof(), temper.null);
end;
deleteFrom = function(tableName__1037)
  return DeleteQuery(tableName__1037, temper.listof(), temper.null);
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
exports.WhereClause = WhereClause;
exports.AndCondition = AndCondition;
exports.OrCondition = OrCondition;
exports.Query = Query;
exports.SetClause = SetClause;
exports.UpdateQuery = UpdateQuery;
exports.DeleteQuery = DeleteQuery;
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
exports.countAll = countAll;
exports.countCol = countCol;
exports.sumCol = sumCol;
exports.avgCol = avgCol;
exports.minCol = minCol;
exports.maxCol = maxCol;
exports.unionSql = unionSql;
exports.unionAllSql = unionAllSql;
exports.intersectSql = intersectSql;
exports.exceptSql = exceptSql;
exports.subquery = subquery;
exports.existsSql = existsSql;
exports.update = update;
exports.deleteFrom = deleteFrom;
return exports;
