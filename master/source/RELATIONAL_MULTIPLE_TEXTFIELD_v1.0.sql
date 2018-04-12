prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_050100 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2016.08.24'
,p_release=>'5.1.4.00.08'
,p_default_workspace_id=>13707805413010735447
,p_default_application_id=>528922
,p_default_owner=>'JOSEPCOVES'
);
end;
/
prompt --application/shared_components/plugins/item_type/es_relational_josepcoves_multitextfield
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(61155198512359989186)
,p_plugin_type=>'ITEM TYPE'
,p_name=>'ES.RELATIONAL.JOSEPCOVES.MULTITEXTFIELD'
,p_display_name=>'Relational: Multiple textfields'
,p_supported_ui_types=>'DESKTOP'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS:APEX_APPL_PAGE_IG_COLUMNS'
,p_javascript_file_urls=>'#PLUGIN_FILES#rltn_textfiledmultiple.js'
,p_css_file_urls=>'#PLUGIN_FILES#rltn_textfieldmultiple.css'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  procedure render_item (',
'    p_item   in            apex_plugin.t_item,',
'    p_plugin in            apex_plugin.t_plugin,',
'    p_param  in            apex_plugin.t_item_render_param,',
'    p_result in out nocopy apex_plugin.t_item_render_result )    ',
'   AS  ',
'    ',
'    v_result apex_plugin.t_page_item_render_result; ',
'    v_page_item_name varchar2(200);',
'    v_item_attrib varchar2(4000);',
'    v_html varchar2(9000);',
'    ',
'    p_value            p_param.value%type := p_param.value;',
'    p_is_readonly      p_param.is_readonly%type := p_param.is_readonly;',
'    p_is_printer_friendly      p_param.is_printer_friendly%type := p_param.is_printer_friendly;',
'    ',
'    p_num_textfields   p_item.attribute_01%type:= p_item.attribute_01;',
'    p_separador        p_item.attribute_02%type:= p_item.attribute_02; ',
'    p_llargades        p_item.attribute_03%type:= p_item.attribute_03; ',
'    p_custom_css       p_item.attribute_04%type:= p_item.attribute_04; ',
'    p_auto_salt        p_item.attribute_05%type:= p_item.attribute_05; ',
'    ',
'    v_llista_valors   apex_t_varchar2;',
'    v_valor_actual    varchar2(4000);',
'    ',
'    v_llista_llargades apex_t_varchar2;',
'    v_llargada_actual varchar2(4000);',
'    ',
'    v_llista_css apex_t_varchar2;',
'    v_css_actual varchar2(4000);',
'    ',
'    v_textfield_html varchar(4000) := ''<input type="textfield" name="#NAME#"  value="#VALUE#" class="text_field apex-item-text rltn_multiple_textfield #CUSTOM_CSS#" #LENGTH#>'';',
'    v_textfield_html_actual varchar(4000);',
'    v_nom_textfield_actual varchar2(4000);',
'                ',
'  BEGIN',
'    ',
'    IF apex_application.g_debug THEN',
'      apex_plugin_util.debug_page_item (p_plugin                => p_plugin,',
'                                        p_page_item             => p_item,',
'                                        p_value                 => p_value,',
'                                        p_is_readonly           => p_is_readonly,',
'                                        p_is_printer_friendly   => p_is_printer_friendly);',
'    END IF;',
'    ',
'    ',
'    IF p_is_readonly OR p_is_printer_friendly THEN    ',
'      apex_plugin_util.print_hidden_if_readonly (p_item_name             => p_item.name,',
'                                                 p_value                 => p_value,',
'                                                 p_is_readonly           => p_is_readonly,',
'                                                 p_is_printer_friendly   => p_is_printer_friendly);',
'      apex_plugin_util.print_display_only (p_item_name          => p_item.NAME,',
'                                           p_display_value      => p_value,',
'                                           p_show_line_breaks   => FALSE,',
'                                           p_escape             => TRUE,',
'                                           p_attributes         => p_item.element_attributes);',
'    ELSE',
'      ',
'      /********* Retreiving parameters and attributes **********/',
'      v_page_item_name := apex_plugin.get_input_name_for_page_item (p_is_multi_value => FALSE);',
'      ',
'      v_item_attrib := p_item.element_attributes;',
'      ',
'      htp.p(',
'              ''<input type="hidden" ',
'                      name="''||v_page_item_name||''" ',
'                      id="''||p_item.name||''"                       ',
'                      value="''||p_value||''" ''||                                             ',
'                      v_item_attrib||'' >''          ',
'            );                            ',
'      ',
'      ',
'      v_llista_valors := apex_string.split(p_value,p_separador);',
'      v_llista_llargades := apex_string.split(p_llargades,'':'');',
'      v_llista_css := apex_string.split(p_custom_css,'':'');',
'      for i in 1..p_num_textfields ',
'      loop',
'        v_nom_textfield_actual := v_page_item_name||''_T''||i;',
'        ',
'        if (i <= v_llista_valors.count) then',
'          v_valor_actual := v_llista_valors(i);',
'        else v_valor_actual := '''';',
'        end if;',
'        ',
'        if (i <= v_llista_llargades.count) then          ',
'          v_llargada_actual := '' maxlength="''||v_llista_llargades(i)||''" size="''||v_llista_llargades(i)||''"'';',
'        else v_llargada_actual := '''';',
'        end if;',
'        ',
'        if (i <= v_llista_css.count) then',
'          v_css_actual := v_llista_css(i);',
'        else',
'          v_css_actual := '''';',
'        end if;',
'        v_textfield_html_actual := v_textfield_html;',
'        v_textfield_html_actual := replace(v_textfield_html_actual,''#NAME#'',v_page_item_name||''_T''||i);',
'        v_textfield_html_actual := replace(v_textfield_html_actual,''#VALUE#'',v_valor_actual);',
'        v_textfield_html_actual := replace(v_textfield_html_actual,''#LENGTH#'',v_llargada_actual);',
'        v_textfield_html_actual := replace(v_textfield_html_actual,''#CUSTOM_CSS#'',v_css_actual);',
'        ',
'        ',
'        htp.p(v_textfield_html_actual);',
'        /* Add on change action to update inner hidden item */',
'        v_html := v_html||''$(''''input[name=''||v_nom_textfield_actual||'']'''').on(''''change'''',function(){rltn_textfield_multiple_update(''''''||v_page_item_name||'''''',''''''||p_separador||'''''');});'';',
'        /* Jump to next textfield when input length overflows*/',
'        if (p_auto_salt = ''Y'' and nvl(v_llargada_actual,''-1'')!=''-1'') then',
'          v_html := v_html||''$(''''input[name=''||v_nom_textfield_actual||'']'''').keyup(function(e){ if ((e.keyCode || e.which) !== 9) rltn_textfield_multiple_insert(''''''||v_nom_textfield_actual||''''''); });'';',
'        end if;',
'      end loop;',
'      /****** JAVASCRIPT **************/      ',
'      ',
'             ',
'       if (p_item.placeholder is not null) then',
'         v_html := v_html||''$(''''#''||p_item.name||'''''').attr(''''placeholder'''',''''''||nvl(p_item.placeholder,'''')||'''''');'';',
'       end if;',
'       apex_javascript.add_onload_code (p_code => v_html);',
'       ',
'    END IF;        ',
'  end render_item;'))
,p_api_version=>2
,p_render_function=>'render_item'
,p_standard_attributes=>'VISIBLE:FORM_ELEMENT:READONLY:SOURCE:PLACEHOLDER'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<h1>RELATIONAL: Multiple textfield</h1>',
'<p>RELATIONAL</p>',
'<p>Josep Coves - josepcoves@relational.es</p>',
'<p>Creation Date: April - 2018</p>',
'<h2><em>Introduction</em></h2>',
'<p>APEX plugin which renders multiple textfield inputs and stores result as a single string, separated by scpecial character.</p>',
'<h2>Case of use</h2>',
'<p>Useful to render bank account items, arrays, matrix, etc.</p>',
'<p>Session value storage example: TEXTFIELDVALUE1|TEXTFIELDVALUE2|TEXTFIELDVALUE3&nbsp;</p>',
'<h2><strong>Features</strong></h2>',
'<ul>',
'<li>Possibility to specify unlimited number of textfields</li>',
'<li>Possibility to specify custom separator</li>',
'<li>Possiblity to specify different length for each textfield</li>',
'<li>Possiblity to specify different CSS classes for each textfield</li>',
'<li>Possiblity to enable auto-focus on next textfield when input exceeds current textfield length</li>',
'<li>Universal Theme aware (supports stretch fields)</li>',
'</ul>'))
,p_version_identifier=>'1.0'
,p_about_url=>'http://www.relational.es'
,p_files_version=>3
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(61155250840244219566)
,p_plugin_id=>wwv_flow_api.id(61155198512359989186)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Number of textfields'
,p_attribute_type=>'NUMBER'
,p_is_required=>true
,p_default_value=>'2'
,p_supported_ui_types=>'DESKTOP'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS:APEX_APPL_PAGE_IG_COLUMNS'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(61155414970021007672)
,p_plugin_id=>wwv_flow_api.id(61155198512359989186)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Delimited by'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>'|'
,p_display_length=>1
,p_supported_ui_types=>'DESKTOP'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS:APEX_APPL_PAGE_IG_COLUMNS'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(61155250840244219566)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'NOT_NULL'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(61155493279043239487)
,p_plugin_id=>wwv_flow_api.id(61155198512359989186)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Textfields length (separated by :)'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_supported_ui_types=>'DESKTOP'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS:APEX_APPL_PAGE_IG_COLUMNS'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(61155602836383020174)
,p_plugin_id=>wwv_flow_api.id(61155198512359989186)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Textfields css (separated by :)'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_supported_ui_types=>'DESKTOP'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS:APEX_APPL_PAGE_IG_COLUMNS'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(61155783994086249955)
,p_plugin_id=>wwv_flow_api.id(61155198512359989186)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Auto focus next textfield on length overflow'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_supported_ui_types=>'DESKTOP'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS:APEX_APPL_PAGE_IG_COLUMNS'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(61155493279043239487)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'NOT_NULL'
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2E726C746E5F6D756C7469706C655F746578746669656C647B0D0A20206D617267696E2D72696768743A3570783B0D0A7D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(61155844010594258399)
,p_plugin_id=>wwv_flow_api.id(61155198512359989186)
,p_file_name=>'rltn_textfieldmultiple.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '66756E6374696F6E20726C746E5F746578746669656C645F6D756C7469706C655F75706461746528705F6974656D5F6E616D652C705F736570617261646F72297B0D0A202020765F6F626A203D2024282723272B705F6974656D5F6E616D65293B0D0A20';
wwv_flow_api.g_varchar2_table(2) := '2020765F6F626A2E76616C282727293B0D0A202020242827696E7075745B6E616D655E3D272B705F6974656D5F6E616D652B275F545D27292E65616368280D0A202020202066756E6374696F6E28297B0D0A202020202020202069662028765F6F626A2E';
wwv_flow_api.g_varchar2_table(3) := '76616C2829213D272729200D0A20202020202020202020765F6F626A2E76616C28765F6F626A2E76616C28292B705F736570617261646F722B242874686973292E76616C2829293B0D0A2020202020202020656C73650D0A20202020202020202020765F';
wwv_flow_api.g_varchar2_table(4) := '6F626A2E76616C28242874686973292E76616C2829293B2020202020200D0A2020202020207D0D0A20202020293B0D0A7D0D0A0D0A66756E6374696F6E20726C746E5F746578746669656C645F6D756C7469706C655F696E7365727428705F6974656D5F';
wwv_flow_api.g_varchar2_table(5) := '6E616D65297B0D0A2020765F6F626A20203D20242827696E7075745B6E616D653D272B705F6974656D5F6E616D652B275D27293B0D0A202069662028765F6F626A2E76616C28292E6C656E677468203D3D20765F6F626A2E6174747228276D61786C656E';
wwv_flow_api.g_varchar2_table(6) := '677468272929207B0D0A2020202076617220246E657874203D20765F6F626A2E6E6578742827696E70757427293B0D0A2020202069662028246E6578742E6C656E67746829207B0D0A2020202020202020246E6578742E666F63757328293B0D0A202020';
wwv_flow_api.g_varchar2_table(7) := '2020202020246E6578742E73656C65637428293B0D0A202020207D0D0A20202020656C73650D0A2020202020202020765F6F626A2E626C757228293B0D0A20207D0D0A7D0D0A0D0A';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(61155844318651258402)
,p_plugin_id=>wwv_flow_api.id(61155198512359989186)
,p_file_name=>'rltn_textfiledmultiple.js'
,p_mime_type=>'application/x-javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false), p_is_component_import => true);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
