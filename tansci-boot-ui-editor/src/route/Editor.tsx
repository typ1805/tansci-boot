import React from 'react';
import {Editor, ShortcutKey} from 'amis-editor';
import {inject, observer} from 'mobx-react';
import {RouteComponentProps} from 'react-router-dom';
import {toast, Select} from 'amis';
import {currentLocale} from 'i18n-runtime';
import {Icon} from '../icons/index';
import {IMainStore} from '../store';
import '../editor/DisabledEditorPlugin'; // 用于隐藏一些不需要的Editor预置组件
import '../renderer/MyRenderer';
import '../editor/MyRenderer';
import axios from 'axios';

let currentIndex = -1;
let host = `${window.location.protocol}//${window.location.host}`;
let iframeUrl = '/editor.html';

const schemaUrl = `${host}/schema.json`;

const editorLanguages = [
  {
    label: '简体中文',
    value: 'zh-CN'
  },
  {
    label: 'English',
    value: 'en-US'
  }
];

// 获取页面ID
const query = window.location.href.split('?')[1];
let id:string = ''
let token:string = ''
if(query){
  let val = query.substr(3);
  val = window.atob(val)
  id = val.split(",")[0]
  token = val.split(",")[1]
}

let _token = window.common.TOKEN_KEY
const apiQueryUrl = window.common.API_QUERY_URL
const apiSaveUrl = window.common.API_SAVE_URL

export default inject('store')(
  observer(function ({
    store,
    location,
    history,
    match
  }: {store: IMainStore} & RouteComponentProps<{id: string}>) {
    const index: number = parseInt(match.params.id, 10);
    const curLanguage = currentLocale(); // 获取当前语料类型

    if (index !== currentIndex) {
      currentIndex = index;
      //store.updateSchema(store.pages[index].schema);
       // 从数据库获取页面JSON
       if(id && id != ''){
        axios.get(apiQueryUrl + id, {headers:{[_token]:token}}).then(function (res:any){
          if(res.data.result && res.data.result.pageschema){
            store.updateSchema(JSON.parse(res.data.result.pageschema));
          } else {
            toast.error('服务器异常，请联系管理员！', '提示');
          }
        }).catch(function (e:any){
          console.log(e)
          toast.error('服务器异常，请联系管理员！', '提示');
        })
      } else {
        store.updateSchema({});
        setTimeout(() => {
          toast.error('服务器异常，请联系管理员！', '提示');
        }, 1000);
      }

    }

    function save() {
      store.updatePageSchemaAt(index);
      toast.success('保存成功', '提示');
    }

    function onChange(value: any) {
      store.updateSchema(value);
      store.updatePageSchemaAt(index);
    }

    function changeLocale(value: string) {
      localStorage.setItem('suda-i18n-locale', value);
      window.location.reload();
    }

    function exit() {
      history.push(`/${store.pages[index].path}`);
    }

    // 保存到数据库
    function onSaveOrUpdate(this: any, e:any) {
    if(id && id != ''){
      store.updatePageSchemaAt(index);
      let schema = store.pages[index].schema;
      axios.post(apiSaveUrl, {id:id, pageschema: JSON.stringify(schema)}, {headers:{[_token]:token}}).then(function (res:any){
        console.log("保存:", res)
        if(res.data.code == 200){
          toast.success("操作成功！", '提示');
        } else {
          toast.error(res.data.message, '提示');
        }
      }).catch(function (e:any){
        console.log(e)
        toast.error("服务器异常，请联系管理员！", '提示');
      })
    }
  }

    return (
      <div className="Editor-Demo">
        <div className="Editor-header">
          <div className="Editor-title">可视化编辑器</div>
          <div className="Editor-view-mode-group-container">
            <div className="Editor-view-mode-group">
              <div
                className={`Editor-view-mode-btn editor-header-icon ${
                  !store.isMobile ? 'is-active' : ''
                }`}
                onClick={() => {
                  store.setIsMobile(false);
                }}
              >
                <Icon icon="pc-preview" title="PC模式" />
              </div>
              <div
                className={`Editor-view-mode-btn editor-header-icon ${
                  store.isMobile ? 'is-active' : ''
                }`}
                onClick={() => {
                  store.setIsMobile(true);
                }}
              >
                <Icon icon="h5-preview" title="移动模式" />
              </div>
            </div>
          </div>

          <div className="Editor-header-actions">
            <ShortcutKey />
            <Select
              className="margin-left-space"
              options={editorLanguages}
              value={curLanguage}
              clearable={false}
              onChange={(e: any) => changeLocale(e.value)}
            />
            <div
              className={`header-action-btn m-1 ${
                store.preview ? 'primary' : ''
              }`}
              onClick={() => {
                store.setPreview(!store.preview);
              }}
            >
              {store.preview ? '编辑' : '预览'}
            </div>

            <div className={`header-action-btn m-1 primary`} onClick={(e:any) => onSaveOrUpdate(e)}>保存</div>

            {/* {!store.preview && (
              <div className={`header-action-btn exit-btn`} onClick={exit}>
                退出
              </div>
            )} */}
          </div>
        </div>
        <div className="Editor-inner">
          <Editor
            theme={'cxd'}
            preview={store.preview}
            isMobile={store.isMobile}
            value={store.schema}
            onChange={onChange}
            onPreview={() => {
              store.setPreview(true);
            }}
            onSave={save}
            className="is-fixed"
            $schemaUrl={schemaUrl}
            iframeUrl={iframeUrl}
            showCustomRenderersPanel={true}
            amisEnv={{
              fetcher: store.fetcher,
              notify: store.notify,
              alert: store.alert,
              copy: store.copy
            }}
          />
        </div>
      </div>
    );
  })
);
