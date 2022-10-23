
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
    if(filterName.trim()=="")
      setListaUsuariosFiltrada(listaUsuarios)
    else{
      console.log("prueba" + filterName);
      let lista = listaUsuarios.filter((item) => {
        if((String(item.fk_persona.nombre)+String(item.fk_persona.apellido)).toLowerCase().includes(String(filterName)))
          return item;
          }
        );
      console.log(lista);
      setListaUsuariosFiltrada(lista);
    }
  }

  useEffect(() => {
    getUserList();
  }, []);

  useEffect(() => {
    filterListByName();
  }, [filterName]);
  async function getUserList(){
    try {
      const response = await instance.get("users/");
      setListaUsuarios(JSON.parse(response.data))
      setListaUsuariosFiltrada(JSON.parse(response.data));
      console.log(listaUsuariosFiltrada);
    } catch (error) {
      console.log(error);
      throw new Error(error);
    } finally {  
    }
  };

  function getEstadoTableCell(row){
    
      if (row.estado==true)
        return(<TableCell align="left" sx={{color:"green",fontWeight: "bold"}}>Activo</TableCell>)
      else
        return(<TableCell align="left" sx={{color:"green",fontWeight: "bold"}}>Inactivo</TableCell>)
    
  }
    return (
        <TableContainer component={Paper}>
          <Table sx={{ minWidth: 650 }} aria-label="simple table">
            <TableHead>
            <Toolbar>
            <OutlinedInput
          value={filterName}
          onChange={handleFilterName}
          placeholder="Buscar usuario..."
          startAdornment={
            <InputAdornment position="start">
              <SearchIcon/>
            </InputAdornment>
          }
        />
        </Toolbar>
              <TableRow>
                <TableCell>Nombre</TableCell>
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
                  sx={{ '&:last-child td, &:last-child th': { border: 0 } }}
                >
                  <TableCell component="th" scope="row">
                    {row.fk_persona.nombre + ' ' + row.fk_persona.apellido}
                  </TableCell>
                  <TableCell align="left">{row.email}</TableCell>
                  <TableCell align="left">{row.fk_persona.docidentidad}</TableCell>
                  <TableCell align="left">{row.fk_rol.nombre}</TableCell>
                  {getEstadoTableCell(row)}
                </TableRow>
                
              ))}
            </TableBody>
          </Table>
        </TableContainer>
      );
}

export default ModuloUsuario;