import 'dart:typed_data';

import '../tweet_nacl.dart';

var iv = Uint8List.fromList([
  0x6a,
  0x09,
  0xe6,
  0x67,
  0xf3,
  0xbc,
  0xc9,
  0x08,
  0xbb,
  0x67,
  0xae,
  0x85,
  0x84,
  0xca,
  0xa7,
  0x3b,
  0x3c,
  0x6e,
  0xf3,
  0x72,
  0xfe,
  0x94,
  0xf8,
  0x2b,
  0xa5,
  0x4f,
  0xf5,
  0x3a,
  0x5f,
  0x1d,
  0x36,
  0xf1,
  0x51,
  0x0e,
  0x52,
  0x7f,
  0xad,
  0xe6,
  0x82,
  0xd1,
  0x9b,
  0x05,
  0x68,
  0x8c,
  0x2b,
  0x3e,
  0x6c,
  0x1f,
  0x1f,
  0x83,
  0xd9,
  0xab,
  0xfb,
  0x41,
  0xbd,
  0x6b,
  0x5b,
  0xe0,
  0xcd,
  0x19,
  0x13,
  0x7e,
  0x21,
  0x79,
]);

var K = [
  u64(0x428a2f98, 0xd728ae22),
  u64(0x71374491, 0x23ef65cd),
  u64(0xb5c0fbcf, 0xec4d3b2f),
  u64(0xe9b5dba5, 0x8189dbbc),
  u64(0x3956c25b, 0xf348b538),
  u64(0x59f111f1, 0xb605d019),
  u64(0x923f82a4, 0xaf194f9b),
  u64(0xab1c5ed5, 0xda6d8118),
  u64(0xd807aa98, 0xa3030242),
  u64(0x12835b01, 0x45706fbe),
  u64(0x243185be, 0x4ee4b28c),
  u64(0x550c7dc3, 0xd5ffb4e2),
  u64(0x72be5d74, 0xf27b896f),
  u64(0x80deb1fe, 0x3b1696b1),
  u64(0x9bdc06a7, 0x25c71235),
  u64(0xc19bf174, 0xcf692694),
  u64(0xe49b69c1, 0x9ef14ad2),
  u64(0xefbe4786, 0x384f25e3),
  u64(0x0fc19dc6, 0x8b8cd5b5),
  u64(0x240ca1cc, 0x77ac9c65),
  u64(0x2de92c6f, 0x592b0275),
  u64(0x4a7484aa, 0x6ea6e483),
  u64(0x5cb0a9dc, 0xbd41fbd4),
  u64(0x76f988da, 0x831153b5),
  u64(0x983e5152, 0xee66dfab),
  u64(0xa831c66d, 0x2db43210),
  u64(0xb00327c8, 0x98fb213f),
  u64(0xbf597fc7, 0xbeef0ee4),
  u64(0xc6e00bf3, 0x3da88fc2),
  u64(0xd5a79147, 0x930aa725),
  u64(0x06ca6351, 0xe003826f),
  u64(0x14292967, 0x0a0e6e70),
  u64(0x27b70a85, 0x46d22ffc),
  u64(0x2e1b2138, 0x5c26c926),
  u64(0x4d2c6dfc, 0x5ac42aed),
  u64(0x53380d13, 0x9d95b3df),
  u64(0x650a7354, 0x8baf63de),
  u64(0x766a0abb, 0x3c77b2a8),
  u64(0x81c2c92e, 0x47edaee6),
  u64(0x92722c85, 0x1482353b),
  u64(0xa2bfe8a1, 0x4cf10364),
  u64(0xa81a664b, 0xbc423001),
  u64(0xc24b8b70, 0xd0f89791),
  u64(0xc76c51a3, 0x0654be30),
  u64(0xd192e819, 0xd6ef5218),
  u64(0xd6990624, 0x5565a910),
  u64(0xf40e3585, 0x5771202a),
  u64(0x106aa070, 0x32bbd1b8),
  u64(0x19a4c116, 0xb8d2d0c8),
  u64(0x1e376c08, 0x5141ab53),
  u64(0x2748774c, 0xdf8eeb99),
  u64(0x34b0bcb5, 0xe19b48a8),
  u64(0x391c0cb3, 0xc5c95a63),
  u64(0x4ed8aa4a, 0xe3418acb),
  u64(0x5b9cca4f, 0x7763e373),
  u64(0x682e6ff3, 0xd6b2b8a3),
  u64(0x748f82ee, 0x5defb2fc),
  u64(0x78a5636f, 0x43172f60),
  u64(0x84c87814, 0xa1f0ab72),
  u64(0x8cc70208, 0x1a6439ec),
  u64(0x90befffa, 0x23631e28),
  u64(0xa4506ceb, 0xde82bde9),
  u64(0xbef9a3f7, 0xb2c67915),
  u64(0xc67178f2, 0xe372532b),
  u64(0xca273ece, 0xea26619c),
  u64(0xd186b8c7, 0x21c0c207),
  u64(0xeada7dd6, 0xcde0eb1e),
  u64(0xf57d4f7f, 0xee6ed178),
  u64(0x06f067aa, 0x72176fba),
  u64(0x0a637dc5, 0xa2c898a6),
  u64(0x113f9804, 0xbef90dae),
  u64(0x1b710b35, 0x131c471b),
  u64(0x28db77f5, 0x23047d84),
  u64(0x32caab7b, 0x40c72493),
  u64(0x3c9ebe0a, 0x15c9bebc),
  u64(0x431d67c4, 0x9c100d4c),
  u64(0x4cc5d4be, 0xcb3e42b6),
  u64(0x597f299c, 0xfc657e2a),
  u64(0x5fcb6fab, 0x3ad6faec),
  u64(0x6c44198c, 0x4a475817),
];

var X = gf([
  0xd51a,
  0x8f25,
  0x2d60,
  0xc956,
  0xa7b2,
  0x9525,
  0xc760,
  0x692c,
  0xdc5c,
  0xfdd6,
  0xe231,
  0xc0a4,
  0x53fe,
  0xcd6e,
  0x36d3,
  0x2169,
]);

var Y = gf([
  0x6658,
  0x6666,
  0x6666,
  0x6666,
  0x6666,
  0x6666,
  0x6666,
  0x6666,
  0x6666,
  0x6666,
  0x6666,
  0x6666,
  0x6666,
  0x6666,
  0x6666,
  0x6666,
]);

var gf1 = gf([1]);

var gf0 = gf();

var D2 = gf([
  0xf159,
  0x26b2,
  0x9b94,
  0xebd6,
  0xb156,
  0x8283,
  0x149a,
  0x00e0,
  0xd130,
  0xeef3,
  0x80f2,
  0x198e,
  0xfce7,
  0x56df,
  0xd9dc,
  0x2406,
]);
