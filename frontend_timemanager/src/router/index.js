import { createRouter, createWebHistory } from 'vue-router'
import User from "@/components/User";
import LandingPage from "@/components/VisualComponent/LandingPage";
import ClockManager from "@/components/ClockManager";
import WorkingTime from "@/components/WorkingTime";
import ManageTeam from "@/components/ManageTeam";
import WorkingTimes from "@/components/WorkingTimes";
import ChartManager from "@/components/ChartManager";
import Login from "@/components/Login";
import Register from "@/components/Register";
import About from "@/components/VisualComponent/About";
import Error from "@/components/VisualComponent/Error";


const routes = [
    {
        path: '/',
        name: 'Home',
        component: LandingPage
    },
    {
        path: '/team',
        name: 'Team',
        component: ManageTeam
    },
    {
        path: '/about',
        name: 'About',
        component: About
    },
    {
        path: '/user/login',
        name: 'Login',
        component: Login
    },
    {
        path: '/user/register',
        name: 'Register',
        component: Register
    },
    {
        path: '/user/profil',
        name: 'Profil',
        component: User
    },        
    {
        path: '/clock',
        name: 'Clock',
        component: ClockManager
    },
    {
        path: '/workingTime',
        name: 'WorkingTime',
        component: WorkingTime
    },
    {
        path: '/workingTimes',
        name: 'WorkingTimes',
        component: WorkingTimes
    },
    {
        path: '/chart',
        name: 'Chart',
        component: ChartManager
    },
    {
        path: '/:pathMatch(.*)*',
        name: 'Error',
        component: Error
    }

];


const router =  createRouter({
    mode: 'history',
    history: createWebHistory(),
    routes
});

router.beforeEach((to, from, next) => {
    if((to.name == 'Login' || to.name == 'Register') && localStorage.getItem('jwt') != null){
        next ('/user/profil')
    }
    else{
        if(to.name !== 'About' && to.name !== 'Login' && to.name !== 'Register' && localStorage.getItem('jwt') == null) next('/user/login')
        else next()
    }
})

export default router