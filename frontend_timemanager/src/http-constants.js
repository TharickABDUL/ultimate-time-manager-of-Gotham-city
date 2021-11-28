import axios from 'axios'

let baseURL = 'http://' + window.location.hostname + ':4000/api'

export const API = axios.create(
    {
        baseURL: baseURL
    })
