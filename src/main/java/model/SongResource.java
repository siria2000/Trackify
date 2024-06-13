package model;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.bson.types.ObjectId;

import java.util.List;

@Path("/songs")
public class SongResource {

    private SongService songService = new SongService();

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<Song> getAllSongs() {
        return songService.getAllSongs();
    }

    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getSongById(@PathParam("id") String id) {
        Song song = songService.getSongById(id);
        if (song != null) {
            return Response.ok(song).build();
        } else {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response addSong(Song song) {
        songService.addSong(song);
        return Response.status(Response.Status.CREATED).entity(song).build();
    }

    @PUT
    @Path("/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response updateSong(@PathParam("id") String id, Song song) {
        song.setId(new ObjectId(id));
        songService.updateSong(song);
        return Response.ok(song).build();
    }

    @DELETE
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response deleteSong(@PathParam("id") String id) {
        songService.deleteSong(id);
        return Response.noContent().build();
    }
}
