const common:any = {}

// 生成UUID
common.uuid = () => {
    function S4() {
      return (((1+Math.random())*0x10000)|0).toString(16).substring(1);
    }
    return (S4()+S4()+S4()+S4()+S4()+S4()+S4()+S4());
}

// 是否包含逗号
common.isComma = (value:any) => {
    return value.toString().indexOf(',') !== -1
}

export default common