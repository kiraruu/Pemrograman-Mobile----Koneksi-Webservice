import 'dart:convert';
// import 'dart:math';

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
            "nilai": "B+"
          },
          {
            "kode": "SI231129",
            "nama": "E-Business",
            "sks": 3,
            "nilai": "A-"
          },
          {
            "kode": "SI231128",
            "nama": "Manajemen Proyek",
            "sks": 3,
            "nilai": "B-"
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

  // Membuat transkrip dengan nilai mata kuliah yang sudah ditentukan
  Transkrip transkrip = Transkrip.fromJson(mahasiswa);

  // Cetak informasi mahasiswa
  print("Nama: $nama");
  print("NIM: $nim");
  print("Program Studi: $programStudi");
  print("Daftar Mata Kuliah:");

  // Cetak satu per satu mata kuliah beserta detailnya
  for (var mataKuliah in transkrip.mataKuliah) {
    print(
        "Kode: ${mataKuliah.kode}, Mata Kuliah: ${mataKuliah.nama}, SKS: ${mataKuliah.sks}, Nilai: ${mataKuliah.nilai}");
  }

  // Hitung IPK
  double ipk = hitungIPK(transkrip);

  // Cetak IPK
  print("IPK: ${ipk.toStringAsFixed(2)}");
}

class MataKuliah {
  String kode;
  String nama;
  int sks;
  String nilai;

  MataKuliah(this.kode, this.nama, this.sks, this.nilai);

  factory MataKuliah.fromJson(Map<String, dynamic> json) {
    return MataKuliah(
      json['kode'],
      json['nama'],
      json['sks'],
      json['nilai'],
    );
  }
}

class Transkrip {
  String nama;
  String nim;
  String programStudi;
  List<MataKuliah> mataKuliah;

  Transkrip(this.nama, this.nim, this.programStudi, this.mataKuliah);

  factory Transkrip.fromJson(Map<String, dynamic> json) {
    List<MataKuliah> mataKuliahList = [];
    for (var mataKuliahData in json['mata_kuliah']) {
      MataKuliah mataKuliah = MataKuliah.fromJson(mataKuliahData);
      mataKuliahList.add(mataKuliah);
    }
    return Transkrip(
      json['nama'],
      json['nim'],
      json['program_studi'],
      mataKuliahList,
    );
  }
}

double hitungIPK(Transkrip transkrip) {
  double totalSKS = 0;
  double totalBobot = 0;

  for (var mataKuliah in transkrip.mataKuliah) {
    double bobot = 0;
    switch (mataKuliah.nilai) {
      case "A":
        bobot = 4;
        break;
      case "A-":
        bobot = 3.7;
        break;
      case "B+":
        bobot = 3.3;
        break;
      case "B":
        bobot = 3;
        break;
      case "B-":
        bobot = 2.7;
        break;
      case "C+":
        bobot = 2.3;
        break;
      case "C":
        bobot = 2;
        break;
      case "C-":
        bobot = 1.7;
        break;
      case "D":
        bobot = 1;
        break;
      case "E":
        bobot = 0;
        break;
      // Tambahkan case untuk nilai lainnya
    }
    totalSKS += mataKuliah.sks;
    totalBobot += bobot * mataKuliah.sks;
  }

  return totalBobot / totalSKS;
}
