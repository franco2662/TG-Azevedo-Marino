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
  clave:'',
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
      clave:userInfo.clave,
      fechacreacion:userInfo.fechacreacion,
      estado:userInfo.estado,
      fk_persona:userInfo.fk_persona,
      fk_rol:userInfo.fk_rol,
      fk_empresa:userInfo.fk_empresa,
      horainicio:dateConexion.current,
      ipconexion:ipConexion.current,
      }
    // console.log(usuarioObjeto.current);
  }

  const value  = useMemo(()=>{
    return({
      showSidebar,
      handleSidebar,
      baseURL,
      makeSesion,
      usuarioObjeto   
    })
  },[usuarioObjeto,showSidebar])
  
  return <AppContext.Provider value = {value}{...props}/>
}

export function useAppContext(){
  const context = React.useContext(AppContext);
  if(!context){
    throw new Error('problema con contexto')
  }
  return context;

}
