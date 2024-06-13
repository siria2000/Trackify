package model;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import org.bson.types.ObjectId;
import static com.mongodb.client.model.Filters.*;

import java.util.ArrayList;
import java.util.List;

public class SongService {

    private MongoCollection<Document> collection;

    public SongService() {
        MongoDatabase database = MongoDBUtil.getDatabase();
        this.collection = database.getCollection("Song");
    }

    public List<Song> getAllSongs() {
        List<Song> songs = new ArrayList<>();
        MongoCursor<Document> cursor = collection.find().iterator();
        try {
            while (cursor.hasNext()) {
                songs.add(documentToSong(cursor.next()));
            }
        } finally {
            cursor.close();
        }
        return songs;
    }

    public Song getSongById(String id) {
        Document doc = collection.find(eq("_id", new ObjectId(id))).first();
        return doc != null ? documentToSong(doc) : null;
    }

    public void addSong(Song song) {
        Document doc = songToDocument(song);
        collection.insertOne(doc);
        song.setId(doc.getObjectId("_id"));
    }

    public void updateSong(Song song) {
        Document doc = songToDocument(song);
        collection.replaceOne(eq("_id", song.getId()), doc);
    }

    public void deleteSong(String id) {
        collection.deleteOne(eq("_id", new ObjectId(id)));
    }

    private Song documentToSong(Document doc) {
        Song song = new Song();
        song.setId(doc.getObjectId("_id"));
        song.setAcousticness(doc.getDouble("acousticness"));
        song.setArtistName(doc.getString("artist_name"));
        song.setDanceability(doc.getDouble("danceability"));
        song.setEnergy(doc.getDouble("energy"));
        song.setInstrumentalness(doc.getDouble("instrumentalness"));
        song.setLiveness(doc.getDouble("liveness"));
        song.setStreams(doc.getInteger("streams"));
        song.setTrackName(doc.getString("track_name"));
        song.setValence(doc.getDouble("valence"));
        return song;
    }

    private Document songToDocument(Song song) {
        return new Document()
                .append("acousticness", song.getAcousticness())
                .append("artist_name", song.getArtistName())
                .append("danceability", song.getDanceability())
                .append("energy", song.getEnergy())
                .append("instrumentalness", song.getInstrumentalness())
                .append("liveness", song.getLiveness())
                .append("streams", song.getStreams())
                .append("track_name", song.getTrackName())
                .append("valence", song.getValence());
    }
}
