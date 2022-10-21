
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

function createData(nombre, email, docidentidad, rol) {
  return { nombre, email, docidentidad, rol};
}



const ModuloUsuario = () =>{
  const {baseURL} = useAppContext();
  const instance = axios.create()
  instance.defaults.baseURL = baseURL;

  // let rows = [
  //   createData('Frozen yoghurt', 159, 6.0, 24, 4.0),
  //   createData('Ice cream sandwich', 237, 9.0, 37, 4.3),
  //   createData('Eclair', 262, 16.0, 24, 6.0),
  //   createData('Cupcake', 305, 3.7, 67, 4.3),
  //   createData('Gingerbread', 356, 16.0, 49, 3.9),
  // ];
  const [filterName, setFilterName] = useState('');
  const[listaUsuarios,setListaUsuarios] = useState([]);
  const handleFilterName = (event) =>{
    setFilterName(event.target.value);
    console.log(filterName);
  }

  useEffect(() => {
    getUserList();
  }, []);

  async function getUserList(){
    const response = await instance.get("users/");
    // console.log(response.data);
    setListaUsuarios(JSON.parse(response.data))
    console.log(listaUsuarios);
    // listaUsuarios.map((info)=>{
    //     console.log(info.id)
    //   });    
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
              </TableRow>
            </TableHead>
            <TableBody>
              {listaUsuarios.map((row) => (
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
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </TableContainer>
      );
}

export default ModuloUsuario;