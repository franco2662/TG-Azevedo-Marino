import React from "react";
import { AppBar, Toolbar, styled, Typography, Box, InputBase, Badge, Drawer, IconButton, Stack, Divider, Button,ButtonBase, List, ListItem, ListItemButton  } from "@mui/material";
import NotificationsIcon from '@mui/icons-material/Notifications';
import MenuIcon from '@mui/icons-material/Menu';
import Sidebar from "./Sidebar";
import ChevronLeftIcon from '@mui/icons-material/ChevronLeft';
import ChevronRightIcon from '@mui/icons-material/ChevronRight';
import { useState, useEffect } from "react";
import { useTheme } from '@mui/material/styles';
import SignIn from "./SignIn";

const openedMixin = (theme) => ({
  width: drawerWidth,
  transition: theme.transitions.create('width', {
    easing: theme.transitions.easing.sharp,
    duration: theme.transitions.duration.enteringScreen,
  }),
  overflowX: 'hidden',
});

const closedMixin = (theme) => ({
  transition: theme.transitions.create('width', {
    easing: theme.transitions.easing.sharp,
    duration: theme.transitions.duration.leavingScreen,
  }),
  overflowX: 'hidden',
  width: `calc(${theme.spacing(7)} + 1px)`,
  [theme.breakpoints.up('sm')]: {
    width: `calc(${theme.spacing(8)} + 1px)`,
  },
});

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

const drawerWidth = 200;

const CustomAppBar = styled(AppBar, {
  shouldForwardProp: (prop) => prop !== 'open',
})(({ theme, open }) => ({
  transition: theme.transitions.create(['margin', 'width'], {
    easing: theme.transitions.easing.sharp,
    duration: theme.transitions.duration.leavingScreen,
  }),
  ...(open && {
    width: `calc(100% - ${drawerWidth}px)`,
    marginLeft: `${drawerWidth}px`,
    transition: theme.transitions.create(['margin', 'width'], {
      easing: theme.transitions.easing.easeOut,
      duration: theme.transitions.duration.enteringScreen,
    }),
  }),
}));

const Navbar = () => {
  
  const theme = useTheme();
  const [open, setOpen] = useState(true);
  const [signInModal, setSignInModal] = useState(false);

  const showSignInModal = () => {
    return <SignIn/>
  }

  const toggleDrawerOpen = () => {
    setOpen(true);
    // console.log('toggleDrawerOpen');
  };
  const toggleDrawerClose = () => {
    setOpen(false);
    // console.log('toggleDrawerClose');
  };
  useEffect(() => {
    setOpen(true);
    setSignInModal(false);
    // console.log('useEffect called');
  }, [])


  return (
    <Box sx={{ display: 'flex',alignItems:"center"}}>
      <CustomAppBar id="appbar" position="fixed" open={open}>
        <Toolbar id = "toolbar" display="flex">
          <IconButton
            color="inherit"
            aria-label="open drawer"
            edge="start"
            onClick={toggleDrawerOpen}
            sx={{
              marginRight: 5,
              ...(open && { display: 'none' }),
            }}
          >
            <MenuIcon />
          </IconButton>
          <Typography variant="h6" sx={{ flexGrow: 1 }} >Dashboard</Typography>
          <Search sx={{ display: { xs: "none", sm: "block" } }} ><InputBase placeholder="search..." /></Search>
          <List width="15%" sx={{ display: 'flex', marginLeft: "10px", alignItems: 'center' }}>
            <ListItem sx={{flexGrow: 1}}>        
            <Badge badgeContent={1} color="error">
              <NotificationsIcon  />
            </Badge>
            </ListItem>
            <ListItemButton variant ="contained" sx={{flexGrow: 4 }} onClick={showSignInModal} >
                <Typography variant="h7">Iniciar Sesión</Typography>
              </ListItemButton> 
              </List>
        </Toolbar>
      </CustomAppBar>
      <Drawer variant="persistent" open={open} >
        <DrawerHeader>
          <IconButton onClick={toggleDrawerClose}>
            {theme.direction === 'rtl' ? <ChevronRightIcon /> : <ChevronLeftIcon />}
          </IconButton>
        </DrawerHeader>
        <Divider />
        <Sidebar open={open} />
      </Drawer>
    </Box>

  )
}
export default Navbar;

