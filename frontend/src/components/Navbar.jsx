import React from "react";
import { AppBar, Toolbar, styled, Typography, Box, InputBase, Badge, Drawer, IconButton, Stack, Divider, Button, ButtonBase, List, ListItem, ListItemButton, Modal, Container } from "@mui/material";
import NotificationsIcon from '@mui/icons-material/Notifications';
import MenuIcon from '@mui/icons-material/Menu';
import Sidebar from "./Sidebar";
import ChevronLeftIcon from '@mui/icons-material/ChevronLeft';
import ChevronRightIcon from '@mui/icons-material/ChevronRight';
import { useState, useEffect } from "react";
import { useTheme } from '@mui/material/styles';
import SignIn from "./SignIn";
import Register from "./Register";
import { useAppContext } from "../AppContext";


const Navbar = () => {
const {usuarioConectado,cambiarUsuario,showSidebar,handleSidebar} = useAppContext();

const Search = styled("div")(({ theme }) => ({
  backgroundColor: "white",
  padding: "0 10px",
  borderRadius: theme.shape.borderRadius
}))

const DrawerHeader = styled('div')(({ theme }) => ({
  display: 'flex',
  alignItems: 'center',
  justifyContent: 'flex-end',
  padding: theme.spacing(0, 1),
  // necessary for content to be below app bar
  ...theme.mixins.toolbar,
}));

const [drawerWidth,setDrawerWidth] = useState(9);

const CustomAppBar = styled(AppBar, {
  shouldForwardProp: (prop) => prop !== 'open',
})(({ theme, open }) => ({
  transition: theme.transitions.create(['margin', 'width'], {
    easing: theme.transitions.easing.sharp,
    duration: theme.transitions.duration.leavingScreen,
  }),
  ...(open && {
    width: `calc(100% - ${drawerWidth}%)`,
    marginLeft: `${drawerWidth}%`,
    transition: theme.transitions.create(['margin', 'width'], {
      easing: theme.transitions.easing.easeOut,
      duration: theme.transitions.duration.enteringScreen,
    }),
  }),
}));

  const theme = useTheme();
  const [open, setOpen] = useState(showSidebar);
  const [openSignIn, setSignIn] = useState(false);
  const [openRegister, setRegister] = useState(false);

  const toggleDrawerOpen = () => {
      setOpen(true);      
      handleSidebar(); 
  };
  const toggleDrawerClose = () => {   
      setOpen(false);
      handleSidebar();
  };

  useEffect(() => {
    setOpen(true);
    setSignIn(false);
    setRegister(false);
  }, []);

  useEffect(() => {
    if (showSidebar) {
      setDrawerWidth(9);
    }
    else {
      setDrawerWidth(0);
    }
  }, [showSidebar]);

  const openSingInModal = () => {
    setSignIn(true);
  };

  const closeSingInModal = () => {
    setSignIn(false);
  };

  const openRegisterModal = () => {
    setRegister(true);
  };

  const closeRegisterModal = () => {
    setRegister(false);
  };

  return (
    <Box sx={{  alignItems: "center" }}>
      <CustomAppBar id="appbar" position="fixed" open={open} sx = {{minHeight:'5%'}}>
        <Toolbar id="toolbar" display="flex">
          <IconButton
            color="inherit"
            aria-label="open drawer"
            edge="start"
            onClick={toggleDrawerOpen}
            sx={{
              marginRight: 5,
              ...(showSidebar && { display: 'none' }),
            }}
          >
          <MenuIcon />
          </IconButton>
          <Typography variant="h6" sx={{ flexGrow: 1 }} >Dashboard</Typography>

          {/* <Search sx={{ display: { xs: "none", sm: "block" } }} ><InputBase placeholder="search..." /></Search> */}

          <Box width="15%" sx={{ display: 'flex', marginLeft: "10px", alignItems: 'center' }}>
            
            {/* <ListItem sx={{ flexGrow: 1 }}>
              <Badge badgeContent={1} color="error">
                <NotificationsIcon />
              </Badge>

            </ListItem> */}
            <ListItemButton variant="contained" sx={{ flexGrow: 4 }} onClick={openSingInModal}>
              <Typography variant="h7">Iniciar Sesión</Typography>
            </ListItemButton>            
            <Modal open={openSignIn} onClose={closeSingInModal}>
                <Container><SignIn></SignIn></Container>
              </Modal>
{/*             
            <ListItemButton variant="contained" sx={{ flexGrow: 4 }} onClick={openRegisterModal}>
              <Typography variant="h8">Registrarse</Typography>
            </ListItemButton>            
            <Modal open={openRegister} onClose={closeRegisterModal}>
                <Container><Register onCloseModal={closeRegisterModal}></Register></Container>
              </Modal> */}
          </Box>
        </Toolbar>
      </CustomAppBar>      
    </Box>

  )
}
export default Navbar;

