use std::path::PathBuf;
use walkdir::WalkDir;

static PLATFORM_PREFIX: &str = "hoguera/platform";
static GEN_RUST_DIR: &str = "gen/rust";

static SUBMODULE_DIR: &str = "third_party";

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let googleapis_dir: String = format!("{}/googleapis", SUBMODULE_DIR);
    let protobuf_dir: String = format!("{}/protobuf/src", SUBMODULE_DIR);
    let protoc_gen_validate_dir: String = format!("{}/protoc-gen-validate", SUBMODULE_DIR);
    let gnostic_dir: String = format!("{}/gnostic/openapiv3", SUBMODULE_DIR);

    if PathBuf::from(GEN_RUST_DIR).exists() {
        std::fs::remove_dir_all(GEN_RUST_DIR)?;
    }
    std::fs::create_dir_all(GEN_RUST_DIR)?;

    /*
    let mut protoc = prost_build::Config::new();
    protoc.out_dir(GEN_RUST_DIR);
    protoc
        .compile_protos(
            &get_proto_files(),
            &[
                ".",
                SUBMODULE_DIR,
                googleapis_dir.as_str(),
                protobuf_dir.as_str(),
                protoc_gen_validate_dir.as_str(),
                gnostic_dir.as_str(),
            ],
        )
        .unwrap_or_else(|e| panic!("protobuf compile error: {}", e));
    */

    tonic_build::configure()
        .build_server(true)
        .build_client(true)
        .build_transport(true)
        .out_dir(GEN_RUST_DIR)
        .compile(
            &get_proto_files(),
            &[
                ".",
                SUBMODULE_DIR,
                googleapis_dir.as_str(),
                protobuf_dir.as_str(),
                protoc_gen_validate_dir.as_str(),
                gnostic_dir.as_str(),
            ],
        )
        .unwrap_or_else(|e| panic!("protobuf compile error: {}", e));
    Ok(())
}

fn get_proto_files() -> Vec<PathBuf> {
    let mut proto_files = Vec::new();
    for entry in WalkDir::new(PLATFORM_PREFIX)
        .follow_links(true)
        .into_iter()
        .filter_map(|e| e.ok())
    {
        if entry.path().extension().unwrap_or_default() == "proto" {
            proto_files.push(entry.into_path());
        }
    }
    proto_files
}
