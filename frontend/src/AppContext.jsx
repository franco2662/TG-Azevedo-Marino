import React from "react";
import { useState, useEffect, useMemo, useRef } from "react";
import axios from "axios";

const AppContext = React.createContext();
export function AppContextProvider(props){
  
  
  const baseURL = "http://127.0.0.1:8000/";
  
  const usuarioConectado = useRef('');
  function cambiarUsuario(usuario){
    usuarioConectado.current =usuario;
  }

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

  async function makeSesion(){
    const instance = axios.create()
  instance.defaults.baseURL = baseURL;
    let objeto = {
      horainicio: dateConexion.current,
      ipconexion:ipConexion.current,
      fk_usuario:0,
      user_email:usuarioConectado.current
    }
    await instance.post("insertSesion/", objeto);
  }

  const value  = useMemo(()=>{
    return({
      usuarioConectado,
      cambiarUsuario,
      showSidebar,
      handleSidebar,
      baseURL,
      ipConexion,
      getIpConexion,
      dateConexion,
      getDateConexion,
      makeSesion   
    })
  },[usuarioConectado,showSidebar])
  
  return <AppContext.Provider value = {value}{...props}/>
}

export function useAppContext(){
  const context = React.useContext(AppContext);
  if(!context){
    throw new Error('problema con contexto')
  }
  return context;

}
