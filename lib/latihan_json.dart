import 'dart:convert';

void main() {
  // Data transkrip mahasiswa dalam bentuk JSON
  String jsonTranskrip = '''
    {
      "mahasiswa": {
        "nama": "Najoan Rizki Pradana",
        "nim": "22082010056",
        "program_studi": "Sistem Informasi",
        "mata_kuliah": [
          {
            "kode": "SI231126",
            "nama": "Pemrograman Mobile",
            "sks": 3,
            "nilai": "A"
          },
          {
            "kode": "SI231121",
            "nama": "Pemrograman Web",
            "sks": 3,
            "nilai": "A"
          },
          {
            "kode": "SI231129",
            "nama": "E-Business",
            "sks": 3,
            "nilai": "A"
          },
          {
            "kode": "SI231128",
            "nama": "Manajemen Proyek",
            "sks": 3,
            "nilai": "A"
          }
        ]
      }
    }
  ''';

  // Decode JSON menjadi Map
  Map<String, dynamic> transkripMap = jsonDecode(jsonTranskrip);

  // Mendapatkan data mahasiswa
  Map<String, dynamic> mahasiswa = transkripMap['mahasiswa'];
  String nama = mahasiswa['nama'];
  String nim = mahasiswa['nim'];
  String programStudi = mahasiswa['program_studi'];

  // Cetak informasi mahasiswa
  print("Nama: $nama");
  print("NIM: $nim");
  print("Program Studi: $programStudi");
  print("Daftar Mata Kuliah:");

  // Cetak satu per satu mata kuliah beserta detailnya
  List<dynamic> mataKuliah = mahasiswa['mata_kuliah'];
  for (var mataKuliahData in mataKuliah) {
    String kode = mataKuliahData['kode'];
    String namaMataKuliah = mataKuliahData['nama'];
    int sks = mataKuliahData['sks'];
    String nilai = mataKuliahData['nilai'];

    print("Kode: $kode, Mata Kuliah: $namaMataKuliah, SKS: $sks, Nilai: $nilai");
  }
}
