import http from "./api.service";

export default class TeamService {
    get(teamID) {
        return http.get('/teams/'+teamID)
    }
    delete(teamID,userID) {
        return http.delete('/team/'+teamID+'/'+userID)
    }
}