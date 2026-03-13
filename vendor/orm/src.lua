local temper = require('temper-core');
local ChangesetError, NumberValidationOpts, Changeset, ChangesetImpl__249, JoinType, InnerJoin, LeftJoin, RightJoin, FullJoin, CrossJoin, JoinClause, NullsPosition, NullsFirst, NullsLast, OrderClause, LockMode, ForUpdate, ForShare, WhereClause, AndCondition, OrCondition, Query, SetClause, UpdateQuery, DeleteQuery, SafeIdentifier, ValidatedIdentifier__334, FieldType, StringField, IntField, Int64Field, FloatField, BoolField, DateField, FieldDef, TableDef, SqlBuilder, SqlFragment, SqlPart, SqlSource, SqlBoolean, SqlDate, SqlFloat64, SqlInt32, SqlInt64, SqlDefault, SqlString, changeset, isIdentStart__663, isIdentPart__664, safeIdentifier, timestamps, deleteSql, from, col, countAll, countCol, sumCol, avgCol, minCol, maxCol, unionSql, unionAllSql, intersectSql, exceptSql, subquery, existsSql, update, deleteFrom, exports;
ChangesetError = temper.type('ChangesetError');
ChangesetError.constructor = function(this__371, field__670, message__671)
  this__371.field__667 = field__670;
  this__371.message__668 = message__671;
  return nil;
end;
ChangesetError.get.field = function(this__2052)
  return this__2052.field__667;
end;
ChangesetError.get.message = function(this__2055)
  return this__2055.message__668;
end;
NumberValidationOpts = temper.type('NumberValidationOpts');
NumberValidationOpts.constructor = function(this__373, greaterThan__678, lessThan__679, greaterThanOrEqual__680, lessThanOrEqual__681, equalTo__682)
  if (greaterThan__678 == nil) then
    greaterThan__678 = temper.null;
  end
  if (lessThan__679 == nil) then
    lessThan__679 = temper.null;
  end
  if (greaterThanOrEqual__680 == nil) then
    greaterThanOrEqual__680 = temper.null;
  end
  if (lessThanOrEqual__681 == nil) then
    lessThanOrEqual__681 = temper.null;
  end
  if (equalTo__682 == nil) then
    equalTo__682 = temper.null;
  end
  this__373.greaterThan__672 = greaterThan__678;
  this__373.lessThan__673 = lessThan__679;
  this__373.greaterThanOrEqual__674 = greaterThanOrEqual__680;
  this__373.lessThanOrEqual__675 = lessThanOrEqual__681;
  this__373.equalTo__676 = equalTo__682;
  return nil;
end;
NumberValidationOpts.get.greaterThan = function(this__2058)
  return this__2058.greaterThan__672;
end;
NumberValidationOpts.get.lessThan = function(this__2061)
  return this__2061.lessThan__673;
end;
NumberValidationOpts.get.greaterThanOrEqual = function(this__2064)
  return this__2064.greaterThanOrEqual__674;
end;
NumberValidationOpts.get.lessThanOrEqual = function(this__2067)
  return this__2067.lessThanOrEqual__675;
end;
NumberValidationOpts.get.equalTo = function(this__2070)
  return this__2070.equalTo__676;
end;
Changeset = temper.type('Changeset');
Changeset.get.tableDef = function(this__225)
  temper.virtual();
end;
Changeset.get.changes = function(this__226)
  temper.virtual();
end;
Changeset.get.errors = function(this__227)
  temper.virtual();
end;
Changeset.get.isValid = function(this__228)
  temper.virtual();
end;
Changeset.methods.cast = function(this__229, allowedFields__692)
  temper.virtual();
end;
Changeset.methods.validateRequired = function(this__230, fields__695)
  temper.virtual();
end;
Changeset.methods.validateLength = function(this__231, field__698, min__699, max__700)
  temper.virtual();
end;
Changeset.methods.validateInt = function(this__232, field__703)
  temper.virtual();
end;
Changeset.methods.validateInt64 = function(this__233, field__706)
  temper.virtual();
end;
Changeset.methods.validateFloat = function(this__234, field__709)
  temper.virtual();
end;
Changeset.methods.validateBool = function(this__235, field__712)
  temper.virtual();
end;
Changeset.methods.putChange = function(this__236, field__715, value__716)
  temper.virtual();
end;
Changeset.methods.getChange = function(this__237, field__719)
  temper.virtual();
end;
Changeset.methods.deleteChange = function(this__238, field__722)
  temper.virtual();
end;
Changeset.methods.validateInclusion = function(this__239, field__725, allowed__726)
  temper.virtual();
end;
Changeset.methods.validateExclusion = function(this__240, field__729, disallowed__730)
  temper.virtual();
end;
Changeset.methods.validateNumber = function(this__241, field__733, opts__734)
  temper.virtual();
end;
Changeset.methods.validateAcceptance = function(this__242, field__737)
  temper.virtual();
end;
Changeset.methods.validateConfirmation = function(this__243, field__740, confirmationField__741)
  temper.virtual();
end;
Changeset.methods.validateContains = function(this__244, field__744, substring__745)
  temper.virtual();
end;
Changeset.methods.validateStartsWith = function(this__245, field__748, prefix__749)
  temper.virtual();
end;
Changeset.methods.validateEndsWith = function(this__246, field__752, suffix__753)
  temper.virtual();
end;
Changeset.methods.toInsertSql = function(this__247)
  temper.virtual();
end;
Changeset.methods.toUpdateSql = function(this__248, id__758)
  temper.virtual();
end;
ChangesetImpl__249 = temper.type('ChangesetImpl__249', Changeset);
ChangesetImpl__249.get.tableDef = function(this__250)
  return this__250._tableDef__760;
end;
ChangesetImpl__249.get.changes = function(this__251)
  return this__251._changes__762;
end;
ChangesetImpl__249.get.errors = function(this__252)
  return this__252._errors__763;
end;
ChangesetImpl__249.get.isValid = function(this__253)
  return this__253._isValid__764;
end;
ChangesetImpl__249.methods.cast = function(this__254, allowedFields__774)
  local mb__776, fn__15462;
  mb__776 = temper.mapbuilder_constructor();
  fn__15462 = function(f__777)
    local t_0, t_1, val__778;
    t_1 = f__777.sqlValue;
    val__778 = temper.mapped_getor(this__254._params__761, t_1, '');
    if not temper.string_isempty(val__778) then
      t_0 = f__777.sqlValue;
      temper.mapbuilder_set(mb__776, t_0, val__778);
    end
    return nil;
  end;
  temper.list_foreach(allowedFields__774, fn__15462);
  return ChangesetImpl__249(this__254._tableDef__760, this__254._params__761, temper.mapped_tomap(mb__776), this__254._errors__763, this__254._isValid__764);
end;
ChangesetImpl__249.methods.validateRequired = function(this__255, fields__780)
  local return__422, t_2, t_3, t_4, t_5, eb__782, valid__783, fn__15451;
  ::continue_1::
  if not this__255._isValid__764 then
    return__422 = this__255;
    goto break_0;
  end
  eb__782 = temper.list_tolistbuilder(this__255._errors__763);
  valid__783 = true;
  fn__15451 = function(f__784)
    local t_6, t_7;
    t_7 = f__784.sqlValue;
    if not temper.mapped_has(this__255._changes__762, t_7) then
      t_6 = ChangesetError(f__784.sqlValue, 'is required');
      temper.listbuilder_add(eb__782, t_6);
      valid__783 = false;
    end
    return nil;
  end;
  temper.list_foreach(fields__780, fn__15451);
  t_3 = this__255._tableDef__760;
  t_4 = this__255._params__761;
  t_5 = this__255._changes__762;
  t_2 = temper.listbuilder_tolist(eb__782);
  return__422 = ChangesetImpl__249(t_3, t_4, t_5, t_2, valid__783);
  ::break_0::return return__422;
end;
ChangesetImpl__249.methods.validateLength = function(this__256, field__786, min__787, max__788)
  local return__423, t_8, t_9, t_10, t_11, t_12, t_13, val__790, len__791;
  ::continue_3::
  if not this__256._isValid__764 then
    return__423 = this__256;
    goto break_2;
  end
  t_8 = field__786.sqlValue;
  val__790 = temper.mapped_getor(this__256._changes__762, t_8, '');
  len__791 = temper.string_countbetween(val__790, 1.0, temper.string_end(val__790));
  if (len__791 < min__787) then
    t_10 = true;
  else
    t_10 = (len__791 > max__788);
  end
  if t_10 then
    local msg__792, eb__793;
    msg__792 = temper.concat('must be between ', temper.int32_tostring(min__787), ' and ', temper.int32_tostring(max__788), ' characters');
    eb__793 = temper.list_tolistbuilder(this__256._errors__763);
    temper.listbuilder_add(eb__793, ChangesetError(field__786.sqlValue, msg__792));
    t_11 = this__256._tableDef__760;
    t_12 = this__256._params__761;
    t_13 = this__256._changes__762;
    t_9 = temper.listbuilder_tolist(eb__793);
    return__423 = ChangesetImpl__249(t_11, t_12, t_13, t_9, false);
    goto break_2;
  end
  return__423 = this__256;
  ::break_2::return return__423;
end;
ChangesetImpl__249.methods.validateInt = function(this__257, field__795)
  local return__424, t_14, t_15, t_16, t_17, t_18, val__797, parseOk__798, local_19, local_20, local_21;
  ::continue_5::
  if not this__257._isValid__764 then
    return__424 = this__257;
    goto break_4;
  end
  t_14 = field__795.sqlValue;
  val__797 = temper.mapped_getor(this__257._changes__762, t_14, '');
  if temper.string_isempty(val__797) then
    return__424 = this__257;
    goto break_4;
  end
  local_19, local_20, local_21 = temper.pcall(function()
    temper.string_toint32(val__797);
    parseOk__798 = true;
  end);
  if local_19 then
  else
    parseOk__798 = false;
  end
  if not parseOk__798 then
    local eb__799;
    eb__799 = temper.list_tolistbuilder(this__257._errors__763);
    temper.listbuilder_add(eb__799, ChangesetError(field__795.sqlValue, 'must be an integer'));
    t_16 = this__257._tableDef__760;
    t_17 = this__257._params__761;
    t_18 = this__257._changes__762;
    t_15 = temper.listbuilder_tolist(eb__799);
    return__424 = ChangesetImpl__249(t_16, t_17, t_18, t_15, false);
    goto break_4;
  end
  return__424 = this__257;
  ::break_4::return return__424;
end;
ChangesetImpl__249.methods.validateInt64 = function(this__258, field__801)
  local return__425, t_23, t_24, t_25, t_26, t_27, val__803, parseOk__804, local_28, local_29, local_30;
  ::continue_7::
  if not this__258._isValid__764 then
    return__425 = this__258;
    goto break_6;
  end
  t_23 = field__801.sqlValue;
  val__803 = temper.mapped_getor(this__258._changes__762, t_23, '');
  if temper.string_isempty(val__803) then
    return__425 = this__258;
    goto break_6;
  end
  local_28, local_29, local_30 = temper.pcall(function()
    temper.string_toint64(val__803);
    parseOk__804 = true;
  end);
  if local_28 then
  else
    parseOk__804 = false;
  end
  if not parseOk__804 then
    local eb__805;
    eb__805 = temper.list_tolistbuilder(this__258._errors__763);
    temper.listbuilder_add(eb__805, ChangesetError(field__801.sqlValue, 'must be a 64-bit integer'));
    t_25 = this__258._tableDef__760;
    t_26 = this__258._params__761;
    t_27 = this__258._changes__762;
    t_24 = temper.listbuilder_tolist(eb__805);
    return__425 = ChangesetImpl__249(t_25, t_26, t_27, t_24, false);
    goto break_6;
  end
  return__425 = this__258;
  ::break_6::return return__425;
end;
ChangesetImpl__249.methods.validateFloat = function(this__259, field__807)
  local return__426, t_32, t_33, t_34, t_35, t_36, val__809, parseOk__810, local_37, local_38, local_39;
  ::continue_9::
  if not this__259._isValid__764 then
    return__426 = this__259;
    goto break_8;
  end
  t_32 = field__807.sqlValue;
  val__809 = temper.mapped_getor(this__259._changes__762, t_32, '');
  if temper.string_isempty(val__809) then
    return__426 = this__259;
    goto break_8;
  end
  local_37, local_38, local_39 = temper.pcall(function()
    temper.string_tofloat64(val__809);
    parseOk__810 = true;
  end);
  if local_37 then
  else
    parseOk__810 = false;
  end
  if not parseOk__810 then
    local eb__811;
    eb__811 = temper.list_tolistbuilder(this__259._errors__763);
    temper.listbuilder_add(eb__811, ChangesetError(field__807.sqlValue, 'must be a number'));
    t_34 = this__259._tableDef__760;
    t_35 = this__259._params__761;
    t_36 = this__259._changes__762;
    t_33 = temper.listbuilder_tolist(eb__811);
    return__426 = ChangesetImpl__249(t_34, t_35, t_36, t_33, false);
    goto break_8;
  end
  return__426 = this__259;
  ::break_8::return return__426;
end;
ChangesetImpl__249.methods.validateBool = function(this__260, field__813)
  local return__427, t_41, t_42, t_43, t_44, t_45, t_46, t_47, t_48, t_49, t_50, val__815, isTrue__816, isFalse__817;
  ::continue_11::
  if not this__260._isValid__764 then
    return__427 = this__260;
    goto break_10;
  end
  t_41 = field__813.sqlValue;
  val__815 = temper.mapped_getor(this__260._changes__762, t_41, '');
  if temper.string_isempty(val__815) then
    return__427 = this__260;
    goto break_10;
  end
  if temper.str_eq(val__815, 'true') then
    isTrue__816 = true;
  else
    if temper.str_eq(val__815, '1') then
      t_44 = true;
    else
      if temper.str_eq(val__815, 'yes') then
        t_43 = true;
      else
        t_43 = temper.str_eq(val__815, 'on');
      end
      t_44 = t_43;
    end
    isTrue__816 = t_44;
  end
  if temper.str_eq(val__815, 'false') then
    isFalse__817 = true;
  else
    if temper.str_eq(val__815, '0') then
      t_46 = true;
    else
      if temper.str_eq(val__815, 'no') then
        t_45 = true;
      else
        t_45 = temper.str_eq(val__815, 'off');
      end
      t_46 = t_45;
    end
    isFalse__817 = t_46;
  end
  if not isTrue__816 then
    t_47 = not isFalse__817;
  else
    t_47 = false;
  end
  if t_47 then
    local eb__818;
    eb__818 = temper.list_tolistbuilder(this__260._errors__763);
    temper.listbuilder_add(eb__818, ChangesetError(field__813.sqlValue, 'must be a boolean (true/false/1/0/yes/no/on/off)'));
    t_48 = this__260._tableDef__760;
    t_49 = this__260._params__761;
    t_50 = this__260._changes__762;
    t_42 = temper.listbuilder_tolist(eb__818);
    return__427 = ChangesetImpl__249(t_48, t_49, t_50, t_42, false);
    goto break_10;
  end
  return__427 = this__260;
  ::break_10::return return__427;
end;
ChangesetImpl__249.methods.putChange = function(this__261, field__820, value__821)
  local t_51, mb__823, pairs__824, i__825;
  mb__823 = temper.mapbuilder_constructor();
  pairs__824 = temper.mapped_tolist(this__261._changes__762);
  i__825 = 0;
  while true do
    t_51 = temper.list_length(pairs__824);
    if not (i__825 < t_51) then
      break;
    end
    temper.mapbuilder_set(mb__823, (temper.list_get(pairs__824, i__825)).key, (temper.list_get(pairs__824, i__825)).value);
    i__825 = temper.int32_add(i__825, 1);
  end
  temper.mapbuilder_set(mb__823, field__820.sqlValue, value__821);
  return ChangesetImpl__249(this__261._tableDef__760, this__261._params__761, temper.mapped_tomap(mb__823), this__261._errors__763, this__261._isValid__764);
end;
ChangesetImpl__249.methods.getChange = function(this__262, field__827)
  local t_52, t_53;
  t_52 = field__827.sqlValue;
  if not temper.mapped_has(this__262._changes__762, t_52) then
    temper.bubble();
  end
  t_53 = field__827.sqlValue;
  return temper.mapped_getor(this__262._changes__762, t_53, '');
end;
ChangesetImpl__249.methods.deleteChange = function(this__263, field__830)
  local t_54, mb__832, pairs__833, i__834;
  mb__832 = temper.mapbuilder_constructor();
  pairs__833 = temper.mapped_tolist(this__263._changes__762);
  i__834 = 0;
  while true do
    t_54 = temper.list_length(pairs__833);
    if not (i__834 < t_54) then
      break;
    end
    if temper.str_ne((temper.list_get(pairs__833, i__834)).key, field__830.sqlValue) then
      temper.mapbuilder_set(mb__832, (temper.list_get(pairs__833, i__834)).key, (temper.list_get(pairs__833, i__834)).value);
    end
    i__834 = temper.int32_add(i__834, 1);
  end
  return ChangesetImpl__249(this__263._tableDef__760, this__263._params__761, temper.mapped_tomap(mb__832), this__263._errors__763, this__263._isValid__764);
end;
ChangesetImpl__249.methods.validateInclusion = function(this__264, field__836, allowed__837)
  local return__431, t_55, t_56, t_57, t_58, t_59, t_60, val__839, found__840, fn__15351;
  ::continue_13::
  if not this__264._isValid__764 then
    return__431 = this__264;
    goto break_12;
  end
  t_55 = field__836.sqlValue;
  if not temper.mapped_has(this__264._changes__762, t_55) then
    return__431 = this__264;
    goto break_12;
  end
  t_56 = field__836.sqlValue;
  val__839 = temper.mapped_getor(this__264._changes__762, t_56, '');
  found__840 = false;
  fn__15351 = function(a__841)
    if temper.str_eq(a__841, val__839) then
      found__840 = true;
    end
    return nil;
  end;
  temper.list_foreach(allowed__837, fn__15351);
  if not found__840 then
    local eb__842;
    eb__842 = temper.list_tolistbuilder(this__264._errors__763);
    temper.listbuilder_add(eb__842, ChangesetError(field__836.sqlValue, 'is not included in the list'));
    t_58 = this__264._tableDef__760;
    t_59 = this__264._params__761;
    t_60 = this__264._changes__762;
    t_57 = temper.listbuilder_tolist(eb__842);
    return__431 = ChangesetImpl__249(t_58, t_59, t_60, t_57, false);
    goto break_12;
  end
  return__431 = this__264;
  ::break_12::return return__431;
end;
ChangesetImpl__249.methods.validateExclusion = function(this__265, field__844, disallowed__845)
  local return__432, t_61, t_62, t_63, t_64, t_65, t_66, val__847, found__848, fn__15338;
  ::continue_15::
  if not this__265._isValid__764 then
    return__432 = this__265;
    goto break_14;
  end
  t_61 = field__844.sqlValue;
  if not temper.mapped_has(this__265._changes__762, t_61) then
    return__432 = this__265;
    goto break_14;
  end
  t_62 = field__844.sqlValue;
  val__847 = temper.mapped_getor(this__265._changes__762, t_62, '');
  found__848 = false;
  fn__15338 = function(d__849)
    if temper.str_eq(d__849, val__847) then
      found__848 = true;
    end
    return nil;
  end;
  temper.list_foreach(disallowed__845, fn__15338);
  if found__848 then
    local eb__850;
    eb__850 = temper.list_tolistbuilder(this__265._errors__763);
    temper.listbuilder_add(eb__850, ChangesetError(field__844.sqlValue, 'is reserved'));
    t_64 = this__265._tableDef__760;
    t_65 = this__265._params__761;
    t_66 = this__265._changes__762;
    t_63 = temper.listbuilder_tolist(eb__850);
    return__432 = ChangesetImpl__249(t_64, t_65, t_66, t_63, false);
    goto break_14;
  end
  return__432 = this__265;
  ::break_14::return return__432;
end;
ChangesetImpl__249.methods.validateNumber = function(this__266, field__852, opts__853)
  local return__433, t_67, t_68, t_69, t_70, t_71, t_72, t_73, t_74, t_75, t_76, t_77, t_78, t_79, t_80, t_81, t_82, t_83, t_84, t_85, t_86, t_87, t_88, t_89, t_90, t_91, t_92, t_93, val__855, parseOk__856, local_94, local_95, local_96, num__858, local_98, local_99, local_100, gt__859, lt__861, gte__863, lte__865, eq__867;
  ::continue_17::
  if not this__266._isValid__764 then
    return__433 = this__266;
    goto break_16;
  end
  t_67 = field__852.sqlValue;
  if not temper.mapped_has(this__266._changes__762, t_67) then
    return__433 = this__266;
    goto break_16;
  end
  t_68 = field__852.sqlValue;
  val__855 = temper.mapped_getor(this__266._changes__762, t_68, '');
  local_94, local_95, local_96 = temper.pcall(function()
    temper.string_tofloat64(val__855);
    parseOk__856 = true;
  end);
  if local_94 then
  else
    parseOk__856 = false;
  end
  if not parseOk__856 then
    local eb__857;
    eb__857 = temper.list_tolistbuilder(this__266._errors__763);
    temper.listbuilder_add(eb__857, ChangesetError(field__852.sqlValue, 'must be a number'));
    t_75 = this__266._tableDef__760;
    t_76 = this__266._params__761;
    t_77 = this__266._changes__762;
    t_69 = temper.listbuilder_tolist(eb__857);
    return__433 = ChangesetImpl__249(t_75, t_76, t_77, t_69, false);
    goto break_16;
  end
  local_98, local_99, local_100 = temper.pcall(function()
    t_78 = temper.string_tofloat64(val__855);
    num__858 = t_78;
  end);
  if local_98 then
  else
    num__858 = 0.0;
  end
  gt__859 = opts__853.greaterThan;
  if not temper.is_null(gt__859) then
    local gt_102;
    gt_102 = gt__859;
    if not temper.float_gt(num__858, gt_102) then
      local eb__860;
      eb__860 = temper.list_tolistbuilder(this__266._errors__763);
      temper.listbuilder_add(eb__860, ChangesetError(field__852.sqlValue, temper.concat('must be greater than ', temper.float64_tostring(gt_102))));
      t_79 = this__266._tableDef__760;
      t_80 = this__266._params__761;
      t_81 = this__266._changes__762;
      t_70 = temper.listbuilder_tolist(eb__860);
      return__433 = ChangesetImpl__249(t_79, t_80, t_81, t_70, false);
      goto break_16;
    end
  end
  lt__861 = opts__853.lessThan;
  if not temper.is_null(lt__861) then
    local lt_103;
    lt_103 = lt__861;
    if not temper.float_lt(num__858, lt_103) then
      local eb__862;
      eb__862 = temper.list_tolistbuilder(this__266._errors__763);
      temper.listbuilder_add(eb__862, ChangesetError(field__852.sqlValue, temper.concat('must be less than ', temper.float64_tostring(lt_103))));
      t_82 = this__266._tableDef__760;
      t_83 = this__266._params__761;
      t_84 = this__266._changes__762;
      t_71 = temper.listbuilder_tolist(eb__862);
      return__433 = ChangesetImpl__249(t_82, t_83, t_84, t_71, false);
      goto break_16;
    end
  end
  gte__863 = opts__853.greaterThanOrEqual;
  if not temper.is_null(gte__863) then
    local gte_104;
    gte_104 = gte__863;
    if not temper.float_ge(num__858, gte_104) then
      local eb__864;
      eb__864 = temper.list_tolistbuilder(this__266._errors__763);
      temper.listbuilder_add(eb__864, ChangesetError(field__852.sqlValue, temper.concat('must be greater than or equal to ', temper.float64_tostring(gte_104))));
      t_85 = this__266._tableDef__760;
      t_86 = this__266._params__761;
      t_87 = this__266._changes__762;
      t_72 = temper.listbuilder_tolist(eb__864);
      return__433 = ChangesetImpl__249(t_85, t_86, t_87, t_72, false);
      goto break_16;
    end
  end
  lte__865 = opts__853.lessThanOrEqual;
  if not temper.is_null(lte__865) then
    local lte_105;
    lte_105 = lte__865;
    if not temper.float_le(num__858, lte_105) then
      local eb__866;
      eb__866 = temper.list_tolistbuilder(this__266._errors__763);
      temper.listbuilder_add(eb__866, ChangesetError(field__852.sqlValue, temper.concat('must be less than or equal to ', temper.float64_tostring(lte_105))));
      t_88 = this__266._tableDef__760;
      t_89 = this__266._params__761;
      t_90 = this__266._changes__762;
      t_73 = temper.listbuilder_tolist(eb__866);
      return__433 = ChangesetImpl__249(t_88, t_89, t_90, t_73, false);
      goto break_16;
    end
  end
  eq__867 = opts__853.equalTo;
  if not temper.is_null(eq__867) then
    local eq_106;
    eq_106 = eq__867;
    if not temper.float_eq(num__858, eq_106) then
      local eb__868;
      eb__868 = temper.list_tolistbuilder(this__266._errors__763);
      temper.listbuilder_add(eb__868, ChangesetError(field__852.sqlValue, temper.concat('must be equal to ', temper.float64_tostring(eq_106))));
      t_91 = this__266._tableDef__760;
      t_92 = this__266._params__761;
      t_93 = this__266._changes__762;
      t_74 = temper.listbuilder_tolist(eb__868);
      return__433 = ChangesetImpl__249(t_91, t_92, t_93, t_74, false);
      goto break_16;
    end
  end
  return__433 = this__266;
  ::break_16::return return__433;
end;
ChangesetImpl__249.methods.validateAcceptance = function(this__267, field__870)
  local return__434, t_107, t_108, t_109, t_110, t_111, t_112, t_113, t_114, val__872, accepted__873;
  ::continue_19::
  if not this__267._isValid__764 then
    return__434 = this__267;
    goto break_18;
  end
  t_107 = field__870.sqlValue;
  if not temper.mapped_has(this__267._changes__762, t_107) then
    return__434 = this__267;
    goto break_18;
  end
  t_108 = field__870.sqlValue;
  val__872 = temper.mapped_getor(this__267._changes__762, t_108, '');
  if temper.str_eq(val__872, 'true') then
    accepted__873 = true;
  else
    if temper.str_eq(val__872, '1') then
      t_111 = true;
    else
      if temper.str_eq(val__872, 'yes') then
        t_110 = true;
      else
        t_110 = temper.str_eq(val__872, 'on');
      end
      t_111 = t_110;
    end
    accepted__873 = t_111;
  end
  if not accepted__873 then
    local eb__874;
    eb__874 = temper.list_tolistbuilder(this__267._errors__763);
    temper.listbuilder_add(eb__874, ChangesetError(field__870.sqlValue, 'must be accepted'));
    t_112 = this__267._tableDef__760;
    t_113 = this__267._params__761;
    t_114 = this__267._changes__762;
    t_109 = temper.listbuilder_tolist(eb__874);
    return__434 = ChangesetImpl__249(t_112, t_113, t_114, t_109, false);
    goto break_18;
  end
  return__434 = this__267;
  ::break_18::return return__434;
end;
ChangesetImpl__249.methods.validateConfirmation = function(this__268, field__876, confirmationField__877)
  local return__435, t_115, t_116, t_117, t_118, t_119, t_120, t_121, val__879, conf__880;
  ::continue_21::
  if not this__268._isValid__764 then
    return__435 = this__268;
    goto break_20;
  end
  t_115 = field__876.sqlValue;
  if not temper.mapped_has(this__268._changes__762, t_115) then
    return__435 = this__268;
    goto break_20;
  end
  t_116 = field__876.sqlValue;
  val__879 = temper.mapped_getor(this__268._changes__762, t_116, '');
  t_117 = confirmationField__877.sqlValue;
  conf__880 = temper.mapped_getor(this__268._changes__762, t_117, '');
  if temper.str_ne(val__879, conf__880) then
    local eb__881;
    eb__881 = temper.list_tolistbuilder(this__268._errors__763);
    temper.listbuilder_add(eb__881, ChangesetError(confirmationField__877.sqlValue, 'does not match'));
    t_119 = this__268._tableDef__760;
    t_120 = this__268._params__761;
    t_121 = this__268._changes__762;
    t_118 = temper.listbuilder_tolist(eb__881);
    return__435 = ChangesetImpl__249(t_119, t_120, t_121, t_118, false);
    goto break_20;
  end
  return__435 = this__268;
  ::break_20::return return__435;
end;
ChangesetImpl__249.methods.validateContains = function(this__269, field__883, substring__884)
  local return__436, t_122, t_123, t_124, t_125, t_126, t_127, val__886;
  ::continue_23::
  if not this__269._isValid__764 then
    return__436 = this__269;
    goto break_22;
  end
  t_122 = field__883.sqlValue;
  if not temper.mapped_has(this__269._changes__762, t_122) then
    return__436 = this__269;
    goto break_22;
  end
  t_123 = field__883.sqlValue;
  val__886 = temper.mapped_getor(this__269._changes__762, t_123, '');
  if not temper.is_string_index(temper.string_indexof(val__886, substring__884)) then
    local eb__887;
    eb__887 = temper.list_tolistbuilder(this__269._errors__763);
    temper.listbuilder_add(eb__887, ChangesetError(field__883.sqlValue, 'must contain the given substring'));
    t_125 = this__269._tableDef__760;
    t_126 = this__269._params__761;
    t_127 = this__269._changes__762;
    t_124 = temper.listbuilder_tolist(eb__887);
    return__436 = ChangesetImpl__249(t_125, t_126, t_127, t_124, false);
    goto break_22;
  end
  return__436 = this__269;
  ::break_22::return return__436;
end;
ChangesetImpl__249.methods.validateStartsWith = function(this__270, field__889, prefix__890)
  local return__437, t_128, t_129, t_130, t_131, t_132, t_133, t_134, val__892, idx__893, starts__894;
  ::continue_25::
  if not this__270._isValid__764 then
    return__437 = this__270;
    goto break_24;
  end
  t_128 = field__889.sqlValue;
  if not temper.mapped_has(this__270._changes__762, t_128) then
    return__437 = this__270;
    goto break_24;
  end
  t_129 = field__889.sqlValue;
  val__892 = temper.mapped_getor(this__270._changes__762, t_129, '');
  idx__893 = temper.string_indexof(val__892, prefix__890);
  if temper.is_string_index(idx__893) then
    t_130 = temper.string_countbetween(val__892, 1.0, temper.require_string_index(idx__893));
    starts__894 = (t_130 == 0);
  else
    starts__894 = false;
  end
  if not starts__894 then
    local eb__895;
    eb__895 = temper.list_tolistbuilder(this__270._errors__763);
    temper.listbuilder_add(eb__895, ChangesetError(field__889.sqlValue, 'must start with the given prefix'));
    t_132 = this__270._tableDef__760;
    t_133 = this__270._params__761;
    t_134 = this__270._changes__762;
    t_131 = temper.listbuilder_tolist(eb__895);
    return__437 = ChangesetImpl__249(t_132, t_133, t_134, t_131, false);
    goto break_24;
  end
  return__437 = this__270;
  ::break_24::return return__437;
end;
ChangesetImpl__249.methods.validateEndsWith = function(this__271, field__897, suffix__898)
  local return__438, t_135, t_136, t_137, t_138, t_139, t_140, t_141, t_142, t_143, t_144, t_145, t_146, t_147, t_148, t_149, t_150, val__900, valLen__901, suffixLen__902, skipCount__904, strIdx__905, i__906, sufIdx__907, matches__908;
  ::continue_27::
  if not this__271._isValid__764 then
    return__438 = this__271;
    goto break_26;
  end
  t_135 = field__897.sqlValue;
  if not temper.mapped_has(this__271._changes__762, t_135) then
    return__438 = this__271;
    goto break_26;
  end
  t_136 = field__897.sqlValue;
  val__900 = temper.mapped_getor(this__271._changes__762, t_136, '');
  valLen__901 = temper.string_countbetween(val__900, 1.0, temper.string_end(val__900));
  t_137 = temper.string_end(suffix__898);
  suffixLen__902 = temper.string_countbetween(suffix__898, 1.0, t_137);
  if (valLen__901 < suffixLen__902) then
    local eb__903;
    eb__903 = temper.list_tolistbuilder(this__271._errors__763);
    temper.listbuilder_add(eb__903, ChangesetError(field__897.sqlValue, 'must end with the given suffix'));
    t_144 = this__271._tableDef__760;
    t_145 = this__271._params__761;
    t_146 = this__271._changes__762;
    t_138 = temper.listbuilder_tolist(eb__903);
    return__438 = ChangesetImpl__249(t_144, t_145, t_146, t_138, false);
    goto break_26;
  end
  skipCount__904 = temper.int32_sub(valLen__901, suffixLen__902);
  strIdx__905 = 1.0;
  i__906 = 0;
  while (i__906 < skipCount__904) do
    t_139 = temper.string_next(val__900, strIdx__905);
    strIdx__905 = t_139;
    i__906 = temper.int32_add(i__906, 1);
  end
  sufIdx__907 = 1.0;
  matches__908 = true;
  while true do
    if matches__908 then
      t_140 = temper.string_hasindex(suffix__898, sufIdx__907);
      t_147 = t_140;
    else
      t_147 = false;
    end
    if not t_147 then
      break;
    end
    if not temper.string_hasindex(val__900, strIdx__905) then
      matches__908 = false;
    elseif (temper.string_get(val__900, strIdx__905) ~= temper.string_get(suffix__898, sufIdx__907)) then
      matches__908 = false;
    else
      t_141 = temper.string_next(val__900, strIdx__905);
      strIdx__905 = t_141;
      t_142 = temper.string_next(suffix__898, sufIdx__907);
      sufIdx__907 = t_142;
    end
  end
  if not matches__908 then
    local eb__909;
    eb__909 = temper.list_tolistbuilder(this__271._errors__763);
    temper.listbuilder_add(eb__909, ChangesetError(field__897.sqlValue, 'must end with the given suffix'));
    t_148 = this__271._tableDef__760;
    t_149 = this__271._params__761;
    t_150 = this__271._changes__762;
    t_143 = temper.listbuilder_tolist(eb__909);
    return__438 = ChangesetImpl__249(t_148, t_149, t_150, t_143, false);
    goto break_26;
  end
  return__438 = this__271;
  ::break_26::return return__438;
end;
ChangesetImpl__249.methods.parseBoolSqlPart = function(this__272, val__911)
  local return__439, t_151, t_152, t_153, t_154, t_155, t_156;
  ::continue_29::
  if temper.str_eq(val__911, 'true') then
    t_153 = true;
  else
    if temper.str_eq(val__911, '1') then
      t_152 = true;
    else
      if temper.str_eq(val__911, 'yes') then
        t_151 = true;
      else
        t_151 = temper.str_eq(val__911, 'on');
      end
      t_152 = t_151;
    end
    t_153 = t_152;
  end
  if t_153 then
    return__439 = SqlBoolean(true);
    goto break_28;
  end
  if temper.str_eq(val__911, 'false') then
    t_156 = true;
  else
    if temper.str_eq(val__911, '0') then
      t_155 = true;
    else
      if temper.str_eq(val__911, 'no') then
        t_154 = true;
      else
        t_154 = temper.str_eq(val__911, 'off');
      end
      t_155 = t_154;
    end
    t_156 = t_155;
  end
  if t_156 then
    return__439 = SqlBoolean(false);
    goto break_28;
  end
  temper.bubble();
  ::break_28::return return__439;
end;
ChangesetImpl__249.methods.valueToSqlPart = function(this__273, fieldDef__914, val__915)
  local return__440, t_157, t_158, t_159, t_160, ft__917;
  ::continue_31::ft__917 = fieldDef__914.fieldType;
  if temper.instance_of(ft__917, StringField) then
    return__440 = SqlString(val__915);
    goto break_30;
  end
  if temper.instance_of(ft__917, IntField) then
    t_157 = temper.string_toint32(val__915);
    return__440 = SqlInt32(t_157);
    goto break_30;
  end
  if temper.instance_of(ft__917, Int64Field) then
    t_158 = temper.string_toint64(val__915);
    return__440 = SqlInt64(t_158);
    goto break_30;
  end
  if temper.instance_of(ft__917, FloatField) then
    t_159 = temper.string_tofloat64(val__915);
    return__440 = SqlFloat64(t_159);
    goto break_30;
  end
  if temper.instance_of(ft__917, BoolField) then
    return__440 = this__273:parseBoolSqlPart(val__915);
    goto break_30;
  end
  if temper.instance_of(ft__917, DateField) then
    t_160 = temper.date_fromisostring(val__915);
    return__440 = SqlDate(t_160);
    goto break_30;
  end
  temper.bubble();
  ::break_30::return return__440;
end;
ChangesetImpl__249.methods.toInsertSql = function(this__274)
  local t_161, t_162, t_163, t_164, t_165, t_166, t_167, t_168, t_169, t_170, t_171, t_172, i__920, colNames__923, valParts__924, pairs__925, i__926, i__929, b__932, t_174, fn__15143, j__934;
  if not this__274._isValid__764 then
    temper.bubble();
  end
  i__920 = 0;
  while true do
    local f__921, dv__922;
    ::continue_33::t_161 = temper.list_length(this__274._tableDef__760.fields);
    if not (i__920 < t_161) then
      break;
    end
    f__921 = temper.list_get(this__274._tableDef__760.fields, i__920);
    if f__921.virtual then
      goto break_32;
    end
    dv__922 = f__921.defaultValue;
    if not f__921.nullable then
      t_162 = f__921.name.sqlValue;
      if not temper.mapped_has(this__274._changes__762, t_162) then
        t_169 = temper.is_null(dv__922);
      else
        t_169 = false;
      end
      t_170 = t_169;
    else
      t_170 = false;
    end
    if t_170 then
      temper.bubble();
    end
    ::break_32::i__920 = temper.int32_add(i__920, 1);
  end
  colNames__923 = temper.listbuilder_constructor();
  valParts__924 = temper.listbuilder_constructor();
  pairs__925 = temper.mapped_tolist(this__274._changes__762);
  i__926 = 0;
  while true do
    local pair__927, fd__928;
    ::continue_35::t_163 = temper.list_length(pairs__925);
    if not (i__926 < t_163) then
      break;
    end
    pair__927 = temper.list_get(pairs__925, i__926);
    t_164 = pair__927.key;
    t_171 = this__274._tableDef__760:field(t_164);
    fd__928 = t_171;
    if fd__928.virtual then
      goto break_34;
    end
    temper.listbuilder_add(colNames__923, fd__928.name.sqlValue);
    t_165 = pair__927.value;
    t_172 = this__274:valueToSqlPart(fd__928, t_165);
    temper.listbuilder_add(valParts__924, t_172);
    ::break_34::i__926 = temper.int32_add(i__926, 1);
  end
  i__929 = 0;
  while true do
    local f__930, dv__931;
    ::continue_37::t_166 = temper.list_length(this__274._tableDef__760.fields);
    if not (i__929 < t_166) then
      break;
    end
    f__930 = temper.list_get(this__274._tableDef__760.fields, i__929);
    if f__930.virtual then
      goto break_36;
    end
    dv__931 = f__930.defaultValue;
    if not temper.is_null(dv__931) then
      local dv_173;
      dv_173 = dv__931;
      t_167 = f__930.name.sqlValue;
      if not temper.mapped_has(this__274._changes__762, t_167) then
        temper.listbuilder_add(colNames__923, f__930.name.sqlValue);
        temper.listbuilder_add(valParts__924, dv_173);
      end
    end
    ::break_36::i__929 = temper.int32_add(i__929, 1);
  end
  if (temper.listbuilder_length(valParts__924) == 0) then
    temper.bubble();
  end
  b__932 = SqlBuilder();
  b__932:appendSafe('INSERT INTO ');
  b__932:appendSafe(this__274._tableDef__760.tableName.sqlValue);
  b__932:appendSafe(' (');
  t_174 = temper.listbuilder_tolist(colNames__923);
  fn__15143 = function(c__933)
    return c__933;
  end;
  b__932:appendSafe(temper.listed_join(t_174, ', ', fn__15143));
  b__932:appendSafe(') VALUES (');
  b__932:appendPart(temper.listed_get(valParts__924, 0));
  j__934 = 1;
  while true do
    t_168 = temper.listbuilder_length(valParts__924);
    if not (j__934 < t_168) then
      break;
    end
    b__932:appendSafe(', ');
    b__932:appendPart(temper.listed_get(valParts__924, j__934));
    j__934 = temper.int32_add(j__934, 1);
  end
  b__932:appendSafe(')');
  return b__932.accumulated;
end;
ChangesetImpl__249.methods.toUpdateSql = function(this__275, id__936)
  local t_175, t_176, t_177, t_178, t_179, pairs__938, b__939, setCount__940, i__941;
  if not this__275._isValid__764 then
    temper.bubble();
  end
  pairs__938 = temper.mapped_tolist(this__275._changes__762);
  if (temper.list_length(pairs__938) == 0) then
    temper.bubble();
  end
  b__939 = SqlBuilder();
  b__939:appendSafe('UPDATE ');
  b__939:appendSafe(this__275._tableDef__760.tableName.sqlValue);
  b__939:appendSafe(' SET ');
  setCount__940 = 0;
  i__941 = 0;
  while true do
    local pair__942, fd__943;
    ::continue_39::t_175 = temper.list_length(pairs__938);
    if not (i__941 < t_175) then
      break;
    end
    pair__942 = temper.list_get(pairs__938, i__941);
    t_176 = pair__942.key;
    t_178 = this__275._tableDef__760:field(t_176);
    fd__943 = t_178;
    if fd__943.virtual then
      goto break_38;
    end
    if (setCount__940 > 0) then
      b__939:appendSafe(', ');
    end
    b__939:appendSafe(fd__943.name.sqlValue);
    b__939:appendSafe(' = ');
    t_177 = pair__942.value;
    t_179 = this__275:valueToSqlPart(fd__943, t_177);
    b__939:appendPart(t_179);
    setCount__940 = temper.int32_add(setCount__940, 1);
    ::break_38::i__941 = temper.int32_add(i__941, 1);
  end
  if (setCount__940 == 0) then
    temper.bubble();
  end
  b__939:appendSafe(' WHERE ');
  b__939:appendSafe(this__275._tableDef__760:pkName());
  b__939:appendSafe(' = ');
  b__939:appendInt32(id__936);
  return b__939.accumulated;
end;
ChangesetImpl__249.constructor = function(this__412, _tableDef__945, _params__946, _changes__947, _errors__948, _isValid__949)
  this__412._tableDef__760 = _tableDef__945;
  this__412._params__761 = _params__946;
  this__412._changes__762 = _changes__947;
  this__412._errors__763 = _errors__948;
  this__412._isValid__764 = _isValid__949;
  return nil;
end;
JoinType = temper.type('JoinType');
JoinType.methods.keyword = function(this__276)
  temper.virtual();
end;
InnerJoin = temper.type('InnerJoin', JoinType);
InnerJoin.methods.keyword = function(this__277)
  return 'INNER JOIN';
end;
InnerJoin.constructor = function(this__448)
  return nil;
end;
LeftJoin = temper.type('LeftJoin', JoinType);
LeftJoin.methods.keyword = function(this__278)
  return 'LEFT JOIN';
end;
LeftJoin.constructor = function(this__451)
  return nil;
end;
RightJoin = temper.type('RightJoin', JoinType);
RightJoin.methods.keyword = function(this__279)
  return 'RIGHT JOIN';
end;
RightJoin.constructor = function(this__454)
  return nil;
end;
FullJoin = temper.type('FullJoin', JoinType);
FullJoin.methods.keyword = function(this__280)
  return 'FULL OUTER JOIN';
end;
FullJoin.constructor = function(this__457)
  return nil;
end;
CrossJoin = temper.type('CrossJoin', JoinType);
CrossJoin.methods.keyword = function(this__281)
  return 'CROSS JOIN';
end;
CrossJoin.constructor = function(this__460)
  return nil;
end;
JoinClause = temper.type('JoinClause');
JoinClause.constructor = function(this__463, joinType__1218, table__1219, onCondition__1220)
  if (onCondition__1220 == nil) then
    onCondition__1220 = temper.null;
  end
  this__463.joinType__1214 = joinType__1218;
  this__463.table__1215 = table__1219;
  this__463.onCondition__1216 = onCondition__1220;
  return nil;
end;
JoinClause.get.joinType = function(this__2187)
  return this__2187.joinType__1214;
end;
JoinClause.get.table = function(this__2190)
  return this__2190.table__1215;
end;
JoinClause.get.onCondition = function(this__2193)
  return this__2193.onCondition__1216;
end;
NullsPosition = temper.type('NullsPosition');
NullsPosition.methods.keyword = function(this__282)
  temper.virtual();
end;
NullsFirst = temper.type('NullsFirst', NullsPosition);
NullsFirst.methods.keyword = function(this__283)
  return ' NULLS FIRST';
end;
NullsFirst.constructor = function(this__467)
  return nil;
end;
NullsLast = temper.type('NullsLast', NullsPosition);
NullsLast.methods.keyword = function(this__284)
  return ' NULLS LAST';
end;
NullsLast.constructor = function(this__470)
  return nil;
end;
OrderClause = temper.type('OrderClause');
OrderClause.constructor = function(this__473, field__1233, ascending__1234, nullsPos__1235)
  if (nullsPos__1235 == nil) then
    nullsPos__1235 = temper.null;
  end
  this__473.field__1229 = field__1233;
  this__473.ascending__1230 = ascending__1234;
  this__473.nullsPos__1231 = nullsPos__1235;
  return nil;
end;
OrderClause.get.field = function(this__2196)
  return this__2196.field__1229;
end;
OrderClause.get.ascending = function(this__2199)
  return this__2199.ascending__1230;
end;
OrderClause.get.nullsPos = function(this__2202)
  return this__2202.nullsPos__1231;
end;
LockMode = temper.type('LockMode');
LockMode.methods.keyword = function(this__285)
  temper.virtual();
end;
ForUpdate = temper.type('ForUpdate', LockMode);
ForUpdate.methods.keyword = function(this__286)
  return ' FOR UPDATE';
end;
ForUpdate.constructor = function(this__477)
  return nil;
end;
ForShare = temper.type('ForShare', LockMode);
ForShare.methods.keyword = function(this__287)
  return ' FOR SHARE';
end;
ForShare.constructor = function(this__480)
  return nil;
end;
WhereClause = temper.type('WhereClause');
WhereClause.get.condition = function(this__288)
  temper.virtual();
end;
WhereClause.methods.keyword = function(this__289)
  temper.virtual();
end;
AndCondition = temper.type('AndCondition', WhereClause);
AndCondition.get.condition = function(this__290)
  return this__290._condition__1248;
end;
AndCondition.methods.keyword = function(this__291)
  return 'AND';
end;
AndCondition.constructor = function(this__487, _condition__1254)
  this__487._condition__1248 = _condition__1254;
  return nil;
end;
OrCondition = temper.type('OrCondition', WhereClause);
OrCondition.get.condition = function(this__292)
  return this__292._condition__1255;
end;
OrCondition.methods.keyword = function(this__293)
  return 'OR';
end;
OrCondition.constructor = function(this__492, _condition__1261)
  this__492._condition__1255 = _condition__1261;
  return nil;
end;
Query = temper.type('Query');
Query.methods.where = function(this__294, condition__1275)
  local nb__1277;
  nb__1277 = temper.list_tolistbuilder(this__294.conditions__1263);
  temper.listbuilder_add(nb__1277, AndCondition(condition__1275));
  return Query(this__294.tableName__1262, temper.listbuilder_tolist(nb__1277), this__294.selectedFields__1264, this__294.orderClauses__1265, this__294.limitVal__1266, this__294.offsetVal__1267, this__294.joinClauses__1268, this__294.groupByFields__1269, this__294.havingConditions__1270, this__294.isDistinct__1271, this__294.selectExprs__1272, this__294.lockMode__1273);
end;
Query.methods.orWhere = function(this__295, condition__1279)
  local nb__1281;
  nb__1281 = temper.list_tolistbuilder(this__295.conditions__1263);
  temper.listbuilder_add(nb__1281, OrCondition(condition__1279));
  return Query(this__295.tableName__1262, temper.listbuilder_tolist(nb__1281), this__295.selectedFields__1264, this__295.orderClauses__1265, this__295.limitVal__1266, this__295.offsetVal__1267, this__295.joinClauses__1268, this__295.groupByFields__1269, this__295.havingConditions__1270, this__295.isDistinct__1271, this__295.selectExprs__1272, this__295.lockMode__1273);
end;
Query.methods.whereNull = function(this__296, field__1283)
  local b__1285, t_180;
  b__1285 = SqlBuilder();
  b__1285:appendSafe(field__1283.sqlValue);
  b__1285:appendSafe(' IS NULL');
  t_180 = b__1285.accumulated;
  return this__296:where(t_180);
end;
Query.methods.whereNotNull = function(this__297, field__1287)
  local b__1289, t_181;
  b__1289 = SqlBuilder();
  b__1289:appendSafe(field__1287.sqlValue);
  b__1289:appendSafe(' IS NOT NULL');
  t_181 = b__1289.accumulated;
  return this__297:where(t_181);
end;
Query.methods.whereIn = function(this__298, field__1291, values__1292)
  local return__512, t_182, t_183, t_184, b__1295, i__1296;
  ::continue_41::
  if temper.listed_isempty(values__1292) then
    local b__1294;
    b__1294 = SqlBuilder();
    b__1294:appendSafe('1 = 0');
    t_182 = b__1294.accumulated;
    return__512 = this__298:where(t_182);
    goto break_40;
  end
  b__1295 = SqlBuilder();
  b__1295:appendSafe(field__1291.sqlValue);
  b__1295:appendSafe(' IN (');
  b__1295:appendPart(temper.list_get(values__1292, 0));
  i__1296 = 1;
  while true do
    t_183 = temper.list_length(values__1292);
    if not (i__1296 < t_183) then
      break;
    end
    b__1295:appendSafe(', ');
    b__1295:appendPart(temper.list_get(values__1292, i__1296));
    i__1296 = temper.int32_add(i__1296, 1);
  end
  b__1295:appendSafe(')');
  t_184 = b__1295.accumulated;
  return__512 = this__298:where(t_184);
  ::break_40::return return__512;
end;
Query.methods.whereInSubquery = function(this__299, field__1298, sub__1299)
  local b__1301, t_185;
  b__1301 = SqlBuilder();
  b__1301:appendSafe(field__1298.sqlValue);
  b__1301:appendSafe(' IN (');
  b__1301:appendFragment(sub__1299:toSql());
  b__1301:appendSafe(')');
  t_185 = b__1301.accumulated;
  return this__299:where(t_185);
end;
Query.methods.whereNot = function(this__300, condition__1303)
  local b__1305, t_186;
  b__1305 = SqlBuilder();
  b__1305:appendSafe('NOT (');
  b__1305:appendFragment(condition__1303);
  b__1305:appendSafe(')');
  t_186 = b__1305.accumulated;
  return this__300:where(t_186);
end;
Query.methods.whereBetween = function(this__301, field__1307, low__1308, high__1309)
  local b__1311, t_187;
  b__1311 = SqlBuilder();
  b__1311:appendSafe(field__1307.sqlValue);
  b__1311:appendSafe(' BETWEEN ');
  b__1311:appendPart(low__1308);
  b__1311:appendSafe(' AND ');
  b__1311:appendPart(high__1309);
  t_187 = b__1311.accumulated;
  return this__301:where(t_187);
end;
Query.methods.whereLike = function(this__302, field__1313, pattern__1314)
  local b__1316, t_188;
  b__1316 = SqlBuilder();
  b__1316:appendSafe(field__1313.sqlValue);
  b__1316:appendSafe(' LIKE ');
  b__1316:appendString(pattern__1314);
  t_188 = b__1316.accumulated;
  return this__302:where(t_188);
end;
Query.methods.whereILike = function(this__303, field__1318, pattern__1319)
  local b__1321, t_189;
  b__1321 = SqlBuilder();
  b__1321:appendSafe(field__1318.sqlValue);
  b__1321:appendSafe(' ILIKE ');
  b__1321:appendString(pattern__1319);
  t_189 = b__1321.accumulated;
  return this__303:where(t_189);
end;
Query.methods.select = function(this__304, fields__1323)
  return Query(this__304.tableName__1262, this__304.conditions__1263, fields__1323, this__304.orderClauses__1265, this__304.limitVal__1266, this__304.offsetVal__1267, this__304.joinClauses__1268, this__304.groupByFields__1269, this__304.havingConditions__1270, this__304.isDistinct__1271, this__304.selectExprs__1272, this__304.lockMode__1273);
end;
Query.methods.selectExpr = function(this__305, exprs__1326)
  return Query(this__305.tableName__1262, this__305.conditions__1263, this__305.selectedFields__1264, this__305.orderClauses__1265, this__305.limitVal__1266, this__305.offsetVal__1267, this__305.joinClauses__1268, this__305.groupByFields__1269, this__305.havingConditions__1270, this__305.isDistinct__1271, exprs__1326, this__305.lockMode__1273);
end;
Query.methods.orderBy = function(this__306, field__1329, ascending__1330)
  local nb__1332;
  nb__1332 = temper.list_tolistbuilder(this__306.orderClauses__1265);
  temper.listbuilder_add(nb__1332, OrderClause(field__1329, ascending__1330, temper.null));
  return Query(this__306.tableName__1262, this__306.conditions__1263, this__306.selectedFields__1264, temper.listbuilder_tolist(nb__1332), this__306.limitVal__1266, this__306.offsetVal__1267, this__306.joinClauses__1268, this__306.groupByFields__1269, this__306.havingConditions__1270, this__306.isDistinct__1271, this__306.selectExprs__1272, this__306.lockMode__1273);
end;
Query.methods.orderByNulls = function(this__307, field__1334, ascending__1335, nulls__1336)
  local nb__1338;
  nb__1338 = temper.list_tolistbuilder(this__307.orderClauses__1265);
  temper.listbuilder_add(nb__1338, OrderClause(field__1334, ascending__1335, nulls__1336));
  return Query(this__307.tableName__1262, this__307.conditions__1263, this__307.selectedFields__1264, temper.listbuilder_tolist(nb__1338), this__307.limitVal__1266, this__307.offsetVal__1267, this__307.joinClauses__1268, this__307.groupByFields__1269, this__307.havingConditions__1270, this__307.isDistinct__1271, this__307.selectExprs__1272, this__307.lockMode__1273);
end;
Query.methods.limit = function(this__308, n__1340)
  if (n__1340 < 0) then
    temper.bubble();
  end
  return Query(this__308.tableName__1262, this__308.conditions__1263, this__308.selectedFields__1264, this__308.orderClauses__1265, n__1340, this__308.offsetVal__1267, this__308.joinClauses__1268, this__308.groupByFields__1269, this__308.havingConditions__1270, this__308.isDistinct__1271, this__308.selectExprs__1272, this__308.lockMode__1273);
end;
Query.methods.offset = function(this__309, n__1343)
  if (n__1343 < 0) then
    temper.bubble();
  end
  return Query(this__309.tableName__1262, this__309.conditions__1263, this__309.selectedFields__1264, this__309.orderClauses__1265, this__309.limitVal__1266, n__1343, this__309.joinClauses__1268, this__309.groupByFields__1269, this__309.havingConditions__1270, this__309.isDistinct__1271, this__309.selectExprs__1272, this__309.lockMode__1273);
end;
Query.methods.join = function(this__310, joinType__1346, table__1347, onCondition__1348)
  local nb__1350;
  nb__1350 = temper.list_tolistbuilder(this__310.joinClauses__1268);
  temper.listbuilder_add(nb__1350, JoinClause(joinType__1346, table__1347, onCondition__1348));
  return Query(this__310.tableName__1262, this__310.conditions__1263, this__310.selectedFields__1264, this__310.orderClauses__1265, this__310.limitVal__1266, this__310.offsetVal__1267, temper.listbuilder_tolist(nb__1350), this__310.groupByFields__1269, this__310.havingConditions__1270, this__310.isDistinct__1271, this__310.selectExprs__1272, this__310.lockMode__1273);
end;
Query.methods.innerJoin = function(this__311, table__1352, onCondition__1353)
  local t_190;
  t_190 = InnerJoin();
  return this__311:join(t_190, table__1352, onCondition__1353);
end;
Query.methods.leftJoin = function(this__312, table__1356, onCondition__1357)
  local t_191;
  t_191 = LeftJoin();
  return this__312:join(t_191, table__1356, onCondition__1357);
end;
Query.methods.rightJoin = function(this__313, table__1360, onCondition__1361)
  local t_192;
  t_192 = RightJoin();
  return this__313:join(t_192, table__1360, onCondition__1361);
end;
Query.methods.fullJoin = function(this__314, table__1364, onCondition__1365)
  local t_193;
  t_193 = FullJoin();
  return this__314:join(t_193, table__1364, onCondition__1365);
end;
Query.methods.crossJoin = function(this__315, table__1368)
  local nb__1370;
  nb__1370 = temper.list_tolistbuilder(this__315.joinClauses__1268);
  temper.listbuilder_add(nb__1370, JoinClause(CrossJoin(), table__1368, temper.null));
  return Query(this__315.tableName__1262, this__315.conditions__1263, this__315.selectedFields__1264, this__315.orderClauses__1265, this__315.limitVal__1266, this__315.offsetVal__1267, temper.listbuilder_tolist(nb__1370), this__315.groupByFields__1269, this__315.havingConditions__1270, this__315.isDistinct__1271, this__315.selectExprs__1272, this__315.lockMode__1273);
end;
Query.methods.groupBy = function(this__316, field__1372)
  local nb__1374;
  nb__1374 = temper.list_tolistbuilder(this__316.groupByFields__1269);
  temper.listbuilder_add(nb__1374, field__1372);
  return Query(this__316.tableName__1262, this__316.conditions__1263, this__316.selectedFields__1264, this__316.orderClauses__1265, this__316.limitVal__1266, this__316.offsetVal__1267, this__316.joinClauses__1268, temper.listbuilder_tolist(nb__1374), this__316.havingConditions__1270, this__316.isDistinct__1271, this__316.selectExprs__1272, this__316.lockMode__1273);
end;
Query.methods.having = function(this__317, condition__1376)
  local nb__1378;
  nb__1378 = temper.list_tolistbuilder(this__317.havingConditions__1270);
  temper.listbuilder_add(nb__1378, AndCondition(condition__1376));
  return Query(this__317.tableName__1262, this__317.conditions__1263, this__317.selectedFields__1264, this__317.orderClauses__1265, this__317.limitVal__1266, this__317.offsetVal__1267, this__317.joinClauses__1268, this__317.groupByFields__1269, temper.listbuilder_tolist(nb__1378), this__317.isDistinct__1271, this__317.selectExprs__1272, this__317.lockMode__1273);
end;
Query.methods.orHaving = function(this__318, condition__1380)
  local nb__1382;
  nb__1382 = temper.list_tolistbuilder(this__318.havingConditions__1270);
  temper.listbuilder_add(nb__1382, OrCondition(condition__1380));
  return Query(this__318.tableName__1262, this__318.conditions__1263, this__318.selectedFields__1264, this__318.orderClauses__1265, this__318.limitVal__1266, this__318.offsetVal__1267, this__318.joinClauses__1268, this__318.groupByFields__1269, temper.listbuilder_tolist(nb__1382), this__318.isDistinct__1271, this__318.selectExprs__1272, this__318.lockMode__1273);
end;
Query.methods.distinct = function(this__319)
  return Query(this__319.tableName__1262, this__319.conditions__1263, this__319.selectedFields__1264, this__319.orderClauses__1265, this__319.limitVal__1266, this__319.offsetVal__1267, this__319.joinClauses__1268, this__319.groupByFields__1269, this__319.havingConditions__1270, true, this__319.selectExprs__1272, this__319.lockMode__1273);
end;
Query.methods.lock = function(this__320, mode__1386)
  return Query(this__320.tableName__1262, this__320.conditions__1263, this__320.selectedFields__1264, this__320.orderClauses__1265, this__320.limitVal__1266, this__320.offsetVal__1267, this__320.joinClauses__1268, this__320.groupByFields__1269, this__320.havingConditions__1270, this__320.isDistinct__1271, this__320.selectExprs__1272, mode__1386);
end;
Query.methods.toSql = function(this__321)
  local t_194, t_195, t_196, b__1390, fn__13822, lv__1401, ov__1402, lm__1403;
  b__1390 = SqlBuilder();
  if this__321.isDistinct__1271 then
    b__1390:appendSafe('SELECT DISTINCT ');
  else
    b__1390:appendSafe('SELECT ');
  end
  if not temper.listed_isempty(this__321.selectExprs__1272) then
    local i__1391;
    b__1390:appendFragment(temper.list_get(this__321.selectExprs__1272, 0));
    i__1391 = 1;
    while true do
      t_194 = temper.list_length(this__321.selectExprs__1272);
      if not (i__1391 < t_194) then
        break;
      end
      b__1390:appendSafe(', ');
      b__1390:appendFragment(temper.list_get(this__321.selectExprs__1272, i__1391));
      i__1391 = temper.int32_add(i__1391, 1);
    end
  elseif temper.listed_isempty(this__321.selectedFields__1264) then
    b__1390:appendSafe('*');
  else
    local fn__13823;
    fn__13823 = function(f__1392)
      return f__1392.sqlValue;
    end;
    b__1390:appendSafe(temper.listed_join(this__321.selectedFields__1264, ', ', fn__13823));
  end
  b__1390:appendSafe(' FROM ');
  b__1390:appendSafe(this__321.tableName__1262.sqlValue);
  fn__13822 = function(jc__1393)
    local t_197, t_198, oc__1394;
    b__1390:appendSafe(' ');
    t_197 = jc__1393.joinType:keyword();
    b__1390:appendSafe(t_197);
    b__1390:appendSafe(' ');
    t_198 = jc__1393.table.sqlValue;
    b__1390:appendSafe(t_198);
    oc__1394 = jc__1393.onCondition;
    if not temper.is_null(oc__1394) then
      local oc_199;
      oc_199 = oc__1394;
      b__1390:appendSafe(' ON ');
      b__1390:appendFragment(oc_199);
    end
    return nil;
  end;
  temper.list_foreach(this__321.joinClauses__1268, fn__13822);
  if not temper.listed_isempty(this__321.conditions__1263) then
    local i__1395;
    b__1390:appendSafe(' WHERE ');
    b__1390:appendFragment((temper.list_get(this__321.conditions__1263, 0)).condition);
    i__1395 = 1;
    while true do
      t_195 = temper.list_length(this__321.conditions__1263);
      if not (i__1395 < t_195) then
        break;
      end
      b__1390:appendSafe(' ');
      b__1390:appendSafe(temper.list_get(this__321.conditions__1263, i__1395):keyword());
      b__1390:appendSafe(' ');
      b__1390:appendFragment((temper.list_get(this__321.conditions__1263, i__1395)).condition);
      i__1395 = temper.int32_add(i__1395, 1);
    end
  end
  if not temper.listed_isempty(this__321.groupByFields__1269) then
    local fn__13821;
    b__1390:appendSafe(' GROUP BY ');
    fn__13821 = function(f__1396)
      return f__1396.sqlValue;
    end;
    b__1390:appendSafe(temper.listed_join(this__321.groupByFields__1269, ', ', fn__13821));
  end
  if not temper.listed_isempty(this__321.havingConditions__1270) then
    local i__1397;
    b__1390:appendSafe(' HAVING ');
    b__1390:appendFragment((temper.list_get(this__321.havingConditions__1270, 0)).condition);
    i__1397 = 1;
    while true do
      t_196 = temper.list_length(this__321.havingConditions__1270);
      if not (i__1397 < t_196) then
        break;
      end
      b__1390:appendSafe(' ');
      b__1390:appendSafe(temper.list_get(this__321.havingConditions__1270, i__1397):keyword());
      b__1390:appendSafe(' ');
      b__1390:appendFragment((temper.list_get(this__321.havingConditions__1270, i__1397)).condition);
      i__1397 = temper.int32_add(i__1397, 1);
    end
  end
  if not temper.listed_isempty(this__321.orderClauses__1265) then
    local first__1398, fn__13820;
    b__1390:appendSafe(' ORDER BY ');
    first__1398 = true;
    fn__13820 = function(orc__1399)
      local t_200, t_201, t_202, np__1400;
      if not first__1398 then
        b__1390:appendSafe(', ');
      end
      first__1398 = false;
      t_202 = orc__1399.field.sqlValue;
      b__1390:appendSafe(t_202);
      if orc__1399.ascending then
        t_201 = ' ASC';
      else
        t_201 = ' DESC';
      end
      b__1390:appendSafe(t_201);
      np__1400 = orc__1399.nullsPos;
      if not temper.is_null(np__1400) then
        t_200 = np__1400:keyword();
        b__1390:appendSafe(t_200);
      end
      return nil;
    end;
    temper.list_foreach(this__321.orderClauses__1265, fn__13820);
  end
  lv__1401 = this__321.limitVal__1266;
  if not temper.is_null(lv__1401) then
    local lv_203;
    lv_203 = lv__1401;
    b__1390:appendSafe(' LIMIT ');
    b__1390:appendInt32(lv_203);
  end
  ov__1402 = this__321.offsetVal__1267;
  if not temper.is_null(ov__1402) then
    local ov_204;
    ov_204 = ov__1402;
    b__1390:appendSafe(' OFFSET ');
    b__1390:appendInt32(ov_204);
  end
  lm__1403 = this__321.lockMode__1273;
  if not temper.is_null(lm__1403) then
    b__1390:appendSafe(lm__1403:keyword());
  end
  return b__1390.accumulated;
end;
Query.methods.countSql = function(this__322)
  local t_205, t_206, b__1406, fn__13757;
  b__1406 = SqlBuilder();
  b__1406:appendSafe('SELECT COUNT(*) FROM ');
  b__1406:appendSafe(this__322.tableName__1262.sqlValue);
  fn__13757 = function(jc__1407)
    local t_207, t_208, oc2__1408;
    b__1406:appendSafe(' ');
    t_207 = jc__1407.joinType:keyword();
    b__1406:appendSafe(t_207);
    b__1406:appendSafe(' ');
    t_208 = jc__1407.table.sqlValue;
    b__1406:appendSafe(t_208);
    oc2__1408 = jc__1407.onCondition;
    if not temper.is_null(oc2__1408) then
      local oc2_209;
      oc2_209 = oc2__1408;
      b__1406:appendSafe(' ON ');
      b__1406:appendFragment(oc2_209);
    end
    return nil;
  end;
  temper.list_foreach(this__322.joinClauses__1268, fn__13757);
  if not temper.listed_isempty(this__322.conditions__1263) then
    local i__1409;
    b__1406:appendSafe(' WHERE ');
    b__1406:appendFragment((temper.list_get(this__322.conditions__1263, 0)).condition);
    i__1409 = 1;
    while true do
      t_205 = temper.list_length(this__322.conditions__1263);
      if not (i__1409 < t_205) then
        break;
      end
      b__1406:appendSafe(' ');
      b__1406:appendSafe(temper.list_get(this__322.conditions__1263, i__1409):keyword());
      b__1406:appendSafe(' ');
      b__1406:appendFragment((temper.list_get(this__322.conditions__1263, i__1409)).condition);
      i__1409 = temper.int32_add(i__1409, 1);
    end
  end
  if not temper.listed_isempty(this__322.groupByFields__1269) then
    local fn__13756;
    b__1406:appendSafe(' GROUP BY ');
    fn__13756 = function(f__1410)
      return f__1410.sqlValue;
    end;
    b__1406:appendSafe(temper.listed_join(this__322.groupByFields__1269, ', ', fn__13756));
  end
  if not temper.listed_isempty(this__322.havingConditions__1270) then
    local i__1411;
    b__1406:appendSafe(' HAVING ');
    b__1406:appendFragment((temper.list_get(this__322.havingConditions__1270, 0)).condition);
    i__1411 = 1;
    while true do
      t_206 = temper.list_length(this__322.havingConditions__1270);
      if not (i__1411 < t_206) then
        break;
      end
      b__1406:appendSafe(' ');
      b__1406:appendSafe(temper.list_get(this__322.havingConditions__1270, i__1411):keyword());
      b__1406:appendSafe(' ');
      b__1406:appendFragment((temper.list_get(this__322.havingConditions__1270, i__1411)).condition);
      i__1411 = temper.int32_add(i__1411, 1);
    end
  end
  return b__1406.accumulated;
end;
Query.methods.safeToSql = function(this__323, defaultLimit__1413)
  local return__537, t_210;
  if (defaultLimit__1413 < 0) then
    temper.bubble();
  end
  if not temper.is_null(this__323.limitVal__1266) then
    return__537 = this__323:toSql();
  else
    t_210 = this__323:limit(defaultLimit__1413);
    return__537 = t_210:toSql();
  end
  return return__537;
end;
Query.constructor = function(this__496, tableName__1416, conditions__1417, selectedFields__1418, orderClauses__1419, limitVal__1420, offsetVal__1421, joinClauses__1422, groupByFields__1423, havingConditions__1424, isDistinct__1425, selectExprs__1426, lockMode__1427)
  if (limitVal__1420 == nil) then
    limitVal__1420 = temper.null;
  end
  if (offsetVal__1421 == nil) then
    offsetVal__1421 = temper.null;
  end
  if (lockMode__1427 == nil) then
    lockMode__1427 = temper.null;
  end
  this__496.tableName__1262 = tableName__1416;
  this__496.conditions__1263 = conditions__1417;
  this__496.selectedFields__1264 = selectedFields__1418;
  this__496.orderClauses__1265 = orderClauses__1419;
  this__496.limitVal__1266 = limitVal__1420;
  this__496.offsetVal__1267 = offsetVal__1421;
  this__496.joinClauses__1268 = joinClauses__1422;
  this__496.groupByFields__1269 = groupByFields__1423;
  this__496.havingConditions__1270 = havingConditions__1424;
  this__496.isDistinct__1271 = isDistinct__1425;
  this__496.selectExprs__1272 = selectExprs__1426;
  this__496.lockMode__1273 = lockMode__1427;
  return nil;
end;
Query.get.tableName = function(this__2205)
  return this__2205.tableName__1262;
end;
Query.get.conditions = function(this__2208)
  return this__2208.conditions__1263;
end;
Query.get.selectedFields = function(this__2211)
  return this__2211.selectedFields__1264;
end;
Query.get.orderClauses = function(this__2214)
  return this__2214.orderClauses__1265;
end;
Query.get.limitVal = function(this__2217)
  return this__2217.limitVal__1266;
end;
Query.get.offsetVal = function(this__2220)
  return this__2220.offsetVal__1267;
end;
Query.get.joinClauses = function(this__2223)
  return this__2223.joinClauses__1268;
end;
Query.get.groupByFields = function(this__2226)
  return this__2226.groupByFields__1269;
end;
Query.get.havingConditions = function(this__2229)
  return this__2229.havingConditions__1270;
end;
Query.get.isDistinct = function(this__2232)
  return this__2232.isDistinct__1271;
end;
Query.get.selectExprs = function(this__2235)
  return this__2235.selectExprs__1272;
end;
Query.get.lockMode = function(this__2238)
  return this__2238.lockMode__1273;
end;
SetClause = temper.type('SetClause');
SetClause.constructor = function(this__552, field__1477, value__1478)
  this__552.field__1474 = field__1477;
  this__552.value__1475 = value__1478;
  return nil;
end;
SetClause.get.field = function(this__2241)
  return this__2241.field__1474;
end;
SetClause.get.value = function(this__2244)
  return this__2244.value__1475;
end;
UpdateQuery = temper.type('UpdateQuery');
UpdateQuery.methods.set = function(this__324, field__1484, value__1485)
  local nb__1487;
  nb__1487 = temper.list_tolistbuilder(this__324.setClauses__1480);
  temper.listbuilder_add(nb__1487, SetClause(field__1484, value__1485));
  return UpdateQuery(this__324.tableName__1479, temper.listbuilder_tolist(nb__1487), this__324.conditions__1481, this__324.limitVal__1482);
end;
UpdateQuery.methods.where = function(this__325, condition__1489)
  local nb__1491;
  nb__1491 = temper.list_tolistbuilder(this__325.conditions__1481);
  temper.listbuilder_add(nb__1491, AndCondition(condition__1489));
  return UpdateQuery(this__325.tableName__1479, this__325.setClauses__1480, temper.listbuilder_tolist(nb__1491), this__325.limitVal__1482);
end;
UpdateQuery.methods.orWhere = function(this__326, condition__1493)
  local nb__1495;
  nb__1495 = temper.list_tolistbuilder(this__326.conditions__1481);
  temper.listbuilder_add(nb__1495, OrCondition(condition__1493));
  return UpdateQuery(this__326.tableName__1479, this__326.setClauses__1480, temper.listbuilder_tolist(nb__1495), this__326.limitVal__1482);
end;
UpdateQuery.methods.limit = function(this__327, n__1497)
  if (n__1497 < 0) then
    temper.bubble();
  end
  return UpdateQuery(this__327.tableName__1479, this__327.setClauses__1480, this__327.conditions__1481, n__1497);
end;
UpdateQuery.methods.toSql = function(this__328)
  local t_211, t_212, b__1501, i__1502, i__1503, lv__1504;
  if temper.listed_isempty(this__328.conditions__1481) then
    temper.bubble();
  end
  if temper.listed_isempty(this__328.setClauses__1480) then
    temper.bubble();
  end
  b__1501 = SqlBuilder();
  b__1501:appendSafe('UPDATE ');
  b__1501:appendSafe(this__328.tableName__1479.sqlValue);
  b__1501:appendSafe(' SET ');
  b__1501:appendSafe((temper.list_get(this__328.setClauses__1480, 0)).field.sqlValue);
  b__1501:appendSafe(' = ');
  b__1501:appendPart((temper.list_get(this__328.setClauses__1480, 0)).value);
  i__1502 = 1;
  while true do
    t_211 = temper.list_length(this__328.setClauses__1480);
    if not (i__1502 < t_211) then
      break;
    end
    b__1501:appendSafe(', ');
    b__1501:appendSafe((temper.list_get(this__328.setClauses__1480, i__1502)).field.sqlValue);
    b__1501:appendSafe(' = ');
    b__1501:appendPart((temper.list_get(this__328.setClauses__1480, i__1502)).value);
    i__1502 = temper.int32_add(i__1502, 1);
  end
  b__1501:appendSafe(' WHERE ');
  b__1501:appendFragment((temper.list_get(this__328.conditions__1481, 0)).condition);
  i__1503 = 1;
  while true do
    t_212 = temper.list_length(this__328.conditions__1481);
    if not (i__1503 < t_212) then
      break;
    end
    b__1501:appendSafe(' ');
    b__1501:appendSafe(temper.list_get(this__328.conditions__1481, i__1503):keyword());
    b__1501:appendSafe(' ');
    b__1501:appendFragment((temper.list_get(this__328.conditions__1481, i__1503)).condition);
    i__1503 = temper.int32_add(i__1503, 1);
  end
  lv__1504 = this__328.limitVal__1482;
  if not temper.is_null(lv__1504) then
    local lv_213;
    lv_213 = lv__1504;
    b__1501:appendSafe(' LIMIT ');
    b__1501:appendInt32(lv_213);
  end
  return b__1501.accumulated;
end;
UpdateQuery.constructor = function(this__554, tableName__1506, setClauses__1507, conditions__1508, limitVal__1509)
  if (limitVal__1509 == nil) then
    limitVal__1509 = temper.null;
  end
  this__554.tableName__1479 = tableName__1506;
  this__554.setClauses__1480 = setClauses__1507;
  this__554.conditions__1481 = conditions__1508;
  this__554.limitVal__1482 = limitVal__1509;
  return nil;
end;
UpdateQuery.get.tableName = function(this__2247)
  return this__2247.tableName__1479;
end;
UpdateQuery.get.setClauses = function(this__2250)
  return this__2250.setClauses__1480;
end;
UpdateQuery.get.conditions = function(this__2253)
  return this__2253.conditions__1481;
end;
UpdateQuery.get.limitVal = function(this__2256)
  return this__2256.limitVal__1482;
end;
DeleteQuery = temper.type('DeleteQuery');
DeleteQuery.methods.where = function(this__329, condition__1514)
  local nb__1516;
  nb__1516 = temper.list_tolistbuilder(this__329.conditions__1511);
  temper.listbuilder_add(nb__1516, AndCondition(condition__1514));
  return DeleteQuery(this__329.tableName__1510, temper.listbuilder_tolist(nb__1516), this__329.limitVal__1512);
end;
DeleteQuery.methods.orWhere = function(this__330, condition__1518)
  local nb__1520;
  nb__1520 = temper.list_tolistbuilder(this__330.conditions__1511);
  temper.listbuilder_add(nb__1520, OrCondition(condition__1518));
  return DeleteQuery(this__330.tableName__1510, temper.listbuilder_tolist(nb__1520), this__330.limitVal__1512);
end;
DeleteQuery.methods.limit = function(this__331, n__1522)
  if (n__1522 < 0) then
    temper.bubble();
  end
  return DeleteQuery(this__331.tableName__1510, this__331.conditions__1511, n__1522);
end;
DeleteQuery.methods.toSql = function(this__332)
  local t_214, b__1526, i__1527, lv__1528;
  if temper.listed_isempty(this__332.conditions__1511) then
    temper.bubble();
  end
  b__1526 = SqlBuilder();
  b__1526:appendSafe('DELETE FROM ');
  b__1526:appendSafe(this__332.tableName__1510.sqlValue);
  b__1526:appendSafe(' WHERE ');
  b__1526:appendFragment((temper.list_get(this__332.conditions__1511, 0)).condition);
  i__1527 = 1;
  while true do
    t_214 = temper.list_length(this__332.conditions__1511);
    if not (i__1527 < t_214) then
      break;
    end
    b__1526:appendSafe(' ');
    b__1526:appendSafe(temper.list_get(this__332.conditions__1511, i__1527):keyword());
    b__1526:appendSafe(' ');
    b__1526:appendFragment((temper.list_get(this__332.conditions__1511, i__1527)).condition);
    i__1527 = temper.int32_add(i__1527, 1);
  end
  lv__1528 = this__332.limitVal__1512;
  if not temper.is_null(lv__1528) then
    local lv_215;
    lv_215 = lv__1528;
    b__1526:appendSafe(' LIMIT ');
    b__1526:appendInt32(lv_215);
  end
  return b__1526.accumulated;
end;
DeleteQuery.constructor = function(this__564, tableName__1530, conditions__1531, limitVal__1532)
  if (limitVal__1532 == nil) then
    limitVal__1532 = temper.null;
  end
  this__564.tableName__1510 = tableName__1530;
  this__564.conditions__1511 = conditions__1531;
  this__564.limitVal__1512 = limitVal__1532;
  return nil;
end;
DeleteQuery.get.tableName = function(this__2259)
  return this__2259.tableName__1510;
end;
DeleteQuery.get.conditions = function(this__2262)
  return this__2262.conditions__1511;
end;
DeleteQuery.get.limitVal = function(this__2265)
  return this__2265.limitVal__1512;
end;
SafeIdentifier = temper.type('SafeIdentifier');
SafeIdentifier.get.sqlValue = function(this__333)
  temper.virtual();
end;
ValidatedIdentifier__334 = temper.type('ValidatedIdentifier__334', SafeIdentifier);
ValidatedIdentifier__334.get.sqlValue = function(this__335)
  return this__335._value__1763;
end;
ValidatedIdentifier__334.constructor = function(this__578, _value__1767)
  this__578._value__1763 = _value__1767;
  return nil;
end;
FieldType = temper.type('FieldType');
StringField = temper.type('StringField', FieldType);
StringField.constructor = function(this__584)
  return nil;
end;
IntField = temper.type('IntField', FieldType);
IntField.constructor = function(this__586)
  return nil;
end;
Int64Field = temper.type('Int64Field', FieldType);
Int64Field.constructor = function(this__588)
  return nil;
end;
FloatField = temper.type('FloatField', FieldType);
FloatField.constructor = function(this__590)
  return nil;
end;
BoolField = temper.type('BoolField', FieldType);
BoolField.constructor = function(this__592)
  return nil;
end;
DateField = temper.type('DateField', FieldType);
DateField.constructor = function(this__594)
  return nil;
end;
FieldDef = temper.type('FieldDef');
FieldDef.constructor = function(this__596, name__1787, fieldType__1788, nullable__1789, defaultValue__1790, virtual__1791)
  if (defaultValue__1790 == nil) then
    defaultValue__1790 = temper.null;
  end
  this__596.name__1781 = name__1787;
  this__596.fieldType__1782 = fieldType__1788;
  this__596.nullable__1783 = nullable__1789;
  this__596.defaultValue__1784 = defaultValue__1790;
  this__596.virtual__1785 = virtual__1791;
  return nil;
end;
FieldDef.get.name = function(this__2073)
  return this__2073.name__1781;
end;
FieldDef.get.fieldType = function(this__2076)
  return this__2076.fieldType__1782;
end;
FieldDef.get.nullable = function(this__2079)
  return this__2079.nullable__1783;
end;
FieldDef.get.defaultValue = function(this__2082)
  return this__2082.defaultValue__1784;
end;
FieldDef.get.virtual = function(this__2085)
  return this__2085.virtual__1785;
end;
TableDef = temper.type('TableDef');
TableDef.methods.field = function(this__336, name__1796)
  local return__603, this__9149, n__9150, i__9151;
  ::continue_43::this__9149 = this__336.fields__1793;
  n__9150 = temper.list_length(this__9149);
  i__9151 = 0;
  while (i__9151 < n__9150) do
    local el__9152, f__1798;
    el__9152 = temper.list_get(this__9149, i__9151);
    i__9151 = temper.int32_add(i__9151, 1);
    f__1798 = el__9152;
    if temper.str_eq(f__1798.name.sqlValue, name__1796) then
      return__603 = f__1798;
      goto break_42;
    end
  end
  temper.bubble();
  ::break_42::return return__603;
end;
TableDef.methods.pkName = function(this__337)
  local return__604, pk__1801;
  ::continue_45::pk__1801 = this__337.primaryKey__1794;
  if not temper.is_null(pk__1801) then
    local pk_216;
    pk_216 = pk__1801;
    return__604 = pk_216.sqlValue;
    goto break_44;
  end
  return__604 = 'id';
  ::break_44::return return__604;
end;
TableDef.constructor = function(this__599, tableName__1803, fields__1804, primaryKey__1805)
  if (primaryKey__1805 == nil) then
    primaryKey__1805 = temper.null;
  end
  this__599.tableName__1792 = tableName__1803;
  this__599.fields__1793 = fields__1804;
  this__599.primaryKey__1794 = primaryKey__1805;
  return nil;
end;
TableDef.get.tableName = function(this__2088)
  return this__2088.tableName__1792;
end;
TableDef.get.fields = function(this__2091)
  return this__2091.fields__1793;
end;
TableDef.get.primaryKey = function(this__2094)
  return this__2094.primaryKey__1794;
end;
SqlBuilder = temper.type('SqlBuilder');
SqlBuilder.methods.appendSafe = function(this__338, sqlSource__1840)
  local t_217;
  t_217 = SqlSource(sqlSource__1840);
  temper.listbuilder_add(this__338.buffer__1838, t_217);
  return nil;
end;
SqlBuilder.methods.appendFragment = function(this__339, fragment__1843)
  local t_218;
  t_218 = fragment__1843.parts;
  temper.listbuilder_addall(this__339.buffer__1838, t_218);
  return nil;
end;
SqlBuilder.methods.appendPart = function(this__340, part__1846)
  temper.listbuilder_add(this__340.buffer__1838, part__1846);
  return nil;
end;
SqlBuilder.methods.appendPartList = function(this__341, values__1849)
  local fn__15514;
  fn__15514 = function(x__1851)
    this__341:appendPart(x__1851);
    return nil;
  end;
  this__341:appendList(values__1849, fn__15514);
  return nil;
end;
SqlBuilder.methods.appendBoolean = function(this__342, value__1853)
  local t_219;
  t_219 = SqlBoolean(value__1853);
  temper.listbuilder_add(this__342.buffer__1838, t_219);
  return nil;
end;
SqlBuilder.methods.appendBooleanList = function(this__343, values__1856)
  local fn__15508;
  fn__15508 = function(x__1858)
    this__343:appendBoolean(x__1858);
    return nil;
  end;
  this__343:appendList(values__1856, fn__15508);
  return nil;
end;
SqlBuilder.methods.appendDate = function(this__344, value__1860)
  local t_220;
  t_220 = SqlDate(value__1860);
  temper.listbuilder_add(this__344.buffer__1838, t_220);
  return nil;
end;
SqlBuilder.methods.appendDateList = function(this__345, values__1863)
  local fn__15502;
  fn__15502 = function(x__1865)
    this__345:appendDate(x__1865);
    return nil;
  end;
  this__345:appendList(values__1863, fn__15502);
  return nil;
end;
SqlBuilder.methods.appendFloat64 = function(this__346, value__1867)
  local t_221;
  t_221 = SqlFloat64(value__1867);
  temper.listbuilder_add(this__346.buffer__1838, t_221);
  return nil;
end;
SqlBuilder.methods.appendFloat64List = function(this__347, values__1870)
  local fn__15496;
  fn__15496 = function(x__1872)
    this__347:appendFloat64(x__1872);
    return nil;
  end;
  this__347:appendList(values__1870, fn__15496);
  return nil;
end;
SqlBuilder.methods.appendInt32 = function(this__348, value__1874)
  local t_222;
  t_222 = SqlInt32(value__1874);
  temper.listbuilder_add(this__348.buffer__1838, t_222);
  return nil;
end;
SqlBuilder.methods.appendInt32List = function(this__349, values__1877)
  local fn__15490;
  fn__15490 = function(x__1879)
    this__349:appendInt32(x__1879);
    return nil;
  end;
  this__349:appendList(values__1877, fn__15490);
  return nil;
end;
SqlBuilder.methods.appendInt64 = function(this__350, value__1881)
  local t_223;
  t_223 = SqlInt64(value__1881);
  temper.listbuilder_add(this__350.buffer__1838, t_223);
  return nil;
end;
SqlBuilder.methods.appendInt64List = function(this__351, values__1884)
  local fn__15484;
  fn__15484 = function(x__1886)
    this__351:appendInt64(x__1886);
    return nil;
  end;
  this__351:appendList(values__1884, fn__15484);
  return nil;
end;
SqlBuilder.methods.appendString = function(this__352, value__1888)
  local t_224;
  t_224 = SqlString(value__1888);
  temper.listbuilder_add(this__352.buffer__1838, t_224);
  return nil;
end;
SqlBuilder.methods.appendStringList = function(this__353, values__1891)
  local fn__15478;
  fn__15478 = function(x__1893)
    this__353:appendString(x__1893);
    return nil;
  end;
  this__353:appendList(values__1891, fn__15478);
  return nil;
end;
SqlBuilder.methods.appendList = function(this__354, values__1895, appendValue__1896)
  local t_225, t_226, i__1898;
  i__1898 = 0;
  while true do
    t_225 = temper.listed_length(values__1895);
    if not (i__1898 < t_225) then
      break;
    end
    if (i__1898 > 0) then
      this__354:appendSafe(', ');
    end
    t_226 = temper.listed_get(values__1895, i__1898);
    appendValue__1896(t_226);
    i__1898 = temper.int32_add(i__1898, 1);
  end
  return nil;
end;
SqlBuilder.get.accumulated = function(this__355)
  return SqlFragment(temper.listbuilder_tolist(this__355.buffer__1838));
end;
SqlBuilder.constructor = function(this__607)
  local t_227;
  t_227 = temper.listbuilder_constructor();
  this__607.buffer__1838 = t_227;
  return nil;
end;
SqlFragment = temper.type('SqlFragment');
SqlFragment.methods.toSource = function(this__360)
  return SqlSource(this__360:toString());
end;
SqlFragment.methods.toString = function(this__361)
  local t_228, builder__1910, i__1911;
  builder__1910 = temper.stringbuilder_constructor();
  i__1911 = 0;
  while true do
    t_228 = temper.list_length(this__361.parts__1905);
    if not (i__1911 < t_228) then
      break;
    end
    temper.list_get(this__361.parts__1905, i__1911):formatTo(builder__1910);
    i__1911 = temper.int32_add(i__1911, 1);
  end
  return temper.stringbuilder_tostring(builder__1910);
end;
SqlFragment.constructor = function(this__628, parts__1913)
  this__628.parts__1905 = parts__1913;
  return nil;
end;
SqlFragment.get.parts = function(this__2100)
  return this__2100.parts__1905;
end;
SqlPart = temper.type('SqlPart');
SqlPart.methods.formatTo = function(this__362, builder__1915)
  temper.virtual();
end;
SqlSource = temper.type('SqlSource', SqlPart);
SqlSource.methods.formatTo = function(this__363, builder__1919)
  temper.stringbuilder_append(builder__1919, this__363.source__1917);
  return nil;
end;
SqlSource.constructor = function(this__634, source__1922)
  this__634.source__1917 = source__1922;
  return nil;
end;
SqlSource.get.source = function(this__2097)
  return this__2097.source__1917;
end;
SqlBoolean = temper.type('SqlBoolean', SqlPart);
SqlBoolean.methods.formatTo = function(this__364, builder__1925)
  local t_229;
  if this__364.value__1923 then
    t_229 = 'TRUE';
  else
    t_229 = 'FALSE';
  end
  temper.stringbuilder_append(builder__1925, t_229);
  return nil;
end;
SqlBoolean.constructor = function(this__637, value__1928)
  this__637.value__1923 = value__1928;
  return nil;
end;
SqlBoolean.get.value = function(this__2103)
  return this__2103.value__1923;
end;
SqlDate = temper.type('SqlDate', SqlPart);
SqlDate.methods.formatTo = function(this__365, builder__1931)
  local t_230, fn__15523;
  temper.stringbuilder_append(builder__1931, "'");
  t_230 = temper.date_tostring(this__365.value__1929);
  fn__15523 = function(c__1933)
    if (c__1933 == 39) then
      temper.stringbuilder_append(builder__1931, "''");
    else
      local local_231, local_232, local_233;
      local_231, local_232, local_233 = temper.pcall(function()
        temper.stringbuilder_appendcodepoint(builder__1931, c__1933);
      end);
      if local_231 then
      else
        temper.bubble();
      end
    end
    return nil;
  end;
  temper.string_foreach(t_230, fn__15523);
  temper.stringbuilder_append(builder__1931, "'");
  return nil;
end;
SqlDate.constructor = function(this__640, value__1935)
  this__640.value__1929 = value__1935;
  return nil;
end;
SqlDate.get.value = function(this__2118)
  return this__2118.value__1929;
end;
SqlFloat64 = temper.type('SqlFloat64', SqlPart);
SqlFloat64.methods.formatTo = function(this__366, builder__1938)
  local t_235, t_236, s__1940;
  s__1940 = temper.float64_tostring(this__366.value__1936);
  if temper.str_eq(s__1940, 'NaN') then
    t_236 = true;
  else
    if temper.str_eq(s__1940, 'Infinity') then
      t_235 = true;
    else
      t_235 = temper.str_eq(s__1940, '-Infinity');
    end
    t_236 = t_235;
  end
  if t_236 then
    temper.stringbuilder_append(builder__1938, 'NULL');
  else
    temper.stringbuilder_append(builder__1938, s__1940);
  end
  return nil;
end;
SqlFloat64.constructor = function(this__643, value__1942)
  this__643.value__1936 = value__1942;
  return nil;
end;
SqlFloat64.get.value = function(this__2115)
  return this__2115.value__1936;
end;
SqlInt32 = temper.type('SqlInt32', SqlPart);
SqlInt32.methods.formatTo = function(this__367, builder__1945)
  local t_237;
  t_237 = temper.int32_tostring(this__367.value__1943);
  temper.stringbuilder_append(builder__1945, t_237);
  return nil;
end;
SqlInt32.constructor = function(this__646, value__1948)
  this__646.value__1943 = value__1948;
  return nil;
end;
SqlInt32.get.value = function(this__2109)
  return this__2109.value__1943;
end;
SqlInt64 = temper.type('SqlInt64', SqlPart);
SqlInt64.methods.formatTo = function(this__368, builder__1951)
  local t_238;
  t_238 = temper.int64_tostring(this__368.value__1949);
  temper.stringbuilder_append(builder__1951, t_238);
  return nil;
end;
SqlInt64.constructor = function(this__649, value__1954)
  this__649.value__1949 = value__1954;
  return nil;
end;
SqlInt64.get.value = function(this__2112)
  return this__2112.value__1949;
end;
SqlDefault = temper.type('SqlDefault', SqlPart);
SqlDefault.methods.formatTo = function(this__369, builder__1956)
  temper.stringbuilder_append(builder__1956, 'DEFAULT');
  return nil;
end;
SqlDefault.constructor = function(this__652)
  return nil;
end;
SqlString = temper.type('SqlString', SqlPart);
SqlString.methods.formatTo = function(this__370, builder__1961)
  local fn__15537;
  temper.stringbuilder_append(builder__1961, "'");
  fn__15537 = function(c__1963)
    if (c__1963 == 39) then
      temper.stringbuilder_append(builder__1961, "''");
    else
      local local_239, local_240, local_241;
      local_239, local_240, local_241 = temper.pcall(function()
        temper.stringbuilder_appendcodepoint(builder__1961, c__1963);
      end);
      if local_239 then
      else
        temper.bubble();
      end
    end
    return nil;
  end;
  temper.string_foreach(this__370.value__1959, fn__15537);
  temper.stringbuilder_append(builder__1961, "'");
  return nil;
end;
SqlString.constructor = function(this__655, value__1965)
  this__655.value__1959 = value__1965;
  return nil;
end;
SqlString.get.value = function(this__2106)
  return this__2106.value__1959;
end;
changeset = function(tableDef__950, params__951)
  local t_243;
  t_243 = temper.map_constructor(temper.listof());
  return ChangesetImpl__249(tableDef__950, params__951, t_243, temper.listof(), true);
end;
isIdentStart__663 = function(c__1768)
  local return__581, t_244, t_245;
  if (c__1768 >= 97) then
    t_244 = (c__1768 <= 122);
  else
    t_244 = false;
  end
  if t_244 then
    return__581 = true;
  else
    if (c__1768 >= 65) then
      t_245 = (c__1768 <= 90);
    else
      t_245 = false;
    end
    if t_245 then
      return__581 = true;
    else
      return__581 = (c__1768 == 95);
    end
  end
  return return__581;
end;
isIdentPart__664 = function(c__1770)
  local return__582;
  if isIdentStart__663(c__1770) then
    return__582 = true;
  elseif (c__1770 >= 48) then
    return__582 = (c__1770 <= 57);
  else
    return__582 = false;
  end
  return return__582;
end;
safeIdentifier = function(name__1772)
  local t_246, idx__1774, t_247;
  if temper.string_isempty(name__1772) then
    temper.bubble();
  end
  idx__1774 = 1.0;
  if not isIdentStart__663(temper.string_get(name__1772, idx__1774)) then
    temper.bubble();
  end
  t_247 = temper.string_next(name__1772, idx__1774);
  idx__1774 = t_247;
  while true do
    if not temper.string_hasindex(name__1772, idx__1774) then
      break;
    end
    if not isIdentPart__664(temper.string_get(name__1772, idx__1774)) then
      temper.bubble();
    end
    t_246 = temper.string_next(name__1772, idx__1774);
    idx__1774 = t_246;
  end
  return ValidatedIdentifier__334(name__1772);
end;
timestamps = function()
  local t_569, t_570, t_571;
  t_569 = safeIdentifier('inserted_at');
  t_570 = FieldDef(t_569, DateField(), true, SqlDefault(), false);
  t_571 = safeIdentifier('updated_at');
  return temper.listof(t_570, FieldDef(t_571, DateField(), true, SqlDefault(), false));
end;
deleteSql = function(tableDef__1193, id__1194)
  local b__1196;
  b__1196 = SqlBuilder();
  b__1196:appendSafe('DELETE FROM ');
  b__1196:appendSafe(tableDef__1193.tableName.sqlValue);
  b__1196:appendSafe(' WHERE ');
  b__1196:appendSafe(tableDef__1193:pkName());
  b__1196:appendSafe(' = ');
  b__1196:appendInt32(id__1194);
  return b__1196.accumulated;
end;
from = function(tableName__1428)
  return Query(tableName__1428, temper.listof(), temper.listof(), temper.listof(), temper.null, temper.null, temper.listof(), temper.listof(), temper.listof(), false, temper.listof(), temper.null);
end;
col = function(table__1430, column__1431)
  local b__1433;
  b__1433 = SqlBuilder();
  b__1433:appendSafe(table__1430.sqlValue);
  b__1433:appendSafe('.');
  b__1433:appendSafe(column__1431.sqlValue);
  return b__1433.accumulated;
end;
countAll = function()
  local b__1435;
  b__1435 = SqlBuilder();
  b__1435:appendSafe('COUNT(*)');
  return b__1435.accumulated;
end;
countCol = function(field__1436)
  local b__1438;
  b__1438 = SqlBuilder();
  b__1438:appendSafe('COUNT(');
  b__1438:appendSafe(field__1436.sqlValue);
  b__1438:appendSafe(')');
  return b__1438.accumulated;
end;
sumCol = function(field__1439)
  local b__1441;
  b__1441 = SqlBuilder();
  b__1441:appendSafe('SUM(');
  b__1441:appendSafe(field__1439.sqlValue);
  b__1441:appendSafe(')');
  return b__1441.accumulated;
end;
avgCol = function(field__1442)
  local b__1444;
  b__1444 = SqlBuilder();
  b__1444:appendSafe('AVG(');
  b__1444:appendSafe(field__1442.sqlValue);
  b__1444:appendSafe(')');
  return b__1444.accumulated;
end;
minCol = function(field__1445)
  local b__1447;
  b__1447 = SqlBuilder();
  b__1447:appendSafe('MIN(');
  b__1447:appendSafe(field__1445.sqlValue);
  b__1447:appendSafe(')');
  return b__1447.accumulated;
end;
maxCol = function(field__1448)
  local b__1450;
  b__1450 = SqlBuilder();
  b__1450:appendSafe('MAX(');
  b__1450:appendSafe(field__1448.sqlValue);
  b__1450:appendSafe(')');
  return b__1450.accumulated;
end;
unionSql = function(a__1451, b__1452)
  local sb__1454;
  sb__1454 = SqlBuilder();
  sb__1454:appendSafe('(');
  sb__1454:appendFragment(a__1451:toSql());
  sb__1454:appendSafe(') UNION (');
  sb__1454:appendFragment(b__1452:toSql());
  sb__1454:appendSafe(')');
  return sb__1454.accumulated;
end;
unionAllSql = function(a__1455, b__1456)
  local sb__1458;
  sb__1458 = SqlBuilder();
  sb__1458:appendSafe('(');
  sb__1458:appendFragment(a__1455:toSql());
  sb__1458:appendSafe(') UNION ALL (');
  sb__1458:appendFragment(b__1456:toSql());
  sb__1458:appendSafe(')');
  return sb__1458.accumulated;
end;
intersectSql = function(a__1459, b__1460)
  local sb__1462;
  sb__1462 = SqlBuilder();
  sb__1462:appendSafe('(');
  sb__1462:appendFragment(a__1459:toSql());
  sb__1462:appendSafe(') INTERSECT (');
  sb__1462:appendFragment(b__1460:toSql());
  sb__1462:appendSafe(')');
  return sb__1462.accumulated;
end;
exceptSql = function(a__1463, b__1464)
  local sb__1466;
  sb__1466 = SqlBuilder();
  sb__1466:appendSafe('(');
  sb__1466:appendFragment(a__1463:toSql());
  sb__1466:appendSafe(') EXCEPT (');
  sb__1466:appendFragment(b__1464:toSql());
  sb__1466:appendSafe(')');
  return sb__1466.accumulated;
end;
subquery = function(q__1467, alias__1468)
  local b__1470;
  b__1470 = SqlBuilder();
  b__1470:appendSafe('(');
  b__1470:appendFragment(q__1467:toSql());
  b__1470:appendSafe(') AS ');
  b__1470:appendSafe(alias__1468.sqlValue);
  return b__1470.accumulated;
end;
existsSql = function(q__1471)
  local b__1473;
  b__1473 = SqlBuilder();
  b__1473:appendSafe('EXISTS (');
  b__1473:appendFragment(q__1471:toSql());
  b__1473:appendSafe(')');
  return b__1473.accumulated;
end;
update = function(tableName__1533)
  return UpdateQuery(tableName__1533, temper.listof(), temper.listof(), temper.null);
end;
deleteFrom = function(tableName__1535)
  return DeleteQuery(tableName__1535, temper.listof(), temper.null);
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
