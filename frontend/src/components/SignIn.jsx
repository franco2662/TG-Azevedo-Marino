import * as React from 'react';
import Avatar from '@mui/material/Avatar';
import Button from '@mui/material/Button';
import CssBaseline from '@mui/material/CssBaseline';
import TextField from '@mui/material/TextField';
import FormControlLabel from '@mui/material/FormControlLabel';
import Checkbox from '@mui/material/Checkbox';
import Link from '@mui/material/Link';
import Grid from '@mui/material/Grid';
import Box from '@mui/material/Box';
import LockOutlinedIcon from '@mui/icons-material/LockOutlined';
import Typography from '@mui/material/Typography';
import Container from '@mui/material/Container';
import { createTheme, ThemeProvider } from '@mui/material/styles';
import { Modal } from '@mui/material';
import Alert from '@mui/material/Alert';
import Snackbar from '@mui/material/Snackbar';
import { useState } from 'react';
import axios from "axios";
import { useAppContext } from "../AppContext";

const style = {
  position: 'absolute',
  top: '50%',
  left: '50%',
  transform: 'translate(-50%, -50%)',
  width: 400,
  bgcolor: 'background.paper',
  border: '2px solid #000',
  boxShadow: 24,
  p: 4,
};
const SignIn = () => {
  
  const {baseURL} = useAppContext();
  const instance = axios.create()
  instance.defaults.baseURL = baseURL;

  const theme = createTheme();
  const[user,setUser]=useState("");
  const[pass,setPass]=useState("");
  const[error,setError]=useState("");
  const[success,setSuccess]=useState("");
  const[errorAlert,setErrorAlert]=useState(false);  
  const[successAlert,setSuccessAlert]=useState(false);
  
  const handleClose = ()=>{
    setSuccessAlert(false);
    setErrorAlert(false);
  }

async function verifyUser(){
  try
  { 
    setSuccessAlert(false);
    setErrorAlert(false);
    const response = await instance.get("verifyuser/"+user);
    if(!response?.data)
      return false;
    else 
      if(response.data == true)
        return true;
      else
        return false;
  }
  catch(err)
  {
    if (!err?.response) 
    {
      console.log("No Server Response");
    }
    else
    {
      console.log("User verification failed");
    }
    return false;    
  }
}

const handleSignIn = async(e)=>{
  try
  { 
    e.preventDefault();
    const verificacion_usuario = await verifyUser();
    if(verificacion_usuario)
    {
      const obj = { email: user, clave: pass };
      const json_request = JSON.stringify(obj);
      const response = await instance.post("validatesignin/", json_request);
      if(response.data==true){
        setSuccess("Ha iniciado sesión!");
        setSuccessAlert(true);
      }      
    }
    else
    {
      setError("Usuario Inválido");
      setErrorAlert(true);
    }       
  }
  catch(err)
  {
    if (!err?.response) 
    {
      setError("Error en el servidor");
    }
    else
    {
      setError("Credenciales incorrectas")
    }
    setSuccessAlert(false);
    setErrorAlert(true);    
  }
}
  return (
    
      <Box
          
      sx={{
        ...style
      }}
    >
          <CssBaseline />
            <Avatar sx={{ m: 1, bgcolor: 'secondary.main' }}>
              <LockOutlinedIcon />
            </Avatar>
            <Typography component="h1" variant="h5">
              Iniciar Sesión
            </Typography>
            <Box component="form" noValidate sx={{ mt: 1 }}>
              <TextField
                margin="normal"
                required
                fullWidth
                id="email"
                label="Correo Electrónico"
                name="email"
                autoComplete="email"
                autoFocus
                value={user}
                onChange={(e)=>setUser(e.target.value)}
              />
              <TextField
                margin="normal"
                required
                fullWidth
                name="password"
                label="Contraseña"
                type="password"
                id="password"
                autoComplete="current-password"
                value={pass}
                onChange={(e)=>setPass(e.target.value)}
              />
              <FormControlLabel
                control={<Checkbox value="remember" color="primary" />}
                label="Recordarme"
              />
              <Button
                type="submit"
                fullWidth
                variant="contained"
                sx={{ mt: 3, mb: 2 }}
                onClick ={handleSignIn}
              >
                Iniciar Sesión
              </Button>
              <Grid container>
                <Grid item xs>
                  <Link href="#" variant="body2">
                    Olvidó su contraseña?
                  </Link>
                </Grid>                
              </Grid>
            </Box>
            <Snackbar open={successAlert} autoHideDuration={3000} onClose={handleClose} sx={{ width: '100%' }}>
              <Alert onClose={handleClose} severity="success" variant='filled' sx={{ width: '100%' }}>
                {success}
              </Alert>
            </Snackbar>
            <Snackbar open={errorAlert} autoHideDuration={3000} onClose={handleClose} sx={{ width: '100%' }}>
              <Alert onClose={handleClose} severity="error" variant='filled' sx={{ width: '100%' }}>
                {error}
              </Alert>
            </Snackbar>
          </Box>
    );
  }

export default SignIn;