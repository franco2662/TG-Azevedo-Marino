
import { React,useState, useEffect } from "react";
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';
import { Toolbar, Tooltip, IconButton, Typography, OutlinedInput, InputAdornment } from '@mui/material';
import SearchIcon from '@mui/icons-material/Search';
import Checkbox from '@mui/material/Checkbox';
import axios from "axios";
import { useAppContext } from "../AppContext";

const ModuloUsuario = () =>{
  const {baseURL} = useAppContext();
  const instance = axios.create()
  instance.defaults.baseURL = baseURL;

  const [filterName, setFilterName] = useState('');
  const [listaUsuarios, setListaUsuarios] = useState([]);
  const [listaUsuariosFiltrada, setListaUsuariosFiltrada] = useState([]);
  const handleFilterName = (event) =>{
    setFilterName(event.target.value);
  }
  
  function filterListByName(){ 
    if(filterName.trim()=="") // Si no hay nada escrito setea la original
      setListaUsuariosFiltrada(listaUsuarios)
    else{
      //Se llena un array, si algun elemento de un registro coincide con la busqueda, se añade
      let lista = listaUsuarios.filter((item) => {          
          if(String(item.nombre_completo).toLowerCase().includes(filterName.toLowerCase()) ||
            String(item.email).toLowerCase().includes(filterName.toLowerCase()) ||
            String(item.doc_identidad).toLowerCase().includes(filterName.toLowerCase()) ||
            String(item.rol).toLowerCase().includes(filterName.toLowerCase()) ||
              ( 
                (filterName.toLowerCase().includes("activo") && item.estado) || //Para buscar por estado
                (filterName.toLowerCase().includes("inactivo") && !item.estado )
              )
          )
          return item;
      });
      setListaUsuariosFiltrada(lista); //Se asigna el array filtrado anteriormente
    }
  }

  useEffect(() => {
    getUserList();
  }, []);

  useEffect(() => {
    filterListByName(); //Cada vez que cambie la busqueda
  }, [filterName]);


  async function getUserList(){
    try {
      const response = await instance.get("viewuserlist/");
      setListaUsuarios(JSON.parse(response.data))    
      setListaUsuariosFiltrada(JSON.parse(response.data))
    } catch (error) {
      console.log(error);
      throw new Error(error);
    } finally {  
    }
  };

  function getEstadoTableCell(estado){
    
      if (estado==true)
        return(<TableCell align="left" sx={{color:"green",fontWeight: "bold"}}>Activo</TableCell>)
      else
        return(<TableCell align="left" sx={{color:"red",fontWeight: "bold"}}>Inactivo</TableCell>)
    
  }
    return (
      <>
        <Toolbar>
          <OutlinedInput
            value={filterName}
            onChange={handleFilterName}
            placeholder="Buscar usuario..."
            startAdornment={
              <InputAdornment position="start">
                <SearchIcon />
              </InputAdornment>
            }
            sx={{ width:'20%' }}
          />
        </Toolbar>
        <TableContainer component={Paper}>
          <Table sx={{ minWidth: 650 }} aria-label="simple table">
            <TableHead>
            
              <TableRow>
                <TableCell align="center" sx={{width:'10%'}}>ID</TableCell>           
                <TableCell align="left">Nombre Completo</TableCell>
                <TableCell align="left">Email</TableCell>
                <TableCell align="left">Doc Identidad</TableCell>
                <TableCell align="left">Rol</TableCell>
                <TableCell align="left">Estado</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>              
              {listaUsuariosFiltrada.map((row) => (
                <TableRow
                  key={row.id}
                  sx={{'&:last-child td, &:last-child th': { border: 0 }}}                  
                >  <TableCell align="center" scope="row">
                <Checkbox/>
                {row.id}
                </TableCell>               
                  <TableCell align="left" scope="row">
                    {row.nombre_completo}
                    </TableCell>
                  <TableCell align="left">{row.email}</TableCell>                  
                  <TableCell align="left">{row.doc_identidad}</TableCell>                  
                  <TableCell align="left">{row.rol}</TableCell>                  
                  {getEstadoTableCell(row.estado)}                  
                </TableRow>
                
              ))}
            </TableBody>
          </Table>
        </TableContainer>
        </>
      );
}

export default ModuloUsuario;