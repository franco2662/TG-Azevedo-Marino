import React from "react";
import { useState, useEffect, useMemo } from "react";

const AppContext = React.createContext();

export function AppContextProvider(props){
  const [usuarioPrueba,setUsuarioPrueba] = useState('prueba');
  function cambiarUsuario(usuario){
    setUsuarioPrueba(usuario);
  }

  const value  = useMemo(()=>{
    return({
      usuarioPrueba,
      cambiarUsuario
    })
  },[usuarioPrueba])
  
  return <AppContext.Provider value = {value}{...props}/>
}

export function useAppContext(){
  const context = React.useContext(AppContext);
  if(!context){
    throw new Error('problema con contexto')
  }
  return context;

}
