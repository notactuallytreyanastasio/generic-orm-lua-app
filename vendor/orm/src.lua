local temper = require('temper-core');
local ChangesetError, NumberValidationOpts, Changeset, ChangesetImpl__234, JoinType, InnerJoin, LeftJoin, RightJoin, FullJoin, CrossJoin, JoinClause, NullsPosition, NullsFirst, NullsLast, OrderClause, LockMode, ForUpdate, ForShare, WhereClause, AndCondition, OrCondition, Query, SetClause, UpdateQuery, DeleteQuery, SafeIdentifier, ValidatedIdentifier__319, FieldType, StringField, IntField, Int64Field, FloatField, BoolField, DateField, FieldDef, TableDef, SqlBuilder, SqlFragment, SqlPart, SqlSource, SqlBoolean, SqlDate, SqlFloat64, SqlInt32, SqlInt64, SqlString, changeset, isIdentStart__639, isIdentPart__640, safeIdentifier, deleteSql, from, col, countAll, countCol, sumCol, avgCol, minCol, maxCol, unionSql, unionAllSql, intersectSql, exceptSql, subquery, existsSql, update, deleteFrom, exports;
ChangesetError = temper.type('ChangesetError');
ChangesetError.constructor = function(this__354, field__646, message__647)
  this__354.field__643 = field__646;
  this__354.message__644 = message__647;
  return nil;
end;
ChangesetError.get.field = function(this__1950)
  return this__1950.field__643;
end;
ChangesetError.get.message = function(this__1953)
  return this__1953.message__644;
end;
NumberValidationOpts = temper.type('NumberValidationOpts');
NumberValidationOpts.constructor = function(this__356, greaterThan__654, lessThan__655, greaterThanOrEqual__656, lessThanOrEqual__657, equalTo__658)
  if (greaterThan__654 == nil) then
    greaterThan__654 = temper.null;
  end
  if (lessThan__655 == nil) then
    lessThan__655 = temper.null;
  end
  if (greaterThanOrEqual__656 == nil) then
    greaterThanOrEqual__656 = temper.null;
  end
  if (lessThanOrEqual__657 == nil) then
    lessThanOrEqual__657 = temper.null;
  end
  if (equalTo__658 == nil) then
    equalTo__658 = temper.null;
  end
  this__356.greaterThan__648 = greaterThan__654;
  this__356.lessThan__649 = lessThan__655;
  this__356.greaterThanOrEqual__650 = greaterThanOrEqual__656;
  this__356.lessThanOrEqual__651 = lessThanOrEqual__657;
  this__356.equalTo__652 = equalTo__658;
  return nil;
end;
NumberValidationOpts.get.greaterThan = function(this__1956)
  return this__1956.greaterThan__648;
end;
NumberValidationOpts.get.lessThan = function(this__1959)
  return this__1959.lessThan__649;
end;
NumberValidationOpts.get.greaterThanOrEqual = function(this__1962)
  return this__1962.greaterThanOrEqual__650;
end;
NumberValidationOpts.get.lessThanOrEqual = function(this__1965)
  return this__1965.lessThanOrEqual__651;
end;
NumberValidationOpts.get.equalTo = function(this__1968)
  return this__1968.equalTo__652;
end;
Changeset = temper.type('Changeset');
Changeset.get.tableDef = function(this__210)
  temper.virtual();
end;
Changeset.get.changes = function(this__211)
  temper.virtual();
end;
Changeset.get.errors = function(this__212)
  temper.virtual();
end;
Changeset.get.isValid = function(this__213)
  temper.virtual();
end;
Changeset.methods.cast = function(this__214, allowedFields__668)
  temper.virtual();
end;
Changeset.methods.validateRequired = function(this__215, fields__671)
  temper.virtual();
end;
Changeset.methods.validateLength = function(this__216, field__674, min__675, max__676)
  temper.virtual();
end;
Changeset.methods.validateInt = function(this__217, field__679)
  temper.virtual();
end;
Changeset.methods.validateInt64 = function(this__218, field__682)
  temper.virtual();
end;
Changeset.methods.validateFloat = function(this__219, field__685)
  temper.virtual();
end;
Changeset.methods.validateBool = function(this__220, field__688)
  temper.virtual();
end;
Changeset.methods.putChange = function(this__221, field__691, value__692)
  temper.virtual();
end;
Changeset.methods.getChange = function(this__222, field__695)
  temper.virtual();
end;
Changeset.methods.deleteChange = function(this__223, field__698)
  temper.virtual();
end;
Changeset.methods.validateInclusion = function(this__224, field__701, allowed__702)
  temper.virtual();
end;
Changeset.methods.validateExclusion = function(this__225, field__705, disallowed__706)
  temper.virtual();
end;
Changeset.methods.validateNumber = function(this__226, field__709, opts__710)
  temper.virtual();
end;
Changeset.methods.validateAcceptance = function(this__227, field__713)
  temper.virtual();
end;
Changeset.methods.validateConfirmation = function(this__228, field__716, confirmationField__717)
  temper.virtual();
end;
Changeset.methods.validateContains = function(this__229, field__720, substring__721)
  temper.virtual();
end;
Changeset.methods.validateStartsWith = function(this__230, field__724, prefix__725)
  temper.virtual();
end;
Changeset.methods.validateEndsWith = function(this__231, field__728, suffix__729)
  temper.virtual();
end;
Changeset.methods.toInsertSql = function(this__232)
  temper.virtual();
end;
Changeset.methods.toUpdateSql = function(this__233, id__734)
  temper.virtual();
end;
ChangesetImpl__234 = temper.type('ChangesetImpl__234', Changeset);
ChangesetImpl__234.get.tableDef = function(this__235)
  return this__235._tableDef__736;
end;
ChangesetImpl__234.get.changes = function(this__236)
  return this__236._changes__738;
end;
ChangesetImpl__234.get.errors = function(this__237)
  return this__237._errors__739;
end;
ChangesetImpl__234.get.isValid = function(this__238)
  return this__238._isValid__740;
end;
ChangesetImpl__234.methods.cast = function(this__239, allowedFields__750)
  local mb__752, fn__14193;
  mb__752 = temper.mapbuilder_constructor();
  fn__14193 = function(f__753)
    local t_0, t_1, val__754;
    t_1 = f__753.sqlValue;
    val__754 = temper.mapped_getor(this__239._params__737, t_1, '');
    if not temper.string_isempty(val__754) then
      t_0 = f__753.sqlValue;
      temper.mapbuilder_set(mb__752, t_0, val__754);
    end
    return nil;
  end;
  temper.list_foreach(allowedFields__750, fn__14193);
  return ChangesetImpl__234(this__239._tableDef__736, this__239._params__737, temper.mapped_tomap(mb__752), this__239._errors__739, this__239._isValid__740);
end;
ChangesetImpl__234.methods.validateRequired = function(this__240, fields__756)
  local return__405, t_2, t_3, t_4, t_5, eb__758, valid__759, fn__14182;
  ::continue_1::
  if not this__240._isValid__740 then
    return__405 = this__240;
    goto break_0;
  end
  eb__758 = temper.list_tolistbuilder(this__240._errors__739);
  valid__759 = true;
  fn__14182 = function(f__760)
    local t_6, t_7;
    t_7 = f__760.sqlValue;
    if not temper.mapped_has(this__240._changes__738, t_7) then
      t_6 = ChangesetError(f__760.sqlValue, 'is required');
      temper.listbuilder_add(eb__758, t_6);
      valid__759 = false;
    end
    return nil;
  end;
  temper.list_foreach(fields__756, fn__14182);
  t_3 = this__240._tableDef__736;
  t_4 = this__240._params__737;
  t_5 = this__240._changes__738;
  t_2 = temper.listbuilder_tolist(eb__758);
  return__405 = ChangesetImpl__234(t_3, t_4, t_5, t_2, valid__759);
  ::break_0::return return__405;
end;
ChangesetImpl__234.methods.validateLength = function(this__241, field__762, min__763, max__764)
  local return__406, t_8, t_9, t_10, t_11, t_12, t_13, val__766, len__767;
  ::continue_3::
  if not this__241._isValid__740 then
    return__406 = this__241;
    goto break_2;
  end
  t_8 = field__762.sqlValue;
  val__766 = temper.mapped_getor(this__241._changes__738, t_8, '');
  len__767 = temper.string_countbetween(val__766, 1.0, temper.string_end(val__766));
  if (len__767 < min__763) then
    t_10 = true;
  else
    t_10 = (len__767 > max__764);
  end
  if t_10 then
    local msg__768, eb__769;
    msg__768 = temper.concat('must be between ', temper.int32_tostring(min__763), ' and ', temper.int32_tostring(max__764), ' characters');
    eb__769 = temper.list_tolistbuilder(this__241._errors__739);
    temper.listbuilder_add(eb__769, ChangesetError(field__762.sqlValue, msg__768));
    t_11 = this__241._tableDef__736;
    t_12 = this__241._params__737;
    t_13 = this__241._changes__738;
    t_9 = temper.listbuilder_tolist(eb__769);
    return__406 = ChangesetImpl__234(t_11, t_12, t_13, t_9, false);
    goto break_2;
  end
  return__406 = this__241;
  ::break_2::return return__406;
end;
ChangesetImpl__234.methods.validateInt = function(this__242, field__771)
  local return__407, t_14, t_15, t_16, t_17, t_18, val__773, parseOk__774, local_19, local_20, local_21;
  ::continue_5::
  if not this__242._isValid__740 then
    return__407 = this__242;
    goto break_4;
  end
  t_14 = field__771.sqlValue;
  val__773 = temper.mapped_getor(this__242._changes__738, t_14, '');
  if temper.string_isempty(val__773) then
    return__407 = this__242;
    goto break_4;
  end
  local_19, local_20, local_21 = temper.pcall(function()
    temper.string_toint32(val__773);
    parseOk__774 = true;
  end);
  if local_19 then
  else
    parseOk__774 = false;
  end
  if not parseOk__774 then
    local eb__775;
    eb__775 = temper.list_tolistbuilder(this__242._errors__739);
    temper.listbuilder_add(eb__775, ChangesetError(field__771.sqlValue, 'must be an integer'));
    t_16 = this__242._tableDef__736;
    t_17 = this__242._params__737;
    t_18 = this__242._changes__738;
    t_15 = temper.listbuilder_tolist(eb__775);
    return__407 = ChangesetImpl__234(t_16, t_17, t_18, t_15, false);
    goto break_4;
  end
  return__407 = this__242;
  ::break_4::return return__407;
end;
ChangesetImpl__234.methods.validateInt64 = function(this__243, field__777)
  local return__408, t_23, t_24, t_25, t_26, t_27, val__779, parseOk__780, local_28, local_29, local_30;
  ::continue_7::
  if not this__243._isValid__740 then
    return__408 = this__243;
    goto break_6;
  end
  t_23 = field__777.sqlValue;
  val__779 = temper.mapped_getor(this__243._changes__738, t_23, '');
  if temper.string_isempty(val__779) then
    return__408 = this__243;
    goto break_6;
  end
  local_28, local_29, local_30 = temper.pcall(function()
    temper.string_toint64(val__779);
    parseOk__780 = true;
  end);
  if local_28 then
  else
    parseOk__780 = false;
  end
  if not parseOk__780 then
    local eb__781;
    eb__781 = temper.list_tolistbuilder(this__243._errors__739);
    temper.listbuilder_add(eb__781, ChangesetError(field__777.sqlValue, 'must be a 64-bit integer'));
    t_25 = this__243._tableDef__736;
    t_26 = this__243._params__737;
    t_27 = this__243._changes__738;
    t_24 = temper.listbuilder_tolist(eb__781);
    return__408 = ChangesetImpl__234(t_25, t_26, t_27, t_24, false);
    goto break_6;
  end
  return__408 = this__243;
  ::break_6::return return__408;
end;
ChangesetImpl__234.methods.validateFloat = function(this__244, field__783)
  local return__409, t_32, t_33, t_34, t_35, t_36, val__785, parseOk__786, local_37, local_38, local_39;
  ::continue_9::
  if not this__244._isValid__740 then
    return__409 = this__244;
    goto break_8;
  end
  t_32 = field__783.sqlValue;
  val__785 = temper.mapped_getor(this__244._changes__738, t_32, '');
  if temper.string_isempty(val__785) then
    return__409 = this__244;
    goto break_8;
  end
  local_37, local_38, local_39 = temper.pcall(function()
    temper.string_tofloat64(val__785);
    parseOk__786 = true;
  end);
  if local_37 then
  else
    parseOk__786 = false;
  end
  if not parseOk__786 then
    local eb__787;
    eb__787 = temper.list_tolistbuilder(this__244._errors__739);
    temper.listbuilder_add(eb__787, ChangesetError(field__783.sqlValue, 'must be a number'));
    t_34 = this__244._tableDef__736;
    t_35 = this__244._params__737;
    t_36 = this__244._changes__738;
    t_33 = temper.listbuilder_tolist(eb__787);
    return__409 = ChangesetImpl__234(t_34, t_35, t_36, t_33, false);
    goto break_8;
  end
  return__409 = this__244;
  ::break_8::return return__409;
end;
ChangesetImpl__234.methods.validateBool = function(this__245, field__789)
  local return__410, t_41, t_42, t_43, t_44, t_45, t_46, t_47, t_48, t_49, t_50, val__791, isTrue__792, isFalse__793;
  ::continue_11::
  if not this__245._isValid__740 then
    return__410 = this__245;
    goto break_10;
  end
  t_41 = field__789.sqlValue;
  val__791 = temper.mapped_getor(this__245._changes__738, t_41, '');
  if temper.string_isempty(val__791) then
    return__410 = this__245;
    goto break_10;
  end
  if temper.str_eq(val__791, 'true') then
    isTrue__792 = true;
  else
    if temper.str_eq(val__791, '1') then
      t_44 = true;
    else
      if temper.str_eq(val__791, 'yes') then
        t_43 = true;
      else
        t_43 = temper.str_eq(val__791, 'on');
      end
      t_44 = t_43;
    end
    isTrue__792 = t_44;
  end
  if temper.str_eq(val__791, 'false') then
    isFalse__793 = true;
  else
    if temper.str_eq(val__791, '0') then
      t_46 = true;
    else
      if temper.str_eq(val__791, 'no') then
        t_45 = true;
      else
        t_45 = temper.str_eq(val__791, 'off');
      end
      t_46 = t_45;
    end
    isFalse__793 = t_46;
  end
  if not isTrue__792 then
    t_47 = not isFalse__793;
  else
    t_47 = false;
  end
  if t_47 then
    local eb__794;
    eb__794 = temper.list_tolistbuilder(this__245._errors__739);
    temper.listbuilder_add(eb__794, ChangesetError(field__789.sqlValue, 'must be a boolean (true/false/1/0/yes/no/on/off)'));
    t_48 = this__245._tableDef__736;
    t_49 = this__245._params__737;
    t_50 = this__245._changes__738;
    t_42 = temper.listbuilder_tolist(eb__794);
    return__410 = ChangesetImpl__234(t_48, t_49, t_50, t_42, false);
    goto break_10;
  end
  return__410 = this__245;
  ::break_10::return return__410;
end;
ChangesetImpl__234.methods.putChange = function(this__246, field__796, value__797)
  local t_51, mb__799, pairs__800, i__801;
  mb__799 = temper.mapbuilder_constructor();
  pairs__800 = temper.mapped_tolist(this__246._changes__738);
  i__801 = 0;
  while true do
    t_51 = temper.list_length(pairs__800);
    if not (i__801 < t_51) then
      break;
    end
    temper.mapbuilder_set(mb__799, (temper.list_get(pairs__800, i__801)).key, (temper.list_get(pairs__800, i__801)).value);
    i__801 = temper.int32_add(i__801, 1);
  end
  temper.mapbuilder_set(mb__799, field__796.sqlValue, value__797);
  return ChangesetImpl__234(this__246._tableDef__736, this__246._params__737, temper.mapped_tomap(mb__799), this__246._errors__739, this__246._isValid__740);
end;
ChangesetImpl__234.methods.getChange = function(this__247, field__803)
  local t_52, t_53;
  t_52 = field__803.sqlValue;
  if not temper.mapped_has(this__247._changes__738, t_52) then
    temper.bubble();
  end
  t_53 = field__803.sqlValue;
  return temper.mapped_getor(this__247._changes__738, t_53, '');
end;
ChangesetImpl__234.methods.deleteChange = function(this__248, field__806)
  local t_54, mb__808, pairs__809, i__810;
  mb__808 = temper.mapbuilder_constructor();
  pairs__809 = temper.mapped_tolist(this__248._changes__738);
  i__810 = 0;
  while true do
    t_54 = temper.list_length(pairs__809);
    if not (i__810 < t_54) then
      break;
    end
    if temper.str_ne((temper.list_get(pairs__809, i__810)).key, field__806.sqlValue) then
      temper.mapbuilder_set(mb__808, (temper.list_get(pairs__809, i__810)).key, (temper.list_get(pairs__809, i__810)).value);
    end
    i__810 = temper.int32_add(i__810, 1);
  end
  return ChangesetImpl__234(this__248._tableDef__736, this__248._params__737, temper.mapped_tomap(mb__808), this__248._errors__739, this__248._isValid__740);
end;
ChangesetImpl__234.methods.validateInclusion = function(this__249, field__812, allowed__813)
  local return__414, t_55, t_56, t_57, t_58, t_59, t_60, val__815, found__816, fn__14082;
  ::continue_13::
  if not this__249._isValid__740 then
    return__414 = this__249;
    goto break_12;
  end
  t_55 = field__812.sqlValue;
  if not temper.mapped_has(this__249._changes__738, t_55) then
    return__414 = this__249;
    goto break_12;
  end
  t_56 = field__812.sqlValue;
  val__815 = temper.mapped_getor(this__249._changes__738, t_56, '');
  found__816 = false;
  fn__14082 = function(a__817)
    if temper.str_eq(a__817, val__815) then
      found__816 = true;
    end
    return nil;
  end;
  temper.list_foreach(allowed__813, fn__14082);
  if not found__816 then
    local eb__818;
    eb__818 = temper.list_tolistbuilder(this__249._errors__739);
    temper.listbuilder_add(eb__818, ChangesetError(field__812.sqlValue, 'is not included in the list'));
    t_58 = this__249._tableDef__736;
    t_59 = this__249._params__737;
    t_60 = this__249._changes__738;
    t_57 = temper.listbuilder_tolist(eb__818);
    return__414 = ChangesetImpl__234(t_58, t_59, t_60, t_57, false);
    goto break_12;
  end
  return__414 = this__249;
  ::break_12::return return__414;
end;
ChangesetImpl__234.methods.validateExclusion = function(this__250, field__820, disallowed__821)
  local return__415, t_61, t_62, t_63, t_64, t_65, t_66, val__823, found__824, fn__14069;
  ::continue_15::
  if not this__250._isValid__740 then
    return__415 = this__250;
    goto break_14;
  end
  t_61 = field__820.sqlValue;
  if not temper.mapped_has(this__250._changes__738, t_61) then
    return__415 = this__250;
    goto break_14;
  end
  t_62 = field__820.sqlValue;
  val__823 = temper.mapped_getor(this__250._changes__738, t_62, '');
  found__824 = false;
  fn__14069 = function(d__825)
    if temper.str_eq(d__825, val__823) then
      found__824 = true;
    end
    return nil;
  end;
  temper.list_foreach(disallowed__821, fn__14069);
  if found__824 then
    local eb__826;
    eb__826 = temper.list_tolistbuilder(this__250._errors__739);
    temper.listbuilder_add(eb__826, ChangesetError(field__820.sqlValue, 'is reserved'));
    t_64 = this__250._tableDef__736;
    t_65 = this__250._params__737;
    t_66 = this__250._changes__738;
    t_63 = temper.listbuilder_tolist(eb__826);
    return__415 = ChangesetImpl__234(t_64, t_65, t_66, t_63, false);
    goto break_14;
  end
  return__415 = this__250;
  ::break_14::return return__415;
end;
ChangesetImpl__234.methods.validateNumber = function(this__251, field__828, opts__829)
  local return__416, t_67, t_68, t_69, t_70, t_71, t_72, t_73, t_74, t_75, t_76, t_77, t_78, t_79, t_80, t_81, t_82, t_83, t_84, t_85, t_86, t_87, t_88, t_89, t_90, t_91, t_92, t_93, val__831, parseOk__832, local_94, local_95, local_96, num__834, local_98, local_99, local_100, gt__835, lt__837, gte__839, lte__841, eq__843;
  ::continue_17::
  if not this__251._isValid__740 then
    return__416 = this__251;
    goto break_16;
  end
  t_67 = field__828.sqlValue;
  if not temper.mapped_has(this__251._changes__738, t_67) then
    return__416 = this__251;
    goto break_16;
  end
  t_68 = field__828.sqlValue;
  val__831 = temper.mapped_getor(this__251._changes__738, t_68, '');
  local_94, local_95, local_96 = temper.pcall(function()
    temper.string_tofloat64(val__831);
    parseOk__832 = true;
  end);
  if local_94 then
  else
    parseOk__832 = false;
  end
  if not parseOk__832 then
    local eb__833;
    eb__833 = temper.list_tolistbuilder(this__251._errors__739);
    temper.listbuilder_add(eb__833, ChangesetError(field__828.sqlValue, 'must be a number'));
    t_75 = this__251._tableDef__736;
    t_76 = this__251._params__737;
    t_77 = this__251._changes__738;
    t_69 = temper.listbuilder_tolist(eb__833);
    return__416 = ChangesetImpl__234(t_75, t_76, t_77, t_69, false);
    goto break_16;
  end
  local_98, local_99, local_100 = temper.pcall(function()
    t_78 = temper.string_tofloat64(val__831);
    num__834 = t_78;
  end);
  if local_98 then
  else
    num__834 = 0.0;
  end
  gt__835 = opts__829.greaterThan;
  if not temper.is_null(gt__835) then
    local gt_102;
    gt_102 = gt__835;
    if not temper.float_gt(num__834, gt_102) then
      local eb__836;
      eb__836 = temper.list_tolistbuilder(this__251._errors__739);
      temper.listbuilder_add(eb__836, ChangesetError(field__828.sqlValue, temper.concat('must be greater than ', temper.float64_tostring(gt_102))));
      t_79 = this__251._tableDef__736;
      t_80 = this__251._params__737;
      t_81 = this__251._changes__738;
      t_70 = temper.listbuilder_tolist(eb__836);
      return__416 = ChangesetImpl__234(t_79, t_80, t_81, t_70, false);
      goto break_16;
    end
  end
  lt__837 = opts__829.lessThan;
  if not temper.is_null(lt__837) then
    local lt_103;
    lt_103 = lt__837;
    if not temper.float_lt(num__834, lt_103) then
      local eb__838;
      eb__838 = temper.list_tolistbuilder(this__251._errors__739);
      temper.listbuilder_add(eb__838, ChangesetError(field__828.sqlValue, temper.concat('must be less than ', temper.float64_tostring(lt_103))));
      t_82 = this__251._tableDef__736;
      t_83 = this__251._params__737;
      t_84 = this__251._changes__738;
      t_71 = temper.listbuilder_tolist(eb__838);
      return__416 = ChangesetImpl__234(t_82, t_83, t_84, t_71, false);
      goto break_16;
    end
  end
  gte__839 = opts__829.greaterThanOrEqual;
  if not temper.is_null(gte__839) then
    local gte_104;
    gte_104 = gte__839;
    if not temper.float_ge(num__834, gte_104) then
      local eb__840;
      eb__840 = temper.list_tolistbuilder(this__251._errors__739);
      temper.listbuilder_add(eb__840, ChangesetError(field__828.sqlValue, temper.concat('must be greater than or equal to ', temper.float64_tostring(gte_104))));
      t_85 = this__251._tableDef__736;
      t_86 = this__251._params__737;
      t_87 = this__251._changes__738;
      t_72 = temper.listbuilder_tolist(eb__840);
      return__416 = ChangesetImpl__234(t_85, t_86, t_87, t_72, false);
      goto break_16;
    end
  end
  lte__841 = opts__829.lessThanOrEqual;
  if not temper.is_null(lte__841) then
    local lte_105;
    lte_105 = lte__841;
    if not temper.float_le(num__834, lte_105) then
      local eb__842;
      eb__842 = temper.list_tolistbuilder(this__251._errors__739);
      temper.listbuilder_add(eb__842, ChangesetError(field__828.sqlValue, temper.concat('must be less than or equal to ', temper.float64_tostring(lte_105))));
      t_88 = this__251._tableDef__736;
      t_89 = this__251._params__737;
      t_90 = this__251._changes__738;
      t_73 = temper.listbuilder_tolist(eb__842);
      return__416 = ChangesetImpl__234(t_88, t_89, t_90, t_73, false);
      goto break_16;
    end
  end
  eq__843 = opts__829.equalTo;
  if not temper.is_null(eq__843) then
    local eq_106;
    eq_106 = eq__843;
    if not temper.float_eq(num__834, eq_106) then
      local eb__844;
      eb__844 = temper.list_tolistbuilder(this__251._errors__739);
      temper.listbuilder_add(eb__844, ChangesetError(field__828.sqlValue, temper.concat('must be equal to ', temper.float64_tostring(eq_106))));
      t_91 = this__251._tableDef__736;
      t_92 = this__251._params__737;
      t_93 = this__251._changes__738;
      t_74 = temper.listbuilder_tolist(eb__844);
      return__416 = ChangesetImpl__234(t_91, t_92, t_93, t_74, false);
      goto break_16;
    end
  end
  return__416 = this__251;
  ::break_16::return return__416;
end;
ChangesetImpl__234.methods.validateAcceptance = function(this__252, field__846)
  local return__417, t_107, t_108, t_109, t_110, t_111, t_112, t_113, t_114, val__848, accepted__849;
  ::continue_19::
  if not this__252._isValid__740 then
    return__417 = this__252;
    goto break_18;
  end
  t_107 = field__846.sqlValue;
  if not temper.mapped_has(this__252._changes__738, t_107) then
    return__417 = this__252;
    goto break_18;
  end
  t_108 = field__846.sqlValue;
  val__848 = temper.mapped_getor(this__252._changes__738, t_108, '');
  if temper.str_eq(val__848, 'true') then
    accepted__849 = true;
  else
    if temper.str_eq(val__848, '1') then
      t_111 = true;
    else
      if temper.str_eq(val__848, 'yes') then
        t_110 = true;
      else
        t_110 = temper.str_eq(val__848, 'on');
      end
      t_111 = t_110;
    end
    accepted__849 = t_111;
  end
  if not accepted__849 then
    local eb__850;
    eb__850 = temper.list_tolistbuilder(this__252._errors__739);
    temper.listbuilder_add(eb__850, ChangesetError(field__846.sqlValue, 'must be accepted'));
    t_112 = this__252._tableDef__736;
    t_113 = this__252._params__737;
    t_114 = this__252._changes__738;
    t_109 = temper.listbuilder_tolist(eb__850);
    return__417 = ChangesetImpl__234(t_112, t_113, t_114, t_109, false);
    goto break_18;
  end
  return__417 = this__252;
  ::break_18::return return__417;
end;
ChangesetImpl__234.methods.validateConfirmation = function(this__253, field__852, confirmationField__853)
  local return__418, t_115, t_116, t_117, t_118, t_119, t_120, t_121, val__855, conf__856;
  ::continue_21::
  if not this__253._isValid__740 then
    return__418 = this__253;
    goto break_20;
  end
  t_115 = field__852.sqlValue;
  if not temper.mapped_has(this__253._changes__738, t_115) then
    return__418 = this__253;
    goto break_20;
  end
  t_116 = field__852.sqlValue;
  val__855 = temper.mapped_getor(this__253._changes__738, t_116, '');
  t_117 = confirmationField__853.sqlValue;
  conf__856 = temper.mapped_getor(this__253._changes__738, t_117, '');
  if temper.str_ne(val__855, conf__856) then
    local eb__857;
    eb__857 = temper.list_tolistbuilder(this__253._errors__739);
    temper.listbuilder_add(eb__857, ChangesetError(confirmationField__853.sqlValue, 'does not match'));
    t_119 = this__253._tableDef__736;
    t_120 = this__253._params__737;
    t_121 = this__253._changes__738;
    t_118 = temper.listbuilder_tolist(eb__857);
    return__418 = ChangesetImpl__234(t_119, t_120, t_121, t_118, false);
    goto break_20;
  end
  return__418 = this__253;
  ::break_20::return return__418;
end;
ChangesetImpl__234.methods.validateContains = function(this__254, field__859, substring__860)
  local return__419, t_122, t_123, t_124, t_125, t_126, t_127, val__862;
  ::continue_23::
  if not this__254._isValid__740 then
    return__419 = this__254;
    goto break_22;
  end
  t_122 = field__859.sqlValue;
  if not temper.mapped_has(this__254._changes__738, t_122) then
    return__419 = this__254;
    goto break_22;
  end
  t_123 = field__859.sqlValue;
  val__862 = temper.mapped_getor(this__254._changes__738, t_123, '');
  if not temper.is_string_index(temper.string_indexof(val__862, substring__860)) then
    local eb__863;
    eb__863 = temper.list_tolistbuilder(this__254._errors__739);
    temper.listbuilder_add(eb__863, ChangesetError(field__859.sqlValue, 'must contain the given substring'));
    t_125 = this__254._tableDef__736;
    t_126 = this__254._params__737;
    t_127 = this__254._changes__738;
    t_124 = temper.listbuilder_tolist(eb__863);
    return__419 = ChangesetImpl__234(t_125, t_126, t_127, t_124, false);
    goto break_22;
  end
  return__419 = this__254;
  ::break_22::return return__419;
end;
ChangesetImpl__234.methods.validateStartsWith = function(this__255, field__865, prefix__866)
  local return__420, t_128, t_129, t_130, t_131, t_132, t_133, t_134, val__868, idx__869, starts__870;
  ::continue_25::
  if not this__255._isValid__740 then
    return__420 = this__255;
    goto break_24;
  end
  t_128 = field__865.sqlValue;
  if not temper.mapped_has(this__255._changes__738, t_128) then
    return__420 = this__255;
    goto break_24;
  end
  t_129 = field__865.sqlValue;
  val__868 = temper.mapped_getor(this__255._changes__738, t_129, '');
  idx__869 = temper.string_indexof(val__868, prefix__866);
  if temper.is_string_index(idx__869) then
    t_130 = temper.string_countbetween(val__868, 1.0, temper.require_string_index(idx__869));
    starts__870 = (t_130 == 0);
  else
    starts__870 = false;
  end
  if not starts__870 then
    local eb__871;
    eb__871 = temper.list_tolistbuilder(this__255._errors__739);
    temper.listbuilder_add(eb__871, ChangesetError(field__865.sqlValue, 'must start with the given prefix'));
    t_132 = this__255._tableDef__736;
    t_133 = this__255._params__737;
    t_134 = this__255._changes__738;
    t_131 = temper.listbuilder_tolist(eb__871);
    return__420 = ChangesetImpl__234(t_132, t_133, t_134, t_131, false);
    goto break_24;
  end
  return__420 = this__255;
  ::break_24::return return__420;
end;
ChangesetImpl__234.methods.validateEndsWith = function(this__256, field__873, suffix__874)
  local return__421, t_135, t_136, t_137, t_138, t_139, t_140, t_141, t_142, t_143, t_144, t_145, t_146, t_147, t_148, t_149, t_150, val__876, valLen__877, suffixLen__878, skipCount__880, strIdx__881, i__882, sufIdx__883, matches__884;
  ::continue_27::
  if not this__256._isValid__740 then
    return__421 = this__256;
    goto break_26;
  end
  t_135 = field__873.sqlValue;
  if not temper.mapped_has(this__256._changes__738, t_135) then
    return__421 = this__256;
    goto break_26;
  end
  t_136 = field__873.sqlValue;
  val__876 = temper.mapped_getor(this__256._changes__738, t_136, '');
  valLen__877 = temper.string_countbetween(val__876, 1.0, temper.string_end(val__876));
  t_137 = temper.string_end(suffix__874);
  suffixLen__878 = temper.string_countbetween(suffix__874, 1.0, t_137);
  if (valLen__877 < suffixLen__878) then
    local eb__879;
    eb__879 = temper.list_tolistbuilder(this__256._errors__739);
    temper.listbuilder_add(eb__879, ChangesetError(field__873.sqlValue, 'must end with the given suffix'));
    t_144 = this__256._tableDef__736;
    t_145 = this__256._params__737;
    t_146 = this__256._changes__738;
    t_138 = temper.listbuilder_tolist(eb__879);
    return__421 = ChangesetImpl__234(t_144, t_145, t_146, t_138, false);
    goto break_26;
  end
  skipCount__880 = temper.int32_sub(valLen__877, suffixLen__878);
  strIdx__881 = 1.0;
  i__882 = 0;
  while (i__882 < skipCount__880) do
    t_139 = temper.string_next(val__876, strIdx__881);
    strIdx__881 = t_139;
    i__882 = temper.int32_add(i__882, 1);
  end
  sufIdx__883 = 1.0;
  matches__884 = true;
  while true do
    if matches__884 then
      t_140 = temper.string_hasindex(suffix__874, sufIdx__883);
      t_147 = t_140;
    else
      t_147 = false;
    end
    if not t_147 then
      break;
    end
    if not temper.string_hasindex(val__876, strIdx__881) then
      matches__884 = false;
    elseif (temper.string_get(val__876, strIdx__881) ~= temper.string_get(suffix__874, sufIdx__883)) then
      matches__884 = false;
    else
      t_141 = temper.string_next(val__876, strIdx__881);
      strIdx__881 = t_141;
      t_142 = temper.string_next(suffix__874, sufIdx__883);
      sufIdx__883 = t_142;
    end
  end
  if not matches__884 then
    local eb__885;
    eb__885 = temper.list_tolistbuilder(this__256._errors__739);
    temper.listbuilder_add(eb__885, ChangesetError(field__873.sqlValue, 'must end with the given suffix'));
    t_148 = this__256._tableDef__736;
    t_149 = this__256._params__737;
    t_150 = this__256._changes__738;
    t_143 = temper.listbuilder_tolist(eb__885);
    return__421 = ChangesetImpl__234(t_148, t_149, t_150, t_143, false);
    goto break_26;
  end
  return__421 = this__256;
  ::break_26::return return__421;
end;
ChangesetImpl__234.methods.parseBoolSqlPart = function(this__257, val__887)
  local return__422, t_151, t_152, t_153, t_154, t_155, t_156;
  ::continue_29::
  if temper.str_eq(val__887, 'true') then
    t_153 = true;
  else
    if temper.str_eq(val__887, '1') then
      t_152 = true;
    else
      if temper.str_eq(val__887, 'yes') then
        t_151 = true;
      else
        t_151 = temper.str_eq(val__887, 'on');
      end
      t_152 = t_151;
    end
    t_153 = t_152;
  end
  if t_153 then
    return__422 = SqlBoolean(true);
    goto break_28;
  end
  if temper.str_eq(val__887, 'false') then
    t_156 = true;
  else
    if temper.str_eq(val__887, '0') then
      t_155 = true;
    else
      if temper.str_eq(val__887, 'no') then
        t_154 = true;
      else
        t_154 = temper.str_eq(val__887, 'off');
      end
      t_155 = t_154;
    end
    t_156 = t_155;
  end
  if t_156 then
    return__422 = SqlBoolean(false);
    goto break_28;
  end
  temper.bubble();
  ::break_28::return return__422;
end;
ChangesetImpl__234.methods.valueToSqlPart = function(this__258, fieldDef__890, val__891)
  local return__423, t_157, t_158, t_159, t_160, ft__893;
  ::continue_31::ft__893 = fieldDef__890.fieldType;
  if temper.instance_of(ft__893, StringField) then
    return__423 = SqlString(val__891);
    goto break_30;
  end
  if temper.instance_of(ft__893, IntField) then
    t_157 = temper.string_toint32(val__891);
    return__423 = SqlInt32(t_157);
    goto break_30;
  end
  if temper.instance_of(ft__893, Int64Field) then
    t_158 = temper.string_toint64(val__891);
    return__423 = SqlInt64(t_158);
    goto break_30;
  end
  if temper.instance_of(ft__893, FloatField) then
    t_159 = temper.string_tofloat64(val__891);
    return__423 = SqlFloat64(t_159);
    goto break_30;
  end
  if temper.instance_of(ft__893, BoolField) then
    return__423 = this__258:parseBoolSqlPart(val__891);
    goto break_30;
  end
  if temper.instance_of(ft__893, DateField) then
    t_160 = temper.date_fromisostring(val__891);
    return__423 = SqlDate(t_160);
    goto break_30;
  end
  temper.bubble();
  ::break_30::return return__423;
end;
ChangesetImpl__234.methods.toInsertSql = function(this__259)
  local t_161, t_162, t_163, t_164, t_165, t_166, t_167, t_168, t_169, t_170, i__896, pairs__898, colNames__899, valParts__900, i__901, b__904, t_171, fn__13890, j__906;
  if not this__259._isValid__740 then
    temper.bubble();
  end
  i__896 = 0;
  while true do
    local f__897;
    t_161 = temper.list_length(this__259._tableDef__736.fields);
    if not (i__896 < t_161) then
      break;
    end
    f__897 = temper.list_get(this__259._tableDef__736.fields, i__896);
    if not f__897.nullable then
      t_162 = f__897.name.sqlValue;
      t_163 = temper.mapped_has(this__259._changes__738, t_162);
      t_168 = not t_163;
    else
      t_168 = false;
    end
    if t_168 then
      temper.bubble();
    end
    i__896 = temper.int32_add(i__896, 1);
  end
  pairs__898 = temper.mapped_tolist(this__259._changes__738);
  if (temper.list_length(pairs__898) == 0) then
    temper.bubble();
  end
  colNames__899 = temper.listbuilder_constructor();
  valParts__900 = temper.listbuilder_constructor();
  i__901 = 0;
  while true do
    local pair__902, fd__903;
    t_164 = temper.list_length(pairs__898);
    if not (i__901 < t_164) then
      break;
    end
    pair__902 = temper.list_get(pairs__898, i__901);
    t_165 = pair__902.key;
    t_169 = this__259._tableDef__736:field(t_165);
    fd__903 = t_169;
    temper.listbuilder_add(colNames__899, fd__903.name.sqlValue);
    t_166 = pair__902.value;
    t_170 = this__259:valueToSqlPart(fd__903, t_166);
    temper.listbuilder_add(valParts__900, t_170);
    i__901 = temper.int32_add(i__901, 1);
  end
  b__904 = SqlBuilder();
  b__904:appendSafe('INSERT INTO ');
  b__904:appendSafe(this__259._tableDef__736.tableName.sqlValue);
  b__904:appendSafe(' (');
  t_171 = temper.listbuilder_tolist(colNames__899);
  fn__13890 = function(c__905)
    return c__905;
  end;
  b__904:appendSafe(temper.listed_join(t_171, ', ', fn__13890));
  b__904:appendSafe(') VALUES (');
  b__904:appendPart(temper.listed_get(valParts__900, 0));
  j__906 = 1;
  while true do
    t_167 = temper.listbuilder_length(valParts__900);
    if not (j__906 < t_167) then
      break;
    end
    b__904:appendSafe(', ');
    b__904:appendPart(temper.listed_get(valParts__900, j__906));
    j__906 = temper.int32_add(j__906, 1);
  end
  b__904:appendSafe(')');
  return b__904.accumulated;
end;
ChangesetImpl__234.methods.toUpdateSql = function(this__260, id__908)
  local t_172, t_173, t_174, t_175, t_176, pairs__910, b__911, i__912;
  if not this__260._isValid__740 then
    temper.bubble();
  end
  pairs__910 = temper.mapped_tolist(this__260._changes__738);
  if (temper.list_length(pairs__910) == 0) then
    temper.bubble();
  end
  b__911 = SqlBuilder();
  b__911:appendSafe('UPDATE ');
  b__911:appendSafe(this__260._tableDef__736.tableName.sqlValue);
  b__911:appendSafe(' SET ');
  i__912 = 0;
  while true do
    local pair__913, fd__914;
    t_172 = temper.list_length(pairs__910);
    if not (i__912 < t_172) then
      break;
    end
    if (i__912 > 0) then
      b__911:appendSafe(', ');
    end
    pair__913 = temper.list_get(pairs__910, i__912);
    t_173 = pair__913.key;
    t_175 = this__260._tableDef__736:field(t_173);
    fd__914 = t_175;
    b__911:appendSafe(fd__914.name.sqlValue);
    b__911:appendSafe(' = ');
    t_174 = pair__913.value;
    t_176 = this__260:valueToSqlPart(fd__914, t_174);
    b__911:appendPart(t_176);
    i__912 = temper.int32_add(i__912, 1);
  end
  b__911:appendSafe(' WHERE id = ');
  b__911:appendInt32(id__908);
  return b__911.accumulated;
end;
ChangesetImpl__234.constructor = function(this__395, _tableDef__916, _params__917, _changes__918, _errors__919, _isValid__920)
  this__395._tableDef__736 = _tableDef__916;
  this__395._params__737 = _params__917;
  this__395._changes__738 = _changes__918;
  this__395._errors__739 = _errors__919;
  this__395._isValid__740 = _isValid__920;
  return nil;
end;
JoinType = temper.type('JoinType');
JoinType.methods.keyword = function(this__261)
  temper.virtual();
end;
InnerJoin = temper.type('InnerJoin', JoinType);
InnerJoin.methods.keyword = function(this__262)
  return 'INNER JOIN';
end;
InnerJoin.constructor = function(this__431)
  return nil;
end;
LeftJoin = temper.type('LeftJoin', JoinType);
LeftJoin.methods.keyword = function(this__263)
  return 'LEFT JOIN';
end;
LeftJoin.constructor = function(this__434)
  return nil;
end;
RightJoin = temper.type('RightJoin', JoinType);
RightJoin.methods.keyword = function(this__264)
  return 'RIGHT JOIN';
end;
RightJoin.constructor = function(this__437)
  return nil;
end;
FullJoin = temper.type('FullJoin', JoinType);
FullJoin.methods.keyword = function(this__265)
  return 'FULL OUTER JOIN';
end;
FullJoin.constructor = function(this__440)
  return nil;
end;
CrossJoin = temper.type('CrossJoin', JoinType);
CrossJoin.methods.keyword = function(this__266)
  return 'CROSS JOIN';
end;
CrossJoin.constructor = function(this__443)
  return nil;
end;
JoinClause = temper.type('JoinClause');
JoinClause.constructor = function(this__446, joinType__1145, table__1146, onCondition__1147)
  if (onCondition__1147 == nil) then
    onCondition__1147 = temper.null;
  end
  this__446.joinType__1141 = joinType__1145;
  this__446.table__1142 = table__1146;
  this__446.onCondition__1143 = onCondition__1147;
  return nil;
end;
JoinClause.get.joinType = function(this__2067)
  return this__2067.joinType__1141;
end;
JoinClause.get.table = function(this__2070)
  return this__2070.table__1142;
end;
JoinClause.get.onCondition = function(this__2073)
  return this__2073.onCondition__1143;
end;
NullsPosition = temper.type('NullsPosition');
NullsPosition.methods.keyword = function(this__267)
  temper.virtual();
end;
NullsFirst = temper.type('NullsFirst', NullsPosition);
NullsFirst.methods.keyword = function(this__268)
  return ' NULLS FIRST';
end;
NullsFirst.constructor = function(this__450)
  return nil;
end;
NullsLast = temper.type('NullsLast', NullsPosition);
NullsLast.methods.keyword = function(this__269)
  return ' NULLS LAST';
end;
NullsLast.constructor = function(this__453)
  return nil;
end;
OrderClause = temper.type('OrderClause');
OrderClause.constructor = function(this__456, field__1160, ascending__1161, nullsPos__1162)
  if (nullsPos__1162 == nil) then
    nullsPos__1162 = temper.null;
  end
  this__456.field__1156 = field__1160;
  this__456.ascending__1157 = ascending__1161;
  this__456.nullsPos__1158 = nullsPos__1162;
  return nil;
end;
OrderClause.get.field = function(this__2076)
  return this__2076.field__1156;
end;
OrderClause.get.ascending = function(this__2079)
  return this__2079.ascending__1157;
end;
OrderClause.get.nullsPos = function(this__2082)
  return this__2082.nullsPos__1158;
end;
LockMode = temper.type('LockMode');
LockMode.methods.keyword = function(this__270)
  temper.virtual();
end;
ForUpdate = temper.type('ForUpdate', LockMode);
ForUpdate.methods.keyword = function(this__271)
  return ' FOR UPDATE';
end;
ForUpdate.constructor = function(this__460)
  return nil;
end;
ForShare = temper.type('ForShare', LockMode);
ForShare.methods.keyword = function(this__272)
  return ' FOR SHARE';
end;
ForShare.constructor = function(this__463)
  return nil;
end;
WhereClause = temper.type('WhereClause');
WhereClause.get.condition = function(this__273)
  temper.virtual();
end;
WhereClause.methods.keyword = function(this__274)
  temper.virtual();
end;
AndCondition = temper.type('AndCondition', WhereClause);
AndCondition.get.condition = function(this__275)
  return this__275._condition__1175;
end;
AndCondition.methods.keyword = function(this__276)
  return 'AND';
end;
AndCondition.constructor = function(this__470, _condition__1181)
  this__470._condition__1175 = _condition__1181;
  return nil;
end;
OrCondition = temper.type('OrCondition', WhereClause);
OrCondition.get.condition = function(this__277)
  return this__277._condition__1182;
end;
OrCondition.methods.keyword = function(this__278)
  return 'OR';
end;
OrCondition.constructor = function(this__475, _condition__1188)
  this__475._condition__1182 = _condition__1188;
  return nil;
end;
Query = temper.type('Query');
Query.methods.where = function(this__279, condition__1202)
  local nb__1204;
  nb__1204 = temper.list_tolistbuilder(this__279.conditions__1190);
  temper.listbuilder_add(nb__1204, AndCondition(condition__1202));
  return Query(this__279.tableName__1189, temper.listbuilder_tolist(nb__1204), this__279.selectedFields__1191, this__279.orderClauses__1192, this__279.limitVal__1193, this__279.offsetVal__1194, this__279.joinClauses__1195, this__279.groupByFields__1196, this__279.havingConditions__1197, this__279.isDistinct__1198, this__279.selectExprs__1199, this__279.lockMode__1200);
end;
Query.methods.orWhere = function(this__280, condition__1206)
  local nb__1208;
  nb__1208 = temper.list_tolistbuilder(this__280.conditions__1190);
  temper.listbuilder_add(nb__1208, OrCondition(condition__1206));
  return Query(this__280.tableName__1189, temper.listbuilder_tolist(nb__1208), this__280.selectedFields__1191, this__280.orderClauses__1192, this__280.limitVal__1193, this__280.offsetVal__1194, this__280.joinClauses__1195, this__280.groupByFields__1196, this__280.havingConditions__1197, this__280.isDistinct__1198, this__280.selectExprs__1199, this__280.lockMode__1200);
end;
Query.methods.whereNull = function(this__281, field__1210)
  local b__1212, t_177;
  b__1212 = SqlBuilder();
  b__1212:appendSafe(field__1210.sqlValue);
  b__1212:appendSafe(' IS NULL');
  t_177 = b__1212.accumulated;
  return this__281:where(t_177);
end;
Query.methods.whereNotNull = function(this__282, field__1214)
  local b__1216, t_178;
  b__1216 = SqlBuilder();
  b__1216:appendSafe(field__1214.sqlValue);
  b__1216:appendSafe(' IS NOT NULL');
  t_178 = b__1216.accumulated;
  return this__282:where(t_178);
end;
Query.methods.whereIn = function(this__283, field__1218, values__1219)
  local return__495, t_179, t_180, t_181, b__1222, i__1223;
  ::continue_33::
  if temper.listed_isempty(values__1219) then
    local b__1221;
    b__1221 = SqlBuilder();
    b__1221:appendSafe('1 = 0');
    t_179 = b__1221.accumulated;
    return__495 = this__283:where(t_179);
    goto break_32;
  end
  b__1222 = SqlBuilder();
  b__1222:appendSafe(field__1218.sqlValue);
  b__1222:appendSafe(' IN (');
  b__1222:appendPart(temper.list_get(values__1219, 0));
  i__1223 = 1;
  while true do
    t_180 = temper.list_length(values__1219);
    if not (i__1223 < t_180) then
      break;
    end
    b__1222:appendSafe(', ');
    b__1222:appendPart(temper.list_get(values__1219, i__1223));
    i__1223 = temper.int32_add(i__1223, 1);
  end
  b__1222:appendSafe(')');
  t_181 = b__1222.accumulated;
  return__495 = this__283:where(t_181);
  ::break_32::return return__495;
end;
Query.methods.whereInSubquery = function(this__284, field__1225, sub__1226)
  local b__1228, t_182;
  b__1228 = SqlBuilder();
  b__1228:appendSafe(field__1225.sqlValue);
  b__1228:appendSafe(' IN (');
  b__1228:appendFragment(sub__1226:toSql());
  b__1228:appendSafe(')');
  t_182 = b__1228.accumulated;
  return this__284:where(t_182);
end;
Query.methods.whereNot = function(this__285, condition__1230)
  local b__1232, t_183;
  b__1232 = SqlBuilder();
  b__1232:appendSafe('NOT (');
  b__1232:appendFragment(condition__1230);
  b__1232:appendSafe(')');
  t_183 = b__1232.accumulated;
  return this__285:where(t_183);
end;
Query.methods.whereBetween = function(this__286, field__1234, low__1235, high__1236)
  local b__1238, t_184;
  b__1238 = SqlBuilder();
  b__1238:appendSafe(field__1234.sqlValue);
  b__1238:appendSafe(' BETWEEN ');
  b__1238:appendPart(low__1235);
  b__1238:appendSafe(' AND ');
  b__1238:appendPart(high__1236);
  t_184 = b__1238.accumulated;
  return this__286:where(t_184);
end;
Query.methods.whereLike = function(this__287, field__1240, pattern__1241)
  local b__1243, t_185;
  b__1243 = SqlBuilder();
  b__1243:appendSafe(field__1240.sqlValue);
  b__1243:appendSafe(' LIKE ');
  b__1243:appendString(pattern__1241);
  t_185 = b__1243.accumulated;
  return this__287:where(t_185);
end;
Query.methods.whereILike = function(this__288, field__1245, pattern__1246)
  local b__1248, t_186;
  b__1248 = SqlBuilder();
  b__1248:appendSafe(field__1245.sqlValue);
  b__1248:appendSafe(' ILIKE ');
  b__1248:appendString(pattern__1246);
  t_186 = b__1248.accumulated;
  return this__288:where(t_186);
end;
Query.methods.select = function(this__289, fields__1250)
  return Query(this__289.tableName__1189, this__289.conditions__1190, fields__1250, this__289.orderClauses__1192, this__289.limitVal__1193, this__289.offsetVal__1194, this__289.joinClauses__1195, this__289.groupByFields__1196, this__289.havingConditions__1197, this__289.isDistinct__1198, this__289.selectExprs__1199, this__289.lockMode__1200);
end;
Query.methods.selectExpr = function(this__290, exprs__1253)
  return Query(this__290.tableName__1189, this__290.conditions__1190, this__290.selectedFields__1191, this__290.orderClauses__1192, this__290.limitVal__1193, this__290.offsetVal__1194, this__290.joinClauses__1195, this__290.groupByFields__1196, this__290.havingConditions__1197, this__290.isDistinct__1198, exprs__1253, this__290.lockMode__1200);
end;
Query.methods.orderBy = function(this__291, field__1256, ascending__1257)
  local nb__1259;
  nb__1259 = temper.list_tolistbuilder(this__291.orderClauses__1192);
  temper.listbuilder_add(nb__1259, OrderClause(field__1256, ascending__1257, temper.null));
  return Query(this__291.tableName__1189, this__291.conditions__1190, this__291.selectedFields__1191, temper.listbuilder_tolist(nb__1259), this__291.limitVal__1193, this__291.offsetVal__1194, this__291.joinClauses__1195, this__291.groupByFields__1196, this__291.havingConditions__1197, this__291.isDistinct__1198, this__291.selectExprs__1199, this__291.lockMode__1200);
end;
Query.methods.orderByNulls = function(this__292, field__1261, ascending__1262, nulls__1263)
  local nb__1265;
  nb__1265 = temper.list_tolistbuilder(this__292.orderClauses__1192);
  temper.listbuilder_add(nb__1265, OrderClause(field__1261, ascending__1262, nulls__1263));
  return Query(this__292.tableName__1189, this__292.conditions__1190, this__292.selectedFields__1191, temper.listbuilder_tolist(nb__1265), this__292.limitVal__1193, this__292.offsetVal__1194, this__292.joinClauses__1195, this__292.groupByFields__1196, this__292.havingConditions__1197, this__292.isDistinct__1198, this__292.selectExprs__1199, this__292.lockMode__1200);
end;
Query.methods.limit = function(this__293, n__1267)
  if (n__1267 < 0) then
    temper.bubble();
  end
  return Query(this__293.tableName__1189, this__293.conditions__1190, this__293.selectedFields__1191, this__293.orderClauses__1192, n__1267, this__293.offsetVal__1194, this__293.joinClauses__1195, this__293.groupByFields__1196, this__293.havingConditions__1197, this__293.isDistinct__1198, this__293.selectExprs__1199, this__293.lockMode__1200);
end;
Query.methods.offset = function(this__294, n__1270)
  if (n__1270 < 0) then
    temper.bubble();
  end
  return Query(this__294.tableName__1189, this__294.conditions__1190, this__294.selectedFields__1191, this__294.orderClauses__1192, this__294.limitVal__1193, n__1270, this__294.joinClauses__1195, this__294.groupByFields__1196, this__294.havingConditions__1197, this__294.isDistinct__1198, this__294.selectExprs__1199, this__294.lockMode__1200);
end;
Query.methods.join = function(this__295, joinType__1273, table__1274, onCondition__1275)
  local nb__1277;
  nb__1277 = temper.list_tolistbuilder(this__295.joinClauses__1195);
  temper.listbuilder_add(nb__1277, JoinClause(joinType__1273, table__1274, onCondition__1275));
  return Query(this__295.tableName__1189, this__295.conditions__1190, this__295.selectedFields__1191, this__295.orderClauses__1192, this__295.limitVal__1193, this__295.offsetVal__1194, temper.listbuilder_tolist(nb__1277), this__295.groupByFields__1196, this__295.havingConditions__1197, this__295.isDistinct__1198, this__295.selectExprs__1199, this__295.lockMode__1200);
end;
Query.methods.innerJoin = function(this__296, table__1279, onCondition__1280)
  local t_187;
  t_187 = InnerJoin();
  return this__296:join(t_187, table__1279, onCondition__1280);
end;
Query.methods.leftJoin = function(this__297, table__1283, onCondition__1284)
  local t_188;
  t_188 = LeftJoin();
  return this__297:join(t_188, table__1283, onCondition__1284);
end;
Query.methods.rightJoin = function(this__298, table__1287, onCondition__1288)
  local t_189;
  t_189 = RightJoin();
  return this__298:join(t_189, table__1287, onCondition__1288);
end;
Query.methods.fullJoin = function(this__299, table__1291, onCondition__1292)
  local t_190;
  t_190 = FullJoin();
  return this__299:join(t_190, table__1291, onCondition__1292);
end;
Query.methods.crossJoin = function(this__300, table__1295)
  local nb__1297;
  nb__1297 = temper.list_tolistbuilder(this__300.joinClauses__1195);
  temper.listbuilder_add(nb__1297, JoinClause(CrossJoin(), table__1295, temper.null));
  return Query(this__300.tableName__1189, this__300.conditions__1190, this__300.selectedFields__1191, this__300.orderClauses__1192, this__300.limitVal__1193, this__300.offsetVal__1194, temper.listbuilder_tolist(nb__1297), this__300.groupByFields__1196, this__300.havingConditions__1197, this__300.isDistinct__1198, this__300.selectExprs__1199, this__300.lockMode__1200);
end;
Query.methods.groupBy = function(this__301, field__1299)
  local nb__1301;
  nb__1301 = temper.list_tolistbuilder(this__301.groupByFields__1196);
  temper.listbuilder_add(nb__1301, field__1299);
  return Query(this__301.tableName__1189, this__301.conditions__1190, this__301.selectedFields__1191, this__301.orderClauses__1192, this__301.limitVal__1193, this__301.offsetVal__1194, this__301.joinClauses__1195, temper.listbuilder_tolist(nb__1301), this__301.havingConditions__1197, this__301.isDistinct__1198, this__301.selectExprs__1199, this__301.lockMode__1200);
end;
Query.methods.having = function(this__302, condition__1303)
  local nb__1305;
  nb__1305 = temper.list_tolistbuilder(this__302.havingConditions__1197);
  temper.listbuilder_add(nb__1305, AndCondition(condition__1303));
  return Query(this__302.tableName__1189, this__302.conditions__1190, this__302.selectedFields__1191, this__302.orderClauses__1192, this__302.limitVal__1193, this__302.offsetVal__1194, this__302.joinClauses__1195, this__302.groupByFields__1196, temper.listbuilder_tolist(nb__1305), this__302.isDistinct__1198, this__302.selectExprs__1199, this__302.lockMode__1200);
end;
Query.methods.orHaving = function(this__303, condition__1307)
  local nb__1309;
  nb__1309 = temper.list_tolistbuilder(this__303.havingConditions__1197);
  temper.listbuilder_add(nb__1309, OrCondition(condition__1307));
  return Query(this__303.tableName__1189, this__303.conditions__1190, this__303.selectedFields__1191, this__303.orderClauses__1192, this__303.limitVal__1193, this__303.offsetVal__1194, this__303.joinClauses__1195, this__303.groupByFields__1196, temper.listbuilder_tolist(nb__1309), this__303.isDistinct__1198, this__303.selectExprs__1199, this__303.lockMode__1200);
end;
Query.methods.distinct = function(this__304)
  return Query(this__304.tableName__1189, this__304.conditions__1190, this__304.selectedFields__1191, this__304.orderClauses__1192, this__304.limitVal__1193, this__304.offsetVal__1194, this__304.joinClauses__1195, this__304.groupByFields__1196, this__304.havingConditions__1197, true, this__304.selectExprs__1199, this__304.lockMode__1200);
end;
Query.methods.lock = function(this__305, mode__1313)
  return Query(this__305.tableName__1189, this__305.conditions__1190, this__305.selectedFields__1191, this__305.orderClauses__1192, this__305.limitVal__1193, this__305.offsetVal__1194, this__305.joinClauses__1195, this__305.groupByFields__1196, this__305.havingConditions__1197, this__305.isDistinct__1198, this__305.selectExprs__1199, mode__1313);
end;
Query.methods.toSql = function(this__306)
  local t_191, t_192, t_193, b__1317, fn__12775, lv__1328, ov__1329, lm__1330;
  b__1317 = SqlBuilder();
  if this__306.isDistinct__1198 then
    b__1317:appendSafe('SELECT DISTINCT ');
  else
    b__1317:appendSafe('SELECT ');
  end
  if not temper.listed_isempty(this__306.selectExprs__1199) then
    local i__1318;
    b__1317:appendFragment(temper.list_get(this__306.selectExprs__1199, 0));
    i__1318 = 1;
    while true do
      t_191 = temper.list_length(this__306.selectExprs__1199);
      if not (i__1318 < t_191) then
        break;
      end
      b__1317:appendSafe(', ');
      b__1317:appendFragment(temper.list_get(this__306.selectExprs__1199, i__1318));
      i__1318 = temper.int32_add(i__1318, 1);
    end
  elseif temper.listed_isempty(this__306.selectedFields__1191) then
    b__1317:appendSafe('*');
  else
    local fn__12776;
    fn__12776 = function(f__1319)
      return f__1319.sqlValue;
    end;
    b__1317:appendSafe(temper.listed_join(this__306.selectedFields__1191, ', ', fn__12776));
  end
  b__1317:appendSafe(' FROM ');
  b__1317:appendSafe(this__306.tableName__1189.sqlValue);
  fn__12775 = function(jc__1320)
    local t_194, t_195, oc__1321;
    b__1317:appendSafe(' ');
    t_194 = jc__1320.joinType:keyword();
    b__1317:appendSafe(t_194);
    b__1317:appendSafe(' ');
    t_195 = jc__1320.table.sqlValue;
    b__1317:appendSafe(t_195);
    oc__1321 = jc__1320.onCondition;
    if not temper.is_null(oc__1321) then
      local oc_196;
      oc_196 = oc__1321;
      b__1317:appendSafe(' ON ');
      b__1317:appendFragment(oc_196);
    end
    return nil;
  end;
  temper.list_foreach(this__306.joinClauses__1195, fn__12775);
  if not temper.listed_isempty(this__306.conditions__1190) then
    local i__1322;
    b__1317:appendSafe(' WHERE ');
    b__1317:appendFragment((temper.list_get(this__306.conditions__1190, 0)).condition);
    i__1322 = 1;
    while true do
      t_192 = temper.list_length(this__306.conditions__1190);
      if not (i__1322 < t_192) then
        break;
      end
      b__1317:appendSafe(' ');
      b__1317:appendSafe(temper.list_get(this__306.conditions__1190, i__1322):keyword());
      b__1317:appendSafe(' ');
      b__1317:appendFragment((temper.list_get(this__306.conditions__1190, i__1322)).condition);
      i__1322 = temper.int32_add(i__1322, 1);
    end
  end
  if not temper.listed_isempty(this__306.groupByFields__1196) then
    local fn__12774;
    b__1317:appendSafe(' GROUP BY ');
    fn__12774 = function(f__1323)
      return f__1323.sqlValue;
    end;
    b__1317:appendSafe(temper.listed_join(this__306.groupByFields__1196, ', ', fn__12774));
  end
  if not temper.listed_isempty(this__306.havingConditions__1197) then
    local i__1324;
    b__1317:appendSafe(' HAVING ');
    b__1317:appendFragment((temper.list_get(this__306.havingConditions__1197, 0)).condition);
    i__1324 = 1;
    while true do
      t_193 = temper.list_length(this__306.havingConditions__1197);
      if not (i__1324 < t_193) then
        break;
      end
      b__1317:appendSafe(' ');
      b__1317:appendSafe(temper.list_get(this__306.havingConditions__1197, i__1324):keyword());
      b__1317:appendSafe(' ');
      b__1317:appendFragment((temper.list_get(this__306.havingConditions__1197, i__1324)).condition);
      i__1324 = temper.int32_add(i__1324, 1);
    end
  end
  if not temper.listed_isempty(this__306.orderClauses__1192) then
    local first__1325, fn__12773;
    b__1317:appendSafe(' ORDER BY ');
    first__1325 = true;
    fn__12773 = function(orc__1326)
      local t_197, t_198, t_199, np__1327;
      if not first__1325 then
        b__1317:appendSafe(', ');
      end
      first__1325 = false;
      t_199 = orc__1326.field.sqlValue;
      b__1317:appendSafe(t_199);
      if orc__1326.ascending then
        t_198 = ' ASC';
      else
        t_198 = ' DESC';
      end
      b__1317:appendSafe(t_198);
      np__1327 = orc__1326.nullsPos;
      if not temper.is_null(np__1327) then
        t_197 = np__1327:keyword();
        b__1317:appendSafe(t_197);
      end
      return nil;
    end;
    temper.list_foreach(this__306.orderClauses__1192, fn__12773);
  end
  lv__1328 = this__306.limitVal__1193;
  if not temper.is_null(lv__1328) then
    local lv_200;
    lv_200 = lv__1328;
    b__1317:appendSafe(' LIMIT ');
    b__1317:appendInt32(lv_200);
  end
  ov__1329 = this__306.offsetVal__1194;
  if not temper.is_null(ov__1329) then
    local ov_201;
    ov_201 = ov__1329;
    b__1317:appendSafe(' OFFSET ');
    b__1317:appendInt32(ov_201);
  end
  lm__1330 = this__306.lockMode__1200;
  if not temper.is_null(lm__1330) then
    b__1317:appendSafe(lm__1330:keyword());
  end
  return b__1317.accumulated;
end;
Query.methods.countSql = function(this__307)
  local t_202, t_203, b__1333, fn__12710;
  b__1333 = SqlBuilder();
  b__1333:appendSafe('SELECT COUNT(*) FROM ');
  b__1333:appendSafe(this__307.tableName__1189.sqlValue);
  fn__12710 = function(jc__1334)
    local t_204, t_205, oc2__1335;
    b__1333:appendSafe(' ');
    t_204 = jc__1334.joinType:keyword();
    b__1333:appendSafe(t_204);
    b__1333:appendSafe(' ');
    t_205 = jc__1334.table.sqlValue;
    b__1333:appendSafe(t_205);
    oc2__1335 = jc__1334.onCondition;
    if not temper.is_null(oc2__1335) then
      local oc2_206;
      oc2_206 = oc2__1335;
      b__1333:appendSafe(' ON ');
      b__1333:appendFragment(oc2_206);
    end
    return nil;
  end;
  temper.list_foreach(this__307.joinClauses__1195, fn__12710);
  if not temper.listed_isempty(this__307.conditions__1190) then
    local i__1336;
    b__1333:appendSafe(' WHERE ');
    b__1333:appendFragment((temper.list_get(this__307.conditions__1190, 0)).condition);
    i__1336 = 1;
    while true do
      t_202 = temper.list_length(this__307.conditions__1190);
      if not (i__1336 < t_202) then
        break;
      end
      b__1333:appendSafe(' ');
      b__1333:appendSafe(temper.list_get(this__307.conditions__1190, i__1336):keyword());
      b__1333:appendSafe(' ');
      b__1333:appendFragment((temper.list_get(this__307.conditions__1190, i__1336)).condition);
      i__1336 = temper.int32_add(i__1336, 1);
    end
  end
  if not temper.listed_isempty(this__307.groupByFields__1196) then
    local fn__12709;
    b__1333:appendSafe(' GROUP BY ');
    fn__12709 = function(f__1337)
      return f__1337.sqlValue;
    end;
    b__1333:appendSafe(temper.listed_join(this__307.groupByFields__1196, ', ', fn__12709));
  end
  if not temper.listed_isempty(this__307.havingConditions__1197) then
    local i__1338;
    b__1333:appendSafe(' HAVING ');
    b__1333:appendFragment((temper.list_get(this__307.havingConditions__1197, 0)).condition);
    i__1338 = 1;
    while true do
      t_203 = temper.list_length(this__307.havingConditions__1197);
      if not (i__1338 < t_203) then
        break;
      end
      b__1333:appendSafe(' ');
      b__1333:appendSafe(temper.list_get(this__307.havingConditions__1197, i__1338):keyword());
      b__1333:appendSafe(' ');
      b__1333:appendFragment((temper.list_get(this__307.havingConditions__1197, i__1338)).condition);
      i__1338 = temper.int32_add(i__1338, 1);
    end
  end
  return b__1333.accumulated;
end;
Query.methods.safeToSql = function(this__308, defaultLimit__1340)
  local return__520, t_207;
  if (defaultLimit__1340 < 0) then
    temper.bubble();
  end
  if not temper.is_null(this__308.limitVal__1193) then
    return__520 = this__308:toSql();
  else
    t_207 = this__308:limit(defaultLimit__1340);
    return__520 = t_207:toSql();
  end
  return return__520;
end;
Query.constructor = function(this__479, tableName__1343, conditions__1344, selectedFields__1345, orderClauses__1346, limitVal__1347, offsetVal__1348, joinClauses__1349, groupByFields__1350, havingConditions__1351, isDistinct__1352, selectExprs__1353, lockMode__1354)
  if (limitVal__1347 == nil) then
    limitVal__1347 = temper.null;
  end
  if (offsetVal__1348 == nil) then
    offsetVal__1348 = temper.null;
  end
  if (lockMode__1354 == nil) then
    lockMode__1354 = temper.null;
  end
  this__479.tableName__1189 = tableName__1343;
  this__479.conditions__1190 = conditions__1344;
  this__479.selectedFields__1191 = selectedFields__1345;
  this__479.orderClauses__1192 = orderClauses__1346;
  this__479.limitVal__1193 = limitVal__1347;
  this__479.offsetVal__1194 = offsetVal__1348;
  this__479.joinClauses__1195 = joinClauses__1349;
  this__479.groupByFields__1196 = groupByFields__1350;
  this__479.havingConditions__1197 = havingConditions__1351;
  this__479.isDistinct__1198 = isDistinct__1352;
  this__479.selectExprs__1199 = selectExprs__1353;
  this__479.lockMode__1200 = lockMode__1354;
  return nil;
end;
Query.get.tableName = function(this__2085)
  return this__2085.tableName__1189;
end;
Query.get.conditions = function(this__2088)
  return this__2088.conditions__1190;
end;
Query.get.selectedFields = function(this__2091)
  return this__2091.selectedFields__1191;
end;
Query.get.orderClauses = function(this__2094)
  return this__2094.orderClauses__1192;
end;
Query.get.limitVal = function(this__2097)
  return this__2097.limitVal__1193;
end;
Query.get.offsetVal = function(this__2100)
  return this__2100.offsetVal__1194;
end;
Query.get.joinClauses = function(this__2103)
  return this__2103.joinClauses__1195;
end;
Query.get.groupByFields = function(this__2106)
  return this__2106.groupByFields__1196;
end;
Query.get.havingConditions = function(this__2109)
  return this__2109.havingConditions__1197;
end;
Query.get.isDistinct = function(this__2112)
  return this__2112.isDistinct__1198;
end;
Query.get.selectExprs = function(this__2115)
  return this__2115.selectExprs__1199;
end;
Query.get.lockMode = function(this__2118)
  return this__2118.lockMode__1200;
end;
SetClause = temper.type('SetClause');
SetClause.constructor = function(this__535, field__1404, value__1405)
  this__535.field__1401 = field__1404;
  this__535.value__1402 = value__1405;
  return nil;
end;
SetClause.get.field = function(this__2121)
  return this__2121.field__1401;
end;
SetClause.get.value = function(this__2124)
  return this__2124.value__1402;
end;
UpdateQuery = temper.type('UpdateQuery');
UpdateQuery.methods.set = function(this__309, field__1411, value__1412)
  local nb__1414;
  nb__1414 = temper.list_tolistbuilder(this__309.setClauses__1407);
  temper.listbuilder_add(nb__1414, SetClause(field__1411, value__1412));
  return UpdateQuery(this__309.tableName__1406, temper.listbuilder_tolist(nb__1414), this__309.conditions__1408, this__309.limitVal__1409);
end;
UpdateQuery.methods.where = function(this__310, condition__1416)
  local nb__1418;
  nb__1418 = temper.list_tolistbuilder(this__310.conditions__1408);
  temper.listbuilder_add(nb__1418, AndCondition(condition__1416));
  return UpdateQuery(this__310.tableName__1406, this__310.setClauses__1407, temper.listbuilder_tolist(nb__1418), this__310.limitVal__1409);
end;
UpdateQuery.methods.orWhere = function(this__311, condition__1420)
  local nb__1422;
  nb__1422 = temper.list_tolistbuilder(this__311.conditions__1408);
  temper.listbuilder_add(nb__1422, OrCondition(condition__1420));
  return UpdateQuery(this__311.tableName__1406, this__311.setClauses__1407, temper.listbuilder_tolist(nb__1422), this__311.limitVal__1409);
end;
UpdateQuery.methods.limit = function(this__312, n__1424)
  if (n__1424 < 0) then
    temper.bubble();
  end
  return UpdateQuery(this__312.tableName__1406, this__312.setClauses__1407, this__312.conditions__1408, n__1424);
end;
UpdateQuery.methods.toSql = function(this__313)
  local t_208, t_209, b__1428, i__1429, i__1430, lv__1431;
  if temper.listed_isempty(this__313.conditions__1408) then
    temper.bubble();
  end
  if temper.listed_isempty(this__313.setClauses__1407) then
    temper.bubble();
  end
  b__1428 = SqlBuilder();
  b__1428:appendSafe('UPDATE ');
  b__1428:appendSafe(this__313.tableName__1406.sqlValue);
  b__1428:appendSafe(' SET ');
  b__1428:appendSafe((temper.list_get(this__313.setClauses__1407, 0)).field.sqlValue);
  b__1428:appendSafe(' = ');
  b__1428:appendPart((temper.list_get(this__313.setClauses__1407, 0)).value);
  i__1429 = 1;
  while true do
    t_208 = temper.list_length(this__313.setClauses__1407);
    if not (i__1429 < t_208) then
      break;
    end
    b__1428:appendSafe(', ');
    b__1428:appendSafe((temper.list_get(this__313.setClauses__1407, i__1429)).field.sqlValue);
    b__1428:appendSafe(' = ');
    b__1428:appendPart((temper.list_get(this__313.setClauses__1407, i__1429)).value);
    i__1429 = temper.int32_add(i__1429, 1);
  end
  b__1428:appendSafe(' WHERE ');
  b__1428:appendFragment((temper.list_get(this__313.conditions__1408, 0)).condition);
  i__1430 = 1;
  while true do
    t_209 = temper.list_length(this__313.conditions__1408);
    if not (i__1430 < t_209) then
      break;
    end
    b__1428:appendSafe(' ');
    b__1428:appendSafe(temper.list_get(this__313.conditions__1408, i__1430):keyword());
    b__1428:appendSafe(' ');
    b__1428:appendFragment((temper.list_get(this__313.conditions__1408, i__1430)).condition);
    i__1430 = temper.int32_add(i__1430, 1);
  end
  lv__1431 = this__313.limitVal__1409;
  if not temper.is_null(lv__1431) then
    local lv_210;
    lv_210 = lv__1431;
    b__1428:appendSafe(' LIMIT ');
    b__1428:appendInt32(lv_210);
  end
  return b__1428.accumulated;
end;
UpdateQuery.constructor = function(this__537, tableName__1433, setClauses__1434, conditions__1435, limitVal__1436)
  if (limitVal__1436 == nil) then
    limitVal__1436 = temper.null;
  end
  this__537.tableName__1406 = tableName__1433;
  this__537.setClauses__1407 = setClauses__1434;
  this__537.conditions__1408 = conditions__1435;
  this__537.limitVal__1409 = limitVal__1436;
  return nil;
end;
UpdateQuery.get.tableName = function(this__2127)
  return this__2127.tableName__1406;
end;
UpdateQuery.get.setClauses = function(this__2130)
  return this__2130.setClauses__1407;
end;
UpdateQuery.get.conditions = function(this__2133)
  return this__2133.conditions__1408;
end;
UpdateQuery.get.limitVal = function(this__2136)
  return this__2136.limitVal__1409;
end;
DeleteQuery = temper.type('DeleteQuery');
DeleteQuery.methods.where = function(this__314, condition__1441)
  local nb__1443;
  nb__1443 = temper.list_tolistbuilder(this__314.conditions__1438);
  temper.listbuilder_add(nb__1443, AndCondition(condition__1441));
  return DeleteQuery(this__314.tableName__1437, temper.listbuilder_tolist(nb__1443), this__314.limitVal__1439);
end;
DeleteQuery.methods.orWhere = function(this__315, condition__1445)
  local nb__1447;
  nb__1447 = temper.list_tolistbuilder(this__315.conditions__1438);
  temper.listbuilder_add(nb__1447, OrCondition(condition__1445));
  return DeleteQuery(this__315.tableName__1437, temper.listbuilder_tolist(nb__1447), this__315.limitVal__1439);
end;
DeleteQuery.methods.limit = function(this__316, n__1449)
  if (n__1449 < 0) then
    temper.bubble();
  end
  return DeleteQuery(this__316.tableName__1437, this__316.conditions__1438, n__1449);
end;
DeleteQuery.methods.toSql = function(this__317)
  local t_211, b__1453, i__1454, lv__1455;
  if temper.listed_isempty(this__317.conditions__1438) then
    temper.bubble();
  end
  b__1453 = SqlBuilder();
  b__1453:appendSafe('DELETE FROM ');
  b__1453:appendSafe(this__317.tableName__1437.sqlValue);
  b__1453:appendSafe(' WHERE ');
  b__1453:appendFragment((temper.list_get(this__317.conditions__1438, 0)).condition);
  i__1454 = 1;
  while true do
    t_211 = temper.list_length(this__317.conditions__1438);
    if not (i__1454 < t_211) then
      break;
    end
    b__1453:appendSafe(' ');
    b__1453:appendSafe(temper.list_get(this__317.conditions__1438, i__1454):keyword());
    b__1453:appendSafe(' ');
    b__1453:appendFragment((temper.list_get(this__317.conditions__1438, i__1454)).condition);
    i__1454 = temper.int32_add(i__1454, 1);
  end
  lv__1455 = this__317.limitVal__1439;
  if not temper.is_null(lv__1455) then
    local lv_212;
    lv_212 = lv__1455;
    b__1453:appendSafe(' LIMIT ');
    b__1453:appendInt32(lv_212);
  end
  return b__1453.accumulated;
end;
DeleteQuery.constructor = function(this__547, tableName__1457, conditions__1458, limitVal__1459)
  if (limitVal__1459 == nil) then
    limitVal__1459 = temper.null;
  end
  this__547.tableName__1437 = tableName__1457;
  this__547.conditions__1438 = conditions__1458;
  this__547.limitVal__1439 = limitVal__1459;
  return nil;
end;
DeleteQuery.get.tableName = function(this__2139)
  return this__2139.tableName__1437;
end;
DeleteQuery.get.conditions = function(this__2142)
  return this__2142.conditions__1438;
end;
DeleteQuery.get.limitVal = function(this__2145)
  return this__2145.limitVal__1439;
end;
SafeIdentifier = temper.type('SafeIdentifier');
SafeIdentifier.get.sqlValue = function(this__318)
  temper.virtual();
end;
ValidatedIdentifier__319 = temper.type('ValidatedIdentifier__319', SafeIdentifier);
ValidatedIdentifier__319.get.sqlValue = function(this__320)
  return this__320._value__1690;
end;
ValidatedIdentifier__319.constructor = function(this__561, _value__1694)
  this__561._value__1690 = _value__1694;
  return nil;
end;
FieldType = temper.type('FieldType');
StringField = temper.type('StringField', FieldType);
StringField.constructor = function(this__567)
  return nil;
end;
IntField = temper.type('IntField', FieldType);
IntField.constructor = function(this__569)
  return nil;
end;
Int64Field = temper.type('Int64Field', FieldType);
Int64Field.constructor = function(this__571)
  return nil;
end;
FloatField = temper.type('FloatField', FieldType);
FloatField.constructor = function(this__573)
  return nil;
end;
BoolField = temper.type('BoolField', FieldType);
BoolField.constructor = function(this__575)
  return nil;
end;
DateField = temper.type('DateField', FieldType);
DateField.constructor = function(this__577)
  return nil;
end;
FieldDef = temper.type('FieldDef');
FieldDef.constructor = function(this__579, name__1712, fieldType__1713, nullable__1714)
  this__579.name__1708 = name__1712;
  this__579.fieldType__1709 = fieldType__1713;
  this__579.nullable__1710 = nullable__1714;
  return nil;
end;
FieldDef.get.name = function(this__1971)
  return this__1971.name__1708;
end;
FieldDef.get.fieldType = function(this__1974)
  return this__1974.fieldType__1709;
end;
FieldDef.get.nullable = function(this__1977)
  return this__1977.nullable__1710;
end;
TableDef = temper.type('TableDef');
TableDef.methods.field = function(this__321, name__1718)
  local return__584, this__8420, n__8421, i__8422;
  ::continue_35::this__8420 = this__321.fields__1716;
  n__8421 = temper.list_length(this__8420);
  i__8422 = 0;
  while (i__8422 < n__8421) do
    local el__8423, f__1720;
    el__8423 = temper.list_get(this__8420, i__8422);
    i__8422 = temper.int32_add(i__8422, 1);
    f__1720 = el__8423;
    if temper.str_eq(f__1720.name.sqlValue, name__1718) then
      return__584 = f__1720;
      goto break_34;
    end
  end
  temper.bubble();
  ::break_34::return return__584;
end;
TableDef.constructor = function(this__581, tableName__1722, fields__1723)
  this__581.tableName__1715 = tableName__1722;
  this__581.fields__1716 = fields__1723;
  return nil;
end;
TableDef.get.tableName = function(this__1980)
  return this__1980.tableName__1715;
end;
TableDef.get.fields = function(this__1983)
  return this__1983.fields__1716;
end;
SqlBuilder = temper.type('SqlBuilder');
SqlBuilder.methods.appendSafe = function(this__322, sqlSource__1745)
  local t_213;
  t_213 = SqlSource(sqlSource__1745);
  temper.listbuilder_add(this__322.buffer__1743, t_213);
  return nil;
end;
SqlBuilder.methods.appendFragment = function(this__323, fragment__1748)
  local t_214;
  t_214 = fragment__1748.parts;
  temper.listbuilder_addall(this__323.buffer__1743, t_214);
  return nil;
end;
SqlBuilder.methods.appendPart = function(this__324, part__1751)
  temper.listbuilder_add(this__324.buffer__1743, part__1751);
  return nil;
end;
SqlBuilder.methods.appendPartList = function(this__325, values__1754)
  local fn__14245;
  fn__14245 = function(x__1756)
    this__325:appendPart(x__1756);
    return nil;
  end;
  this__325:appendList(values__1754, fn__14245);
  return nil;
end;
SqlBuilder.methods.appendBoolean = function(this__326, value__1758)
  local t_215;
  t_215 = SqlBoolean(value__1758);
  temper.listbuilder_add(this__326.buffer__1743, t_215);
  return nil;
end;
SqlBuilder.methods.appendBooleanList = function(this__327, values__1761)
  local fn__14239;
  fn__14239 = function(x__1763)
    this__327:appendBoolean(x__1763);
    return nil;
  end;
  this__327:appendList(values__1761, fn__14239);
  return nil;
end;
SqlBuilder.methods.appendDate = function(this__328, value__1765)
  local t_216;
  t_216 = SqlDate(value__1765);
  temper.listbuilder_add(this__328.buffer__1743, t_216);
  return nil;
end;
SqlBuilder.methods.appendDateList = function(this__329, values__1768)
  local fn__14233;
  fn__14233 = function(x__1770)
    this__329:appendDate(x__1770);
    return nil;
  end;
  this__329:appendList(values__1768, fn__14233);
  return nil;
end;
SqlBuilder.methods.appendFloat64 = function(this__330, value__1772)
  local t_217;
  t_217 = SqlFloat64(value__1772);
  temper.listbuilder_add(this__330.buffer__1743, t_217);
  return nil;
end;
SqlBuilder.methods.appendFloat64List = function(this__331, values__1775)
  local fn__14227;
  fn__14227 = function(x__1777)
    this__331:appendFloat64(x__1777);
    return nil;
  end;
  this__331:appendList(values__1775, fn__14227);
  return nil;
end;
SqlBuilder.methods.appendInt32 = function(this__332, value__1779)
  local t_218;
  t_218 = SqlInt32(value__1779);
  temper.listbuilder_add(this__332.buffer__1743, t_218);
  return nil;
end;
SqlBuilder.methods.appendInt32List = function(this__333, values__1782)
  local fn__14221;
  fn__14221 = function(x__1784)
    this__333:appendInt32(x__1784);
    return nil;
  end;
  this__333:appendList(values__1782, fn__14221);
  return nil;
end;
SqlBuilder.methods.appendInt64 = function(this__334, value__1786)
  local t_219;
  t_219 = SqlInt64(value__1786);
  temper.listbuilder_add(this__334.buffer__1743, t_219);
  return nil;
end;
SqlBuilder.methods.appendInt64List = function(this__335, values__1789)
  local fn__14215;
  fn__14215 = function(x__1791)
    this__335:appendInt64(x__1791);
    return nil;
  end;
  this__335:appendList(values__1789, fn__14215);
  return nil;
end;
SqlBuilder.methods.appendString = function(this__336, value__1793)
  local t_220;
  t_220 = SqlString(value__1793);
  temper.listbuilder_add(this__336.buffer__1743, t_220);
  return nil;
end;
SqlBuilder.methods.appendStringList = function(this__337, values__1796)
  local fn__14209;
  fn__14209 = function(x__1798)
    this__337:appendString(x__1798);
    return nil;
  end;
  this__337:appendList(values__1796, fn__14209);
  return nil;
end;
SqlBuilder.methods.appendList = function(this__338, values__1800, appendValue__1801)
  local t_221, t_222, i__1803;
  i__1803 = 0;
  while true do
    t_221 = temper.listed_length(values__1800);
    if not (i__1803 < t_221) then
      break;
    end
    if (i__1803 > 0) then
      this__338:appendSafe(', ');
    end
    t_222 = temper.listed_get(values__1800, i__1803);
    appendValue__1801(t_222);
    i__1803 = temper.int32_add(i__1803, 1);
  end
  return nil;
end;
SqlBuilder.get.accumulated = function(this__339)
  return SqlFragment(temper.listbuilder_tolist(this__339.buffer__1743));
end;
SqlBuilder.constructor = function(this__586)
  local t_223;
  t_223 = temper.listbuilder_constructor();
  this__586.buffer__1743 = t_223;
  return nil;
end;
SqlFragment = temper.type('SqlFragment');
SqlFragment.methods.toSource = function(this__344)
  return SqlSource(this__344:toString());
end;
SqlFragment.methods.toString = function(this__345)
  local t_224, builder__1815, i__1816;
  builder__1815 = temper.stringbuilder_constructor();
  i__1816 = 0;
  while true do
    t_224 = temper.list_length(this__345.parts__1810);
    if not (i__1816 < t_224) then
      break;
    end
    temper.list_get(this__345.parts__1810, i__1816):formatTo(builder__1815);
    i__1816 = temper.int32_add(i__1816, 1);
  end
  return temper.stringbuilder_tostring(builder__1815);
end;
SqlFragment.constructor = function(this__607, parts__1818)
  this__607.parts__1810 = parts__1818;
  return nil;
end;
SqlFragment.get.parts = function(this__1989)
  return this__1989.parts__1810;
end;
SqlPart = temper.type('SqlPart');
SqlPart.methods.formatTo = function(this__346, builder__1820)
  temper.virtual();
end;
SqlSource = temper.type('SqlSource', SqlPart);
SqlSource.methods.formatTo = function(this__347, builder__1824)
  temper.stringbuilder_append(builder__1824, this__347.source__1822);
  return nil;
end;
SqlSource.constructor = function(this__613, source__1827)
  this__613.source__1822 = source__1827;
  return nil;
end;
SqlSource.get.source = function(this__1986)
  return this__1986.source__1822;
end;
SqlBoolean = temper.type('SqlBoolean', SqlPart);
SqlBoolean.methods.formatTo = function(this__348, builder__1830)
  local t_225;
  if this__348.value__1828 then
    t_225 = 'TRUE';
  else
    t_225 = 'FALSE';
  end
  temper.stringbuilder_append(builder__1830, t_225);
  return nil;
end;
SqlBoolean.constructor = function(this__616, value__1833)
  this__616.value__1828 = value__1833;
  return nil;
end;
SqlBoolean.get.value = function(this__1992)
  return this__1992.value__1828;
end;
SqlDate = temper.type('SqlDate', SqlPart);
SqlDate.methods.formatTo = function(this__349, builder__1836)
  local t_226, fn__14254;
  temper.stringbuilder_append(builder__1836, "'");
  t_226 = temper.date_tostring(this__349.value__1834);
  fn__14254 = function(c__1838)
    if (c__1838 == 39) then
      temper.stringbuilder_append(builder__1836, "''");
    else
      local local_227, local_228, local_229;
      local_227, local_228, local_229 = temper.pcall(function()
        temper.stringbuilder_appendcodepoint(builder__1836, c__1838);
      end);
      if local_227 then
      else
        temper.bubble();
      end
    end
    return nil;
  end;
  temper.string_foreach(t_226, fn__14254);
  temper.stringbuilder_append(builder__1836, "'");
  return nil;
end;
SqlDate.constructor = function(this__619, value__1840)
  this__619.value__1834 = value__1840;
  return nil;
end;
SqlDate.get.value = function(this__2007)
  return this__2007.value__1834;
end;
SqlFloat64 = temper.type('SqlFloat64', SqlPart);
SqlFloat64.methods.formatTo = function(this__350, builder__1843)
  local t_231, t_232, s__1845;
  s__1845 = temper.float64_tostring(this__350.value__1841);
  if temper.str_eq(s__1845, 'NaN') then
    t_232 = true;
  else
    if temper.str_eq(s__1845, 'Infinity') then
      t_231 = true;
    else
      t_231 = temper.str_eq(s__1845, '-Infinity');
    end
    t_232 = t_231;
  end
  if t_232 then
    temper.stringbuilder_append(builder__1843, 'NULL');
  else
    temper.stringbuilder_append(builder__1843, s__1845);
  end
  return nil;
end;
SqlFloat64.constructor = function(this__622, value__1847)
  this__622.value__1841 = value__1847;
  return nil;
end;
SqlFloat64.get.value = function(this__2004)
  return this__2004.value__1841;
end;
SqlInt32 = temper.type('SqlInt32', SqlPart);
SqlInt32.methods.formatTo = function(this__351, builder__1850)
  local t_233;
  t_233 = temper.int32_tostring(this__351.value__1848);
  temper.stringbuilder_append(builder__1850, t_233);
  return nil;
end;
SqlInt32.constructor = function(this__625, value__1853)
  this__625.value__1848 = value__1853;
  return nil;
end;
SqlInt32.get.value = function(this__1998)
  return this__1998.value__1848;
end;
SqlInt64 = temper.type('SqlInt64', SqlPart);
SqlInt64.methods.formatTo = function(this__352, builder__1856)
  local t_234;
  t_234 = temper.int64_tostring(this__352.value__1854);
  temper.stringbuilder_append(builder__1856, t_234);
  return nil;
end;
SqlInt64.constructor = function(this__628, value__1859)
  this__628.value__1854 = value__1859;
  return nil;
end;
SqlInt64.get.value = function(this__2001)
  return this__2001.value__1854;
end;
SqlString = temper.type('SqlString', SqlPart);
SqlString.methods.formatTo = function(this__353, builder__1862)
  local fn__14268;
  temper.stringbuilder_append(builder__1862, "'");
  fn__14268 = function(c__1864)
    if (c__1864 == 39) then
      temper.stringbuilder_append(builder__1862, "''");
    else
      local local_235, local_236, local_237;
      local_235, local_236, local_237 = temper.pcall(function()
        temper.stringbuilder_appendcodepoint(builder__1862, c__1864);
      end);
      if local_235 then
      else
        temper.bubble();
      end
    end
    return nil;
  end;
  temper.string_foreach(this__353.value__1860, fn__14268);
  temper.stringbuilder_append(builder__1862, "'");
  return nil;
end;
SqlString.constructor = function(this__631, value__1866)
  this__631.value__1860 = value__1866;
  return nil;
end;
SqlString.get.value = function(this__1995)
  return this__1995.value__1860;
end;
changeset = function(tableDef__921, params__922)
  local t_239;
  t_239 = temper.map_constructor(temper.listof());
  return ChangesetImpl__234(tableDef__921, params__922, t_239, temper.listof(), true);
end;
isIdentStart__639 = function(c__1695)
  local return__564, t_240, t_241;
  if (c__1695 >= 97) then
    t_240 = (c__1695 <= 122);
  else
    t_240 = false;
  end
  if t_240 then
    return__564 = true;
  else
    if (c__1695 >= 65) then
      t_241 = (c__1695 <= 90);
    else
      t_241 = false;
    end
    if t_241 then
      return__564 = true;
    else
      return__564 = (c__1695 == 95);
    end
  end
  return return__564;
end;
isIdentPart__640 = function(c__1697)
  local return__565;
  if isIdentStart__639(c__1697) then
    return__565 = true;
  elseif (c__1697 >= 48) then
    return__565 = (c__1697 <= 57);
  else
    return__565 = false;
  end
  return return__565;
end;
safeIdentifier = function(name__1699)
  local t_242, idx__1701, t_243;
  if temper.string_isempty(name__1699) then
    temper.bubble();
  end
  idx__1701 = 1.0;
  if not isIdentStart__639(temper.string_get(name__1699, idx__1701)) then
    temper.bubble();
  end
  t_243 = temper.string_next(name__1699, idx__1701);
  idx__1701 = t_243;
  while true do
    if not temper.string_hasindex(name__1699, idx__1701) then
      break;
    end
    if not isIdentPart__640(temper.string_get(name__1699, idx__1701)) then
      temper.bubble();
    end
    t_242 = temper.string_next(name__1699, idx__1701);
    idx__1701 = t_242;
  end
  return ValidatedIdentifier__319(name__1699);
end;
deleteSql = function(tableDef__1120, id__1121)
  local b__1123;
  b__1123 = SqlBuilder();
  b__1123:appendSafe('DELETE FROM ');
  b__1123:appendSafe(tableDef__1120.tableName.sqlValue);
  b__1123:appendSafe(' WHERE id = ');
  b__1123:appendInt32(id__1121);
  return b__1123.accumulated;
end;
from = function(tableName__1355)
  return Query(tableName__1355, temper.listof(), temper.listof(), temper.listof(), temper.null, temper.null, temper.listof(), temper.listof(), temper.listof(), false, temper.listof(), temper.null);
end;
col = function(table__1357, column__1358)
  local b__1360;
  b__1360 = SqlBuilder();
  b__1360:appendSafe(table__1357.sqlValue);
  b__1360:appendSafe('.');
  b__1360:appendSafe(column__1358.sqlValue);
  return b__1360.accumulated;
end;
countAll = function()
  local b__1362;
  b__1362 = SqlBuilder();
  b__1362:appendSafe('COUNT(*)');
  return b__1362.accumulated;
end;
countCol = function(field__1363)
  local b__1365;
  b__1365 = SqlBuilder();
  b__1365:appendSafe('COUNT(');
  b__1365:appendSafe(field__1363.sqlValue);
  b__1365:appendSafe(')');
  return b__1365.accumulated;
end;
sumCol = function(field__1366)
  local b__1368;
  b__1368 = SqlBuilder();
  b__1368:appendSafe('SUM(');
  b__1368:appendSafe(field__1366.sqlValue);
  b__1368:appendSafe(')');
  return b__1368.accumulated;
end;
avgCol = function(field__1369)
  local b__1371;
  b__1371 = SqlBuilder();
  b__1371:appendSafe('AVG(');
  b__1371:appendSafe(field__1369.sqlValue);
  b__1371:appendSafe(')');
  return b__1371.accumulated;
end;
minCol = function(field__1372)
  local b__1374;
  b__1374 = SqlBuilder();
  b__1374:appendSafe('MIN(');
  b__1374:appendSafe(field__1372.sqlValue);
  b__1374:appendSafe(')');
  return b__1374.accumulated;
end;
maxCol = function(field__1375)
  local b__1377;
  b__1377 = SqlBuilder();
  b__1377:appendSafe('MAX(');
  b__1377:appendSafe(field__1375.sqlValue);
  b__1377:appendSafe(')');
  return b__1377.accumulated;
end;
unionSql = function(a__1378, b__1379)
  local sb__1381;
  sb__1381 = SqlBuilder();
  sb__1381:appendSafe('(');
  sb__1381:appendFragment(a__1378:toSql());
  sb__1381:appendSafe(') UNION (');
  sb__1381:appendFragment(b__1379:toSql());
  sb__1381:appendSafe(')');
  return sb__1381.accumulated;
end;
unionAllSql = function(a__1382, b__1383)
  local sb__1385;
  sb__1385 = SqlBuilder();
  sb__1385:appendSafe('(');
  sb__1385:appendFragment(a__1382:toSql());
  sb__1385:appendSafe(') UNION ALL (');
  sb__1385:appendFragment(b__1383:toSql());
  sb__1385:appendSafe(')');
  return sb__1385.accumulated;
end;
intersectSql = function(a__1386, b__1387)
  local sb__1389;
  sb__1389 = SqlBuilder();
  sb__1389:appendSafe('(');
  sb__1389:appendFragment(a__1386:toSql());
  sb__1389:appendSafe(') INTERSECT (');
  sb__1389:appendFragment(b__1387:toSql());
  sb__1389:appendSafe(')');
  return sb__1389.accumulated;
end;
exceptSql = function(a__1390, b__1391)
  local sb__1393;
  sb__1393 = SqlBuilder();
  sb__1393:appendSafe('(');
  sb__1393:appendFragment(a__1390:toSql());
  sb__1393:appendSafe(') EXCEPT (');
  sb__1393:appendFragment(b__1391:toSql());
  sb__1393:appendSafe(')');
  return sb__1393.accumulated;
end;
subquery = function(q__1394, alias__1395)
  local b__1397;
  b__1397 = SqlBuilder();
  b__1397:appendSafe('(');
  b__1397:appendFragment(q__1394:toSql());
  b__1397:appendSafe(') AS ');
  b__1397:appendSafe(alias__1395.sqlValue);
  return b__1397.accumulated;
end;
existsSql = function(q__1398)
  local b__1400;
  b__1400 = SqlBuilder();
  b__1400:appendSafe('EXISTS (');
  b__1400:appendFragment(q__1398:toSql());
  b__1400:appendSafe(')');
  return b__1400.accumulated;
end;
update = function(tableName__1460)
  return UpdateQuery(tableName__1460, temper.listof(), temper.listof(), temper.null);
end;
deleteFrom = function(tableName__1462)
  return DeleteQuery(tableName__1462, temper.listof(), temper.null);
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
