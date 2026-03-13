local temper = require('temper-core');
local ChangesetError, NumberValidationOpts, Changeset, ChangesetImpl__286, JoinType, InnerJoin, LeftJoin, RightJoin, FullJoin, CrossJoin, JoinClause, NullsPosition, NullsFirst, NullsLast, OrderClause, LockMode, ForUpdate, ForShare, WhereClause, AndCondition, OrCondition, Query, SetClause, UpdateQuery, DeleteQuery, SafeIdentifier, ValidatedIdentifier__372, FieldType, StringField, IntField, Int64Field, FloatField, BoolField, DateField, FieldDef, TableDef, SqlBuilder, SqlFragment, SqlPart, SqlSource, SqlBoolean, SqlDate, SqlFloat64, SqlInt32, SqlInt64, SqlDefault, SqlString, changeset, isIdentStart__710, isIdentPart__711, safeIdentifier, timestamps, deleteSql, renderWhere__705, renderJoins__706, renderGroupBy__707, renderHaving__708, from, col, countAll, countCol, sumCol, avgCol, minCol, maxCol, unionSql, unionAllSql, intersectSql, exceptSql, subquery, existsSql, update, deleteFrom, exports;
ChangesetError = temper.type('ChangesetError');
ChangesetError.constructor = function(this__409, field__717, message__718)
  this__409.field__714 = field__717;
  this__409.message__715 = message__718;
  return nil;
end;
ChangesetError.get.field = function(this__2204)
  return this__2204.field__714;
end;
ChangesetError.get.message = function(this__2207)
  return this__2207.message__715;
end;
NumberValidationOpts = temper.type('NumberValidationOpts');
NumberValidationOpts.constructor = function(this__411, greaterThan__725, lessThan__726, greaterThanOrEqual__727, lessThanOrEqual__728, equalTo__729)
  if (greaterThan__725 == nil) then
    greaterThan__725 = temper.null;
  end
  if (lessThan__726 == nil) then
    lessThan__726 = temper.null;
  end
  if (greaterThanOrEqual__727 == nil) then
    greaterThanOrEqual__727 = temper.null;
  end
  if (lessThanOrEqual__728 == nil) then
    lessThanOrEqual__728 = temper.null;
  end
  if (equalTo__729 == nil) then
    equalTo__729 = temper.null;
  end
  this__411.greaterThan__719 = greaterThan__725;
  this__411.lessThan__720 = lessThan__726;
  this__411.greaterThanOrEqual__721 = greaterThanOrEqual__727;
  this__411.lessThanOrEqual__722 = lessThanOrEqual__728;
  this__411.equalTo__723 = equalTo__729;
  return nil;
end;
NumberValidationOpts.get.greaterThan = function(this__2210)
  return this__2210.greaterThan__719;
end;
NumberValidationOpts.get.lessThan = function(this__2213)
  return this__2213.lessThan__720;
end;
NumberValidationOpts.get.greaterThanOrEqual = function(this__2216)
  return this__2216.greaterThanOrEqual__721;
end;
NumberValidationOpts.get.lessThanOrEqual = function(this__2219)
  return this__2219.lessThanOrEqual__722;
end;
NumberValidationOpts.get.equalTo = function(this__2222)
  return this__2222.equalTo__723;
end;
Changeset = temper.type('Changeset');
Changeset.get.tableDef = function(this__262)
  temper.virtual();
end;
Changeset.get.changes = function(this__263)
  temper.virtual();
end;
Changeset.get.errors = function(this__264)
  temper.virtual();
end;
Changeset.get.isValid = function(this__265)
  temper.virtual();
end;
Changeset.methods.cast = function(this__266, allowedFields__739)
  temper.virtual();
end;
Changeset.methods.validateRequired = function(this__267, fields__742)
  temper.virtual();
end;
Changeset.methods.validateLength = function(this__268, field__745, min__746, max__747)
  temper.virtual();
end;
Changeset.methods.validateInt = function(this__269, field__750)
  temper.virtual();
end;
Changeset.methods.validateInt64 = function(this__270, field__753)
  temper.virtual();
end;
Changeset.methods.validateFloat = function(this__271, field__756)
  temper.virtual();
end;
Changeset.methods.validateBool = function(this__272, field__759)
  temper.virtual();
end;
Changeset.methods.putChange = function(this__273, field__762, value__763)
  temper.virtual();
end;
Changeset.methods.getChange = function(this__274, field__766)
  temper.virtual();
end;
Changeset.methods.deleteChange = function(this__275, field__769)
  temper.virtual();
end;
Changeset.methods.validateInclusion = function(this__276, field__772, allowed__773)
  temper.virtual();
end;
Changeset.methods.validateExclusion = function(this__277, field__776, disallowed__777)
  temper.virtual();
end;
Changeset.methods.validateNumber = function(this__278, field__780, opts__781)
  temper.virtual();
end;
Changeset.methods.validateAcceptance = function(this__279, field__784)
  temper.virtual();
end;
Changeset.methods.validateConfirmation = function(this__280, field__787, confirmationField__788)
  temper.virtual();
end;
Changeset.methods.validateContains = function(this__281, field__791, substring__792)
  temper.virtual();
end;
Changeset.methods.validateStartsWith = function(this__282, field__795, prefix__796)
  temper.virtual();
end;
Changeset.methods.validateEndsWith = function(this__283, field__799, suffix__800)
  temper.virtual();
end;
Changeset.methods.toInsertSql = function(this__284)
  temper.virtual();
end;
Changeset.methods.toUpdateSql = function(this__285, id__805)
  temper.virtual();
end;
ChangesetImpl__286 = temper.type('ChangesetImpl__286', Changeset);
ChangesetImpl__286.get.tableDef = function(this__287)
  return this__287._tableDef__807;
end;
ChangesetImpl__286.get.changes = function(this__288)
  return this__288._changes__809;
end;
ChangesetImpl__286.get.errors = function(this__289)
  return this__289._errors__810;
end;
ChangesetImpl__286.get.isValid = function(this__290)
  return this__290._isValid__811;
end;
ChangesetImpl__286.methods.addError = function(this__291, field__821, message__822)
  local eb__824;
  eb__824 = temper.list_tolistbuilder(this__291._errors__810);
  temper.listbuilder_add(eb__824, ChangesetError(field__821, message__822));
  return ChangesetImpl__286(this__291._tableDef__807, this__291._params__808, this__291._changes__809, temper.listbuilder_tolist(eb__824), false);
end;
ChangesetImpl__286.methods.cast = function(this__292, allowedFields__826)
  local mb__828, fn__17273;
  mb__828 = temper.mapbuilder_constructor();
  fn__17273 = function(f__829)
    local t_0, t_1, val__830;
    t_1 = f__829.sqlValue;
    val__830 = temper.mapped_getor(this__292._params__808, t_1, '');
    if not temper.string_isempty(val__830) then
      t_0 = f__829.sqlValue;
      temper.mapbuilder_set(mb__828, t_0, val__830);
    end
    return nil;
  end;
  temper.list_foreach(allowedFields__826, fn__17273);
  return ChangesetImpl__286(this__292._tableDef__807, this__292._params__808, temper.mapped_tomap(mb__828), this__292._errors__810, this__292._isValid__811);
end;
ChangesetImpl__286.methods.validateRequired = function(this__293, fields__832)
  local return__461, t_2, t_3, t_4, t_5, eb__834, valid__835, fn__17262;
  ::continue_1::
  if not this__293._isValid__811 then
    return__461 = this__293;
    goto break_0;
  end
  eb__834 = temper.list_tolistbuilder(this__293._errors__810);
  valid__835 = true;
  fn__17262 = function(f__836)
    local t_6, t_7;
    t_7 = f__836.sqlValue;
    if not temper.mapped_has(this__293._changes__809, t_7) then
      t_6 = ChangesetError(f__836.sqlValue, 'is required');
      temper.listbuilder_add(eb__834, t_6);
      valid__835 = false;
    end
    return nil;
  end;
  temper.list_foreach(fields__832, fn__17262);
  t_3 = this__293._tableDef__807;
  t_4 = this__293._params__808;
  t_5 = this__293._changes__809;
  t_2 = temper.listbuilder_tolist(eb__834);
  return__461 = ChangesetImpl__286(t_3, t_4, t_5, t_2, valid__835);
  ::break_0::return return__461;
end;
ChangesetImpl__286.methods.validateLength = function(this__294, field__838, min__839, max__840)
  local return__462, t_8, t_9, t_10, t_11, t_12, val__842, len__843;
  ::continue_3::
  if not this__294._isValid__811 then
    return__462 = this__294;
    goto break_2;
  end
  t_8 = field__838.sqlValue;
  val__842 = temper.mapped_getor(this__294._changes__809, t_8, '');
  len__843 = temper.string_countbetween(val__842, 1.0, temper.string_end(val__842));
  if (len__843 < min__839) then
    t_12 = true;
  else
    t_12 = (len__843 > max__840);
  end
  if t_12 then
    t_9 = field__838.sqlValue;
    t_10 = temper.int32_tostring(min__839);
    t_11 = temper.int32_tostring(max__840);
    return__462 = this__294:addError(t_9, temper.concat('must be between ', t_10, ' and ', t_11, ' characters'));
    goto break_2;
  end
  return__462 = this__294;
  ::break_2::return return__462;
end;
ChangesetImpl__286.methods.validateInt = function(this__295, field__845)
  local return__463, t_13, t_14, val__847, parseOk__848, local_15, local_16, local_17;
  ::continue_5::
  if not this__295._isValid__811 then
    return__463 = this__295;
    goto break_4;
  end
  t_13 = field__845.sqlValue;
  val__847 = temper.mapped_getor(this__295._changes__809, t_13, '');
  if temper.string_isempty(val__847) then
    return__463 = this__295;
    goto break_4;
  end
  local_15, local_16, local_17 = temper.pcall(function()
    temper.string_toint32(val__847);
    parseOk__848 = true;
  end);
  if local_15 then
  else
    parseOk__848 = false;
  end
  if not parseOk__848 then
    t_14 = field__845.sqlValue;
    return__463 = this__295:addError(t_14, 'must be an integer');
    goto break_4;
  end
  return__463 = this__295;
  ::break_4::return return__463;
end;
ChangesetImpl__286.methods.validateInt64 = function(this__296, field__850)
  local return__464, t_19, t_20, val__852, parseOk__853, local_21, local_22, local_23;
  ::continue_7::
  if not this__296._isValid__811 then
    return__464 = this__296;
    goto break_6;
  end
  t_19 = field__850.sqlValue;
  val__852 = temper.mapped_getor(this__296._changes__809, t_19, '');
  if temper.string_isempty(val__852) then
    return__464 = this__296;
    goto break_6;
  end
  local_21, local_22, local_23 = temper.pcall(function()
    temper.string_toint64(val__852);
    parseOk__853 = true;
  end);
  if local_21 then
  else
    parseOk__853 = false;
  end
  if not parseOk__853 then
    t_20 = field__850.sqlValue;
    return__464 = this__296:addError(t_20, 'must be a 64-bit integer');
    goto break_6;
  end
  return__464 = this__296;
  ::break_6::return return__464;
end;
ChangesetImpl__286.methods.validateFloat = function(this__297, field__855)
  local return__465, t_25, t_26, val__857, parseOk__858, local_27, local_28, local_29;
  ::continue_9::
  if not this__297._isValid__811 then
    return__465 = this__297;
    goto break_8;
  end
  t_25 = field__855.sqlValue;
  val__857 = temper.mapped_getor(this__297._changes__809, t_25, '');
  if temper.string_isempty(val__857) then
    return__465 = this__297;
    goto break_8;
  end
  local_27, local_28, local_29 = temper.pcall(function()
    temper.string_tofloat64(val__857);
    parseOk__858 = true;
  end);
  if local_27 then
  else
    parseOk__858 = false;
  end
  if not parseOk__858 then
    t_26 = field__855.sqlValue;
    return__465 = this__297:addError(t_26, 'must be a number');
    goto break_8;
  end
  return__465 = this__297;
  ::break_8::return return__465;
end;
ChangesetImpl__286.methods.validateBool = function(this__298, field__860)
  local return__466, t_31, t_32, t_33, t_34, t_35, t_36, t_37, val__862, isTrue__863, isFalse__864;
  ::continue_11::
  if not this__298._isValid__811 then
    return__466 = this__298;
    goto break_10;
  end
  t_31 = field__860.sqlValue;
  val__862 = temper.mapped_getor(this__298._changes__809, t_31, '');
  if temper.string_isempty(val__862) then
    return__466 = this__298;
    goto break_10;
  end
  if temper.str_eq(val__862, 'true') then
    isTrue__863 = true;
  else
    if temper.str_eq(val__862, '1') then
      t_34 = true;
    else
      if temper.str_eq(val__862, 'yes') then
        t_33 = true;
      else
        t_33 = temper.str_eq(val__862, 'on');
      end
      t_34 = t_33;
    end
    isTrue__863 = t_34;
  end
  if temper.str_eq(val__862, 'false') then
    isFalse__864 = true;
  else
    if temper.str_eq(val__862, '0') then
      t_36 = true;
    else
      if temper.str_eq(val__862, 'no') then
        t_35 = true;
      else
        t_35 = temper.str_eq(val__862, 'off');
      end
      t_36 = t_35;
    end
    isFalse__864 = t_36;
  end
  if not isTrue__863 then
    t_37 = not isFalse__864;
  else
    t_37 = false;
  end
  if t_37 then
    t_32 = field__860.sqlValue;
    return__466 = this__298:addError(t_32, 'must be a boolean (true/false/1/0/yes/no/on/off)');
    goto break_10;
  end
  return__466 = this__298;
  ::break_10::return return__466;
end;
ChangesetImpl__286.methods.putChange = function(this__299, field__866, value__867)
  local t_38, mb__869, pairs__870, i__871;
  mb__869 = temper.mapbuilder_constructor();
  pairs__870 = temper.mapped_tolist(this__299._changes__809);
  i__871 = 0;
  while true do
    t_38 = temper.list_length(pairs__870);
    if not (i__871 < t_38) then
      break;
    end
    temper.mapbuilder_set(mb__869, (temper.list_get(pairs__870, i__871)).key, (temper.list_get(pairs__870, i__871)).value);
    i__871 = temper.int32_add(i__871, 1);
  end
  temper.mapbuilder_set(mb__869, field__866.sqlValue, value__867);
  return ChangesetImpl__286(this__299._tableDef__807, this__299._params__808, temper.mapped_tomap(mb__869), this__299._errors__810, this__299._isValid__811);
end;
ChangesetImpl__286.methods.getChange = function(this__300, field__873)
  local t_39, t_40;
  t_39 = field__873.sqlValue;
  if not temper.mapped_has(this__300._changes__809, t_39) then
    temper.bubble();
  end
  t_40 = field__873.sqlValue;
  return temper.mapped_getor(this__300._changes__809, t_40, '');
end;
ChangesetImpl__286.methods.deleteChange = function(this__301, field__876)
  local t_41, mb__878, pairs__879, i__880;
  mb__878 = temper.mapbuilder_constructor();
  pairs__879 = temper.mapped_tolist(this__301._changes__809);
  i__880 = 0;
  while true do
    t_41 = temper.list_length(pairs__879);
    if not (i__880 < t_41) then
      break;
    end
    if temper.str_ne((temper.list_get(pairs__879, i__880)).key, field__876.sqlValue) then
      temper.mapbuilder_set(mb__878, (temper.list_get(pairs__879, i__880)).key, (temper.list_get(pairs__879, i__880)).value);
    end
    i__880 = temper.int32_add(i__880, 1);
  end
  return ChangesetImpl__286(this__301._tableDef__807, this__301._params__808, temper.mapped_tomap(mb__878), this__301._errors__810, this__301._isValid__811);
end;
ChangesetImpl__286.methods.validateInclusion = function(this__302, field__882, allowed__883)
  local return__470, t_42, t_43, t_44, val__885, found__886, fn__17186;
  ::continue_13::
  if not this__302._isValid__811 then
    return__470 = this__302;
    goto break_12;
  end
  t_42 = field__882.sqlValue;
  if not temper.mapped_has(this__302._changes__809, t_42) then
    return__470 = this__302;
    goto break_12;
  end
  t_43 = field__882.sqlValue;
  val__885 = temper.mapped_getor(this__302._changes__809, t_43, '');
  found__886 = false;
  fn__17186 = function(a__887)
    if temper.str_eq(a__887, val__885) then
      found__886 = true;
    end
    return nil;
  end;
  temper.list_foreach(allowed__883, fn__17186);
  if not found__886 then
    t_44 = field__882.sqlValue;
    return__470 = this__302:addError(t_44, 'is not included in the list');
    goto break_12;
  end
  return__470 = this__302;
  ::break_12::return return__470;
end;
ChangesetImpl__286.methods.validateExclusion = function(this__303, field__889, disallowed__890)
  local return__471, t_45, t_46, t_47, val__892, found__893, fn__17177;
  ::continue_15::
  if not this__303._isValid__811 then
    return__471 = this__303;
    goto break_14;
  end
  t_45 = field__889.sqlValue;
  if not temper.mapped_has(this__303._changes__809, t_45) then
    return__471 = this__303;
    goto break_14;
  end
  t_46 = field__889.sqlValue;
  val__892 = temper.mapped_getor(this__303._changes__809, t_46, '');
  found__893 = false;
  fn__17177 = function(d__894)
    if temper.str_eq(d__894, val__892) then
      found__893 = true;
    end
    return nil;
  end;
  temper.list_foreach(disallowed__890, fn__17177);
  if found__893 then
    t_47 = field__889.sqlValue;
    return__471 = this__303:addError(t_47, 'is reserved');
    goto break_14;
  end
  return__471 = this__303;
  ::break_14::return return__471;
end;
ChangesetImpl__286.methods.validateNumber = function(this__304, field__896, opts__897)
  local return__472, t_48, t_49, t_50, t_51, t_52, t_53, t_54, t_55, t_56, t_57, t_58, t_59, t_60, t_61, val__899, parseOk__900, local_62, local_63, local_64, num__901, local_66, local_67, local_68, gt__902, lt__903, gte__904, lte__905, eq__906;
  ::continue_17::
  if not this__304._isValid__811 then
    return__472 = this__304;
    goto break_16;
  end
  t_48 = field__896.sqlValue;
  if not temper.mapped_has(this__304._changes__809, t_48) then
    return__472 = this__304;
    goto break_16;
  end
  t_49 = field__896.sqlValue;
  val__899 = temper.mapped_getor(this__304._changes__809, t_49, '');
  local_62, local_63, local_64 = temper.pcall(function()
    temper.string_tofloat64(val__899);
    parseOk__900 = true;
  end);
  if local_62 then
  else
    parseOk__900 = false;
  end
  if not parseOk__900 then
    t_50 = field__896.sqlValue;
    return__472 = this__304:addError(t_50, 'must be a number');
    goto break_16;
  end
  local_66, local_67, local_68 = temper.pcall(function()
    t_61 = temper.string_tofloat64(val__899);
    num__901 = t_61;
  end);
  if local_66 then
  else
    num__901 = 0.0;
  end
  gt__902 = opts__897.greaterThan;
  if not temper.is_null(gt__902) then
    local gt_70;
    gt_70 = gt__902;
    if not temper.float_gt(num__901, gt_70) then
      t_51 = field__896.sqlValue;
      t_52 = temper.float64_tostring(gt_70);
      return__472 = this__304:addError(t_51, temper.concat('must be greater than ', t_52));
      goto break_16;
    end
  end
  lt__903 = opts__897.lessThan;
  if not temper.is_null(lt__903) then
    local lt_71;
    lt_71 = lt__903;
    if not temper.float_lt(num__901, lt_71) then
      t_53 = field__896.sqlValue;
      t_54 = temper.float64_tostring(lt_71);
      return__472 = this__304:addError(t_53, temper.concat('must be less than ', t_54));
      goto break_16;
    end
  end
  gte__904 = opts__897.greaterThanOrEqual;
  if not temper.is_null(gte__904) then
    local gte_72;
    gte_72 = gte__904;
    if not temper.float_ge(num__901, gte_72) then
      t_55 = field__896.sqlValue;
      t_56 = temper.float64_tostring(gte_72);
      return__472 = this__304:addError(t_55, temper.concat('must be greater than or equal to ', t_56));
      goto break_16;
    end
  end
  lte__905 = opts__897.lessThanOrEqual;
  if not temper.is_null(lte__905) then
    local lte_73;
    lte_73 = lte__905;
    if not temper.float_le(num__901, lte_73) then
      t_57 = field__896.sqlValue;
      t_58 = temper.float64_tostring(lte_73);
      return__472 = this__304:addError(t_57, temper.concat('must be less than or equal to ', t_58));
      goto break_16;
    end
  end
  eq__906 = opts__897.equalTo;
  if not temper.is_null(eq__906) then
    local eq_74;
    eq_74 = eq__906;
    if not temper.float_eq(num__901, eq_74) then
      t_59 = field__896.sqlValue;
      t_60 = temper.float64_tostring(eq_74);
      return__472 = this__304:addError(t_59, temper.concat('must be equal to ', t_60));
      goto break_16;
    end
  end
  return__472 = this__304;
  ::break_16::return return__472;
end;
ChangesetImpl__286.methods.validateAcceptance = function(this__305, field__908)
  local return__473, t_75, t_76, t_77, t_78, t_79, val__910, accepted__911;
  ::continue_19::
  if not this__305._isValid__811 then
    return__473 = this__305;
    goto break_18;
  end
  t_75 = field__908.sqlValue;
  if not temper.mapped_has(this__305._changes__809, t_75) then
    return__473 = this__305;
    goto break_18;
  end
  t_76 = field__908.sqlValue;
  val__910 = temper.mapped_getor(this__305._changes__809, t_76, '');
  if temper.str_eq(val__910, 'true') then
    accepted__911 = true;
  else
    if temper.str_eq(val__910, '1') then
      t_79 = true;
    else
      if temper.str_eq(val__910, 'yes') then
        t_78 = true;
      else
        t_78 = temper.str_eq(val__910, 'on');
      end
      t_79 = t_78;
    end
    accepted__911 = t_79;
  end
  if not accepted__911 then
    t_77 = field__908.sqlValue;
    return__473 = this__305:addError(t_77, 'must be accepted');
    goto break_18;
  end
  return__473 = this__305;
  ::break_18::return return__473;
end;
ChangesetImpl__286.methods.validateConfirmation = function(this__306, field__913, confirmationField__914)
  local return__474, t_80, t_81, t_82, t_83, val__916, conf__917;
  ::continue_21::
  if not this__306._isValid__811 then
    return__474 = this__306;
    goto break_20;
  end
  t_80 = field__913.sqlValue;
  if not temper.mapped_has(this__306._changes__809, t_80) then
    return__474 = this__306;
    goto break_20;
  end
  t_81 = field__913.sqlValue;
  val__916 = temper.mapped_getor(this__306._changes__809, t_81, '');
  t_82 = confirmationField__914.sqlValue;
  conf__917 = temper.mapped_getor(this__306._changes__809, t_82, '');
  if temper.str_ne(val__916, conf__917) then
    t_83 = confirmationField__914.sqlValue;
    return__474 = this__306:addError(t_83, 'does not match');
    goto break_20;
  end
  return__474 = this__306;
  ::break_20::return return__474;
end;
ChangesetImpl__286.methods.validateContains = function(this__307, field__919, substring__920)
  local return__475, t_84, t_85, t_86, val__922;
  ::continue_23::
  if not this__307._isValid__811 then
    return__475 = this__307;
    goto break_22;
  end
  t_84 = field__919.sqlValue;
  if not temper.mapped_has(this__307._changes__809, t_84) then
    return__475 = this__307;
    goto break_22;
  end
  t_85 = field__919.sqlValue;
  val__922 = temper.mapped_getor(this__307._changes__809, t_85, '');
  if not temper.is_string_index(temper.string_indexof(val__922, substring__920)) then
    t_86 = field__919.sqlValue;
    return__475 = this__307:addError(t_86, 'must contain the given substring');
    goto break_22;
  end
  return__475 = this__307;
  ::break_22::return return__475;
end;
ChangesetImpl__286.methods.validateStartsWith = function(this__308, field__924, prefix__925)
  local return__476, t_87, t_88, t_89, t_90, val__927, idx__928, starts__929;
  ::continue_25::
  if not this__308._isValid__811 then
    return__476 = this__308;
    goto break_24;
  end
  t_87 = field__924.sqlValue;
  if not temper.mapped_has(this__308._changes__809, t_87) then
    return__476 = this__308;
    goto break_24;
  end
  t_88 = field__924.sqlValue;
  val__927 = temper.mapped_getor(this__308._changes__809, t_88, '');
  idx__928 = temper.string_indexof(val__927, prefix__925);
  if temper.is_string_index(idx__928) then
    t_89 = temper.string_countbetween(val__927, 1.0, temper.require_string_index(idx__928));
    starts__929 = (t_89 == 0);
  else
    starts__929 = false;
  end
  if not starts__929 then
    t_90 = field__924.sqlValue;
    return__476 = this__308:addError(t_90, 'must start with the given prefix');
    goto break_24;
  end
  return__476 = this__308;
  ::break_24::return return__476;
end;
ChangesetImpl__286.methods.validateEndsWith = function(this__309, field__931, suffix__932)
  local return__477, t_91, t_92, t_93, t_94, t_95, t_96, t_97, t_98, t_99, t_100, val__934, valLen__935, suffixLen__936, skipCount__937, strIdx__938, i__939, sufIdx__940, matches__941;
  ::continue_27::
  if not this__309._isValid__811 then
    return__477 = this__309;
    goto break_26;
  end
  t_91 = field__931.sqlValue;
  if not temper.mapped_has(this__309._changes__809, t_91) then
    return__477 = this__309;
    goto break_26;
  end
  t_92 = field__931.sqlValue;
  val__934 = temper.mapped_getor(this__309._changes__809, t_92, '');
  valLen__935 = temper.string_countbetween(val__934, 1.0, temper.string_end(val__934));
  t_93 = temper.string_end(suffix__932);
  suffixLen__936 = temper.string_countbetween(suffix__932, 1.0, t_93);
  if (valLen__935 < suffixLen__936) then
    t_94 = field__931.sqlValue;
    return__477 = this__309:addError(t_94, 'must end with the given suffix');
    goto break_26;
  end
  skipCount__937 = temper.int32_sub(valLen__935, suffixLen__936);
  strIdx__938 = 1.0;
  i__939 = 0;
  while (i__939 < skipCount__937) do
    t_95 = temper.string_next(val__934, strIdx__938);
    strIdx__938 = t_95;
    i__939 = temper.int32_add(i__939, 1);
  end
  sufIdx__940 = 1.0;
  matches__941 = true;
  while true do
    if matches__941 then
      t_96 = temper.string_hasindex(suffix__932, sufIdx__940);
      t_100 = t_96;
    else
      t_100 = false;
    end
    if not t_100 then
      break;
    end
    if not temper.string_hasindex(val__934, strIdx__938) then
      matches__941 = false;
    elseif (temper.string_get(val__934, strIdx__938) ~= temper.string_get(suffix__932, sufIdx__940)) then
      matches__941 = false;
    else
      t_97 = temper.string_next(val__934, strIdx__938);
      strIdx__938 = t_97;
      t_98 = temper.string_next(suffix__932, sufIdx__940);
      sufIdx__940 = t_98;
    end
  end
  if not matches__941 then
    t_99 = field__931.sqlValue;
    return__477 = this__309:addError(t_99, 'must end with the given suffix');
    goto break_26;
  end
  return__477 = this__309;
  ::break_26::return return__477;
end;
ChangesetImpl__286.methods.parseBoolSqlPart = function(this__310, val__943)
  local return__478, t_101, t_102, t_103, t_104, t_105, t_106;
  ::continue_29::
  if temper.str_eq(val__943, 'true') then
    t_103 = true;
  else
    if temper.str_eq(val__943, '1') then
      t_102 = true;
    else
      if temper.str_eq(val__943, 'yes') then
        t_101 = true;
      else
        t_101 = temper.str_eq(val__943, 'on');
      end
      t_102 = t_101;
    end
    t_103 = t_102;
  end
  if t_103 then
    return__478 = SqlBoolean(true);
    goto break_28;
  end
  if temper.str_eq(val__943, 'false') then
    t_106 = true;
  else
    if temper.str_eq(val__943, '0') then
      t_105 = true;
    else
      if temper.str_eq(val__943, 'no') then
        t_104 = true;
      else
        t_104 = temper.str_eq(val__943, 'off');
      end
      t_105 = t_104;
    end
    t_106 = t_105;
  end
  if t_106 then
    return__478 = SqlBoolean(false);
    goto break_28;
  end
  temper.bubble();
  ::break_28::return return__478;
end;
ChangesetImpl__286.methods.valueToSqlPart = function(this__311, fieldDef__946, val__947)
  local return__479, t_107, t_108, t_109, t_110, ft__949;
  ::continue_31::ft__949 = fieldDef__946.fieldType;
  if temper.instance_of(ft__949, StringField) then
    return__479 = SqlString(val__947);
    goto break_30;
  end
  if temper.instance_of(ft__949, IntField) then
    t_107 = temper.string_toint32(val__947);
    return__479 = SqlInt32(t_107);
    goto break_30;
  end
  if temper.instance_of(ft__949, Int64Field) then
    t_108 = temper.string_toint64(val__947);
    return__479 = SqlInt64(t_108);
    goto break_30;
  end
  if temper.instance_of(ft__949, FloatField) then
    t_109 = temper.string_tofloat64(val__947);
    return__479 = SqlFloat64(t_109);
    goto break_30;
  end
  if temper.instance_of(ft__949, BoolField) then
    return__479 = this__311:parseBoolSqlPart(val__947);
    goto break_30;
  end
  if temper.instance_of(ft__949, DateField) then
    t_110 = temper.date_fromisostring(val__947);
    return__479 = SqlDate(t_110);
    goto break_30;
  end
  temper.bubble();
  ::break_30::return return__479;
end;
ChangesetImpl__286.methods.toInsertSql = function(this__312)
  local t_111, t_112, t_113, t_114, t_115, t_116, t_117, t_118, t_119, t_120, t_121, t_122, i__952, colNames__955, valParts__956, pairs__957, i__958, i__961, b__964, t_124, fn__17030, j__966;
  if not this__312._isValid__811 then
    temper.bubble();
  end
  i__952 = 0;
  while true do
    local f__953, dv__954;
    ::continue_33::t_111 = temper.list_length(this__312._tableDef__807.fields);
    if not (i__952 < t_111) then
      break;
    end
    f__953 = temper.list_get(this__312._tableDef__807.fields, i__952);
    if f__953.virtual then
      goto break_32;
    end
    dv__954 = f__953.defaultValue;
    if not f__953.nullable then
      t_112 = f__953.name.sqlValue;
      if not temper.mapped_has(this__312._changes__809, t_112) then
        t_119 = temper.is_null(dv__954);
      else
        t_119 = false;
      end
      t_120 = t_119;
    else
      t_120 = false;
    end
    if t_120 then
      temper.bubble();
    end
    ::break_32::i__952 = temper.int32_add(i__952, 1);
  end
  colNames__955 = temper.listbuilder_constructor();
  valParts__956 = temper.listbuilder_constructor();
  pairs__957 = temper.mapped_tolist(this__312._changes__809);
  i__958 = 0;
  while true do
    local pair__959, fd__960;
    ::continue_35::t_113 = temper.list_length(pairs__957);
    if not (i__958 < t_113) then
      break;
    end
    pair__959 = temper.list_get(pairs__957, i__958);
    t_114 = pair__959.key;
    t_121 = this__312._tableDef__807:field(t_114);
    fd__960 = t_121;
    if fd__960.virtual then
      goto break_34;
    end
    temper.listbuilder_add(colNames__955, fd__960.name.sqlValue);
    t_115 = pair__959.value;
    t_122 = this__312:valueToSqlPart(fd__960, t_115);
    temper.listbuilder_add(valParts__956, t_122);
    ::break_34::i__958 = temper.int32_add(i__958, 1);
  end
  i__961 = 0;
  while true do
    local f__962, dv__963;
    ::continue_37::t_116 = temper.list_length(this__312._tableDef__807.fields);
    if not (i__961 < t_116) then
      break;
    end
    f__962 = temper.list_get(this__312._tableDef__807.fields, i__961);
    if f__962.virtual then
      goto break_36;
    end
    dv__963 = f__962.defaultValue;
    if not temper.is_null(dv__963) then
      local dv_123;
      dv_123 = dv__963;
      t_117 = f__962.name.sqlValue;
      if not temper.mapped_has(this__312._changes__809, t_117) then
        temper.listbuilder_add(colNames__955, f__962.name.sqlValue);
        temper.listbuilder_add(valParts__956, dv_123);
      end
    end
    ::break_36::i__961 = temper.int32_add(i__961, 1);
  end
  if (temper.listbuilder_length(valParts__956) == 0) then
    temper.bubble();
  end
  b__964 = SqlBuilder();
  b__964:appendSafe('INSERT INTO ');
  b__964:appendSafe(this__312._tableDef__807.tableName.sqlValue);
  b__964:appendSafe(' (');
  t_124 = temper.listbuilder_tolist(colNames__955);
  fn__17030 = function(c__965)
    return c__965;
  end;
  b__964:appendSafe(temper.listed_join(t_124, ', ', fn__17030));
  b__964:appendSafe(') VALUES (');
  b__964:appendPart(temper.listed_get(valParts__956, 0));
  j__966 = 1;
  while true do
    t_118 = temper.listbuilder_length(valParts__956);
    if not (j__966 < t_118) then
      break;
    end
    b__964:appendSafe(', ');
    b__964:appendPart(temper.listed_get(valParts__956, j__966));
    j__966 = temper.int32_add(j__966, 1);
  end
  b__964:appendSafe(')');
  return b__964.accumulated;
end;
ChangesetImpl__286.methods.toUpdateSql = function(this__313, id__968)
  local t_125, t_126, t_127, t_128, t_129, pairs__970, b__971, setCount__972, i__973;
  if not this__313._isValid__811 then
    temper.bubble();
  end
  pairs__970 = temper.mapped_tolist(this__313._changes__809);
  if (temper.list_length(pairs__970) == 0) then
    temper.bubble();
  end
  b__971 = SqlBuilder();
  b__971:appendSafe('UPDATE ');
  b__971:appendSafe(this__313._tableDef__807.tableName.sqlValue);
  b__971:appendSafe(' SET ');
  setCount__972 = 0;
  i__973 = 0;
  while true do
    local pair__974, fd__975;
    ::continue_39::t_125 = temper.list_length(pairs__970);
    if not (i__973 < t_125) then
      break;
    end
    pair__974 = temper.list_get(pairs__970, i__973);
    t_126 = pair__974.key;
    t_128 = this__313._tableDef__807:field(t_126);
    fd__975 = t_128;
    if fd__975.virtual then
      goto break_38;
    end
    if (setCount__972 > 0) then
      b__971:appendSafe(', ');
    end
    b__971:appendSafe(fd__975.name.sqlValue);
    b__971:appendSafe(' = ');
    t_127 = pair__974.value;
    t_129 = this__313:valueToSqlPart(fd__975, t_127);
    b__971:appendPart(t_129);
    setCount__972 = temper.int32_add(setCount__972, 1);
    ::break_38::i__973 = temper.int32_add(i__973, 1);
  end
  if (setCount__972 == 0) then
    temper.bubble();
  end
  b__971:appendSafe(' WHERE ');
  b__971:appendSafe(this__313._tableDef__807:pkName());
  b__971:appendSafe(' = ');
  b__971:appendInt32(id__968);
  return b__971.accumulated;
end;
ChangesetImpl__286.constructor = function(this__450, _tableDef__977, _params__978, _changes__979, _errors__980, _isValid__981)
  this__450._tableDef__807 = _tableDef__977;
  this__450._params__808 = _params__978;
  this__450._changes__809 = _changes__979;
  this__450._errors__810 = _errors__980;
  this__450._isValid__811 = _isValid__981;
  return nil;
end;
JoinType = temper.type('JoinType');
JoinType.methods.keyword = function(this__314)
  temper.virtual();
end;
InnerJoin = temper.type('InnerJoin', JoinType);
InnerJoin.methods.keyword = function(this__315)
  return 'INNER JOIN';
end;
InnerJoin.constructor = function(this__487)
  return nil;
end;
LeftJoin = temper.type('LeftJoin', JoinType);
LeftJoin.methods.keyword = function(this__316)
  return 'LEFT JOIN';
end;
LeftJoin.constructor = function(this__490)
  return nil;
end;
RightJoin = temper.type('RightJoin', JoinType);
RightJoin.methods.keyword = function(this__317)
  return 'RIGHT JOIN';
end;
RightJoin.constructor = function(this__493)
  return nil;
end;
FullJoin = temper.type('FullJoin', JoinType);
FullJoin.methods.keyword = function(this__318)
  return 'FULL OUTER JOIN';
end;
FullJoin.constructor = function(this__496)
  return nil;
end;
CrossJoin = temper.type('CrossJoin', JoinType);
CrossJoin.methods.keyword = function(this__319)
  return 'CROSS JOIN';
end;
CrossJoin.constructor = function(this__499)
  return nil;
end;
JoinClause = temper.type('JoinClause');
JoinClause.constructor = function(this__502, joinType__1326, table__1327, onCondition__1328)
  if (onCondition__1328 == nil) then
    onCondition__1328 = temper.null;
  end
  this__502.joinType__1322 = joinType__1326;
  this__502.table__1323 = table__1327;
  this__502.onCondition__1324 = onCondition__1328;
  return nil;
end;
JoinClause.get.joinType = function(this__2361)
  return this__2361.joinType__1322;
end;
JoinClause.get.table = function(this__2364)
  return this__2364.table__1323;
end;
JoinClause.get.onCondition = function(this__2367)
  return this__2367.onCondition__1324;
end;
NullsPosition = temper.type('NullsPosition');
NullsPosition.methods.keyword = function(this__320)
  temper.virtual();
end;
NullsFirst = temper.type('NullsFirst', NullsPosition);
NullsFirst.methods.keyword = function(this__321)
  return ' NULLS FIRST';
end;
NullsFirst.constructor = function(this__506)
  return nil;
end;
NullsLast = temper.type('NullsLast', NullsPosition);
NullsLast.methods.keyword = function(this__322)
  return ' NULLS LAST';
end;
NullsLast.constructor = function(this__509)
  return nil;
end;
OrderClause = temper.type('OrderClause');
OrderClause.constructor = function(this__512, field__1341, ascending__1342, nullsPos__1343)
  if (nullsPos__1343 == nil) then
    nullsPos__1343 = temper.null;
  end
  this__512.field__1337 = field__1341;
  this__512.ascending__1338 = ascending__1342;
  this__512.nullsPos__1339 = nullsPos__1343;
  return nil;
end;
OrderClause.get.field = function(this__2370)
  return this__2370.field__1337;
end;
OrderClause.get.ascending = function(this__2373)
  return this__2373.ascending__1338;
end;
OrderClause.get.nullsPos = function(this__2376)
  return this__2376.nullsPos__1339;
end;
LockMode = temper.type('LockMode');
LockMode.methods.keyword = function(this__323)
  temper.virtual();
end;
ForUpdate = temper.type('ForUpdate', LockMode);
ForUpdate.methods.keyword = function(this__324)
  return ' FOR UPDATE';
end;
ForUpdate.constructor = function(this__516)
  return nil;
end;
ForShare = temper.type('ForShare', LockMode);
ForShare.methods.keyword = function(this__325)
  return ' FOR SHARE';
end;
ForShare.constructor = function(this__519)
  return nil;
end;
WhereClause = temper.type('WhereClause');
WhereClause.get.condition = function(this__326)
  temper.virtual();
end;
WhereClause.methods.keyword = function(this__327)
  temper.virtual();
end;
AndCondition = temper.type('AndCondition', WhereClause);
AndCondition.get.condition = function(this__328)
  return this__328._condition__1356;
end;
AndCondition.methods.keyword = function(this__329)
  return 'AND';
end;
AndCondition.constructor = function(this__526, _condition__1362)
  this__526._condition__1356 = _condition__1362;
  return nil;
end;
OrCondition = temper.type('OrCondition', WhereClause);
OrCondition.get.condition = function(this__330)
  return this__330._condition__1363;
end;
OrCondition.methods.keyword = function(this__331)
  return 'OR';
end;
OrCondition.constructor = function(this__531, _condition__1369)
  this__531._condition__1363 = _condition__1369;
  return nil;
end;
Query = temper.type('Query');
Query.methods.where = function(this__332, condition__1400)
  local nb__1402;
  nb__1402 = temper.list_tolistbuilder(this__332.conditions__1388);
  temper.listbuilder_add(nb__1402, AndCondition(condition__1400));
  return Query(this__332.tableName__1387, temper.listbuilder_tolist(nb__1402), this__332.selectedFields__1389, this__332.orderClauses__1390, this__332.limitVal__1391, this__332.offsetVal__1392, this__332.joinClauses__1393, this__332.groupByFields__1394, this__332.havingConditions__1395, this__332.isDistinct__1396, this__332.selectExprs__1397, this__332.lockMode__1398);
end;
Query.methods.orWhere = function(this__333, condition__1404)
  local nb__1406;
  nb__1406 = temper.list_tolistbuilder(this__333.conditions__1388);
  temper.listbuilder_add(nb__1406, OrCondition(condition__1404));
  return Query(this__333.tableName__1387, temper.listbuilder_tolist(nb__1406), this__333.selectedFields__1389, this__333.orderClauses__1390, this__333.limitVal__1391, this__333.offsetVal__1392, this__333.joinClauses__1393, this__333.groupByFields__1394, this__333.havingConditions__1395, this__333.isDistinct__1396, this__333.selectExprs__1397, this__333.lockMode__1398);
end;
Query.methods.whereNull = function(this__334, field__1408)
  local b__1410, t_130;
  b__1410 = SqlBuilder();
  b__1410:appendSafe(field__1408.sqlValue);
  b__1410:appendSafe(' IS NULL');
  t_130 = b__1410.accumulated;
  return this__334:where(t_130);
end;
Query.methods.whereNotNull = function(this__335, field__1412)
  local b__1414, t_131;
  b__1414 = SqlBuilder();
  b__1414:appendSafe(field__1412.sqlValue);
  b__1414:appendSafe(' IS NOT NULL');
  t_131 = b__1414.accumulated;
  return this__335:where(t_131);
end;
Query.methods.whereIn = function(this__336, field__1416, values__1417)
  local return__555, t_132, t_133, t_134, b__1420, i__1421;
  ::continue_41::
  if temper.listed_isempty(values__1417) then
    local b__1419;
    b__1419 = SqlBuilder();
    b__1419:appendSafe('1 = 0');
    t_132 = b__1419.accumulated;
    return__555 = this__336:where(t_132);
    goto break_40;
  end
  b__1420 = SqlBuilder();
  b__1420:appendSafe(field__1416.sqlValue);
  b__1420:appendSafe(' IN (');
  b__1420:appendPart(temper.list_get(values__1417, 0));
  i__1421 = 1;
  while true do
    t_133 = temper.list_length(values__1417);
    if not (i__1421 < t_133) then
      break;
    end
    b__1420:appendSafe(', ');
    b__1420:appendPart(temper.list_get(values__1417, i__1421));
    i__1421 = temper.int32_add(i__1421, 1);
  end
  b__1420:appendSafe(')');
  t_134 = b__1420.accumulated;
  return__555 = this__336:where(t_134);
  ::break_40::return return__555;
end;
Query.methods.whereInSubquery = function(this__337, field__1423, sub__1424)
  local b__1426, t_135;
  b__1426 = SqlBuilder();
  b__1426:appendSafe(field__1423.sqlValue);
  b__1426:appendSafe(' IN (');
  b__1426:appendFragment(sub__1424:toSql());
  b__1426:appendSafe(')');
  t_135 = b__1426.accumulated;
  return this__337:where(t_135);
end;
Query.methods.whereNot = function(this__338, condition__1428)
  local b__1430, t_136;
  b__1430 = SqlBuilder();
  b__1430:appendSafe('NOT (');
  b__1430:appendFragment(condition__1428);
  b__1430:appendSafe(')');
  t_136 = b__1430.accumulated;
  return this__338:where(t_136);
end;
Query.methods.whereBetween = function(this__339, field__1432, low__1433, high__1434)
  local b__1436, t_137;
  b__1436 = SqlBuilder();
  b__1436:appendSafe(field__1432.sqlValue);
  b__1436:appendSafe(' BETWEEN ');
  b__1436:appendPart(low__1433);
  b__1436:appendSafe(' AND ');
  b__1436:appendPart(high__1434);
  t_137 = b__1436.accumulated;
  return this__339:where(t_137);
end;
Query.methods.whereLike = function(this__340, field__1438, pattern__1439)
  local b__1441, t_138;
  b__1441 = SqlBuilder();
  b__1441:appendSafe(field__1438.sqlValue);
  b__1441:appendSafe(' LIKE ');
  b__1441:appendString(pattern__1439);
  t_138 = b__1441.accumulated;
  return this__340:where(t_138);
end;
Query.methods.whereILike = function(this__341, field__1443, pattern__1444)
  local b__1446, t_139;
  b__1446 = SqlBuilder();
  b__1446:appendSafe(field__1443.sqlValue);
  b__1446:appendSafe(' ILIKE ');
  b__1446:appendString(pattern__1444);
  t_139 = b__1446.accumulated;
  return this__341:where(t_139);
end;
Query.methods.select = function(this__342, fields__1448)
  return Query(this__342.tableName__1387, this__342.conditions__1388, fields__1448, this__342.orderClauses__1390, this__342.limitVal__1391, this__342.offsetVal__1392, this__342.joinClauses__1393, this__342.groupByFields__1394, this__342.havingConditions__1395, this__342.isDistinct__1396, this__342.selectExprs__1397, this__342.lockMode__1398);
end;
Query.methods.selectExpr = function(this__343, exprs__1451)
  return Query(this__343.tableName__1387, this__343.conditions__1388, this__343.selectedFields__1389, this__343.orderClauses__1390, this__343.limitVal__1391, this__343.offsetVal__1392, this__343.joinClauses__1393, this__343.groupByFields__1394, this__343.havingConditions__1395, this__343.isDistinct__1396, exprs__1451, this__343.lockMode__1398);
end;
Query.methods.orderBy = function(this__344, field__1454, ascending__1455)
  local nb__1457;
  nb__1457 = temper.list_tolistbuilder(this__344.orderClauses__1390);
  temper.listbuilder_add(nb__1457, OrderClause(field__1454, ascending__1455, temper.null));
  return Query(this__344.tableName__1387, this__344.conditions__1388, this__344.selectedFields__1389, temper.listbuilder_tolist(nb__1457), this__344.limitVal__1391, this__344.offsetVal__1392, this__344.joinClauses__1393, this__344.groupByFields__1394, this__344.havingConditions__1395, this__344.isDistinct__1396, this__344.selectExprs__1397, this__344.lockMode__1398);
end;
Query.methods.orderByNulls = function(this__345, field__1459, ascending__1460, nulls__1461)
  local nb__1463;
  nb__1463 = temper.list_tolistbuilder(this__345.orderClauses__1390);
  temper.listbuilder_add(nb__1463, OrderClause(field__1459, ascending__1460, nulls__1461));
  return Query(this__345.tableName__1387, this__345.conditions__1388, this__345.selectedFields__1389, temper.listbuilder_tolist(nb__1463), this__345.limitVal__1391, this__345.offsetVal__1392, this__345.joinClauses__1393, this__345.groupByFields__1394, this__345.havingConditions__1395, this__345.isDistinct__1396, this__345.selectExprs__1397, this__345.lockMode__1398);
end;
Query.methods.limit = function(this__346, n__1465)
  if (n__1465 < 0) then
    temper.bubble();
  end
  return Query(this__346.tableName__1387, this__346.conditions__1388, this__346.selectedFields__1389, this__346.orderClauses__1390, n__1465, this__346.offsetVal__1392, this__346.joinClauses__1393, this__346.groupByFields__1394, this__346.havingConditions__1395, this__346.isDistinct__1396, this__346.selectExprs__1397, this__346.lockMode__1398);
end;
Query.methods.offset = function(this__347, n__1468)
  if (n__1468 < 0) then
    temper.bubble();
  end
  return Query(this__347.tableName__1387, this__347.conditions__1388, this__347.selectedFields__1389, this__347.orderClauses__1390, this__347.limitVal__1391, n__1468, this__347.joinClauses__1393, this__347.groupByFields__1394, this__347.havingConditions__1395, this__347.isDistinct__1396, this__347.selectExprs__1397, this__347.lockMode__1398);
end;
Query.methods.join = function(this__348, joinType__1471, table__1472, onCondition__1473)
  local nb__1475;
  nb__1475 = temper.list_tolistbuilder(this__348.joinClauses__1393);
  temper.listbuilder_add(nb__1475, JoinClause(joinType__1471, table__1472, onCondition__1473));
  return Query(this__348.tableName__1387, this__348.conditions__1388, this__348.selectedFields__1389, this__348.orderClauses__1390, this__348.limitVal__1391, this__348.offsetVal__1392, temper.listbuilder_tolist(nb__1475), this__348.groupByFields__1394, this__348.havingConditions__1395, this__348.isDistinct__1396, this__348.selectExprs__1397, this__348.lockMode__1398);
end;
Query.methods.innerJoin = function(this__349, table__1477, onCondition__1478)
  local t_140;
  t_140 = InnerJoin();
  return this__349:join(t_140, table__1477, onCondition__1478);
end;
Query.methods.leftJoin = function(this__350, table__1481, onCondition__1482)
  local t_141;
  t_141 = LeftJoin();
  return this__350:join(t_141, table__1481, onCondition__1482);
end;
Query.methods.rightJoin = function(this__351, table__1485, onCondition__1486)
  local t_142;
  t_142 = RightJoin();
  return this__351:join(t_142, table__1485, onCondition__1486);
end;
Query.methods.fullJoin = function(this__352, table__1489, onCondition__1490)
  local t_143;
  t_143 = FullJoin();
  return this__352:join(t_143, table__1489, onCondition__1490);
end;
Query.methods.crossJoin = function(this__353, table__1493)
  local nb__1495;
  nb__1495 = temper.list_tolistbuilder(this__353.joinClauses__1393);
  temper.listbuilder_add(nb__1495, JoinClause(CrossJoin(), table__1493, temper.null));
  return Query(this__353.tableName__1387, this__353.conditions__1388, this__353.selectedFields__1389, this__353.orderClauses__1390, this__353.limitVal__1391, this__353.offsetVal__1392, temper.listbuilder_tolist(nb__1495), this__353.groupByFields__1394, this__353.havingConditions__1395, this__353.isDistinct__1396, this__353.selectExprs__1397, this__353.lockMode__1398);
end;
Query.methods.groupBy = function(this__354, field__1497)
  local nb__1499;
  nb__1499 = temper.list_tolistbuilder(this__354.groupByFields__1394);
  temper.listbuilder_add(nb__1499, field__1497);
  return Query(this__354.tableName__1387, this__354.conditions__1388, this__354.selectedFields__1389, this__354.orderClauses__1390, this__354.limitVal__1391, this__354.offsetVal__1392, this__354.joinClauses__1393, temper.listbuilder_tolist(nb__1499), this__354.havingConditions__1395, this__354.isDistinct__1396, this__354.selectExprs__1397, this__354.lockMode__1398);
end;
Query.methods.having = function(this__355, condition__1501)
  local nb__1503;
  nb__1503 = temper.list_tolistbuilder(this__355.havingConditions__1395);
  temper.listbuilder_add(nb__1503, AndCondition(condition__1501));
  return Query(this__355.tableName__1387, this__355.conditions__1388, this__355.selectedFields__1389, this__355.orderClauses__1390, this__355.limitVal__1391, this__355.offsetVal__1392, this__355.joinClauses__1393, this__355.groupByFields__1394, temper.listbuilder_tolist(nb__1503), this__355.isDistinct__1396, this__355.selectExprs__1397, this__355.lockMode__1398);
end;
Query.methods.orHaving = function(this__356, condition__1505)
  local nb__1507;
  nb__1507 = temper.list_tolistbuilder(this__356.havingConditions__1395);
  temper.listbuilder_add(nb__1507, OrCondition(condition__1505));
  return Query(this__356.tableName__1387, this__356.conditions__1388, this__356.selectedFields__1389, this__356.orderClauses__1390, this__356.limitVal__1391, this__356.offsetVal__1392, this__356.joinClauses__1393, this__356.groupByFields__1394, temper.listbuilder_tolist(nb__1507), this__356.isDistinct__1396, this__356.selectExprs__1397, this__356.lockMode__1398);
end;
Query.methods.distinct = function(this__357)
  return Query(this__357.tableName__1387, this__357.conditions__1388, this__357.selectedFields__1389, this__357.orderClauses__1390, this__357.limitVal__1391, this__357.offsetVal__1392, this__357.joinClauses__1393, this__357.groupByFields__1394, this__357.havingConditions__1395, true, this__357.selectExprs__1397, this__357.lockMode__1398);
end;
Query.methods.lock = function(this__358, mode__1511)
  return Query(this__358.tableName__1387, this__358.conditions__1388, this__358.selectedFields__1389, this__358.orderClauses__1390, this__358.limitVal__1391, this__358.offsetVal__1392, this__358.joinClauses__1393, this__358.groupByFields__1394, this__358.havingConditions__1395, this__358.isDistinct__1396, this__358.selectExprs__1397, mode__1511);
end;
Query.methods.toSql = function(this__359)
  local t_144, b__1515, lv__1521, ov__1522, lm__1523;
  b__1515 = SqlBuilder();
  if this__359.isDistinct__1396 then
    b__1515:appendSafe('SELECT DISTINCT ');
  else
    b__1515:appendSafe('SELECT ');
  end
  if not temper.listed_isempty(this__359.selectExprs__1397) then
    local i__1516;
    b__1515:appendFragment(temper.list_get(this__359.selectExprs__1397, 0));
    i__1516 = 1;
    while true do
      t_144 = temper.list_length(this__359.selectExprs__1397);
      if not (i__1516 < t_144) then
        break;
      end
      b__1515:appendSafe(', ');
      b__1515:appendFragment(temper.list_get(this__359.selectExprs__1397, i__1516));
      i__1516 = temper.int32_add(i__1516, 1);
    end
  elseif temper.listed_isempty(this__359.selectedFields__1389) then
    b__1515:appendSafe('*');
  else
    local fn__15280;
    fn__15280 = function(f__1517)
      return f__1517.sqlValue;
    end;
    b__1515:appendSafe(temper.listed_join(this__359.selectedFields__1389, ', ', fn__15280));
  end
  b__1515:appendSafe(' FROM ');
  b__1515:appendSafe(this__359.tableName__1387.sqlValue);
  renderJoins__706(b__1515, this__359.joinClauses__1393);
  renderWhere__705(b__1515, this__359.conditions__1388);
  renderGroupBy__707(b__1515, this__359.groupByFields__1394);
  renderHaving__708(b__1515, this__359.havingConditions__1395);
  if not temper.listed_isempty(this__359.orderClauses__1390) then
    local first__1518, fn__15279;
    b__1515:appendSafe(' ORDER BY ');
    first__1518 = true;
    fn__15279 = function(orc__1519)
      local t_145, t_146, t_147, np__1520;
      if not first__1518 then
        b__1515:appendSafe(', ');
      end
      first__1518 = false;
      t_147 = orc__1519.field.sqlValue;
      b__1515:appendSafe(t_147);
      if orc__1519.ascending then
        t_146 = ' ASC';
      else
        t_146 = ' DESC';
      end
      b__1515:appendSafe(t_146);
      np__1520 = orc__1519.nullsPos;
      if not temper.is_null(np__1520) then
        t_145 = np__1520:keyword();
        b__1515:appendSafe(t_145);
      end
      return nil;
    end;
    temper.list_foreach(this__359.orderClauses__1390, fn__15279);
  end
  lv__1521 = this__359.limitVal__1391;
  if not temper.is_null(lv__1521) then
    local lv_148;
    lv_148 = lv__1521;
    b__1515:appendSafe(' LIMIT ');
    b__1515:appendInt32(lv_148);
  end
  ov__1522 = this__359.offsetVal__1392;
  if not temper.is_null(ov__1522) then
    local ov_149;
    ov_149 = ov__1522;
    b__1515:appendSafe(' OFFSET ');
    b__1515:appendInt32(ov_149);
  end
  lm__1523 = this__359.lockMode__1398;
  if not temper.is_null(lm__1523) then
    b__1515:appendSafe(lm__1523:keyword());
  end
  return b__1515.accumulated;
end;
Query.methods.countSql = function(this__360)
  local b__1526;
  b__1526 = SqlBuilder();
  b__1526:appendSafe('SELECT COUNT(*) FROM ');
  b__1526:appendSafe(this__360.tableName__1387.sqlValue);
  renderJoins__706(b__1526, this__360.joinClauses__1393);
  renderWhere__705(b__1526, this__360.conditions__1388);
  renderGroupBy__707(b__1526, this__360.groupByFields__1394);
  renderHaving__708(b__1526, this__360.havingConditions__1395);
  return b__1526.accumulated;
end;
Query.methods.safeToSql = function(this__361, defaultLimit__1528)
  local return__580, t_150;
  if (defaultLimit__1528 < 0) then
    temper.bubble();
  end
  if not temper.is_null(this__361.limitVal__1391) then
    return__580 = this__361:toSql();
  else
    t_150 = this__361:limit(defaultLimit__1528);
    return__580 = t_150:toSql();
  end
  return return__580;
end;
Query.constructor = function(this__539, tableName__1531, conditions__1532, selectedFields__1533, orderClauses__1534, limitVal__1535, offsetVal__1536, joinClauses__1537, groupByFields__1538, havingConditions__1539, isDistinct__1540, selectExprs__1541, lockMode__1542)
  if (limitVal__1535 == nil) then
    limitVal__1535 = temper.null;
  end
  if (offsetVal__1536 == nil) then
    offsetVal__1536 = temper.null;
  end
  if (lockMode__1542 == nil) then
    lockMode__1542 = temper.null;
  end
  this__539.tableName__1387 = tableName__1531;
  this__539.conditions__1388 = conditions__1532;
  this__539.selectedFields__1389 = selectedFields__1533;
  this__539.orderClauses__1390 = orderClauses__1534;
  this__539.limitVal__1391 = limitVal__1535;
  this__539.offsetVal__1392 = offsetVal__1536;
  this__539.joinClauses__1393 = joinClauses__1537;
  this__539.groupByFields__1394 = groupByFields__1538;
  this__539.havingConditions__1395 = havingConditions__1539;
  this__539.isDistinct__1396 = isDistinct__1540;
  this__539.selectExprs__1397 = selectExprs__1541;
  this__539.lockMode__1398 = lockMode__1542;
  return nil;
end;
Query.get.tableName = function(this__2379)
  return this__2379.tableName__1387;
end;
Query.get.conditions = function(this__2382)
  return this__2382.conditions__1388;
end;
Query.get.selectedFields = function(this__2385)
  return this__2385.selectedFields__1389;
end;
Query.get.orderClauses = function(this__2388)
  return this__2388.orderClauses__1390;
end;
Query.get.limitVal = function(this__2391)
  return this__2391.limitVal__1391;
end;
Query.get.offsetVal = function(this__2394)
  return this__2394.offsetVal__1392;
end;
Query.get.joinClauses = function(this__2397)
  return this__2397.joinClauses__1393;
end;
Query.get.groupByFields = function(this__2400)
  return this__2400.groupByFields__1394;
end;
Query.get.havingConditions = function(this__2403)
  return this__2403.havingConditions__1395;
end;
Query.get.isDistinct = function(this__2406)
  return this__2406.isDistinct__1396;
end;
Query.get.selectExprs = function(this__2409)
  return this__2409.selectExprs__1397;
end;
Query.get.lockMode = function(this__2412)
  return this__2412.lockMode__1398;
end;
SetClause = temper.type('SetClause');
SetClause.constructor = function(this__595, field__1592, value__1593)
  this__595.field__1589 = field__1592;
  this__595.value__1590 = value__1593;
  return nil;
end;
SetClause.get.field = function(this__2415)
  return this__2415.field__1589;
end;
SetClause.get.value = function(this__2418)
  return this__2418.value__1590;
end;
UpdateQuery = temper.type('UpdateQuery');
UpdateQuery.methods.set = function(this__362, field__1599, value__1600)
  local nb__1602;
  nb__1602 = temper.list_tolistbuilder(this__362.setClauses__1595);
  temper.listbuilder_add(nb__1602, SetClause(field__1599, value__1600));
  return UpdateQuery(this__362.tableName__1594, temper.listbuilder_tolist(nb__1602), this__362.conditions__1596, this__362.limitVal__1597);
end;
UpdateQuery.methods.where = function(this__363, condition__1604)
  local nb__1606;
  nb__1606 = temper.list_tolistbuilder(this__363.conditions__1596);
  temper.listbuilder_add(nb__1606, AndCondition(condition__1604));
  return UpdateQuery(this__363.tableName__1594, this__363.setClauses__1595, temper.listbuilder_tolist(nb__1606), this__363.limitVal__1597);
end;
UpdateQuery.methods.orWhere = function(this__364, condition__1608)
  local nb__1610;
  nb__1610 = temper.list_tolistbuilder(this__364.conditions__1596);
  temper.listbuilder_add(nb__1610, OrCondition(condition__1608));
  return UpdateQuery(this__364.tableName__1594, this__364.setClauses__1595, temper.listbuilder_tolist(nb__1610), this__364.limitVal__1597);
end;
UpdateQuery.methods.limit = function(this__365, n__1612)
  if (n__1612 < 0) then
    temper.bubble();
  end
  return UpdateQuery(this__365.tableName__1594, this__365.setClauses__1595, this__365.conditions__1596, n__1612);
end;
UpdateQuery.methods.toSql = function(this__366)
  local t_151, b__1616, i__1617, lv__1618;
  if temper.listed_isempty(this__366.conditions__1596) then
    temper.bubble();
  end
  if temper.listed_isempty(this__366.setClauses__1595) then
    temper.bubble();
  end
  b__1616 = SqlBuilder();
  b__1616:appendSafe('UPDATE ');
  b__1616:appendSafe(this__366.tableName__1594.sqlValue);
  b__1616:appendSafe(' SET ');
  b__1616:appendSafe((temper.list_get(this__366.setClauses__1595, 0)).field.sqlValue);
  b__1616:appendSafe(' = ');
  b__1616:appendPart((temper.list_get(this__366.setClauses__1595, 0)).value);
  i__1617 = 1;
  while true do
    t_151 = temper.list_length(this__366.setClauses__1595);
    if not (i__1617 < t_151) then
      break;
    end
    b__1616:appendSafe(', ');
    b__1616:appendSafe((temper.list_get(this__366.setClauses__1595, i__1617)).field.sqlValue);
    b__1616:appendSafe(' = ');
    b__1616:appendPart((temper.list_get(this__366.setClauses__1595, i__1617)).value);
    i__1617 = temper.int32_add(i__1617, 1);
  end
  renderWhere__705(b__1616, this__366.conditions__1596);
  lv__1618 = this__366.limitVal__1597;
  if not temper.is_null(lv__1618) then
    local lv_152;
    lv_152 = lv__1618;
    b__1616:appendSafe(' LIMIT ');
    b__1616:appendInt32(lv_152);
  end
  return b__1616.accumulated;
end;
UpdateQuery.constructor = function(this__597, tableName__1620, setClauses__1621, conditions__1622, limitVal__1623)
  if (limitVal__1623 == nil) then
    limitVal__1623 = temper.null;
  end
  this__597.tableName__1594 = tableName__1620;
  this__597.setClauses__1595 = setClauses__1621;
  this__597.conditions__1596 = conditions__1622;
  this__597.limitVal__1597 = limitVal__1623;
  return nil;
end;
UpdateQuery.get.tableName = function(this__2421)
  return this__2421.tableName__1594;
end;
UpdateQuery.get.setClauses = function(this__2424)
  return this__2424.setClauses__1595;
end;
UpdateQuery.get.conditions = function(this__2427)
  return this__2427.conditions__1596;
end;
UpdateQuery.get.limitVal = function(this__2430)
  return this__2430.limitVal__1597;
end;
DeleteQuery = temper.type('DeleteQuery');
DeleteQuery.methods.where = function(this__367, condition__1628)
  local nb__1630;
  nb__1630 = temper.list_tolistbuilder(this__367.conditions__1625);
  temper.listbuilder_add(nb__1630, AndCondition(condition__1628));
  return DeleteQuery(this__367.tableName__1624, temper.listbuilder_tolist(nb__1630), this__367.limitVal__1626);
end;
DeleteQuery.methods.orWhere = function(this__368, condition__1632)
  local nb__1634;
  nb__1634 = temper.list_tolistbuilder(this__368.conditions__1625);
  temper.listbuilder_add(nb__1634, OrCondition(condition__1632));
  return DeleteQuery(this__368.tableName__1624, temper.listbuilder_tolist(nb__1634), this__368.limitVal__1626);
end;
DeleteQuery.methods.limit = function(this__369, n__1636)
  if (n__1636 < 0) then
    temper.bubble();
  end
  return DeleteQuery(this__369.tableName__1624, this__369.conditions__1625, n__1636);
end;
DeleteQuery.methods.toSql = function(this__370)
  local b__1640, lv__1641;
  if temper.listed_isempty(this__370.conditions__1625) then
    temper.bubble();
  end
  b__1640 = SqlBuilder();
  b__1640:appendSafe('DELETE FROM ');
  b__1640:appendSafe(this__370.tableName__1624.sqlValue);
  renderWhere__705(b__1640, this__370.conditions__1625);
  lv__1641 = this__370.limitVal__1626;
  if not temper.is_null(lv__1641) then
    local lv_153;
    lv_153 = lv__1641;
    b__1640:appendSafe(' LIMIT ');
    b__1640:appendInt32(lv_153);
  end
  return b__1640.accumulated;
end;
DeleteQuery.constructor = function(this__607, tableName__1643, conditions__1644, limitVal__1645)
  if (limitVal__1645 == nil) then
    limitVal__1645 = temper.null;
  end
  this__607.tableName__1624 = tableName__1643;
  this__607.conditions__1625 = conditions__1644;
  this__607.limitVal__1626 = limitVal__1645;
  return nil;
end;
DeleteQuery.get.tableName = function(this__2433)
  return this__2433.tableName__1624;
end;
DeleteQuery.get.conditions = function(this__2436)
  return this__2436.conditions__1625;
end;
DeleteQuery.get.limitVal = function(this__2439)
  return this__2439.limitVal__1626;
end;
SafeIdentifier = temper.type('SafeIdentifier');
SafeIdentifier.get.sqlValue = function(this__371)
  temper.virtual();
end;
ValidatedIdentifier__372 = temper.type('ValidatedIdentifier__372', SafeIdentifier);
ValidatedIdentifier__372.get.sqlValue = function(this__373)
  return this__373._value__1901;
end;
ValidatedIdentifier__372.constructor = function(this__621, _value__1905)
  this__621._value__1901 = _value__1905;
  return nil;
end;
FieldType = temper.type('FieldType');
StringField = temper.type('StringField', FieldType);
StringField.constructor = function(this__627)
  return nil;
end;
IntField = temper.type('IntField', FieldType);
IntField.constructor = function(this__629)
  return nil;
end;
Int64Field = temper.type('Int64Field', FieldType);
Int64Field.constructor = function(this__631)
  return nil;
end;
FloatField = temper.type('FloatField', FieldType);
FloatField.constructor = function(this__633)
  return nil;
end;
BoolField = temper.type('BoolField', FieldType);
BoolField.constructor = function(this__635)
  return nil;
end;
DateField = temper.type('DateField', FieldType);
DateField.constructor = function(this__637)
  return nil;
end;
FieldDef = temper.type('FieldDef');
FieldDef.constructor = function(this__639, name__1925, fieldType__1926, nullable__1927, defaultValue__1928, virtual__1929)
  if (defaultValue__1928 == nil) then
    defaultValue__1928 = temper.null;
  end
  this__639.name__1919 = name__1925;
  this__639.fieldType__1920 = fieldType__1926;
  this__639.nullable__1921 = nullable__1927;
  this__639.defaultValue__1922 = defaultValue__1928;
  this__639.virtual__1923 = virtual__1929;
  return nil;
end;
FieldDef.get.name = function(this__2225)
  return this__2225.name__1919;
end;
FieldDef.get.fieldType = function(this__2228)
  return this__2228.fieldType__1920;
end;
FieldDef.get.nullable = function(this__2231)
  return this__2231.nullable__1921;
end;
FieldDef.get.defaultValue = function(this__2234)
  return this__2234.defaultValue__1922;
end;
FieldDef.get.virtual = function(this__2237)
  return this__2237.virtual__1923;
end;
TableDef = temper.type('TableDef');
TableDef.methods.field = function(this__374, name__1934)
  local return__646, this__10148, n__10149, i__10150;
  ::continue_43::this__10148 = this__374.fields__1931;
  n__10149 = temper.list_length(this__10148);
  i__10150 = 0;
  while (i__10150 < n__10149) do
    local el__10151, f__1936;
    el__10151 = temper.list_get(this__10148, i__10150);
    i__10150 = temper.int32_add(i__10150, 1);
    f__1936 = el__10151;
    if temper.str_eq(f__1936.name.sqlValue, name__1934) then
      return__646 = f__1936;
      goto break_42;
    end
  end
  temper.bubble();
  ::break_42::return return__646;
end;
TableDef.methods.pkName = function(this__375)
  local return__647, pk__1939;
  ::continue_45::pk__1939 = this__375.primaryKey__1932;
  if not temper.is_null(pk__1939) then
    local pk_154;
    pk_154 = pk__1939;
    return__647 = pk_154.sqlValue;
    goto break_44;
  end
  return__647 = 'id';
  ::break_44::return return__647;
end;
TableDef.constructor = function(this__642, tableName__1941, fields__1942, primaryKey__1943)
  if (primaryKey__1943 == nil) then
    primaryKey__1943 = temper.null;
  end
  this__642.tableName__1930 = tableName__1941;
  this__642.fields__1931 = fields__1942;
  this__642.primaryKey__1932 = primaryKey__1943;
  return nil;
end;
TableDef.get.tableName = function(this__2240)
  return this__2240.tableName__1930;
end;
TableDef.get.fields = function(this__2243)
  return this__2243.fields__1931;
end;
TableDef.get.primaryKey = function(this__2246)
  return this__2246.primaryKey__1932;
end;
SqlBuilder = temper.type('SqlBuilder');
SqlBuilder.methods.appendSafe = function(this__376, sqlSource__1986)
  local t_155;
  t_155 = SqlSource(sqlSource__1986);
  temper.listbuilder_add(this__376.buffer__1984, t_155);
  return nil;
end;
SqlBuilder.methods.appendFragment = function(this__377, fragment__1989)
  local t_156;
  t_156 = fragment__1989.parts;
  temper.listbuilder_addall(this__377.buffer__1984, t_156);
  return nil;
end;
SqlBuilder.methods.appendPart = function(this__378, part__1992)
  temper.listbuilder_add(this__378.buffer__1984, part__1992);
  return nil;
end;
SqlBuilder.methods.appendPartList = function(this__379, values__1995)
  local fn__17333;
  fn__17333 = function(x__1997)
    this__379:appendPart(x__1997);
    return nil;
  end;
  this__379:appendList(values__1995, fn__17333);
  return nil;
end;
SqlBuilder.methods.appendBoolean = function(this__380, value__1999)
  local t_157;
  t_157 = SqlBoolean(value__1999);
  temper.listbuilder_add(this__380.buffer__1984, t_157);
  return nil;
end;
SqlBuilder.methods.appendBooleanList = function(this__381, values__2002)
  local fn__17327;
  fn__17327 = function(x__2004)
    this__381:appendBoolean(x__2004);
    return nil;
  end;
  this__381:appendList(values__2002, fn__17327);
  return nil;
end;
SqlBuilder.methods.appendDate = function(this__382, value__2006)
  local t_158;
  t_158 = SqlDate(value__2006);
  temper.listbuilder_add(this__382.buffer__1984, t_158);
  return nil;
end;
SqlBuilder.methods.appendDateList = function(this__383, values__2009)
  local fn__17321;
  fn__17321 = function(x__2011)
    this__383:appendDate(x__2011);
    return nil;
  end;
  this__383:appendList(values__2009, fn__17321);
  return nil;
end;
SqlBuilder.methods.appendFloat64 = function(this__384, value__2013)
  local t_159;
  t_159 = SqlFloat64(value__2013);
  temper.listbuilder_add(this__384.buffer__1984, t_159);
  return nil;
end;
SqlBuilder.methods.appendFloat64List = function(this__385, values__2016)
  local fn__17315;
  fn__17315 = function(x__2018)
    this__385:appendFloat64(x__2018);
    return nil;
  end;
  this__385:appendList(values__2016, fn__17315);
  return nil;
end;
SqlBuilder.methods.appendInt32 = function(this__386, value__2020)
  local t_160;
  t_160 = SqlInt32(value__2020);
  temper.listbuilder_add(this__386.buffer__1984, t_160);
  return nil;
end;
SqlBuilder.methods.appendInt32List = function(this__387, values__2023)
  local fn__17309;
  fn__17309 = function(x__2025)
    this__387:appendInt32(x__2025);
    return nil;
  end;
  this__387:appendList(values__2023, fn__17309);
  return nil;
end;
SqlBuilder.methods.appendInt64 = function(this__388, value__2027)
  local t_161;
  t_161 = SqlInt64(value__2027);
  temper.listbuilder_add(this__388.buffer__1984, t_161);
  return nil;
end;
SqlBuilder.methods.appendInt64List = function(this__389, values__2030)
  local fn__17303;
  fn__17303 = function(x__2032)
    this__389:appendInt64(x__2032);
    return nil;
  end;
  this__389:appendList(values__2030, fn__17303);
  return nil;
end;
SqlBuilder.methods.appendString = function(this__390, value__2034)
  local t_162;
  t_162 = SqlString(value__2034);
  temper.listbuilder_add(this__390.buffer__1984, t_162);
  return nil;
end;
SqlBuilder.methods.appendStringList = function(this__391, values__2037)
  local fn__17297;
  fn__17297 = function(x__2039)
    this__391:appendString(x__2039);
    return nil;
  end;
  this__391:appendList(values__2037, fn__17297);
  return nil;
end;
SqlBuilder.methods.appendList = function(this__392, values__2041, appendValue__2042)
  local t_163, t_164, i__2044;
  i__2044 = 0;
  while true do
    t_163 = temper.listed_length(values__2041);
    if not (i__2044 < t_163) then
      break;
    end
    if (i__2044 > 0) then
      this__392:appendSafe(', ');
    end
    t_164 = temper.listed_get(values__2041, i__2044);
    appendValue__2042(t_164);
    i__2044 = temper.int32_add(i__2044, 1);
  end
  return nil;
end;
SqlBuilder.get.accumulated = function(this__393)
  return SqlFragment(temper.listbuilder_tolist(this__393.buffer__1984));
end;
SqlBuilder.constructor = function(this__650)
  local t_165;
  t_165 = temper.listbuilder_constructor();
  this__650.buffer__1984 = t_165;
  return nil;
end;
SqlFragment = temper.type('SqlFragment');
SqlFragment.methods.toSource = function(this__398)
  return SqlSource(this__398:toString());
end;
SqlFragment.methods.toString = function(this__399)
  local t_166, builder__2056, i__2057;
  builder__2056 = temper.stringbuilder_constructor();
  i__2057 = 0;
  while true do
    t_166 = temper.list_length(this__399.parts__2051);
    if not (i__2057 < t_166) then
      break;
    end
    temper.list_get(this__399.parts__2051, i__2057):formatTo(builder__2056);
    i__2057 = temper.int32_add(i__2057, 1);
  end
  return temper.stringbuilder_tostring(builder__2056);
end;
SqlFragment.constructor = function(this__671, parts__2059)
  this__671.parts__2051 = parts__2059;
  return nil;
end;
SqlFragment.get.parts = function(this__2252)
  return this__2252.parts__2051;
end;
SqlPart = temper.type('SqlPart');
SqlPart.methods.formatTo = function(this__400, builder__2061)
  temper.virtual();
end;
SqlSource = temper.type('SqlSource', SqlPart);
SqlSource.methods.formatTo = function(this__401, builder__2065)
  temper.stringbuilder_append(builder__2065, this__401.source__2063);
  return nil;
end;
SqlSource.constructor = function(this__677, source__2068)
  this__677.source__2063 = source__2068;
  return nil;
end;
SqlSource.get.source = function(this__2249)
  return this__2249.source__2063;
end;
SqlBoolean = temper.type('SqlBoolean', SqlPart);
SqlBoolean.methods.formatTo = function(this__402, builder__2071)
  local t_167;
  if this__402.value__2069 then
    t_167 = 'TRUE';
  else
    t_167 = 'FALSE';
  end
  temper.stringbuilder_append(builder__2071, t_167);
  return nil;
end;
SqlBoolean.constructor = function(this__680, value__2074)
  this__680.value__2069 = value__2074;
  return nil;
end;
SqlBoolean.get.value = function(this__2255)
  return this__2255.value__2069;
end;
SqlDate = temper.type('SqlDate', SqlPart);
SqlDate.methods.formatTo = function(this__403, builder__2077)
  local t_168, fn__17342;
  temper.stringbuilder_append(builder__2077, "'");
  t_168 = temper.date_tostring(this__403.value__2075);
  fn__17342 = function(c__2079)
    if (c__2079 == 39) then
      temper.stringbuilder_append(builder__2077, "''");
    else
      local local_169, local_170, local_171;
      local_169, local_170, local_171 = temper.pcall(function()
        temper.stringbuilder_appendcodepoint(builder__2077, c__2079);
      end);
      if local_169 then
      else
        temper.bubble();
      end
    end
    return nil;
  end;
  temper.string_foreach(t_168, fn__17342);
  temper.stringbuilder_append(builder__2077, "'");
  return nil;
end;
SqlDate.constructor = function(this__683, value__2081)
  this__683.value__2075 = value__2081;
  return nil;
end;
SqlDate.get.value = function(this__2270)
  return this__2270.value__2075;
end;
SqlFloat64 = temper.type('SqlFloat64', SqlPart);
SqlFloat64.methods.formatTo = function(this__404, builder__2084)
  local t_173, t_174, s__2086;
  s__2086 = temper.float64_tostring(this__404.value__2082);
  if temper.str_eq(s__2086, 'NaN') then
    t_174 = true;
  else
    if temper.str_eq(s__2086, 'Infinity') then
      t_173 = true;
    else
      t_173 = temper.str_eq(s__2086, '-Infinity');
    end
    t_174 = t_173;
  end
  if t_174 then
    temper.stringbuilder_append(builder__2084, 'NULL');
  else
    temper.stringbuilder_append(builder__2084, s__2086);
  end
  return nil;
end;
SqlFloat64.constructor = function(this__686, value__2088)
  this__686.value__2082 = value__2088;
  return nil;
end;
SqlFloat64.get.value = function(this__2267)
  return this__2267.value__2082;
end;
SqlInt32 = temper.type('SqlInt32', SqlPart);
SqlInt32.methods.formatTo = function(this__405, builder__2091)
  local t_175;
  t_175 = temper.int32_tostring(this__405.value__2089);
  temper.stringbuilder_append(builder__2091, t_175);
  return nil;
end;
SqlInt32.constructor = function(this__689, value__2094)
  this__689.value__2089 = value__2094;
  return nil;
end;
SqlInt32.get.value = function(this__2261)
  return this__2261.value__2089;
end;
SqlInt64 = temper.type('SqlInt64', SqlPart);
SqlInt64.methods.formatTo = function(this__406, builder__2097)
  local t_176;
  t_176 = temper.int64_tostring(this__406.value__2095);
  temper.stringbuilder_append(builder__2097, t_176);
  return nil;
end;
SqlInt64.constructor = function(this__692, value__2100)
  this__692.value__2095 = value__2100;
  return nil;
end;
SqlInt64.get.value = function(this__2264)
  return this__2264.value__2095;
end;
SqlDefault = temper.type('SqlDefault', SqlPart);
SqlDefault.methods.formatTo = function(this__407, builder__2102)
  temper.stringbuilder_append(builder__2102, 'DEFAULT');
  return nil;
end;
SqlDefault.constructor = function(this__695)
  return nil;
end;
SqlString = temper.type('SqlString', SqlPart);
SqlString.methods.formatTo = function(this__408, builder__2107)
  local fn__17356;
  temper.stringbuilder_append(builder__2107, "'");
  fn__17356 = function(c__2109)
    if (c__2109 == 39) then
      temper.stringbuilder_append(builder__2107, "''");
    else
      local local_177, local_178, local_179;
      local_177, local_178, local_179 = temper.pcall(function()
        temper.stringbuilder_appendcodepoint(builder__2107, c__2109);
      end);
      if local_177 then
      else
        temper.bubble();
      end
    end
    return nil;
  end;
  temper.string_foreach(this__408.value__2105, fn__17356);
  temper.stringbuilder_append(builder__2107, "'");
  return nil;
end;
SqlString.constructor = function(this__698, value__2111)
  this__698.value__2105 = value__2111;
  return nil;
end;
SqlString.get.value = function(this__2258)
  return this__2258.value__2105;
end;
changeset = function(tableDef__982, params__983)
  local t_181;
  t_181 = temper.map_constructor(temper.listof());
  return ChangesetImpl__286(tableDef__982, params__983, t_181, temper.listof(), true);
end;
isIdentStart__710 = function(c__1906)
  local return__624, t_182, t_183;
  if (c__1906 >= 97) then
    t_182 = (c__1906 <= 122);
  else
    t_182 = false;
  end
  if t_182 then
    return__624 = true;
  else
    if (c__1906 >= 65) then
      t_183 = (c__1906 <= 90);
    else
      t_183 = false;
    end
    if t_183 then
      return__624 = true;
    else
      return__624 = (c__1906 == 95);
    end
  end
  return return__624;
end;
isIdentPart__711 = function(c__1908)
  local return__625;
  if isIdentStart__710(c__1908) then
    return__625 = true;
  elseif (c__1908 >= 48) then
    return__625 = (c__1908 <= 57);
  else
    return__625 = false;
  end
  return return__625;
end;
safeIdentifier = function(name__1910)
  local t_184, idx__1912, t_185;
  if temper.string_isempty(name__1910) then
    temper.bubble();
  end
  idx__1912 = 1.0;
  if not isIdentStart__710(temper.string_get(name__1910, idx__1912)) then
    temper.bubble();
  end
  t_185 = temper.string_next(name__1910, idx__1912);
  idx__1912 = t_185;
  while true do
    if not temper.string_hasindex(name__1910, idx__1912) then
      break;
    end
    if not isIdentPart__711(temper.string_get(name__1910, idx__1912)) then
      temper.bubble();
    end
    t_184 = temper.string_next(name__1910, idx__1912);
    idx__1912 = t_184;
  end
  return ValidatedIdentifier__372(name__1910);
end;
timestamps = function()
  local t_507, t_508, t_509;
  t_507 = safeIdentifier('inserted_at');
  t_508 = FieldDef(t_507, DateField(), true, SqlDefault(), false);
  t_509 = safeIdentifier('updated_at');
  return temper.listof(t_508, FieldDef(t_509, DateField(), true, SqlDefault(), false));
end;
deleteSql = function(tableDef__1301, id__1302)
  local b__1304;
  b__1304 = SqlBuilder();
  b__1304:appendSafe('DELETE FROM ');
  b__1304:appendSafe(tableDef__1301.tableName.sqlValue);
  b__1304:appendSafe(' WHERE ');
  b__1304:appendSafe(tableDef__1301:pkName());
  b__1304:appendSafe(' = ');
  b__1304:appendInt32(id__1302);
  return b__1304.accumulated;
end;
renderWhere__705 = function(b__1370, conditions__1371)
  local t_697, t_698, t_699, t_700;
  if not temper.listed_isempty(conditions__1371) then
    local i__1373;
    b__1370:appendSafe(' WHERE ');
    t_697 = (temper.list_get(conditions__1371, 0)).condition;
    b__1370:appendFragment(t_697);
    i__1373 = 1;
    while true do
      t_698 = temper.list_length(conditions__1371);
      if not (i__1373 < t_698) then
        break;
      end
      b__1370:appendSafe(' ');
      t_699 = temper.list_get(conditions__1371, i__1373):keyword();
      b__1370:appendSafe(t_699);
      b__1370:appendSafe(' ');
      t_700 = (temper.list_get(conditions__1371, i__1373)).condition;
      b__1370:appendFragment(t_700);
      i__1373 = temper.int32_add(i__1373, 1);
    end
  end
  return nil;
end;
renderJoins__706 = function(b__1374, joinClauses__1375)
  local fn__15516;
  fn__15516 = function(jc__1377)
    local t_701, t_702, oc__1378;
    b__1374:appendSafe(' ');
    t_701 = jc__1377.joinType:keyword();
    b__1374:appendSafe(t_701);
    b__1374:appendSafe(' ');
    t_702 = jc__1377.table.sqlValue;
    b__1374:appendSafe(t_702);
    oc__1378 = jc__1377.onCondition;
    if not temper.is_null(oc__1378) then
      local oc_703;
      oc_703 = oc__1378;
      b__1374:appendSafe(' ON ');
      b__1374:appendFragment(oc_703);
    end
    return nil;
  end;
  temper.list_foreach(joinClauses__1375, fn__15516);
  return nil;
end;
renderGroupBy__707 = function(b__1379, groupByFields__1380)
  local t_704;
  if not temper.listed_isempty(groupByFields__1380) then
    local fn__15499;
    b__1379:appendSafe(' GROUP BY ');
    fn__15499 = function(f__1382)
      return f__1382.sqlValue;
    end;
    t_704 = temper.listed_join(groupByFields__1380, ', ', fn__15499);
    b__1379:appendSafe(t_704);
  end
  return nil;
end;
renderHaving__708 = function(b__1383, havingConditions__1384)
  local t_705, t_706, t_707, t_708;
  if not temper.listed_isempty(havingConditions__1384) then
    local i__1386;
    b__1383:appendSafe(' HAVING ');
    t_705 = (temper.list_get(havingConditions__1384, 0)).condition;
    b__1383:appendFragment(t_705);
    i__1386 = 1;
    while true do
      t_706 = temper.list_length(havingConditions__1384);
      if not (i__1386 < t_706) then
        break;
      end
      b__1383:appendSafe(' ');
      t_707 = temper.list_get(havingConditions__1384, i__1386):keyword();
      b__1383:appendSafe(t_707);
      b__1383:appendSafe(' ');
      t_708 = (temper.list_get(havingConditions__1384, i__1386)).condition;
      b__1383:appendFragment(t_708);
      i__1386 = temper.int32_add(i__1386, 1);
    end
  end
  return nil;
end;
from = function(tableName__1543)
  return Query(tableName__1543, temper.listof(), temper.listof(), temper.listof(), temper.null, temper.null, temper.listof(), temper.listof(), temper.listof(), false, temper.listof(), temper.null);
end;
col = function(table__1545, column__1546)
  local b__1548;
  b__1548 = SqlBuilder();
  b__1548:appendSafe(table__1545.sqlValue);
  b__1548:appendSafe('.');
  b__1548:appendSafe(column__1546.sqlValue);
  return b__1548.accumulated;
end;
countAll = function()
  local b__1550;
  b__1550 = SqlBuilder();
  b__1550:appendSafe('COUNT(*)');
  return b__1550.accumulated;
end;
countCol = function(field__1551)
  local b__1553;
  b__1553 = SqlBuilder();
  b__1553:appendSafe('COUNT(');
  b__1553:appendSafe(field__1551.sqlValue);
  b__1553:appendSafe(')');
  return b__1553.accumulated;
end;
sumCol = function(field__1554)
  local b__1556;
  b__1556 = SqlBuilder();
  b__1556:appendSafe('SUM(');
  b__1556:appendSafe(field__1554.sqlValue);
  b__1556:appendSafe(')');
  return b__1556.accumulated;
end;
avgCol = function(field__1557)
  local b__1559;
  b__1559 = SqlBuilder();
  b__1559:appendSafe('AVG(');
  b__1559:appendSafe(field__1557.sqlValue);
  b__1559:appendSafe(')');
  return b__1559.accumulated;
end;
minCol = function(field__1560)
  local b__1562;
  b__1562 = SqlBuilder();
  b__1562:appendSafe('MIN(');
  b__1562:appendSafe(field__1560.sqlValue);
  b__1562:appendSafe(')');
  return b__1562.accumulated;
end;
maxCol = function(field__1563)
  local b__1565;
  b__1565 = SqlBuilder();
  b__1565:appendSafe('MAX(');
  b__1565:appendSafe(field__1563.sqlValue);
  b__1565:appendSafe(')');
  return b__1565.accumulated;
end;
unionSql = function(a__1566, b__1567)
  local sb__1569;
  sb__1569 = SqlBuilder();
  sb__1569:appendSafe('(');
  sb__1569:appendFragment(a__1566:toSql());
  sb__1569:appendSafe(') UNION (');
  sb__1569:appendFragment(b__1567:toSql());
  sb__1569:appendSafe(')');
  return sb__1569.accumulated;
end;
unionAllSql = function(a__1570, b__1571)
  local sb__1573;
  sb__1573 = SqlBuilder();
  sb__1573:appendSafe('(');
  sb__1573:appendFragment(a__1570:toSql());
  sb__1573:appendSafe(') UNION ALL (');
  sb__1573:appendFragment(b__1571:toSql());
  sb__1573:appendSafe(')');
  return sb__1573.accumulated;
end;
intersectSql = function(a__1574, b__1575)
  local sb__1577;
  sb__1577 = SqlBuilder();
  sb__1577:appendSafe('(');
  sb__1577:appendFragment(a__1574:toSql());
  sb__1577:appendSafe(') INTERSECT (');
  sb__1577:appendFragment(b__1575:toSql());
  sb__1577:appendSafe(')');
  return sb__1577.accumulated;
end;
exceptSql = function(a__1578, b__1579)
  local sb__1581;
  sb__1581 = SqlBuilder();
  sb__1581:appendSafe('(');
  sb__1581:appendFragment(a__1578:toSql());
  sb__1581:appendSafe(') EXCEPT (');
  sb__1581:appendFragment(b__1579:toSql());
  sb__1581:appendSafe(')');
  return sb__1581.accumulated;
end;
subquery = function(q__1582, alias__1583)
  local b__1585;
  b__1585 = SqlBuilder();
  b__1585:appendSafe('(');
  b__1585:appendFragment(q__1582:toSql());
  b__1585:appendSafe(') AS ');
  b__1585:appendSafe(alias__1583.sqlValue);
  return b__1585.accumulated;
end;
existsSql = function(q__1586)
  local b__1588;
  b__1588 = SqlBuilder();
  b__1588:appendSafe('EXISTS (');
  b__1588:appendFragment(q__1586:toSql());
  b__1588:appendSafe(')');
  return b__1588.accumulated;
end;
update = function(tableName__1646)
  return UpdateQuery(tableName__1646, temper.listof(), temper.listof(), temper.null);
end;
deleteFrom = function(tableName__1648)
  return DeleteQuery(tableName__1648, temper.listof(), temper.null);
end;
exports = {};
exports.ChangesetError = ChangesetError;
exports.NumberValidationOpts = NumberValidationOpts;
exports.Changeset = Changeset;
exports.JoinType = JoinType;
exports.InnerJoin = InnerJoin;
exports.LeftJoin = LeftJoin;
exports.RightJoin = RightJoin;
exports.FullJoin = FullJoin;
exports.CrossJoin = CrossJoin;
exports.JoinClause = JoinClause;
exports.NullsPosition = NullsPosition;
exports.NullsFirst = NullsFirst;
exports.NullsLast = NullsLast;
exports.OrderClause = OrderClause;
exports.LockMode = LockMode;
exports.ForUpdate = ForUpdate;
exports.ForShare = ForShare;
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
exports.SqlDefault = SqlDefault;
exports.SqlString = SqlString;
exports.changeset = changeset;
exports.safeIdentifier = safeIdentifier;
exports.timestamps = timestamps;
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
