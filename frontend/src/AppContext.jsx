import React from "react";
import { useState, useEffect, useMemo, useRef } from "react";
import axios from "axios";

const AppContext = React.createContext();
export function AppContextProvider(props){
  
  const baseURL = "http://127.0.0.1:8000/";
  const [showSidebar,setShowSidebar] = useState(true);
  function handleSidebar(){
    setShowSidebar(!showSidebar);  
  }

  const ipConexion = useRef('');
  async function getIpConexion(){
    const res = await axios.get('https://geolocation-db.com/json/')
    ipConexion.current = res.data.IPv4;
  }

  const dateConexion = useRef(new Date().toISOString())
  function getDateConexion(){
    var today = new Date().toISOString();
    dateConexion.current = today;
  };

  const usuarioObjeto = useRef({
  id:'',
  email:'',
  fechacreacion:'',
  estado:'',
  fk_persona:'',
  fk_rol:'',
  fk_empresa:'',
  horainicio:'',
  ipconexion:'',
  })

  async function makeSesion(user){
    await getIpConexion();
    getDateConexion();
    const instance = axios.create()
    instance.defaults.baseURL = baseURL;
    let objeto = {
      horainicio: dateConexion.current,
      ipconexion:ipConexion.current,
      fk_usuario:0,
      user_email:user
    }
    await instance.post("insertSesion/", objeto);

    const response = await instance.get("getUserByEmail/"+user);
    //console.log(response?.data);
    const userInfo = JSON.parse(response.data)

    usuarioObjeto.current = {
      id:userInfo.id,
      email:userInfo.email,
      fechacreacion:userInfo.fechacreacion,
      estado:userInfo.estado,
      fk_persona:userInfo.fk_persona,
      fk_rol:userInfo.fk_rol,
      fk_empresa:userInfo.fk_empresa,
      horainicio:dateConexion.current,
      ipconexion:ipConexion.current,
      }
      getSession();
  }

  function getSession(){
    if (sessionStorage.getItem('user_session') === null) {
      sessionStorage.setItem('user_session',JSON.stringify(usuarioObjeto.current));
    }
    else{
      if(usuarioObjeto.current.id == '')
        usuarioObjeto.current = JSON.parse(sessionStorage.getItem('user_session'));
      //console.log(JSON.parse(sessionStorage.getItem('user_session')));
    }
  }

  function singOut(){
    
    sessionStorage.removeItem('user_session');
    
  }
  async function getLastAnalisis(){
    const instance = axios.create()
    instance.defaults.baseURL = baseURL;
    console.log(usuarioObjeto.current.id);
    if(usuarioObjeto.current.id!=""){
      const response = await instance.get("lastIdAnalisisByUser/"+usuarioObjeto.current.id);
      console.log(JSON.parse(response.data)["id_analisis"]);
      if(response?.data)
      return Number.parseInt(JSON.parse(response.data)["id_analisis"]);
    }
  
}
  const idAnalisisFromHistory = useRef(0);

  const value  = useMemo(()=>{
    return({
      showSidebar,
      handleSidebar,
      baseURL,
      makeSesion,
      usuarioObjeto,
      getSession,
      singOut,
      idAnalisisFromHistory  
    })
  },[usuarioObjeto,showSidebar,idAnalisisFromHistory])
  
  return <AppContext.Provider value = {value}{...props}/>
}

export function useAppContext(){
  const context = React.useContext(AppContext);
  if(!context){
    throw new Error('problema con contexto')
  }
  return context;

}
