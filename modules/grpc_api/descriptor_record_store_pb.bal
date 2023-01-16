import ballerina/grpc;
import ballerina/protobuf;
import ballerina/protobuf.types.empty;
import ballerina/protobuf.types.wrappers;

public const string DESCRIPTOR_RECORD_STORE_DESC = "0A1D64657363726970746F725F7265636F72645F73746F72652E70726F746F1A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F1A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F225B0A05416C62756D120E0A0269641801200128095202696412140A057469746C6518022001280952057469746C6512160A06617274697374180320012809520661727469737412140A057072696365180420012802520570726963653286010A06416C62756D7312300A08676574416C62756D121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A062E416C62756D121A0A08616464416C62756D12062E416C62756D1A062E416C62756D122E0A0A6C697374416C62756D7312162E676F6F676C652E70726F746F6275662E456D7074791A062E416C62756D3001620670726F746F33";

public isolated client class AlbumsClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, DESCRIPTOR_RECORD_STORE_DESC);
    }

    isolated remote function getAlbum(string|wrappers:ContextString req) returns Album|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Albums/getAlbum", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Album>result;
    }

    isolated remote function getAlbumContext(string|wrappers:ContextString req) returns ContextAlbum|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Albums/getAlbum", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Album>result, headers: respHeaders};
    }

    isolated remote function addAlbum(Album|ContextAlbum req) returns Album|grpc:Error {
        map<string|string[]> headers = {};
        Album message;
        if req is ContextAlbum {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Albums/addAlbum", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Album>result;
    }

    isolated remote function addAlbumContext(Album|ContextAlbum req) returns ContextAlbum|grpc:Error {
        map<string|string[]> headers = {};
        Album message;
        if req is ContextAlbum {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Albums/addAlbum", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Album>result, headers: respHeaders};
    }

    isolated remote function listAlbums() returns stream<Album, grpc:Error?>|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("Albums/listAlbums", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        AlbumStream outputStream = new AlbumStream(result);
        return new stream<Album, grpc:Error?>(outputStream);
    }

    isolated remote function listAlbumsContext() returns ContextAlbumStream|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("Albums/listAlbums", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        AlbumStream outputStream = new AlbumStream(result);
        return {content: new stream<Album, grpc:Error?>(outputStream), headers: respHeaders};
    }
}

public class AlbumStream {
    private stream<anydata, grpc:Error?> anydataStream;

    public isolated function init(stream<anydata, grpc:Error?> anydataStream) {
        self.anydataStream = anydataStream;
    }

    public isolated function next() returns record {|Album value;|}|grpc:Error? {
        var streamValue = self.anydataStream.next();
        if (streamValue is ()) {
            return streamValue;
        } else if (streamValue is grpc:Error) {
            return streamValue;
        } else {
            record {|Album value;|} nextRecord = {value: <Album>streamValue.value};
            return nextRecord;
        }
    }

    public isolated function close() returns grpc:Error? {
        return self.anydataStream.close();
    }
}

public client class AlbumsAlbumCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendAlbum(Album response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextAlbum(ContextAlbum response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public type ContextAlbumStream record {|
    stream<Album, error?> content;
    map<string|string[]> headers;
|};

public type ContextAlbum record {|
    Album content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: DESCRIPTOR_RECORD_STORE_DESC}
public type Album record {|
    string id = "";
    string title = "";
    string artist = "";
    float price = 0.0;
|};

