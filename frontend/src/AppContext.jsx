import React from "react";
import { useState, useEffect, useMemo } from "react";

const AppContext = React.createContext();
export function AppContextProvider(props){
  
  const [usuarioPrueba,setUsuarioPrueba] = useState('prueba');
  function cambiarUsuario(usuario){
    setUsuarioPrueba(usuario);
  }
  const [showSidebar,setShowSidebar] = useState(true);

  function handleSidebar(){
    console.log('sidebar actual '+ showSidebar);
    setShowSidebar(!showSidebar);    
    console.log('cambio sidebar a ' + showSidebar);
  }
  const value  = useMemo(()=>{
    return({
      usuarioPrueba,
      cambiarUsuario,
      showSidebar,
      handleSidebar   
    })
  },[usuarioPrueba,showSidebar])
  
  return <AppContext.Provider value = {value}{...props}/>
}

export function useAppContext(){
  const context = React.useContext(AppContext);
  if(!context){
    throw new Error('problema con contexto')
  }
  return context;

}
