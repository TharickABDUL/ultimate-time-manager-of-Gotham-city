import http from "./api.service";

export default class ClockService {
    get(userID) {
        return http.get('/clocks/' + userID)
    }
    clock(userID,body){
        return http.post('/clocks/'+userID,body)
    }
}